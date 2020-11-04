/**
 * DealerTrack_Applicant
 * @description
 */
public abstract class DealerTrack_Applicant 
{
		/**
		 * @description Common Applicant Base Properties - First and Last Names must be kept transient here
		 */
		public transient String FirstName { get; set; }
		
		/**
		 * @description
		 */
		public String MiddleInitial { get; set; }
		
		/**
		 * @description
		 */
		public transient String LastName { get; set; }
		
		/**
		 * @description
		 */
		public String Suffix { get; set; }
		
		/**
		 * @description
		 */
		public String EmailAddress { get; set; }
		
		/**
		 * @description
		 */
		public String SSN { get; set; }
		
		/**
		 * @description
		 */
		public String DateOfBirth { get; set; }		
		
		/**
		 * @description
		 */
		public String DriverLicenseNumber { get; set; }
		
		/**
		 * @description
		 */
		public String DriverLicenseState { get; set; }		
		
		/**
		 * @description
		 */
		public String HomePhone { get; set; }
		
		/**
		 * @description
		 */
		public String CellPhone { get; set; }
		
		/**
		 * @description
		 */
		public String AddressLine1 { get; set; }
		
		/**
		 * @description
		 */
		public String AddressLine2 { get; set; }
		
		/**
		 * @description
		 */
		public String City { get; set; }
		
		/**
		 * @description
		 */
		public String State { get; set; }
		
		/**
		 * @description
		 */
		public String ZipCode { get; set; }
		
		/**
		 * @description
		 */
		public String HousingStatus { get; set; }
		
		/**
		 * @description
		 */
		public String MortgageOrRent { get; set; }
		
		/**
		 * @description
		 */
		public String TotalMonthsAtAddress { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousAddressLine1 { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousAddressLine2 { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousCity { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousState { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousZipCode { get; set; }
		
		/**
		 * @description
		 */
		public String TotalMonthsAtPreviousAddress { get; set; }		
		
		/**
		 * @description
		 */
		public String TotalMonthsEmployed { get; set; }
		
		/**
		 * @description
		 */
		public String MonthlyIncome { get; set; }
		
		/**
		 * @description
		 */
		public String OtherMonthlyIncome { get; set; }
		
		/**
		 * @description
		 */
		public String OtherIncomeSource { get; set; }		
		
		/**
		 * @description
		 */
		public String EmploymentStatus { get; set; }
		
		/**
		 * @description
		 */
		public String EmployedBy { get; set; }
		
		/**
		 * @description
		 */
		public String BusinessPhone { get; set; }		
		
		/**
		 * @description
		 */
		public String Occupation { get; set; }
		
		/**
		 * @description
		 */
		public List<AddressType> EmployerAddress { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousEmploymentStatus { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousEmployedBy { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousBusinessPhone { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousOccupation { get; set; }
		
		/**
		 * @description
		 */
		public List<AddressType> PreviousEmployerAddress { get; set; }
		
		/**
		 * @description
		 */
		public String PreviousTotalMonthsEmployed { get; set; }
		
		/**
		 * @description
		 */
		public String PreferredLanguage { get; set; }
		
		/**
		 * @description
		 */
		public String PreferredContactMethod { get; set; }
		
		/**
		 * @description
		 */
		public class PrimaryApplicant extends DealerTrack_Applicant
		{
			// Do not remove class. Inherits from base.
		}
		
		/**
		 * @description
		 */ 
		public class CoApplicant extends DealerTrack_Applicant
		{
			public String Relationship { get; set; }
		}
		
		/**
		 * @description
		 */
		public class BusinessApplicant extends DealerTrack_Applicant
		{
			public String BusinessTaxId { get; set; }
			// BusinessName Required
			public String BusinessName { get; set; }
			public String BusinessEstablishedDate { get; set; }
			public String StateOfIncorporation { get; set; }
			public String BusinessPhoneNo { get; set; }
			public List<FinancialStatementType> FinancialStatement { get; set; }
			public String YearsInBusiness { get; set; }
			public String NumberOfEmployees { get; set; }
			public String BankName { get; set; }
			public String BankAccountNo { get; set; }
			public String BankContactName { get; set; }
			public String BankContactPhoneNo { get; set; }
		}
		
		/**
		 * @description
		 */
		public class AddressType
		{
			public String AddressLine1 { get; set; }
			public String AddressLine2 { get; set; }
			public String City { get; set; }
			public String State { get; set; }
			public String ZipCode { get; set; }			
		}
		
		/**
		 * @description
		 */
		public class FinancialStatementType
		{
			public String type_desc { get; set; }
			public String type_code { get; set; }
		}
}