/**
*
*	PartsReturn processes the return of parts to a purchasing vendor
*
*
*		Without Sharing - This class accesses Read Only objects for historical tracking (Parts Ledger)
*		
*
*		to-do : pre-populate the shipping address of the vendor based on the account record.
*				return value to be at LIFO and tied to a purchase order line item *Mandatory Field, derive value from the purchase order this was purchased on
*				add a tracking number
* 				add a reason for return (Open Notes Field)		
*/

/**
 * 2016-1-24	|Jarrett Kuljis		|W-000614
 * Correct quantity issue when adding a line to a return
 *
 * 2016-12-21 	|Jarrett Kuljis		|W-000837
 * Price field was not present resulting in failure when adding a new return line.
 * 
 */
public without sharing class PartsReturn {
	
	public dealer__Parts_Invoice__c pi {get;set;}
	public dealer__Dealer_Location__c location {get;set;}
	public dealer__Parts_Invoice_Line__c returnLine {get;set;}
	public Id deleteRowId {get;set;}
	public String purchaseOrderId {get;set;}
	public String partsRecordId {get;set;}
	public Integer lineCount {get;set;}

	public PartsReturn(ApexPages.StandardController c) {
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Parts_Invoice__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
                c.addFields(af);
        }

        pi = (dealer__Parts_Invoice__c)c.getRecord();	

        pi.dealer__Vendor_Return__c=true;	

        // Get the users Location Record
        User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
        List<dealer__Dealer_Location__c> matchingLocations = [Select Id, Name, dealer__Company_Number__c from dealer__Dealer_Location__c where dealer__Company_Number__c =: u.Division limit 1];
        if(matchingLocations[0]!=null) {location = matchingLocations[0];}
        if(pi.dealer__Location__c==null && matchingLocations[0]!=null) {
        	pi.dealer__Location__c=matchingLocations[0].Id;
        }

        // Instantiate the return line
        if(pi.Id!=null) {
        	returnLine = new dealer__Parts_Invoice_Line__c(dealer__Quantity_Sold__c=0);
        }

        if(pi.dealer__Status__c==null) {
        	pi.dealer__Status__c='Open';
        }

        // Get Line Count
        List<dealer__Parts_Invoice_Line__c> lines = [Select Id From dealer__Parts_Invoice_Line__c Where dealer__Parts_Invoice__c=:pi.Id];
        lineCount=lines.size();
	}

	/**
	*
	*	SelectOption of all purchase orders this part was sold against that do not have a sell out line
	* @returns {List<SelectOption} - purchase order lines with PO name
	* @test PartManagementServiceLayer.testPartsReturn
	*/
	public List<SelectOption> getpoLines() {

		List<SelectOption> pol = new List<SelectOption>();

		if(partsRecordId!=null && partsRecordId!='' && partsRecordId!='000000000000000') {

			System.debug('Searching for PartsRecordId = '+partsRecordId);

			for(dealer__Purchase_Order_Line__c l : [Select Id, Name, dealer__Purchase_Order__c, dealer__Purchase_Order__r.Name, dealer__Item_Value__c, dealer__Part_Cost__c, dealer__Part_Quantity_Received__c, dealer__Amount__c from dealer__Purchase_Order_Line__c Where dealer__Part__c=:partsRecordId and dealer__Returned_to_Vendor__c = false order by CreatedDate DESC limit 100]) {
					pol.add(new SelectOption(l.Id, l.dealer__Purchase_Order__r.Name));
			}
		}

		return pol;
	}

	/**
	*
	*	Part selected pagereference to reload the polines
	* @test PartManagementServiceLayer.testPartsReturn
	*/
	public PageReference reloadPOLines() {
		return null;
	}

	/**
	*
	*	Void - void if no lines are present
	* @test PartManagementServiceLayer.testPartsReturn
	*/
	public PageReference voidRecord() {
		List<dealer__Parts_Invoice_Line__c> lines = [Select Id From dealer__Parts_Invoice_Line__c Where dealer__Parts_Invoice__c=:pi.Id];
		if(lines.size()>0) {
	        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to void parts return, lines exist'));
			return null;			
		}

		pi.dealer__Status__c='Void';

		try {
			update pi;
		} Catch(DmlException e) {
	        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to void '+e.getMessage()));
			return null;			
		} 

		PageReference partsInvoice = Page.PartsReturnToVendor;
		partsInvoice.setRedirect(true);
		partsInvoice.getParameters().put('id', pi.Id);
		return PartsInvoice;		
	}

	/**
	*
	*	Invoice - invoice the record and prepare for posting to General Ledger
	* @test PartManagementServiceLayer.testPartsReturn
	*/
	public PageReference invoiceRecord() {
		
		// Get Custom Setting for Purchase Order Events (Fixed Ops Hierarchy Setting)
        dealer__FixedOperationsSettings__c fops = dealer__FixedOperationsSettings__c.getOrgDefaults();  
        SavePoint sp = Database.setSavePoint();

		// Prevent Zero Line Items from being Invoiced
		if([SELECT Id, Line_Count__c FROM Parts_Invoice__c WHERE Id=:pi.Id].Line_Count__c==0) {
	        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to Invoice, this Return To Vendor has no Invoice Lines, unable to Invoice '));
			return null;			
		}

		pi.Invoice_Date_Time__c=Datetime.now();
		pi.Status__c='Invoiced';
		
		try {
			update pi;
		} Catch(DmlException e) {
	        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to void '+e.getMessage()));
	        Database.rollback(sp);
			return null;			
		}

		// Send external accounting system a message
		try {

  			if(fops.dealer__PurchaseOrderPartsReceiptAddress__c!=null) {
                // Check Validity of email handle
                if(!Utility.emailValid(fops.dealer__PurchaseOrderPartsReceiptAddress__c)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Third Party Accounting Integration Email Handle Invalid ('+fops.dealer__PurchaseOrderPartsReceiptAddress__c+')'));
                    database.rollback(sp);
                    return null;  
                }

                // Prepare Message
                String message = '{ "recordId" : "'+pi.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parts_return_to_vendor", "partsReceiptValue" : null }';

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(fops.dealer__PurchaseOrderPartsReceiptAddress__c);
                mail.setToAddresses(sendTo);
                mail.setSubject('Parts Return to Vendor');
                mail.setPlainTextBody(message);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
            }                			

		} Catch(Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unknown Exception while posting to 3rd party accounting solution.  '+e.getCause()));			
			Database.rollback(sp);
			return null;
		}

		PageReference partsInvoice = Page.PartsReturnToVendor;
		partsInvoice.setRedirect(true);
		partsInvoice.getParameters().put('id', pi.Id);
		return PartsInvoice;		
	}


	/**
	*
	*	Save - Save the new record or update the existing record. 
	* @test PartManagementServiceLayer.testPartsReturn
	*/
	public PageReference save() {
		// Set Transaction Control
		SavePoint sp = Database.setSavePoint();

		if(pi.Id==null) {

	        // Incrimental ID Numbering not dependent on object
	        dealer__DMS_Settings__c pset = [Select Id, dealer__Parts_Current_Invoice_Number__c 
	                                                                From dealer__DMS_Settings__c 
	                                                                where Name = 'ActiveSettings' limit 1];
	        pset.dealer__Parts_Current_Invoice_Number__c += 1; 
	        // Check to see if there is an existing invoice with that number
	       	List<dealer__Parts_Invoice__c> curInv = [Select Id, Name, dealer__Invoice_Number__c from dealer__Parts_Invoice__c where dealer__Invoice_Number__c=:String.valueOf(pset.dealer__Parts_Current_Invoice_Number__c) limit 1];
	        if(curInv.size()>0) {
	        	pset.dealer__Parts_Current_Invoice_Number__c += 1;
	        }

	        String invoiceName = location.dealer__Company_Number__c+':'+String.valueOf(pset.dealer__Parts_Current_Invoice_Number__c);		

	        pi.Name = invoiceName;
	        pi.dealer__Invoice_Number__c = 'RETURN-' + String.valueOf(pset.dealer__Parts_Current_Invoice_Number__c);
	        pi.dealer__Counterman__c = UserInfo.getUserId();
	        pi.RecordTypeId = [Select Id from RecordType where DeveloperName = 'Counter_Return' limit 1].Id;
	        pi.dealer__Status__c='Open';
	        pi.dealer__Open_Date_Time__c=DateTime.now();
	        // Get the shipping address from the Account
	        if(pi.dealer__Customer__c!=null && pi.dealer__Ship_To__c==null) {
	        	Account a = [SELECT Id, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode 
	        					FROM Account where Id=:pi.dealer__Customer__c limit 1];

	        	// Check the Ship for non-null values
	        	if(a.ShippingStreet!=null && a.ShippingCity!=null && a.ShippingState != null && a.ShippingPostalCode != null) {
	        		pi.dealer__Ship_To__c = a.ShippingStreet+' \r\n'+a.ShippingCity+', '+a.ShippingState+' '+a.ShippingPostalCode;
	        	}
	        }

	        try {
	        	insert pi;
	        	update pset;
	        } Catch(DmlException e) {
	        	Database.rollback(sp);
	        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Failed to Create Parts Invoice - '+e.getMessage()));
	        	return null;
	        }

	        System.debug(pi);

	        // Return to the invoice page
			PageReference partsInvoice = Page.PartsReturnToVendor;
			partsInvoice.setRedirect(true);
			partsInvoice.getParameters().put('id', pi.Id);
			return PartsInvoice;

    	} else {

    		System.debug(pi);

    		// Perform Update
    		try {
    			update pi;
    		} catch(DmlException e) {
    			Database.rollback(sp);
    			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Failed to Update Parts Invoice - '+e.getMessage()));
    			return null;
    		}

	        // Return to the invoice page
			PageReference partsInvoice = Page.PartsReturnToVendor;
			partsInvoice.setRedirect(true);
			partsInvoice.getParameters().put('id', pi.Id);
			return PartsInvoice;

    	}

    	return null;
	}

	/**
	 * cancel
	 * @return PageReference
	 * @notes Returns to the PartsReturns page as declared on the custom tab.
	 * @test PartManagementServiceLayer.testPartsReturn
	 */
	public PageReference cancel() {
        PageReference pr = Page.PartsReturns;		
        pr.setRedirect(true);
        return pr;
	}

	/**
	 * addReturnLine
	 * @return PageReference
	 * @notes Performs the process of adding a line to the Parts Return.
	 * @test PartManagementServiceLayer.testPartsReturn
	 */
	public PageReference addReturnLine() {

		// Validate the return row data
		if(returnLine==null || returnLine.dealer__Part__c == null || returnLine.dealer__Quantity_Sold__c == null) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Return Line can not be empty.'));
			return null;
		}

		if(returnLine.dealer__Quantity_Sold__c <= 0) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Return quantity must be greater than 0'));
			return null;			
		}

		// Transaction Control
		SavePoint sp = Database.setSavePoint();

		try{

			// Get Count of Lines, for naming the next line in order
			Integer lineCount  = [SELECT count() FROM dealer__Parts_Invoice_Line__c 
													WHERE dealer__Parts_Invoice__c=:pi.Id];
			++lineCount;

			// Lookup Part and Make sure it is for the same location
			dealer__Parts_Inventory__c part = [Select Id, Name, dealer__On_Hand__c, dealer__Part_No__c, dealer__Description__c from dealer__Parts_Inventory__c where Id=:returnLine.dealer__Part__c limit 1 for update];

			// Get Ledger Information and Set Value
			List<dealer__Parts_Ledger__c> ledger = [SELECT dealer__Part__c, dealer__Parts_Sale_Line__c, dealer__Quantity__c, dealer__Purchased_By__c, dealer__Sold_By__c, dealer__Item_Value__c, 
														dealer__Current_Value__c, dealer__Purchase_Order__c, dealer__Transaction_Note__c, dealer__Entry_Date__c, dealer__Repair_Order_Line__c, 
														Name, Id 
													FROM dealer__Parts_Ledger__c 
													where dealer__Part__c=:part.Id 
													and dealer__Quantity__c > 0
													order by dealer__Entry_Date__c ASC
													LIMIT :Integer.valueOf(returnLine.dealer__Quantity_Sold__c)];

			if(ledger.size()!=returnLine.dealer__Quantity_Sold__c) {
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'On Hand inventory for this part is less than the requested return quantity.'));
				return null;				
			}
			
			Decimal inventory_Cost = 0;
			dealer__Purchase_Order_Line__c poLine = [Select Id, dealer__Item_Value__c, dealer__Returned_to_Vendor__c from dealer__Purchase_Order_Line__c where Id=:purchaseOrderId limit 1];

			poLine.dealer__Returned_to_Vendor__c = true;

			update poLine;

			// inventory_Cost=(poLine.dealer__Item_Value__c.setScale(2, System.RoundingMode.HALF_UP) * returnLine.dealer__Quantity_Sold__c);

			// Inventory Cost needs to be pulled from the ledger 
			for(dealer__Parts_Ledger__c ll : ledger) {
				inventory_Cost += ll.Item_Value__c;
			}
			// Reduce stock
			part.dealer__On_Hand__c = part.dealer__On_Hand__c - returnLine.dealer__Quantity_Sold__c;

			update part;

			// Create the Part Invoice Line
			dealer__Parts_Invoice_Line__c invoiceLine = new dealer__Parts_Invoice_Line__c(
				Name=pi.Name+'-'+lineCount,
				dealer__Counterman__c=UserInfo.getUserId(),
				dealer__Parts_Invoice__c=pi.Id,
				dealer__Quantity_Sold__c=returnLine.dealer__Quantity_Sold__c,
				dealer__Part__c=part.Id,
				dealer__Part_Number__c=part.Name,
				dealer__Part_Description__c=part.dealer__Description__c,
				dealer__Cost__c=inventory_Cost,
				dealer__Price__c=inventory_Cost,
				dealer__Purchase_Order_Line__c=purchaseOrderId

			);

			insert invoiceLine;

			// Update the parts ledger
			for(Parts_Ledger__c ll : ledger) {
				// Null check
                if(ll.Transaction_Note__c==null) { ll.Transaction_Note__c = ''; }
                
                String tnote = (ll.dealer__Transaction_Note__c!=null && ll.dealer__Transaction_Note__c.right(1)!=';') ? ll.dealer__Transaction_Note__c +';Return to Vendor;' : ll.dealer__Transaction_Note__c +'Return to Vendor;';

				ll.Quantity__c = 0;
				ll.Transaction_Note__c =  tnote;
				ll.Parts_Sale_Line__c = invoiceLine.Id;
			}

			// update ledger;
			PartAPI.subLedgerDML(ledger, 'UPDATE');

		} Catch(DmlException e) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error adding return line '+e.getMessage()));
			Database.rollback(sp);
			return null;
		} Catch(SObjectException e) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error adding return line '+e.getMessage()));
			Database.rollback(sp);
			return null;
		}

		PageReference partsInvoice = Page.PartsReturnToVendor;
		partsInvoice.setRedirect(true);
		partsInvoice.getParameters().put('id', pi.Id);
		return PartsInvoice;
	}

	/**
	*
	*	Delete Part Line
	* @test PartManagementServiceLayer.testPartsReturn
	*
	*/
	public PageReference deleteLine() {

		if(deleteRowId==null) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Delete Id not set'));
			return null;
		}

		// Transaction Control
		SavePoint sp = Database.setSavePoint();

		try {

			// Get Invoice Line
			dealer__Parts_Invoice_Line__c line = [Select Id, dealer__Part__c, dealer__Quantity_Sold__c, dealer__Purchase_Order_Line__c from dealer__Parts_Invoice_Line__c where Id=:deleteRowId limit 1];

			// Clear PO Line this was returned on
			// Throw error for invalid poline
			if(line == null || line.dealer__Purchase_Order_Line__c==null) {
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Delete Id not set, or Purchase Order Line invalid'));
				return null;				
			}

			dealer__Purchase_Order_Line__c poLine = [Select Id, dealer__Item_Value__c, dealer__Returned_to_Vendor__c from dealer__Purchase_Order_Line__c where Id=:line.dealer__Purchase_Order_Line__c limit 1];

			poLine.dealer__Returned_to_Vendor__c = false;

			update poLine;
			
			// Undo the ledger lines that had been added to this parts invoice line
			List<dealer__Parts_Ledger__c> ledger = [Select Id, dealer__Parts_Sale_Line__c, dealer__Quantity__c from dealer__Parts_Ledger__c where dealer__Parts_Sale_Line__c=:deleteRowId limit 1000];
			for(dealer__Parts_Ledger__c ll : ledger) {
				ll.dealer__Quantity__c=1;
				ll.dealer__Transaction_Note__c='';
			}

			// update ledger;
			PartAPI.subLedgerDML(ledger, 'UPDATE');

			// Reset inventory value
			dealer__Parts_Inventory__c inv = [Select Id, dealer__On_Hand__c from dealer__Parts_Inventory__c where Id=:line.dealer__Part__c limit 1];

			inv.dealer__On_Hand__c += line.dealer__Quantity_Sold__c;

			update inv;

			delete line;

		} Catch(DmlException e) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error adding return line '+e.getMessage()));
			Database.rollback(sp);
			return null;
		} Catch(SObjectException e) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error adding return line '+e.getMessage()));
			Database.rollback(sp);
			return null;
		}
		
		return null;		
	}

	/**
	*
	*	Parts Lines added to the Return Invoice
	* @test PartManagementServiceLayer.testPartsReturn
	*
	*/
	public List<dealer__Parts_Invoice_Line__c> getInvoiceLines() {
		return [Select Id, Name, dealer__Counterman__c, dealer__Parts_Invoice__c, dealer__Quantity_Sold__c, dealer__Part__c, dealer__Part_Number__c, dealer__Part_Description__c, dealer__Cost__c, dealer__Purchase_Order_Line__c, 
					dealer__Purchase_Order_Line__r.Name, dealer__Purchase_Order_Line__r.dealer__Purchase_Order__c 
					From dealer__Parts_Invoice_Line__c 
						Where dealer__Parts_Invoice__c=:pi.Id
					Limit 1000
				];
	}

}