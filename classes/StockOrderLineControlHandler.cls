public class StockOrderLineControlHandler {

    /**
     * Updates the Part Number field with the Name of the Parts Master from the lookup field.
     * @param {List<Stock_Order_Line__c} - Lines provided by the trigger
     * @test StockOrderDomainLayer.testBeforeUpdate & StockOrderDomainLayer.testBeforeInsert
     */
    public static void updatePartNumber(List<Stock_Order_Line__c> lines) {
        List<Id> partList = new List<Id>();
            //Get Part Master Name to update Stock Order Line
            for(Stock_Order_Line__c sol: lines){
                if(sol.PartMaster__c != null){
                    partList.add(sol.PartMaster__c);
                }
            }

            if(partList.size() >0){
                Map<Id,Parts_Master__c> partMap = new Map<Id, Parts_Master__c> ([SELECT Id, Name FROM Parts_Master__c WHERE Id IN:partList]);
                //Update the part number field with Part Master Name field
                for(Stock_Order_Line__c sol : lines){

                    if(sol.PartMaster__c != null){
                        if(partMap.containsKey(sol.PartMaster__c)){
                            sol.Part_Number__c = partMap.get(sol.PartMaster__c).Name;
                        }
                    }
                }
            }
    }
}