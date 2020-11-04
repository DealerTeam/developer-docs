public with sharing class SalesUp_EXT {
    
    public String searchLeadVehicleMake {get;set;}
    public String searchLeadVehicleModel {get;set;}
    public List<dealer__Sales_Up__c> uplist {get;set;}
    
    Event datePickerSup = new Event();
    public Event getProxyDate() { return datePickerSup; }   
    
    private final List<dealer__Sales_Up__c> up;
    public SalesUp_EXT(ApexPages.standardSetController controller) {
        this.up = controller.getSelected();
    }
    
    public String soqlDateFormat(Date dte) {
        return String.valueOf(dte);
    }
    
    public PageReference searchUps() {
        System.debug(datePickerSup);
        String soql = 'Select d.Name, d.Id, d.dealer__Year_To__c, d.dealer__Year_High__c, d.dealer__Model__c, d.dealer__Make__c, d.dealer__Lead_Type__c, d.dealer__Lead_Status__c, d.dealer__Desired_Stock_Num__c, d.CreatedDate, d.dealer__Color_Preference_Ext__c, d.dealer__Co_Buyer_Contact__c, d.dealer__Buyer_Contact__c  From dealer__Sales_Up__c d where Name != null ';            
        String queryPlug = '';
        if(searchLeadVehicleMake.length()>0) { queryPlug += queryPlug+' and d.dealer__Make__c = \''+String.escapeSingleQuotes(searchLeadVehicleMake)+'\''; }
        if(searchLeadVehicleModel.length()>0) { queryPlug += queryPlug+' and d.dealer__Model__c = \''+String.escapeSingleQuotes(searchLeadVehicleModel)+'\''; }
        if(datePickerSup.Custom_Search_Start_Date__c != null && datePickerSup.Custom_Search_End_Date__c != null) { 
                queryPlug += 'and d.dealer__Lead_Date__c >= '+soqlDateFormat(datePickerSup.Custom_Search_Start_Date__c)+' and d.dealer__Lead_Date__c <= '+soqlDateFormat(datePickerSup.Custom_Search_End_Date__c); 
        }
            
        soql += queryPlug;
        soql += ' and (d.dealer__Lead_Status__c != \'Drop\' and  d.dealer__Lead_Status__c != \'Sold\' and d.dealer__Lead_Status__c != \'Bought Elsewhere\' ) order by d.CreatedDate desc limit 1000';
                    
        System.debug(soql);
        uplist = Database.query(soql);
                                    
        return null;                
        
    }
    
    
}