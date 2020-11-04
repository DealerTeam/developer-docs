public class ServiceAppointmentControlHandler 
{

    //W-000642 begin - After Insert Trigger 
    public void AddEventsonInsert(List <dealer__Service_Appointment__c> ServiceAppointmentList){
        // Udpate DateTime custom field based upon the Date__c and Time__c fields
       
        dealer__DMS_Settings__c dms =  dealer__DMS_Settings__c.getValues('ActiveSettings');
         if(dms.dealer__Service_Appointment_Durration__c == null){ 
             dms.dealer__Service_Appointment_Durration__c=15;
             update dms; 
         }

        Set<Id> setAppId = new Set<Id>();
        List<dealer__Service_Appointment__c> lstAppointment = new List<dealer__Service_Appointment__c>();
        List<Event> listEventsToBeUpserted = new List<Event>();

        //get all service appointment ids
        for(dealer__Service_Appointment__c objServiceAppoinement : ServiceAppointmentList) {   
            setAppId.add(objServiceAppoinement.id);
        }   

        //Query all related events
        lstAppointment = [select Id,dealer__Date_Time__c,dealer__Customer_Contact__c,dealer__SA__c,
                                (Select Id, Type, ActivityDate, ActivityDateTime,StartDateTime,WhoId,WhatId,
                                DurationInMinutes,OwnerId,dealer__Activity_Type__c,Subject 
                                from Events where Type = 'Service Appointment' 
                                limit 1) from dealer__Service_Appointment__c where id in :setAppId];
        
        for(dealer__Service_Appointment__c objServiceAppoinement : lstAppointment) {                
                Event objEvent = new Event();           
                   
                objEvent.ActivityDateTime = objServiceAppoinement.dealer__Date_Time__c;
                objEvent.StartDateTime = objServiceAppoinement.dealer__Date_Time__c;
                objEvent.WhoId = objServiceAppoinement.dealer__Customer_Contact__c;
                objEvent.WhatId = objServiceAppoinement.Id;
                objEvent.DurationInMinutes=Integer.valueOf(dms.dealer__Service_Appointment_Durration__c);
                
                if(objServiceAppoinement.dealer__SA__c!=null) {
                    objEvent.OwnerId=objServiceAppoinement.dealer__SA__c;
                }
                
                objEvent.Type = 'Service Appointment';
                objEvent.dealer__Activity_Type__c = 'Service Appointment';
                objEvent.Subject = 'Service Appointment';
                listEventsToBeUpserted.add(objEvent);
            
    
        }

        //Update/Insert events
        if(listEventsToBeUpserted.size()>0){
            upsert listEventsToBeUpserted;
        }

   }

    //W-000903 begin - After Update  Trigger 
   public void AddEventsonUpdate(List <dealer__Service_Appointment__c> ServiceAppointmentList){

        
        dealer__DMS_Settings__c dms =  dealer__DMS_Settings__c.getValues('ActiveSettings');
         if(dms.dealer__Service_Appointment_Durration__c == null){ 
             dms.dealer__Service_Appointment_Durration__c=15;
             update dms; 
         }

        Set<Id> setAppId = new Set<Id>();
        List<dealer__Service_Appointment__c> lstAppointment = new List<dealer__Service_Appointment__c>();
        List<Event> listEventsToBeUpserted = new List<Event>();

        //get all service appointment ids
        for(dealer__Service_Appointment__c objServiceAppoinement : ServiceAppointmentList) {   
            setAppId.add(objServiceAppoinement.id);
        }   

        //Query all related events
        lstAppointment = [select Id,dealer__Date_Time__c,dealer__Customer_Contact__c,dealer__SA__c,
                                (Select Id, Type, ActivityDate, ActivityDateTime,StartDateTime,WhoId,WhatId,
                                DurationInMinutes,OwnerId,dealer__Activity_Type__c,Subject 
                                from Events where Type = 'Service Appointment' 
                                limit 1) from dealer__Service_Appointment__c where id in :setAppId];
        
        for(dealer__Service_Appointment__c objServiceAppoinement : lstAppointment) {                
                List<Event> ListEventswithAppointments = new List<Event>();

                ListEventswithAppointments = objServiceAppoinement.Events;

               if(ListEventswithAppointments.size()>0){

                   if(ListEventswithAppointments[0].ActivityDateTime != objServiceAppoinement.dealer__Date_Time__c ||
                      ListEventswithAppointments[0].StartDateTime != objServiceAppoinement.dealer__Date_Time__c ||
                      ListEventswithAppointments[0].WhoId != objServiceAppoinement.dealer__Customer_Contact__c ||
                      ListEventswithAppointments[0].WhatId != objServiceAppoinement.Id ||
                      ListEventswithAppointments[0].DurationInMinutes != Integer.valueOf(dms.dealer__Service_Appointment_Durration__c) ||
                      objServiceAppoinement.dealer__SA__c!=null && ListEventswithAppointments[0].OwnerId != objServiceAppoinement.dealer__SA__c
                      ) 
                   {

                        ListEventswithAppointments[0].ActivityDateTime = objServiceAppoinement.dealer__Date_Time__c; 

                        ListEventswithAppointments[0].StartDateTime = objServiceAppoinement.dealer__Date_Time__c;
                        ListEventswithAppointments[0].WhoId = objServiceAppoinement.dealer__Customer_Contact__c;
                        ListEventswithAppointments[0].WhatId = objServiceAppoinement.Id;
                        ListEventswithAppointments[0].DurationInMinutes=Integer.valueOf(dms.dealer__Service_Appointment_Durration__c);
                    
                        if(objServiceAppoinement.dealer__SA__c!=null) {
                            ListEventswithAppointments[0].OwnerId=objServiceAppoinement.dealer__SA__c;
                        }
                        
                        ListEventswithAppointments[0].Type = 'Service Appointment';
                        ListEventswithAppointments[0].dealer__Activity_Type__c = 'Service Appointment';
                        ListEventswithAppointments[0].Subject = 'Service Appointment';


                        listEventsToBeUpserted.addAll(ListEventswithAppointments);
                   }

               }
               
        }

        //Update/Insert events
        if(listEventsToBeUpserted.size()>0){
            upsert listEventsToBeUpserted;
    }

   }

   //W-000903 begin
   public void BeforeHandlerforMapping(List <dealer__Service_Appointment__c> ServiceAppointmentList){

       
        dealer__DMS_Settings__c dms =  dealer__DMS_Settings__c.getValues('ActiveSettings');
         if(dms.dealer__Service_Appointment_Durration__c == null){ 
             dms.dealer__Service_Appointment_Durration__c=15;
             update dms; 
         }

        Set<Id> userIds = new Set<Id>(); 
        Set<Id> customerID = new Set<ID>();
        Set<String> customerExternalReference = new Set<String>();
        Set<Id> vehicleID = new Set<ID>();
        Set<String> vehicleExtRef = new Set<String>();
        Map<Id, Contact> contacts = new Map<Id, Contact>();
        Map<String, Contact> contactKey = new Map<String, Contact>(); 
        Map<Id, dealer__Service_Vehicle__c> vehicles = new Map<Id, dealer__Service_Vehicle__c>();
        Map<String, dealer__Service_Vehicle__c> vehicleKey = new Map<String, dealer__Service_Vehicle__c>();
        Set<Id> setAccountId = new Set<Id>();//W-000642
        Map<Id,Id> mapAccContactId = new Map<Id,Id>();//W-000642
        Set<Id> setLocationId = new Set<Id>();//W-000697
        
        for(dealer__Service_Appointment__c objServiceAppoinement : ServiceAppointmentList) {
            
            if(objServiceAppoinement.dealer__Customer_Contact__c  != null) {
                customerID.add(objServiceAppoinement.dealer__Customer_Contact__c );
            }
            
            if(objServiceAppoinement.dealer__Vehicle__c != null) {
                vehicleID.add(objServiceAppoinement.dealer__Vehicle__c);
            }
            
            // Check for the external customer key to field
            if(objServiceAppoinement.dealer__Customer_Number__c  != null) {
                customerExternalReference.add(objServiceAppoinement.dealer__Customer_Number__c );
            }
            
            if(objServiceAppoinement.dealer__Vehicle_VIN__c  != null) {
                vehicleExtRef.add(objServiceAppoinement.dealer__Vehicle_VIN__c );
            }

            if(objServiceAppoinement.OwnerId!=null){
                userIds.add(objServiceAppoinement.OwnerId);
            }

            //W-000642 
            if(objServiceAppoinement.dealer__Customer__c!=null){
                setAccountId.add(objServiceAppoinement.dealer__Customer__c);
            }

            //W-000697 
            if(objServiceAppoinement.dealer__Company__c!=null){
                setLocationId.add(objServiceAppoinement.dealer__Company__c);
            }
        } 
        
        //W-000697
        Set<Id> myLocations = new Set<Id>();
        for(dealer__Dealer_Location_User__c locU : [SELECT Id, dealer__Dealer_Location__c FROM dealer__Dealer_Location_User__c WHERE dealer__User__c =: UserInfo.getUserId() and dealer__Dealer_Location__c in :setLocationId]) {
            myLocations.add(locU.dealer__Dealer_Location__c);
        }

        //W-000642
        for(Account a:[select id,(select id from contacts) from Account where id in :setAccountId]){
            if(a.contacts.size()>0){
                mapAccContactId.put(a.Id,a.contacts[0].id);
            }
        }
        
        List<Contact> cList = [Select Id,dealer__External_ID__c from Contact where Id in : customerID 
                                    or dealer__External_ID__c in :customerExternalReference 
                                    limit 2000];
                                                   
        for(Contact objContact : cList) {
                contacts.put(objContact.Id, objContact);
                contactKey.put(objContact.dealer__External_ID__c, objContact);
        }
        
        List<dealer__Service_Vehicle__c> vList = [Select Id,dealer__VIN__c from dealer__Service_Vehicle__c where id in:vehicleId or  dealer__VIN__c in:vehicleExtRef limit 2000];
        
        for(dealer__Service_Vehicle__c objServiceVechile : vList) {
            vehicles.put(objServiceVechile.ID, objServiceVechile);
            vehicleKey.put(objServiceVechile.dealer__VIN__c, objServiceVechile);
        }    

        Map<Id, User> ownerIdDivision = new Map<Id,User>([Select Id, Division from User where IsActive = true and Id IN:userIds limit 5000]);
        //Map<Id, Contact> customerInfo = new Map<Id, Contact>([Select Id, FirstName, LastName, Email from Contact where Id IN:customerIds limit 5000]);    
        for(dealer__Service_Appointment__c objServiceAppoinement : ServiceAppointmentList) {

            //W-000697 Add error if Logged in user is not related to the location of Appointment
            if(objServiceAppoinement.dealer__Company__c!=null && !myLocations.contains(objServiceAppoinement.dealer__Company__c)){
                objServiceAppoinement.addError('Error: Logged in user is not related to the location of Appointment');
            }

            //Add error if sequence number not set
            if(dms.dealer__Service_Appointment_Sequence_Number__c==null) {
                objServiceAppoinement.Name.addError('Error: Service Appointment Sequence Number is not set in the Setup');
            }

            //Update SA Name with Appointment sequence number
            Integer apptNumber = Integer.valueOf(String.valueOf(dms.Service_Appointment_Sequence_Number__c)) + 1;
            dms.Service_Appointment_Sequence_Number__c = apptNumber;

            System.debug(dms.Service_Appointment_Sequence_Number__c);
            
            try {
                update dms;    
                system.debug(dms);
            } Catch(DmlException e) {
                throw new DmlException(e.getMessage());
            }
            
            objServiceAppoinement.Name = 'SA#'+apptNumber; 
            
            //W-000642
            if(objServiceAppoinement.dealer__Customer_Number__c==null && objServiceAppoinement.dealer__Customer__c != null) {
                
                //Check if Account has any child contacts if yes then assign the same
                if( mapAccContactId.keyset().contains(objServiceAppoinement.dealer__Customer__c)){
                    objServiceAppoinement.dealer__Customer_Contact__c = mapAccContactId.get(objServiceAppoinement.dealer__Customer__c);             
                }
            }   
            //W-000642

            // if statement added to support location based appointment scheduling for multi location scheduler.
            if( Utility.isBlank( objServiceAppoinement.dealer__Company__c) && Utility.isBlank( objServiceAppoinement.dealer__Company_Number__c) ) {
                
                // Set Company Number based on Record Owner
                if(ownerIdDivision.get(objServiceAppoinement.OwnerId)!=null) {
                    objServiceAppoinement.dealer__Company__c          =   Utility.lookupUserLocation();
                    objServiceAppoinement.dealer__Company_Number__c   =   ownerIdDivision.get(objServiceAppoinement.OwnerId).Division;
                }
            }

            //Update Name according to Company Number
            if ( !Utility.isBlank(objServiceAppoinement.dealer__Company_Number__c) ) {
                objServiceAppoinement.Name = 'SA#'+objServiceAppoinement.dealer__Company_Number__c+'-'+String.valueOf(apptNumber);
            }
            
            // Set Customer if Not Previously Set
            if(contacts.get(objServiceAppoinement.dealer__Customer_Contact__c) == null && objServiceAppoinement.dealer__Customer_Number__c != null) {
                if(contactKey.get(objServiceAppoinement.dealer__Customer_Number__c)!=null) {
                    objServiceAppoinement.dealer__Customer_Contact__c = contactKey.get(objServiceAppoinement.dealer__Customer_Number__c).Id;       
                }
            }
            
            // Set Vehicle Record by VIN
            if(vehicles.get(objServiceAppoinement.dealer__Vehicle__c)==null && objServiceAppoinement.dealer__Vehicle_VIN__c != null) {
                if(vehicleKey.get(objServiceAppoinement.dealer__Vehicle_VIN__c)!=null) {
                    objServiceAppoinement.dealer__Vehicle__c = vehicleKey.get(objServiceAppoinement.dealer__Vehicle_VIN__c).Id;
                }
            }            
        }
    }

    //Delete events when sales appointment is deleted
   public void DeleteEvents(List <dealer__Service_Appointment__c> ServiceAppointmentList){

        Set<Id> setAppId = new Set<Id>();

        //Get all service ids
        for(dealer__Service_Appointment__c a : ServiceAppointmentList) {
            setAppId.add(a.Id);
        }

        //fetch the associated events
        List<Event> listEventsToBeDeleted = [Select Id  from Event where WhatId in :setAppId
                                and Type = 'Service Appointment' ];

        //Delete the events
        if(listEventsToBeDeleted!=null && listEventsToBeDeleted.size()>0){
            delete listEventsToBeDeleted;
        }

   }

  
}
//W-000903 Ends