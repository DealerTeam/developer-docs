/**
* Date            |Developer            |Work#
* Notes
* --
* 2016-9-20        |David Ray          |Case # 2073
* DR1 - Parts Inventroy should inherit the status of its master - 9-22 - Force to include pack QTY from master.
*
* 2016-11-25       |Gaurav Agrawal       |W-000321
* Implemented Trigger Framework
*
* 2016-11-25       |Abhishek Goel       |W-000776
* To prevent creating multiple part with same location on a single Part Master
*/
/**
 * PartsInventoryControlHandler - Domain Layer Logic
 * @test PartPhysicalDomainLayer.testPartsInventoryControlHandler
 */
public class PartsInventoryControlHandler{
    
    public static void PartsToPartMasterLocationValidation(List<dealer__Parts_Inventory__c> PartsList, Boolean isInsert){
        
        //map of Part IDz and Part Master Ids 
        map<Id, Set<Id>> mapPartMasterLocation = new map<Id, Set<Id>>();
        //Set of Part Master Ids
        Set<Id> PartMasterIdSet = new Set<Id>();
        
        //Map of Part Master and its Id
        Map<Id, dealer__Parts_Master__c> PartMasterMap = new Map<Id, dealer__Parts_Master__c>();
        
        //For loop to get all Part Master Ids
        for(dealer__Parts_Inventory__c objPart : PartsList){
            PartMasterIdSet.add(objPart.dealer__Parts_Master__c);
        } 

        for(dealer__Parts_Inventory__c obj: [SELECT id, name, dealer__Location__c, dealer__Parts_Master__c FROM dealer__Parts_Inventory__c WHERE (dealer__Parts_Master__c IN: PartMasterIdSet)])
        {
            if(!mapPartMasterLocation.containsKey(obj.dealer__Parts_Master__c))
            {
                mapPartMasterLocation.put(obj.dealer__Parts_Master__c, new Set<Id>());
                mapPartMasterLocation.get(obj.dealer__Parts_Master__c).add(obj.dealer__Location__c);
            }
            else
            {
                mapPartMasterLocation.get(obj.dealer__Parts_Master__c).add(obj.dealer__Location__c);
            }
        }

        for(dealer__Parts_Inventory__c obj: PartsList)
        {
            if(mapPartMasterLocation.get(obj.dealer__Parts_Master__c) !=null && mapPartMasterLocation.get(obj.dealer__Parts_Master__c).contains(obj.dealer__Location__c))
            {
                obj.addError('Part already present for selected location under the selected Part Master');
            }
        }
    }

