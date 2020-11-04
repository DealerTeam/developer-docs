public with sharing class PartInventoryAPI {
    
    /**
    * makeAdjustment Handles adjusting on_order__c or Cost__c
    * @param  partHistory List of history with values needed to update parts inventory
    * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public void makeAdjustment(List<Part_Inventory_History__c> partHistory)
    {
        canEditParts();
        List<Parts_Inventory__c> parts = new List<Parts_Inventory__c>();

        parts = validateAdjustment(partHistory);
        try {
            if(partHistory.size() > 0){
                insert partHistory;
            }
        } Catch(Exception e){
            throw new PartInventoryAPIException('Error create Part Inventory History records: ' + e.getMessage());
        }
        try{
            if(parts.size() > 0){
                update parts;
            }
        } Catch(Exception e) {
            throw new PartInventoryAPIException('Error create Part Inventory History records: ' + e.getMessage());
        }
    }
    /**
    * validateAdjustment checks the part_inventory_history__c records are valid for updating
    * @param  partHistory List<Part_Inventory_History__c> records with changes to validate
    * @test PartPhysicalInventoryUILayer.testPIEXT
    * @return List<Part_Inventory__c> organized records to update
     */
    public List<Parts_Inventory__c> validateAdjustment(List<Part_Inventory_History__c> partHistory)
    {
        Map<Id, Parts_Inventory__c> partsMap = new Map<Id, Parts_Inventory__c>();
        Set<Id> costIds = new Set<Id>();
        Set<Id> quantityIds = new Set<Id>();

        for(Part_Inventory_History__c historyItem : partHistory){

            if(historyItem.Event_Notes__c == null || historyItem.Event_Notes__c == ''){
                throw new PartInventoryAPIException('Must provide a reason for change.');
            }
            //Update existing part cost
            if(historyItem.Transaction_Event__c != null && historyItem.Transaction_Event__c.contains('Cost')){
                if(partsMap.get(historyItem.Part__c) == null){
                    Parts_Inventory__c part = new Parts_Inventory__c(Id=historyItem.Part__c, Cost__c=historyItem.Cost__c); 
                    partsMap.put(part.Id, part);
                }
                else{
                    partsMap.get(historyItem.Part__c).Cost__c = historyItem.Cost__c;
                }

                costIds.add(historyItem.Part__c);
            }
            //Careful this could be on_hand or on_order
            if(historyItem.Transaction_Event__c != null && historyItem.Transaction_Event__c.contains('on Order')){
                if(partsMap.get(historyItem.Part__c) == null){
                    Parts_Inventory__c part = new Parts_Inventory__c(Id=historyItem.Part__c, On_Order__c=historyItem.Quantity_Adjustment__c); 
                    partsMap.put(part.Id, part);
                }
                else{
                    partsMap.get(historyItem.Part__c).On_Order__c = historyItem.Quantity_Adjustment__c;
                }
                quantityIds.add(historyItem.Part__c);
            }
        }
        if(costIds.size() > 0){
            Map<Id, Parts_Inventory__c> priorCostMap = new Map<Id, Parts_Inventory__c>([SELECT Id, Cost__c FROM Parts_Inventory__c WHERE Id=:costIds]);
            for(Parts_inventory__c part : partsMap.values()){
                if(priorCostMap.get(part.Id) != null && part.Cost__c == priorCostMap.get(part.Id).Cost__c){
                    throw new PartInventoryAPIException('Cost adjustments must have a different value than the current inventory record.');
                }
            }
        }

        if(quantityIds.size() > 0){
            Map<Id, Parts_Inventory__c> priorQuantMap = new Map<Id, Parts_Inventory__c>([SELECT Id, On_Order__c FROM Parts_Inventory__c WHERE Id=:quantityIds]);
            for(Parts_inventory__c part : partsMap.values()){
                if(priorQuantMap.get(part.Id) != null && part.On_Order__c == priorQuantMap.get(part.Id).On_Order__c){
                    throw new PartInventoryAPIException('On-Order adjustments must have a different value than the current inventory record.');
                }
            }
        }

        return  partsMap.values();
    }


    /**
    * adjustOnHand handles updating on-hand adjustments to parts inventory
    * @param  partHistory list of history records used to update existing parts inventory
     */
    public void adjustOnHand(List<Part_Inventory_History__c> partHistory, Boolean updateEmail) 
    {
        canEditParts();
        Set<Id> partsIds = new Set<Id>();
        Decimal difference = 0;
        List<Parts_Inventory__c> partsToUpdate = new List<Parts_Inventory__c>();
        List<Part_Inventory_History__c> historyToInsert = new List<Part_Inventory_History__c>();
        for(Part_Inventory_History__c historyItem : partHistory){
            partsIds.add(historyItem.Part__c);
        }

        if(partsIds.size() > 0){
            Map<Id, Parts_Inventory__c> existingParts = new Map<Id, Parts_Inventory__c>([SELECT Id, On_Hand__c, Cost__c, Location__c FROM Parts_Inventory__c WHERE Id IN:partsIds]);
            
            for(Part_Inventory_History__c historyItem : partHistory){
                if(existingParts.get(historyItem.Part__c) != null && existingParts.get(historyItem.Part__c).On_Hand__c != null){
                    if(historyItem.Quantity_Adjustment__c == existingParts.get(historyItem.Part__c).On_Hand__c){
                        throw new PartInventoryAPIException('On-Hand adjustments must have a different value than the current inventory record.');
                    }
                    //Find the difference between new quantity and existing on hand
                    difference = historyItem.Quantity_Adjustment__c - existingParts.get(historyItem.Part__c).On_Hand__c;
                    //Update existing On_Hand__c with the new value and add to list to perform DML
                    existingParts.get(historyItem.Part__c).On_Hand__c = historyItem.Quantity_Adjustment__c;
                    partsToUpdate.add(existingParts.get(historyItem.Part__c));
                    //Update history record with the difference and add to list to perform DML
                    historyItem.Quantity_Adjustment__c = difference;
                    historyItem.Cost__c = existingParts.get(historyItem.Part__c).Cost__c != null ? existingParts.get(historyItem.Part__c).Cost__c : 0;
                    historyToInsert.add(historyItem);
                }
            }
            ValidateSameStore(partsToUpdate);

            PartAPI.updateLedger(historyToInsert, partsToUpdate, updateEmail);
        }
    }

    public void ValidateSameStore(List<Parts_Inventory__c> partList)
    {
        String location = '';
        for(Parts_Inventory__c part : partList){
            if(part.Location__c != null && location == ''){
                location = part.Location__c;
            }
            else if(part.Location__c != null && location != ''){
                if(location != part.Location__c){
                    throw new PartInventoryAPIException('Unable to update Part. Updates must be limited to a single Company.');
                }
            }
        }
    }
    

    /**
    * getPartHistory
    * @return List<dealer__Part_Inventory_History__c>
    * @notes returns a list of the inventory history records for this part
    * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public List<Part_Inventory_History__c> getPartHistory(String partId){
        return [SELECT Part__c, Parts_Invoice__c, Event_Notes__c, Transaction_Time__c, Quantity_Adjustment__c, Transaction_Event__c, Purchase_Order__c, Cost__c, Sale__c, Cost_Relieved__c, Id, Name, CreatedById, CreatedDate FROM Part_Inventory_History__c WHERE Part__c =:partId ORDER BY Transaction_Time__c DESC LIMIT 100];
    }

    /**
    * getPartLedger
    * @return List<dealer__Parts_Ledger__c>
    * @notes get the list of ledger entries for the part record.
    * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public List<Parts_Ledger__c> getPartLedger(String partId) {
        return [SELECT Part__c, Parts_Sale_Line__c, Quantity__c, Purchased_By__c, Sold_By__c, Item_Value__c, Current_Value__c, Purchase_Order__c, Transaction_Note__c, Entry_Date__c, Repair_Order_Line__c, Name, Id, Reason_for_Change__c FROM Parts_Ledger__c WHERE Part__c=:partId ORDER BY CreatedDate DESC LIMIT 100];
    }

    /**
    * canEditParts Checks for custom permission BulkPartsAdjustment
     */
    public void canEditParts(){
        if(Utility.hasCustomPermission('BulkPartsAdjustment') == false){
            throw new PartInventoryAPIException('User is not authorized to make inventory adjustments. Please contact your administrator to have this feature enabled.');
        }
    }
       

    public class PartInventoryAPIException extends Exception{}
}