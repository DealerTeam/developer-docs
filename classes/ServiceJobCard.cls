/**
* Date            |Developer            |Work#
* Notes
* --------------------------------------------------------------------------------------------

*2016.10.13       |Sneha                |Case#00002116
*   Made List of Service Repair Order transient and made declaration of User list in getTechsList method
*
*/

public with sharing class ServiceJobCard {

    ////Case#00002116 - techId not used in VF page so no need to declare public
    //public Id techId {get;set;}
    //Case#00002116 declared transient
    public transient List<dealer__Service_Repair_Order__c> ros = new List<dealer__Service_Repair_Order__c>();    
    public String selectedTech {get;set;}
    public Date Today { get { return Date.today(); }}
    
    /*
     * Controller 
     */
    public ServiceJobCard() {
        Id techId = ApexPages.currentPage().getParameters().get('techId');
        if(techId!=null){
          selectedTech = String.valueOf(techId);
          ros = getRepairOrderList();            
        } 
    }
    
    /*
     * getRepairOrderList - 
     */
    public List<dealer__Service_Repair_Order__c> getRepairOrderList() {
        List<Id> roList = new List<Id>();
        List<dealer__Service_Job__c> jobs = [Select Id, dealer__Repair_Order_Id__c 
                                                from dealer__Service_Job__c 
                                                where dealer__Technician__c=:selectedTech 
                                                and dealer__RO_Status__c = 'Open'
                                                and dealer__Stat__c = 'Open'                                               
                                                limit 1000];
        //System.debug('TID: '+selectedTech+' Jobs='+jobs);
        for(dealer__Service_Job__c j : jobs) {
            roList.add(j.dealer__Repair_Order_Id__c); 
        }
        
        // Location and Inventory Status are missing, needed, but due to versioning could not be included.
        List<dealer__Service_Repair_Order__c> roItems = [Select d.dealer__VIN__c, d.dealer__Vehicle__r.dealer__Status_Code__c, d.dealer__Vehicle__r.dealer__Sale_Date__c,
                                                         d.dealer__Vehicle__r.dealer__Ext_Color__c, d.dealer__Location__c,
                                                         d.dealer__Tag__c, d.dealer__Status__c, d.dealer__Vehicle__r.dealer__Stock_Number__c,
                                                         d.dealer__Service_Advisor__c, d.dealer__Recommendations__c, d.dealer__RO_Number__c, 
                                                         d.dealer__Posted_Date_Time__c, d.dealer__Open_Job_Lines__c, d.dealer__Mileage_In__c,d.dealer__Days_Down__c, Customer_Contact__r.Name,
                                                         d.dealer__Customer_Labor_Charges__c, d.dealer__Customer_Contact__c, d.dealer__Comments__c, 
                                                         d.Name, d.Id, d.dealer__Promise_Date__c, d.dealer__Promise_Time__c, d.dealer__Waiting__c, 
                                                         (Select Id, Name, dealer__Cause__c, dealer__CauseExtended__c,dealer__CustomerConcern__c, dealer__Concern__c, dealer__Correction__c, 
                                                                        dealer__Line_Number__c, dealer__Op_Code__c, dealer__Standard_Operation_Code__c, 
                                                                        dealer__Stat__c, dealer__Job_Added_Date__c, dealer__Operation_Code_Description__c,
                                                                  dealer__Technician__c
                                                                        From dealer__Job_Lines__r) 
                                                         From dealer__Service_Repair_Order__c d
                                                         where d.Id in:roList
                                                         and dealer__Location__c = 'Main Shop' 
                                                         order by d.dealer__Promise_Date__c ASC NULLS LAST, 
                                                         d.dealer__Waiting__c DESC NULLS LAST,
                                                         d.CreatedDate ASC NULLS LAST
                                                         limit 1000];
        System.debug('Generation of RO List '+roItems);
        
        return roItems;
    }
    
    /*
     * getTechList  
     */
    public List<SelectOption> getTechsList() {
        List<SelectOption> techList = new List<SelectOption>();

        
        //Case#00002116
        List<User> techs = new List<User>();
        techs = [Select Id, Name from User where dealer__Technician__c=true order by Name ASC limit 200];
        for(User u : techs) {
            techList.add(new SelectOption(u.Id, u.Name));
        }
        return techList;
    }
    
    /*
     * getRepairOrders
     */
    public List<dealer__Service_Repair_Order__c> getRepairOrders() {
        //System.debug('GetRepairOrders Called '+ros);
        return ros;
    }
    
    /*
     * compileReport
     */
    public PageReference compileReport() {
        //System.debug('Technician ID Selected: '+selectedTech);
        ros = getRepairOrderList();
        return null;
    }
}