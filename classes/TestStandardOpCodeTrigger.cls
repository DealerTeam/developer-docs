@isTest
private class TestStandardOpCodeTrigger {
    
    @isTest
    static void standardOPCodeTest() {
        
        Test.startTest();
           dealer__StandardOpCode__c op = [ SELECT Id, dealer__Op_Code__c FROM dealer__StandardOpCode__c ];
           op.dealer__Company_Number__c = null;
           update op;
       Test.stopTest();
        SYSTEM.assertEquals([ SELECT Id, dealer__Op_Code__c FROM dealer__StandardOpCode__c ].dealer__Op_Code__c , '01TEST');
    }
    
    @isTest
    static void standardOPCodeTestCompanyNumber() {
       
       Test.startTest();
           dealer__StandardOpCode__c op = [ SELECT Id, dealer__Op_Code__c FROM dealer__StandardOpCode__c ];
           op.dealer__Company_Number__c = '1111';
           update op;
       Test.stopTest();

       SYSTEM.assertEquals([ SELECT Id, dealer__Op_Code__c FROM dealer__StandardOpCode__c ].dealer__Op_Code__c , '1111:01TEST');
        
    }

    @testSetup
    static void setupMethod() {
        dealer__StandardOpCode__c newSC = (dealer__StandardOpCode__c)TestFactory.createSObject(new dealer__StandardOpCode__c(Name='01TEST', dealer__Active__c=true, dealer__Book_Time__c=0.5, dealer__Concern__c='test op code', dealer__Op_Code__c='12345',  dealer__Op_Code_Description__c='Test op code vialble for all repairs'), true);
    }
}