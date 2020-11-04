public with sharing class SMS {

    public String customerId {get;set;}
    public Contact c {get;set;}
    public Id WhatId {get;set;}
    public String mobile;
    public String message {get;set;}
    public Boolean sendStatus {get;set;}
    public String jsonPayload {get;set;}
    public Id selectedTemplate {get;set;}
    public dealer__Sales_Up__c prospect {get;set;}
    
    public SMS() {
        sendStatus=false;
        if(ApexPages.currentPage().getParameters().get('cid')!='' && ApexPages.currentPage().getParameters().get('cid')!=null) {
            c = setContact(ApexPages.currentPage().getParameters().get('cid')); 
        }
        
        if(ApexPages.currentPage().getParameters().get('wid')!='' && ApexPages.currentPage().getParameters().get('wid')!=null) {
            WhatId = ApexPages.currentPage().getParameters().get('wid');    
        }       

        if(ApexPages.currentPage().getParameters().get('tid')!=null && ApexPages.currentPage().getParameters().get('tid')!='') {
            selectedTemplate=ApexPages.currentPage().getParameters().get('tid');
        }
    }
    
    public Contact setContact(String Id) {
        Contact[] contact = [Select Id, Name, MobilePhone, dealer__Allow_SMS__c from Contact where Id =:Id limit 1];
        if(contact.size()==1) {
            if(contact[0].dealer__Allow_SMS__c!=true) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Customer has not indicated they wish to receive text messages, please select Allow Text Messages on the Customer Record.'));
                return null;
            }
            
            this.mobile = contact[0].MobilePhone;
            return contact[0];
        } else {
            return null;
        }
    } 
    
    public PageReference send() {
        // generate JSON for call to dealerteam.com API
        dealer__SalesDeskLogSettings__c DS = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(DS==null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Employee does not have an SMS Account or Phone Number linked to their settings.'));
            return null;
        }
        if(DS.dealer__SMS_Account_Code__c==null || DS.dealer__SMS_Phone_Number__c == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Employee does not have an SMS Account or Phone Number linked to their settings.'));
            return null;
        }

        // Check Message Content for validity
        if(this.message.length() == 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The message can not be blank.'));
            return null;
        }
        
        jsonPayload = JSON.serialize(new msg(c.MobilePhone, this.message, DS.dealer__SMS_Account_Code__c, DS.dealer__SMS_Phone_Number__c, this.customerId, this.WhatId));
        
             Http h = new Http();
             HttpRequest req = new HttpRequest();
             
                req.setEndpoint('https://apsv1.dealerteam.com/api/sfdcrest/sms.php');
                req.setMethod('POST');
                req.setHeader('Content-type', 'application/json');
                req.setBody(jsonPayload);
                
                    
                if(!Test.isRunningTest()) {
                    HTTPResponse res = h.send(req);
                
                
               /* 
               System.debug('STATUS: '+res.getStatusCode());
               System.debug(res);
               System.debug(res.getBody());
               */
               
                if(res.getStatusCode()==200) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Text Message successfully delivered.'));
                    sendStatus=true;
                    // Mark task to denote SMS
                     Task t = new Task( Subject='Outbound Text',
                               Description=this.message,
                               ActivityDate=Date.today(),
                               WhoId=c.Id,
                               Status='Completed',
                               Type='SMS');
                     if(WhatId!=null) {
                        t.WhatId=WhatId;
                     }          
                     insert t;   
                
                } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Oops, there was a problem delivering the text message.'));
                    return null;
                }
        }       

        // If WHATID is provided, return user to that page.
        if(WhatId!=null) {
            PageReference p = new PageReference('/'+WhatId);
            p.setRedirect(true);
            return p;
        }

        return null;
    }

    public PageReference cancel() {
        if(WhatId!=null) {
            PageReference p = new PageReference('/'+WhatId);
            p.setRedirect(true);
            return p;
        }
        return null;        
    }

    /**
    *
    *   Get Previous Txt message interaction
    *
    *
    */ 
    public List<Task> getMessageHistory() {
        return [Select Id, Description, ActivityDate, Owner.FirstName, Owner.LastName, Subject, Type from Task where WhatId=:WhatId and ( Type='SMS' or Type='MMS' ) order by ActivityDate DESC limit 100];
    }

    /**
    *
    *   List of available templates for use in the Text Message
    *
    */
    public List<EmailTemplate> templates() {
        return [Select Id, Name from EmailTemplate where Folder.DeveloperName = 'SMS_MMS'];
    }

    /**
    *
    *   SelectOption to render the list in the User Interface
    *
    */
    public List<SelectOption> gettemplateSelect() {
        List<SelectOption> listItems = new List<SelectOption>();
        listItems.add(new SelectOption('', '---'));
        for(EmailTemplate et : templates()) {
            listItems.add(new SelectOption(et.Id, et.Name));
        }
        return listItems;
    }    

    /**
    *
    *   Get all prospect fields, both custom and managed for use in the Form Compiler
    *
    *
    */
    public void getAllProspectFields() {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get('dealer__Sales_Up__c').getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + String.escapeSingleQuotes(fieldName);
            }
        }
        String query = 'Select ' + commaSepratedFields + ' from dealer__Sales_Up__c where id = \'' + String.escapeSingleQuotes(WhatId) + '\' limit 1';
        prospect = Database.query(query);       
    }

    /**
    *
    *   Compile Form Content
    *
    */
    public Component.Apex.OutputText getcompiledMessage() {
        Component.Apex.OutputText mf = new Component.Apex.OutputText();
        if(selectedTemplate!=null && WhatId!=null) {
            getAllProspectFields();
            mf.expressions.value = [Select Id, Body from EmailTemplate where Id=:selectedTemplate limit 1].Body;
        }
        return mf;
    }


    public class msg {
        public string phone {get;set;}
        public string txt {get;set;}
        public string key {get;set;}
        public string pn { get; set;}
        public string whoid { get; set; }
        public string whatid { get; set; }
        public msg(String p, String t, String k, String epn, String woid, String whid){
            
            phone=p.replaceAll('^[0-9]+$', '');
            txt=t;
            key=k;
            pn=epn;
            whoid=woid;
            whatid=whid;
        }
    }
    
}