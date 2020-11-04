public with sharing class CreditApplicationControlHandler {
    public static void validate(List<Credit_Application__c> triggerNew)
    {
        for(Credit_Application__c app : triggerNew){
            System.assert(app.Sales_Up__c != null,'A Sales Up is required to start a Credit Application');
        }
    }

    public static void setName(List<Credit_Application__c> triggerNew)
    {
        for(Credit_Application__c app : triggerNew){
            String nameStr = '';
            if(app.ApplicationType__c == 'Business' || app.ApplicationType__c == 'Business w/Co-Applicant'){
                nameStr = app.BusinessTradeName__c == null ? app.Business_Name__c : app.BusinessTradeName__c;
            } else {
                String fname = app.First_Name__c != null ? app.First_Name__c : '';
                String lname = app.Last_Name__c != null ? ' '+app.Last_Name__c : '';
                nameStr = fname+lname;
            }
            app.Name = nameStr + ' - ' +Date.today().format();
        }
    }
}