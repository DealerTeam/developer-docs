/**
* Date            |Developer            |Work#
* Notes
* -----------------------------------------------------
* 2016.11.25      |Gaurav Agrawal       |W-000321
* Implemented Trigger Framework
*
* 2016.12.15      |Gaurav Agrawal       |W-000806
* Concatenate Manufacturer and Part Number in Part MFG:No. field on Insert/Update
*/
/**
 * PartsMasterTriggerHandler - Domain Layer Logic
 * @test PartPhysicalInventoryDomainLayer
 */
public class PartsMasterTriggerHandler{
    
    public static void PartMasterAndPartsSync(List<Parts_Master__c> PartsMasterList, Map<Id, Parts_Master__c> PartOldMap){
    
        //Map of Part master id and its all related parts
        Map<Id, List<Parts_Inventory__c>> PartMasterAndRelatedPartsMap = new Map<Id, List<Parts_Inventory__c>>();
        
        //Set of IDs of Part Masters
        Set<Id> PartMasterIdSet = new Set<Id>();
        
        //List of parts to update description
        List<Parts_Inventory__c> PartInventoryList = new List<Parts_Inventory__c>();
        
        //List of parts to update MFG
        List<Parts_Inventory__c> PartInventoryListOne = new List<Parts_Inventory__c>();        
        
        //For loop for getting all the ids of Part master trigger context
        for(Parts_Master__c objPartMaster : PartsMasterList){
            PartMasterIdSet.add(objPartMaster.Id);
        }
        
        //For loop for creating map with master Id and its related parts list
        for(Parts_Master__c objPartMaster : [SELECT Id, (SELECT ID, Description__c, MFG__c FROM Parts_Inventories__r) FROM Parts_Master__c WHERE ID IN : PartMasterIdSet]){        
            PartMasterAndRelatedPartsMap.put(objPartMaster.Id, objPartMaster.Parts_Inventories__r);
        } 
        
        //For loop running for trigger context to update part description
        for(Parts_Master__c objPartMaster : PartsMasterList){

            //Condition to check if old and new description of Part master, if different then update all the related parts with the same description
            if(objPartMaster.Part_Description__c != PartOldMap.get(objPartMaster.Id).Part_Description__c){
                
                //For loop for all the related records of part master and update the description of all the parts
                for(Parts_Inventory__c objPartInventory : PartMasterAndRelatedPartsMap.get(objPartMaster.Id)){
                    objPartInventory.Description__c = objPartMaster.Part_Description__c;
                    //Add all the parts in the list for updating with new description
                    PartInventoryList.add(objPartInventory);
                }
            }
            
            /* W-000321 Begin */
            //Condition to check if old and new Manufacturer of Part master, if different then update all the related part's MFG with the same Manufacturer
            if(objPartMaster.Manufacturer__c != PartOldMap.get(objPartMaster.Id).Manufacturer__c){

                //For loop for all the related records of part master and update the MFG of all the parts
                for(Parts_Inventory__c objPartInventory : PartMasterAndRelatedPartsMap.get(objPartMaster.Id)){
                    objPartInventory.MFG__c = objPartMaster.Manufacturer__c;
                    //Add all the parts in the list for updating with new MFG
                    PartInventoryListOne.add(objPartInventory);
                }
            }
            /* W-000321 End */            
        }
        //If part inventory list is having some values to update
        if(PartInventoryList.size()>0){
            update PartInventoryList;
        }
        
        /* W-000321*/
        //If part inventory list for updating MFG is having some values
        if(PartInventoryListOne.size()>0){
            update PartInventoryListOne;
        }       
    }
    
    public static void CheckDefaultValues(List<Parts_Master__c> PartsMasterList){
        for(Parts_Master__c pm : PartsMasterList) {
            if(pm.Name==null){
                pm.addError('Part Number (Name) can not be blank'); 
            } 
            if(pm.Raw_Part_Number__c==null){
                pm.Raw_Part_Number__c=String.valueOf(pm.Name).replace('-','');
            }
            if(pm.Price_Tape_Date__c==null){
                pm.Price_Tape_Date__c=Date.today();
            }
            if(pm.Manufacturer__c==null){
                pm.Manufacturer__c='OT';
            }
            
            /* W-000806 Begin */
            if(pm.Manufacturer__c!=null){
                pm.Part_No__c=pm.Manufacturer__c;
            }
            if(pm.Name != null){
                pm.Part_No__c+=':'+pm.Name;
            }
            /* W-000806 End */
            
            // Check for Active Status
            if(pm.Status__c==null) {
                pm.Status__c='Active';
            }
        }    
    }
    
    public static void DefaultValues(List<Parts_Master__c> PartsMasterList, Map<Id, Parts_Master__c> PartNewMap){
    
        
        Set<Id> pm = new Set<Id>();
        Map<Id, Parts_Inventory__c> partsInventory = new Map<Id, Parts_Inventory__c>();
        for(Parts_Master__c p : PartsMasterList) {
            pm.add(p.Id);
        }

        // Get associated parts
        Boolean requiresUpdate = false;
        List<Parts_Inventory__c> pUpdate = new List<Parts_Inventory__c>();
        Parts_Master__c p;
        
        for(Parts_Inventory__c pts : [Select Id, Pack_QTY__c, Illustration__c, Parts_Master__c, List__c, Cost__c, Status__c, On_Hand__c from Parts_Inventory__c where Parts_Master__c IN:pm limit 2000]) {
            
            p = PartNewMap.get(pts.Parts_Master__c);

            if(pts.Pack_QTY__c != p.Pack_QTY__c) {
                pts.Pack_QTY__c = p.Pack_QTY__c;
                requiresUpdate=true;    
            }
            
            if(pts.Illustration__c != p.Catalog_Image__c) {
                pts.Illustration__c = p.Catalog_Image__c;
                requiresUpdate=true;
            }

            if(pts.Cost__c != p.Cost__c) {
                pts.Cost__c = p.Cost__c;
                requiresUpdate=true;
            }
            if(pts.List__c != p.Retail_Price__c) {
                pts.List__c = p.Retail_Price__c;
                requiresUpdate=true;
            }

            
            //RT1
            if(pts.Status__c != p.Status__c) {
                if(p.Status__c == 'Obsolete' && pts.On_Hand__c > 0) {
                    pts.Status__c = 'Obsolete w/ Inventory';
                }
                else {
                    pts.Status__c = p.Status__c;
                }
                requiresUpdate = true;
            }
            //end RT1
            
            if(requiresUpdate==true) {
                pUpdate.add(pts);
            }

            requiresUpdate=false;
        }   

        if(pUpdate.size()>0) {
            update pUpdate;
        }  
    }
}