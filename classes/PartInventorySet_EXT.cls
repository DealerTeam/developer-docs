public with sharing class PartInventorySet_EXT {

    public List<dealer__Parts_Inventory__c> parts { get; set; }
    public ApexPages.StandardSetController ssc;

    public decimal partsSize {get;set;}

    public String reasonForChange {get;set;}

    public PartInventoryAPI partAPI {get;private set;}

    public String nameLabel {get;set;}
    public String onHandLabel {get;set;}

    public PartInventorySet_EXT(ApexPages.StandardSetController standardSetController)
    {
        this.ssc = standardSetController;

        if(!Test.isRunningTest()) {
            ssc.addFields(new List<String> {'Id', 'Part_Number__c', 'Description__c', 'On_Hand__c'});
        }

        queryParts();
        
        this.partsSize = ssc.getResultSize();

        this.reasonForChange = '';

        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType partSchema = schemaMap.get('dealer__Parts_Inventory__c');
        Map<String, Schema.SObjectField> fieldMap = partSchema.getDescribe().fields.getMap();

        this.nameLabel = fieldMap.get('dealer__Part_Number__c').getDescribe().getLabel();
        this.onHandLabel = fieldMap.get('dealer__On_Hand__c').getDescribe().getLabel();

    }

    public void setPartAPI(){
        if(partAPI == null){
            partAPI = new PartInventoryAPI();
        }
    }

    public Pagereference updateParts()
    {
        system.debug(parts);
        adjustOnHand();
        queryParts();
        this.reasonForChange = '';
        return null;
    }

    public PageReference cancel(){
        return ssc.cancel();
    }

    public boolean validateReasonForChange()
    {
            if(String.isBlank(reasonforchange)|| reasonForChange == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide Reason for Change.'));
            return true;
        }
        return false;

    }

    /**
     * adjustOnHand
     * @return PageReference
     * @notes Used to adjust the onhand quantity of part in physical inventory.  This is specifically for Manual Adjustments.
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public PageReference adjustOnHand() 
    {

        /*
            Abstracted version start
        */
        if(validateReasonForChange() == true){
            return null;
        }
        List<Part_Inventory_History__c> historyList = new List<Part_Inventory_History__c>();

        for(Parts_Inventory__c inventoryRecord : parts){
            /* Record the part history */
            dealer__Part_Inventory_History__c p = new dealer__Part_Inventory_History__c(
                        dealer__Part__c = inventoryRecord.Id,
                        dealer__Transaction_Event__c = 'Manual On Hand Adjustment',
                        dealer__Transaction_Time__c = Datetime.now(),
                        dealer__Quantity_Adjustment__c = inventoryRecord.On_Hand__c,
                        dealer__Event_Notes__c = reasonforchange,
                        dealer__Cost__c = null);
            historyList.add(p);
        }
        if(historyList.size() > 0){
            try{
                setPartAPI();
                partAPI.adjustOnHand(historyList, true); //Will need to add onHand support to for email notification of GL update
            } Catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to adjust the on hand of this inventory record: '+e.getMessage()));
                return null;
            }

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'On Hand Adjusted'));
            return null;
        }

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No parts selected to update: '));
        return null;
    }

    public void queryParts(){
        List<dealer__Parts_Inventory__c> partList = ssc.getSelected();
        Set<Id> partIds = new Set<Id>();
        for(Parts_Inventory__c p : partList){
            partIds.add(p.Id);
        }
        this.parts = [SELECT Id, Part_Number__c, Description__c, On_Hand__c, MFG__c, Physical_OnHand__c FROM Parts_Inventory__c WHERE Id IN: partIds ORDER BY dealer__MFG__c ASC, Part_Number__c ASC];
    }
}