/**
* Date            |Developer            |Work#
* Notes
* ----------------------------------------------------------------------------
*
* 2016.10.14       |Sneha                |Case# 00002076
* Prevent deletion of service job if line total is greater than 0
*
* 2017.01.05       |Gaurav              |W-000858
* Modified ServiceJobLinkParent trigger on Service Job Line for restricting the user from manually adjusting Cost.   
*/

public class ServiceJobTriggerHandler{


    public void handleBeforeInsert(List<Service_Job__c> ListServiceJob){

      Set<Id> setRepairIds = new Set<ID>();
      Set<String> setParentIds = new Set<String>();
      Set<String> setTechnicianIds =new Set<String>();
      Set<String> setOpCodeIds = new Set<String>();
            
        for(Service_Job__c objService : ListServiceJob) {
            if(objService.Service_Repair_Order__c!=null) {
                setRepairIds.add(objService.Service_Repair_Order__c);
            }
            if(objService.dealer__Service_Repair_Order__c==null && objService.dealer__Parent_Record__c!=null) {
                setParentIds.add(objService.dealer__Parent_Record__c);
            }
            if(objService.dealer__Technician_ID__c!=null) {
                setTechnicianIds.add(objService.dealer__Technician_ID__c);
            }
            if(objService.dealer__Op_Code__c!=null && objService.dealer__Standard_Operation_Code__c==null) {
                if(!setOpCodeIds.contains(objService.dealer__Op_Code__c)) {
                    setOpCodeIds.add(objService.dealer__Op_Code__c);
                }
            }
        }
            
        // Get associated Records
        // Parent RO Records
        
        List<Service_Repair_Order__c> ListServiceOrder = [SELECT Id, Name, RO_Number__c FROM Service_Repair_Order__c WHERE Id in : setRepairIds OR RO_Number__c in :setParentIds LIMIT 1000];
        
        Map<Id, dealer__Service_Repair_Order__c> MapServiceOrder = new Map<Id, dealer__Service_Repair_Order__c>();
        Map<String, dealer__Service_Repair_Order__c> MapServiceOrderKey = new Map<String, dealer__Service_Repair_Order__c>();                                
        for(dealer__Service_Repair_Order__c objRepair : ListServiceOrder) {
            MapServiceOrder.put(objRepair.Id, objRepair);
            MapServiceOrderKey.put(objRepair.dealer__RO_Number__c, objRepair);
        }
        
        // Get Associated Technician
        Map<String, User> MapTechKeys = new Map<String, User>();
        if(setTechnicianIds.size() > 0){
            List<User> ListUser = [Select Id, EmployeeNumber from User where EmployeeNumber in: setTechnicianIds limit 2000];
            for(User objUser : ListUser) {
                MapTechKeys.put(objUser.EmployeeNumber, objUser);
            } 
        }
          
        // Get Associated Operation Codes
        Map<String, dealer__StandardOpCode__c>MapStandardCode = new Map<String, dealer__StandardOpCode__c>();
        if(setOpCodeIds.size() > 0){
            List<dealer__StandardOpCode__c> StandardOpCodeList = [Select Id, Name from dealer__StandardOpCode__c where Name in:setOpCodeIds limit 2000];     
            for(dealer__StandardOpCode__c objStandardCode : StandardOpCodeList) {
                MapStandardCode.put(objStandardCode.Name, objStandardCode);
            }
        }
        
        // Associate Keys
        for(dealer__Service_Job__c objJob : ListServiceJob) {
            if(objJob.dealer__Service_Repair_Order__c == null && objJob.dealer__Parent_Record__c != null) {
                objJob.dealer__Service_Repair_Order__c = MapServiceOrderKey.get(objJob.dealer__Parent_Record__c).Id;  
            }
            if(objJob.dealer__Technician__c == null && MapTechKeys.get(objJob.dealer__Technician_ID__c)!=null) {
                objJob.dealer__Technician__c = MapTechKeys.get(objJob.dealer__Technician_ID__c).Id;
            }
            if(objJob.dealer__Op_Code__c!=null && MapStandardCode.get(objJob.dealer__Op_Code__c)!=null) {
                objJob.dealer__Standard_Operation_Code__c = MapStandardCode.get(objJob.dealer__Op_Code__c).Id;
            }
        } 

        // Set Job Name if not Previously set
        for(dealer__Service_Job__c objJob : ListServiceJob) {

            System.assert(MapServiceOrder.get(objJob.Service_Repair_Order__c)!=null);

            objJob.Name = MapServiceOrder.get(objJob.Service_Repair_Order__c).Name + '-' +objJob.Line_Number__c;

        }
   
    }
    
