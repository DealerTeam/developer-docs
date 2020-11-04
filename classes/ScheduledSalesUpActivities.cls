public class ScheduledSalesUpActivities implements Schedulable 
{
	public void execute(SchedulableContext sc) 
	{
		// Need to tweak this soql to filter sups
		Set<Id> sups = (new Map<Id, Sales_Up__c>([SELECT Id FROM Sales_Up__c WHERE Lead_Status__c != 'Won'])).keySet();

		SalesUpActivityHandler.SetTaskDates(sups);
		SalesUpActivityHandler.SetEventDates(sups);

	}
}