    public static void PartsInventoryControlMethod(List<dealer__Parts_Inventory__c> PartsList, Boolean isInsert){
        
        /*
            This trigger is responsible for the following tasks
                1) Setting dealer__Company_Number (Picklist) with the DLR Code
                2) Set NAME property to be MFG:PARTNUMBER
                3) Setting / Enforcing dealer__Part_No__c to be a string = DLR CODE : MFG CODE : PART NUMBER
                4) First pass, if Parts Master does not exist, add it.
                5) First pass, if Parts Master ID not set lookup from database
        */
    
        /*
            Example to Search or Create a Master Part without specifing in the feed
                dealer__Parts_Inventory__c p = new dealer__Parts_Inventory__c();
                p.Name = '123456-Z';
                p.dealer__Part_No__c  = 'CR3:OT:123456-Z';
                p.dealer__Description__c = 'Test Part Trigger';
                p.dealer__MFG__c = 'OT';
                p.dealer__Cost__c= 99;
                p.dealer__List__c= 129;
                p.dealer__Pack_QTY__c = 0;
                p.dealer__Company_Number__c = 'CR3';
    
                insert p;       
        */        
        
        //Set of Part Master Ids
        Set<Id> PartMasterIdSet = new Set<Id>();
        
        //Map of Part Master and its Id
        Map<Id, dealer__Parts_Master__c> PartMasterMap = new Map<Id, dealer__Parts_Master__c>();
        
        //For loop to get all Part Master Ids
        for(dealer__Parts_Inventory__c objPart : PartsList){
            PartMasterIdSet.add(objPart.dealer__Parts_Master__c);
        }
        
        //For loop to create Part Master Map
        for(dealer__Parts_Master__c objPartMaster : [SELECT Id, dealer__Manufacturer__c FROM dealer__Parts_Master__c WHERE Id IN : PartMasterIdSet]){
            PartMasterMap.put(objPartMaster.Id, objPartMaster);
        }
        
        //For loop to sync Part Master's Manufacturer and Part's MFG
        for(dealer__Parts_Inventory__c objPart : PartsList){
            if(objPart.dealer__Parts_Master__c != null){
                objPart.dealer__MFG__c = PartMasterMap.get(objPart.dealer__Parts_Master__c).dealer__Manufacturer__c;
            }
        }
        
        
        // First Pass - Check for Master
        Set<String> partKeys = new Set<String>();
        Map<String, Id> partMasterResult = new Map<String, Id>();
        
        for(dealer__Parts_Inventory__c p : PartsList){
            if(p.dealer__Parts_Master__c == null) {
                // Add the part master search key to see if part exists in master
                if(p.dealer__Part_No__c==null) { p.addError('Part MFG:No. (dealer__Part_No__c) is a required field for insert/update'); }
                partKeys.add(p.dealer__MFG__c+':'+p.Name);
            }
        }
        
        // Get the relevent parts master entries to support the insertion of data       
        if(partKeys.size()>0){          
            for(dealer__Parts_Master__c pm : [SELECT Id, dealer__Part_No__c,dealer__Status__c,dealer__Product_Tax_Code__c 
                                              FROM dealer__Parts_Master__c WHERE dealer__Part_No__c IN:partKeys limit 1000]){
                partMasterResult.put(pm.dealer__Part_No__c, pm.Id);
            }           
        }

        // Set the PM Entry
        for(dealer__Parts_Inventory__c p : PartsList){
            if(p.dealer__Parts_Master__c==null){                
                if(partMasterResult.get(p.dealer__MFG__c+':'+p.Name)!=null){
                    p.dealer__Parts_Master__c = (Id)partMasterResult.get(p.dealer__MFG__c+':'+p.Name);
                }
            }
        }
        
        // Generate Parts Master Records for any parts that do not have an existing entry
        List<dealer__Parts_Master__c> itemsToCreate = new List<dealer__Parts_Master__c>();
        for(dealer__Parts_Inventory__c p : PartsList){
            if(p.dealer__Parts_Master__c==null){
                // Isolate the part number w/o Manufacturer
                String part_name = p.Name.subStringAfterLast(':');
                if(part_name=='' || part_name==null) {
                    part_name = p.Name;
                }
                
                itemsToCreate.add(new dealer__Parts_Master__c(
                                            Name=part_name,
                                            dealer__Part_Description__c=p.dealer__Description__c,
                                            dealer__Manufacturer__c=p.dealer__MFG__c,
                                            dealer__Part_No__c=p.dealer__MFG__c+':'+p.Name,
                                            dealer__Raw_Part_Number__c=p.Name,
                                            dealer__Cost__c=p.dealer__Cost__c,
                                            dealer__Pack_QTY__c=p.dealer__Pack_QTY__c,
                                            dealer__Retail_Price__c=p.dealer__List__c));
            }
        }

        // Insert Master Records if Necessary
        Map<String, Id> pmIds = new Map<String, Id>();
        if(itemsToCreate.size()>0){
            insert itemsToCreate;
            // Loop and Assign created Record
            for(dealer__Parts_Master__c cPM : itemsToCreate){
                pmIds.put(cPM.dealer__Part_No__c, cPM.Id);
            }
        }

        // Loop parts records without master assigned and assign from array
        for(dealer__Parts_Inventory__c p : PartsList){
            if(p.dealer__Parts_Master__c == null){
                if(pmIds.get(p.dealer__MFG__c+':'+p.Name)!=null){
                    p.dealer__Parts_Master__c=pmIds.get(p.dealer__MFG__c+':'+p.Name);
                }
            }
        }
        
        // Should the name be sanatized by the Trigger
        Boolean runSanitizer = true;

        // Collect the location ID's to associate company number
        Set<ID> locationIds =   new Set<Id>();
        Set<ID> masterIds   =   new Set<Id>();
        
        // MAP of locations with the defined Company Number
        Map<Id, dealer__Dealer_Location__c> locationMap =  new Map<Id, dealer__Dealer_Location__c>();
        Map<String, Id> locationIdMap = new Map<String, Id>();  
        
        for(dealer__Dealer_Location__c d : [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 3000]) {
            locationMap.put(d.Id, d);
            locationIdMap.put(d.dealer__Company_Number__c, d.Id);
        }   

        for(dealer__Parts_Inventory__c p : PartsList) {

            // Check to see if Location is assigned
            if(p.dealer__Location__c==null && p.dealer__Company_Number__c ==null) {
                p.addError('Either dealer__Location__c or dealer__Company_Number__c are required');
            }

            if(p.dealer__Location__c==null) {
                if(locationIdMap.get(p.dealer__Company_Number__c)!=null) {
                    p.dealer__Location__c = locationIdMap.get(p.dealer__Company_Number__c);
                } else {
                    p.addError('Company location not found for '+p.dealer__Company_Number__c+'; Please check your company number to see that it is a valid Dealer Location Company Number.');
                }
            }

            p.dealer__Company_Number__c     =   locationMap.get(p.dealer__Location__c).dealer__Company_Number__c;

            if(p.dealer__Location__c == null) {
                p.addError('Unable to Save Part, Locaiton is a required field');
            } 
            if(p.dealer__Parts_Master__c == null) {
                p.addError('Unable to Save Part, Company and Master are required');
            }

            if(p.dealer__MFG__c != null && 
                    p.dealer__Company_Number__c != null && 
                    (p.dealer__Part_No__c == p.dealer__Company_Number__c+':'+p.dealer__MFG__c+':'+p.dealer__Part_Number__c) &&
                    (p.Name == p.dealer__MFG__c+':'+p.dealer__Part_Number__c)) {
                runSanitizer=false;
            }
            // Need to make sure that the sanitizer runs on insert. - DR1
            if(isInsert) { 
                runSanitizer=true; 
            }
            // /DR1

            locationIds.add(p.dealer__Location__c);
            masterIds.add(p.dealer__Parts_Master__c);
        }

        if(runSanitizer==true) {

            Map<Id, dealer__Parts_Master__c> masterMap = new Map<Id, dealer__Parts_Master__c>([Select Id, Name, dealer__Manufacturer__c,dealer__Status__c, dealer__Pack_QTY__c from dealer__Parts_Master__c Where Id IN:masterIds limit 2000]);

            /*
                Core Trigger
            */
            for(dealer__Parts_Inventory__c inv : PartsList) {

                // Error Checking for API Notifications
                //if(masterMap.get(inv.dealer__Parts_Master__c)==null) {
                //  inv.addError('Part must be associated with Parts Master Definition');
                //}
                
                //System.debug('Getting here');
                //System.debug(masterMap.get(inv.dealer__Parts_Master__c));

                //inv.dealer__MFG__c            =   masterMap.get(inv.dealer__Parts_Master__c).dealer__Manufacturer__c;
                dealer__Parts_Master__c master  =   masterMap.get(inv.dealer__Parts_Master__c);
                String system_part_number       =   master.Name;
                inv.dealer__Part_No__c          =   inv.dealer__Company_Number__c+':'+inv.dealer__MFG__c+':'+system_part_number;
                inv.Name                        =   inv.dealer__MFG__c+':'+system_part_number;


                // DR1 - 
                if(master.dealer__Status__c!=null) {
                    inv.dealer__Status__c =  (inv.dealer__On_Hand__c>0 && master.dealer__Status__c=='Obsolete') ? 'Obsolete w/ Inventory' : master.dealer__Status__c;
                }   

                if(master.dealer__Pack_QTY__c!=null) {
                    inv.dealer__Pack_QTY__c = master.dealer__Pack_QTY__c;
                }
                // /DR1
            }
        }
    }

    
    public class MyException extends Exception {}

}