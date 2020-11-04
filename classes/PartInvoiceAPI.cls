global with sharing class PartInvoiceAPI {

	global static Parts_Invoice__c invoice(Id invoiceId) {
		DescribeSObjectResult describeRO = dealer__Parts_Invoice__c.getSObjectType().getDescribe();
        List<String> inv_fieldNames = new List<String>( describeRO.fields.getMap().keySet() );	
        return Database.query('SELECT '+String.join( inv_fieldNames, ',' )+' FROM dealer__Parts_Invoice__c WHERE Id = \''+String.escapeSingleQuotes(invoiceId) +'\' limit 1 ');	
	}

	global static Parts_Invoice__c createInvoice(Parts_Invoice__c ivs) {
		try {
			insert ivs;
		} Catch(Exception e) {
			throw new PartInvoiceAPIException(e.getMessage());
		}
		return ivs;
	}

	/**
	*	
	*/
	global static Parts_Invoice_Line__c addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment) {
		
		StockOrderAPI soAPI = new StockOrderAPI();
		
		if(invoiceId==null) { throw new PartInvoiceAPIException('Required parameter invoiceId is null;'); }
		if(partId==null) { throw new PartInvoiceAPIException('Required parameter partId is null;'); }
		if(quantity==null) { throw new PartInvoiceAPIException('Required quantity partId is null;'); }

		SavePoint sp = Database.setSavePoint();

		// Get information from the existing invoice
		dealer__Parts_Invoice__c invoice = [Select Id, Name, dealer__Line_Count__c, dealer__Location__c, dealer__Service_Repair_Order__c FROM dealer__Parts_Invoice__c where Id=:invoiceId limit 1];

		// Get information from the eixsting part that is being sold
		dealer__Parts_Inventory__c part = [Select Id, Name, dealer__Bin__c, dealer__List__c, dealer__Core__c, dealer__Description__c, dealer__Cost__c,
													dealer__Part_No__c, dealer__Source__c, dealer__On_Hand__c
												FROM dealer__Parts_Inventory__c 
												WHERE Id=:partId];

		// Reduce the QTY On Hand by the QTY Sold
		part.On_Hand__c	=  (part.On_Hand__c!=null) ? part.On_Hand__c-Quantity : ( 0 - Quantity);											

		// Allow for Sale Price to be Null, sell at default.
		if(salePrice==null) { salePrice=part.List__c; } 

		// Update Line Count based on invoice line items
		Decimal lineCount = invoice.Line_Count__c;
		lineCount++;

		// Create the invoice line
 		Parts_Invoice_Line__c pi = new Parts_Invoice_Line__c();  
 		pi.Parts_Invoice__c = invoice.Id; 
	    pi.Name = invoice.Name+'-'+lineCount.setScale(0);
	    pi.Part__c    = part.Id;
	    pi.List__c    = part.List__c;
	    pi.Price__c   = salePrice;
		pi.Core__c    = (part.Core__c!=null)?part.Core__c:0;
	    pi.Cost__c    = null; // Ledger Entry
	    pi.Bin__c     = part.Bin__c;
	    pi.Counterman__c  = UserInfo.getUserId();
	    pi.Sale_Date__c   = System.now();
	    pi.Part_Number__c = part.Part_No__c;
	    pi.Part_Description__c 	= 	part.Description__c;
	    pi.Quantity_Sold__c 	=	quantity;
	    pi.Source__c 			= 	part.Source__c;
	    pi.Sold_Via__c 			= 	'Invoice Line'; 
	    pi.Comment__c 			= 	comment;
	    pi.Job_Line__c 			= 	jobLineId;
	    pi.Service_Repair_Order__c = invoice.Service_Repair_Order__c;

		// Get the Ledger records
		PartInvoiceAPI invoiceApi = new PartInvoiceAPI(); //Used to access a private non-static method (Internal Use Only)

		List<dealer__Parts_Ledger__c> ledgerEntries = invoiceApi.ledger(part.Id, invoice.Id, quantity);

		Decimal ledger_cost = 0;
		for(dealer__Parts_Ledger__c l : ledgerEntries) {
			ledger_cost += l.dealer__Item_Value__c;
		}

		if(ledger_cost!=0) {
			pi.dealer__Cost__c=ledger_cost;
		} else {
			// Throw Error
			Database.rollback(sp);
			throw new PartInvoiceAPIException('Error generating Ledger for Parts Sale');
		}	    

	    try {
			
			update part;
	    	insert pi;

			//Process Stock Order Logic
			soAPI.processStockOrder(pi);

	    	// Update the Ledger Lines with the Parts Invoice Line Id
	    	List<dealer__Parts_Ledger__c> ledgerLines = new List<dealer__Parts_Ledger__c>();
	    	for(dealer__Parts_Ledger__c ledger : ledgerEntries) {
	    		ledgerLines.add(new dealer__Parts_Ledger__c(Id=ledger.Id, dealer__Parts_Sale_Line__c=pi.Id));
	    	}

			PartAPI.subLedgerDML(ledgerLines, 'UPDATE');

	    	return pi;

	    } Catch(DmlException e) {
	    	// Throw Error
	    	Database.rollback(sp);

			String errorString = 'Error saving Parts Invoice Line: Message "';
			for (Integer i = 0; i < e.getNumDml(); i++) {
				// Process exception here
				errorString += e.getDmlMessage(i); 
			}
			errorString += '"';
			
	    	throw new PartInvoiceAPIException(errorString);

	    } Catch(Exception e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException(e.getMessage());
		}


		return null;
	}

	global static List<Parts_Invoice_Line__c> addInvoiceLines(List<Parts_Invoice_Line__c> lines) {

		// Map of Parts for data integrity
		Set<Id> partsIds = new Set<Id>();
		for(Parts_Invoice_Line__c pil : lines) {
			if(!partsIds.contains(pil.Part__c)) { 
				partsIds.add(pil.Part__c);
			}
		}
		Map<Id, Parts_Inventory__c> partsById = new Map<Id, Parts_Inventory__c>([SELECT Id, Name, Description__c, Bin__c, List__c, Core__c,
																						Part_No__c,Source__c, On_Order__c, On_Hand__c,
																						Cost__c 
																					FROM Parts_Inventory__c 
																					WHERE Id IN:partsIds]);
		
		// Static instance of headerAPI
		PartInvoiceAPI invoiceApi = new PartInvoiceAPI();

		// Container for created lines
		List<Parts_Invoice_Line__c> linesToCreate = new List<Parts_Invoice_Line__c>();
		Integer lineNumber = 1;
		for(Parts_Invoice_Line__c il : lines) {

			// preflight validation
			if(il.Parts_Invoice__c==null) { throw new PartInvoiceAPIException('Parts_Invoice_Line__c.Parts_Invoice__c is null;'); }
			if(il.Part__c==null) { throw new PartInvoiceAPIException('Parts_Invoice_Line__c.Part__c is null;'); }
			if(il.Quantity_Sold__c==null) { throw new PartInvoiceAPIException('Parts_Invoice_Line__c.Quantity_Sold__c is null;'); }			

			// Defaults
			if(il.Sale_Date__c==null) {	il.Sale_Date__c=Date.today(); }
			if(il.Counterman__c==null) { il.Counterman__c=UserInfo.getUserId(); }
			if(il.Sold_Via__c==null) { il.Sold_Via__c='Invoice Line'; }	
			il.Part_Number__c = partsById.get(il.Part__c).Part_No__c;
			il.Part_Description__c = partsById.get(il.Part__c).Description__c;
			il.List__c = partsById.get(il.Part__c).List__c;
			il.Source__c = partsById.get(il.Part__c).Source__c;
			il.Bin__c = partsById.get(il.Part__c).Bin__c;
			il.Core__c = partsById.get(il.Part__c).Core__c;
			il.Cost__c = (partsById.get(il.Part__c) != null && partsById.get(il.Part__c).Cost__c != null) ? partsById.get(il.Part__c).Cost__c : 0;
			il.Quantity_Ordered__c = (il.Quantity_Sold__c > partsById.get(il.Part__c).On_Hand__c) ? il.Quantity_Sold__c - partsById.get(il.Part__c).On_Hand__c : 0;
			
			// Inventory Reduction Placed in Map
			Parts_Inventory__c p = partsById.get(il.Part__c);
			p.On_Hand__c -= il.Quantity_Sold__c;
			p.On_Order__c = (p.On_Order__c==null) ? 0 : p.On_Order__c;
			p.On_Order__c = (p.On_Hand__c <= 0) ? p.On_Order__c += il.Quantity_Sold__c : 0;
			partsById.put(il.Part__c, p);

			linesToCreate.add(il);
			lineNumber++;
		}

		// Prepare DML - transaction control crucial as Inventory/Ledger must be balanced
		SavePoint sp = Database.setSavePoint();

		// ) Create Invoice Lines
		try {
			insert linesToCreate;
		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException(e.getMessage());
		}

		//2) Process Stock Order Logic
		StockOrderAPI soAPI = new StockOrderAPI();
		soAPI.processStockOrders(linesToCreate);

		// 3) Create Ledger Lines
		List<Parts_Ledger__c> ledgerUpdate = new List<Parts_Ledger__c>();
		List<Parts_Invoice_Line__c> lineUpdate = new List<Parts_Invoice_Line__c>();	

		// 3.a) Obtain Ledger Lines and FIFO Valuations, future update will address LIFO C/A
		Map<Id, List<Parts_Ledger__c>> valuationTable = PartInvoiceAPI.bulkLedger(linesToCreate);

		for(Parts_Invoice_Line__c pil : linesToCreate) {
			System.assert(valuationTable.get(pil.Part__c)!=null, 'Ledger Table inconsistant for Part Id '+pil.Part__c);
		}

		for(Parts_Invoice_Line__c pil : linesToCreate) {
			
			// Prepare the Ledger Lines
			Decimal ledger_cost = 0;
			for(Parts_Ledger__c  l : valuationTable.get(pil.Part__c)) {
				ledger_cost += l.Item_Value__c;
				l.Parts_Sale_Line__c=pil.Id;
				ledgerUpdate.add(l);
			}			

			if(ledger_cost==0) {
				Database.rollback(sp);
				throw new PartInvoiceAPIException('LIFO/FIFO Costs is 0');
			}
			
			pil.Cost__c=ledger_cost;
			lineUpdate.add(pil);
		}

		// 4) Fire DML
		System.debug(Limits.getQueries());

		try {
			update lineUpdate; // Set updated Cost based on Ledger
			
			PartAPI.subLedgerDML(ledgerUpdate, 'UPDATE');

			update partsById.values(); // Set QTY / ORDER fields
		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException(e.getMessage());
		}

		// Return home
		return lineUpdate;
		return linesToCreate;
	}

	/**
	 * 	removeInvoiceLine - Removes an invoice line from the parts invoice, resets inventory and re-assigns stock.
	 *	@param Id of the invoice line requesting removal
	 */
	global static Boolean removeInvoiceLine(Id invoiceLineId) {
		if(invoiceLineId==null) {
			return false;
		}
		return PartInvoiceAPI.removeInvoiceLine(new List<Parts_Invoice_Line__c>{ new Parts_Invoice_Line__c(Id=invoiceLineId) });
	}
	
	/** 
	 * removeInvoiceLine - removes an invoice line or many by list of invoice lines
	 * @param List of Parts Invoice Lines
	 */
	global static Boolean removeInvoiceLine(List<Parts_Invoice_Line__c> partInvoiceLines) {
	
		// 1. reset ledger lines
		// 2. adjust part inventory back to stock
		// 3. remove invoice line
		SavePoint sp = Database.setSavePoint();

       	Set<Id> partLineId = new Set<Id>();
       	//Part Id, Part Invoice Line
        Map<Id, dealer__Parts_Invoice_Line__c> partLineMap = new Map<Id, dealer__Parts_Invoice_Line__c>();
		for(dealer__Parts_Invoice_Line__c pil: partInvoiceLines){
			partLineId.add(pil.Id);
		}
        for(dealer__Parts_Invoice_Line__c pil: [SELECT Id, Name, dealer__Part__c, dealer__Quantity_Sold__c, dealer__Parts_Invoice__r.Name FROM dealer__Parts_Invoice_Line__c WHERE Id IN:partLineId]){

            if(!partLineMap.containsKey(pil.dealer__Part__c)){
                partLineMap.put(pil.dealer__Part__c, pil);
            }
        }
        
        // Get the Part Record
		Map<Id,Parts_Inventory__c> partInventoryMap = new Map<Id,Parts_Inventory__c>();
        for(Parts_Inventory__c inventory : [Select Id, Name, On_Hand__c 
                                            from Parts_Inventory__c where Id IN:partLineMap.keySet() limit 1000]){
            partInventoryMap.put(inventory.Id, inventory);
        }

        //Part Id, Parts Ledger list
        Map<Id, List<Parts_Ledger__c>> partMap = new Map<Id, List<Parts_Ledger__c>>();

		// Get the Ledger Record
		for(Parts_Ledger__c pl : [Select Id, Quantity__c, Purchase_Order__r.Name, Transaction_Note__c, Part__c, Parts_Sale_Line__c, Parts_Sale_Line__r.Parts_Invoice__r.Name
                                           from Parts_Ledger__c where Parts_Sale_Line__c IN : partLineId]){
            // Process list into map
			List<Parts_Ledger__c> pll = (partMap.get(pl.Parts_Sale_Line__c)!=null) ? partMap.get(pl.Parts_Sale_Line__c) : new List<Parts_Ledger__c>();
			pll.add(pl);
			partMap.put(pl.Parts_Sale_Line__c, pll);
       	}

		List<Parts_Ledger__c> updateLedger = new List<Parts_Ledger__c>();
		List<Parts_Ledger__c> deleteLedger = new List<Parts_Ledger__c>();
        
        for(dealer__Parts_Invoice_Line__c pil: partInvoiceLines){
            if(partMap.get(pil.Id) != null){
				List<Parts_Ledger__c> ledgerLines = partMap.get(pil.Id);
				for(Parts_Ledger__c ll : ledgerLines) {

					// Two scenarios, first sale from stock, or filled sale line, second sold negative
					if(ll.Quantity__c==-1) {
						deleteLedger.add(ll);
					} else {
						ll.Parts_Sale_Line__c=null;
						ll.Quantity__c=1;
		
						/* Specify the transaction note, record removal from invoice */
						if(ll.Transaction_Note__c==null) { ll.Transaction_Note__c=''; }
						ll.Transaction_Note__c=(ll.Transaction_Note__c.right(1)!=';') ? ll.Transaction_Note__c + ';Removed from ' + ll.Parts_Sale_Line__r.Parts_Invoice__r.Name +';' : ll.Transaction_Note__c + 'Removed from ' + ll.Parts_Sale_Line__r.Parts_Invoice__r.Name +';';
						ll.Transaction_Note__c=ll.Transaction_Note__c.left(255);
		
						updateLedger.add(ll);
					}
				}
			}
        }        
		
		// Step 1
		try {
      
			if(!updateLedger.isEmpty())
				// update updateLedger;
				PartAPI.subLedgerDML(updateLedger, 'UPDATE');
			if(!deleteLedger.isEmpty())
				//delete deleteLedger;
				PartAPI.subLedgerDML(deleteLedger, 'DELETE');

		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException('Failed to update the ledger entries. ' + e.getMessage());
		} 

		// Step 2
        List<dealer__Part_Inventory_History__c> partInvHistory = new List<dealer__Part_Inventory_History__c>();
        for(Parts_Inventory__c inv : partInventoryMap.values()){
                
            Decimal onHandAfter = (inv.On_Hand__c + partLineMap.get(inv.id).Quantity_Sold__c);
            inv.On_Hand__c = onHandAfter;
                
            // Update History
            dealer__Part_Inventory_History__c invHistory = new dealer__Part_Inventory_History__c(
                dealer__Quantity_Adjustment__c=(partLineMap.get(inv.id).Quantity_Sold__c * -1), 
                dealer__Part__c=inv.Id,
                dealer__Parts_Invoice__c=partLineMap.get(inv.id).Parts_Invoice__c,
                dealer__Transaction_Event__c='Removed part from '+partLineMap.get(inv.id).Parts_Invoice__r.Name
            );
                
            partInvHistory.add(invHistory);
        }
        
        try {

            update partInventoryMap.values();
            insert partInvHistory;
            
		} Catch(DmlException e) {
			Database.rollback(sp); 
			throw new PartInvoiceAPIException('Failed to return part(s) to inventory. ' + e.getMessage());
		} Catch(Exception e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException('Failed to return part(s) to inventory. ' + e.getMessage());			
		}

		// Step 3
		try {
			delete partInvoiceLines;
		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException('Failed to remove invoice lines. ' + e.getMessage());			
		}

		return true;

	}

	global static Parts_Invoice_Line__c updateInvoiceLine(Id lineId, Decimal quantity, Decimal salePrice, String comment) {
        
        Boolean isSubLedgerEnabled = Utility.isDMSFeatureEnabled('PartSubLedger');

		Parts_Invoice_Line__c line = new Parts_Invoice_Line__c();
		Parts_Inventory__c inv = new Parts_Inventory__c();

		StockOrderAPI soAPI = new StockOrderAPI();
		PartInvoiceAPI invoiceAPI = new PartInvoiceAPI();

		// SavePoint 
		SavePoint sp = Database.setSavePoint();

		// Selector
		try {
			line = [SELECT Parts_Invoice__c, Bin__c, Core__c, Cost__c, Counterman_No__c, Counterman__c, Currently_Available__c, Drop_Ship__c, 
												Extended_Price__c, Gross_Margin__c, Job_Line__c, List__c, MFG__c, Net_Price__c, 
												Net__c, Order_Type__c, Part_Description__c, 
												Part_Number__c, Part__c, Pay_Type__c, Price_Level_Strategy__c, Price_Level__c, 
												Price__c, Quantity_Ordered__c, Quantity_Sold__c, 
												Sale_Date__c, Service_Job_Line_Number__c, Service_Line_Payment_Method__c, 
												Service_Repair_Order__c, Sold_Via__c, Source__c, 
												Stocking_Group__c, Total_Price__c, Total_Tax__c, Transaction_Code__c, 
												Part_Master_Record__c, Currently_On_Order__c, Negative_QTY__c, Name, Id,
												Comment__c, Parts_Invoice__r.Name
											FROM Parts_Invoice_Line__c 
											WHERE Id=:lineId 
											LIMIT 1 
											FOR UPDATE];

			inv = [SELECT Id, Name, On_Hand__c, On_Order__c, Cost__c 
										FROM Parts_Inventory__c 
										WHERE Id=:line.Part__c 
										LIMIT 1 
										FOR UPDATE];
		} Catch(QueryException e) {
			throw new PartInvoiceAPIException(e.getMessage());
		}

		// Grep Price if empty, comment if empty
		if(salePrice==null) { salePrice = (line.Price__c * quantity); }
		if(comment!=null) { line.Comment__c = comment; }

		// Reset Totals
		if(line.Quantity_Sold__c==null) {line.Quantity_Sold__c=0;}
		if(line.Quantity_Ordered__c==null) {line.Quantity_Ordered__c=0;}
		if(inv.On_Hand__c==null) {inv.On_Hand__c=0;}
		if(inv.On_Order__c==null) {inv.On_Order__c=0;}
		// Quantity-ordered should always be whatever it takes to make inv 0 from - on -hand;

        // Capture line cost and retain in the event that subledger is not enabled.
		Decimal lineCost = line.Cost__c;

		Decimal reqDiff = quantity - line.Quantity_Sold__c;
		inv.On_Hand__c = inv.On_Hand__c - reqDiff;
		inv.On_Order__c= inv.On_Hand__c <=0 ? inv.On_Order__c += reqDiff : 0;

		// Decrease in the Line QTY
        if(isSubLedgerEnabled) {
            if(quantity<line.Quantity_Sold__c) {
                List<Parts_Ledger__c> ledger = invoiceAPI.ledgerRemoveFromInvoice(inv.Id, line.Id, Integer.valueOf(line.Quantity_Sold__c-quantity));
            }
    
            // Increase in the Line QTY
            if(quantity>line.Quantity_Sold__c) {
                List<Parts_Ledger__c> ledger = invoiceApi.ledger(inv.Id, line.Parts_Invoice__c, (quantity - line.Quantity_Sold__c));
                List<Parts_Ledger__c> ledgerLines = new List<Parts_Ledger__c>();
                for(Parts_Ledger__c pll : ledger) {
                    ledgerLines.add(new Parts_Ledger__c(Id=pll.Id, Parts_Sale_Line__c=line.Id));
                }
    
                try {
                    // update ledgerLines;
                    PartAPI.subLedgerDML(ledgerLines, 'UPDATE');
                } Catch(DmlException e) {
                    throw new PartInvoiceAPIException(e.getMessage());
                }
            }
        


			// Get sum of ledger values for updated cost
			List<aggregateResult> lineCostResult = [SELECT sum(Item_Value__c) partCost FROM Parts_Ledger__c WHERE Part__c =:inv.Id AND Parts_Sale_Line__c=:line.Id];
			System.assert(lineCostResult[0].get('partCost') != null, 'Error: Part Cost must be represented by the Part Ledger');
            lineCost = (Decimal)lineCostResult[0].get('partCost');
		}
        
		// Set line level values and update
		line.Quantity_Ordered__c += reqDiff;
		line.Quantity_Sold__c = quantity;
		line.Cost__c = lineCost;
		line.Price__c = salePrice;
		line.Comment__c = comment;

     // Update History
        dealer__Part_Inventory_History__c invHistory = new dealer__Part_Inventory_History__c(
            dealer__Quantity_Adjustment__c=reqDiff, 
            dealer__Part__c=inv.Id,
            dealer__Parts_Invoice__c=line.Parts_Invoice__c,
            dealer__Transaction_Event__c='Removed part from '+ line.Parts_Invoice__r.Name
        );
        
		try {
			update inv;
			update line;
			insert invHistory;
		} Catch(DmlException e) {
			throw new PartInvoiceAPIException(e.getMessage());
		}

		//Process Stock Order Logic
		soAPI.processStockOrder(line);

		return line;
	}

	/**
	 * [invoiceLines description]
	 * @param  invoiceId [description]
	 * @return           [description]
	 */
	global static List<dealer__Parts_Invoice_Line__c> invoiceLines(Id invoiceId) {

        DescribeSObjectResult describeInvoiceLine = dealer__Parts_Invoice_Line__c.getSObjectType().getDescribe();
        List<String> inv_fieldNames = new List<String>( describeInvoiceLine.fields.getMap().keySet() );	

        // Related Data
        inv_fieldNames.add('dealer__Parts_Order__r.dealer__Service_Job_Line__c');
		inv_fieldNames.add('dealer__Parts_Order__r.dealer__Parts_Line__c');
		
        List<dealer__Parts_Invoice_Line__c> lines = Database.query('SELECT ' + String.join( inv_fieldNames, ',' ) + ' FROM dealer__Parts_Invoice_Line__c WHERE dealer__Parts_Invoice__c = \''+String.escapeSingleQuotes(invoiceId) +'\' ORDER BY Name ASC');	

        return lines;		
	}


	/**
	 * ledger
	 * @param  partId    Part record Id
	 * @param  invoiceId Invoice Record Id
	 * @param  qtySold   Quantity sold via this transaction
	 * @return List<dealer__Parts_Ledger__c> the resulting ledger lines
	 * @notes
	 */
	private List<Parts_Ledger__c> ledger(Id partId, Id invoiceId, Decimal qtySold) {

		Decimal cost = 0;
		Decimal qAdd = 0;

		if(invoiceId==null) {
			throw new PartInvoiceAPIException('invoiceId may not be null');
		}

		Parts_Inventory__c inv = [SELECT Id, Name, Description__c, List__c, 
													Parts_Master__c,On_Hand__c,
													On_Order__c, Cost__c
                                          	FROM Parts_Inventory__c 
                                          	WHERE Id=:partId];		

		SavePoint sp = Database.setSavePoint();

		List<Parts_Ledger__c> insertLedger = new List<Parts_Ledger__c>();
        List<Parts_Ledger__c> updateLedger = new List<Parts_Ledger__c>();

        // Get invoice data
        Parts_Invoice__c partInvoice = [Select Id, Name From Parts_Invoice__c where Id=:invoiceId];
        
        // Query FIFO, Derive cost and associate sale
        List<Parts_Ledger__c> fifoLedger = [Select Id, Quantity__c, Item_Value__c, Transaction_Note__c 
                                                    from Parts_Ledger__c 
                                                    where Parts_Sale_Line__c = NULL 
                                                    and Part__c =:inv.Id
                                                    and Quantity__c > 0
                                                    order by Entry_Date__c ASC 
                                                    limit :Integer.valueOf(qtySold)];
        
        // check result size, if result size is larger or equal than requested amount satisfy from table, else satisfy what is in the table and add ledger entries
        if(fifoLedger.size()>=qtySold) {

			System.debug('FIFO > qtySold');

            cost = 0;
            for(Integer i=0; i<qtySold; i++) {

				// Assist with null pointer exception
				if(fifoLedger[i].Transaction_Note__c==null) {
					fifoLedger[i].Transaction_Note__c='';
				}
                
                updateLedger.add(new Parts_Ledger__c(
                    Id=fifoLedger[i].Id,
                    Quantity__c=0,
                    Transaction_Note__c=(fifoLedger[i].Transaction_Note__c!=null && fifoLedger[i].Transaction_Note__c.right(1)!=';') ? fifoLedger[i].Transaction_Note__c +';Sold on invoice '+partInvoice.Name+';' : fifoLedger[i].Transaction_Note__c +'Sold on invoice '+partInvoice.Name+';',
                    Item_Value__c=fifoLedger[i].Item_Value__c
                ));
            }
        }
        
        // If Results of FIFO are less than QTY Sold - Process cost for QTY sold and then the remaining value to come from part cost
		// The scenario can exist that the QTY Sold will exceed the FIFO results size.  This scenario will occur when selling from
		// stock and then selling in exces of stock on the same line.  Must support selling negative at that event.
        if(fifoLedger.size()<qtySold && fifoLedger.size()!=0) {

			System.debug('FIFO < qtySold but not 0');



            qAdd=qtySold;
            cost = 0;
            for(Integer i=0; i<fifoLedger.size(); i++) {
				if(fifoLedger[i].Transaction_Note__c==null) {
					fifoLedger[i].Transaction_Note__c='';
				}
                qAdd--;
				system.debug('fifoledger '+fifoLedger[i]);
                updateLedger.add(new Parts_Ledger__c(
	                    Id=fifoLedger[i].Id,
	                    Quantity__c=0,
	                    Transaction_Note__c=(fifoLedger[i].Transaction_Note__c.right(1)!=';') ? fifoLedger[i].Transaction_Note__c+';Sold on invoice '+partInvoice.Name+';' : fifoLedger[i].Transaction_Note__c+'Sold on invoice '+partInvoice.Name+';'
	                )
		);	    		
            }

			// Fill the rest not filled by the existing fifo entries
			for(Integer i=0; i<qAdd; i++) {
				qAdd--;
			    insertLedger.add(new Parts_Ledger__c(
            			Quantity__c=-1,
            			Transaction_Note__c='Negative Sale '+partInvoice.Name+';',
            			Item_Value__c=inv.Cost__c,
            			Part__c=inv.Id
            		)
            	);
			}
        }
        
        if(fifoLedger.size()==0) {
			System.debug('FIFO size == 0');
            // We are going neg for the first sale
            for(Integer i=0; i<qtySold; i++) {
            	insertLedger.add(new Parts_Ledger__c(
            			Quantity__c=-1,
            			Transaction_Note__c='Negative Sale '+partInvoice.Name+';',
            			Item_Value__c=inv.Cost__c,
            			Part__c=inv.Id
            		)
            	);
            }
        }

        try {
			PartAPI.subLedgerDML(insertLedger, 'INSERT');
			PartAPI.subLedgerDML(updateLedger, 'UPDATE');
        } Catch(DmlException e) {
        	throw new PartInvoiceAPIException(e.getMessage());
        }

        List<Parts_Ledger__c> outLedger = new List<Parts_Ledger__c>();
        outLedger.addAll(insertLedger);
        outLedger.addAll(updateLedger);

        return outLedger;
        
	}

	private static Map<Id, List<Parts_Ledger__c>> bulkLedger(List<Parts_Invoice_Line__c> partSalesLines) {

		
		// Get Map of Items to Ledger based on Part
		Map<Id, List<Parts_Ledger__c>> partMap = new Map<Id, List<Parts_Ledger__c>>();
		Map<Id, List<Parts_Ledger__c>> returnMap = new Map<Id, List<Parts_Ledger__c>>();
        
        	// Records we need to process
		Set<Id> partsIds = new Set<Id>();
		for(Parts_Invoice_Line__c pil : partSalesLines) {
            
			partsIds.add(pil.Part__c);
            		partMap.put(pil.Part__c, new List<Parts_Ledger__c>());
		}

		for(Parts_Ledger__c pl : [SELECT Id, Part__c, Quantity__c, Item_Value__c, Transaction_Note__c 
                                                    FROM Parts_Ledger__c 
                                                    WHERE Parts_Sale_Line__c = NULL 
                                                    AND Part__c IN:partsIds
                                                    AND Quantity__c > 0
                                                    ORDER BY Entry_Date__c ASC
													]) {
			// Process list into map
			List<Parts_Ledger__c> pll = (partMap.get(pl.Part__c)!=null) ? partMap.get(pl.Part__c) : new List<Parts_Ledger__c>();
			pll.add(pl);
			partMap.put(pl.Part__c, pll);
		}

		// Process each item
		for(Parts_Invoice_Line__c pil : partSalesLines) {
			System.debug(partMap.get(pil.Part__c));
			returnMap.put(pil.Part__c, ledgerProcessFIFO(pil, partMap.get(pil.Part__c)));
		}

		try {

			List<Parts_Ledger__c> ledgerInsertion = new List<Parts_Ledger__c>();
			for(Id mapIteration : returnMap.keySet()) {
				for(Parts_Ledger__c pl : returnMap.get(mapIteration)) {
					ledgerInsertion.add(pl);
				}
			}

			// upsert ledgerInsertion;
			PartAPI.subLedgerDML(ledgerInsertion, 'UPSERT');

			// Re-instantiation of Map
			returnMap = new Map<Id, List<Parts_Ledger__c>>();
			for(Parts_Ledger__c pl : ledgerInsertion) {
				if(returnMap.get(pl.Part__c)==null) {
					returnMap.put(pl.Part__c, new List<Parts_Ledger__c>());
				} 

				List<Parts_Ledger__c> plg = returnMap.get(pl.Part__c);
				plg.add(pl); 
				returnMap.put(pl.Part__c, plg);
			}

		} Catch(DmlException e) {
			throw new PartInvoiceAPIException(e.getMessage());
		}

		return returnMap;
	}

	private static List<Parts_Ledger__c> ledgerProcessFIFO(Parts_Invoice_Line__c invoiceLine, List<Parts_Ledger__c> existingLedgerLines) {

		// Qualify the values
		System.assert(invoiceLine.Cost__c != null, 'Part Cost must be set.');

		if(existingLedgerLines==null) {
			existingLedgerLines=new List<Parts_Ledger__c>();
		}

		// Processing container
		List<Parts_Ledger__c> returnList = new List<Parts_Ledger__c>();

		// Three main loops
		// 1) FIFO Table => QTY SOLD (On Hand)
		// 2) FIFO Table === QTY Sold
		// 3) FIFO Table <= QTY SOLD 

		// 1) 
		if(existingLedgerLines.size() >= invoiceLine.Quantity_Sold__c) {

			System.debug('Inside Ledger positive on-hand Sale Loop');

            for(Integer i=0; i<invoiceLine.Quantity_Sold__c; i++) {

				// Assist with null pointer exception
				if(existingLedgerLines[i].Transaction_Note__c==null) {
					existingLedgerLines[i].Transaction_Note__c='';
				}
                
                returnList.add(new Parts_Ledger__c(
                    Id=existingLedgerLines[i].Id,
                    Quantity__c=0,
                    Transaction_Note__c=(existingLedgerLines[i].Transaction_Note__c!=null && existingLedgerLines[i].Transaction_Note__c.right(1)!=';') ? existingLedgerLines[i].Transaction_Note__c +';Sold on invoice '+invoiceLine.Name+';' : existingLedgerLines[i].Transaction_Note__c +'Sold on invoice '+invoiceLine.Name+';',
                    Item_Value__c=existingLedgerLines[i].Item_Value__c,
					Part__c=existingLedgerLines[i].Part__c
                ));
				returnList[i].Transaction_Note__c = returnList[i].Transaction_Note__c.left(255);
				
            }
		}

		// 2) 
		if(existingLedgerLines.size() < invoiceLine.Quantity_Sold__c && existingLedgerLines.size() != 0) {
            
			System.debug('Inside Ledger Less Than Loop');

			// Measure difference
			Decimal qAdd=invoiceLine.Quantity_Sold__c;


			// Iterage the positive side
            for(Integer i=0; i<existingLedgerLines.size(); i++) {
                qAdd--;
				if(existingLedgerLines[i].Transaction_Note__c==null) {
					existingLedgerLines[i].Transaction_Note__c='';
				}
                returnList.add(new Parts_Ledger__c(
	                    Id=existingLedgerLines[i].Id,
	                    Quantity__c=0,
	                    Transaction_Note__c=(existingLedgerLines[i].Transaction_Note__c.right(1)!=';') ? existingLedgerLines[i].Transaction_Note__c+';Sold on invoice '+invoiceLine.Name+';' : existingLedgerLines[i].Transaction_Note__c+'Sold on invoice '+invoiceLine.Name+';',
                    	Item_Value__c=invoiceLine.Cost__c,
                    	Part__c=existingLedgerLines[i].Part__c
					)
				);	    		
            }

			// Fill the rest not filled by the existing fifo entries
			for(Integer i=0; i<qAdd; i++) {

				System.debug('Inside Ledger Negative Sale Loop');
				//qAdd--;
			    returnList.add(new Parts_Ledger__c(
            			Quantity__c=-1,
            			Transaction_Note__c='Negative Sale '+invoiceLine.Name+';',
            			Item_Value__c=invoiceLine.Cost__c,
            			Part__c=invoiceLine.Part__c,
						Entry_Date__c=Date.today()
            		)
            	);
			}
		}

		// 3)
		if(existingLedgerLines.size() == 0) {
            for(Integer i=0; i<invoiceLine.Quantity_Sold__c; i++) {
            	returnList.add(new Parts_Ledger__c(
            			Quantity__c=-1,
            			Transaction_Note__c='Negative Sale '+invoiceLine.Name+';',
            			Item_Value__c=invoiceLine.Cost__c,
            			Part__c=invoiceLine.Part__c
            		)
            	);
            }			
		}

		System.debug(returnList);

		return returnList;
	}

	private List<Parts_Ledger__c> ledgerRemoveFromInvoice(Id partId, Id invLineId, Integer qtyReturned) {

		// This method returns items to the ledger that had previously been placed here.
		// This method should only be called by the updatePartLine method, to ensure that the ledger is 
		// consistant with the Part Invoice Line.

		List<Parts_Ledger__c> updateLedger = new List<Parts_Ledger__c>();
		List<Parts_Ledger__c> deleteLedger = new List<Parts_Ledger__c>();

		Parts_Inventory__c inv = [Select Id, Name, Description__c, List__c, 
													Parts_Master__c,On_Hand__c,
													On_Order__c, Cost__c
                                          	from Parts_Inventory__c 
                                          	where Id=:partId];		

        List<Parts_Ledger__c> fifoLedger = [Select Id, Quantity__c, Item_Value__c, Transaction_Note__c 
                                                    from Parts_Ledger__c 
                                                    where Part__c =:inv.Id
													and Parts_Sale_Line__c =:invLineId
                                                    order by Quantity__c ASC 
                                                    limit :Integer.valueOf(Math.abs(qtyReturned))];

		System.assert(fifoLedger.size()==qtyReturned, 'LIFO/FIFO Table does not appear to recognize the quantity requested be reduced from the part invoice line.');

		SavePoint sp = Database.setSavePoint();

		for(Parts_Ledger__c ledger : fifoLedger) {

			// If we are returning to Stock
			if(ledger.Quantity__c==0) {
				ledger.Parts_Sale_Line__c=null;
				ledger.Quantity__c = 1;
				ledger.Transaction_Note__c += (ledger.Transaction_Note__c.right(1)==';') ? 'Removed from Invoice' : ';Removed from Invoice';
				updateLedger.add(ledger);
			}

			// If we are unwinding a Negative
			if(ledger.Quantity__c==-1) {
				deleteLedger.add(ledger);
			}
		}

		try {
			
			if(!updateLedger.isEmpty()) {
				// update updateLedger;
				PartAPI.subLedgerDML(updateLedger, 'UPDATE');
			}

			if(!deleteLedger.isEmpty()) {
				// delete deleteLedger;
				PartAPI.subLedgerDML(deleteLedger, 'DELETE');
			}

		} Catch(DmlException e) {
			Database.rollback(sp);
			throw new PartInvoiceAPIException(e.getMessage());
		}

		return updateLedger;										
	}

	private static Map<Id, Map<Id, Decimal>> sumLedgerValue(Set<Id> saleLineIds) {
        
        // Map by PartSaleInvoiceLine, Part
        Map<Id, Map<Id, Decimal>> returnMap = new Map<Id, Map<Id, Decimal>>();
        
        // Iterative Query
        for(Parts_Ledger__c pl : [SELECT Id, Item_Value__c, Part__c, Parts_Sale_Line__c FROM Parts_Ledger__c WHERE Parts_Sale_Line__c IN:saleLineIds]) {
            
            // If this is the first pass, set the value
            if(returnMap.get(pl.Parts_Sale_Line__c)==null) {
                returnMap.put(pl.Parts_Sale_Line__c, new Map<Id, Decimal>{ pl.Part__c => pl.Item_Value__c });
            } else {
                // The sale line has parts on it, does it have the part in this iteration
                if(returnMap.get(pl.Parts_Sale_Line__c).get(pl.Part__c)==null) {
                    returnMap.put(pl.Parts_Sale_Line__c, new Map<Id, Decimal>{ pl.Part__c => pl.Item_Value__c });
                } else {
                    returnMap.put(pl.Parts_Sale_Line__c, new Map<Id, Decimal> { pl.Part__c => (returnMap.get(pl.Parts_Sale_Line__c).get(pl.Part__c) + pl.Item_Value__c) });
                }
            }
        }
        
        return returnMap;
    }
    	

	global class PartInvoiceAPIException extends Exception {}
}