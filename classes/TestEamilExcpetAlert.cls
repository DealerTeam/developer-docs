@isTest
private class TestEamilExcpetAlert {
    private static testMethod void TestEmailExceptionToAdmin() {
         
        Lead MyBadLead;
         
        try {
            insert MyBadLead;
        } catch (exception e) {
            EmailExceptionToAdmin OutGoingEmail = new EmailExceptionToAdmin('TestEmailExceptionToAdmin',e,'Test Method!');
        } // try & catch
         
    } // test EmailExceptionToAdmin
}