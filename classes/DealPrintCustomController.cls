/**
 * DealPrintCustomController
 * @description
 */
public class DealPrintCustomController {
	
    /**
     * @description
     */
    public DealAPI.Deal dealWrapper {get; private set;}
    
    /**
     * @description
     */
    public double totalPrice {get;set;}
    
    /**
     * @description
     */
    public double totalTax {get;set;}
    
    /**
     * @description
     */
    public Account payorAcct {get;set;}
    
    /**
     * @description
     */
    public String payorPhone {get;set;}
    
    /**
     * @description
     */
    public String phone {get;set;}
    
    /**
     * @description
     */
    public String fax {get;set;}
    
    /**
     * @description
     */
    public String last8 {get;set;}
    
    /**
     * @description
     */
    public String custCell {get; private set;}
    
    /**
     * @description
     */
    public String custPhone {get;set;}
    
    /**
     * @description
     */
    public String dlrPhone {get;set;}
    
    /**
     * @description
     */
    public String dlrFax {get;set;}
  
    /**
     * DealPrintCustomController 
     * @param  controller 
     * @description
     */
    public DealPrintCustomController(ApexPages.StandardController controller)
    {
        Id dealId = ApexPages.currentPage().getParameters().get('id');
        dealWrapper = DealAPI.dealData(dealId);
        
        if(dealWrapper.location.dealer__Main_Phone__c != null)
            dlrPhone =  Utility.formatPhoneTen(dealWrapper.location.dealer__Main_Phone__c);
        
        if(dealWrapper.dealHeader.dealer__Buyer_Mobile_Phone__c != null)
            custCell = Utility.formatPhoneTen(dealWrapper.dealHeader.dealer__Buyer_Mobile_Phone__c);
        

        if(dealWrapper.dealHeader.dealer__Buyer_Home_Phone__c != null)
            custPhone = Utility.formatPhoneTen(dealWrapper.dealHeader.dealer__Buyer_Home_Phone__c);
        
        totalTax = 0;

        if(dealWrapper.dealHeader.dealer__Equipment_Tax__c != null)
            totalTax += dealWrapper.dealHeader.dealer__Equipment_Tax__c;
        
        if(dealWrapper.dealHeader.dealer__Standard_Tax__c != null)
            totalTax += dealWrapper.dealHeader.dealer__Standard_Tax__c ;
    
        totalPrice = 0;

        if (dealWrapper.dealHeader.dealer__Vehicle_Price__c != null )
            totalPrice += dealWrapper.dealHeader.dealer__Vehicle_Price__c ;

        if(dealWrapper.dealHeader.dealer__Conversion_Price__c != null)
            totalPrice += dealWrapper.dealHeader.dealer__Conversion_Price__c ;	

        if(dealWrapper.dealheader.dealer__Deferred_1_Payee__c != null ) {
            Id i = Id.valueOf(dealWrapper.dealheader.dealer__Deferred_1_Payee__c);
            payorAcct = setPayorAccount(i);
            if(payorAcct.Phone!=null){
                payorPhone = Utility.formatPhoneTen(payorAcct.Phone);
            }              
        }

      
 

    }

     public Account setPayorAccount(Id pId){
        List<Account> acc = new List<Account>();
        Account pAcct = new Account();
        acc = [SELECT Id, Name, FirstName, LastName, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingAddress, Phone, Fax FROM Account WHERE Id =: pId ];
            if(acc.size() == 1){
                pAcct = acc[0];
            }
        return pAcct;

    }

    

        public class dealFormException extends Exception{}
}