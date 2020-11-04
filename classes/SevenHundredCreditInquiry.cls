public abstract class SevenHundredCreditInquiry 
{
	public interface IInquiry
	{
		void Initialize();
	}
	
	public class InquiryBaseProperties
	{
		public String ACCOUNT { get; set; }
		public String PASSWD { get; set; }
		public String PRODUCT { get; set; } // Enum - CREDIT, OFAC, IDCHECK, REDFLAG ,PRESCR, SAVEONLY
		// Either BUREAU or MULTIBUR will be sent/populated, not both.
		public String BUREAU { get; set; } // Enum - TU, XPN, EFX - Example: "XPN"
		public String MULTIBUR { get; set; } // Enum - TU, XPN, EFX - Example: "TU:XPN:EFX"
		private String PASS = '2';
		private String PROCESS = 'PCCREDIT';
	
	    /* User Data */
	    // User Name of User in Affiliate system recorded for auditing purposes 
		public String A_USER_NAME { get; set; }
		// User Id from affiliate system to be recorded with record of transaction 
		public String A_USER_ID { get; set; }
		// Indicates if original application was modified, if so and bureau was already requested, should be set to Y so that the duplicate check is bypassed and a new report is obtained. 
		public String APP_MODIFIED { get; set; }
	}
	
	// This is the class that gets JSON serialized. It contains one popuplated map "Data"
	public class Inquiry extends SevenHundredCreditInquiry implements IInquiry
	{
		public transient InquiryBaseProperties Properties = new InquiryBaseProperties();		
		public transient SevenHundredCreditApplicant.PrimaryApplicant PrimaryApplicant = new SevenHundredCreditApplicant.PrimaryApplicant();
		public transient SevenHundredCreditApplicant.CoApplicant CoApplicant = new SevenHundredCreditApplicant.CoApplicant();
		public transient SevenHundredCreditVehicle Vehicle = new SevenHundredCreditVehicle();
		
		private Map<String, Object>	Data = new Map<String, Object>();
		
		public void Initialize()
		{
			if(Vehicle.YEAR != null && Vehicle.NMAKE != null)
				PopulateMap(Vehicle, Data);
				
			if(CoApplicant.SPOUSE != null && CoApplicant.SPOUSESSN != null)
				PopulateMap(CoApplicant, Data);
				
			if(PrimaryApplicant.NAME != null && PrimaryApplicant.SSN != null)
				PopulateMap(PrimaryApplicant, Data);
				
			PopulateMap(Properties, Data);				
		}
	}

    // Helper method to populate payload map
	private void PopulateMap(object properties, Map<String, Object> dataMap)
	{
		String serializedClass = JSON.serialize(properties);
	
		Map<String, Object> tempMap = (Map<String, Object>)JSON.deserializeUntyped(serializedClass);
		
		for (String key : tempMap.keySet())
		{
			object value = tempMap.get(key);
			
			if(value != null)
			  dataMap.put(key, value);
		}
		
	}

}