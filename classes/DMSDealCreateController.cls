/**
 * DMSDealCreateController
 * @description
 */
public with sharing class DMSDealCreateController {
    
    /**
     * create 
     * @param  recordId 
     * @return String
     * @description
     */ 
    @AuraEnabled
    public static String create(String recordId)
    { 
        Sales_Up__c sup = (Sales_Up__c)Utility.queryAllFields('dealer__Sales_Up__c',recordId);
       
       //Validation
        if(sup.Car_Deal__c != null) throw new AuraHandledException('A Deal already exists for this Record.');
        if(sup.Store_Location__c == null) throw new AuraHandledException('This Record does not have a location set. Please set a location and try again.');

        Vehicle_Inventory__c desiredVehicle = sup.Desired_Stock_Num__c	 != null ? (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c',sup.Desired_Stock_Num__c	)  : new Vehicle_Inventory__c();
        Account buyerAccount = sup.Customer_Account__c != null ? (Account)Utility.queryAllFields('Account',sup.Customer_Account__c) : new Account();
        Contact buyerContact = sup.Buyer_Contact__c != null ? (Contact)Utility.queryAllFields('Contact',sup.Buyer_Contact__c) : new Contact();
        Contact coBuyerContact = sup.Co_Buyer_Contact__c != null ? (Contact)Utility.queryAllFields('Contact',sup.Co_Buyer_Contact__c) : new Contact();
        Account coBuyerAccount = sup.Co_Buyer__c != null ? (Account)Utility.queryAllFields('Account',sup.dealer__Co_Buyer__c) : new Account();
        Dealer_Location__c location = sup.Store_Location__c != null ? (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c',sup.Store_Location__c) : new Dealer_Location__c();
        Request request = new Request(sup,desiredVehicle,buyerAccount,buyerContact,coBuyerAccount,coBuyerContact,location);
        
        // URL Sandbox || Production
        String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');

        // If Test isrunning 
        if(Test.isRunningTest()) { return null; }

        Response response = (Response)JSON.deserialize(EnterpriseControllerAPI.CallOut(baseUrl+'/dealerstar/createdeal', JSON.serialize(request)), Response.class);
        
        if(response.DealId != null){
            Deal__c deal = new Deal__c(Name=response.DealId,Sales_Lead__c = sup.Id, Deal_ID__c = response.DealId);
            Insert deal;
            sup.Car_Deal__c = deal.Id;
            update sup;
        }
        return JSON.serializePretty(response);
        
    }
    
    /**
     * getDetails 
     * @param  recordId 
     * @return string
     */ 
    @AuraEnabled
    public static string getDetails(String recordId)
    {
        Sales_Up__c sup = [SELECT Name, Store_Location__r.Name, Customer_Account__r.Name, Desired_Stock_Num__r.Stock_Number__c FROM Sales_Up__c WHERE Id =: recordId];
        return JSON.serializePretty(new Details(sup.Name, sup.Customer_Account__r.Name, sup.Desired_Stock_Num__r.Stock_Number__c == null ? '' : sup.Desired_Stock_Num__r.Stock_Number__c, sup.Store_Location__r.Name));
    }
    
    /**
     * @description
     */
    public class Response{
        @AuraEnabled
        Public String Url;
        @AuraEnabled
        Public String DealId;
        @AuraEnabled
        Public String Error;
        public Response(String url, String dealId, String error){
            this.Url = url;
            this.DealId = dealId;
            this.Error = error;
        }
    }
    
    /**
     * @description
     */
    public class Details{
        Public String SupName;
        Public String CustomerName;
        Public String StockNumber;
        Public String Company;

        public Details(String supName, String customerName, String stockNumber, String company){
            this.SupName = supName;
            this.CustomerName = customerName;
            this.StockNumber = stockNumber;
            this.Company = company;
        }
    }
    
    /**
     * @description
     */
    public class Request{
        public Sales_Up__c SalesUp;
        public Vehicle_Inventory__c DesiredVehicle;
        public Account BuyerAccount;
        public Contact BuyerContact;
        public Account CoBuyerAccount;
        public Contact CoBuyerContact;
        public Dealer_Location__c Location;
        public Request(Sales_Up__c salesUp, Vehicle_Inventory__c desiredVehicle, Account buyerAccount, Contact buyerContact, Account coBuyerAccount, Contact coBuyerContact, Dealer_Location__c location){
            this.SalesUp = salesUp;
            this.DesiredVehicle = desiredVehicle;
            this.BuyerAccount = buyerAccount;
            this.BuyerContact = buyerContact;
            this.CoBuyerAccount = coBuyerAccount;
            this.CoBuyerContact = coBuyerContact;
            this.Location = location;
        }
    }
}