public without sharing class SelectDealership {

    public String selectedDealershipId {get;set;}
    public Integer numberOfLocations {get;set;}

    public SelectDealership() {
        // Get number of dealerships available to the user in this context
        numberOfLocations = [Select Count() from Dealer_Location_User__c Where User__c=:UserInfo.getUserId()];
    }

    public List<dealer__Dealer_Location__c> getmyDealerships() {
        List<dealer__Dealer_Location__c> dealershipList = new List<dealer__Dealer_Location__c>();
        List<Dealer_Location_User__c> availableLocations = [select Id, Dealer_Location__c from Dealer_Location_User__c where User__c=:UserInfo.getUserId() limit 500];
        Set<Id> dealershipLocationIds = new Set<Id>();

        for(Dealer_Location_User__c dl : availableLocations) {
            dealershipLocationIds.add(dl.Dealer_Location__c);
        }

        if(dealershipLocationIds.size()>0) {
            dealershipList = [SELECT dealer__Address__c, dealer__Street__c, dealer__City__c, dealer__Company_Number__c, dealer__Email__c, dealer__General_Manager__c,
                                 dealer__Main_Phone__c, dealer__Physical_Location__c, dealer__Postal_Code__c, dealer__Service_Director__c, dealer__State__c, 
                                 dealer__Website__c, dealer__Tax_Parts__c, Id, Name 
                                FROM dealer__Dealer_Location__c
                                Where Id IN:dealershipLocationIds
                                Limit 500];
        } else {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'You are not associated with Any Dealerships, Contact your Systems Administrator(s)');//Same old drama 
            ApexPages.addMessage(myMsg);
            return null;            
        }

        return dealershipList;
    }

    public PageReference chooseDealership() {
        if(selectedDealershipId==null) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The Selected ID is NULL');//Same old drama 
            ApexPages.addMessage(myMsg);
            return null;            
        }   

        dealer__Dealer_Location__c d = [Select Id, Name, dealer__Company_Number__c, dealer__General_Manager__c, dealer__Service_Director__c FROM dealer__Dealer_Location__c where Id=:selectedDealershipId limit 1];
        User me = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];

        me.Division                 =   d.dealer__Company_Number__c;
        me.Dealership_Location__c   =   d.Name;
        update me;

        PageReference sd = new PageReference('/');
        sd.setRedirect(true);
        return sd;
    }
}