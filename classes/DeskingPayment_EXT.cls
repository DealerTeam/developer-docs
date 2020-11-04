public with sharing class DeskingPayment_EXT {

	private final dealer__Deal_Payment__c dealPayment;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public DeskingPayment_EXT(ApexPages.StandardController stdController) {
        this.dealPayment = (dealer__Deal_Payment__c)stdController.getRecord();

        if(ApexPages.CurrentPage().getParameters().get('dealId')!=null) {
            this.dealPayment.dealer__Car_Deal__c = [select Id from dealer__Deal__c where Id =:ApexPages.CurrentPage().getParameters().get('dealId') limit 1].Id;
        }
    }

    public PageReference savePayment() {
        insert this.dealPayment;
        PageReference desking = Page.Desking;
        desking.getParameters().put('id', this.dealPayment.dealer__Car_Deal__c);
        return desking;
    }
}