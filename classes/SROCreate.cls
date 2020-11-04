/**
 *
 *  SROCreate - Visualforce Page Custom Controller
 *
 */
public with sharing class SROCreate {

    public dealer__Service_Repair_Order__c sro {get;set;}
    public list<dealer__Dealer_Location__c> loc =new list<dealer__Dealer_Location__c>();     
    public Map<String, String> urlParameters = new Map<String, String>();

    /**
     *
     * SROCreate constructor
     *
     */
    public SROCreate(ApexPages.StandardController sc) {

        sro = (dealer__Service_Repair_Order__c)sc.getRecord();

        // Set the company
        User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
        list<dealer__Dealer_Location__c> loc = [Select Id, Name, dealer__Company_Number__c from dealer__Dealer_Location__c where dealer__Company_Number__c =:u.Division limit 1];
        if(loc.size()>0)
        {
            sro.dealer__Company__c = loc[0].Id;
            sro.dealer__Company_Number__c = loc[0].dealer__Company_Number__c;
            sro.dealer__Service_Advisor__c = UserInfo.getUserId();
        }


        if(ApexPages.currentPage()!=null) {
            urlParameters = ApexPages.currentPage().getParameters();
            for(String p : urlParameters.keySet()) {
                // Allow for Customer and Vehicle to be passed as ID's
                if(p=='customer') {
                    sro.dealer__Customer__c = urlParameters.get(p);
                }
                if(p=='vehicle') {
                    sro.dealer__Vehicle__c = urlParameters.get(p);
                }
                if(p.contains('_lkid')) {
                    Id lkId = urlParameters.get(p);
                    if(lkId.getSObjectType() == Schema.dealer__Vehicle_Inventory__c.SObjectType ){
                         lookupVehicleInventory(lkId);
                    }
                    else if(lkId.getSobjectType() == Schema.Account.SObjectType || lkId.getSobjectType() == Schema.Contact.SObjectType){
                        sro.dealer__Customer__c = lookupPersonsAccountId(urlParameters.get(p));
                    }
                }
            }
        }
    }

    public PageReference save() {
        
        sro.dealer__Taxable__c = false;

        // If Vehicle Inventory is Present, auto set the Service Vehicle
        if(sro.dealer__Vehicle_Inventory__c != null && sro.dealer__Vehicle__c == null) {
            dealer__Service_Vehicle__c[] sv = [Select Id, dealer__Last_Odometer__c from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c =:sro.dealer__Vehicle_Inventory__c limit 1];
            if(sv.size()==1) {
                sro.dealer__Vehicle__c = sv[0].Id;
                if(sro.dealer__Mileage_In__c == null || sro.dealer__Mileage_In__c == 0) {
                    sro.dealer__Mileage_In__c = sv[0].dealer__Last_Odometer__c;
                }
            }
        }

        try {
            insert sro;
            
        } catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
            return null;            
        }

        PageReference roPage = new ApexPages.StandardController(sro).view();
        roPage.setRedirect(true);
        return roPage;
    }

    public Id lookupPersonsAccountId(Id i) {
      // BLL1a handle either account Id *or* contact Id and don't require it to be a person account
      Account[] a = new List<Account>();
      if (Schema.Account.SObjectType == i.getSObjectType()) {
        a = [select Id from Account where Id=:i limit 1];
      } 
      else if (Schema.Contact.SObjectType == i.getSObjectType()) {
        try {
            Contact c = [select Id, AccountId from Contact where Id=:i limit 1];
            a = [select Id from Account where Id=:c.AccountId limit 1];
        } catch(Exception e) {
            if(a.size()==0) {
                throw new ROCreateException('Customer Account not found');
            }
        }
      }
        
        return a[0].Id;
    }

    //Set related fields when SRO is created from a vehicle inventory record 
    public void lookupVehicleInventory(Id i){
        List<Vehicle_Inventory__c> vi = [SELECT Id, Service_Vehicle__c, Mileage__c FROM Vehicle_Inventory__c WHERE Id =: i LIMIT 1];
        if(vi.size() > 0){
            sro.Vehicle_Inventory__c = vi[0].Id != null ? vi[0].Id: sro.Vehicle_Inventory__c;
            sro.Vehicle__c = vi[0].Service_Vehicle__c != null ? vi[0].Service_Vehicle__c : sro.Vehicle__c;
            sro.Mileage_In__c = vi[0].Mileage__c != null ? vi[0].Mileage__c : sro.Mileage_In__c;
        }

    }  

    public class ROCreateException extends Exception{}     
}