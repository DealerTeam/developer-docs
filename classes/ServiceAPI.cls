/**
 *	ServiceAPI - General interface to the Service related solutions
 *
 */

public class ServiceAPI
{
	
	public static List<StandardOpCode__c> standardOperationCodes() 
	{
		return [Select Id, Name, Concern__c, Estimate__c, 
					Op_Code_Description__c, Service_Type__c, 
					Book_Time__c, Pay_Type__c
                	FROM StandardOpCode__c
                    WHERE Active__c = true 
					ORDER BY Name ASC
					LIMIT 2000];
	}

	/* Getter for the Misc Charge Types by Location */
	public static List<MiscChargeCode__c> miscChargeCodes(Id locationId) 
	{

		List<MiscChargeCode__c> returnList = new List<MiscChargeCode__c>();
		returnList = [SELECT Location__c, FlatAmount__c, PercentageBasedAmount__c, Active__c, Taxable__c,
							Description__c, BaseCharge__c, ApplicablePayType__c, Id, Name 
						FROM MiscChargeCode__c
						WHERE Location__c=:locationId];
		// If the list is empty, return the picklist value from the object
		if(returnList.isEmpty()) {
			Schema.DescribeFieldResult fieldResult = Service_Misc_Charge__c.Type__c.getDescribe();
			List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
				
			for( Schema.PicklistEntry f : ple) {
				returnList.add( new MiscChargeCode__c(
						Name=f.getValue(),
						Description__c=f.getValue()
					)
				);
			}
		}

		return returnList;
	}


	public static List<DispatchEvent__c> getDispatchEvents(Dealer_Location__c location)
	{
		List<DispatchEvent__c> dEvents = new List<DispatchEvent__c>();

		for(DispatchEvent__c de : ServiceQuerySelector.dispatchEvents(location.Id)) 
		{
			dEvents.add(de);
		}

		return dEvents;
	}

	public static List<Service_Job__c> getJobLinesForDispatch(Dealer_Location__c location)
	{
		return ServiceQuerySelector.jobLinesWithoutDispatchEvent(location.Id);
	}

	public static void storeDispatchEvent(DispatchEvent__c evt)
	{
		try {
			System.debug(evt);
			upsert evt;
		} Catch(DmlException e) {
			throw new DmlException(e.getMessage());
		} Catch(Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	public static void deleteDispatchEvent(DispatchEvent__c evt)
	{
		try {
			delete evt;
		} Catch(DmlException e) {
			throw new DmlException(e.getMessage());
		} Catch(Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}

	public class Technician
	{
		public String FullName {get;set;}
		public Id UserId {get;set;}
	}

    public class DispachedWork 
    {
        public DispatchEvent__c dispatchEvent {get;set;}
        public String startDate {get;set;}
        public String endDate {get;set;}
        public DispachedWork(DispatchEvent__c e)
        {
            dispatchEvent = e;
            startDate = '/Date('+String.valueOf(e.StartDateTime__c.getTime())+')/';
            endDate   = '/Date('+String.valueOf(e.EndDateTime__c.getTime())+')/';
        }
    }  	

	public class ServiceException extends Exception {}

	public static Decimal getWarrantyLaborRate(Id Loc){
		
		Decimal laborRate = 0;
		// //Query to ensure division is available
		// User technician = [SELECT Id, Division FROM User WHERE Id =: techId];

		// //Get the manufacturer and its labor rate from the passed service vehicle
		// Service_Vehicle__c veh = [SELECT Manufacturer__c, Manufacturer__r.WarrantyLaborRate__c 
		// 							  FROM Service_Vehicle__c WHERE Id =: sv LIMIT 1];
		
		// //Determine if the tech has an active cert for the associated manufacturer
		// List<Certification__c> cert = [SELECT Active__c FROM Certification__c WHERE Technician__c =: technician.Id AND Manufacturer__c =: veh.Manufacturer__c AND Active__c = true LIMIT 1];

		// //Use the manufacturer's warranty rate if the user is certified, otherwise use the location default
		// if(cert.size() == 1){
		// 	laborRate = veh.Manufacturer__r.WarrantyLaborRate__c != null ? veh.Manufacturer__r.WarrantyLaborRate__c : laborRate;
		// 	return laborRate;
		// }
		// else{
		// 	Dealer_Location__c[] loc = [SELECT Id, Warranty_Labor_Rate__c FROM Dealer_Location__c WHERE Company_Number__c =: technician.Division LIMIT 1];

		// 	if(loc.size()==1) {
		// 		laborRate = loc[0].Warranty_Labor_Rate__c != null ? loc[0].Warranty_Labor_Rate__c : laborRate;
        //     	return laborRate;
		// 	}
		// }
		List<Dealer_Location__c> locs = [SELECT Warranty_Labor_Rate__c FROM Dealer_Location__c WHERE Location_Account__c =: loc LIMIT 1];
		if(!locs.isEmpty()){
			if(locs[0].Warranty_Labor_Rate__c > 0){
				laborRate = locs[0].Warranty_Labor_Rate__c;
			}
		}
		return laborRate;
	}

}