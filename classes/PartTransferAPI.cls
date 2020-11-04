/**
 * PartTransferAPI - Service Layer encapsulation 
 */
public class PartTransferAPI {

	/**
	 * createPartInvoiceLine
	 * @param  PartTransfer__c 
	 * @param  Parts_Invoice__c     
	 * @param  Parts_Order__c
	 * @param  Id, Part
	 * @param  Decimal, part qty      
	 * @return Parts_Invoice__c 
	 * @test   PartManagementServiceLayer.testNewTransfer
	 */
	public static Parts_Invoice_Line__c createTransferLine(PartTransfer__c transfer, Parts_Invoice__c invoice, Parts_Order__c partOrder, Id partMasterId, Decimal qty, String lineComment) {
		
		if(transfer==null || partMasterId == null || qty == null || qty < 0) {
			throw new PartTransferAPIException('Invalid paramter map');
		}

		SavePoint sp = Database.setSavePoint();

		// Pre-Flight, to check if the part has a QOH greater than Requested
		Parts_Inventory__c inv = new Parts_Inventory__c();

		try { 
			inv = [SELECT Id, On_Hand__c, Parts_Master__c
                                          	from Parts_Inventory__c 
                                          	where Parts_Master__c=:partMasterId
                                          	and Location__c =:transfer.From_Location__c];

			if(inv.Id==null) {
				throw new PartTransferAPIException('Unable to transfer Part with masterID of "'+partMasterId+'".  This part does not have any QTY on-hand in the From Location');
			}

        } Catch(Exception e) {
        	throw new PartTransferAPIException('Part with ID \''+partMasterId+'\' not found '+e.getMessage());
        }

        if(inv.On_Hand__c == null || inv.On_Hand__c<qty) {
			throw new PartTransferAPIException('On hand may not be lower than QTY requested');
        }

        // Ensure part exists in the new location, if not create it.
        Id receivingPartId = null;
        Parts_Inventory__c[] p = [SELECT Id, Name 
                                          FROM dealer__Parts_Inventory__c 
                                          where dealer__Parts_Master__c =:inv.dealer__Parts_Master__c 
                                          and dealer__Location__c=:transfer.To_Location__c 
                                          limit 1];
        
        if(p.size()==0) {
            // Add new Part to Location Based on Search from Master
            List<dealer__Parts_Master__c> pmList = [SELECT dealer__Applications__c, dealer__Core_Required__c, dealer__Core_Value__c, dealer__Cost__c, dealer__Height__c, dealer__Jobber_Price__c, dealer__Labor_Time__c, dealer__Length__c, dealer__MAP__c, dealer__MFG_Comments__c, dealer__Manufacturer__c, dealer__Pack_QTY__c, dealer__Part_Description__c, dealer__Part_No_Display__c, dealer__Part_No__c, dealer__Price_Tape_Date__c, dealer__Raw_Part_Number__c, dealer__Retail_Price__c, dealer__Return_Code__c, dealer__UPC__c, dealer__Warranty_Price__c, dealer__Weight__c, dealer__Width__c, dealer__Catalog_Image__c, Id, Name FROM dealer__Parts_Master__c where Id=:inv.dealer__Parts_Master__c limit 1];
			
			try{
				receivingPartId = partAPI.createInventoryFromMaster(pmList, transfer.To_Location__c).values()[0].Id;
			} Catch(DmlException e) {
            	Database.rollBack(sp);
				throw new PartTransferAPIException(e.getMessage());
            }

        } else {
        	receivingPartId = p[0].Id;
        }

		//// Create a Part Invoice Line 
		try {
			
			dealer__Parts_Invoice_Line__c invline = PartInvoiceApi.addInvoiceLine(invoice.Id, null, inv.Id, qty, null, lineComment);		

			if(partOrder!=null && partOrder.dealer__Order__c != null) {

				dealer__Parts_Order__c[] matchedOrder = [Select Id, dealer__Parts_Line__c from dealer__Parts_Order__c where dealer__Order__c =: partOrder.dealer__Order__c and dealer__Parts_Inventory__r.dealer__Parts_Master__c =:partMasterId limit 1];		

				// Set the Transfer Line
				if(matchedOrder.size()>0) {
					matchedOrder[0].Transfer_Line__c = invLine.Id;
					matchedOrder[0].OwnerId=UserInfo.getUserId();

					update matchedOrder;

					invLine.Parts_Order__c = matchedOrder[0].Id;

					update invLine;

				}
			}

			return invLine;

	    } Catch(Exception e) {
			Database.rollBack(sp);
			throw new PartTransferAPIException(e.getMessage());
		}  

		return null; 
	}


	public class PartTransferAPIException extends Exception {

	}
}