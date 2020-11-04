@isTest
public with sharing class Enterprise_Test {

    @isTest 
    static void testEnterpriseController(){
        
        test.setMock(HttpCalloutMock.class, new EnterpriseAPIMock());

        test.startTest();
            Enterprise.EnterpriseRequest req = new Enterprise.EnterpriseRequest();
            req.resource = 'https://apps.dealerteam.com/dealertrackdms/opentrack/dealadd';
            req.jsonObject = '{}';
            req.method = 'POST';
            
            Enterprise.call(req);

            EnterpriseControllerAPI.Callout(req.resource, req.jsonObject);
            EnterpriseControllerAPI.Callout(req.resource, req.jsonObject, 120000);

        test.stopTest();
    }

}
