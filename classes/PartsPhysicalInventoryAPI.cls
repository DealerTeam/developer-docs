/**
 * @author DealerTeam.com, LLC
 * @description Parts physical inventory service layer application programming interface. 
 * @test PartPhysicalInventoryServiceLayer
 * @test PartPhysicalInventoryDomainLayer
 */
public class PartsPhysicalInventoryAPI {
    
    /**
     * loadDetailRecords description
     * @description Load detail records from a specific parts physical into a list.
     * @param  partPhysicalDetailsId Id representing the parts physical record
     * @return  List<dealer__PartsPhysicalDetail__c>
     */
    public static List<PartsPhysicalDetail__c> loadDetailRecords(Id partPhysicalDetailsId)
    {

        return [SELECT Id, Name, Part__c, Part__r.Name, Part__r.MFG__c, Part__r.Part_Number__c, 
                    Initial_Quantity__c, Part__r.Description__c, Count__c, Net__c, Cost__c,
                    Variance_Value__c, Variance_Count_1__c, Count_Variance__c, Notes__c, General_Ledger_Variance_Value__c 
                FROM PartsPhysicalDetail__c
                WHERE Parts_Physical_Inventory__c =: partPhysicalDetailsId 
                ORDER BY Part__r.MFG__c, Part__r.Part_Number__c ASC];        
    } 
  
