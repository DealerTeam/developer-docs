public with sharing class InspectionDiagramController {
    @AuraEnabled
    public static imageWrapper getImageUrl(Id recordId){
        String savedUrl;
        String defaultUrl = 'https://apsv1.dealerteam.com/api/mpi/generate-damage-diagram';
        
        AppraisalConfiguration__mdt appraisalSettings = appraisalSettings();
        String sObjectName = recordId.getSObjectType().getDescribe().getName();
        try{
            if(sObjectName == 'dealer__Inspection_Report__c'){
                Inspection_report__c thisReport = [SELECT Id, Body_Damage_URL__c,
                                                Service_Vehicle__c,Service_Vehicle__r.Year__c, Service_Vehicle__r.Make__c,
                                                Service_Vehicle__r.Carline__c, Service_Vehicle__r.Body_Type_Picklist__c
                                                from Inspection_report__c WHERE Id=: recordId];
                
                //Saved Url
                if(thisReport.Body_Damage_URL__c != null){
                    savedUrl = thisReport.Body_Damage_URL__c;
                } 

                //Default Url
                if (thisReport.Service_Vehicle__c != null){
                    defaultUrl += '?year='+thisReport.Service_Vehicle__r.Year__c+
                                '&make='+thisReport.Service_Vehicle__r.Make__c+
                                '&model='+thisReport.Service_Vehicle__r.Carline__c+
                                '&bodystyle='+thisReport.Service_Vehicle__r.Body_Type_Picklist__c+
                                '&di='+(Integer)appraisalSettings.DefaultDiagramId__c;
                
                } else if(thisReport.Service_Vehicle__c == null){
                    defaultUrl += '?di='+(Integer)appraisalSettings.DefaultDiagramId__c;
                }

            } else if(sObjectName == 'dealer__Appraisal__c'){
                
                Appraisal__c thisAppraisal = [SELECT Id, Name,Body_Damage_URL__c,
                                            Service_Vehicle__c,Service_Vehicle__r.Year__c, Service_Vehicle__r.Make__c,
                                            Service_Vehicle__r.Carline__c, Service_Vehicle__r.Body_Type_Picklist__c 
                                            FROM Appraisal__c WHERE Id =: recordId];
                //Saved Url
                if(thisAppraisal.Body_Damage_URL__c != null){
                    savedUrl = thisAppraisal.Body_Damage_URL__c;
                } 

                //Default Url
                if (thisAppraisal.Service_Vehicle__c != null){
                    defaultUrl += '?year='+thisAppraisal.Service_Vehicle__r.Year__c+
                                '&make='+thisAppraisal.Service_Vehicle__r.Make__c+
                                '&model='+thisAppraisal.Service_Vehicle__r.Carline__c+
                                '&bodystyle='+thisAppraisal.Service_Vehicle__r.Body_Type_Picklist__c+
                                '&di='+(Integer)appraisalSettings.DefaultDiagramId__c;
                
                } else if(thisAppraisal.Service_Vehicle__c == null){
                    defaultUrl += '?di='+(Integer)appraisalSettings.DefaultDiagramId__c;
                }
            }
            else{
                //Vehicle Inventory
                //Service Vehicle
                //Etc.. (future iterations)
            }
        } catch (QueryException e){
            throw new AuraHandledException(e.getMessage());
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }

        return new imageWrapper(savedUrl, defaultUrl);
    }
    public class imageWrapper{
        @AuraEnabled
        public string SavedUrl;
        @AuraEnabled
        public string DefaultUrl;
        public imageWrapper(String savedUrl, String defaultUrl){
            this.SavedUrl = savedUrl;
            this.DefaultUrl = defaultUrl;
        }
    }

@AuraEnabled
    public static string saveURL(Id recordId, String url){
        String sObjectName = recordId.getSObjectType().getDescribe().getName();
        try{
            if(sObjectName == 'dealer__Inspection_Report__c'){
                Inspection_report__c thisReport = new Inspection_report__c(Id=recordId, Body_Damage_URL__c = url);
                update thisReport;
                return thisReport.Body_Damage_URL__c;
            } else if(sObjectName == 'dealer__Appraisal__c') {
                Appraisal__c thisAppraisal = new Appraisal__c(Id=recordId, Body_Damage_URL__c=url);
                update thisAppraisal;
                return thisAppraisal.Body_Damage_URL__c;
            } else {
                //Vehicle Inventory
                //Service Vehicle
                //Etc.. (future iterations)
            }
        } catch (DMLException e){
            throw new AuraHandledException(e.getMessage());
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }

        return '';
    }

    /** Acquire default vehicle diagram from appraisal settings */
    public static AppraisalConfiguration__mdt appraisalSettings(){
        try {
            if(!Test.isRunningTest()){
                AppraisalConfiguration__mdt[] appraisalMetaData = [SELECT DefaultDiagramId__c FROM AppraisalConfiguration__mdt WHERE QualifiedApiName ='dealer__Default_Appraisal_Configuration' LIMIT 1];
                System.assert(!appraisalMetaData.isEmpty(), 'Appraisal Default Configuration does not appear to be set, please create the dealer__Default_Appraisal_Configuration metadata file.');
                return appraisalMetaData[0]; 
            } else {
                return new AppraisalConfiguration__mdt();
            }
        } Catch(QueryException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}