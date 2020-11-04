@isTest
private class Form_BuyersGuideController_TEST {
	
	@isTest static void test_method_one() {
		PageReference p = Page.dealer__Form_BG_4_kk;
		Vehicle_inventory__c i = new Vehicle_Inventory__c();
		i.VIN__c = '1232344';
		i.Make__c = 'maketest';
		i.model__c='Model';
		i.Stock_Number__c = '1234';
		i.Year__c='2001';

		insert i;
		p.getParameters().put('Id',i.Id);
		p.getParameters().put('warrantyType', 'warrantyType');
		p.getParameters().put('dealerWarrantyType', 'dealerWarrantyType');
		p.getParameters().put('nonDealerWarrantyType', 'nonDealerWarrantyType');
		p.getParameters().put('includesServiceContract','true');

		Test.setCurrentPage(p); 
		FORM_BuyersGuideController bg = new FORM_BuyersGuideController();
		
		Vehicle_Inventory__c vi = bg.getVehicleInventory();
		String warType = bg.getWarrantyType();
		String dealerWarrantyType = bg.getDealerWarrantyType();
		String nonDealerWarrantyType = bg.getNonDealerWarrantyType();
		Boolean includesServiceContract = bg.getIncludesServiceContract();

		system.assert(vi.Make__c == 'maketest', 'make');
		system.assert(warType == 'warrantyType', 'warType not correct');
		system.assert(dealerWarrantyType == 'dealerWarrantyType', 'dealerWarrranty Type not correct');
		system.assert(nonDealerWarrantyType == 'nonDealerWarrantyType', 'non dealer warrnaty type not correct');
		system.assert(includesServiceContract == true, 'includesServiceContract shoudl be true');
	}
	
}