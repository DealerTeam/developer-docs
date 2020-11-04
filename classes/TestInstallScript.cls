@isTest
private class TestInstallScript {
    static testmethod void runTest() {
        dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Deal_Number__c = 1;
            dms.dealer__Deal_Default_Rate__c = 9.9; 
            dms.dealer__Service_Appointment_Sequence_Number__c = 2000;
            insert dms;   
        }

        InstallScript postinstall = new InstallScript();
        Test.testInstall(postinstall, null);
        Test.testInstall(postinstall, new Version(1,0), true);
        System.assertNotEquals(dms,null);
        dealer__VINDecoderCS__c vdc = new dealer__VINDecoderCS__c();
        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
            vdc.Name = 'ActiveSettings';
            vdc.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            vdc.dealer__DecoderClientID__c = '6310';
            vdc.dealer__DecoderKey__c = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
            vdc.dealer__DecoderName__c = 'Data One Software';
            insert vdc;   
        }
        System.assertNotEquals(vdc,null);
    }

    @istest static void testcreateDefaultLocation() {

        // Run method
        InstallScriptOrgAPI.createDefaultLocation();

        // Assertions
        System.assert([SELECT Id FROM Dealer_Location__c WHERE Company_Number__c = 'RD1'].size()==1, 'Location RD1 does not exist.');

    }
}