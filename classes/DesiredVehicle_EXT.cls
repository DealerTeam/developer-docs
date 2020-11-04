public with sharing class DesiredVehicle_EXT {
	
	private final dealer__Desired_Vehicle__c veh;
	
	public Id salesUpId;
    public list<dealer__DMS_Settings__c> dealDefaults = dealer__DMS_Settings__c.getall().values();
	
	public DesiredVehicle_EXT(ApexPages.standardController s) {
		if(ApexPages.currentPage().getParameters().get('sid')!=''&&ApexPages.currentPage().getParameters().get('sid')!=null) {
			salesUpId = ApexPages.currentPage().getParameters().get('sid');
		}
		this.veh = (dealer__Desired_Vehicle__c)s.getRecord();
	}
}