public class RentalAgreementControlHandler {
        /*
        Rental Schedule Event - Agreements__c, Event_Start__c, Event_End__c, Rental_Rate__c
                                 Vehicle_Inventory__c
        */
    public RentalAgreementControlHandler(){} 
    public void manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew){
        List<Rental_Schedule_Event__c> newEvents = new List<Rental_Schedule_Event__c>();
        for(Rental_Agreements__c ra : triggerNew){
            Boolean fromScheduler = ra.FromScheduler__c == null || ra.FromScheduler__c == false ? false : true;
            if(!fromScheduler && ra.Rental_Vehicle__c != null && ra.DateTime_Out__c != null && ra.DateTime_DUE_IN__c != null){
                newEvents.add(new Rental_Schedule_Event__c(
                    Event_Start__c = ra.DateTime_Out__c,
                    Event_End__c = ra.DateTime_DUE_IN__c,
                    Agreements__c = ra.Id,
                    Location__c = ra.Location__c,
                    Rental_Rate__c = ra.Rental_Rates_code__c,
                    Vehicle_Inventory__c = ra.Rental_Vehicle__c,
                    Customer_Contact__c = ra.Contact__c
                ));
            }
        }
        insert(newEvents);
    }
    public void manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew, Map<Id,Rental_Agreements__c> triggerOldMap){
        
        Map<Id, Rental_Agreements__c> changedAgreementMap = new Map<Id,Rental_Agreements__c>();
        
        for(Rental_Agreements__c ra : triggerNew){
            if(ra.Rental_Vehicle__c != null && ra.DateTime_Out__c != null && ra.DateTime_DUE_IN__c != null){
                if(ra.DateTime_Out__c != triggerOldMap.get(ra.Id).DateTime_Out__c || ra.DateTime_DUE_IN__c != triggerOldMap.get(ra.Id).DateTime_DUE_IN__c){
                    changedAgreementMap.put(ra.Id, ra);
                }
            }
        }

        if(changedAgreementMap.size() > 0){
            Map<Id,Rental_Schedule_Event__c> eventMap = new Map<Id, Rental_Schedule_Event__c>();//Rental Agreement id , schedule event
            for(Rental_Schedule_Event__c rse : [SELECT Id, Agreements__c FROM Rental_Schedule_Event__c WHERE Agreements__c IN: changedAgreementMap.Keyset()]){
                eventMap.put(rse.Agreements__c,rse);
            }

            //Now Loop through changed agreement map and see which schedules need created or updated.
            List<Rental_Schedule_Event__c> upsertEvents = new List<Rental_Schedule_Event__c>();
            for(Rental_Agreements__c ra : changedAgreementMap.values()){
                if(eventMap.get(ra.Id) != null){//event already exists
                    upsertEvents.add(new Rental_Schedule_Event__c(
                        Id = eventMap.get(ra.Id).Id,
                        Event_Start__c = ra.DateTime_Out__c,
                        Event_End__c = ra.DateTime_DUE_IN__c
                    ));
                } else if(eventMap.get(ra.Id) == null){ // event does not exist
                    upsertEvents.add(new Rental_Schedule_Event__c(
                        Event_Start__c = ra.DateTime_Out__c,
                        Event_end__c= ra.DateTime_DUE_IN__c,
                        Agreements__c= ra.Id,
                        Location__c = ra.Location__c,
                        Rental_Rate__c= ra.Rental_Rates_code__c,
                        Vehicle_Inventory__c=ra.Rental_Vehicle__c,
                        Customer_Contact__c=ra.Contact__c
                    ));
                }
            }
            if(upsertEvents.size() > 0){
                upsert upsertEvents;
            }
        }
    }
}