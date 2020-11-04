@isTest
public class CreditApplication_TC{

static testMethod void myUnitTest() 
{
Credit_Application__c CreditApplication = new Credit_Application__c();
ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(CreditApplication );
     CreditApplication ca = new CreditApplication (sc);
     
     
  ca.ApplicantFirstName ='appfirst';
   ca.ApplicantLastName='applast';
      ca.ApplicantBirthdate =system.today();
     ca.IsApplicant=true;
      ca.IsCOApplicant=true;
     ca.AssetSection=true;
     ca.errMsg = false;
    ca.isStep1=true;
  ca.isStep2=false;
 ca.isStep3=false;
   ca.COApplicantFirstName='coap';
   
  ca.COApplicantLastName='coapl';
 ca.COApplicantBirthdate=system.today();
  ca.isNextCOApplicant=false;
  ca.isFirstImage=true;
     ca.isSecondImage=false;
ca.isThirdImage=false;






}
}