@isTest
private class TestSalesLeadResponseTime {

    //Tests using specified business hours from the company number of the sales up
    static testMethod void testSLRT() {
        TestClassUtil util = new TestClassUtil();
        Contact c = new Contact(FirstName='John', LastName='Smithston');
        insert c;
        dealer__Sales_Up__c lead = new dealer__Sales_Up__c(Name='test',
                                                        dealer__Buyer_Contact__c=c.Id,
                                                        dealer__FirstName__c=c.FirstName,
                                                        dealer__LastName__c=c.LastName,
                                                        dealer__Lead_Type__c='Walk-In',
                                                        dealer__Lead_Origination_Service__c='Urban Science',
                                                        dealer__Make__c='Nissan',
                                                        dealer__Company_Number__c = 'CN1'                                                           
                                                    );
        insert lead;
        system.assert(lead.dealer__Response_Time__c == null);
        Task t = new Task(Subject='lead response', Status='Completed', WhatId=lead.Id);
        insert t;
        dealer__Sales_Up__c leadAfter = [Select Id, dealer__Response_Time__c from dealer__Sales_Up__c where Id = :lead.Id limit 1];
        system.assert(leadAfter.dealer__Response_Time__c != null);
        
        
       Profile prof = [select id from profile where name='system Administrator'];
        User u = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert u;

        System.runAs(u) {
            dealer__CRMSettings__c crm = new dealer__CRMSettings__c();
            if([select Id, dealer__UrbanScience_Active__c from dealer__CRMSettings__c].size() == 0){
                //dealer__CRMSettings__c crm = [select Id, dealer__UrbanScience_Active__c from dealer__CRMSettings__c limit 1];
                //dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
                //dealer__CRMSettings__c crm = new dealer__CRMSettings__c();
                crm.dealer__UrbanScience_Active__c = false;
                insert crm;
            }
            else{
                crm = [select Id, dealer__UrbanScience_Active__c from dealer__CRMSettings__c limit 1];
            }
            
            crm.dealer__UrbanScience_Active__c=true;
            update crm;
            
            leadAfter.dealer__Demo__c=true;
            update leadAfter;
            
            crm.dealer__UrbanScience_Active__c=false;
            update crm;
        }
    }
    //Tests using the default business hours when there are none set for a location
    static testMethod void testSLRT2() {
        TestClassUtil util = new TestClassUtil();
        Contact c = new Contact(FirstName='John', LastName='Smithston');
        insert c;
        dealer__Sales_Up__c lead = new dealer__Sales_Up__c(Name='test',
                                                        dealer__Buyer_Contact__c=c.Id,
                                                        dealer__FirstName__c=c.FirstName,
                                                        dealer__LastName__c=c.LastName,
                                                        dealer__Lead_Type__c='Walk-In',
                                                        dealer__Lead_Origination_Service__c='Urban Science',
                                                        dealer__Make__c='Nissan',
                                                        dealer__Company_Number__c = 'CN5');
        insert lead;
        system.assert(lead.dealer__Response_Time__c == null);
        Task t = new Task(Subject='lead response', Status='Completed', WhatId=lead.Id);
        insert t;
        dealer__Sales_Up__c leadAfter = [Select Id, dealer__Response_Time__c from dealer__Sales_Up__c where Id = :lead.Id limit 1];
        system.assert(leadAfter.dealer__Response_Time__c != null);
    }

    static testMethod void testUpdateTask() {
        TestClassUtil util = new TestClassUtil();
        Contact c = new Contact(FirstName='John', LastName='Smithston');
        insert c;
        dealer__Sales_Up__c lead = new dealer__Sales_Up__c(Name='test',
                                                        dealer__Buyer_Contact__c=c.Id,
                                                        dealer__FirstName__c=c.FirstName,
                                                        dealer__LastName__c=c.LastName,
                                                        dealer__Lead_Type__c='Walk-In',
                                                        dealer__Lead_Origination_Service__c='Urban Science',
                                                        dealer__Make__c='Nissan',
                                                        dealer__Company_Number__c = 'CN5');
        insert lead;
        system.assert(lead.dealer__Response_Time__c == null);
        Task t = new Task(Subject='lead response', Status='In Progress', WhatId=lead.Id);
        insert t;
        dealer__Sales_Up__c leadAfter = [Select Id, dealer__Response_Time__c from dealer__Sales_Up__c where Id = :lead.Id limit 1];
        system.assert(leadAfter.dealer__Response_Time__c == null);


        t.Status='Completed';
        update t;
        leadAfter = [Select Id, dealer__Response_Time__c from dealer__Sales_Up__c where Id = :lead.Id limit 1];
        system.assert(leadAfter.dealer__Response_Time__c != null);
    }
}