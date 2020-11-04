/**
 * DealerTrackEnums
 * @description
 */
public class DealerTrackEnums 
{   
	/**
	 * @description Lead related dealertrack enums  
	 */
	public Map<string, string> LeadType
	{
		get
		{
			return new Map<String, String> { 'Personal' => 'Personal', 'Individual' => 'Personal', 'Individual w/Co-Applicant' => 'Personal', 'Business' => 'Business','Business w/Co-Applicant' => 'Business' };
		}
	}

	/**
	 * @description
	 */
	public Map<string, string> FinanceMethod
	{
		get
		{
			return new Map<String, String> { 'Retail' => 'Retail', 'Lease' => 'Lease' };
		}
	}

	/**
	 * @description Applicant(s) related dealertrack enums
	 */
	public Map<string, string> Suffix
	{
		get
		{
			return new Map<String, String> { 'I' => 'I', 'II' => 'II', 'III' => 'III', 'IV' => 'IV', 'JR' => 'JR', 'SR' => 'SR' };
		}
	}

	/**
	 * @description
	 */
	public Map<string, string> HousingStatus
	{
		get
		{
			return new Map<String, String> 
			{ 
				'Mortgage' => 'Mortgage', 'Buying home' => 'Mortgage',
				'Rent' => 'Rent', 'Renting/Leasing' => 'Rent',
				'Family' => 'Family', 'Living w/relatives' => 'Family',
				'Own Outright' => 'OwnOutright', 'Owns home outright' => 'Ownoutright',
				'Military' => 'Military',
				'Other' => 'Other', 'Unknown' => 'Other'
			};
		}
	}

	/**
	 * @description
	 */
	public Map<string, string> EmploymentStatus
	{
		get
		{
			return new Map<String, String> 
			{ 
				'Employed' => 'Employed','Full Time' => 'Employed', 'Part Time' => 'Employed',
				'Unemployed' => 'Unemployed',
				'Retired' => 'Retired',
				'Active Military' => 'ActiveMilitary',
				'Retired Military' => 'RetiredMilitary',
				'Self Employed' => 'SelfEmployed','Contract' => 'SelfEmployed',
				'Student' => 'Student',
				'Other' => 'Other', 'Not Applicable' => 'Other','Seasonal' => 'Other', 'Temporary' => 'Other'
			};
		}
	}

	/**
	 * @description
	 */
	public Map<string, string> CoAppRelationship
	{
		get
		{
			return new Map<String, String> 
			{ 
				'Civil Union' => 'CivilUnion', 
				'Registered Domestic Partner' => 'RegDomPr', 'Resides With' => 'RegDomPr',
				'Spouse' => 'Spouse', 
				'Relative' => 'Relative', 'Parent' => 'Relative',
				'Other' => 'Other'
			};
		}
	}

	/**
	 * @description
	 */
	public Map<string, string> PreferredContactMethod
	{
		get
		{
			return new Map<String, String> { 'Business Phone' => 'BusinessPhone', 'Home Phone' => 'HomePhone', 'Cell Phone' => 'CellPhone', 'Email' => 'Email' };
		}
	}

}