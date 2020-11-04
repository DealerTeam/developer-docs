/**		
 * 		Handler for RelatedEvent trigger
 **/
public class RelatedEventHandler {
    public void handleAfterInsertUpdate(List<Event> evt) {

        // Get the Sales Up Key Prefix
	    Schema.DescribeSObjectResult r = dealer__Sales_Up__c.sObjectType.getDescribe();
	    String keyPrefix = r.getKeyPrefix();
	    Set<Id> supIds = new Set<Id>();

        //Get DMS Settings
        dealer__DMS_Settings__c dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        Map<Id,dealer__Sales_Appointment__c> apptMap = new Map<Id,dealer__Sales_Appointment__c>();


        for(Event e : evt) {
			if(e.WhatId != null) {
				if(String.valueOf(e.WhatId).left(3) == keyPrefix) {
					supIds.add(e.WhatId);
				}
			}

            if(dms.dealer__SalesAppointmentLinkedEvent__c == true && e.dealer__Sales_Appointment__c != null){
                apptMap.put(e.dealer__Sales_Appointment__c, new dealer__Sales_Appointment__c(Id=e.dealer__Sales_Appointment__c, dealer__Notes__c = e.description, dealer__DateTime__c = e.ActivityDateTime, dealer__Subject__c = e.Subject));
            }
		}

        update apptMap.values();

		SalesUpActivityHandler.SetEventDates(supIds);

        
    }
}