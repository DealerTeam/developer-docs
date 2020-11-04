@isTest
private class DealershipLocationAPI_TEST {
	@testSetup static void setupTest(){
        
		Profile prof = [select id from profile where name='system Administrator'];
		dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        
		User usr = new User(alias = 'usr', email='us.testusr123@dealerteam.com',
			emailencodingkey='UTF-8', lastname='lstname',
			timezonesidkey='America/Los_Angeles',
			languagelocalekey='en_US',
			localesidkey='en_US', profileid = prof.Id,
			username='us.testusr123@dealerteam.com',
			Division='DT1');
		insert usr;

		Document doc1 = new Document();
		doc1.Name = 'InvoiceLogo';
		doc1.DeveloperName = 'InvoiceLogo';
		doc1.FolderId=usr.Id;
		insert doc1;

		Document doc2 = new Document();
		doc2.Name='locLogo';
		doc2.DeveloperName = 'locLogo';
		doc2.FolderId=usr.Id;
		insert doc2;

	}
	@isTest static void test_method_one() {

		system.assert([SELECT Logo_Name__c from Dealer_Location__c LIMIT 1].Logo_Name__c == 'InvoiceLogo', 'Trigger for Dealer_Location__c should always set the logo name to \'InvoiceLogo\' if the field is null ');
		system.assert([SELECT Id, Name FROM Document LIMIT 1].Id != null ,'Document not insert correctly in test');
		String imageUrl = DealershipLocationAPI.formLogoURL([SELECT Id from Dealer_Location__c LIMIT 1].Id);
		system.assert( imageUrl != null, ' #1 DealershipLocationAPI.formLogoURL should return a value');
		Id imageId = (Id)imageURL.split('=')[1];
		system.assert([SELECT DeveloperName FROM Document WHERE Id=:imageId].DeveloperName == 'InvoiceLogo', 'First doc\'s name should equal \'InvoiceLogo\' ');

		//now to change the location's logo name to 'locLogo and make sure it's working as expected
		Dealer_Location__c loc = [SELECT Id FROM Dealer_Location__c LIMIT 1];
		loc.Logo_Name__c='locLogo';
		upsert loc;

		imageUrl = DealershipLocationAPI.formLogoURL([SELECT Id from Dealer_Location__c LIMIT 1].Id);
		system.assert( imageUrl != null, '#2 DealershipLocationAPI.formLogoURL should return a value');
		imageId = (Id)imageURL.split('=')[1];
		system.assert([SELECT DeveloperName FROM Document WHERE Id=:imageId].DeveloperName == 'locLogo', 'First doc\'s name should equal \'InvoiceLogo\' ');

		Try{
			loc.Logo_Name__c ='doesnotexist';
			upsert loc;
			} catch(Exception e){
				Boolean expectedExpeptionThrown = e.getMessage().contains('Static resource doesnotexist does not exist. Please make sure you have uploaded this file.')?true:false;
				system.AssertEquals(expectedExpeptionThrown, true);
				}
        String imageUrl2 = DealershipLocationAPI.formLogoURL(loc.Id);
        
        
	}
    @isTest
    static void testCreateLocationFees() {
        
        Dealer_Location__c loc = [SELECT id FROM Dealer_Location__c LIMIT 1];
        
        String feeJson = '{"feeName":"Doc Fee","feeDescription":"Doc Fee","feeDefaultAmount":199,"feeDefaultOnDeals":true,"feeTaxable":true,"feeCode":"","feeDefaultAmountByFormulaField":"","feeDefaultOnDealsByFormulaField":""}';
        
        loc.Fees__c = feeJson;
        update loc;
        DealershipLocationAPI.createLocationFees(loc, feeJson);
        
        List<DealershipLocationAPI.Fee> returnFees = DealershipLocationAPI.getLocationFees(loc.Id);
        system.assertEquals(1, returnFees.size(), 'No location fee found');
        system.assertEquals(199, returnFees[0].feeDefaultAmount, 'Default amount does not match');
        returnFees[0].feeDefaultByFormulaField = '';
        DealershipLocationAPI.editFee(loc, feeJson);
        
    }
    @isTest
    static void testCreateLocationNoFees() {
        Dealer_Location__c loc = [SELECT id FROM Dealer_Location__c LIMIT 1];
        List<DealershipLocationAPI.Fee> returnFees = new List<DealershipLocationAPI.Fee>();
         
        try{
            DealershipLocationAPI.getLocationFees(loc.Id);
        }catch (Exception e){
            String message = e.getMessage();
        }        
    }
    
    @isTest
    static void testGetCoveredSystems() {
        Dealer_Location__c loc = [SELECT id FROM Dealer_Location__c LIMIT 1];
        DealershipLocationAPI.getCoveredSystems(loc.Id);
    }
    @isTest
    static void testNewCoveredSystem() {
        DealershipLocationAPI.CoveredSystem cs = new DealershipLocationAPI.CoveredSystem();
        
        cs.systemCovered = 'test';
        cs.duration = '';
        cs.warrantyType = '';
        
        
        
    }
}