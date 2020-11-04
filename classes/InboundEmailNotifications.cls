global class InboundEmailNotifications implements Messaging.InboundEmailHandler {
    
   global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    
    if(email==null) {
        return null;
    }
    
  // Get the contact record from whom the email is being sent
    Contact[] contact = [Select Id from Contact where Email =:email.fromAddress order by LastActivityDate desc limit 50];
        
        // Get CRM Settings
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
            
        if(contact.size()==0) {
            return null;
        }
      
        // Determine Notes
        String strNotes    = '';
        if(email.htmlBody != null) {
            strNotes = email.htmlBody;
            strNotes = strNotes.stripHtmlTags();
        } else if (email.plainTextBody != null) {
            strNotes = email.plainTextBody;
        }
        
        // Get Owner ID Based on toAddress[0];
        Id emailOwnerId;
       
        User[] u = [Select Id from User where Email =:email.fromAddress limit 1];
        if(u.size()==0) {
            emailOwnerId=UserInfo.getUserId();
        } else {
            emailOwnerId=u[0].Id;
        }
       
        //Save Record 
        Task task = new Task();
            task.WhoId= contact[0].Id;
            task.Subject='Email: '+email.subject;
            task.ActivityDate=Date.today();
            task.Description=strNotes;
            task.OwnerId = emailOwnerId;
            task.Type = 'Email';
            task.dealer__Activity_Type__c='Email';
            //Check CRM Settings for Open or Closed Status on inbound Emails
            if(crm.dealer__Email_Inbound_Activities_Remain_Open__c==true) {
                task.status = 'Unread Email';
            } else {            
                task.Status = 'Read Email';
            }
       
        // Get most recent Sales Lead for this contact
        dealer__Sales_Up__c[] sup = [Select Id from dealer__Sales_Up__c where dealer__Buyer_Contact__c =:contact[0].Id order by CreatedDate Desc limit 1];
        if(sup.size()>0) {
            task.WhatId=sup[0].Id;
        }
        
        insert task;
       
           /*
            if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
              for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                Attachment attachment = new Attachment();
                // attach to the newly created contact record
                attachment.ParentId = contact[0].Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                insert attachment;
              }
            }
           */
    return result;
 
  }
}