    /**
     * PhyscialTypeOptions
     * @description List of Types available when performing a parts physical inventory
     * @return   List<SelectOption>
     */
    public static List<SelectOption> physcialTypeOptions()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Location', 'Location'));
        options.add(new SelectOption('Bin', 'Specific Bins'));
        options.add(new SelectOption('Dollar', 'Dollar Value'));
        options.add(new SelectOption('Random', 'Random'));
        return options;
    }
    
    /**
     * @description computeGeneralLedgerVariance calculates the general ledger variance value of included parts with a discrepancy.
     * @param  PartPhysicalDetailsId PartPhysicalDetailsId description
     */
    public static void computeGeneralLedgerVariance(Id partPhysicalDetailsId) 
    {
       
        Decimal variance_value = 0;

        Set<Id> pUpdateAffectedIds = new Set<Id>();
        List<PartsPhysicalDetail__c> pWorkFile = new List<PartsPhysicalDetail__c>();

        for(PartsPhysicalDetail__c ppd : [Select Id, Part__c, Part__r.On_Hand__c, Part__r.Cost__c, Count__c, Cost__c, Variance__c from PartsPhysicalDetail__c where Parts_Physical_Inventory__c =: partPhysicalDetailsId]) {
            if(ppd.Variance__c) {
                pUpdateAffectedIds.add(ppd.Part__c);
            }
            pWorkFile.add(ppd);
        }

        List<Parts_Ledger__c> ledger_list = [Select Id, Item_Value__c, Part__c FROM Parts_Ledger__c WHERE Quantity__c = 1 and Part__c IN : pUpdateAffectedIds order by CreatedDate ASC];

        // Setup a MAP of the Affected Parts and Update the Variance Value on the Part Line.
        List<PartsPhysicalDetail__c> varianceByPartDetail = new List<PartsPhysicalDetail__c>();

        // Process the work file
        for(PartsPhysicalDetail__c ppw : pWorkFile) {  

            // Individual Value
            Decimal itemVariance = 0;

            // If Increase on Part
            if(ppw.Count__c>ppw.Part__r.On_Hand__c) {
                for(Decimal i=ppw.Part__r.On_Hand__c; i<ppw.Count__c; i++) {
                    itemVariance += ppw.Part__r.Cost__c;
                    variance_value += ppw.Part__r.Cost__c;
                }
            }

            // If decrease on Part
            if(ppw.Count__c<ppw.Part__r.On_Hand__c) {

                Decimal decrease_amount = ppw.Part__r.On_Hand__c - ppw.Count__c;

                for(Parts_Ledger__c ll : ledger_list) {

                    if(ll.Part__c == ppw.Part__c && decrease_amount > 0) {
                        variance_value += (ll.Item_Value__c * -1);
                        itemVariance += (ll.Item_Value__c * -1);
                        decrease_amount--;
                    }
                }
            }

            // If reset to Equal, Zero


            // Add the item variance values to the Map and Udpate
            varianceByPartDetail.add(new PartsPhysicalDetail__c(Id=ppw.Id, General_Ledger_Variance_Value__c=itemVariance));
        }

        try {
            if(!varianceByPartDetail.isEmpty())
                update varianceByPartDetail;
        } Catch(DmlException e) {
            throw new PartsPhysicalInventoryAPIException(e.getMessage());
        } Catch(Exception e) {
            throw new PartsPhysicalInventoryAPIException(e.getMessage());
        }        
    }

    /**
     * saveCountApiMethod 
     * @param  detail_records List<dealer__PartsPhysicalDetail__c> record IDs
     * @param  ppi            dealer__PartPhysicalInventory__c Physical Inventory Workfile
     * @return                PageReference standardAction for the PartsPhysical 
     */
    public static PageReference saveCountApiMethod(List<dealer__PartsPhysicalDetail__c> detail_records, dealer__PartPhysicalInventory__c ppi)
    {
        
        SavePoint sp = Database.setSavePoint();

        if(detail_records==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'There are no detail records to save.')); 
            return null;
        }

        try {

            update detail_records;

            ppi.dealer__Status__c = 'Started';
            Decimal openRows = 0;
            for(dealer__PartsPhysicalDetail__c ppd : detail_records) {
                if(ppd.dealer__Count__c==null) {
                    openRows++;
                }
            }

            if(openRows==0) {
                ppi.dealer__Status__c='Missing Parts Reviewed';
            }
            
            update ppi;

        } catch(DmlException e) {
            database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failed to update Physical Work File.  Error: '+e.getMessage())); 
            return null;
        }

        // Set the GL Variance values

        try {
            PartsPhysicalInventoryAPI.computeGeneralLedgerVariance(ppi.Id);
        } Catch(Exception e) {
            database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }

        return new ApexPages.StandardController(ppi).view();        
    }
    
    /**
     * completePhysicalAPIMethod 
     * @param  PartPhysicalInventory__c
     * @return  PageReference PartsPhysicalInventory standard view action
     */
    public static PageReference completePhysicalAPIMethod(dealer__PartPhysicalInventory__c ppi){
        
        system.debug('complete');
        System.assert(ppi.Id!=null, 'PartPhysicalInventoryAPI.completePhysicalAPIMethod() requires the referenced physical inventory to have an ID');
		ppi = [SELECT Id, Name, Status__c FROM PartPhysicalInventory__c WHERE Id=:ppi.Id LIMIT 1];
        
    	if(ppi.Status__c == 'Complete' || ppi.Status__c == 'Posted') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'This Physical has been completed and can not be modified.'));
                return null;
        }

        SavePoint sp = Database.setSavePoint();
 
        // 1. Update the inventory
        List<dealer__Parts_Inventory__c> pUpdate = new List<dealer__Parts_Inventory__c>();
        List<dealer__PartsPhysicalDetail__c> pWorkFile = new List<dealer__PartsPhysicalDetail__c>();
        List<dealer__PartsPhysicalDetail__c> pEntireSet= [Select Id from dealer__PartsPhysicalDetail__c where dealer__Parts_Physical_Inventory__c =: ppi.Id];
        Set<Id> pUpdateAffectedIds = new Set<Id>();

        for(dealer__PartsPhysicalDetail__c ppd : [Select Id, dealer__Part__c, dealer__Part__r.dealer__On_Hand__c, dealer__Part__r.dealer__Cost__c, dealer__Count__c, dealer__Cost__c, dealer__Variance__c from dealer__PartsPhysicalDetail__c where dealer__Parts_Physical_Inventory__c =: ppi.Id and dealer__Variance__c = true]) {
            if(ppd.dealer__Variance__c) {
                pUpdateAffectedIds.add(ppd.dealer__Part__c);
                pWorkFile.add(ppd);
            }
        }

        // 2. Generate the Ledger Entry
        // Prepare the ledger adjustments for each of the affected parts.
        List<dealer__Part_Inventory_History__c> adjust_history = new List<dealer__Part_Inventory_History__c>();
        List<dealer__Parts_Ledger__c> ledger_update = new List<dealer__Parts_Ledger__c>();
        List<dealer__Parts_Ledger__c> ledger_insert = new List<dealer__Parts_Ledger__c>();
        List<dealer__Parts_Ledger__c> ledger_list = [Select Id, dealer__Item_Value__c, dealer__Part__c 
                                                        from dealer__Parts_Ledger__c
                                                        where dealer__Quantity__c = 1
                                                        and dealer__Part__c IN :pUpdateAffectedIds 
                                                        order by CreatedDate ASC];
        Map<Id, dealer__Parts_Ledger__c> ledger_map = new Map<Id, dealer__Parts_Ledger__c>(ledger_list);

        Decimal variance_value = 0;

        // Process the work file
        for(dealer__PartsPhysicalDetail__c ppw : pWorkFile) {

            // Prepare our ledger entries
            System.debug(ppw.dealer__Part__r.dealer__On_Hand__c);

            // If Increase on Part
            if(ppw.dealer__Count__c>ppw.dealer__Part__r.dealer__On_Hand__c) {
                for(Decimal i=ppw.dealer__Part__r.dealer__On_Hand__c; i < ppw.dealer__Count__c; i++) {

                    variance_value += ppw.dealer__Part__r.dealer__Cost__c;

                    ledger_insert.add(new dealer__Parts_Ledger__c(
                                            dealer__Part__c=ppw.dealer__Part__c,
                                            dealer__Entry_Date__c=Date.today(),
                                            dealer__Quantity__c=1,
                                            dealer__Item_Value__c=ppw.dealer__Part__r.dealer__Cost__c,
                                            dealer__Transaction_Note__c='Physical Inventory Variance Increase'
                                        )
                                );
                }
            }

            // If decrease on Part
            if(ppw.dealer__Count__c<ppw.dealer__Part__r.dealer__On_Hand__c) {

                Decimal decrease_amount = ppw.dealer__Part__r.dealer__On_Hand__c - ppw.dealer__Count__c;

                for(dealer__Parts_Ledger__c ll : ledger_list) {
                    if(ll.dealer__Part__c == ppw.dealer__Part__c && decrease_amount > 0) {

                        variance_value += ll.dealer__Item_Value__c;

                        ledger_update.add(new dealer__Parts_Ledger__c(
                                Id=ll.Id,
                                dealer__Quantity__c=0,
                                dealer__Transaction_Note__c='Physical Inventory Variance Decrease'
                            )
                        );

                        decrease_amount--;
                    }
                }
            }

            // 2c. Set parts history record
            if( ppw.dealer__Count__c==null) { ppw.dealer__Count__c=0; }
            Decimal physical_variance_count = 0;
            if(ppw.dealer__Count__c > ppw.dealer__Part__r.dealer__On_Hand__c) {
                physical_variance_count = ppw.dealer__Count__c - ppw.dealer__Part__r.dealer__On_Hand__c;
            }
            if(ppw.dealer__Count__c < ppw.dealer__Part__r.dealer__On_Hand__c) {
                physical_variance_count = ppw.dealer__Part__r.dealer__On_Hand__c - ppw.dealer__Count__c;
            }


            adjust_history.add(new dealer__Part_Inventory_History__c(
                                                        dealer__Part__c=ppw.dealer__Part__c,
                                                        dealer__Transaction_Event__c='Physical Variance',
                                                        dealer__Transaction_Time__c=Datetime.now(),
                                                        dealer__Quantity_Adjustment__c=physical_variance_count,
                                                        dealer__Event_Notes__c='Physical Variance of '+physical_variance_count
                                            )
            );


            // Prepare Part On Hand Adjustment
            pUpdate.add(new dealer__Parts_Inventory__c(         
                                    Id=ppw.dealer__Part__c, 
                                    dealer__On_Hand__c=ppw.dealer__Count__c
                            )
                        );            
        }

        // 3. Erase the lines of the physical
        
        // 4. Post the Physical
        ppi.dealer__Status__c = 'Complete';

        try {
            
            update ppi;

            if(!ledger_update.isEmpty())
                update ledger_update;

            if(!ledger_insert.isEmpty()) 
                insert ledger_insert;

            if(!pUpdate.isEmpty()) 
                update pUpdate;

            if(!adjust_history.isEmpty())
                insert adjust_history;

            // Record Variance Report here
            PageReference variancePage = Page.PartsPhysicalVarianceReport;
            variancePage.getParameters().put('Id', ppi.Id);
            Blob vrb;
            if(!Test.isRunningTest()) {
                vrb = variancePage.getContentAsPDF();
            } else {
                vrb = Blob.valueOf('Test Coverage Blob');
            }
            Attachment d = new Attachment();
            d.ParentId = ppi.Id;
            d.Body = vrb;
            d.ContentType = 'application/pdf';
            d.Name = 'VarianceReport.pdf';  

            // Store report 1
            insert d;

            // Store report 2
            //1.2 Parts Physical Report csv
            List<dealer__PartsPhysicalDetail__c>  partDetails = loadDetailRecords(ppi.Id);
            
            String csv = 'Part Number,Part Description,NET,Variance,On hand,Count,Count Variance,Notes\n';
            
            for(dealer__PartsPhysicalDetail__c p: partDetails){
                csv += p.dealer__Part__r.dealer__Part_Number__c != null ? p.dealer__Part__r.dealer__Part_Number__c + ',':',';
                csv += p.dealer__Part__r.dealer__Description__c != null ? p.dealer__Part__r.dealer__Description__c.escapeCsv() + ',':',';
                csv += p.dealer__Net__c != null ? p.dealer__Net__c + ',':',';
                csv += p.dealer__Variance_Value__c != null ? p.dealer__Variance_Value__c + ',' : ',';
                csv += p.dealer__Initial_Quantity__c != null ? p.dealer__Initial_Quantity__c + ',' : ',';
                csv += p.dealer__Count__c != null ? p.dealer__Count__c + ',' : ',';
                csv += p.dealer__Count_Variance__c != null ? p.dealer__Count_Variance__c + ',' : ',';
                csv += p.dealer__Notes__c != null ? p.dealer__Notes__c.escapeCsv() + '\n': '\n';
            }
            
            Blob csvBlob = Blob.valueOf(csv);
            Attachment att = new Attachment();
            att.ParentId = ppi.Id;
            att.Body = csvBlob;
            att.ContentType = 'application/vnd.ms-excel';
            att.Name = 'PartsPhysicalPost.csv';
            insert att;

            // Delete Contents
            if(!pEntireSet.isEmpty())
                delete pEntireSet;


        } Catch(DmlException e) {
                Database.Rollback(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failed to Complete Physical '+e.getMessage()));
                return null;    
        }


        // Apply the GL Value
        dealer__FixedOperationsSettings__c fops = dealer__FixedOperationsSettings__c.getOrgDefaults();     
        if(fops.dealer__PurchaseOrderPartsReceiptAddress__c!=null) {
            // Check Validity of email handle
            if(!Utility.emailValid(fops.dealer__PurchaseOrderPartsReceiptAddress__c)) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Third Party Accounting Integration Email Handle Invalid ('+fops.dealer__PurchaseOrderPartsReceiptAddress__c+')'));
                database.rollback(sp);
                return null;  
            }

            // Prepare Message
            String message = '{ "recordId" : "' + ppi.Id + '", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parts_physical_variance", "partsReceiptValue" : "' + variance_value + '" }';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            sendTo.add(fops.dealer__PurchaseOrderPartsReceiptAddress__c);
            mail.setToAddresses(sendTo);
            mail.setSubject('Parts Physical Adj.');
            mail.setPlainTextBody(message);

            try {
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            } catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Unable to post inventory adjustment to the Third Party General Ledger'));                
                database.rollback(sp);
                return null;
            }
            
        }             
        
        return new ApexPages.StandardController(ppi).view();
    }   

    public class PartsPhysicalInventoryAPIException extends Exception {}
}