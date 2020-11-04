/**
 * CreditReportController 
 * @description
 */
public class CreditReportController 
{
    /**
     * RunSevenHundredCreditReport 
     * @param  appId      
     * @param  reportType 
     * @param  bureaus   
     * @return  dealer__Credit_Application__c  
     * @description  In this class we can put a method specific to each reporting provider    
     */
    @auraEnabled
    public static dealer__Credit_Application__c RunSevenHundredCreditReport(string appId, String reportType, List<string> bureaus)
    {
             try
            {  
                Id i = Id.valueOf(appId);
                SevenHundredCreditApplicationHandler.InquiryResult result = SevenHundredCreditApplicationHandler.CreateInquiry(new Set<Id>{  i }, reportType, bureaus);

                if(!result.success)
                {
                    // default error message
                    string error = 'An unknown error has occurred';
                    
                    // actual error message
                    if(result.messages.size() > 0)
                        error = result.messages[0];
                    
                    return null;              
                }
                else
                {
                    return [select dealer__Experian_Credit_Report_Url__c, dealer__Equifax_Credit_Report_Url__c, 
                    dealer__TransUnion_Credit_Report_Url__c, dealer__OFAC_Report_Url__c, dealer__Red_Flag_Report_Url__c, dealer__Experian_Credit_Score__c,
                    dealer__Equifax_Credit_Score__c, dealer__TransUnion_Credit_Score__c, dealer__Co_App_Experian_Credit_Score__c,
                    dealer__Co_App_Equifax_Credit_Score__c, dealer__Co_App_TransUnion_Credit_Score__c, dealer__Experian_Credit_Report_Run_Time__c,
                    dealer__Equifax_Credit_Report_Run_Time__c, dealer__TransUnion_Credit_Report_Run_Time__c,
                    dealer__OFAC_Report_Run_Time__c, dealer__Red_Flag_Report_Run_Time__c
                    from dealer__Credit_Application__c where id =: appId];
                }
            }
            catch(System.DmlException e)
            {
                return null;
            }       
    }
}