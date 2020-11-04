/**
 * Date            |Developer            |Work#
 * Notes
 * --
 * 2016.11.24      |Sneha Utture            |Case #2193
 * Added method to increase test coverage.
 * 2019.5.3      |David Ray            |
 *
 */

@isTest
private class Test_FormControl {

    @testSetup 
    static void testDataInit() {
        // Referental Datea
        // Create Form
        String frmBase64 = 'fHwyLDEwLERMRSMrMiwzMCx7IWRlYWwuZGVhbGVyX19EZWFsX0lEX19jfSsyLDUwLFJPUysyLDcwLHshZGVhbC5kZWFsZXJfX1N0b2NrX051bWJlcl9fY30rfHx8fDYsMix7IWRlYWwuZGVhbGVyX19CdXllcl9GaXJzdF9OYW1lX19jfSs2LDMwLHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0ZpcnN0X05hbWVfX2N9KzYsNTYseyEkT3JnYW5pemF0aW9uLk5hbWV9K3w3LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQWRkcmVzc19fY30rNywzMCx7IWRlYWwuZGVhbGVyX19Db19CdXllcl9BZGRyZXNzX19jfSs3LDU2LHshJE9yZ2FuaXphdGlvbi5TdHJlZXR9K3w4LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsMzAseyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsNTYseyEkT3JnYW5pemF0aW9uLkNpdHl9IHshJE9yZ2FuaXphdGlvbi5TdGF0ZX0geyEkT3JnYW5pemF0aW9uLlBvc3RhbENvZGV9K3x8fHx8fDE0LDEzLHshZGVhbC5kZWFsZXJfX01ha2VfX2N9K3wxNSwyLHshZGVhbC5kZWFsZXJfX05VT19fY30rMTUsOCx7IWRlYWwuZGVhbGVyX19ZZWFyX19jfSsxNSwxMyx7IWRlYWwuZGVhbGVyX19Nb2RlbF9fY30rMTUsMjQseyFST1VORChkZWFsLmRlYWxlcl9fTWlsZWFnZV9fYywwKX0rMTUsMzYseyFkZWFsLmRlYWxlcl9fVklOX19jfSt8fHx8fHx8fHwyNCw0OCx7IVJPVU5EKGRlYWwuZGVhbGVyX19Eb3duX1B5bXRfX2MsMCl9K3wyNSw1LHshZGVhbC5kZWFsZXJfX1JhdGVfX2N9KzI1LDEzLHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fY30rMjUsMjUseyFkZWFsLmRlYWxlcl9fQW10X0ZpbmFuY2VkX19jfSsyNSwzNSx7IWRlYWwuZGVhbGVyX19BbXRfRmluYW5jZWRfX2N9KzI1LDQ4LHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fYytkZWFsLmRlYWxlcl9fRG93bl9QeW10X19jfSsyNSw1OCxOL0ErMjUsNzEsTi9BKzI1LDc3LE4vQSt8MjYsNTgsTi9BKzI2LDcxLE4vQSsyNiw3NyxOL0ErfDI3LDY3LE4vQSsyNyw3MSxOL0ErMjcsNzcsTi9BK3wyOCw2NyxOL0ErMjgsNzEsTi9BKzI4LDc3LE4vQSt8MjksNjcsTi9BKzI5LDcxLE4vQSsyOSw3NyxOL0ErfDMwLDY3LE4vQSszMCw3MSxOL0ErMzAsNzcsTi9BK3wzMSw3NyxOL0ErfHx8fHwzNiw1LHshZGVhbC5kZWFsZXJfX1Rlcm1fX2MtMX0rMzYsMjgseyFkZWFsLmRlYWxlcl9fTW9udGhseV9QeW10X19jfSszNiw0NSx7IWRlYWwuZGVhbGVyX19GaXJzdF9QYXltZW50X0RhdGVfX2N9K3x8fHx8fHx8fHx8fHx8fHx8fHw=';
        dealer__Form__c frm = new dealer__Form__c(
            Name='TestForm', 
            dealer__Impact_Code__c=frmBase64, 
            dealer__Print_Type__c='Impact'
        );
        insert frm;

        // Create Deal
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
                dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
        dms.Name = 'ActiveSettings';
        dms.dealer__Service_Current_Invoice_Number__c = 30093;
        dms.dealer__Service_Job_Line_Number__c = 8;
        //dms.dealer__State_Tax_Rate__c = 7.75;
        dms.dealer__Parts_Current_Invoice_Number__c = 50115;
        dms.dealer__Parts_Current_Quote_Number__c = 20028;
        dms.dealer__Default_Tax_Rate__c = 7.75;
        dms.dealer__Deal_Number__c = 1;
        dms.dealer__Deal_Default_Rate__c = 9.9; 
        insert dms;   
        }

