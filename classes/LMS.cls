/**
 * LMS
 * @description
 */
public with sharing class LMS {
    
    /**
     * LMS 
     * @description
     */
    public LMS() {}
    
    /**
     * notifyUrbanScience 
     * @param  e , e = Event
     * @param  r , r = Record ID
     * @return void
     * @description  Callout to Urban Sciences ELS. This method is typically called via trigger
     */ 
    @future (callOut=true)
    public static void notifyUrbanScience(String e, Id r) 
    {
        
        // Check to ensure dealer is participating
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        Boolean sendLead = false;
        // Get Required Lead Info
        dealer__Sales_Up__c[] sup = [Select Id, CreatedDate, CreatedBy.Name, dealer__LMS_ID__c, dealer__Enterprise_System_Submission_Date__c, 
                                     dealer__Lead_Origination_Service__c, dealer__Make__c, dealer__Salesperson_1__r.Name, dealer__Lead_Type__c 
                                     from dealer__Sales_Up__c 
                                     where Id=:r limit 1];
        
        if(sup.size()!=1) {
            // Perform Error Notification as this must always be set.
            System.debug('Error: SalesUp not found');
            return;
        }
        
        if(sup[0].dealer__Lead_Origination_Service__c == 'Urban Science') {
            sendLead=true;
        }
        
        if(sup[0].dealer__Lead_Type__c=='Walk-In' && sup[0].dealer__Make__c =='Nissan') {
            sendLead=true;
        }
        
        String dt = '';
        if(sup[0].dealer__Enterprise_System_Submission_Date__c!=null) {
            dt = sup[0].dealer__Enterprise_System_Submission_Date__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');     
        } else {
            dt = sup[0].CreatedDate.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');  
        }
        
        // Determine Approrpiate User to Report On
        String reportingUser = sup[0].CreatedBy.Name;
        if(sup[0].dealer__Salesperson_1__r.Name!=null) {
            reportingUser = sup[0].dealer__Salesperson_1__r.Name;
        }
        
        String jsonPayload = '[{"Key":"vzuE31UOGAHWy87HUnV5rQCxV8hGl2mP","Event":"'+e+'","RecordID":"'+sup[0].Id+'","LMSID":"'+sup[0].dealer__LMS_ID__c+'", "CreatedBy":"'+reportingUser+'", "CreatedDate":"'+dt+'"}]';
        
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://apsv1.dealerteam.com/api/urbanscience/leadModified');
        req.setEndpoint('https://appdev.dealerteam.com/urbanscience/leadModified.php');
        req.setMethod('POST');
        req.setBody(jsonPayload);
        
        if(!Test.isRunningTest() && crm.dealer__UrbanScience_Active__c!=false && sendLead==true) {
            Http http = new Http();
            HttpResponse res = http.send(req);
        
            //System.debug(res.getBody());
            //check the response
            if (res.getStatusCode() == 200) {
                System.debug('Callout successful');
            } else {
                System.debug('Callout failed: ' + res);
            } 
        }
    }
}