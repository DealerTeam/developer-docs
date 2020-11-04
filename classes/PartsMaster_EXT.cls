public with sharing class PartsMaster_EXT {

    public String newPartNumber {get;set;}
    
    public dealer__Parts_Master__c master;
    
    public PartsMaster_EXT(ApexPages.standardController controller){
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Parts_Master__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {       
            controller.addFields(af);
        }        
        master = (dealer__Parts_Master__c)controller.getRecord();
    }
    
    /**
     * Handle saving Parts Master record
     * @test PartPhysicalInventoryUILayer.testPartsMasterEXT
     */
    public PageReference save() {
        
        if(master.dealer__Manufacturer__c==null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Manufacturer must be selected'));
                return null;
        }
        
        master.dealer__Raw_Part_Number__c = String.valueOf(master.Name).replace('-', '');
        master.dealer__Part_No__c = master.dealer__Manufacturer__c+':'+master.Name;
        master.dealer__Price_Tape_Date__c=Date.today();

        try {
            insert master;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating Part Master Entry: '+e.getMessage()));
            return null;             
        }
        
        
        PageReference partPage = new ApexPages.Standardcontroller(master).view();
        partPage.setRedirect(true);
        return partPage;
    }

    /**
    *   
    *   Supercede Part Number - v.1.438
    *   
    *   @method to update an existing part and its related inventories to the superceded part number
    * @test PartPhysicalInventoryUILayer.testPartsMasterEXT
    */
    public PageReference supercede() {  

        if(newPartNumber==null || newPartNumber=='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Superceded Part Number must be specified.'));
            return null;            
        }

        // See if the Master already contains that part#
        String newPKey = master.dealer__Manufacturer__c+':'+newPartNumber;
        String oldName = master.Name;
        
        dealer__Parts_Master__c[] pExists = [Select Id from dealer__Parts_Master__c where dealer__Part_No__c =:newPKey limit 1];

        if(pExists.size()>0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, newPKey+' already exsits in the Parts Master.'));
            return null;              
        }

        try {

        List<dealer__Parts_Inventory__c> inventory = [Select Id, dealer__MFG__c, dealer__Location__r.dealer__Company_Number__c from dealer__Parts_Inventory__c where dealer__Parts_Master__c =:master.Id limit 2000 for update];
        master.dealer__Part_No__c = newPKey;
        master.Name = newPartNumber;
        master.dealer__Raw_Part_Number__c = master.Name.replaceAll('[^a-zA-Z0-9]', '');

        List<dealer__Parts_Inventory__c> invUpdate = new List<dealer__Parts_Inventory__c>();
        dealer__PartSupersession__c supersession = new dealer__PartSupersession__c(
                                                            dealer__Parts_Master__c=master.Id,
                                                            dealer__Old_Part__c=oldName
                                                       );

        for(dealer__Parts_Inventory__c i : inventory) {
            i.dealer__Part_No__c = i.dealer__Location__r.dealer__Company_Number__c+':'+i.dealer__MFG__c+':'+newPartNumber;
            i.Name = i.dealer__MFG__c+':'+newPartNumber;
            i.dealer__Company_Number__c = i.dealer__Location__r.dealer__Company_Number__c;
            i.dealer__Supersedes__c = oldName;
            invUpdate.add(i);
        }

        update master;
        if(invUpdate.size()>0) {
            update invUpdate;
        }
        insert supersession;

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error applying supersession: '+e.getMessage()));
            return null;             
        }

        return new ApexPages.standardController(master).view();
    }
    
    public class PartsMasterException extends Exception{}
    
}