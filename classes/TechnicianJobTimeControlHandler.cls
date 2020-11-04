public class TechnicianJobTimeControlHandler{


    /**
    *
    *   If using start and end times set the actual time entry based on those values
    *
    *
    */
    public static void manualOrClockedActuals(List<Technician_Job_Time__c> techtimes) {
        for(Technician_Job_Time__c tt : techtimes) {
            if(tt.Start_Time__c!=null && tt.End_Time__c!=null) {
                
                Long startTime = tt.Start_Time__c.getTime();
                Long endTime   = tt.End_Time__c.getTime();
                Decimal diff = Decimal.valueOf(Integer.valueOf((endTime - startTime)));
                Decimal flatRateTime = ((((diff) / 1000) / 60) / 60);
                
                tt.Actual_Time_Entry__c = flatRateTime.setScale(1, System.RoundingMode.HALF_UP);               
            }
        }
    } 
    
    /**
    *   Labor cost logic routine
    *
    */
    public static void laborCost(List<Technician_Job_Time__c> techTimes) {
        Set<Id> locationIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
        for(Technician_Job_Time__c tt : techTimes) {
            locationIds.add(tt.Location__c);
            userIds.add(tt.Technician__c);
        }

        Map<Id, Dealer_Location__c> locations = new Map<Id, Dealer_Location__c>([
            SELECT Id, Name, LaborCost__c FROM Dealer_Location__c WHERE Id IN:locationIds
        ]);

        Map<Id, User> techs = new Map<Id, User>([
            SELECT Id, Name, Flat_Rate_Hourly_Wage__c, Flat_Rate_Technician__c FROM User where Id IN:userIds
        ]);

        // Set the defaults
        for(Technician_Job_Time__c tt : techTimes) {

            if(tt.Book_Time_Entry__c==null) {
                tt.Book_Time_Entry__c=0; 
            }

            if(tt.Actual_Time_Entry__c==null) {
                tt.Actual_Time_Entry__c=0;
            }
            // Location Based Job Costing
            if(locations.get(tt.Location__c)!=null  
                && locations.get(tt.Location__c).LaborCost__c != null) {
                    tt.Labor_Cost__c = (tt.Book_Time_Entry__c * locations.get(tt.Location__c).LaborCost__c);
            }

            // Technician Based Job Costing
            if(techs.get(tt.Technician__c)!=null 
                && techs.get(tt.Technician__c).Flat_Rate_Hourly_Wage__c!=null
                && techs.get(tt.Technician__c).Flat_Rate_Hourly_Wage__c>0 ) {
                    if(techs.get(tt.Technician__c).Flat_Rate_Technician__c==true) {
                        tt.Labor_Cost__c = (tt.Actual_Time_Entry__c * techs.get(tt.Technician__c).Flat_Rate_Hourly_Wage__c).setScale(2, RoundingMode.HALF_UP);
                    } else {
                        tt.Labor_Cost__c = (tt.Book_Time_Entry__c * techs.get(tt.Technician__c).Flat_Rate_Hourly_Wage__c).setScale(2, RoundingMode.HALF_UP);
                    }
            }
        } 
    } 

    //Utility method to update time clock entry of Technician Job Time on before event
    public static void updateTimeClockEntry(List<dealer__Technician_Job_Time__c> technicianJobTimeList){
        
        //Query today's time clock of current user.
        dealer__Time_Clock__c[] payrollClock = [Select Id from dealer__Time_Clock__c where dealer__User__c =: UserInfo.getUserId() and dealer__Date__c =: Date.Today() limit 1];
        
        //For loop of before trigger context
        for(dealer__Technician_Job_Time__c objTechnicianJobTime : technicianJobTimeList){
            
            //If there is atleast one time clock
            if(!payrollClock.isEmpty()){
                //Put time clock in Technician Job Time
                objTechnicianJobTime.Time_Clock_Entry__c = payrollClock[0].Id;
            }
        }
    }
    
    //Utility method to update Service Job Line's Labor Charges based on related Technician Job Time on After event
    public static void updateServiceJobLine(List<dealer__Technician_Job_Time__c> technicianJobTimeList){
        
        //Set of Service Job Line Ids
        Set<Id> ServiceJobLineIdSet = new Set<Id>();
        
        //List of Service Job to update
        List<dealer__Service_Job__c> ServiceJobLineUpdateList = new List<dealer__Service_Job__c>();
        
        //For loop to get Service Job Ids
        for(dealer__Technician_Job_Time__c objTechnicianJobTime : technicianJobTimeList){
            ServiceJobLineIdSet.add(objTechnicianJobTime.dealer__Service_Job_Line__c);
        }
        
        //For loop to create maps
        for(dealer__Service_Job__c objServiceJob : [SELECT Id, Name, Labor_Charges__c, (SELECT Id, Name, Labor_Total__c, Labor_Cost__c FROM Technician_Job_Times__r) FROM Service_Job__c WHERE Id IN : ServiceJobLineIdSet]){
            
            //initialize Labor charges to 0
            objServiceJob.Labor_Charges__c = 0;
            objServiceJob.Technician_Cost__c = 0;

            //For loop to add all the Labor total of related Technician Job Time to Parent Service Job's Labor Charges            
            for(Technician_Job_Time__c objTJT : objServiceJob.Technician_Job_Times__r){
            
                //If Labor Total is not null then add it to the Parent Service Job's Labor Charges
                if(objTJT.Labor_Total__c != null)
                    objServiceJob.Labor_Charges__c += objTJT.Labor_Total__c.setScale(2, RoundingMode.HALF_UP);

                if(objTJT.Labor_Cost__c!=null) 
                    objServiceJob.Technician_Cost__c += objTJT.Labor_Cost__c.setScale(2, RoundingMode.HALF_UP);             
            }
            
            //Add Service Job to list for update
            ServiceJobLineUpdateList.add(objServiceJob);            
        }
        
        //Check Service Job List for null and update
        if(ServiceJobLineUpdateList.size()>0){
            update ServiceJobLineUpdateList;
        }
    }
}