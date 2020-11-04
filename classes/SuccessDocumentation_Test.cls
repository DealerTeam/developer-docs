/**
 * Test The Success Documentation Controller 
 */
@isTest
private class SuccessDocumentation_Test {
	
    static testmethod void testController() {
        SuccessDocumentation sd = new SuccessDocumentation();
        sd.getsuccessDocumentationContent();
        sd.getObjectKeys();
    }
}