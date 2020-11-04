/**
 * DealerTrack_Lead
 * @description
 */
public abstract class DealerTrack_Lead 
{
	/**
	 * @description
	 */
	public interface ILead
	{
		void Initialize();
	}	
	
	/**
	 * @description ParnterId, PartnerDealerId required for all calls. Do not add any more properties here.
	 */
	public String PartnerId { get; set; }
    
	/**
	 * @description
	 */ 
	public String PartnerDealerId { get; set; }
    
    /**
	 * @description
	 */
	private virtual class DealerTrack_Lead_Proxy extends DealerTrack_Lead
    {
    	/* Do not add anything else to the DealerTrack_Lead_Proxy class. This assures the position of PrimaryApplicant/BusinessApplicant in the Json object when serialized
    	   It is imperative that the Json object is PartnerId, PartnerDealerId and PrimaryApplicant/BusinessApplicant in the first three indices in that order.
    	   Anything after that is legal. Apex sorts json objects in reverse alphabetical order. This is a solid workaround. */
    	private Map<String, Object> PrimaryApplicant = new Map<String, Object>();
    	private Map<String, Object> BusinessApplicant = new Map<String, Object>();
    }
    
	/**
	 * @description This is the class that gets json serialized for create and update calls, including base classes
	 */
	public virtual class Lead extends DealerTrack_Lead_Proxy implements ILead
	{
		/* transient keeps the objects from being serialized to the rest call
		   Unfortunately we have to new up the transient classes because apex doesn't allow a body on properties-
		   when marked with transient */
		public transient DealerTrack_Applicant.PrimaryApplicant Primary_Applicant = new DealerTrack_Applicant.PrimaryApplicant();
		public transient DealerTrack_Applicant.CoApplicant Co_Applicant = new DealerTrack_Applicant.CoApplicant();
		public transient DealerTrack_Applicant.BusinessApplicant Business_Applicant = new DealerTrack_Applicant.BusinessApplicant();
		public transient DealerTrack_Vehicle.FinancedVehicle FinancedVehicle = new DealerTrack_Vehicle.FinancedVehicle();
		public transient DealerTrack_Vehicle.TradeInVehicle TradeInVehicle = new DealerTrack_Vehicle.TradeInVehicle();
		public transient DealerTrack_Loan Loan = new DealerTrack_Loan();
		public transient DealerTrack_Lead.CustomerNotes Customer_Notes = new DealerTrack_Lead.CustomerNotes();
		public transient DealerTrack_Lead.CustomFields Custom_Fields = new DealerTrack_Lead.CustomFields();
		
		// Other top level nodes
		
		// Enum * "Retail" or "Lease"
		public String FinanceMethod { get; set; }
		// True, False, Null
		public boolean SendAdfEmail = false;
		// String (500)
		public String Comments = '';
		// String (20)
		//public String PrequalificationReferenceNumber { get; set; };
		
		// Maps for nested nodes	
		private Map<String, Object> CoApplicant = new Map<String, Object>();
		private Map<String, Object> VehicleInfo = new Map<String, Object>();
		private Map<String, Object> TradeInVehicleInfo = new Map<String, Object>();
		private Map<String, Object> LoanInfo = new Map<String, Object>();
		private Map<String, Object> CustomerNotes = new Map<String, Object>();
		private Map<String, Object> CustomFields = new Map<String, Object>();
		
		// Initialize the nested objects
		public void Initialize()
		{   
			// PrimaryApplicant First and Last name are the minimum required to create a lead
			if(Primary_Applicant.FirstName != null && Primary_Applicant.LastName != null)
			{         
	            PopulateNode(Primary_Applicant, PrimaryApplicant);
	            
	            /* These must be added to PrimaryApplicant last because DealerTrack's service looks for them first
	               and will fail if they are out of order. Map is first in last out */            
	            PrimaryApplicant.put('a:LastName', Primary_Applicant.LastName);
	            PrimaryApplicant.put('a:FirstName', Primary_Applicant.FirstName);
			
			} else { AddNullNameSpace(PrimaryApplicant); }
			
			// BusinessApplicant First and Last name are the minimum required to create a lead
			if(Business_Applicant.BusinessName != null)
			{         
	            PopulateNode(Business_Applicant, BusinessApplicant);
	            
	            /* These must be added to BusinessApplicant last because DealerTrack's service looks for them first
	               and will fail if they are out of order. Map is first in last out */            
	            BusinessApplicant.put('a:LastName', Business_Applicant.LastName);
	            BusinessApplicant.put('a:FirstName', Business_Applicant.FirstName);
			
			} else { AddNullNameSpace(BusinessApplicant); }
			
			// Logic to make sure we have at least the minimum fields populated or we add null namespace schema
			if(Co_Applicant.FirstName != null && Co_Applicant.LastName != null)
				PopulateNode(Co_Applicant, CoApplicant);
			  else
				AddNullNameSpace(CoApplicant);
				
			if(FinancedVehicle.Year != null && FinancedVehicle.Make != null)
				PopulateNode(FinancedVehicle, VehicleInfo);
			  else
				AddNullNameSpace(VehicleInfo);
				
			if(TradeInVehicle.Year != null && TradeInVehicle.Make != null)
				PopulateNode(TradeInVehicle, TradeInVehicleInfo);
			  else
				AddNullNameSpace(TradeInVehicleInfo);
				
			if(Loan.CashSellingPrice != null)
				PopulateNode(Loan, LoanInfo);
			  else
				AddNullNameSpace(LoanInfo);
				
			if(Customer_Notes.Content != null || Customer_Notes.Title != null)
			   PopulateNode(Customer_Notes, CustomerNotes);
			  else
			   AddNullNameSpace(CustomerNotes);
			   
			if(Custom_Fields.Name != null || Custom_Fields.Value != null)
			   PopulateNode(Customer_Notes, CustomerNotes);
			  else
			   AddNullNameSpace(CustomerNotes);	
		}		
	}

