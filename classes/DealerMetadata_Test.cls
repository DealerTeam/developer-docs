@isTest
private class DealerMetadata_Test {
	
	@isTest static void testGetRequiredFields() {
		Map<String,Boolean> fieldMap = DealerMetadata.getAllRequiredFields(Schema.SObjectType.Rental_Agreements__c, 'Rental_Agreements__c-Rental Agreements Layout');
		system.assert(fieldMap.size() > 0,'Object fields should be returned');
	}
	
}