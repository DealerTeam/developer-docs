/**
 * DealPaymentPDFControl
 * @description
 */
public with sharing class DealPaymentPDFControl {

    /**
     * @description
     */
    public dealer__Dealer_Location__c userLoc {get;set;}
    
    /**
     * @description
     */
    public dealer__Cashering__c objCashering{get;set;}
    
    /**
     * @description
     */
    public DateTime invoiceTime {get;set;}
    
    /**
     * @description
     */
    public dealer__Deal__c objDeal {get;set;}
    
    /**
     * @description
     */
    public String InvoiceLogo {get; set;}

    /**
     * DealPaymentPDFControl 
     * @param  controller 
     * @description
     */
    public DealPaymentPDFControl(ApexPages.StandardController controller) 
    {
    
        if(ApexPages.currentPage().getParameters().get('id') != null){
        
            objCashering = [SELECT Id, Name, dealer__Amount__c, dealer__Close_Date__c, dealer__Company_Number__c, dealer__Credit_Card_Authorization_Code__c, 
                            dealer__Customer__c, dealer__Customer__r.Name,dealer__Customer__r.IsPersonAccount, dealer__Customer__r.PersonMailingStreet, 
                            dealer__Customer__r.PersonMailingCity, dealer__Customer__r.PersonMailingState, dealer__Customer__r.PersonMailingPostalCode, 
                            dealer__Customer__r.BillingStreet, dealer__Customer__r.BillingCity, dealer__Customer__r.BillingState, dealer__Customer__r.Phone,
                            dealer__Customer__r.PersonMobilePhone, dealer__Customer__r.PersonEmail,dealer__Customer__r.BillingPostalCode,dealer__Deposit__c,
                            dealer__Parts_Invoice__c, dealer__Payment_Method__c, dealer__Rental_Agreement__c, dealer__Service_Repair_Order__c, 
                            dealer__Payment_Receipt_Details__c, dealer__Deal__r.Name, dealer__Deal__c, dealer__Parts_Invoice__r.Name,
                            dealer__Service_Repair_Order__r.Name, dealer__Rental_Agreement__r.Name
                            FROM dealer__Cashering__c WHERE ID =: ApexPages.currentPage().getParameters().get('id')];
            
            if(objCashering.dealer__Deal__c != null){

                objDeal = [SELECT Id, Name, dealer__Vehicle__c,  dealer__Vehicle__r.dealer__VIN__c, dealer__Vehicle__r.dealer__Year__c, dealer__Vehicle__r.dealer__Make__c, 
                           dealer__Vehicle__r.dealer__Conversion_Model__c, dealer__Conversion_Manufacturer__c, dealer__Vehicle__r.dealer__Stock_Number__c, 
						   dealer__Store_Location__c 
                           FROM dealer__Deal__c
              			   WHERE ID =: objCashering.dealer__Deal__c];
                                

              	if(objDeal.dealer__Store_Location__c  != null){   

                    userLoc = [select Id, Name, dealer__Address__c, dealer__Street__c, dealer__City__c, dealer__Company_Number__c, dealer__Main_Phone__c, dealer__Postal_Code__c, 
                               dealer__State__c, dealer__Website__c, dealer__Company_Contracting_Name__c  
                               FROM dealer__Dealer_Location__c WHERE Id =: objDeal.dealer__Store_Location__c];                 
                }

                InvoiceLogo = DealPaymentPDFControl.logo_url(objDeal.dealer__Store_Location__c);
              
            }      
            
            invoiceTime = System.Now();
            
        }        
    }
    
    /**
     * logo_url 
     * @param  locationId 
     * @return String
     * @description
     */
    private static String logo_url(Id locationId) 
    {
		if(locationId==null) {
			return '';
		}
        system.debug(locationId);
        return DealershipLocationAPI.formLogoURL(locationId);
	}

    /**
     * getprintDateTime 
     * @return string
     * @description
     */
    public string getprintDateTime() 
    { 
        datetime dt = datetime.now();
        return dt.format('MM/dd/yyyy HH:mm a');        
    }           

}