    /**
	 * @description Updates an existing lead
	 */
	public class UpdateLead extends Lead
    {
    	public String LeadReferenceNumber { get; set; }
    }
    	
    /**
	 * @description Gets an existing lead
	 */
	public class ExistingLead extends DealerTrack_Lead
    {
    	public String LastName { get; set; }
    	public String LeadReferenceNumber { get; set; }
    }
    
	/**
	 * @description
	 */
    public class CustomerNotes
    {
    	public String Title { get; set; }
    	public String Content { get; set; }
    }
    
	/**
	 * @description
	 */
    public class CustomFields
    {
    	public String Name { get; set; }
    	public String Value { get; set; }    	
    }
    
	/**
	 * PopulateNode 
	 * @param  properties 
	 * @param  nodeMap  
	 * @return void
	 * @description Helper method to populate nodes  
	 */
	private void PopulateNode(object properties, Map<String, Object> nodeMap)
	{
		String serializedClass = JSON.serialize(properties);
	
		Map<String, Object> tempMap = (Map<String, Object>)JSON.deserializeUntyped(serializedClass);
		
		for (String key : tempMap.keySet())
		{
			object value = tempMap.get(key);
			
			if(value != null)
			  nodeMap.put('a:' + key, value);
		}
		
		// Adds namespace schema
		nodeMap.put('@', new Map<String,Object> 
		  {
			'xmlns:a' => 'http://schemas.datacontract.org/2004/07/DealerTrack.DataContracts.Lead'
		  });
	}
	
	/**
	 * AddNullNameSpace
	 * @param  nodeMap 
	 * @return void
	 * @description
	 */ 
	private void AddNullNameSpace(Map<String, Object> nodeMap)
	{
		// Adds null namespace
		nodeMap.put('@', new Map<String,Object> 
		  {
			'i:nil' => 'true'
		  });		
	}
   
}