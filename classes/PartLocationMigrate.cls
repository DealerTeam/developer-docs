/**
* @test PartPhysicalInventoryDomainLayer.testPartsMasterTriggerHandler
* Date            |Developer            |Work#
* Notes
* --
* 2017.13.01      |Gaurav               |W-000892
* Created batch class for bulk insertion of Part Physical Detail records
**/

global class PartLocationMigrate implements Database.batchable<SObject>, database.allowscallouts, Database.Stateful {
    
    global List<id> ListRecForEmailId;
    
    //Part Physical Inventory record for Part Physical Detail record
    global dealer__PartPhysicalInventory__c objPartPhysicalInv;
    
    //Contructor
    global PartLocationMigrate(dealer__PartPhysicalInventory__c objPPI){
        ListRecForEmailId = new List<Id>();
        this.objPartPhysicalInv = objPPI;           
    }
    
    global Database.QueryLocator start(Database.batchableContext bc){
        string qLoc;
        qLoc = 'Select Id, dealer__On_Hand__c, dealer__Bin__c, dealer__Cost__c from dealer__Parts_Inventory__c where dealer__Location__c ='+'\''+objPartPhysicalInv.dealer__Location__c+'\''+' AND (dealer__On_Hand__c > 0 OR dealer__Physical_OnHand__c >0)';
        return Database.getQueryLocator(qLoc);
    }
    
    global void execute(Database.BatchableContext bc, List<dealer__Parts_Inventory__c> sObjs){ 
    
        List<dealer__PartsPhysicalDetail__c> ppd = new List<dealer__PartsPhysicalDetail__c>();

        //For loop to create Part Physical Detail records based on Parts Inventory records
        for(dealer__Parts_Inventory__c pi : sObjs) {

            ppd.add(new dealer__PartsPhysicalDetail__c(
                    dealer__Parts_Physical_Inventory__c = objPartPhysicalInv.Id,
                    dealer__Part__c=pi.Id,
                    dealer__Initial_Quantity__c=pi.dealer__On_Hand__c,
                    dealer__Bin__c=pi.dealer__Bin__c,
                    dealer__Cost__c=pi.dealer__Cost__c
                )
            );
        }
        
        if(ppd.size()>0){ 
            //insert ppd;                   
            Database.SaveResult[] srList = Database.insert(ppd, false);   
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if(!sr.isSuccess()) {
                    // Operation was unsuccessful, so get the ID of the record that was processed
                    ListRecForEmailId.add(sr.getId());
                }
            } 
        }       
    }
    
    global void finish(Database.BatchableContext bc){
        // Email each Batch failed records  
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
        String[] toAddresses = new String[]{'apexerror@dealerteam.com'};  
        mail.setToAddresses(toAddresses);  
        mail.setSubject('Org:('+UserInfo.getOrganizationId()+') PartLocationMigrate Failed Records');  
        mail.setHTMLBody('Org ID:('+UserInfo.getOrganizationId()+')<br></br><b> PartLocationMigrate failed records ID:</b> <br></br><br></br>' +ListRecForEmailId);          
        if(ListRecForEmailId.size()>0){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });     
        }
    }
}