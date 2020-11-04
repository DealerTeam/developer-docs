/**
 * BirthDayReminder_AC
 * @description Creates a task on Contact for record owner  
 */ 
public with sharing class BirthDayReminder_AC {
    
    /**
     * System.today
     * System.day
     * @description Checks the current day agaisnt Contact bday day
     */ 
    Integer todayDay = System.today().day();
    
    /**
     * System.today.Month
     * @description Checks the current month against Contact bday month
     */
    Integer todayMonth = System.today().Month();
    
    /**
     * birthdayWishes 
     * @return void
     * @description Creates task for Owner to call and wish happy bday
     */ 
    public void birthdayWishes()
    {
        List<Contact> birthDayContacts = [select id, 
                                                Name,
                                                BirthDate,
                                                OwnerId
                                                from Contact where BirthDay__c=:todayDay and BirthMonth__c=:todayMonth
                                                ];
                                                
        System.debug('*************'+birthDayContacts); 
        List<Task> birthDayTasks = new List<Task>();
        for(Contact c : birthDayContacts)
        {
            Task t = new Task();
            
            t.Subject = 'Call to wish '+ c.Name +' Happy Birthday';
            t.Priority = 'High';
            t.activityDate = System.today();
            t.WhoId = c.Id;
            t.OwnerId = c.OwnerId; 
             
            birthDayTasks.add(t);   
        }
        
        if(birthDayTasks.size()>0) 
        {
            insert birthDayTasks;
        }
    }
}