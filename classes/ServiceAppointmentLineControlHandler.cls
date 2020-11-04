/**
* Date            |Developer            |Work#
* Notes
* --
* 2017.01.23      |Gaurav               |W-000903
* Implemented Trigger framework
**/

public class ServiceAppointmentLineControlHandler{

    //Handler method to get Standard Operation Code based on Service Appointment Company Number and Op Code Name    
    public static void beforeInsertUpdate(List<dealer__Service_Appointment_Line__c> ServiceAppointmentLineList){
         
        Set<Id> ServiceAppointmentIdSet = new Set<Id>();        
        List<String> opCodeStringList = new List<String>();
        Map<String, dealer__StandardOpCode__c> StandardOpCodeMap = new Map<String, dealer__StandardOpCode__c>();
        Map<Id, dealer__Service_Appointment__c> ServiceAppointmentMap = new Map<Id, dealer__Service_Appointment__c>();
        
        for(dealer__Service_Appointment_Line__c objServiceAppoLine : ServiceAppointmentLineList){        
            
            if(objServiceAppoLine.dealer__Service_Appointment__c != null){
                ServiceAppointmentIdSet.add(objServiceAppoLine.dealer__Service_Appointment__c);
            }
        }
        
        for(dealer__Service_Appointment__c objServiceAppointment : [SELECT Id, Name, dealer__Company_Number__c FROM dealer__Service_Appointment__c WHERE ID IN : ServiceAppointmentIdSet]){
            ServiceAppointmentMap.put(objServiceAppointment.Id, objServiceAppointment);
        }  
                
        for(dealer__Service_Appointment_Line__c objServiceAppoLine : ServiceAppointmentLineList){         
            if(ServiceAppointmentMap.get(objServiceAppoLine.dealer__Service_Appointment__c) != null
                && ServiceAppointmentMap.get(objServiceAppoLine.dealer__Service_Appointment__c).dealer__Company_Number__c != null 
                && objServiceAppoLine.dealer__Op_Code_Name__c != null){            
                opCodeStringList.add(String.valueOf(ServiceAppointmentMap.get(objServiceAppoLine.dealer__Service_Appointment__c).dealer__Company_Number__c+':'+objServiceAppoLine.dealer__Op_Code_Name__c));
            }        
        }

        for(dealer__StandardOpCode__c objStandardOpCode : [Select Id, Name, dealer__Op_Code__c FROM dealer__StandardOpCode__c WHERE dealer__Op_Code__c IN : opCodeStringList]){
            StandardOpCodeMap.put(objStandardOpCode.dealer__Op_Code__c, objStandardOpCode);
        }            
        
        for(dealer__Service_Appointment_Line__c objServiceAppoLine : ServiceAppointmentLineList){
        
            if(ServiceAppointmentMap.get(objServiceAppoLine.dealer__Service_Appointment__c) != null && objServiceAppoLine.dealer__Op_Code_Name__c != null){
            
                String StandardOpCode = String.valueOf(ServiceAppointmentMap.get(objServiceAppoLine.dealer__Service_Appointment__c).dealer__Company_Number__c+':'+objServiceAppoLine.dealer__Op_Code_Name__c);
                
                if(StandardOpCodeMap.get(StandardOpCode) != null){
                
                    objServiceAppoLine.dealer__Standard_Op_Code__c = StandardOpCodeMap.get(StandardOpCode).Id;
                    
                    if(objServiceAppoLine.Name == null || objServiceAppoLine.Name == ''){
                        objServiceAppoLine.Name = StandardOpCodeMap.get(StandardOpCode).Name;
                    }
                }
            }
        }
    }
    
