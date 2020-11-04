public with sharing class CreditApplicationAPI {

    public static CreditApplicationSubmission__c submitRouteOne(String appId, String dealId, String providerId){
        CreditApplicationSubmission__c submission = new creditApplicationSubmission__c();
        String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
       
        RouteOne.Callout r1Callout = new RouteOne.Callout(appId, dealId, providerId);
        String rawResponse = (Test.isRunningTest()) ? '{"conversationId":"DTM-1-3flk9vk03ko","response":{"success":true,"body":"OK","errors":[]}}' : EnterpriseControllerAPI.CallOut(baseUrl + '/routeone/dms/CreditApplication', json.serialize(r1Callout));
        
        RouteOne.SubmissionResponse routeOne = (RouteOne.SubmissionResponse)JSON.deserialize(rawResponse, RouteOne.SubmissionResponse.class);
        if(routeOne.conversationId != null){
            String status = routeOne.response.errors.size() > 0 ? 'Failed' : 'Submitted';
            String submissionResponse = status == 'Submitted' ? routeOne.response.body : 'Required fields are missing: '+String.join(routeOne.response.errors,', ');
            submission = new creditApplicationSubmission__c(
                CreditApplication__c = appId,
                Deal__c = dealId,
                SalesUp__c = r1Callout.sup.Id,
                UUID__c = routeOne.conversationId,
                Status__c = status,
                SubmissionResponse__c = submissionResponse
            );
            insert submission;
        }

        return submission;
    }

    public static CreditApplicationSubmission__c submitDealerTrack(String appId, String dealId, String providerId){
        CreditApplicationSubmission__c submission = new creditApplicationSubmission__c();
        String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        String rawResponse = (Test.isRunningTest()) ? '{"conversationId":"DTM-1-3flk9vk03k1","response":{"success":true,"body":"OK","errors":[]}}' : JSON.serialize(DealerTrackCreditApplicationHandler.CreateLeadFromApp(appId, dealId, providerId));
        DealerTrack_Lead_API.LeadResponse response = (DealerTrack_Lead_API.LeadResponse)JSON.deserialize(rawResponse, DealerTrack_Lead_API.LeadResponse.class);
        system.debug(JSON.serialize(response));
        //Will need a valid response to populate this information.
        // if(routeOne.conversationId != null){
        //     String status = routeOne.response.errors.size() > 0 ? 'Failed' : 'Submitted';
        //     String submissionResponse = status == 'Submitted' ? routeOne.response.body : 'Required fields are missing: '+String.join(routeOne.response.errors,', ');
        //     submission = new creditApplicationSubmission__c(
        //         CreditApplication__c = appId,
        //         Deal__c = dealId,
        //         SalesUp__c = r1Callout.sup.Id,
        //         UUID__c = routeOne.conversationId,
        //         Status__c = status,
        //         SubmissionResponse__c = submissionResponse
        //     );
        //     insert submission;
        // }

        return submission;
    }


    public static List<Deal__c> relatedDeals(Id appId){
        Credit_Application__c app = [SELECT Id, Sales_Up__c FROM Credit_Application__c WHERE Id = : appId];
        Deal__c [] deals = app.Sales_Up__c == null ? new List<Deal__c>() : [SELECT Id, Name, Sales_Lead__c, Vehicle__r.Name, Conversion_Description__c FROM Deal__c WHERE Sales_Lead__c =: app.Sales_Up__c];
        return deals;
    }

    public static List<Credit_Application__c> dealRelatedApps(Id dealId){
        Sales_Up__c [] sup = [SELECT Id, Name, Car_Deal__c FROM Sales_Up__c where Car_Deal__c =: dealId ];
        if(sup.size() > 0){
            Credit_Application__c [] apps = [SELECT Id, Name, ApplicationType__c FROM Credit_Application__c WHERE Sales_Up__c =: sup[0].Id];
            return apps;
        } 
        return new List<Credit_Application__c>();
    }

    public static Credit_Application__c createFromSalesUp(Id supId){
        
        Sales_Up__c sup = [SELECT Id, Customer_Account__c, dealer__Buyer_Contact__c, Co_Buyer__c  FROM Sales_Up__c WHERE Id =: supId];
        Account     buyer   = sup.Customer_Account__c != null   ? (Account)Utility.queryAllFields('Account', sup.Customer_Account__c) : new Account();
        Contact     buyerContact = sup.Buyer_Contact__c != null ? (Contact)Utility.queryAllFields('Contact', sup.Buyer_Contact__c) : new Contact();
        Account     coBuyer = sup.Co_Buyer__c != null ?           (Account)Utility.queryAllFields('Account', sup.Co_Buyer__c) : new Account();
        
        Credit_Application__c app = new Credit_Application__c(Sales_Up__c = sup.Id);
        
        //TK: As of June 1 2020, Arch is not using co-buyer functionality on Sales ups. Skipping that for now
        if (buyer.isPersonAccount){
            //B2C  

            app.First_Name__c = buyer.FirstName;
            app.Middle_Name__c = buyer.MiddleName;
            app.Last_Name__c = buyer.LastName;
            app.Driver_License_No__c = buyer.Drivers_License_Number__pc;
            app.DriverLicenseState__c = buyer.Drivers_License_State__pc;
            app.Home_Phone__c = buyer.PersonHomePhone;
            app.Mobile_Phone__c = buyer.PersonMobilePhone;
            app.Email_Address__c = buyer.PersonEmail;
            app.Current_Address_Street__c = buyer.PersonMailingStreet;
            app.Current_Address_City__c = buyer.PersonMailingCity;
            app.CurrentAddressState__c = buyer.PersonMailingState;
            app.Current_Address_Zip__c = buyer.PersonMailingPostalCode;

        } else {
            //B2B

            app.Business_Name__c = buyer.Name;
            app.Business_Phone__c = buyer.Phone;
            app.Business_Street__c = buyer.BillingStreet;
            app.Business_City__c = buyer.BillingCity;
            app.BusinessState__c = buyer.BillingState;
            app.Business_Zip_Code__c = buyer.BillingPostalCode;

            //Operator
            app.BusinessOperatorFirstName__c = buyerContact.Firstname;
            app.BusinessOperatorLastName__c = buyerContact.LastName;
            app.BusinessOperatorStreet__c = buyerContact.MailingStreet;
            app.BusinessOperatorCity__c = buyerContact.MailingCity;
            app.BusinessOperatorState__c = buyerContact.MailingState;
            app.BusinessOperatorPostalCode__c = buyerContact.MailingPostalCode;

        }

        //Now set app Type
        if(buyer.isPersonAccount){
            app.ApplicationType__c = 'Individual';
        } else {
            app.ApplicationType__c = 'Business';
        }

        insert app;
        
        //Name is set in the Domain layer and we want to surface this data.
        return [SELECT Id, Name FROM Credit_Application__c WHERE Id =: app.Id];
    }

}