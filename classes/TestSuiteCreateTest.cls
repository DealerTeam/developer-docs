@isTest (seeAllData=true)
public class TestSuiteCreateTest {
     
    @isTest static void testApexTestSuite(){
        
        Test.setMock(HttpCalloutMock.class, new mockCallout());
        TestSuiteCreate.createApexTestSuite('TestSuiteDT1', 'TestClasses');
    }
    
    public class mockCallout implements HttpCalloutMock
    {
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse res = new HttpResponse();
            res.setBody( '{"text":"value"}');
            res.setStatusCode(201);
            return res;
        }   
    }
}