    //Handler method link Service Appointment Line with Service Appointment based on Extenal Id    
    public static void ServiceAppointOnInsertUpdate(List<dealer__Service_Appointment_Line__c> ServiceAppointmentLineList){
    
        Set<String> appointmentXREF = new Set<String>(); //dealer__Appointment_Key__c 
        Set<String> appointmentIDSet = new Set<String>();
        Map<String, dealer__Service_Appointment__c> appointmentMap = new Map<String, dealer__Service_Appointment__c>();

        for(dealer__Service_Appointment_Line__c s : ServiceAppointmentLineList){

            if (s.dealer__Service_Appointment__c != null) {
                appointmentIDSet.add(s.dealer__Service_Appointment__c);
            }

            if(s.dealer__Service_Appointment__c == null && s.dealer__Appointment_Key__c != null) {
                appointmentXREF.add(s.dealer__Appointment_Key__c);
            }
        }
               
        for(dealer__Service_Appointment__c saL : [Select Id, Name, dealer__External_Id__c from dealer__Service_Appointment__c where dealer__External_Id__c IN : appointmentXREF OR Id IN:appointmentIDSet]){        
            appointmentMap.put(saL.dealer__External_Id__c, saL);
            appointmentMap.put(saL.Id, saL);
        }

        for(dealer__Service_Appointment_Line__c s : ServiceAppointmentLineList){

            if(appointmentMap.get(s.dealer__Appointment_Key__c) !=null && s.dealer__Appointment_Key__c != null){
            
                if(appointmentMap.get(s.dealer__Appointment_Key__c).Id != null){
                
                    s.dealer__Service_Appointment__c = appointmentMap.get(s.dealer__Appointment_Key__c).Id;
                } 
            }

            // Apply the Line Key external ID based on the Paren Reccord Name field and line sequence# dealer__Line__c
            if(appointmentMap.get(s.dealer__Service_Appointment__c) != null && s.dealer__Line__c != null){
            
                String lineKeyString = appointmentMap.get(s.dealer__Service_Appointment__c).Name +'-'+s.dealer__Line__c;
                
                if(s.dealer__Line_Key__c != lineKeyString){
                    s.dealer__Line_Key__c = lineKeyString;
                }
            }
        }  
    }
    
    //Handler method to update event description
    public static void EventDescriptionOnAfter(List<dealer__Service_Appointment_Line__c> ServiceAppointmentLineList){
    
        Set<Id> ServiceAppointmentIdSet = new Set<Id>();
        Map<String, Event> EventMap = new Map<String, Event>(); 
        Map<Id, List<dealer__Service_Appointment_Line__c>> ServiceAppointmentMap = new Map<Id, List<dealer__Service_Appointment_Line__c>>();
        Map<Id, Event> EventsToUpdateMap = new Map<Id, Event>();         
        
        for(dealer__Service_Appointment_Line__c objServiceAppointmentLine : ServiceAppointmentLineList){

            if(objServiceAppointmentLine.dealer__Service_Appointment__c != null) {
                ServiceAppointmentIdSet.add(objServiceAppointmentLine.dealer__Service_Appointment__c);
            }
        }
        
        for(Event objEvent : [Select Id, Type, ActivityDate, ActivityDateTime, WhatId FROM Event WHERE WhatId IN : ServiceAppointmentIdSet  AND Type = 'Service Appointment']){
            EventMap.put(objEvent.WhatId, objEvent);
        }   
        
        for(dealer__Service_Appointment__c objServiceAppointment : [SELECT Id, Name, (SELECT Id, Name, dealer__Complaint__c FROM dealer__Service_Appointment_Lines__r) FROM dealer__Service_Appointment__c WHERE ID IN : ServiceAppointmentIdSet]){
            ServiceAppointmentMap.put(objServiceAppointment.Id, objServiceAppointment.dealer__Service_Appointment_Lines__r);
        }
        
        for(dealer__Service_Appointment_Line__c objServiceAppointmentLine : ServiceAppointmentLineList){
        
            Event objEvent = new Event();
            String EventDescription = '';
            
            if(objServiceAppointmentLine.dealer__Service_Appointment__c != null){
            
                if(EventMap.get(objServiceAppointmentLine.dealer__Service_Appointment__c) != null){
                    objEvent = EventMap.get(objServiceAppointmentLine.dealer__Service_Appointment__c);
                }
                
                if(ServiceAppointmentMap.get(objServiceAppointmentLine.dealer__Service_Appointment__c) != null){
                    for(dealer__Service_Appointment_Line__c s : ServiceAppointmentMap.get(objServiceAppointmentLine.dealer__Service_Appointment__c)){
                        if(s.dealer__Complaint__c != null && s.dealer__Complaint__c != ''){
                            EventDescription += s.dealer__Complaint__c;
                        }
                    }
                }                
            }
            objEvent.Description  = EventDescription;
            EventsToUpdateMap.put(objEvent.Id, objEvent);

        }  
        
        if(EventsToUpdateMap.size()>0){
            update EventsToUpdateMap.values();
        }   
    }
}