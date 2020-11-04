@isTest
private class SalesAppointment_TC {

	private static testMethod void testSalesAppointment() {
        
        RecordType rt = [select Id, Name from RecordType 
                         where SObjectType='Account' and IsPersonType=true
                         limit 1];
        // Create a person account
        Account p = new Account(
            RecordTypeId=rt.Id, 
            FirstName='Test', 
            LastName='PersonAccount'
        );
        insert p;
        p = [select Id, FirstName, LastName, PersonContactId from Account where Id =:p.Id];
        
        // Create a solution opportunity
        dealer__Sales_Up__c s = new dealer__Sales_Up__c(
            Name='Test Solution Opportunity',
            dealer__Customer_Account__c = p.Id 
        );
        insert s;
        
        DateTime dt = DateTime.now();
        dealer__Sales_Appointment__c appt1 = new dealer__Sales_Appointment__c(
           dealer__Appointment_Type__c = 'First Visit',
           dealer__Assigned_To__c = UserInfo.getUserId(),
           dealer__Customer__c = p.PersonContactId,
           dealer__Sales_Up__c = s.Id,
           dealer__DateTime__c = dt,
           dealer__Date__c = dt.date(),
           dealer__Time__c = dt.format('hh:mm a')
        );
	}

}