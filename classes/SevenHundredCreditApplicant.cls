public class SevenHundredCreditApplicant 
{
    public class PrimaryApplicant
    {
    	// Applicant Full Name
	 	public String NAME { get; set; }
		public String SSN { get; set; }
		public String ADDRESS { get; set; }
		public String CITY { get; set; }
		public String STATE { get; set; }
		public String ZIP { get; set; }
		public String DOB { get; set; }
		public String EMAIL { get; set; }
		public String PREVADDRESS { get; set; }
		public String PREVCITY { get; set; }
		public String PREVSTATE { get; set; }
		public String PREVZIP { get; set; }
		public String EMPLOYER { get; set; }
		public String POSITION { get; set; }
		public String WPHONE { get; set; }
		public String MOBILE { get; set; }
		public String YEARS { get; set; } // years employed
		public String TYPEOFBUSINESS { get; set; }
		public String MINCOME { get; set; }
		public String OTHERINCOME { get; set; }
		public String OTHERINCOMEEXPLN { get; set; }
		public String MONTHS { get; set; } // months employed   	
    }
    
    public class CoApplicant
    {
    	// SPOUSE = Co-Applicant Full Name
		public String SPOUSE { get; set; } 
		public String SPOUSESSN { get; set; }
		public String SPOUSEAGE { get; set; }
		public String SPOUSEDOB { get; set; }
		public String SPOUSEADDRESS { get; set; }
		public String SPOUSECITY { get; set; }
		public String SPOUSESTATE { get; set; }
		public String SPOUSEZIP { get; set; }    	
    }
}