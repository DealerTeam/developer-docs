/**
 * BirthDayRemainderScheduler
 * @description
 */ 
global with sharing class BirthDayRemainderScheduler implements Schedulable{
    
    /**
     * execute 
     * @param  SC 
     * @return void
     * @description
     */ 
    global void execute (SchedulableContext SC)
    {
        BirthDayReminder_AC br=  new BirthDayReminder_AC();       
        br.birthdayWishes();
       
    }
}