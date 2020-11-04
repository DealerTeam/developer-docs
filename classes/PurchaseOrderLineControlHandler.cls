/**		
 * 		Handler for PurchaseOrderLineControl trigger
 * 		Test class: PurchaseOrderLineControlTest
 **/
public class PurchaseOrderLineControlHandler {
    
    /* ------ Before Context ----- */
    
    /** 
    *  	This method runs on before insert / update context
    * 	@param dealer__Purchase_Order_Line__c list 
    **/ 
    public void handleBeforeInsertUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList){
        
        // If RO Line is Set get the associated Parts Invoice Line
		Set<Id> repairOrderSaleLineIds = new Set<Id>();
		for(dealer__Purchase_Order_Line__c pl : purchaseOrderLineList) {
			if(pl.Parts_Line__c == null && pl.Service_Job_Line__c!=null) {
				if(!repairOrderSaleLineIds.contains(pl.Service_Job_Line__c))
					repairOrderSaleLineIds.add(pl.Service_Job_Line__c);
			}
		}

		Map<Id, Map<Id, Id>> svcInvoicePartMap = new Map<Id, Map<Id, Id>>();
		for(Service_Job__c sj : [SELECT Id, (SELECT Id, Part__c FROM Parts_Lines__r) FROM Service_Job__c WHERE Id IN:repairOrderSaleLineIds]) {
			for(Parts_Invoice_Line__c invLine : sj.Parts_Lines__r) {
				Map<Id, Id> pIMap = new Map<Id, Id>();
				pIMap.put(invLine.Part__c, invLine.Id);
				svcInvoicePartMap.put(sj.Id, pIMap);
			}
		}

		// Additional Sanity checks
		for(dealer__Purchase_Order_Line__c pl : purchaseOrderLineList) {
               
			// Set Part Invoice Line if not Previously Set
			if(pl.Purchase_Order_Accepted_Date__c == null
				&& pl.Parts_Line__c==null 
				&& pl.Service_Job_Line__c !=null 
				&& svcInvoicePartMap.get(pl.Service_Job_Line__c)!=null
				&& svcInvoicePartMap.get(pl.Service_Job_Line__c).get(pl.Part__c)!=null) {
					pl.Parts_Line__c=svcInvoicePartMap.get(pl.Service_Job_Line__c).get(pl.Part__c);
			} 

			// Sanity Check to prevent Parts Purchase Order Lines from missing the Part# reference
			if(pl.dealer__Part_Quantity__c != null && pl.dealer__Part__c==null) {
				pl.dealer__Part__c.addError('Part# is required on a Parts Purchase Order Line.');
			}

			if(pl.dealer__Part_Quantity__c != null && pl.dealer__Part__c != null) {
				if(pl.dealer__Part_Cost__c != null && pl.dealer__Amount__c == null) {
					// Price should be suggested but not forced
					pl.dealer__Amount__c = (pl.dealer__Part_Quantity__c * pl.dealer__Part_Cost__c);
				}
			}

            if(pl.dealer__Amount__c==null) { pl.dealer__Amount__c=0; }
            
            // Check to see if pack part and we have an evenly divisble value
            if(pl.Pack_Quantity__c!=null && pl.Pack_Quantity__c!=0 && pl.Pack_Quantity__c>1 && pl.Pack_Part_Override__c==false) {
                Decimal dividedAmount = pl.Amount__c / pl.Pack_Quantity__c;
                if(dividedAmount.scale() > 2) {
                    pl.addError('Line amount must be evenly divisble by Pack Part Quantity of '+pl.Pack_Quantity__c);
                }
            } else {
                if(pl.Amount__c != null && pl.Part_Quantity__c !=null) {
                    Decimal dividedAmount = pl.Amount__c / pl.Part_Quantity__c;
                    if(dividedAmount.scale() > 2 && !Test.isRunningTest()) {
                        pl.addError('Line amount must be evenly divisble by requested Part Quantity of '+pl.Part_Quantity__c);
                    }     
                }
            }            
			
			pl.dealer__Amount__c = pl.dealer__Amount__c.setScale(2, System.RoundingMode.HALF_UP);
		}
        
    }
    
    /** 
    *  	This method runs on before delete context
    * 	@param dealer__Purchase_Order_Line__c Old list 
    **/ 
    public void handleBeforeDelete(List<dealer__Purchase_Order_Line__c> purchaseOrderLineOldList){
        
        //Service Job Line Id / Purchase Order Line 
        Map<Id, dealer__Purchase_Order_Line__c> jobPOMap = new Map<Id, dealer__Purchase_Order_Line__c>();
        for(dealer__Purchase_Order_Line__c pl : purchaseOrderLineOldList) {
			// Prevent line deletion if accepted date is set
			if(pl.dealer__Purchase_Order_Accepted_Date__c!=null && pl.dealer__RecordType__c != 'Vehicle_Purchase') {
				pl.addError('Accepted/Posted Purchase Orders can not be deleted.');
			}
            
            if(pl.dealer__Service_Job_Line__c != null) {
                jobPOMap.put(pl.dealer__Service_Job_Line__c, pl);
            }
        }
        
        // Bulkified
        // Recalculate Sublet Line amounts on Header when deleted
        List<dealer__Service_Job__c> jobs = [Select Id, dealer__Sublet_Cost__c, dealer__Sublet_Total__c, dealer__Service_Repair_Order__c 
                                      		from dealer__Service_Job__c where Id=:jobPOMap.keySet() limit 2000];
        
        Set<Id> SROIds = new Set<Id>();
        for(dealer__Service_Job__c job: jobs){

            if(job.dealer__Sublet_Cost__c == null) { job.dealer__Sublet_Cost__c =  0; }
            if(job.dealer__Sublet_Total__c == null) { job.dealer__Sublet_Total__c = 0; }
            
            Decimal lineTotal = (jobPOMap.get(job.Id).dealer__Amount__c != null) ? jobPOMap.get(job.Id).dealer__Amount__c : 0;
            Decimal custTotal = (jobPOMap.get(job.Id).dealer__Customer_Total__c != null) ? jobPOMap.get(job.Id).dealer__Customer_Total__c : 0;
            
            Decimal newAmount = job.dealer__Sublet_Cost__c - lineTotal;
            Decimal newCustAmt = job.dealer__Sublet_Total__c - custTotal;
            
            job.dealer__Sublet_Cost__c = (newAmount>0)?newAmount:0;
            job.dealer__Sublet_Total__c = (newCustAmt>0)?newCustAmt:0;
            
            SROIds.add(job.dealer__Service_Repair_Order__c);
        }	
        
        try{
        	update jobs;
        }catch(Exception e){
            e.getMessage();
        }
        
        //To force customer, warranty & internal charges calculations on SRO trigger
        List<dealer__Service_Repair_Order__c> ros = [Select Id from dealer__Service_Repair_Order__c 
                                              			where Id=:SROIds limit 2000];
        try{
        	update ros;    // Is this here to force triggers to run or something? effectively updating the totals?
        }catch(Exception ex){
            ex.getMessage();
        }
    }
    
    /** 
    *  	This method runs on before update context
    * 	@param dealer__Purchase_Order_Line__c list 
    * 	@param Id, dealer__Purchase_Order_Line__c Old Map 
    **/ 
    public void handleBeforeUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap ){
        
        Set<Id> setPartLineId = new Set<Id>();
		Set<Id> setInvoiceId = new Set<Id>();
		Set<Id> partIds = new Set<Id>();

		//get the associated part lines
		for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
            
			if(objLine.dealer__Parts_Line__c!=null){
				setPartLineId.add(objLine.dealer__Parts_Line__c);
			}

			Purchase_Order_Line__c old = purchaseOrderLineOldMap.get(objLine.Id);

			// the part has changed
			if(objLine.Part__c != null && old.Part__c != objLine.Part__c){
				partIds.add(objLine.Part__c);
			}
		}

		Map<Id,dealer__Parts_Invoice_Line__c> mapLine = new Map<Id,dealer__Parts_Invoice_Line__c>([select id,dealer__Cost__c,dealer__Quantity_Sold__c,dealer__Parts_Invoice__c 
                                                                                                   from dealer__Parts_Invoice_Line__c where id in:setPartLineId]);

		if(partIds.size() > 0){
            
			Map<Id, dealer__Parts_Inventory__c> parts = new Map<Id, dealer__Parts_Inventory__c>([select id, Cost__c, Name, Description__c 
                                                                                                 from dealer__Parts_Inventory__c where id in:partIds]);

			for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
                
				dealer__Parts_Inventory__c part = parts.get(objLine.dealer__Part__c);
				objLine.Amount__c = objLine.Part_Quantity__c * part.Cost__c;
				objLine.Description__c = part.Name + ' ' + part.Description__c;
			}		
		}

		//Get invoice ids
		for(dealer__Parts_Invoice_Line__c objLine: mapLine.values()){
			setInvoiceId.add(objLine.dealer__Parts_Invoice__c);
		}

		Map<Id,dealer__Parts_Invoice__c> mapInvoice = new Map<Id,dealer__Parts_Invoice__c>([select id,(select id from dealer__Parts_Transfers__r) 
                                                                                            from dealer__Parts_Invoice__c where id in:setInvoiceId]);

		for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
            
			Boolean hasTransfer=false;

			//Check if respective Parts Invoice has atleast one Part Transfer records
			if(objLine.dealer__Parts_Line__c!=null && 
				mapLine.get(objLine.dealer__Parts_Line__c)!=null && mapLine.get(objLine.dealer__Parts_Line__c).dealer__Parts_Invoice__c!=null &&
				mapInvoice.get(mapLine.get(objLine.dealer__Parts_Line__c).dealer__Parts_Invoice__c).dealer__Parts_Transfers__r.size()>0){
				hasTransfer=true;
			}

			//Check if Quantity/Amount/Partsline is changed
			if(hasTransfer && ( objLine.dealer__Amount__c!=mapLine.get(objLine.dealer__Parts_Line__c).dealer__Cost__c ||
				objLine.dealer__Part_Quantity__c!=mapLine.get(objLine.dealer__Parts_Line__c).dealer__Quantity_Sold__c ||
				purchaseOrderLineOldMap.get(objLine.Id).dealer__Parts_Line__c!=objLine.dealer__Parts_Line__c //If parts line is changed
			)	
			){
				objLine.addError('Transfer Purchase Order Lines should be managed in the Transfer Record');
			}
		}
    }
    
    /** 
    *  	This method runs on before insert context
    * 	@param dealer__Purchase_Order_Line__c list 
    **/ 
    public void handleBeforeInsert(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList){
        
        Set<Id> setPOId = new Set<Id>();

		//get the PO ids 
		for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
			if(objLine.dealer__Purchase_Order__c!=null){
				setPOId.add(objLine.dealer__Purchase_Order__c);
			}
		}

		Map<Id,dealer__Purchase_Order__c> mapPO = new Map<Id,dealer__Purchase_Order__c>([select id,(select id from dealer__Parts_Transfers__r) 
                                                                                         from dealer__Purchase_Order__c where id in:setPOId]);

		//Check if PO has a transfer record and PO invoice is blank
		for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
			if(objLine.dealer__Purchase_Order__c!=null && mapPO.get(objLine.dealer__Purchase_Order__c).dealer__Parts_Transfers__r.size()>0
				&& objLine.dealer__Parts_Line__c==null
				){
				objLine.addError('Transfer Purchase Order Lines should be managed in the Transfer Record');
			}
		}
        
    }
    
    /* ------ After Context ----- */
    
    /** 
    *  	This method runs on after update context
    * 	@param dealer__Purchase_Order_Line__c list 
    * 	@param Id, dealer__Purchase_Order_Line__c Old Map
    **/ 
    public void handleAfterUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap){
        
        
        Set<Id> setPOId = new Set<Id>();
		for(dealer__Purchase_Order_Line__c objLine: purchaseOrderLineList){
			if(objLine.dealer__Purchase_Order__c!=null){
				setPOId.add(objLine.dealer__Purchase_Order__c);
			}
		}
        
		Map<Id,dealer__Purchase_Order__c> mapPO = new Map<Id,dealer__Purchase_Order__c>([select id, dealer__Status__c
                                                                                         from dealer__Purchase_Order__c where id in:setPOId]);

        system.debug('mapPO ' + mapPO);
        // Ensure that Lines Values of specific properties are not modified after accepted
        for(dealer__Purchase_Order_Line__c pL : purchaseOrderLineList) {
            
            // Get the before record for comparison
            dealer__Purchase_Order_Line__c bfore = purchaseOrderLineOldMap.get(pL.Id);
            if(bfore.dealer__Purchase_Order_Accepted_Date__c != null && mapPO.get(pL.dealer__Purchase_Order__c).Status__c == 'Accepted') { // Get the before record and check for an accepted status
                
                String errorMessage = 'may not be changed on an Accepted/Posted Purchase Order';
                if(pL.dealer__Amount__c != bfore.dealer__Amount__c) { pL.dealer__Amount__c.addError('Amount '+errorMessage); } 
                // Parts Related Items
                if(pL.dealer__Part__c != bfore.dealer__Part__c) { pL.dealer__Part__c.addError('Part '+errorMessage); }
                if(pL.dealer__Part_Quantity__c != bfore.dealer__Part_Quantity__c) { pL.dealer__Part_Quantity__c.addError('Quantity '+errorMessage); }
                if(pL.dealer__Part_Quantity_Received__c != bfore.dealer__Part_Quantity_Received__c) { pL.dealer__Part_Quantity_Received__c.addError('Quantity Received '+errorMessage); }
                if(pL.dealer__Parts_Invoice__c != bfore.dealer__Parts_Invoice__c) { pL.dealer__Parts_Invoice__c.addError('Invoice '+errorMessage); }
                if(pL.dealer__Parts_Line__c != bfore.dealer__Parts_Line__c) { pL.dealer__Parts_Line__c.addError('Invoice Line '+errorMessage); }
                if(pL.dealer__Parts_Master__c != bfore.dealer__Parts_Master__c) { pL.dealer__Parts_Master__c.addError('Parts Master '+errorMessage); }
                if(pL.dealer__Purchase_Order__c != bfore.dealer__Purchase_Order__c) { pL.dealer__Purchase_Order__c.addError('Purchase Order '+errorMessage); }
                if(pL.dealer__Service_Job_Line__c != bfore.dealer__Service_Job_Line__c) { pL.dealer__Service_Job_Line__c.addError('Repair Order Line '+errorMessage); }
            }
            
            // If this POLine is related to a Service Job Line and that is related to a negative sale ledger update the Inv Line
            if(Trigger.size == 1 && pL.Parts_Line__c != null) { // Single Edits at this time
                List<Parts_Ledger__c> ledgerUpdate = new List<Parts_Ledger__c>();
                Decimal packQuantity = (pL.Pack_Quantity__c != null && pl.Pack_Part_Override__c == false) ? pL.Pack_Quantity__c : 1;
                Decimal itemValue = (pL.Part_Quantity__c!=null && pL.Part_Quantity__c!= 0) ? (pL.Amount__c / (pL.Part_Quantity__c * packQuantity)) : pL.Amount__c;
                for(Parts_Ledger__c pledg : [SELECT Id, Item_Value__c FROM Parts_Ledger__c WHERE Parts_Sale_Line__c =:pL.Parts_Line__c]) {
                    if(pledg.Item_Value__c != itemValue) {
                        pledg.Item_Value__c = itemValue;
                        ledgerUpdate.add(pledg);
                    }
                }	 
                
                if(!ledgerUpdate.isEmpty()) {
                    // update ledgerUpdate;
                    PartAPI.subLedgerDML(ledgerUpdate, 'UPDATE');
                }
            }			
        }        
    }
    
    /** 
    *  	This method runs on after delete context
    * 	@param dealer__Purchase_Order_Line__c Old list 
    **/ 
    public void handleAfterDelete(List<dealer__Purchase_Order_Line__c> purchaseOrderLineOldList){
        
        System.debug('After Delete Context');
		
		Set<Id> invQuery = new Set<Id>();
		// Get the ID's 
		for(Purchase_Order_Line__c pol : purchaseOrderLineOldList) {
			if(pol.Part__c != null && !invQuery.contains(pol.Part__c)) {
				invQuery.add(pol.Part__c);
			}
		}

		// Should we have affected ID's begin the processing
		if(invQuery.size()>0) {
            
			Map<Id, Parts_Inventory__c> invtoUpdate = new Map<Id, Parts_Inventory__c>([SELECT Id, Name, On_Order__c 
                                                                                       FROM Parts_Inventory__c WHERE Id IN:invQuery]);
			Boolean isChanged = false;
			// Reduce the on-order QTY by amount
			for(Purchase_Order_Line__c pol : purchaseOrderLineOldList) {
                
				if(pol.Part__c != null && invtoUpdate.get(pol.Part__c)!=null) {
					isChanged=true;
					Parts_Inventory__c p = invtoUpdate.get(pol.Part__c);
					p.On_Order__c = (p.On_Order__c == null)?0:p.On_Order__c;
					p.On_Order__c-=(pol.Part_Quantity__c != null) ? pol.Part_Quantity__c : 0;
					invtoUpdate.put(p.Id, p);
				}
			}

			if(isChanged)
				update invtoUpdate.values();
		}
    }
    
    public void handleAfterInsertUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap){
        
        //Maps to populate dealer__Service_Job_Line__c related data
        Map<Id, dealer__Purchase_Order_Line__c> partsLinePOLineMap = new Map<Id, dealer__Purchase_Order_Line__c>();
        Map<Id, dealer__Purchase_Order_Line__c> jobLinePOLineMap = new Map<Id, dealer__Purchase_Order_Line__c>();
        Map<Id, dealer__Purchase_Order_Line__c> partsInvPOLineMap = new Map<Id, dealer__Purchase_Order_Line__c>();
   		Set<Id> subletIds = new Set<Id>();
        
        for(dealer__Purchase_Order_Line__c poline : purchaseOrderLineList) {
            
            //Part Invoice Line
            if(poline.dealer__Parts_Line__c != null) {
                if(!partsLinePOLineMap.containsKey(poline.dealer__Parts_Line__c)){
                    partsLinePOLineMap.put(poline.dealer__Parts_Line__c, poline);
                }
            }
            
            //Service Job
            if(poline.dealer__Service_Job_Line__c != null){
                
                if(!jobLinePOLineMap.containsKey(poline.dealer__Service_Job_Line__c)){
                	jobLinePOLineMap.put(poline.dealer__Service_Job_Line__c, poline);
                }
                if(poline.dealer__RecordType__c == 'Sublet'){
                    subletIds.add(poline.dealer__Service_Job_Line__c);
                }
            }
            //Part Inventory
            if(poline.dealer__Part__c != null){
                if(!partsInvPOLineMap.containsKey(poline.dealer__Part__c)){
                	partsInvPOLineMap.put(poline.dealer__Part__c, poline);
                }
            }
        } 
        
        if(partsLinePOLineMap.size() > 0){
            List<dealer__Parts_Invoice_Line__c> invLines = [SELECT Id, dealer__Cost__c, dealer__Price__c, dealer__Extended_Price__c, 
                                                           dealer__Quantity_Sold__c, Part__c, Part__r.Pack_QTY__c,
                                                           (SELECT Id, Name, Item_Value__c, Purchase_Order__c, dealer__Quantity__c
                                                            FROM Parts_Ledgers__r) 
                                                           FROM dealer__Parts_Invoice_Line__c
                                                           WHERE Id =:partsLinePOLineMap.keySet()
                                                           LIMIT 2000];
            
            // Check to see if the line amount is different than before, if so update the associated parts invoice line and job line
            for(dealer__Parts_Invoice_Line__c invLine : invLines){
                
                // This value must pull from the Ledger as well as the PO.
                // Example: 1 Sold from Stock 3 Sold in total, there for the Cost = (SOld from stock) + PO Amount
                Decimal fromStockCost 	= 	0;
                Decimal unitCountSold   =	(invLine.Quantity_Sold__c!=null) ? invLine.Quantity_Sold__c : 1;	//Added unit count to compensate for difference on POLine count and Stock Count
                Decimal unitCountFilled	=	0; 
                Decimal poLineQuantity	=	(partsLinePOLineMap.get(invLine.Id).Part_Quantity__c!=null) ? partsLinePOLineMap.get(invLine.Id).Part_Quantity__c : 1;
                
                for(Parts_Ledger__c fl : invLine.Parts_Ledgers__r) { // Ledger is assumed to have the items limited to the parts invoice line
                    if(fl.Purchase_Order__c!=null 
                       && fl.Purchase_Order__c!=partsLinePOLineMap.get(invLine.Id).Purchase_Order__c
                       && fl.Quantity__c == 1) { // This is an after context trigger so the receipt of the PO will be contained.
                           fromStockCost += fl.Item_Value__c;
                           unitCountFilled+=1;
                       }
                }
                
                /*
                    ROUTINE COMPLEX TO ACCOMIDATE THE NEED FOR MIXED QTY SOLD AND PO PURCHASE QTY
                    THIS SETS COST ON THE PARTS LINE
                */
                
                System.assert(invLine.Part__r.Pack_QTY__c!=null, 'Part record must specify a value for the Pack Quantity Field. (NULL Values not accepted)');
                
                Decimal lineAmount = 0;
                Decimal filledByPO = (unitCountSold - unitCountFilled);
                
                /* Pack Parts */
                if(invLine.Part__r.Pack_QTY__c!=null 
                   && invLine.Part__r.Pack_QTY__c>1
                   && partsLinePOLineMap.get(invLine.Id).Pack_Part_Override__c==false
                   && (unitCountSold > unitCountFilled)) {
                       
                       System.debug('Inside the pack part negative sale section');
                       System.debug('PO Line Amount '+partsLinePOLineMap.get(invLine.Id).dealer__Amount__c);
                       System.debug('INV Line Part Pack Quantity '+invLine.Part__r.Pack_QTY__c);
                       System.debug('PO Line Quantity '+poLineQuantity);
                       System.debug('Items filled not by Stock '+filledByPO);
                       
                       // PO Line is the amount of the entire pack, setting this to the item value
                       lineAmount  +=  ((partsLinePOLineMap.get(invLine.Id).dealer__Amount__c / invLine.Part__r.Pack_QTY__c) /  poLineQuantity) * filledByPO;
                       unitCountFilled += filledByPO;
                   }
                
                /* Pack Part from Transfer PO */
                if(invLine.Part__r.Pack_QTY__c!=null 
                   && invLine.Part__r.Pack_QTY__c>1
                   && partsLinePOLineMap.get(invLine.Id).Pack_Part_Override__c==true) {
                       lineAmount  +=  (partsLinePOLineMap.get(invLine.Id).dealer__Amount__c / poLineQuantity) * filledByPO;
                   }
                
                /* Non-Pack Parts */
                if(invLine.Part__r.Pack_QTY__c==1
                   && (unitCountSold > unitCountFilled)) {
                       lineAmount  +=  (partsLinePOLineMap.get(invLine.Id).dealer__Amount__c /  poLineQuantity) * filledByPO;
                       unitCountFilled += filledByPO;						
                   }
                
                // To generate the cost of the line item we need to derive from the 
                // originating ledgers as well as the value receipted from the 
                // purchase order. 
                //  To do this we are tracking the QTY out of the ledger minus the total quantity
                // 	This is in the individual quantity for pack parts.
                
                System.debug(fromStockCost);
                System.debug(lineAmount);
                
                invLine.dealer__Cost__c = fromStockCost + lineAmount;
                
                // In future releases this may be sub-optimal as it may allow force the sale price above the desired retail price to the customer
                if(invLine.dealer__Cost__c > invLine.dealer__Extended_Price__c) {
                    invLine.dealer__Price__c = (invLine.dealer__Cost__c / invLine.dealer__Quantity_Sold__c);  //Updated to use Extended Price and set Price per QTY
                }
            }
            
            try {
                update invLines;
            } Catch(DmlException e) {
                e.getMessage();                    
            }  	
        }

        if(jobLinePOLineMap.size() > 0){
            Map<ID, dealer__Service_Job__c> jobs = new Map<ID, dealer__Service_Job__c>([SELECT Id, dealer__Parts_Cost__c, dealer__Parts_Total__c, dealer__Service_Repair_Order__c 
                                                                                        FROM dealer__Service_Job__c 
                                                                                        WHERE Id=:jobLinePOLineMap.keySet() limit 2000]);
            
            //Changed sumpart & sumSublet clause to WHERE instead of 'having' to save SOQL Errors JCruz
            for(AggregateResult sumPart : [SELECT dealer__Job_Line__c jobline, SUM(dealer__Cost__c) pcost, SUM(dealer__Extended_Price__c) pretail 
                                           FROM dealer__Parts_Invoice_Line__c 
                                           WHERE dealer__Job_Line__c IN:jobLinePOLineMap.keySet() GROUP BY dealer__Job_Line__c]){
                                               
            	Id jline = (Id)sumPart.get('jobline');             
                jobs.get(jline).dealer__Parts_Cost__c = (decimal) sumPart.get('pcost');
                jobs.get(jline).dealer__Parts_Total__c = (decimal) sumPart.get('pretail');
            }
        
            for(AggregateResult sumSublet : [SELECT dealer__Service_Job_Line__c jobline, SUM(dealer__Amount__c) amsum, SUM(dealer__Customer_Total__c) amtotal 
                                            FROM dealer__Purchase_Order_Line__c 
                                            WHERE dealer__Service_Job_Line__c IN:subletIds GROUP BY dealer__Service_Job_Line__c]){
                                                 
                Id jline = (Id)sumSublet.get('jobline'); 
                                                 
                Decimal sum = (decimal) sumSublet.get('amsum');
                Decimal total = (decimal) sumSublet.get('amtotal');
                
                System.debug('********** amsum: ' + sumSublet.get('amsum') + ' *******');
                System.debug('********** amtotal: ' + sumSublet.get('amtotal') + ' *******');
    
                jobs.get(jline).dealer__Sublet_Cost__c = sum;
                jobs.get(jline).dealer__Sublet_Total__c= total;
            }
               
            try {
                update jobs.values();	
            } Catch(DmlException e) {
                e.getMessage(); 
            }
            
            Set<Id> sros = new Set<Id>();
            for(dealer__Service_Job__c j: jobs.values()){
                if(!sros.contains(j.dealer__Service_Repair_Order__c)){
                    sros.add(j.dealer__Service_Repair_Order__c);
                }
			}
            
            if(sros.size() > 0){
            	List<dealer__Service_Repair_Order__c> ros = [Select Id from dealer__Service_Repair_Order__c 
                                                  			where Id=:sros limit 2000];
                
                try {
                	update ros;	
                } Catch(DmlException e) {
                    e.getMessage(); 
                }
            }
        }
        
        if(partsInvPOLineMap.size() > 0){
            
            // This is either an insert or QTY Changed
            List<Parts_Inventory__c> ps = [SELECT Id, Name, On_Order__c FROM Parts_Inventory__c 
                                    	WHERE Id =: partsInvPOLineMap.keySet()];
            
            for(Parts_Inventory__c p: ps){
                
                Integer i = (Integer)partsInvPOLineMap.get(p.Id).Part_Quantity__c;
                Id po = partsInvPOLineMap.get(p.Id).Id;
                if(Trigger.isUpdate) {
                    // Compare new and old values for onorder delta
                    Integer iB = (Integer)purchaseOrderLineOldMap.get(po).Part_Quantity__c;	
                    i = i - iB;							
                }
                if(p.On_Order__c==null) { p.On_Order__c=0; }
                p.On_Order__c += i;
            }
            
            try{
                update ps;
            }catch(Exception e){
                e.getMessage();
            }
        }
  
    }
}