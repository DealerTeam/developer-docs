/**
 * CarFaxReportHandler 
 * @description
 */ 
public class CarFaxReportHandler 
{
	
	/**
	 * CreateRequest description
	 * @param  vins           
	 * @param  carFaxUname    
	 * @param  carFaxPassword 
	 * @param  reportType     
	 * @return  RequestResult              
	 * @description Takes a set of service vehicle vin's. Get's the carfax and updates the vehicle
	 */
	public static RequestResult CreateRequest(Set<string> vins, string carFaxUname, string carFaxPassword, string reportType)
	{
		Service_Vehicle__c[] vehicles = [SELECT VIN__c, CarFaxAccidentCount__c, CarFaxAccidentIndicator__c, CarFaxBrandedTitleIndicator__c, CarFaxDamageIndicator__c, CarFaxFrameDamageIndicator__c,
			CarFaxMajorProblemIndicator__c, CarfaxVHR__c, CarfaxNumberOfOwners__c, CarfaxServiceRecordCount__c From Service_Vehicle__c WHERE VIN__c IN :vins];
		
		RequestResult result = new RequestResult();

		if(vehicles.size() < 1)
		{
			result.messages.add('No matching VIN numbers found');
			result.success = false;
			return result;
		}
		
		List<Service_Vehicle__c> vehiclesToUpdate = new List<Service_Vehicle__c>();
		for (Service_Vehicle__c vehicle : vehicles)
		{
			CarFaxAPI.Request req = new CarFaxAPI.Request();
			req.VIN = vehicle.VIN__c;
			req.UserName = carFaxUname; 
			req.Password = carFaxPassword;
			req.ReportType = reportType;

			CarFaxAPI.Response resp = CarFaxAPI.CreateRequest(req);

			if(resp.Errors != null && resp.Errors.size() > 0)
			{
				result.messages.add('Error for VIN: ' + vehicle.VIN__c + ' Error:' + resp.Errors);
				result.success = false;
			}
			else
			{
				vehicle.CarFaxAccidentCount__c = (resp.AccidentCount!=null) ? integer.ValueOf(resp.AccidentCount) : null;
				vehicle.CarFaxAccidentIndicator__c = boolean.ValueOf(resp.AccidentIndicator); 
				vehicle.CarFaxBrandedTitleIndicator__c = boolean.ValueOf(resp.BrandedTitleIndicator);
				vehicle.CarFaxDamageIndicator__c = boolean.ValueOf(resp.DamageIndicator);
				vehicle.CarFaxFrameDamageIndicator__c = boolean.ValueOf(resp.FrameDamageIndicator);
				vehicle.CarFaxMajorProblemIndicator__c = boolean.ValueOf(resp.MajorProblemIndicator);
				vehicle.CarfaxVHR__c =  resp.VehicleHistoryReportUrl;
				vehicle.CarfaxNumberOfOwners__c = integer.ValueOf(resp.NumberOfOwners);
				vehicle.CarfaxServiceRecordCount__c = integer.ValueOf(resp.ServiceRecordCount);
				vehicle.CarfaxLastRunDate__c = Date.today();
				System.debug(vehicle);

				vehiclesToUpdate.add(vehicle);
			}
		}

		// if we have vehicles to update perform update
		if(!vehiclesToUpdate.isEmpty()) {
			try {
				update vehiclesToUpdate;
			} Catch(DmlException e) {
				//
			}
		}

		return result;
	}

	/**
	 * RequestResult
	 * @description
	 */
	public class RequestResult
	{
		public boolean success = true;
		public List<string> messages = new List<string>();
	}
}