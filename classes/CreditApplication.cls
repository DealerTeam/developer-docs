/**
 * CreditApplication
 * @description
 */ 
public with sharing class CreditApplication {

    /**
     * @description
     */
     Credit_Application__c CreditApplication = new Credit_Application__c();
     
    /**
     * @description
     */
     public String ApplicantFirstName{get;set;}
     
    /**
     * @description
     */
     public String ApplicantLastName{get;set;}
     
    /**
     * @description
     */
     public Date ApplicantBirthdate{get;set;}
     
    /**
     * @description
     */
     public Boolean IsApplicant{get;set;}
     
     /**
     * @description
     */
     public Boolean IsCOApplicant{get;set;}
     
     /**
     * @description
     */
     public Boolean AssetSection{get;set;}
     
     /**
     * @description
     */
     public Boolean errMsg = false;
     
     /**
     * @description
     */
     public Boolean isStep1 {get;set;}
     
     /**
     * @description
     */
     public Boolean isStep2 {get;set;}
     
     /**
     * @description
     */
     public Boolean isStep3 {get;set;}
     
     /**
     * @description
     */
     public String COApplicantFirstName{get;set;}
     
     /**
     * @description
     */
     public String COApplicantLastName{get;set;}
     
     /**
     * @description
     */
     public Date COApplicantBirthdate{get;set;}
     
     /**
     * @description
     */
     public Boolean isNextCOApplicant=false;
     
     /**
     * @description
     */
     public Boolean isFirstImage{get;set;}
     
     /**
     * @description
     */
     public Boolean isSecondImage{get;set;}
     
     /**
     * @description
     */
     public Boolean isThirdImage{get;set;}
     
     /**
      * CreditApplication 
      * @param  Controller 
      * @description
      */
     public CreditApplication( Apexpages.Standardcontroller Controller ) 
     {
        IsApplicant=true;
        isStep1=true;
        isStep2=false;
        isStep3=true;
        isFirstImage=true;isSecondImage=false;isThirdImage=false;   
        
     }
     
     /*
     
     public Credit_Application__c getCreditApplication()
     {
        return CreditApplication;
     }
     
     public void ApplicantDetails(){
        Contact Applicantdetails=[select id,
                                    FirstName,
                                    LastName,Birthdate 
                                    from Contact 
                                    where ID= :CreditApplication.Buyer__c];
        ApplicantFirstName=Applicantdetails.FirstName;
        ApplicantLastName=Applicantdetails.LastName;
        ApplicantBirthdate=Applicantdetails.Birthdate;
        
     }
     public void COApplicantDetails(){
        Contact COApplicantdetails=[select id,
                                    FirstName,
                                    LastName,Birthdate 
                                    from Contact 
                                    where ID= :CreditApplication.CO_Buyer__c];
        COApplicantFirstName=COApplicantdetails.FirstName;
        COApplicantLastName=COApplicantdetails.LastName;
        COApplicantBirthdate=COApplicantdetails.Birthdate;
        
     }
     public void PreviousCOApplicant(){
        isApplicant=true;
        IsCOApplicant=false;
        isStep2=false;
        AssetSection=false;
        if(!isNextCOApplicant){ isStep3=true;}
        isFirstImage=true;isSecondImage=false;isThirdImage=false;
        
     }
     public void SubmitApplicant()
     {
            
            if(ApplicantLastName==null || ApplicantLastName==''){
                ApexPages.Message msgForm = new ApexPages.Message(ApexPages.severity.Error,'Please Enter Last Name');
                ApexPages.addMessage(msgForm);
                errMsg=true;
            }
            else{
                AssetSection=false;
                IsApplicant=false;
                IsCOApplicant=true;
                errMsg=false;
                isStep1=false;
                isStep2=true;
                isStep3=false;
                isFirstImage=false;isSecondImage=true;isThirdImage=false;
            }
        
     }
     public boolean getRenderErrMsg(){   
        return errMsg;
    }
     public void NextCOApplicant(){
        if(CoApplicantLastName==null || COApplicantLastName==''){
                ApexPages.Message msgForm = new ApexPages.Message(ApexPages.severity.Error,'Please Enter Last Name');
                ApexPages.addMessage(msgForm);
                errMsg=true;
            }
        else{
            AssetSection=true;
            IsApplicant=false;
            IsCOApplicant=false;
            isStep1=false;
            isStep2=false;
            isStep3=true;
            errMsg=false;
            isNextCOApplicant=true;
            isFirstImage=false;isSecondImage=false;isThirdImage=true;
            System.debug('>>>>'+CreditApplication+COApplicantFirstName+COApplicantLAstName+ApplicantFirstName+ApplicantLastName);
        }
     }
     public void PreviousSubmit(){
        AssetSection=false;
        IsApplicant=false;
        IsCOApplicant=true;
        errMsg=false;
        isFirstImage=false;isSecondImage=true;isThirdImage=false;
        System.debug('>>>>'+CreditApplication+COApplicantFirstName+COApplicantLAstName+ApplicantFirstName+ApplicantLastName);
     }
     public pagereference Submit(){
        Credit_Application__c CA=new Credit_Application__c();
        if(CreditApplication.Buyer__c==null){
            // create customer with LastName and First Name
            Contact NewBuyer=new Contact(LastName=ApplicantLastName,FirstName=ApplicantFirstName);
            insert NewBuyer;
            CA.Buyer__c=NewBuyer.ID;
        }
        else{
            CA.Buyer__c=CreditApplication.Buyer__c; 
        }
        
        CA.First_Name__c =   ApplicantFirstName;
        CA.Last_Name__c =   ApplicantLastName;
        CA.Birthdate__c =   ApplicantBirthdate;
        CA.Address__c =   CreditApplication.Address__c;
        CA.Co_App_First_Name__c =   COApplicantFirstName;
        CA.Co_App_Last_Name__c =   COApplicantLastName;
        if(CreditApplication.Co_Buyer__c==null){
            // create customer with LastName and First Name
            Contact NewCOBuyer=new Contact(LastName=COApplicantLastName,FirstName=COApplicantFirstName);
            insert NewCOBuyer;
            CA.Co_Buyer__c=NewCOBuyer.ID;
        }
        else{
            CA.Co_Buyer__c=CreditApplication.Co_Buyer__c;   
        }
        
         CA.Age_Of_Dependent_1__c =   CreditApplication.Age_Of_Dependent_1__c;
         CA.Age_Of_Dependent_2__c =   CreditApplication.Age_Of_Dependent_2__c;
         CA.Age_Of_Dependent_3__c =   CreditApplication.Age_Of_Dependent_3__c;
         CA.Home_Phone__c =   CreditApplication.Home_Phone__c;
         CA.Driver_License_No__c =   CreditApplication.Driver_License_No__c;
         
         CA.How_Long_Months__c =   CreditApplication.How_Long_Months__c;
         CA.How_Long_Years__c =   CreditApplication.How_Long_Years__c;
         CA.Initial__c =   CreditApplication.Initial__c;
         
         CA.Marital_Status__c =   CreditApplication.Marital_Status__c;
         CA.Occupation_Or_Rank__c =   CreditApplication.Occupation_Or_Rank__c;
         CA.Relationship__c =   CreditApplication.Relationship__c;
         CA.Relative_Address__c =   CreditApplication.Relative_Address__c;
         CA.Relative_City__c =   CreditApplication.Relative_City__c;
         CA.Relative_Phone__c =   CreditApplication.Relative_Phone__c;
         CA.Relative_State__c =   CreditApplication.Relative_State__c;
         CA.Relative_Zip__c =   CreditApplication.Relative_Zip__c;
         CA.Social_Security_Number__c =   CreditApplication.Social_Security_Number__c;
         CA.State__c =   CreditApplication.State__c;
         CA.BirthDate__c =   CreditApplication.BirthDate__c;
         CA.City__c =   CreditApplication.City__c;
         
         CA.Applicant_Support__c =   CreditApplication.Applicant_Support__c;
         CA.Applicant_Support_Under__c =   CreditApplication.Applicant_Support_Under__c;
         CA.Applicants_Gross_Monthly_Income__c =   CreditApplication.Applicants_Gross_Monthly_Income__c;
         CA.Previous_Address_1__c =   CreditApplication.Previous_Address_1__c;
         CA.Previous_Address_2__c =   CreditApplication.Previous_Address_2__c;
         CA.Previous_City_1__c =   CreditApplication.Previous_City_1__c;
         CA.Previous_City_2__c =   CreditApplication.Previous_City_2__c;
         CA.Previous_Employment1__c =   CreditApplication.Previous_Employment1__c;
         CA.Previous_Employment1_Address__c =   CreditApplication.Previous_Employment1_Address__c;
         CA.Previous_Employment1_City__c =   CreditApplication.Previous_Employment1_City__c;
         CA.Previous_Employment1_How_Long_Months__c =   CreditApplication.Previous_Employment1_How_Long_Months__c;
         CA.Previous_Employment1_How_Long_Years__c =   CreditApplication.Previous_Employment1_How_Long_Years__c;
         CA.Previous_Employment1_Phone__c =   CreditApplication.Previous_Employment1_Phone__c;
         CA.Previous_Employment1_State__c =   CreditApplication.Previous_Employment1_State__c;
         CA.Previous_Employment1_Zip__c =   CreditApplication.Previous_Employment1_Zip__c;
         CA.Previous_Employment2__c =   CreditApplication.Previous_Employment2__c;
         CA.Previous_Employment2_Address__c =   CreditApplication.Previous_Employment2_Address__c;
         CA.Previous_Employment2_City__c =   CreditApplication.Previous_Employment2_City__c;
         CA.Previous_Employment2_How_Long_Months__c =   CreditApplication.Previous_Employment2_How_Long_Months__c;
         CA.Previous_Employment2_How_Long_Years__c =   CreditApplication.Previous_Employment2_How_Long_Years__c;
         CA.Previous_Employment2_Phone__c =   CreditApplication.Previous_Employment2_Phone__c;
         CA.Previous_Employment2_State__c =   CreditApplication.Previous_Employment2_State__c;
         CA.Previous_Employment2_Zip__c =   CreditApplication.Previous_Employment2_Zip__c;
         CA.Previous_State_1__c =   CreditApplication.Previous_State_1__c;
         CA.Previous_State_2__c =   CreditApplication.Previous_State_2__c;
         CA.Previous_Zip_1__c =   CreditApplication.Previous_Zip_1__c;
         CA.Previous_Zip_2__c =   CreditApplication.Previous_Zip_2__c;
         CA.Previous1_How_Long_Months__c =   CreditApplication.Previous1_How_Long_Months__c;
         CA.Previous1_How_Long_Years__c =   CreditApplication.Previous1_How_Long_Years__c;
         CA.Previous1_Lived_In_Community_Months__c =   CreditApplication.Previous1_Lived_In_Community_Months__c;
         CA.Previous1_Lived_In_Community_Years__c =   CreditApplication.Previous1_Lived_In_Community_Years__c;
         CA.Previous2_How_Long_Months__c =   CreditApplication.Previous2_How_Long_Months__c;
         CA.Previous2_How_Long_Years__c =   CreditApplication.Previous2_How_Long_Years__c;
         CA.Previous2_Lived_In_Community_Months__c =   CreditApplication.Previous2_Lived_In_Community_Months__c;
         CA.Previous2_Lived_In_Community_Years__c =   CreditApplication.Previous2_Lived_In_Community_Years__c;
         CA.Nearest_Relative__c =   CreditApplication.Nearest_Relative__c;
         ///////////////////////////////////////////////////////////////////
         
            
         CA.X2nd_Mortage_Amount__c =  CreditApplication.X2nd_Mortage_Amount__c;
         
         CA.Age_Of_Home__c =   CreditApplication.Age_Of_Home__c;
         CA.Any_Law_Suits_Pending_Against_You__c =   CreditApplication.Any_Law_Suits_Pending_Against_You__c;
         CA.Any_Property_Repossessed__c =   CreditApplication.Any_Property_Repossessed__c;
         
         CA.Asset_Type__c =   CreditApplication.Asset_Type__c;
         CA.Bank_Account_Balance1__c =   CreditApplication.Bank_Account_Balance1__c;
         CA.Bank_Account_Balance2__c =   CreditApplication.Bank_Account_Balance2__c;
         CA.Bank_Account_No_1__c =   CreditApplication.Bank_Account_No_1__c;
         CA.Bank_Account_No_2__c =   CreditApplication.Bank_Account_No_2__c;
         CA.Bank_Account_Type1__c =   CreditApplication.Bank_Account_Type1__c;
         CA.Bank_Account_Type2__c =   CreditApplication.Bank_Account_Type2__c;
         CA.Bank_Branch_Address1__c =   CreditApplication.Bank_Branch_Address1__c;
         CA.Bank_Branch_Address2__c =   CreditApplication.Bank_Branch_Address2__c;
         CA.Bank_Reference1__c =   CreditApplication.Bank_Reference1__c;
         CA.Bank_Reference2__c =   CreditApplication.Bank_Reference2__c;
        
         CA.Co_App_Occupation_Or_Rank__c =   CreditApplication.Co_App_Occupation_Or_Rank__c;
         CA.Co_Applicant_Support__c =   CreditApplication.Co_Applicant_Support__c;
         CA.Co_Applicant_Support_Under__c =   CreditApplication.Co_Applicant_Support_Under__c;
         CA.Co_App_Address__c =   CreditApplication.Co_App_Address__c;
         CA.Co_App_Age_of_Dependent_1__c =   CreditApplication.Co_App_Age_of_Dependent_1__c;
         CA.Co_App_Age_of_Dependent_2__c =   CreditApplication.Co_App_Age_of_Dependent_2__c;
         CA.Co_App_Age_of_Dependent_3__c =   CreditApplication.Co_App_Age_of_Dependent_3__c;
         CA.Co_App_Birthdate__c =   CreditApplication.Co_App_Birthdate__c;
         CA.Co_App_City__c =   CreditApplication.Co_App_City__c;
         CA.Co_App_Driver_License_No__c =   CreditApplication.Co_App_Driver_License_No__c;
         
         CA.Co_App_How_Long_Months__c =   CreditApplication.Co_App_How_Long_Months__c;
         CA.Co_App_How_Long_Years__c =   CreditApplication.Co_App_How_Long_Years__c;
         CA.Co_App_Initial__c =   CreditApplication.Co_App_Initial__c;
         
         CA.Co_App_Marital_Status__c =   CreditApplication.Co_App_Marital_Status__c;
         CA.Co_App_Nearest_Relative__c =   CreditApplication.Co_App_Nearest_Relative__c;
         CA.Co_App_Phone__c =   CreditApplication.Co_App_Phone__c;
         CA.Co_App_Present_Employer__c =   CreditApplication.Co_App_Present_Employer__c;
         CA.Co_App_Present_Employer_Address__c =   CreditApplication.Co_App_Present_Employer_Address__c;
         CA.Co_App_Present_Employer_City__c =   CreditApplication.Co_App_Present_Employer_City__c;
         CA.Co_App_Present_Employer_How_Long_Months__c =   CreditApplication.Co_App_Present_Employer_How_Long_Months__c;
         CA.Co_App_Present_Employer_How_Long_Years__c =   CreditApplication.Co_App_Present_Employer_How_Long_Years__c;
         CA.Co_App_Present_Employer_Phone__c =   CreditApplication.Co_App_Present_Employer_Phone__c;
         CA.Co_App_Present_Employer_State__c =   CreditApplication.Co_App_Present_Employer_State__c;
         CA.Co_App_Present_Employer_Zip__c =   CreditApplication.Co_App_Present_Employer_Zip__c;
         CA.Co_App_Previous_Address_1__c =   CreditApplication.Co_App_Previous_Address_1__c;
         CA.Co_App_Previous_Address_2__c =   CreditApplication.Co_App_Previous_Address_2__c;
         CA.Co_App_Previous_City_1__c =   CreditApplication.Co_App_Previous_City_1__c;
         CA.Co_App_Previous_City_2__c =   CreditApplication.Co_App_Previous_City_2__c;
         CA.Co_App_Previous_Employment1__c =   CreditApplication.Co_App_Previous_Employment1__c;
         CA.Co_App_Previous_Employment1_Address__c =   CreditApplication.Co_App_Previous_Employment1_Address__c;
         CA.Co_App_Previous_Employment1_City__c =   CreditApplication.Co_App_Previous_Employment1_City__c;
         CA.Co_App_Previous_Employment1_How_Long_M__c =   CreditApplication.Co_App_Previous_Employment1_How_Long_M__c;
         CA.Co_App_Previous_Employment1_How_Long_Y__c =   CreditApplication.Co_App_Previous_Employment1_How_Long_Y__c;
         CA.Co_App_Previous_Employment1_Phone__c =   CreditApplication.Co_App_Previous_Employment1_Phone__c;
         CA.Co_App_Previous_Employment1_State__c =   CreditApplication.Co_App_Previous_Employment1_State__c;
         CA.Co_App_Previous_Employment1_Zip__c =   CreditApplication.Co_App_Previous_Employment1_Zip__c;
         CA.Co_App_Previous_Employment2__c =   CreditApplication.Co_App_Previous_Employment2__c;
         CA.Co_App_Previous_Employment2_Address__c =   CreditApplication.Co_App_Previous_Employment2_Address__c;
         CA.Co_App_Previous_Employment2_City__c =   CreditApplication.Co_App_Previous_Employment2_City__c;
         CA.Co_App_Previous_Employment2_How_Long_M__c =   CreditApplication.Co_App_Previous_Employment2_How_Long_M__c;
         CA.Co_App_Previous_Employment2_How_Long_Y__c =   CreditApplication.Co_App_Previous_Employment2_How_Long_Y__c;
         CA.Co_App_Previous_Employment2_Phone__c =   CreditApplication.Co_App_Previous_Employment2_Phone__c;
         CA.Co_App_Previous_Employment2_State__c =   CreditApplication.Co_App_Previous_Employment2_State__c;
         CA.Co_App_Previous_Employment2_Zip__c =   CreditApplication.Co_App_Previous_Employment2_Zip__c;
         CA.Co_App_Previous_State_1__c =   CreditApplication.Co_App_Previous_State_1__c;
         CA.Co_App_Previous_State_2__c =   CreditApplication.Co_App_Previous_State_2__c;
         CA.Co_App_Previous_Zip_1__c =   CreditApplication.Co_App_Previous_Zip_1__c;
         CA.Co_App_Previous_Zip_2__c =   CreditApplication.Co_App_Previous_Zip_2__c;
         CA.Co_App_Previous1_How_Long_Months__c =   CreditApplication.Co_App_Previous1_How_Long_Months__c;
         CA.Co_App_Previous1_How_Long_Years__c =   CreditApplication.Co_App_Previous1_How_Long_Years__c;
         CA.Co_App_Previous1_Lived_In_Community_M__c =   CreditApplication.Co_App_Previous1_Lived_In_Community_M__c;
         CA.Co_App_Previous1_Lived_In_Community_Y__c =   CreditApplication.Co_App_Previous1_Lived_In_Community_Y__c;
         CA.Co_App_Previous2_How_Long_Months__c =   CreditApplication.Co_App_Previous2_How_Long_Months__c;
         CA.Co_App_Previous2_How_Long_Years__c =   CreditApplication.Co_App_Previous2_How_Long_Years__c;
         CA.Co_App_Previous2_Lived_In_Community_M__c =   CreditApplication.Co_App_Previous2_Lived_In_Community_M__c;
         CA.Co_App_Previous2_Lived_In_Community_Y__c =   CreditApplication.Co_App_Previous2_Lived_In_Community_Y__c;
         CA.Co_App_Realation_Ship_to_Applicant__c =   CreditApplication.Co_App_Realation_Ship_to_Applicant__c;
         CA.Co_App_Relationship__c =   CreditApplication.Co_App_Relationship__c;
         CA.Co_App_Relative_Address__c =   CreditApplication.Co_App_Relative_Address__c;
         CA.Co_App_Relative_City__c =   CreditApplication.Co_App_Relative_City__c;
         CA.Co_App_Relative_Phone__c =   CreditApplication.Co_App_Relative_Phone__c;
         CA.Co_App_Relative_State__c =   CreditApplication.Co_App_Relative_State__c;
         CA.Co_App_Relative_Zip__c =   CreditApplication.Co_App_Relative_Zip__c;
         CA.Co_App_Social_Security_Number__c =   CreditApplication.Co_App_Social_Security_Number__c;
         CA.Co_App_State__c =   CreditApplication.Co_App_State__c;
         CA.Co_App_Zip__c =   CreditApplication.Co_App_Zip__c;
         CA.Co_Applicants_Gross_Monthly_Income__c =   CreditApplication.Co_Applicants_Gross_Monthly_Income__c;
         CA.Company_Name_of_All_obligations1__c =   CreditApplication.Company_Name_of_All_obligations1__c;
         CA.Company_Name_of_All_obligations2__c =   CreditApplication.Company_Name_of_All_obligations2__c;
         CA.Company_Name_of_All_obligations3__c =   CreditApplication.Company_Name_of_All_obligations3__c;
         CA.Company_Name_of_All_obligations4__c =   CreditApplication.Company_Name_of_All_obligations4__c;
         CA.Credit_Account_No1__c =   CreditApplication.Credit_Account_No1__c;
         CA.Credit_Account_No2__c =   CreditApplication.Credit_Account_No2__c;
         CA.Credit_Account_No3__c =   CreditApplication.Credit_Account_No3__c;
         CA.Credit_Account_No4__c =   CreditApplication.Credit_Account_No4__c;
         CA.Credit_Account_Status1__c =   CreditApplication.Credit_Account_Status1__c;
         CA.Credit_Account_Status2__c =   CreditApplication.Credit_Account_Status2__c;
         CA.Credit_Account_Status3__c =   CreditApplication.Credit_Account_Status3__c;
         CA.Credit_Account_Status4__c =   CreditApplication.Credit_Account_Status4__c;
         CA.Credit_Address1__c =   CreditApplication.Credit_Address1__c;
         CA.Credit_Address2__c =   CreditApplication.Credit_Address2__c;
         CA.Credit_Address3__c =   CreditApplication.Credit_Address3__c;
         CA.Credit_Address4__c =   CreditApplication.Credit_Address4__c;
         CA.Credit_Balance1__c =   CreditApplication.Credit_Balance1__c;
         CA.Credit_Balance2__c =   CreditApplication.Credit_Balance2__c;
         CA.Credit_Balance3__c =   CreditApplication.Credit_Balance3__c;
         CA.Credit_Balance4__c =   CreditApplication.Credit_Balance4__c;
         CA.Credit_City1__c =   CreditApplication.Credit_City1__c;
         CA.Credit_City2__c =   CreditApplication.Credit_City2__c;
         CA.Credit_City3__c =   CreditApplication.Credit_City3__c;
         CA.Credit_City4__c =   CreditApplication.Credit_City4__c;
         CA.Credit_High1__c =   CreditApplication.Credit_High1__c;
         CA.Credit_High2__c =   CreditApplication.Credit_High2__c;
         CA.Credit_High3__c =   CreditApplication.Credit_High3__c;
         CA.Credit_High4__c =   CreditApplication.Credit_High4__c;
         CA.Credit_Monthly_Payment_Or_Date_Closed1__c =   CreditApplication.Credit_Monthly_Payment_Or_Date_Closed1__c;
         CA.Credit_Monthly_Payment_Or_Date_Closed2__c =   CreditApplication.Credit_Monthly_Payment_Or_Date_Closed2__c;
         CA.Credit_Monthly_Payment_Or_Date_Closed3__c =   CreditApplication.Credit_Monthly_Payment_Or_Date_Closed3__c;
         CA.Credit_Monthly_Payment_Or_Date_Closed4__c =   CreditApplication.Credit_Monthly_Payment_Or_Date_Closed4__c;
         CA.Credit_State1__c =   CreditApplication.Credit_State1__c;
         CA.Credit_State2__c =   CreditApplication.Credit_State2__c;
         CA.Credit_State3__c =   CreditApplication.Credit_State3__c;
         CA.Credit_State4__c =   CreditApplication.Credit_State4__c;
         CA.Credit_Zip1__c =   CreditApplication.Credit_Zip1__c;
         CA.Credit_Zip2__c =   CreditApplication.Credit_Zip2__c;
         CA.Credit_Zip3__c =   CreditApplication.Credit_Zip3__c;
         CA.Credit_Zip4__c =   CreditApplication.Credit_Zip4__c;
         CA.Date_Home_Purchaged__c =   CreditApplication.Date_Home_Purchaged__c;
         CA.Have_you_ever_file_Bankruptcy__c =   CreditApplication.Have_you_ever_file_Bankruptcy__c;
         CA.Home_Payment__c =   CreditApplication.Home_Payment__c;
         CA.LandLord_Address__c =   CreditApplication.LandLord_Address__c;
         CA.LandLord_Or_Mortage_Holder__c =   CreditApplication.LandLord_Or_Mortage_Holder__c;
         CA.Landlord_Account_Number__c =   CreditApplication.Landlord_Account_Number__c;
         CA.Market_Value__c =   CreditApplication.Market_Value__c;
         CA.Military_Reserve_Status__c =   CreditApplication.Military_Reserve_Status__c;
         CA.Military_Reserve__c =   CreditApplication.Military_Reserve__c;
         CA.Mortage_Balance__c =   CreditApplication.Mortage_Balance__c;         
         CA.Payment_Or_Rent__c =   CreditApplication.Payment_Or_Rent__c;
         CA.Personal_Friend_Address1__c =   CreditApplication.Personal_Friend_Address1__c;
         CA.Personal_Friend_Address2__c =   CreditApplication.Personal_Friend_Address2__c;
         CA.Personal_Friend_City1__c =   CreditApplication.Personal_Friend_City1__c;
         CA.Personal_Friend_City2__c =   CreditApplication.Personal_Friend_City2__c;
         CA.Personal_Friend_Phone1__c =   CreditApplication.Personal_Friend_Phone1__c;
         CA.Personal_Friend_Phone2__c =   CreditApplication.Personal_Friend_Phone2__c;
         CA.Personal_Friend_State1__c =   CreditApplication.Personal_Friend_State1__c;
         CA.Personal_Friend_State2__c =   CreditApplication.Personal_Friend_State2__c;
         CA.Personal_Friend_Zip1__c =   CreditApplication.Personal_Friend_Zip1__c;
         CA.Personal_Friend_Zip2__c =   CreditApplication.Personal_Friend_Zip2__c;
         CA.Personal_friends_known_over_1_year1__c =   CreditApplication.Personal_friends_known_over_1_year1__c;
         CA.Personal_friends_known_over_1_year2__c =   CreditApplication.Personal_friends_known_over_1_year2__c;
         CA.Present_Employer__c =   CreditApplication.Present_Employer__c;
         CA.Present_Employer_Address__c =   CreditApplication.Present_Employer_Address__c;
         CA.Present_Employer_City__c =   CreditApplication.Present_Employer_City__c;
         CA.Present_Employer_How_Long_Months__c =   CreditApplication.Present_Employer_How_Long_Months__c;
         CA.Present_Employer_How_Long_Years__c =   CreditApplication.Present_Employer_How_Long_Years__c;
         CA.Present_Employer_Phone__c =   CreditApplication.Present_Employer_Phone__c;
         CA.Present_Employer_State__c =   CreditApplication.Present_Employer_State__c;
         CA.Present_Employer_Zip__c =   CreditApplication.Present_Employer_Zip__c;
         CA.Present_Vehicle_Financed_By_Leased_By1__c =   CreditApplication.Present_Vehicle_Financed_By_Leased_By1__c;
         CA.Present_Vehicle_Financed_By_Leased_By2__c =   CreditApplication.Present_Vehicle_Financed_By_Leased_By2__c;
         CA.Price_Paid_For_Home__c =   CreditApplication.Price_Paid_For_Home__c;        
         CA.Type_Of_Credit1__c =   CreditApplication.Type_Of_Credit1__c;
         CA.Type_Of_Credit2__c =   CreditApplication.Type_Of_Credit2__c;
         CA.Type_Of_Credit3__c =   CreditApplication.Type_Of_Credit3__c;
         CA.Type_Of_Credit4__c =   CreditApplication.Type_Of_Credit4__c;
         CA.Vehicle_Account_No1__c =   CreditApplication.Vehicle_Account_No1__c;
         CA.Vehicle_Account_No2__c =   CreditApplication.Vehicle_Account_No2__c;
         CA.Vehicle_Address1__c =   CreditApplication.Vehicle_Address1__c;
         CA.Vehicle_Address2__c =   CreditApplication.Vehicle_Address2__c;
         CA.Vehicle_City1__c =   CreditApplication.Vehicle_City1__c;
         CA.Vehicle_City2__c =   CreditApplication.Vehicle_City2__c;
         CA.Vehicle_Monthly_Payment1__c =   CreditApplication.Vehicle_Monthly_Payment1__c;
         CA.Vehicle_Monthly_Payment2__c =   CreditApplication.Vehicle_Monthly_Payment2__c;
         CA.Vehicle_State1__c =   CreditApplication.Vehicle_State1__c;
         CA.Vehicle_State2__c =   CreditApplication.Vehicle_State2__c;
         CA.Vehicle_Zip1__c =   CreditApplication.Vehicle_Zip1__c;
         CA.Vehicle_Zip2__c =   CreditApplication.Vehicle_Zip2__c;
 
        insert CA;
        System.debug('>>>>>>>>>>>>>>.'+CA);
        PageReference retPage =new Pagereference('/'+ CA.ID);
        retPage.setRedirect(true); 
        return retPage;
     }
     
     */

}