/**
* Date                |Developer            |Work#
* Notes
* --
* 2016-10-26          |Jarrett Kuljis       |
* Update the Kit Price always, based on the kit list, labor sale
*
* 2016-10-27          |Abhishek Goel        |W-000630
* Not set Kit price if labour and Kitlist = = 0 or Null
*
* 2016-11-30          |Gaurav Agrawal       |#W-000743
* Optimized trigger and implemented trigger framework
*   
**/

/**
 * PartsKitControlHandler - Domain Layer Trigger Handler
 * @test ParPhysicalInventoryDomainLayer.testPartsKitControl
 */
public class PartsKitControlHandler{

    //Utility method for calculations of PartsKit
    public static void PartsKitLaborCalculations(List<dealer__Parts_Kit__c> PartsKitList){
        
        for(dealer__Parts_Kit__c objPartsKit : PartsKitList){
            
            if(objPartsKit.dealer__Labor_Sale__c==null){
                objPartsKit.dealer__Labor_Sale__c = 0;
            }

            // Begin  W-000630
            if(Utility.isGreaterThanZero(objPartsKit.dealer__Kit_List__c) || Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Sale__c)){
                objPartsKit.Kit_Price__c = objPartsKit.dealer__Labor_Sale__c + objPartsKit.dealer__Kit_List__c;                
            }
            // End  W-000630

            //Begin W-000710
            
            // Check Kit hours
            if((Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Cost__c) || Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Sale__c) || Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Hourly_Cost__c) || Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Hourly_Sale__c)) && !Utility.isGreaterThanZero(objPartsKit.dealer__Kit_Hours__c)){
                objPartsKit.addError('Please add Kit Hours for labor work.');
            }
            else
            {
                // Update Total labor fields
                if(Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Hourly_Cost__c)){
                    objPartsKit.dealer__Labor_Cost__c = objPartsKit.dealer__Labor_Hourly_Cost__c * objPartsKit.dealer__Kit_Hours__c;
                }
                else if(Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Cost__c)){
                    objPartsKit.dealer__Labor_Hourly_Cost__c = objPartsKit.dealer__Labor_Cost__c / objPartsKit.dealer__Kit_Hours__c;
                }


                if(Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Hourly_Sale__c)){
                    objPartsKit.dealer__Labor_Sale__c = objPartsKit.dealer__Labor_Hourly_Sale__c * objPartsKit.dealer__Kit_Hours__c;
                }
                else if(Utility.isGreaterThanZero(objPartsKit.dealer__Labor_Sale__c)){
                    objPartsKit.dealer__Labor_Hourly_Sale__c = objPartsKit.dealer__Labor_Sale__c / objPartsKit.dealer__Kit_Hours__c;
                } 
            }
            // End W-000710 
        }       
    } 
    
    //Utility method to insert Part Master and Part for PartsKit
    public static void CreatePartMasterAndParts(List<dealer__Parts_Kit__c> PartsKitList){
    
        // After creation of Parts Kit, create record in Part table to support autocomplete lookups.
        dealer__FixedOperationsSettings__c ops = dealer__FixedOperationsSettings__c.getOrgDefaults(); 
        
        if(ops.dealer__Kit_Create_Part_Master__c == true){
        
            List<dealer__Parts_Inventory__c> pi = new List<dealer__Parts_Inventory__c>();
            List<dealer__Parts_Stocking_Group__c> stockingGroup = [Select Id from dealer__Parts_Stocking_Group__c where dealer__Active__c = true and dealer__Default__c = true limit 1];                        
            Map<dealer__Parts_Kit__c,dealer__Parts_Master__c> PartMasterMap = new Map<dealer__Parts_Kit__c,dealer__Parts_Master__c>();       
            
            for(dealer__Parts_Kit__c objPartsKit : PartsKitList){
            
                // Create the Master Definition of the KIT
                dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
                pm.Name = objPartsKit.Name;
                pm.dealer__Retail_Price__c = 0;
                pm.Manufacturer__c = 'KIT';
                PartMasterMap.put(objPartsKit, pm);
            }  
            
            insert PartMasterMap.values();
            
            for(dealer__Parts_Kit__c objPartsKit : PartMasterMap.keySet()){
                pi.add(new dealer__Parts_Inventory__c(
                                                      Name = 'KIT:'+objPartsKit.Name, 
                                                      dealer__Part_No__c = objPartsKit.Name,
                                                      dealer__Cost__c = 0, 
                                                      dealer__List__c = 0,
                                                      dealer__Description__c = objPartsKit.dealer__Description__c,
                                                      dealer__MFG__c = 'KIT',
                                                      dealer__Stocking_Group__c = stockingGroup[0].Id,
                                                      dealer__Kit__c = objPartsKit.Id,
                                                      dealer__Parts_Master__c = PartMasterMap.get(objPartsKit).Id,
                                                      dealer__Location__c = Utility.lookupUserLocation()
                                                    ));      
            }
            
            if(pi.size() > 0) {
                insert pi;
            }
        }             
    }  
}