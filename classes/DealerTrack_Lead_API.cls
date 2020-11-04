/**
 * DealerTrack_Lead_API
 * @description
 */
public class DealerTrack_Lead_API 
{
	/**
	 * @description
	 */
	Static final String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') + '/dealertrack/leads/' : Utility.DMSConfiguration('DMSSyncEndpointSandbox') + '/dealertrack/leads/';
	
	/**
	 * CreateLead 
	 * @param  lead 
	 * @return LeadResponse
	 * @description Returns a Lead Response Object
	 */
	public static LeadResponse CreateLead(DealerTrack_Lead.ILead lead)
	{
		lead.Initialize();
		return (LeadResponse)JSON.deserialize(EnterpriseControllerAPI.CallOut(baseUrl + 'createlead', JSON.serialize(lead)), LeadResponse.class);
	}
	
	/**
	 * UpdateLead 
	 * @param  lead 
	 * @return LeadResponse
	 * @description
	 */
	public static LeadResponse UpdateLead(DealerTrack_Lead.ILead lead)
	{
		lead.Initialize();
		return (LeadResponse)JSON.deserialize(EnterpriseControllerAPI.CallOut(baseUrl + 'updatelead', JSON.serialize(lead)), LeadResponse.class);
	}
	
	/**
	 * GetLead 
	 * @param  lead 
	 * @return LeadResponse
	 * @description Returns a Lead Response Object
	 */
	public static LeadResponse GetLead(DealerTrack_Lead.ExistingLead lead)
	{
		return (LeadResponse)JSON.deserialize(EnterpriseControllerAPI.CallOut(baseUrl + 'getlead', JSON.serialize(lead)), LeadResponse.class);
	}
			
	/**
	 * @description We only need a few values here as most values are a mirror of the credit application object
	 */
	public class LeadResponse
	{
		public String LeadReferenceNumber { get; set; }
		public String LeadUpdateDate { get; set; }
		public String LeadDetailUrl { get; set; }
	}
	
    
}