/**
 * cashierPageController
 * @description
 */
global with sharing class cashierPageController {
    
    /**
     * @description
     */ 
    global dealer__Cashering__c cashierRecord {get;set;} 
    
    /**
     * @description
     */ 
    global String logoUrl {get;set;}
    
    /**
     * @description
     */ 
    global Dealer_Location__c location {get;set;}
    
    /**
     * @description
     */ 
    global Account customer {get;set;}

    /**
     * cashierPageController 
     * @param  sc 
     * @return    
     * @description
     */ 
    global cashierPageController(ApexPages.standardController sc) 
    {
        String cashierRecordId = sc.getRecord().Id; 

        System.debug(cashierRecordId);
        List<dealer__Cashering__c> cashierRecords = [SELECT Id, dealer__Deposit__c, dealer__Amount__c, dealer__Close_Date__c, dealer__Location__c, 
                                    Name, dealer__Payment_Method__c, dealer__Customer__c  
                                    FROM dealer__Cashering__c];
        System.debug(cashierRecords);
        this.cashierRecord = [ SELECT Id, dealer__Deposit__c, dealer__Amount__c, dealer__Close_Date__c, dealer__Location__c, 
                                    Name, dealer__Payment_Method__c, dealer__Customer__c  
                                    FROM dealer__Cashering__c 
                                    WHERE Id =: cashierRecordId ];
        this.logoUrl = getLogo();
        List<Dealer_Location__c> locList = queryLocation(cashierRecord.dealer__Location__c);
        List<Account> customerList = queryAccount(cashierRecord.dealer__Customer__c);
        if ( locList.size() > 0 ) this.location = locList[0];
        if ( customerList.size() > 0 ) this.customer = customerList[0];
    }

    /**
     * getLogo 
     * @return  String
     * @description 
     */ 
    global String getLogo() 
    {
        Document[] doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
        if(doc.size()!=0) {
            String imageId = doc[0].Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;        
        }
        return '';
    }

    /**
     * queryLocation
     * @param  locId 
     * @return List<Dealer_Location__c>
     * @description     
     */ 
    global List<Dealer_Location__c> queryLocation(Id locId) 
    {
        return [SELECT BAR_Number__c, City__c, Company_Number__c, EPA_Number__c, Email__c, General_Manager__c, Internal_Labor_Rate__c, Main_Phone__c, Open_Hour__c, Service_Director__c, 
                    Service_Invoice_Disclaimer__c, Service_RO_Disclaimer__c, State__c, Postal_Code__c,
                    Tax_ID__c, Tax_Local_Rate__c, Tax_Parts__c, Tax_Service__c, Website__c, Location_Account__c, BDC_Director__c,
                        Company_Contracting_Name__c,
                        Location_Account__r.Name,
                        BDC_Director__r.Name,
                        Service_Director__r.Name,
                        General_Manager__r.Name,
                    Street__c, Name, Id,
                    Service_Estimate_Disclaimer__c 
                    FROM Dealer_Location__c
                    WHERE Id=:locId];       
    } 

    /**
     * queryAccount 
     * @param  acctId 
     * @return  List<Account>  
     * @description    
     */
    global List<Account> queryAccount(Id acctId) 
    {
        // Static field selection
        return [SELECT Id, Name, LastName, FirstName, RecordTypeId, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, 
                    BillingCountry, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, 
                    Phone, Fax, AccountNumber, IsPersonAccount, PersonContactId, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, 
                    PersonOtherStreet, PersonOtherState, PersonOtherCity, PersonOtherPostalCode, PersonOtherCountry, PersonMobilePhone, PersonHomePhone, PersonOtherPhone, PersonEmail, 
                    PersonTitle, PersonBirthdate, Fleet_Customer__c 
                    FROM Account
                    WHERE Id=:acctId];
    }
}