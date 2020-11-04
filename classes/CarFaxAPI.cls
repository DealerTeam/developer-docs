/**
 * CarFaxAPI 
 * @description
 */
public class CarFaxAPI 
{
    /**
	 * CreateRequest 
	 * @param  request 
	 * @return Response 
	 * @description       
	 */
	public static Response CreateRequest(CarFaxAPI.Request request)
    {
		String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
		Response r = (Response)JSON.deserialize(EnterpriseControllerAPI.CallOut(baseUrl+'/carfax/requests/getcarfax', JSON.serialize(request)), Response.class);
    	return r;
    }

	/**
	 * Request
	 * @description
	 */
	public inherited sharing class Request
	{
    	public String vin { get; set; }
    	public String username { get; set; }
    	public String password { get; set; }
		public String reportType { get; set; }
	}
    
	/**
	 * Response
	 * @description
	 */ 
    public inherited sharing class Response
    {
    	public String AccidentCount { get; set; }
    	public String AccidentIndicator { get; set; }
    	public String BrandedTitleIndicator { get; set; }
    	public String DamageIndicator { get; set; }
    	public String FrameDamageIndicator { get; set; }
    	public String MajorProblemIndicator { get; set; }
		public String VehicleHistoryReportUrl { get; set; }
		public String NumberOfOwners { get; set; }
		public String ServiceRecordCount { get; set; }
		public String[] Errors { get; set; }
	}
	
	public class CarFaxAPIException extends Exception{}
    
}