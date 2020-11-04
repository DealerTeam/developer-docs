/**		
 * 		Handler for SalesAppointmentControl trigger
 **/
public class SalesAppointmentControlHandler {
    
    
    /** 
    *  	Deletes related Event records on before delete context
    * 	@param dealer__Sales_Appointment__c old list
    **/ 
    public void handleBeforeDelete(List<dealer__Sales_Appointment__c> oldSalesApptList){
        
        Map<Id,dealer__Sales_Appointment__c> supMap = new Map<Id,dealer__Sales_Appointment__c>();
        for(dealer__Sales_Appointment__c a : oldSalesApptList){
            if(supMap.get(a.dealer__Sales_Up__c) == null){
            	supMap.put(a.dealer__Sales_Up__c, a);
            }
        }
        
        List<Event> e = [SELECT Id, WhatId, ActivityDateTime FROM Event 
                    	WHERE WhatId =:supMap.keySet() AND Type = 'Sales Appointment'];
        
        List<Event> eventsToDelete = new List<Event>();
        if(!e.isEmpty()){
            for(Event evt: e){
                if(supMap.get(evt.WhatId).dealer__DateTime__c == evt.ActivityDateTime){
                    eventsToDelete.add(evt);
                }
            }
        }
        
        if(eventsToDelete.size() > 0){
            try {
                delete eventsToDelete;           
            } Catch(DmlException ex) {
                Trigger.old[0].addError('Failed to remove calendar event when deleting appointment. '+ex.getMessage());
            }
        }
    }
    
    /**
     *  Populate Date and Time fields with DateTime value on before context
     * 	@param dealer__Sales_Appointment__c list
     **/
    public void handleBeforeDateTime(List<dealer__Sales_Appointment__c> salesApptList){
        
        for(dealer__Sales_Appointment__c a : salesApptList) {

            if (a.dealer__DateTime__c != null)  {
                a.dealer__Date__c = a.dealer__DateTime__c.date();
                a.dealer__Time__c = a.dealer__DateTime__c.format('h:mm a');
            }
        }
    }
    
    /**
     *  Creates related event on after Insert context
     * 	@param dealer__Sales_Appointment__c list
     **/
    public void handleAfterInsert(List<dealer__Sales_Appointment__c> salesApptList){

        //Get DMS Settings
        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        Set<id> supIds = new Set<id>();
        for(dealer__Sales_Appointment__c sa : salesApptList){
            supIds.add(sa.dealer__Sales_Up__c);
        }
        Map<id, dealer__Sales_Up__c> supMap = new Map<id, dealer__Sales_Up__c>([SELECT Id, dealer__Buyer_Contact__c, dealer__Buyer_Contact__r.Name FROM dealer__Sales_Up__c WHERE Id IN :supIds]);

        List<Event> eventsToInsert = new List<Event>();
        for(dealer__Sales_Appointment__c a : salesApptList) {
            if(a.Assigned_To__c != null){
                Event e = new Event();
                e.ActivityDateTime = a.dealer__DateTime__c;
                
                if(a.dealer__DateTime__c != null){
                    e.ActivityDate = a.dealer__DateTime__c.date();
                }
                
                e.StartDateTime = a.dealer__DateTime__c;
                e.WhoId = a.dealer__Customer__c;
                e.WhatId= a.dealer__Sales_Up__c;
                e.DurationInMinutes=60;
                e.OwnerId=a.dealer__Assigned_To__c;
                e.Type = 'Sales Appointment';
                e.Subject = 'Sales Appointment';

                //W-002164 Begins
                if(dms.size() > 0 && dms[0].dealer__SalesAppointmentLinkedEvent__c == true){
                    e.dealer__Sales_Appointment__c = a.Id;
                    e.description = a.dealer__Notes__c;

                    String s = '';
                    
                    if(supMap.get(a.dealer__Sales_Up__c).dealer__Buyer_Contact__r.Name != null && supMap.get(a.dealer__Sales_Up__c).dealer__Buyer_Contact__r.Name != ''){
                        s = 'Sales Appointment: ' + supMap.get(a.dealer__Sales_Up__c).dealer__Buyer_Contact__r.Name;
                    } else{
                        s = 'Sales Appointment';
                    }
                    
                    
                    if(s.length() > 255){
                        s = s.substring(0,255);
                    }

                    e.Subject = a.dealer__Subject__c != null && a.dealer__Subject__c != '' ? a.dealer__Subject__c : s;
                }
                //W-002164 Ends

                eventsToInsert.add(e);
            }
            
        }
        
        try {
            insert eventsToInsert;
        } Catch(DmlException ex) {
            salesApptList[0].addError('Failed to create calendar event for this appointment. '+ex.getMessage());
        }
        
        handleAfterInsertUpdate(salesApptList);
        
    }
    
