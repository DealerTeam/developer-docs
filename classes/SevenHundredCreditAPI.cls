public class SevenHundredCreditAPI 
{
    public static InquiryResponse CreateInquiry(SevenHundredCreditInquiry.IInquiry inquiry)
    {
    	inquiry.Initialize();    
    	return (InquiryResponse)JSON.deserialize(EnterpriseControllerAPI.CallOut('https://njs-dev.dealerteam.com/700credit/inquiries/createinquiry', JSON.serialize(inquiry)), InquiryResponse.class);
    }
    
    public class InquiryResponse
    {
    	public String Transid { get; set; }
    	public String Token { get; set; }
    	public String ResultCode { get; set; }
    	public String ResultDescription { get; set; }
    	public String Tier { get; set; }
		// CREDIT
    	public String ApplicantExperianScore { get; set; }
		public String ApplicantEquifaxScore { get; set; }
		public String ApplicantTransUnionScore { get; set; }
    	public String CoApplicantExperianScore { get; set; }
		public String CoApplicantEquifaxScore { get; set; }
		public String CoApplicantTransUnionScore { get; set; }
		// OFAC
		public String ApplicantOFACResult { get; set; }
		public String CoApplicantOFACResult { get; set; }
		// REDFLAG
		public String ApplicantRedFlagSummary { get; set; }
		public String CoApplicantRedFlagSummary { get; set; }
		public String ApplicantRedFlagScore { get; set; }
		public String CoApplicantRedFlagScore { get; set; }
		public String ApplicantRedFlagOFACResult { get; set; }
		public String CoApplicantRedFlagOFACResult { get; set; }
		// PreScreen or PreQualify Score
		public String PreScore { get; set; }
    	public String IframeUrl { get; set; }
    	public String Product { get; set; }
		public String Error { get; set; }
    }
    
}