/**
* SalesAppointment_EXT - 
*
*
**
* Date            |Developer            |Work#
* Notes
* --

*2016.07.01       |Sneha                |Case#1867
*   Update Customer & Sales Up depending on given criteria

*2016.07.27       |Sneha                |Case#1941
*   If Timezone of Assigned to user is different then the logged in user then convert the DateTime with respect to Assigned user

*2016.07.28       |Sneha                |Case#1941
*   to display timezone when assigned user is selected
*/
public with sharing class SalesAppointment_EXT {
    
    private final dealer__Sales_Appointment__c appt;
    public String upId {get;set;}
    ApexPages.Standardcontroller controller;
    public dealer__Sales_Up__c up;
    public boolean futureAppointmentExists {get;set;}
    
    public SalesAppointment_EXT(ApexPages.standardController s) {
        
        appt = (dealer__Sales_Appointment__c)s.getRecord();
        controller = s;        
        
        //#1867 : Begins
        string salesUpId = '';
        
        Map<string,string> mapParameters = ApexPages.currentPage().getParameters();
        
        //Get parent salesup record id
        for(String key :mapParameters.keyset()){
            
            //if the page is opened by "New Sales appointment" button click, check for _lkid
            if(key.contains('_lkid') && mapParameters.get(key).startsWith(dealer__Sales_Up__c.sobjecttype.getDescribe().getKeyPrefix())){
                salesUpId = mapParameters.get(key);
            }
            
            //if the page is opened by "Create appointment" button click, check for uid
            if(key=='uid'){
                salesUpId = mapParameters.get(key);
            }
        }   
        salesUpId = salesUpId.trim();   
        //#1867 : Ends
                        
        System.debug(appt);
        
        if(appt.Id==null) {
            appt.dealer__Assigned_To__c = Userinfo.getUserId();
            appt.dealer__Set_By__c = Userinfo.getUserId(); 
            
            //#1867 : Begins
            //appt.dealer__Sales_Up__c= ApexPages.currentPage().getParameters().get('uid');//commented because dealer__Sales_Up__c was getting null when clicked on "New Salesup Appointment"
            if(salesUpId!=''){
                appt.dealer__Sales_Up__c = salesUpId;
            }            

            /*if(ApexPages.currentPage().getParameters().get('cid')!=null
                    &&ApexPages.currentPage().getParameters().get('cid')!='') {
                        appt.dealer__Customer__c= ApexPages.currentPage().getParameters().get('cid');
            }*/
            
            //Fetch Buyer contact & Customer account id
            for(dealer__Sales_Up__c objSalesUp: [select id,dealer__Buyer_Contact__c,dealer__Customer_Account__c,dealer__Customer_Account__r.isPersonAccount,dealer__Customer_Account__r.PersonContactId from dealer__Sales_Up__c where id = :salesUpId]){
                
                //Update buyer id if exists
                if(objSalesUp.dealer__Buyer_Contact__c!=null){
                    appt.dealer__Customer__c = objSalesUp.dealer__Buyer_Contact__c;
                }
                //Else Update customer account id if exists
                else if(objSalesUp.dealer__Customer_Account__c!=null && objSalesUp.dealer__Customer_Account__r.isPersonAccount){
                    appt.dealer__Customer__c = objSalesUp.dealer__Customer_Account__r.PersonContactId;
                }
            }
            //#1867 : Ends
            
        } else {
            // To-Do: check for open appointments and set accordingly.
        }
    
    }
    
    public string getUserTimeZone(){
        if(appt!=null && appt.dealer__Assigned_To__c!=null){
            User objUser = [select id,TimeZoneSidKey from User where id=:appt.dealer__Assigned_To__c ];
            return objUser.TimeZoneSidKey;
        }
        else{
        }
        return '';
    }
    
    public PageReference Save() {

        List<dealer__Sales_Appointment__c> sa=[SELECT id,dealer__Original_Date__c,dealer__Date__c,dealer__Time__c from dealer__Sales_Appointment__c where id=:appt.ID];

        // Appointment Time Missing Error
        if(appt.dealer__Time__c==null || appt.dealer__Time__c=='') {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Appointment Time Missing'));
            return null;
        }

        if(sa.size()>0 && sa[0].dealer__Original_Date__c==null){
            appt.dealer__Original_Date__c = sa[0].dealer__Date__c;
            appt.dealer__Original_Time__c = sa[0].dealer__Time__c;
        }

        DateTime md = DateTime.newInstance(appt.dealer__Date__c.year(), appt.dealer__Date__c.month(), appt.dealer__Date__c.day());

        // Setup Appointment DateTime
        DateTime an = Utility.stringToDateTime(md.format('MM/dd/yyyy')+' '+appt.dealer__Time__c);
        /*
        if(an<=DateTime.now()) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Requested Appointment Time in the Past '+an));
            return null;        
        }*/
        
        // Calculate the DateTime based on Assigned Users Time Zone
        if (appt.dealer__Assigned_To__c != null) {
            User owner = [SELECT Id,TimeZoneSidKey FROM USER WHERE Id =: appt.dealer__Assigned_To__c];
        
            Timezone currenttz = UserInfo.getTimeZone(); 
            Timezone targettz = Timezone.getTimeZone(owner.TimeZoneSidKey); 
            //DateTime dt = DateTime.newInstance(salesAppointment.dealer__Date__c, salesAppointmentTime); 
            System.debug('targettz.getID() - '+targettz.getID()+'\ncurrenttz.getID()'+currenttz.getID());
            
            //Case#1941 Begin
            //If Timezone is different convert the DateTime with respect to Assigned user
            if(targettz.getID()!=currenttz.getID()){
                System.debug('Different Timezone');
                an = an.AddSeconds((targettz.getOffset(an)-currenttz.getOffset(an))/1000); 
            }
            //appt.dealer__Time__c = an.format('hh:mm a', targettz.getID()); 
            //Case#1941 End
            
            System.debug('Time - '+appt.dealer__Time__c);

        }
        System.debug('Date Time- '+an);
        // Set the DateTime
        appt.dealer__DateTime__c = an;
        
        if(appt.dealer__Sales_Up__c!=null) {
            up  =   [Select Id from dealer__Sales_Up__c where Id = :appt.dealer__Sales_Up__c limit 1];  
            
        }

        try {
        
            if(appt.Id==null) {
                insert appt;
            } else {
                update appt;
            }

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An unexpected error occurred. '+e.getMessage()));
            return null;
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An unexpected error occurred. '+e.getMessage()));
            return null;
        }
        
        PageReference upPage = new ApexPages.StandardController(up).view();
        upPage.setRedirect(true);
        return upPage;
    }
    
    
}