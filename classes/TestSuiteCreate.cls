public class TestSuiteCreate {
    
    private static String testSuiteUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v39.0/sobjects/ApexTestSuite';
	private static String suiteMemberUrl = URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v39.0/sobjects/TestSuiteMembership';
    
    /*		Method to create Apex Test Suite
     * 		@Param: String suite name
     * 		@Param: String static resource file name 
     * */
    public static void createApexTestSuite(String suiteName, String fileName){
        
        List<ApexTestSuite> ts = [Select Id, TestSuiteName FROM ApexTestSuite WHERE TestSuiteName =: suiteName];
        
        //Test Suite exists
        if(ts.size() == 1){
            
            //Add classes to Test suite
            TestSuiteCreate.createTestSuiteMember(ts[0].Id, fileName);
            
        }else{
            //Create Test Suite
            HTTPRequest req = new HTTPRequest();
            req.setEndpoint(testSuiteUrl);
            req.setMethod('POST');
            // OAuth header
            req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
            req.setHeader('Content-Type', 'application/json');
            req.setBody('{'+
                '"TestSuiteName" : "' + suiteName +'"'+
            '}');
        
            Http h = new Http();
            HttpResponse res = h.send(req);
            System.debug('Response: ' + res.getBody());
            if (res.getStatusCode() == 201) {
                
                Response n = (Response)JSON.deserialize(res.getBody(), Response.class);
                //Add classes to Test suite
                TestSuiteCreate.createTestSuiteMember(n.Id, fileName);
                
            }else{
                System.debug('Error creating Test Suite. Status code: ' + res.getStatusCode() + ' - ' + res.getStatus());
            }
            
        }
        
    }
 
    
    /*		Future method to add Apex Test Classes to Test Suite
    * 		@Param: String suite id
    * 		@Param: String static resource file name 
    * */
    @future(callout=true)
    public static void createTestSuiteMember(String suiteId, String fileName){
        
        Set<String> classNames = new Set<String>();
        try{
            if(!Test.isRunningTest()){
                
                 //SuiteName is the same as the static resource  
                StaticResource srObject = [select id, body from StaticResource Where Name =: fileName];
                String contents = srObject.body.toString();
                for(String line: contents.split('\n')) {
                    classNames.add(line);
                }
            }else{
                classNames.add('TestSuiteCreateTest');
            }
           
        }catch(Exception e){
            system.debug('Error: ' + e.getMessage());
        }
        
        system.debug('classNames size: ' + classNames.size());
        if(classNames.size() > 0){
            
            //Get Classes Ids to be added to Test Suite
            List<String> classId = TestSuiteCreate.getApexClassId(classNames);
            system.debug('classId size: ' + classId.size());
            for(Integer i=0;i<classId.size();i++){
                
                String memberBody = '{'+
                    '"ApexTestSuiteId" : "' + suiteId +'",'+
                    '"ApexClassId" : "' + classId[i] +'"'+
                    '}';
                
                HTTPRequest req = new HTTPRequest();
                req.setEndpoint(suiteMemberUrl);
                req.setMethod('POST');
                // OAuth header
                req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
                req.setHeader('Content-Type', 'application/json');
                req.setBody(memberBody);
                
                Http h = new Http();
                HttpResponse res = h.send(req);
                if (res.getStatusCode() == 201) {
                    Response n = (Response)JSON.deserialize(res.getBody(), Response.class);
                    
                }else{
                    System.debug('Error adding class to Test Suite. Status code: ' + res.getStatusCode() + ' - ' + res.getStatus());
                }
            }
        }
    } 
  
    
    /*		Method to Get Apex Test Classes Ids From Test Class Name
    * 		@Param: Set<String> class names
    * 		@Return: List<String> Apex Classes Ids
    * */
    public static List<String> getApexClassId(Set<String> classNames){
        
        List<String> classIds = new List<String>();
        for(ApexClass a : [select id, Name from ApexClass WHERE Name IN : classNames]){
            classIds.add(a.id);
        }
        return classIds;
    }
    
    /*
     * 		Inner class to deserialize HttpResponse
     * */
    private class Response {

        private String id;
  
	}
}