    /**
     *   on after Update context
     * 	@param dealer__Sales_Appointment__c list
     **/
    public void handleAfterUpdate(List<dealer__Sales_Appointment__c> salesApptList){

        //Get DMS Settings
        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        
        Map<Id,dealer__Sales_Appointment__c> supMap = new Map<Id,dealer__Sales_Appointment__c>();
        for(dealer__Sales_Appointment__c a : salesApptList) {
            if(supMap.get(a.dealer__Sales_Up__c) == null){
            	supMap.put(a.dealer__Sales_Up__c, a);
            }
        }
        
        Map<id, dealer__Sales_Up__c> buyerMap = new Map<id, dealer__Sales_Up__c>([SELECT Id, dealer__Buyer_Contact__c, dealer__Buyer_Contact__r.Name FROM dealer__Sales_Up__c WHERE Id IN :supMap.keyset()]);

        List<Event> e = [Select evt.Id, evt.Type, evt.ActivityDate, evt.ActivityDateTime, evt.WhatId
                             from Event evt 
                             where evt.WhatId IN: supMap.keySet()
                             and evt.Type = 'Sales Appointment' 
                             limit 200];
        
        List<Event> eventsToUpdate = new List<Event>();
        if(e.size()>0){
            
            for(Event evt : e){
                
                evt.ActivityDateTime = supMap.get(evt.WhatId).dealer__DateTime__c;
                evt.ActivityDate = supMap.get(evt.WhatId).dealer__DateTime__c.date();
                evt.StartDateTime = supMap.get(evt.WhatId).dealer__DateTime__c;
                
                //T-00988 Begin         
                if(supMap.get(evt.WhatId).dealer__DateTime__c != null) {             
                    //Add 60 minutes to startdatetime instead of adding durationInMinutes
                    evt.EndDateTime = supMap.get(evt.WhatId).dealer__DateTime__c.addseconds(3600);
                }
                evt.DurationInMinutes=null;
                //T-00988 End
                
                evt.WhoId = supMap.get(evt.WhatId).dealer__Customer__c;
                evt.OwnerId = supMap.get(evt.WhatId).dealer__Assigned_To__c;
                evt.Subject = 'Sales Appointment';
                //W-002164 Begins
                if(dms.size() > 0 && dms[0].dealer__SalesAppointmentLinkedEvent__c == true){
                    evt.dealer__Sales_Appointment__c = supMap.get(evt.WhatId).Id;
                    evt.description = supMap.get(evt.WhatId).dealer__Notes__c;

                    String s = 'Sales Appointment: ' + buyerMap.get(evt.WhatId).dealer__Buyer_Contact__r.Name;
                    system.debug(buyerMap.get(evt.WhatId).dealer__Buyer_Contact__r.Name);
                    
                    if(s.length() > 255){
                        s = s.substring(0,255);
                    }

                    evt.Subject = supMap.get(evt.WhatId).dealer__Subject__c != null && supMap.get(evt.WhatId).dealer__Subject__c != '' ? supMap.get(evt.WhatId).dealer__Subject__c : s;
                }
                //W-002164 Ends

                eventsToUpdate.add(evt);
            }
            
            try {
                update eventsToUpdate;
            } Catch(DmlException ex) {
                salesApptList[0].addError('Failed to update calendar event for this appointment. '+ex.getMessage());
            }
        }
        
        handleAfterInsertUpdate(salesApptList);
    }
    
    /**
     * 	 Updates SalesUp latest appointment date/time
     * 	 @param dealer__Sales_Appointment__c list	
     **/
    private void handleAfterInsertUpdate(List<dealer__Sales_Appointment__c> salesApptList){
        
        Set<ID> salesUpIds = new Set<ID>();
        for(dealer__Sales_Appointment__c a : salesApptList) {
            salesUpIds.add(a.dealer__Sales_Up__c);
        }
        
        Map<Id, dealer__Sales_Up__c> salesUpMap = new Map<Id, dealer__Sales_Up__c>([Select ID, dealer__In_Store__c, dealer__Latest_Appointment_Date_Time__c 
                                                                                    from dealer__Sales_Up__c where ID in:SalesUpIds]);

        List<dealer__Sales_Up__c> salesUpList = new List<dealer__Sales_Up__c>();
        for(dealer__Sales_Appointment__c a : salesApptList) {
                
            dealer__Sales_Up__c supOldRecord = salesUpMap.get(a.dealer__Sales_Up__c);
            
            if(supOldRecord !=null && 
               (!supOldRecord.dealer__In_Store__c || supOldRecord.dealer__Latest_Appointment_Date_Time__c != a.dealer__DateTime__c)) { 
                   
                   if(a.dealer__Appointment_Result__c == 'Show') {
                       supOldRecord.dealer__In_Store__c = true;
                   }
                   
                   supOldRecord.dealer__Latest_Appointment_Date_Time__c = a.dealer__DateTime__c;
                   salesUpList.add(supOldRecord);
               }
        }
        
        if(salesUpList.size()>0) {
            try {
                update SalesupList;
            } Catch(DmlException e) {
                salesApptList[0].addError('Failed to update latest appointment date/time. '+e.getMessage());
            }
        } 
    }
}