        TestClassUtil util = new TestClassUtil(); 
        String acctId = util.insertAccount();

        dealer__Deal__c deal = new dealer__Deal__c();
        deal.Name = 'Test';
        deal.dealer__Deal_Id__c = '1000';
        deal.dealer__Buyer__c = acctId;
        
        insert deal;   

        
        dealer__Trade_In__c ti = new dealer__Trade_In__c(
            Name='Test Trade', 
            dealer__Car_Deal__c=deal.Id
        );

        insert ti;
    }

    static testmethod void testFormControl() {
         
        dealer__Form__c frm = [
            SELECT Id, Name 
            FROM dealer__Form__c 
            WHERE Name = 'TestForm' 
            LIMIT 1
        ];

        dealer__Deal__c deal = [
            SELECT Id, Name
            FROM dealer__Deal__c
            WHERE Name = 'Test'
            LIMIT 1
        ];

        Test.setCurrentPageReference(new PageReference('Page.ImpactForm_Generator'));
        System.currentPageReference().getParameters().put('fid', frm.Id);
        System.currentPageReference().getParameters().put('did', deal.Id);
        System.currentPageReference().getParameters().put('id', frm.Id);

        FormControl f = new FormControl();
                
                //f.saveNewForm();
        f.newForm();
        f.updateForm();
        f.formsList();
        f.getPreview();
        f.getfdf();  //Case #2193
        f.getObjectFieldNames();
        f.getObjectFieldNamesSimple();
        f.getForms();
        f.getConfig();
        f.saveNewForm();
        f.compileFormSource();
        f.setDealId();
        f.deal_name='YTest';
          
        f.getBuyer();
        f.getCoBuyer();
        f.getisPersonAccount();
        f.gettradeIn1();
        f.gettradeIn2();
        f.gettradeIn3();

        f.retreiveTaxList();
        f.retreiveDiscountList();
        f.retreiveAftermarketList();
        f.retreiveServiceContractList();
        //FormControl.compileForm('{"formdId" : "'+frm.Id+'", "dealId" : "'+deal.Id+'"}');
        Appraisal__c ap = new Appraisal__c();
        insert ap;
        FormAPI.lookupAppraisal(ap.Id);
        List<Form__c> frms = new List<Form__c>();
        frms.add([SELECT Id, Page_Name__c, Print_Type__c FROM Form__c LIMIT 1]);
        FormAPI.bundleForms(deal.Id,frms);

    }

    static testmethod void testForm_EXT() {
        dealer__Form__c form = new dealer__Form__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(form);
        Form_EXT f = new Form_EXT(sc);

        // Test Upload
        f.uploadPDF();
        Document d = f.document;
        
    }

    static testmethod void testLookup(){
        Deal__c deal = [
            SELECT Id, Name
            FROM Deal__c
            WHERE Name = 'Test'
            LIMIT 1
        ];

        List<Trade_In__c> trades = FormAPI.lookupTradeIns(deal.Id);

        System.assertEquals(trades.size(), 1);
    }

    static testmethod void testFDF(){
        // Not super meanigful tests, but they up the coverage percent

        List<Form__c> frms = new List<Form__c>();
        
        dealer__Form__c frm1 = new dealer__Form__c(
            Name='LaserForm1', 
            dealer__Print_Type__c='Laser',
            dealer__Page_Name__c = 'testName'
        );
        frms.add(frm1);
        
        Form__c frm2 = new Form__c(
            Name='TestForm2', 
            Print_Type__c='FDF',
            FDF_Code__c='test\ntest\n',
            DocumentContentId__c = 'aa111'
        );
        frms.add(frm2);

        insert frms;

        Deal__c deal = [
            SELECT Id, Name
            FROM Deal__c
            WHERE Name = 'Test'
            LIMIT 1
        ];
    
        String formString = FormAPI.bundleForms(deal.Id, frms);
        
        FormAPI.processFeeVariables(frm2,deal);
    }

    @isTest
    static void testFormFunctions() {
        dealer__Form__c form = [SELECT Id FROM Form__c LIMIT 1];
        PageReference pageRef = Page.FormManagerFunctions;
        Test.setCurrentPage(pageRef);

        // Put Id into the current page Parameters
        ApexPages.currentPage().getParameters().put('recordId',form.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(form);
        Form_EXT f = new Form_EXT(sc);

        // Test Upload
        f.documentId = '1234';
        f.handleUpload();

        f.fdf = 'test fdf content';
        f.handleFDF();

        form = FormControl.getForm(form.Id);
        System.assertEquals('1234', form.DocumentContentId__c, 'getForm did not return form with expected fields.');
    }
}