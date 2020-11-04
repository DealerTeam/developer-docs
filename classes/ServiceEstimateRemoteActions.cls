public with sharing class ServiceEstimateRemoteActions {
    
    public ServiceEstimateRemoteActions(ApexPages.Standardcontroller sc) {}
    
    // <name>saveCostmeticRepairLine</name>
    // <summary>Provide javascript function to save cosmetic repair line to object</summary>
    // <param name"linejson">json represencation of the service_estimate__line to be saved</param>
    @remoteaction
    public static void saveCosmeticRepairLine(ID EstimateID, Decimal ref, String description, Decimal estimate, String vendor, String repairType, Integer cordX, Integer cordY) {
        dealer__Service_Estimate_Line__c estLine = new dealer__Service_Estimate_Line__c(
                                                            dealer__Service_Estimate__c=EstimateID,
                                                            dealer__Cosmetic_Estimate__c=estimate,
                                                            dealer__Repair_Type__c=repairType,
                                                            dealer__Description__c=description,
                                                            dealer__damageCoordinateX__c=cordX,
                                                            dealer__damageCoordinateY__c=cordY,
                                                            dealer__Vendor__c=vendor,
                                                            dealer__Diagram_Reference_Number__c=ref
                                                        ); 
        insert estLine;                                             
    }
}