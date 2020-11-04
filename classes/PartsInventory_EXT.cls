/**
 * Date            |Developer            |Work#
 * Notes
 * --
 * 2016.07.13      |David Ray            |215
 * Adding support for Product Tax Code for each line of a part kit to have taxes calculated individually
 *
 * 2016.07.20       |Jarrett Kuljis     |000427
 * Manual adjustments failed if Cost adjustments are performed first.
 *
 * 2016-08-27       |Jarrett Kuljis     |W-000503
 * Create a VF interface to the part inventory record.  Add support for rendering button dissabled if they user does not have access to the function.
 * 
 * 2016-11-21       |Jarrett Kuljis     |W-000592
 * Save method was only inserting records, was not updating based on the status of the sObject
 * 
 * 2016-11-24       |Sneha Utture     |W-000592
 * Created a VF pageReference method(returnToPart) to return from part's management to part.
 * 
 * 2016-11-25       |Gaurav Agrawal   |W-000321
 * Made changes into save method to sync Parent Part Master's Manufacturer to Part's MFG
 */
public with sharing class PartsInventory_EXT {
    
    public String reasonforchange {get;set;}
    public Boolean onHandFlag {get;set;}
    public dealer__Parts_Inventory__c inventoryRecord {get;set;}
    public dealer__Parts_Master__c pm {get;set;}
    public FixedOperationsSettings__c myFixedOperationsSettings { 
        get {
            return FixedOperationsSettings__c.getInstance();
        }
    }

    public PartInventoryAPI partAPI {get;private set;}

    public PartsInventory_EXT(ApexPages.standardController controller) {

        inventoryRecord = (dealer__Parts_Inventory__c)controller.getRecord();
        setPartAPI();
        // Set Dealership Location by Default User Selection    
        if (inventoryRecord.Location__c == null) {
            inventoryRecord.Location__c = dealer.Utility.lookupUserLocation();
        } 

        // If Master is Defined Pre-Populate Values
        if(inventoryRecord.dealer__Parts_Master__c!=null) {
             pm = [Select Id, Name, dealer__Part_Description__c, dealer__Cost__c, dealer__Retail_Price__c, dealer__Part_No_Display__c, dealer__Weight__c, dealer__Warranty_Price__c,
                    dealer__Jobber_Price__c, dealer__Pack_QTY__c, dealer__Core_Value__c, dealer__Core_Required__c, dealer__Manufacturer__c,dealer__Product_Tax_Code__c, dealer__Catalog_Image__c 
                    from dealer__Parts_Master__c 
                    where Id=:inventoryRecord.dealer__Parts_Master__c limit 1];

            
            inventoryRecord.Name  =   pm.Name;
            if(inventoryRecord.Description__c == null)      {   inventoryRecord.Description__c      =   pm.dealer__Part_Description__c; }
            if(inventoryRecord.Cost__c==null)               {   inventoryRecord.Cost__c             =   pm.dealer__Cost__c; }
            if(inventoryRecord.List__c==null)               {   inventoryRecord.List__c             =   pm.dealer__Retail_Price__c; }
            if(inventoryRecord.Entry_Date__c ==null)        {   inventoryRecord.Entry_Date__c       =   Date.today(); }
            if(inventoryRecord.Jobber__c ==null )           {   inventoryRecord.Jobber__c           =   pm.dealer__Jobber_Price__c; }
            if(inventoryRecord.MFG__c == null)              {   inventoryRecord.MFG__c              =   pm.dealer__Manufacturer__c; }
            if(inventoryRecord.Product_Tax_Code__c == null) {   inventoryRecord.Product_Tax_Code__c =   pm.Product_Tax_Code__c; }
        }
    }

    public void setPartAPI(){
        if(partAPI == null){
            partAPI = new PartInventoryAPI();
        }
    }
    
    /**
     * getPartHistory
     * @return List<dealer__Part_Inventory_History__c>
     * @notes returns a list of the inventory history records for this part
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public List<dealer__Part_Inventory_History__c> getPartHistory() {
        setPartAPI();
        return partAPI.getPartHistory(inventoryRecord.Id);
    }

    /**
     * getPartLedger
     * @return List<dealer__Parts_Ledger__c>
     * @notes get the list of ledger entries for the part record.
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public List<dealer__Parts_Ledger__c> getPartLedger() {
        setPartAPI();
        return partAPI.getPartLedger(inventoryRecord.Id);
    }

    /**
     * partManagment - redirects the user to the part management page
     * @return PageReference
     * @notes Performs page redirect to send the user to the parts management page
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public PageReference partManagement() {
        PageReference pm = Page.PartQTYAdjust;
        pm.getParameters().put('id', inventoryRecord.Id);
        pm.setRedirect(true);
        return pm;
    }

    public PageReference partPrintLabel() {
        PageReference pm = Page.DYMOLabelPrint;
        pm.getParameters().put('id', inventoryRecord.Id);
        pm.setRedirect(true);
        return pm;        
    }    

    public PageReference cancel() {
        PageReference cancelTab = new PageReference('/'+dealer__Parts_Inventory__c.sobjecttype.getDescribe().getKeyPrefix()+'/o');
        cancelTab.setRedirect(true);
        return cancelTab;
    }

    /**
     * validateReasonForChange - validate 'Reason for Change' field must have value.
     * @returns boolean - true if reasonforchange is blank
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public boolean validateReasonForChange()
    {
            if(String.isBlank(reasonforchange)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter value in Reason for Change field'));
            return true;
        }
        return false;

    }

    /**
     * adjustCost - Performs cost adjustment on the part record
     * @return PageReference
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public PageReference adjustCost() {

        List<Part_Inventory_History__c> historyList = new List<Part_Inventory_History__c>();

        dealer__Part_Inventory_History__c p = new dealer__Part_Inventory_History__c(
                                                        dealer__Part__c=inventoryRecord.Id,
                                                        dealer__Transaction_Event__c='Manual Cost Adjustment',
                                                        dealer__Transaction_Time__c=Datetime.now(),
                                                        dealer__Cost__c=inventoryRecord.dealer__Cost__c,
                                                        dealer__Quantity_Adjustment__c=0,
                                                        dealer__Event_Notes__c=reasonforchange
                                            );
        historyList.add(p);
        try {
            setPartAPI();
            partAPI.makeAdjustment(historyList);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to adjust the Cost of this inventory record: '+e.getMessage()));
            return null;
        }

        // To-Do : Apply to GL Asynchronously. 

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Cost Adjusted'));
        return null;
    }

    /**
     * adjustOrder - Performs order adjustment on the part record
     * @return PageReference
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public PageReference adjustOrder() {

        List<Part_Inventory_History__c> historyList = new List<Part_Inventory_History__c>();

        dealer__Part_Inventory_History__c p = new dealer__Part_Inventory_History__c(
                                                        dealer__Part__c=inventoryRecord.Id,
                                                        dealer__Transaction_Event__c='Manual on Order Adjustment',
                                                        dealer__Transaction_Time__c=Datetime.now(),
                                                        dealer__Quantity_Adjustment__c=inventoryRecord.dealer__On_Order__c,
                                                        dealer__Event_Notes__c=reasonforchange
                                            );
        historyList.add(p);
        try {
            setPartAPI();
            partAPI.makeAdjustment(historyList);

        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to adjust the order of this inventory record: '+e.getMessage()));
            return null;
        }

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Order Adjusted'));
        return null;
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

        List<Part_Inventory_History__c> historyList = new List<Part_Inventory_History__c>();
        /* Record the part history */
        dealer__Part_Inventory_History__c p = new dealer__Part_Inventory_History__c(
                    dealer__Part__c=inventoryRecord.Id,
                    dealer__Transaction_Event__c='Manual On Hand Adjustment',
                    dealer__Transaction_Time__c=Datetime.now(),
                    dealer__Quantity_Adjustment__c=inventoryRecord.On_Hand__c,
                    dealer__Event_Notes__c= onHandFlag ==true ? 'GL not updated per User.' : reasonforchange,
                    dealer__Cost__c= null);
        historyList.add(p);
        try{
            setPartAPI();
            partAPI.adjustOnHand(historyList, !onHandFlag);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to adjust the on hand of this inventory record: '+e.getMessage()));
            return null;
        }

        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'On Hand Adjusted'));
        return null;
    }

    /**
     * save
     * @return PageReference
     * @notes Overloaded save method on standard object Parts_Inventory__c.
     * @test PartPhysicalInventoryUILayer.testPIEXT
     */
    public PageReference save() {

        if(inventoryRecord.dealer__Part_No__c==null) {
            inventoryRecord.dealer__Part_No__c='OT:'+inventoryRecord.Name;
        }
        
        /*W-000321 Begin*/
        
        //Condition to check whether its Part Master is not null
        if(inventoryRecord.dealer__Parts_Master__c != null){
            //Query the Part Master and assign Part Master's manufacturer to Part's MFG
            inventoryRecord.dealer__MFG__c = [SELECT Id, dealer__Manufacturer__c FROM dealer__Parts_Master__c WHERE Id =: inventoryRecord.dealer__Parts_Master__c].dealer__Manufacturer__c;
        }
        /*W-000321 End*/
        
        try {
            if(inventoryRecord.Id==null) { //W-000592
                insert inventoryRecord;
            } else {
                update inventoryRecord;
            }
        } catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));  
            return null;
        }
        
        PageReference partPage = new ApexPages.Standardcontroller(inventoryRecord).view();
        partPage.setRedirect(true);
        return partPage;
    }

    public Boolean getisPartManagementAccessible() {
        return Utility.pageAccess('PartQTYAdjust');
    }
    
    // W-000592
    public PageReference returnToPart() {
        PageReference cancelTab = new PageReference('/'+inventoryRecord.Id);
        cancelTab.setRedirect(true);
        return cancelTab;
    }
    
    @remoteAction
    public static List<dealer__Parts_Inventory__c> searchExistingParts(String pn) {
        if(pn.length() < 2) { return null; }
        return [Select Id, Name from dealer__Parts_Inventory__c where Name = :pn limit 1];
    }
    
    @remoteAction
    public static List<dealer__Parts_Master__c> partsMasterSearch(String pn) {
        if(pn.length() < 2) { return null; }
        return [Select Id, Name, dealer__Part_Description__c, dealer__Cost__c, dealer__Retail_Price__c, dealer__Part_No_Display__c, dealer__Weight__c, dealer__Warranty_Price__c,
                    dealer__Jobber_Price__c, dealer__Pack_QTY__c, dealer__Core_Value__c, dealer__Core_Required__c ,dealer__Product_Tax_Code__c 
                    from dealer__Parts_Master__c 
                    where Name =:pn limit 1];
    }
}