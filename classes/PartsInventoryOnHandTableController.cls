public with sharing class PartsInventoryOnHandTableController {
    
    public PartsInventoryOnHandTableController() {}

    /**
     * Retreive a list of Inventory Records that share a Parts Master
     * 
     * @param partId 
     * @returns `List<Parts_Inventory__c>`
     * @exception 
     */
    @AuraEnabled(cacheable=true)
    public static List<Parts_Inventory__c> getInventoryLocationOnHand(Id partId) {
        
        try {

            Id masterId = getPartMasterId(partId);

            List<Parts_Inventory__c> parts = [
                SELECT Id, Location__r.Name,Location__r.Company_Number__c, On_Hand__c
                FROM Parts_Inventory__c
                WHERE Parts_Master__c = : masterId
            ];
            return (parts.size() > 0) ? parts : null;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * Return the Parts Master Id from a given PartId
     * 
     * @param partId 
     * @returns `Id`
     */
    private static Id getPartMasterId(Id partId) {

        List<Parts_Inventory__c> part = [
            SELECT Id, Parts_Master__c 
            FROM Parts_Inventory__c
            WHERE Id = : partId
            LIMIT 1
        ];
        return ( part.size() > 0 ) ? part.get(0).Parts_Master__c : null;
    }

}