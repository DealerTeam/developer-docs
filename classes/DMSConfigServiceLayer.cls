@isTest
private class DMSConfigServiceLayer {
    @TestSetup
    static void testData(){
        
    }
    @isTest
    static void DMSConfigServiceLayer() {
        List<DMSConfigController.DMSWrapper> wrapper = DMSConfigController.getDMSApplications();
    }
}