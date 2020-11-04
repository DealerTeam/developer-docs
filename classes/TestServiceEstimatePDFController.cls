@isTest (seeAllData=true)
private class TestServiceEstimatePDFController {
    static testmethod void testSEPDFC() {
        ServiceEstimatePDFEmailController sepdf = new ServiceEstimatePDFEmailController();
        sepdf.email='test@test.com';
        sepdf.subject='test Subj';
        sepdf.message='test message';
        sepdf.sendPdf();
    }
}