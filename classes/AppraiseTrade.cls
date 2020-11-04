public with sharing class AppraiseTrade {
    /*
    public dealer__Sales_Up__c sup { get; set; }
    public dealer__Appraisal__c appraisal {get;set;}
    public dealer__Inspection_Report__c inspection {get;set;}
    public dealer__Service_Vehicle__c serviceVeh { get; set; }
    
    private Id appraisalTypeId { get; set;}
    public dealer__Service_Vehicle_Appraisal__c serviceVehApprsl { get; set; }
    
    public AppraiseTrade(ApexPages.StandardController controller) {
        System.debug('--controller1--'+controller);
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Sales_Up__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {       
            controller.addFields(af);
        }
        System.debug('--controller2--'+controller);
        sup = (dealer__Sales_Up__c)controller.getRecord();
        
        inspection = new dealer__Inspection_Report__c();
        serviceVeh = new dealer__Service_Vehicle__c();
        appraisal = new dealer__Appraisal__c();
        
        appraisal.dealer__Sales_Up__c = sup.Id;
        
        try{
            appraisal = [Select Id, dealer__Appraised_Value__c, dealer__Acquisition_method__c, dealer__Store_Location__c, 
                dealer__Appraised_By__c , dealer__Sales_Up__c, dealer__Transportation__c, dealer__Certification__c, 
                dealer__Auction_Fee__c 
                FROM dealer__Appraisal__c 
                WHERE dealer__Sales_Up__c =:sup.Id];
            
            appraisalTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Appraisal' LIMIT 1].Id;
        }catch(Exception e){
            appraisal = new dealer__Appraisal__c();
            appraisal.dealer__Sales_Up__c = sup.Id;
            appraisal.dealer__Appraised_By__c = userInfo.getUserId();   
        }
    }
    
    
    public PageReference saveAppraisal() {
    
        try{
            insert appraisal;
        }catch(Exception e){
            //PageReference edit = Page.AppraiseTrade;
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You do not have permission to create Appraisal'));
            
            //return edit;
            throw new AppraiseException('Failed to Create Appraise Error: '+e.getMessage());
        }
        serviceVeh.dealer__Vin__c = sup.dealer__Trade_VIN__c;
        serviceVeh.dealer__Year__c = sup.dealer__Trade_Year__c;
        serviceVeh.dealer__Make__c = sup.dealer__Trade_Make__c;
        serviceVeh.dealer__Carline__c = sup.dealer__Trade_Model__c;
        serviceVeh.dealer__Trim_Level__c = sup.dealer__Trade_Trim_Level__c;
        serviceVeh.dealer__Last_Odometer__c = sup.dealer__Trade_Mileage__c;
        serviceVeh.dealer__Body_Type__c = sup.dealer__Trade_Body_Type__c;
        insert serviceVeh;
        
        inspection.dealer__Internal_Comments__c = sup.dealer__Trade_Comments__c;
        //inspection.RecordTypeId = appraisalTypeId;
        inspection.dealer__Sales_Up__c = sup.Id;
        
        insert inspection;
        
        serviceVehApprsl = new dealer__Service_Vehicle_Appraisal__c(dealer__Sales_Up__c = sup.Id, dealer__Service_Vehicle__c = serviceVeh.Id);
        insert serviceVehApprsl;
        
        if(appraisal.dealer__Sales_Up__c == null){
            PageReference p = new PageReference('/'+appraisal.Id);
            return p;
        } else {
            PageReference p = new PageReference('/'+sup.Id);
            return p;
        }
    }
    
    public PageReference editAppraisal() {
        PageReference edit = new PageReference('/apex/AppraiseTrade?id='+sup.Id);
        edit.setRedirect(true);
        return edit;
    }
    
    public void deleteAppraisal(){
        delete [Select Id FROM dealer__Appraisal__c Where id =:ApexPages.currentPage().getParameters().get('appraisalId')];
    }
    
    public PageReference editServiceVehicle() {
        Id serviceVehId  =  ApexPages.currentPage().getParameters().get('serviceVehicleEdit');
        PageReference edit = new PageReference('/'+serviceVehId+'/e?retURL=%2F'+sup.Id);
        edit.setRedirect(true);
        return edit;
    }
    */
    public class AppraiseException extends Exception {}
    
}