    public static List<User> ListUser = null;
    public static List<StandardOpCode__c> StandardOpCodeList = null;
    public static List<Service_Repair_Order__c> ListServiceOrder = null;
    public void handleBeforeUpdate(List<Service_Job__c> ListServiceJob,Map<Id,Service_Job__c> MapServiceJob){
    
      boolean isChanged = false;
      Set<Id> setRepairIds = new Set<ID>();
      Set<String> setParentIds = new Set<String>();
      Set<String> setTechnicianIds =new Set<String>();
      Set<String> setOpCodeIds = new Set<String>(); 
      set<Id> setIds = new set<Id>(); 
            for (dealer__Service_Job__c objServiceJob : ListServiceJob) {
                setIds.add(objServiceJob.id);
               //W-000858 Begins
                dealer__Service_Job__c oldObjServiceJob  = MapServiceJob.get(objServiceJob.id);
                if(oldObjServiceJob.dealer__Parts_Cost__c != objServiceJob.dealer__Parts_Cost__c){
                    isChanged = true;
                }
                //W-000858 End
                
                if(objServiceJob.dealer__Service_Repair_Order__c!=null) {
                    setRepairIds.add(objServiceJob.dealer__Service_Repair_Order__c);
                }
                if(objServiceJob.dealer__Service_Repair_Order__c==null && objServiceJob.dealer__Parent_Record__c!=null) {
                    setParentIds.add(objServiceJob.dealer__Parent_Record__c);
                }
                if(objServiceJob.dealer__Technician_ID__c!=null) {
                    setTechnicianIds.add(objServiceJob.dealer__Technician_ID__c);
                }
                if(objServiceJob.dealer__Op_Code__c!=null && objServiceJob.dealer__Standard_Operation_Code__c==null) {
                    if(!setOpCodeIds.contains(objServiceJob.dealer__Op_Code__c)) {
                        setOpCodeIds.add(objServiceJob.dealer__Op_Code__c);
                    }
                }
                
            }
            //W-000858 Begins
            if(isChanged){     
                AggregateResult[] jobtotals = [SELECT dealer__Job_Line__c, sum(dealer__Cost__c) FROM dealer__Parts_Invoice_Line__c WHERE dealer__Job_Line__c IN:setIds GROUP BY dealer__Job_Line__c];
                for(AggregateResult objTotal : jobtotals){
                    for(dealer__Service_Job__c objService: ListServiceJob){
                        objService.dealer__Parts_Cost__c=Decimal.valueOf(String.valueOf(objTotal.get('expr0')));
                    }
                }
            }
            //W-000858 End
            // Get associated Records
            // Parent RO Records
            
            if(ServiceJobTriggerHandler.ListServiceOrder == null) { 
                ServiceJobTriggerHandler.ListServiceOrder = [Select Id, dealer__RO_Number__c 
                                            from dealer__Service_Repair_Order__c
                                            where Id in : setRepairIds 
                                            or dealer__RO_Number__c in :setParentIds 
                                            limit 1000];
            }
            
            Map<Id, dealer__Service_Repair_Order__c> MapServiceOrder = new Map<Id, dealer__Service_Repair_Order__c>();
            Map<String, dealer__Service_Repair_Order__c> MapServiceOrderKey = new Map<String, dealer__Service_Repair_Order__c>();                                
            for(dealer__Service_Repair_Order__c objRepair : ListServiceOrder) {
                MapServiceOrder.put(objRepair.Id, objRepair);
                MapServiceOrderKey.put(objRepair.dealer__RO_Number__c, objRepair);
            }
            
            // Get Associated Technician
            if(ServiceJobTriggerHandler.ListUser==null) { ServiceJobTriggerHandler.ListUser = [Select Id, EmployeeNumber from User where EmployeeNumber in: setTechnicianIds limit 2000]; }
            Map<String, User> MapTechKeys = new Map<String, User>();
            for(User objUser : ListUser) {
                MapTechKeys.put(objUser.EmployeeNumber, objUser);
            }  
            
            // Get Associated Operation Codes
            if(ServiceJobTriggerHandler.StandardOpCodeList == null) { ServiceJobTriggerHandler.StandardOpCodeList = [Select Id, Name from dealer__StandardOpCode__c where Name in:setOpCodeIds limit 2000]; }
            Map<String, dealer__StandardOpCode__c>MapStandardCode = new Map<String, dealer__StandardOpCode__c>();
            for(dealer__StandardOpCode__c objStandardCode : StandardOpCodeList) {
                MapStandardCode.put(objStandardCode.Name, objStandardCode);
            }
            
            // Associate Keys
            for(dealer__Service_Job__c objJob : ListServiceJob) {
                if(objJob.dealer__Service_Repair_Order__c == null && objJob.dealer__Parent_Record__c != null) {
                    objJob.dealer__Service_Repair_Order__c = MapServiceOrderKey.get(objJob.dealer__Parent_Record__c).Id;  
                }
                if(objJob.dealer__Technician__c == null && MapTechKeys.get(objJob.dealer__Technician_ID__c)!=null) {
                    objJob.dealer__Technician__c = MapTechKeys.get(objJob.dealer__Technician_ID__c).Id;
                }
                if(objJob.dealer__Op_Code__c!=null && MapStandardCode.get(objJob.dealer__Op_Code__c)!=null) {
                    objJob.dealer__Standard_Operation_Code__c = MapStandardCode.get(objJob.dealer__Op_Code__c).Id;
                }
            }    
            
            
       }
       //Case# 00002076 Begins
       public void handleBeforeDelete(List<Service_Job__c> ListServiceJob){
          for(dealer__Service_Job__c objServiceJob : ListServiceJob) {
                if(objServiceJob.dealer__Line_Total__c != null && objServiceJob.dealer__Line_Total__c > 0){
                    objServiceJob.addError('You can not delete service job with line total greater than 0');
                }
            }
       
       }
       //Case# 00002076 End
}