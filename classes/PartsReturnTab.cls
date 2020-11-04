/**
 * Handles part returns
 * @test PartManagementServiceLayer.testPartsReturnTab
 */
public with sharing class PartsReturnTab {

	public PartsReturnTab() {
		
	}

	public PageReference newReturn() {
		PageReference partsInvoice = Page.PartsReturnToVendor;
		partsInvoice.setRedirect(true);
		return PartsInvoice;		
	}

	public List<dealer__Parts_Invoice__c> getReturns() {
		return [Select Id, Name, dealer__Customer__c, CreatedDate, CreatedById, dealer__Location__c, dealer__RMA_No__c, dealer__Status__c from dealer__Parts_Invoice__c where dealer__Vendor_Return__c = true order by CreatedDate DESC Limit 50];
	}
}