public class SalesLeadResponseTimeHandler {
    public void calculateResponseTime(List<Task> triggerNew) {
        // Get the objectkeyprefix 
        if(triggerNew[0].WhatId != null && triggerNew[0].WhatId.getSobjectType() != Sales_Up__c.sObjectType) {
            return;
        }        
        
        dealer__Sales_Up__c[] l = [SELECT Id, CreatedDate, dealer__Response_Time__c,
                                    dealer__Company_Number__c
                                    FROM dealer__Sales_Up__c
                                    WHERE Id =:triggerNew[0].WhatId 
                                    and Response_Time__c = null
                                    LIMIT 1];
                                    
        
                                    
        if(l.size() > 0) {
            Task[] taskList = [Select Id from Task where WhatId = :l[0].Id order by CreatedDate asc limit 1];
            if(taskList.size() == 1) {
                System.debug('Assigned to Lead, and Response Time == null');

                //MKS1
                BusinessHours[] bh = [Select Id from businesshours where IsActive=true and Name = :l[0].dealer__Company_Number__c];
                if(bh.size() == 0){
                    bh = [Select Id from businesshours where IsDefault=true];
                }
                //end MKS1

                long created = l[0].CreatedDate.getTime() / 1000 / 60;
                long responded = triggerNew[0].CreatedDate.getTime() / 1000 /60;
                l[0].dealer__Response_Time__c = BusinessHours.diff(bh[0].id, l[0].CreatedDate, triggerNew[0].CreatedDate) / 1000 / 60;
                update l[0];
            }
        }
    }
}