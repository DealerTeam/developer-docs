/**
* Date            |Developer            |Work#
* Notes
* --
* 2017.01.18       |Gaurav               |W-000903
* Implemented Trigger Framework.
* 
*/

//W-000903 Begins
public class ServiceEstimateLineTaxCalculationHandler 
{
    
    public void BeforeHandlerforCalcultingTax(List <dealer__Service_Estimate_Line__c> ListServiceEstimateLine){

        dealer__TaxSettings__c taxDefaults = new dealer__TaxSettings__c();

        if(dealer__TaxSettings__c.getValues('ActiveSettings')!=null) {
            taxDefaults = dealer__TaxSettings__c.getValues('ActiveSettings');   
        }
        //W-001780 Begins
        if(taxDefaults.dealer__State_Tax_Rate__c != null) {
            Set<Id> SEIds = new Set<Id>();
            for(dealer__Service_Estimate_Line__c SELine : ListServiceEstimateLine){
                SEIds.add(SELine.dealer__Service_Estimate__c);
            }
            Map<Id,Boolean> taxableMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxPartsMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxServiceMap = new Map<Id,Boolean>(); 
            Map<Id,dealer__Service_Estimate__c> SEMap = new Map<Id,dealer__Service_Estimate__c>();

            if(SEIds.size()>0){
                for(dealer__Service_Estimate__c se:[SELECT Id, dealer__Taxable__c, dealer__Store_Location__r.dealer__Tax_Service__c, dealer__Store_Location__r.dealer__Tax_Parts__c FROM dealer__Service_Estimate__c WHERE Id IN :SEIds]){
            
                    taxableMap.put(se.Id, se.dealer__Taxable__c);
                    taxPartsMap.put(se.Id, se.dealer__Store_Location__r.dealer__Tax_Parts__c);
                    taxServiceMap.put(se.Id, se.dealer__Store_Location__r.dealer__Tax_Service__c);
                     system.debug('taxable status=======' + se);
                }
            }
            for(dealer__Service_Estimate_Line__c  objServiceLine : ListServiceEstimateLine) {
                    Boolean taxable = taxableMap.get(objServiceLine.dealer__Service_Estimate__c);
                    Boolean taxParts = taxPartsMap.get(objServiceLine.dealer__Service_Estimate__c);
                    Boolean taxService = taxServiceMap.get(objServiceLine.dealer__Service_Estimate__c);
                    if(taxable == true){
                        if(taxParts == true && taxService == true){
                            objServiceLine.dealer__Tax__c = (objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100)) + (objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100));
                        } 
                        else if(taxParts == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        else if(taxService == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        system.debug('service estimate found to be taxable');

                    }
                    if(taxable == false){
                        objServiceLine.dealer__Tax__c = (0);
                        system.debug('service estimate found to be NOT taxable');

                    }
                    system.debug(objServiceLine);
            }

            //W-001780 Ends
        }

              

    }

}
//W-000903 Ends