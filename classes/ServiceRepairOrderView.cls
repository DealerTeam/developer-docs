public with sharing class ServiceRepairOrderView {

    public String rId {get;set;}
    public Service_Repair_Order__c ro {get;set;}
    public Vehicle_Inventory__c inventoryRecord {get;set;}
    public Dealer_Location__c location {get;set;}
    public String email {get;set;}
    public String subject {get { return 'Service Repair Order from '+UserInfo.getOrganizationName(); } set;}
    public String body { get; set; }
    public String TOADDRESS {get;set;}
    public String ccAddress {get;set;}
    public List<AttachmentClass> listAttachment{get;set;}
    public dealer__FixedOperationsSettings__c ops {get;set;}
    public String postingURL {get;set;}
    public Attachment objAttachment{get;set;}
    public Transient Component.Apex.OutputPanel relatedLists { get; set; }

    public ServiceRepairOrderView(ApexPages.StandardController c) {

        // Get related data for VF Page
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Service_Repair_Order__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        ccAddress=''; 
        listAttachment = new List<attachmentClass>();
        objAttachment = new Attachment();

        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            c.addFields(af);
        }
        
        ops = dealer__FixedOperationsSettings__c.getOrgDefaults();

        this.ro = (dealer__Service_Repair_Order__c)c.getRecord();        
        for (dealer__Service_Repair_Order__c roData: [ SELECT dealer__Customer_Contact__c, dealer__Customer__c, dealer__Customer_Contact__r.email, dealer__Customer__r.PersonEmail FROM dealer__Service_Repair_Order__c WHERE id =: ro.Id ] ) {
            if ( roData.dealer__Customer_Contact__c != null && roData.dealer__Customer_Contact__r.email != null ) {
                TOADDRESS = roData.dealer__Customer_Contact__r.email;
            } else if( roData.dealer__Customer__c != null && roData.dealer__Customer__r.PersonEmail != null ) {
                TOADDRESS = roData.dealer__Customer__r.PersonEmail;
            }
        }

        // Set the Location if not set
        if(ro.Id!=null && ro.Company__c!=null) {
            location = [SELECT Id, Customer_Pay_Labor_Rate__c, LaborCost__c, Warranty_Labor_Rate__c, Internal_Labor_Rate__c FROM Dealer_Location__c WHERE Id=:ro.Company__c LIMIT 1];
        }

        // Stage related inventory record
        inventoryRecord = new Vehicle_Inventory__c();
        if(ro.Vehicle_Inventory__c != null) {
            inventoryRecord = VehicleInventoryAPI.selectAllFields(ro.Vehicle_Inventory__c);
        }

        // Obtain valid list views to render
        relatedLists = Utility.sObjectRelatedListComponent('dealer__Service_Repair_Order__c');
    }

    public String getDealerLocation() {
        return JSON.serialize(location);
    }   

    public PageReference save() {
        if(ro.dealer__Vehicle__c!=null) {
            dealer__Service_Vehicle__c v = [Select Id, dealer__VIN__c from dealer__Service_Vehicle__c 
                                            where Id=:ro.dealer__Vehicle__c limit 1];
            ro.dealer__VIN__c = v.dealer__VIN__c;
        }

        try {
            if(ro.Id==null) {
                insert ro;
            } else {
                update ro;
            }
        } catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
        }

        return new ApexPages.StandardController(ro).view();
    }
 
    public PageReference updateVehicle() {
        if(inventoryRecord.Id!=null) {
            try {
                update inventoryRecord;
            } Catch(DmlException e) {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Vehicle could not be updated: '+ e.getDmlMessage(0)));
               return null;                
            }
        }
        return null;
    }

    public PageReference detailUpdate() {

        ro = [SELECT dealer__Comments__c, dealer__Company_Number__c, dealer__Create_Date_Time__c, dealer__Customer_Charges__c, dealer__Customer_Contact__c, dealer__Customer_Invoice_Total__c, dealer__Customer_Labor_Charges__c, dealer__Customer_Number__c, dealer__Customer_Parts_Charges__c, dealer__Customer_Sublet_Charges__c, dealer__Customer_Tax__c, dealer__Customer__c, dealer__Days_Down__c, dealer__Deposit__c, dealer__Discount_Code__c, dealer__Discount_Total__c, dealer__Discount_Type__c, dealer__Dispatched__c, dealer__Estimate__c, dealer__Franchise_Code__c, dealer__Hazardous_Materials__c, dealer__Internal_Charges__c, dealer__Inventory_Vehicle_Status__c, dealer__Invoiced_Date_Time__c, dealer__Location__c, dealer__Mileage_In__c, dealer__Mileage_Out__c, dealer__Parts_Invoice__c, dealer__Posted_Date_Time__c, dealer__Promise_Date__c, dealer__Promise_Time__c, dealer__RO_Number__c, dealer__Recommendations__c, dealer__Rewards_ID__c, dealer__Rewards_Number__c, dealer__Sales_Inventory_Id__c, dealer__Service_Advisor_ID__c, dealer__Service_Advisor_Name__c, dealer__Service_Advisor__c, dealer__Shop_Supplies__c, dealer__Status__c, dealer__Tag__c, dealer__Tax__c, dealer__Taxable__c, dealer__Tax_Exempt__c, dealer__VIN__c, dealer__Vehicle_Inventory__c, dealer__Vehicle__c, dealer__Waiting__c, dealer__Warranty_Charges__c, dealer__Customer_Pay_Labor__c, dealer__Customer_Pay_Parts__c, dealer__Internal_Labor_Charges__c, dealer__Internal_Parts_Charges__c, dealer__Number_of_Repair_Lines__c, dealer__Open_Flat_Rate_Hours__c, dealer__Open_Job_Lines__c, dealer__Total_Flat_Rate_Hours__c, dealer__Warranty_Labor_Charges__c, dealer__Warranty_Parts_Charges__c, dealer__Company__c, dealer__Color_Code__c, External_ID__c, upload_Customer__c, Conversion_Manufacturer__c, Lift_Model__c, Lift_Cycle_Count__c, Lift_MFG__c, Lift_Serial_Number__c, Name, Id 
              FROM dealer__Service_Repair_Order__c
            where Id=:ro.Id
            limit 1];

        return null;
    }

    public PageReference emailSRO() {
        getAttachments();
        PageReference eb = Page.SroEmail;
        if(ro != null) {
            eb.getParameters().put('ro', ro.Id);
        }
        return eb;
    }

    public pagereference getAttachments(){ 
        listAttachment = new List<attachmentClass>();

        for(Attachment a: [select id,name,ContentType from Attachment where parentId=:ro.id]){
            listAttachment.add(new AttachmentClass(a));
        }

        return null;
    }

    public PageReference sendPdf() {

        List<String> allEmails = new List<String>();
        List<String> allEmailsCC = new List<String>();

        if( String.isNotEmpty(TOADDRESS) ){
            for ( String emailRow: TOADDRESS.split(',') ) {
                if ( !validateEmail(emailRow.trim()) ) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid email address'));
                    return null;
                }
                allEmails.add(emailRow.trim());
            }
        }

        Messaging.EmailFileAttachment attach = AttachPDF();

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(allEmails);
        mail.setSubject(this.subject);
        mail.setHtmlBody(this.body);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });


        if( String.isNotEmpty(ccAddress) ){
            for ( String emailRow: ccAddress.split(',') ) {
                if ( !validateEmail(emailRow.trim()) ) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid cc email address'));
                    return null;
                }
                allEmailsCC.add(emailRow.trim());
            }
            mail.setCCAddresses(allEmailsCC);
        }

        //W-000531 begin
        List<Messaging.EmailFileAttachment> listEmailAtt = new List<Messaging.EmailFileAttachment>();
        listEmailAtt.add(attach);

        Set<Id> setAttachId = new Set<Id>();

        for(AttachmentClass a: listAttachment){
            if(a.selected){
                setAttachId.add(a.objAttachment.id);
            }
        }

        Decimal attachmentSize=0;
        for(Attachment a:[select id,name,contentType,body,BodyLength from Attachment where id in :setAttachId]){
            Messaging.EmailFileAttachment mattach = new Messaging.EmailFileAttachment();
            mattach.setContentType(a.ContentType);
            mattach.setFileName(a.Name);
            mattach.setInline(false);
            mattach.Body = a.body;
            listEmailAtt.add(mattach);
            attachmentSize+=a.BodyLength;
        }

        System.debug('attachmentSize - '+attachmentSize);
        if(attachmentSize>26214400){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Attachments must be less then 25MB'));
            return null;
        }

        mail.setFileAttachments(listEmailAtt);
        //W-000531 end

        // Send the email
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception e){
            return null;
        }


        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Purchase Order was sent to '+TOADDRESS));

        // Record Activity
        Task t = new Task( Subject='Emailed Purchase Order to '+TOADDRESS ,
                           ActivityDate=Date.today(),
                           WhatId=ro.Id,
                           Status='Completed');
        insert t;

        PageReference sq = Page.Sro;
        sq.getParameters().put('id', string.valueOf(ro.Id));
        return sq;

    }

     public Messaging.EmailFileAttachment AttachPDF() {
        PageReference pdf;
        //W-000531 begin
        if(ops.dealer__Service_Repair_Order_PDF__c!=null){
            pdf=new Pagereference(ops.dealer__Service_Repair_Order_PDF__c);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No PDF added to custom setting'));
        }



        //W-000531 end
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id', string.valueOf(ro.Id));

        // the contents of the attachment from the pdf
        Blob body;

        try {
          // returns the output of the page as a PDF
          body = pdf.getContent();

        } catch (VisualforceException e) {
          body = Blob.valueOf('Error Generating Attachment');
        }

        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName(ro.Name+'-ServiceRepairOrder.pdf');
        attach.setInline(false);
        attach.Body = body;

        return attach;
    }

    public static Boolean validateEmail(String email) {
        Boolean res = true;
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);
        if (!MyMatcher.matches())
            res = false;
        return res;
    }

    public PageReference upload() {
        System.debug('objAttachment - '+objAttachment);
        objAttachment.ParentId = ro.id; // the record the file is attached to

        try {
          insert objAttachment;
          objAttachment.body=null;
          listAttachment.add(new AttachmentClass(true,objAttachment));

        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
          return null;
        } finally {
          objAttachment = new Attachment();
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        return null;
    }

    /**
    *
    *   Return to the RO Page
    *
    */
    public PageReference returnToRo() {
        PageReference r = new ApexPages.StandardController(ro).view();
        return r;
    }

    /**
     * SImple Remote Action to get the job lines...
     * @param  masterRecordId The ID of the RO to be requested
     * @return Service Job List.
     */
    
    @RemoteAction
    public static List<dealer__Service_Job__c> loadServiceJobLines(String masterRecordId) {
        return [Select d.dealer__Stat__c, d.dealer__Standard_Operation_Code__c, d.dealer__Standard_Operation_Code__r.dealer__Service_Type__c, 
                    d.dealer__Standard_Operation_Code__r.dealer__Op_Code_Description__c, d.dealer__Service_Repair_Order__c, 
                    d.dealer__RO_Number__c, d.dealer__RO_Invoice_Date_Time__c, d.dealer__Parts_Cost__c, d.dealer__Op_Code__c, 
                    d.dealer__Line_Number__c, d.dealer__Labor_Type__c, d.dealer__Labor_Rate__c, d.dealer__Labor_Charges__c, 
                    d.dealer__Job_Start__c, d.dealer__Job_Finish__c, d.dealer__Estimate__c, d.dealer__Correction__c, 
                    d.dealer__CustomerConcern__c, d.dealer__Cause__c, d.dealer__CauseExtended__c, d.dealer__Book_Time__c, d.dealer__Actual_Time__c, dealer__Currently_Active__c,
                    d.Name, d.LastModifiedDate, d.LastModifiedById, d.dealer__Line_Total__c, d.dealer__Sublet_Total__c, d.dealer__Parts_Total__c,
                    d.Id, d.CreatedDate, d.CreatedById, d.dealer__Standard_Operation_Code__r.Name, 
                        (Select Id, Name, dealer__Counterman__c, dealer__Core__c, dealer__Cost__c, dealer__Price__c, dealer__List__c, 
                            dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Part__c, dealer__Price_Level__c, dealer__Transaction_Code__c, 
                            dealer__Part_Number__c, dealer__Part_Description__c, dealer__Bin__c, dealer__Extended_Price__c, dealer__Job_Line__c
                             From dealer__Parts_Lines__r)
                    From dealer__Service_Job__c d
                    where d.dealer__Service_Repair_Order__c = :masterRecordId 
                    order by d.dealer__Line_Number__c asc
                    limit 100];
    }


    @RemoteAction
    public static Decimal laborTotal(String lineId) {
        AggregateResult[] sumLabor = [Select SUM(Labor_Total__c) tsum FROM dealer__Technician_Job_Time__c 
                                        where  dealer__Service_Job_Line__c=:lineId];
        return (decimal) sumLabor[0].get('tsum');       
    }

    @RemoteAction 
	public static List<MiscChargeCode__c> miscChargeCodes(String locationId) {
		return ServiceAPI.miscChargeCodes(locationId);
	}

    public class AttachmentClass{
        public boolean selected{get;set;}
        public Attachment objAttachment{get;set;}

        public attachmentClass(Attachment a){
            selected = false;
            objAttachment=a;
        }

        public attachmentClass(boolean sel,Attachment a){
            selected = sel;
            objAttachment=a;
        }
    }
    
}