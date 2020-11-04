public class SalesUpActivityHandler 
{
	public static void SetTaskDates(Set<Id> supIds) 
	{
		List<Sales_Up__c> sups = [SELECT Id , Next_Task_Date__c, Last_Task_Date__c FROM Sales_Up__c WHERE Id IN :supIds];
		List<Task> allRelatedTasks = [SELECT Id, ActivityDate, isClosed, WhatId FROM Task WHERE WhatId in:supIds AND ActivityDate != null];
		List<Task> supRelatedTasks = new List<Task>();
		List<Date> nextDates = new List<Date>();
		List<Date> lastDates = new List<Date>();
		List<Sales_Up__c> supsToUpdate = new List<Sales_Up__c>();

		Boolean doUpdate = false;

		for(Sales_Up__c sup : sups)
		{
			// get related tasks
			for(Task t : allRelatedTasks)
			{
				if(t.WhatId == sup.Id)
					supRelatedTasks.add(t);
			}

			// get all task dates and add them to appropriate list
			for(task t : supRelatedTasks)
			{
				if(!t.isClosed && t.ActivityDate >= system.Today())
					nextDates.add(t.ActivityDate);
				else if(t.isClosed)
					lastDates.add(t.ActivityDate);
			}
			
			// perform date comparison on supRelatedTasks

			if(nextDates.size() > 0)
			{
				MinMaxDate nDates = compareDates(nextDates);
				doUpdate = sup.Next_Task_Date__c != nDates.Min;
				sup.Next_Task_Date__c = nDates.Min;
			}
			else
			{
				doUpdate = sup.Next_Task_Date__c != null;
				sup.Next_Task_Date__c = null;
			}

			if(lastDates.size() > 0)
			{
				MinMaxDate lDates = compareDates(lastDates);
				doUpdate = sup.Last_Task_Date__c != lDates.Max ? true : doUpdate;
				sup.Last_Task_Date__c = lDates.Max;
			}
			else
			{
				doUpdate = sup.Last_Task_Date__c != null ? true : doUpdate;
				sup.Last_Task_Date__c = null;
			}

			if(doUpdate)
				supsToUpdate.add(sup);

		}

		// update sups
		if(supsToUpdate.size() > 0)
			updateSups(supsToUpdate);
	}

	public static void SetEventDates(Set<Id> supIds) 
	{
		List<Sales_Up__c> sups = [SELECT Id , NextEventDateTime__c, LastEventDateTime__c FROM Sales_Up__c WHERE Id IN :supIds];
		List<Event> allRelatedEvents = [SELECT Id, StartDateTime, EndDateTime, WhatId FROM Event WHERE WhatId in:supIds AND StartDateTime != null];
		List<Event> supRelatedEvents = new List<Event>();
		List<DateTime> nextDates = new List<DateTime>();
		List<DateTime> lastDates = new List<DateTime>();
		List<Sales_Up__c> supsToUpdate = new List<Sales_Up__c>();

		Boolean doUpdate = false;

		for(Sales_Up__c sup : sups)
		{
			// get related Events
			for(Event e : allRelatedEvents)
			{
				if(e.WhatId == sup.Id)
					supRelatedEvents.add(e);
			}

			// get all Event dates and add them to appropriate list
			for(Event e : supRelatedEvents)
			{
				if(e.StartDateTime > system.Now())
					nextDates.add(e.StartDateTime);
				else
					lastDates.add(e.StartDateTime);
			}

			// perform date comparison on supRelatedEvents

			if(nextDates.size() > 0)
			{
				MinMaxDateTime nDates = compareDates(nextDates);
				doUpdate = sup.NextEventDateTime__c != nDates.Min;
				sup.NextEventDateTime__c = nDates.Min;
			}
			else
			{
			    doUpdate = sup.NextEventDateTime__c != null;
				sup.NextEventDateTime__c = null;
			}

			if(lastDates.size() > 0)
			{
				MinMaxDateTime lDates = compareDates(lastDates);
				doUpdate = sup.LastEventDateTime__c != lDates.Max ? true : doUpdate;
				sup.LastEventDateTime__c = lDates.Max;
			}
			else
			{
				doUpdate = sup.LastEventDateTime__c != null ? true : doUpdate;
				sup.LastEventDateTime__c = null;
			}

			if(doUpdate)
				supsToUpdate.add(sup);
		}

		// update sups
		if(supsToUpdate.size() > 0)
			updateSups(supsToUpdate);
	}

	// public so we can test - See TestSalesUpActivityHandler.testDMLException()
	public static void updateSups(List<Sales_Up__c> sups)
	{
		try
		{
			update sups;
		} 
		catch(DMLException e)
		{
			throw new ActivityException('Error in SalesUpActivityHandler: ' + e);
		}
	}

	static MinMaxDate compareDates(List<Date> datelist)
	{
		MinMaxDate dateObj = new MinMaxDate();
		datelist.sort();
		dateObj.Min = datelist.get(0);
		dateObj.Max = datelist.get(datelist.size()-1);

		return dateObj;
	}

	static MinMaxDateTime compareDates(List<DateTime> datelist)
	{
		MinMaxDateTime dateObj = new MinMaxDateTime();
		datelist.sort();
		dateObj.Min = datelist.get(0);
		dateObj.Max = datelist.get(datelist.size()-1);

		return dateObj;
	}

	class MinMaxDate
	{
		public Date Min;
		public Date Max;
	}

	class MinMaxDateTime
	{
		public DateTime Min;
		public DateTime Max;
	}

	public class ActivityException extends Exception{}
}