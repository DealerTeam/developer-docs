@isTest
private class SalesUpControllerTest {
	@testSetup static void createTestData() {
		TestClassUtil util = new TestClassUtil();
		dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
		if(dms == null){
			util.insertDMSSettings();   
		}
	} 

	
	@isTest static void test_method_one() {
		
		List<String> leadTypes = SalesUpController.getLeadTypePicklistValues();
		//Person Account:
		Account b2cAccount1 = new Account( FirstName='b2cFirst', LastName='b2cLast', Phone='5305551234', PersonEmail='b2c@gmail.com');
		Account b2bAccount = new Account( FirstName='b2bFirst', LastName='b2bLast', Name='test Industry', Phone='5305551234', PersonEmail='b2c@gmail.com');
		String recordTypes = SalesUpController.getRecordTypes();
		String source = SalesUpController.getSourcePicklistValues().size()>0?SalesUpController.getSourcePicklistValues()[0]:'location'; 
		String status = SalesUpController.getStatusPickListValues().size()>0?SalesUpController.getStatusPickListValues()[0]:'Untouched';
		system.assert(recordTypes != null, 'record Types were not generated');
		system.assert(source != null,'Source picklist was not generated');
		system.assert(status != null,'Status poiclist was not generated');
		List<sObject> objContainers = SalesUpController.createContainerObjects();

		//New b2c account/Sup
		List<sObject> b2cResult = SalesUpController.doCreate(b2cAccount1,new Contact(),new Sales_Up__c(Source__c=source,Lead_Status__c=status));
		system.assert(b2cResult[0].Id != null, 'b2c Sales Up not created successfully');
		system.assert([SELECT Id, IsPersonAccount FROM Account WHERE Id=:b2cResult[1].Id ].IsPersonAccount == true, 'b2c account should be a Person Account');

		//New b2b account/Sup
		List<sObject> b2bResult = SalesUpController.doCreate(b2bAccount,new Contact(), new Sales_Up__c(Source__c=source,Lead_Status__c=status));
		Contact b2bContact = new Contact( lastName='test', AccountId=b2bAccount.Id);
		insert b2bContact;
		system.assert(b2bResult[0].Id != null, 'b2b Sales Up not created successfully');
		system.assert([SELECT Id, IsPersonAccount FROM Account WHERE Id=:b2bResult[1].Id ].IsPersonAccount == false, 'b2b account should not be a Person Account');
		//create sup using existing account
		List<sObject> b2cResult2 = SalesUpController.doCreate((Account)b2cResult[1],new Contact(), new Sales_Up__c(Source__c=source,Lead_Status__c=status));
		//suggest Results
		system.debug(' accounts = '+[SELECT Name FROM ACCOUNT]);
		SalesUpController.suggestResults('test','test','test','test','test');
		SalesUpController.suggestResults(null,null,null,null,null);

		Account a = [SELECT Id FROM Account LIMIT 1];
		SalesUpController.suggestSUPResults(a.Id);

		//duplicate check
		Account b2cAccount2 = new Account( FirstName='b2cFirst', LastName='b2cLast', Phone='5305551234', PersonEmail='b2c@gmail.com');
		List<sObject> duplicateResults = SalesUpController.findCustomerDuplicates(b2cAccount2);
		Map <String,String> fields = SalesUpController.getFieldLabels();
		
		List<sObject> customerList = SalesUpController.getCustomer((String)[SELECT Id FROM Account LIMIT 1].Id);
		system.assert(customerList[0].Id != null,'Get customer method should return an account');
		customerList = SalesUpController.getCustomer((String)[SELECT Id FROM Contact LIMIT 1].Id);
		system.assert(customerList[1].Id != null,'Get customer method should return a contact');

		List<Contact> contactList = SalesUpController.businessContacts([SELECT Id FROM Account WHERE Name = 'test Industry' LIMIT 1]);
		system.assert(contactList.size() > 0, 'businessContact should return a related contact using a B2b Account');

		Account parentAccount = SalesUpController.parentAccount(contactList[0].Id);
		system.assert(parentAccount.Id != null, 'SalesUpController.parentAccount should have returned the parent account of this contact');

		SalesUpController.recentAccounts();
		SalesUpController.searchAccounts('b2bFirst');
		SalesUpController.selectedAccount(b2bResult[0].Id);
		SalesUpController.SearchContacts('test',b2bResult[0].Id);
		SalesUpController.relatedContacts(b2bResult[0].Id);
		SalesUpController.selectedContact(b2bContact.Id);
		
	}

	@isTest
	static void testFieldSet(){
		List<SalesUpController.fieldSetWrapper> wrap = SalesUpController.getSalesUpFieldSet();
		System.assert(wrap.size() > 0, 'getSalesUpFieldSet found no fields.');
	}
	
}