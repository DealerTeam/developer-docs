/**
 * claimController
 * @description
 */
public with sharing class claimController {

    /**
     * @description
     */ 
    public dealer__Claim__c claim {get;set;}

    /**
     * @description
     */
    public list<dealer__Dealer_Location__c> loc =new list<dealer__Dealer_Location__c>();
     
    /**
     * @description
     */
    public Map<String, String> urlParameters = new Map<String, String>();
    
    /**
     * claimController
     * @param  sc 
     * @description
     */ 
    public claimController(ApexPages.StandardController sc) 
    {

        claim = (dealer__Claim__c)sc.getRecord();

        // Set the company
        User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
       list<dealer__Dealer_Location__c> loc = [Select Id, Name, dealer__Company_Number__c from dealer__Dealer_Location__c where dealer__Company_Number__c =:u.Division limit 1];
        if(loc.size()>0)
        {
            claim.dealer__StoreLocation__c = loc[0].Id;
            claim.dealer__CompanyNumber__c = loc[0].dealer__Company_Number__c;
            claim.dealer__ServiceAdvisor__c = UserInfo.getUserId();
        }


        if(ApexPages.currentPage()!=null) {
            urlParameters = ApexPages.currentPage().getParameters();
            for(String p : urlParameters.keySet()) {
                // Allow for Customer and Vehicle to be passed as ID's
                if(p=='customer') {
                    claim.dealer__Customer__c = urlParameters.get(p);
                }
                if(p=='vehicle') {
                    claim.ServiceVehicle__c = urlParameters.get(p);
                }
                if(p.contains('customer_lkid')) {
                    claim.dealer__Customer__c = lookupPersonsAccountId(urlParameters.get(p));
                }
                if(p.contains('vehicle_lkid')) {
                    claim.ServiceVehicle__c = lookupServiceVehicle(urlParameters.get(p));
                }
                if(p=='sro') {
                    claim.ServiceRepairOrder__c = urlParameters.get(p);
                }
            }
        }
    }

    /**
     * save 
     * @return PageReference
     * @description
     */ 
    public PageReference save() 
    {
        
        claim.dealer__Taxable__c = false;

        // If Vehicle Inventory is Present, auto set the Service Vehicle
        if(claim.dealer__InventoryVehicle__c != null && claim.dealer__ServiceVehicle__c == null) {
            dealer__Service_Vehicle__c[] sv = [Select Id, dealer__Last_Odometer__c from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c =:claim.dealer__InventoryVehicle__c limit 1];
            if(sv.size()==1) {
                claim.dealer__ServiceVehicle__c = sv[0].Id;
                if(claim.dealer__CurrentMileage__c == null || claim.dealer__CurrentMileage__c == 0) {
                    claim.dealer__CurrentMileage__c = sv[0].dealer__Last_Odometer__c;
                }
            }
        }

        try {
            insert claim;
            
        } catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
            return null;            
        }

        PageReference claimPage = new ApexPages.StandardController(claim).view();
        claimPage.setRedirect(true);
        return claimPage;
    }

    /**
     * lookupPersonsAccountId 
     * @param  i 
     * @return  Id
     * @description
     */ 
    public Id lookupPersonsAccountId(Id i) 
    {
      // BLL1a handle either account Id *or* contact Id and don't require it to be a person account
      Account[] a = new List<Account>();
      if (Schema.Account.SObjectType == i.getSObjectType()) {
        a = [select Id from Account where Id=:i limit 1];
      } else if (Schema.Contact.SObjectType == i.getSObjectType()) {
        try {
            Contact c = [select Id, AccountId from Contact where Id=:i limit 1];
            a = [select Id from Account where Id=:c.AccountId limit 1];
        } catch(Exception e) {}
      }
      // BLL1a end block
        //Account[] a = [Select Id from Account where PersonContactId =:i or Id=:i limit 1];  // BLL1d
        if(a.size()==0) {
            throw new claimException('Customer Account not found');
        }
        return a[0].Id;
    }  
    
    /**
     * lookupServiceVehicle 
     * @param  i 
     * @return Id
     * @description
     */ 
    public Id lookupServiceVehicle(Id i) 
    {
      // Handle either account Id *or* contact Id and don't require it to be a person account
      dealer__Service_Vehicle__c[] sv = new List<dealer__Service_Vehicle__c>();
      if (Schema.dealer__Service_Vehicle__c.SObjectType == i.getSObjectType()) {
        sv = [select Id, Name from dealer__Service_Vehicle__c where Id=:i limit 1];
      } 
        if(sv.size()==0) {
            throw new ClaimException('Servive Vehicle not found');
        }
        return sv[0].Id;
    } 

    /**
     * claimException
     * @description
     */
    public class ClaimException extends Exception{}     
}