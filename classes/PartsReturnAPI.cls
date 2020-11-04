public without sharing class PartsReturnAPI {
    
    /**
    * Creates or updates a Parts Invoice
    * @param  pi Parts_Invoice__c
    */ 
    public static Parts_Invoice__c savePartsInvoice(Parts_Invoice__c pi)
    {
		if(pi.Id==null) {
            //Get location FROM user's location
            User u = [SELECT Id, Division FROM User WHERE Id=:UserInfo.getUserId() limit 1];
            
            Dealer_Location__c [] matchingLocations = [SELECT Id, Name, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c =: u.Division limit 1];
            System.assert(matchingLocations.size() > 0,'You must have your Division set for a valid location');
            Dealer_Location__c location = matchingLocations[0];
            
	        // Incrimental ID Numbering not dependent on object
	        DMS_Settings__c pset = [SELECT Id, Parts_Current_Invoice_Number__c FROM DMS_Settings__c WHERE Name = 'ActiveSettings' limit 1];

            pset.Parts_Current_Invoice_Number__c += 1; 
            
            // Check to see if there is an existing invoice with that number
	       	List<Parts_Invoice__c> curInv = [SELECT Id, Name, Invoice_Number__c FROM Parts_Invoice__c WHERE Invoice_Number__c=:String.valueOf(pset.Parts_Current_Invoice_Number__c) limit 1];
	        if(curInv.size()>0) {
	        	pset.Parts_Current_Invoice_Number__c += 1;
	        }

	        String invoiceName = location.Company_Number__c+':'+String.valueOf(pset.Parts_Current_Invoice_Number__c);		

            pi.Name = invoiceName;
            pi.Location__c = location.Id;
	        pi.Invoice_Number__c = 'RETURN-' + String.valueOf(pset.Parts_Current_Invoice_Number__c);
	        pi.Counterman__c = UserInfo.getUserId();
	        pi.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Vendor_Return' LIMIT 1].Id;
	        pi.Status__c='Open';
	        pi.Open_Date_Time__c=DateTime.now();
	        // Get the shipping address FROM the Account
	        if(pi.Customer__c!=null && pi.Ship_To__c==null) {
	        	Account a = [SELECT Id, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode 
	        				 FROM Account WHERE Id=:pi.Customer__c limit 1];

	        	// Check the Ship for non-null values
	        	if(a.ShippingStreet!=null && a.ShippingCity!=null && a.ShippingState != null && a.ShippingPostalCode != null) {
	        		pi.Ship_To__c = a.ShippingStreet+' \r\n'+a.ShippingCity+', '+a.ShippingState+' '+a.ShippingPostalCode;
	        	}
	        }

	        try {
	        	insert pi;
	        	update pset;

                return pi;
	        } Catch(DmlException e) {
	        	throw new PartsReturnAPIException(e.getMessage());
	        }

    	} else {

    		// Perform Update
    		try {
    			update pi;

                return pi;
    		} catch(DmlException e) {
	        	throw new PartsReturnAPIException(e.getMessage());
    		}
    	}
    }
    
    /**
    * Performs the process of adding a line to the Parts Return
    * @param  pi         Parts Invoice
    * @param  returnLine Parts_Invoice_Line__c to return
    */
    public static void addReturnLine(Parts_Invoice__c pi, Parts_Invoice_Line__c returnLine)
    {
        
       // Validate the return row data
        System.assert(pi.Id != null,'Parts Invoice Id is required to return a line.');
        System.assert(returnLine != null && returnLine.Part__c != null && returnLine.Quantity_Sold__c != null,'Return Line can not be empty.');
        System.assert(returnLine.Quantity_Sold__c > 0, 'Return quantity must be greater than 0');
        System.assert(returnLine.Purchase_Order_Line__c != null, 'Purchase Order is required on Parts Invoice line');
        
        Purchase_Order_Line__c poLine = [SELECT Id, Item_Value__c, Part_Cost__c, Returned_to_Vendor__c, Purchase_Order__c FROM Purchase_Order_Line__c WHERE Id=:returnLine.Purchase_Order_Line__c limit 1];


		try{

			// Get Count of Lines, for naming the next line in order
			Integer lineCount  = [SELECT count() FROM Parts_Invoice_Line__c WHERE Parts_Invoice__c=:pi.Id];
			++lineCount;

			// Lookup Part and Make sure it is for the same location
			Parts_Inventory__c part = [SELECT Id, Name, On_Hand__c, Part_No__c, Description__c FROM Parts_Inventory__c WHERE Id=:returnLine.Part__c limit 1 for update];

			// Get Ledger Information and Set Value
			Parts_Ledger__c [] ledger = [SELECT Part__c, Parts_Sale_Line__c, Quantity__c, Purchased_By__c, Sold_By__c, Item_Value__c, 
                                            Current_Value__c, Purchase_Order__c, Transaction_Note__c, Entry_Date__c, Repair_Order_Line__c, Name, Id 
                                            FROM Parts_Ledger__c 
                                            WHERE Part__c=:part.Id 
                                            AND Quantity__c > 0
                                            AND Purchase_Order__C =: poLine.Purchase_Order__c
                                            order by Entry_Date__c ASC
                                            LIMIT :Integer.valueOf(returnLine.Quantity_Sold__c)];

			if(ledger.size()!=returnLine.Quantity_Sold__c) {
				throw new PartsReturnAPIException('On Hand inventory for this part is less than the requested return quantity.');
			}
			
			poLine.Returned_to_Vendor__c = true;

			update poLine;

			// Reduce stock
			part.On_Hand__c = part.On_Hand__c - returnLine.Quantity_Sold__c;

			update part;

			// Create the Part Invoice Line
			Parts_Invoice_Line__c invoiceLine = new Parts_Invoice_Line__c(
				Name=pi.Name+'-'+lineCount,
				Counterman__c=UserInfo.getUserId(),
				Parts_Invoice__c=pi.Id,
				Quantity_Sold__c=returnLine.Quantity_Sold__c,
				Part__c=part.Id,
				Part_Number__c= returnLine.Part_Number__c,
				Part_Description__c=part.Description__c,
				Cost__c=poLine.Part_Cost__c,
				Price__c=poLine.Item_Value__c,
				Purchase_Order_Line__c=poLine.Id
			);

			insert invoiceLine;

			// Update the parts ledger
			for(Parts_Ledger__c ll : ledger) {
                // Null check
                ll.Transaction_Note__c = ll.Transaction_Note__c != null ? ll.Transaction_Note__c : '';
                
                String tnote = (ll.Transaction_Note__c!=null && ll.Transaction_Note__c.right(1)!=';') ? ll.Transaction_Note__c +';Return to Vendor;' : ll.Transaction_Note__c +'Return to Vendor;';

				ll.Quantity__c = 0;
				ll.Transaction_Note__c =  tnote;
				ll.Parts_Sale_Line__c = invoiceLine.Id;
			}

			// update ledger;
			PartAPI.subLedgerDML(ledger, 'UPDATE');

		} Catch(DmlException e) {
            throw new PartsReturnAPIException(e.getMessage());
		} Catch(SObjectException e) {
            throw new PartsReturnAPIException(e.getMessage());
		}
    }
    
    /**
    * Deletes Part Line
    * @param  line 
    */
    public static void deleteLine(Parts_Invoice_Line__c line)
    {
        System.assert(line.Id != null,'Parts Invoice Line Id required to delete a record');
        System.assert(line.Part__c != null,'Part Id required to delete a record');
        System.assert(line.Quantity_Sold__c != null,'Quantity Sold is required to delete a Parts Invoice Line');
        System.assert(line.Purchase_Order_Line__c != null,'Purchase Order Line Id is required to delete a Parts Invoice Line');
        try{
            Purchase_Order_Line__c poLine = [SELECT Id, Item_Value__c, Returned_to_Vendor__c FROM Purchase_Order_Line__c WHERE Id=:line.Purchase_Order_Line__c];
            poLine.Returned_to_Vendor__c = false;
            update poLine; 
    
            Parts_Ledger__C [] ledger = [Select Id, Parts_Sale_Line__c, Quantity__c from Parts_Ledger__c where Parts_Sale_Line__c=:line.Id limit 1000];
            for(Parts_Ledger__c ll : ledger ){
                ll.Quantity__c=1;
                ll.Transaction_Note__c='';
            }
            PartAPI.subLedgerDML(ledger,'UPDATE');
    
            // Reset Inventory Value
            Parts_Inventory__c inv = [Select Id, On_Hand__c from Parts_Inventory__c where Id=:line.Part__c];
            inv.On_Hand__c += line.Quantity_Sold__c;
            update inv;
            delete line;
        } catch(DMLException e){
            throw new PartsReturnAPIException(e.getMessage());
        } catch(SobjectException e){
            throw new PartsReturnAPIException(e.getMessage());
        }
    }

    /**
    * SelectOptions of all purchase orders this part was sold against that do not have a sell out line
    * @param  part Part
    * @return      List<SelectOption>
    */ 
    public static List<SelectOption> getPoLines(Parts_Inventory__c part)
    {
        System.assert(part.Id != null, 'Part Id is required to look up PO lines.');

        List<SelectOption> pol = new List<SelectOption>();

        for(Purchase_Order_Line__c l : [SELECT Id, Name, Purchase_Order__c, Purchase_Order__r.Name, Item_Value__c, Part_Cost__c, Part_Quantity_Received__c, Amount__c 
                                        FROM Purchase_Order_Line__c 
                                        WHERE Part__c=:part.Id AND Returned_to_Vendor__c = false 
                                        ORDER BY CreatedDate DESC limit 100]) {

                pol.add(new SelectOption(l.Id, l.Purchase_Order__r.Name));
        }
		return pol;
    }

    /**
    * void if no lines are present
    * @param  pi Parts Invoice
    */
    public static void voidPartsInvoice(Parts_Invoice__c pi)
    {
        System.assert(pi.Id != null, 'Parts Invoice Id is required to void a record.');

        Parts_Invoice_Line__c [] lines = [SELECT Id FROM Parts_Invoice_Line__c WHERE Parts_Invoice__c=:pi.Id];
		if(lines.size()>0) throw new PartsReturnAPIException('Unable to void parts return, lines exist');
        
        pi.status__c = 'Void';

        try{
            update pi;
        } catch(DMLException e){
            throw new PartsReturnAPIException(e.getMessage());
        }
    }

    /**
    * invoice the record and prepare for posting to General Ledger
    * @param  pi Parts Invoice
    */
    public static void invoiceRecord(Parts_Invoice__c pi) 
    {
        System.assert(pi.Id != null, 'Parts Invoice Id is required to invoice a record.');
 
        SavePoint sp = Database.setSavePoint();

		// Prevent Zero Line Items FROM being Invoiced
		if([SELECT Id, Line_Count__c FROM Parts_Invoice__c WHERE Id=:pi.Id].Line_Count__c==0) {
            throw new PartsReturnAPIException('Unable to Invoice, this Return To Vendor has no Invoice Lines, unable to Invoice');
        }

		pi.Invoice_Date_Time__c=Datetime.now();
		pi.Status__c='Invoiced';
		
		try {
            update pi;
            sendAccountingMessage(pi);
		} Catch(DmlException e) {
            throw new PartsReturnAPIException(e.getMessage());
		}
    }

    /**
    * Parts Lines added to the Return Invoice
    * @param  pi Parts Invoice
    */ 
    public static List<Parts_Invoice_Line__c> getInvoiceLines(Parts_Invoice__c pi)
    {
        System.assert(pi.Id != null, 'Parts Invoice Id required to get Parts Invoice Lines');
        Parts_Invoice_Line__c [] lines = 
        [
            SELECT Id, Name, Counterman__c, Parts_Invoice__c,
            Quantity_Sold__c, Part__c, Part_Number__c, Price__c,
            Part_Description__c, Cost__c, Purchase_Order_Line__c, Total_Price__c,
            Purchase_Order_Line__r.Name, Purchase_Order_Line__r.Purchase_Order__c 
            FROM Parts_Invoice_Line__c 
            WHERE Parts_Invoice__c=:pi.Id
            LIMIT 1000
        ];
        return lines;
    }

    /**
    * Sends Accounting Email to accounting solution
    * @param  pi Parts Invoice
    */
    public static void sendAccountingMessage(Parts_Invoice__c pi)
    {
		// Get Custom Setting for Purchase Order Events (Fixed Ops Hierarchy Setting)
        FixedOperationsSettings__c fops = FixedOperationsSettings__c.getOrgDefaults(); 
        
        try {

            if(fops.PurchaseOrderPartsReceiptAddress__c!=null) {
              // Check Validity of email handle
              if(!Utility.emailValid(fops.PurchaseOrderPartsReceiptAddress__c)) {
                  throw new PartsReturnAPIException('Error: Third Party Accounting Integration Email Handle Invalid ('+fops.PurchaseOrderPartsReceiptAddress__c+')');
              }

              // Prepare Message
              String message = '{ "recordId" : "'+pi.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parts_return_to_vendor", "partsReceiptValue" : null }';

              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              List<String> sendTo = new List<String>();
              sendTo.add(fops.PurchaseOrderPartsReceiptAddress__c);
              mail.setToAddresses(sendTo);
              mail.setSubject('Parts Return to Vendor');
              mail.setPlainTextBody(message);
              Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
          }                			

        } catch(Exception e) {
            throw new PartsReturnAPIException('Unknown Exception while posting to 3rd party accounting solution.  '+e.getCause());
        }
    }

    public class PartsReturnAPIException extends Exception {}

}