public with sharing class ServiceRepairOrder_EXT {
    
    public String getUserName() {
        return UserInfo.getName();
    }
   
    public String getUserId() {
        return UserInfo.getUserId();
    }
    
    public String searchCustomerInput { get; set; }
    public String searchVehicleInput { get; set; }
    public Decimal vehicleMiles { get; set; }
    public Date vehicleLastService {get;set;}
    public String vehicleVIN { get; set; }
    public String inventoryStatus {
        get {
            return inventorystatus;
        }
        set {
            inventorystatus = value;
        }
    } 

    public List<Contact> customers { get; set;}
    public List<dealer__Service_Vehicle__c> vehicles { get; set; }
    public List<jobLineWrapper> jobList = new List<jobLineWrapper>();
    public List<dealer__Service_Job__c> selectedLines {get;set;}
    
    public dealer__DMS_Settings__c dmsSettings;
    
    public Decimal newEstimate {get;set;}
    public String estimateApprovedBy {get;set;}
    public String estimateNotes {get;set;}
    
    public String estimateApprovalMethod;
    public String getestimateApprovalMethod() {
        return estimateApprovalMethod;
    }
    public void setestimateApprovalMethod(String s) {
        this.estimateApprovalMethod = s;
    }
    
    public Integer custSize { get; set; }
    public Integer vehSize { get; set; }
    public dealer__Service_Repair_Order__c ro;
    public String techId    {get;set;}

    public dealer__Dealer_Location__c userLoc {get;set;}
    public list<dealer__Dealer_Location__c> userLoc_list = new list<dealer__Dealer_Location__c>();
    public dealer__FixedOperationsSettings__c fixedOpsSettings {
        get {
            return dealer__FixedOperationsSettings__c.getOrgDefaults();
        }
        set;
    }
    
    
    /*
     * 
     *  Controller
     * 
     * 
     */

    public ServiceRepairOrder_EXT(ApexPages.StandardController controller) {
        
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Service_Repair_Order__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            controller.addFields(af);
        }
        
        this.ro = (dealer__Service_Repair_Order__c)controller.getRecord();
        
        if(ApexPages.CurrentPage().getParameters().get('customer') != '' && ApexPages.CurrentPage().getParameters().get('customer') != null) {
            this.ro.dealer__Customer_Contact__c = ApexPages.CurrentPage().getParameters().get('customer');
            this.ro.dealer__Customer__c = [Select Id, AccountId from Contact where Id=:this.ro.dealer__Customer_Contact__c limit 1].AccountId;
        } else {
            redirectInit();
        }

        // Lookup based on Appointment
        if(ApexPages.CurrentPage().getParameters().get('aptId') != '' && ApexPages.CurrentPage().getParameters().get('aptId') != null) {
            dealer__Service_Appointment__c sa = [Select Id, dealer__Vehicle__c, dealer__Customer_Contact__c, dealer__Customer__c
                                                    From dealer__Service_Appointment__c 
                                                    where Id=: ApexPages.CurrentPage().getParameters().get('aptId')
                                                    Limit 1];

            if(sa.dealer__Customer_Contact__c!=null) {
               this.ro.dealer__Customer_Contact__c = sa.dealer__Customer_Contact__c; 
            }                                                    

            if(sa.dealer__Customer__c!=null) {
                this.ro.dealer__Customer__c = sa.dealer__Customer__c;
            } 

            if(sa.dealer__Vehicle__c!=null) {
                this.ro.dealer__Vehicle__c = sa.dealer__Vehicle__c;
            }
        }      
        
        if(ApexPages.CurrentPage().getParameters().get('vehicle') != '' && ApexPages.CurrentPage().getParameters().get('vehicle') != null) {
            this.ro.dealer__Vehicle__c = ApexPages.CurrentPage().getParameters().get('vehicle');
            dealer__Service_Vehicle__c veh = [Select Id, dealer__VIN__c, dealer__Last_Odometer__c, dealer__Last_Service__c 
                                                        from dealer__Service_Vehicle__c 
                                                        where Id = :ApexPages.CurrentPage().getParameters().get('vehicle') 
                                                        limit 1];
            vehicleVIN      =   veh.dealer__VIN__c;
            vehicleMiles    =   veh.dealer__Last_Odometer__c;          
            vehicleLastService= veh.dealer__Last_Service__c;
        }

        // Set inventorystatus of vehicle inventory record present
        inventoryStatus = ro.dealer__Inventory_Vehicle_Status__c;

        String userId = UserInfo.getUserId();
        String userLocKey = [SELECT Division FROM User WHERE Id =: userId LIMIT 1].Division;

        if( !Utility.isBlank(userLocKey) ) 
        {
             userLoc_list = [SELECT Id, Name, dealer__Address__c, dealer__City__c, dealer__Company_Number__c, dealer__Main_Phone__c, dealer__Postal_Code__c, dealer__State__c, dealer__Website__c FROM dealer__Dealer_Location__c WHERE dealer__Company_Number__c =: userLocKey LIMIT 1];
             
             if(userLoc_list.size()>0)
             userLoc=userLoc_list[0];
              
        } else {
            userLoc = null;
        }
    }
    
    /*
     * Get DMS Defaults
     */
    public dealer__DMS_Settings__c getDMSDefaults() {
        dmsSettings = dealer__DMS_Settings__c.getValues('ActiveSettings');
        return dmsSettings;
    }
 
    /*
     * Get Invoice Logo
     */
    public String getInvoiceLogo() {
        
        if(userLoc==null || userLoc.Id==null) {
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;            
        }
        
        return DealershipLocationAPI.formLogoURL(userLoc.Id); 
    }  

    /**
    *   Get Inventory Vehicle Status Values
    */ 
    /*
    String inventoryStatus = '';
    public String getInventoryStatus() { return inventoryStatus; }
    public void setInventoryStatus() { this.inventoryStatus = inventoryStatus; }
    */

    public List<SelectOption> getInventoryStatusOptions() {
        
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult F = dealer__Vehicle_Inventory__c.dealer__Status_Code__c.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();

        for(Schema.PicklistEntry pl : P) {
            if(pl.isActive()) {
                options.add(new SelectOption(pl.getValue(), pl.getLabel()));
            }
        }

        return options;
    }
    
    /*
     * Get Parts Lines
     * 
     *      params: ro.Id
     */
    public List<dealer__Parts_Invoice_Line__c> getServicePartsList() {
        List<dealer__Parts_Invoice_Line__c> plines = new List<dealer__Parts_Invoice_Line__c>();
        if(ro.Id!=null) {
        plines = [Select Id, dealer__Job_Line__c, dealer__Service_Job_Line_Number__c, dealer__Extended_Price__c, 
                                                        dealer__Part_Description__c, dealer__Part_Number__c, dealer__Price__c, dealer__Total_Price__c,
                                                        dealer__Service_Line_Payment_Method__c, dealer__Pay_Type__c, dealer__Quantity_Sold__c, Name 
                                                    from dealer__Parts_Invoice_Line__c
                                                    where dealer__Service_Repair_Order__c=:ro.Id
                                                    order by dealer__Service_Job_Line_Number__c asc
                                                    limit 1000];
        }
        
        return plines;
    }  
    
    /*
     *  Get Job Lines
     * 
     *      Params: ro.Id
     */
    public List<dealer__Service_Job__c> getServiceJobList() {
        List<dealer__Service_Job__c> jLines = new List<dealer__Service_Job__c>();
        if(ro.Id!=null) {
            jLines = [Select Id, dealer__Labor_Type__c, dealer__Labor_Rate__c, dealer__Labor_Charges__c, 
                            dealer__Cause__c, dealer__Concern__c, dealer__CustomerConcern__c, dealer__Correction__c,
                            dealer__Op_Code__c, dealer__Line_Total__c, dealer__Parts_Total__c, dealer__Service_Type__c, dealer__Line_Number__c,
                            dealer__Operation_Code_Description__c, dealer__Stat__c, dealer__Technician__c, dealer__Book_Time__c  
                        from dealer__Service_Job__c 
                        where dealer__Service_Repair_Order__c =:ro.Id 
                        order by dealer__Line_Number__c asc
                        limit 1000];
        }
        return jLines;
    } 
    
    /*
     *  Get Job Lines as a Wrapper Class
     */
    public List<jobLineWrapper> getJobList() {
        return jobList;
    }
    
    /*
     * 
     */
    public void buildJobList() {
        for(dealer__Service_Job__c sl : getServiceJobList()) {
            jobList.add(new jobLineWrapper(sl));
        }
    }
    
    /*
     *  
     */
    
    /*
     * Get Printable Date Time as a String
     * 
     */
    public string printDateTime { 
            get {
                datetime dt = datetime.now();
                return dt.format('MM/dd/yyyy HH:mm a');
            }
    }
    
    /*
     * Page Reference - Redirect to Create New Service Ro Page
     */
    public PageReference redirectInit() {
        PageReference initPage = Page.ServiceRepairOrderInit;
        initPage.setRedirect(true);
        return initPage;
    }
    
    /*
     * Page Reference - Add New Customer Page, sends to Standard Controller, should be updated to respect overridden pages on objects
     */
    public PageReference addCustomer() {
        PageReference addCust = new PageReference('/003/e');
        addCust.setRedirect(true);
        return addCust;
    }
    
    /*
     * Page Reference - Direct to Tech Time Entry Page
     */
    public PageReference techTimeEntry() {
        PageReference tt = Page.TechTimeEntry;
        tt.getParameters().put('ro', ro.Id);
        tt.setRedirect(true);
        return tt;
    }
    
    /**
    *   Page Reference - Save override
    */ 
    public PageReference save() {
        if(ro.dealer__Sales_Inventory_Id__c!='') {
            ro.dealer__Vehicle_Inventory__c = ro.dealer__Sales_Inventory_Id__c;
            if(inventoryStatus != ro.dealer__Inventory_Vehicle_Status__c && inventoryStatus != null && inventoryStatus != '') {

                dealer__Vehicle_Inventory__c veh = [Select Id, dealer__Status_Code__c 
                                                        from dealer__Vehicle_Inventory__c
                                                        where Id =:ro.dealer__Sales_Inventory_Id__c
                                                        limit 1];
                veh.dealer__Status_Code__c = inventoryStatus;
                update veh;
            }
        }
        
        // Update Record
        if(ro.Id!=null) {
            update ro;
        } else {
            insert ro;
        }

        PageReference roPage = new ApexPages.StandardController(ro).view();
        roPage.setRedirect(true);
        return roPage;
    }

    /*
     * Page Reference - Invoice Repair Order 
     */
    public PageReference invoiceRO() {

        // Check that VIN of Vehicle has been assigned.  We require the VIN be saved before completion
        dealer__Service_Vehicle__c veh = [Select Id, dealer__VIN__c from dealer__Service_Vehicle__c where Id = :ro.dealer__Vehicle__c limit 1];
        if(veh.dealer__VIN__c == null || veh.dealer__VIN__c == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The Vehicle VIN must be entered before closing this Repair Order'));
            return null;    
        }
        
        // Check for Mileage Out
        if(ro.dealer__Mileage_Out__c==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Mileage Out is required to close the Repair Order'));
            return null;            
        }

        if(ro.dealer__Mileage_Out__c!=null) {
            if(ro.dealer__Mileage_Out__c < ro.dealer__Mileage_In__c) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Mileage Out may not be less than Mileage In'));
                return null;                
            }
        }

        if(ro.dealer__Open_Job_Lines__c > 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'There are still open Job Lines, Please complete before invoicing.'));
            return null;
        } else {
            ro.dealer__Status__c = 'Cashier';
            ro.dealer__Invoiced_Date_Time__c = Datetime.now();
            update ro;
            return Page.ServiceRepairOrder;
        }
            
    }
    
    /*
     * Page Reference to Re-Open an Invoice that has not been Cashiered
     */
    public PageReference reopenInvoice() {
        ro.dealer__Invoiced_Date_Time__c = null;
        ro.dealer__Status__c = 'Open';
        update ro;
        return Page.ServiceRepairOrder;
    }
    
    /*
     *  Page Reference - Tech Job Lines
     */
    public PageReference techJobCard() {
        this.buildJobList();
        return Page.TechSelectJobs;
    }
    
    /*
     * 
     */
    public PageReference assignTech() {
        if(this.techId==null || this.techId=='') {
            System.debug('Unable to locate techID');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to assign a technican, no user found.'));
            return null;
        }
        
        List<dealer__Service_Job__c> sj = new List<dealer__Service_Job__c>();
        for(jobLineWrapper j : this.JobList) {
            if(j.selected == true) {
               j.jL.dealer__Technician__c=this.techId; 
               sj.add(new dealer__Service_Job__c(Id=j.jL.Id, dealer__Technician__c=this.techId));
                
            }
        }
        
        update sj;
        
        return null;
    }
    
    /*
     * 
     */
    public PageReference openTechCard() {
        this.selectedLines = new List<dealer__Service_Job__c>();
        // Choose only the selected job line items
        for(jobLineWrapper j : this.JobList) {
            if(j.selected == true) {
               this.selectedLines.add(j.jL);
            }
        }        
        return Page.TechJobCardPDF;
    }
    
    /*
     * Page Reference to Cashier an Invoice
     */
    public PageReference cashierInvoice() { 
        PageReference cashier = Page.CashierPayments;
        cashier.setRedirect(true);
        cashier.getParameters().put('id',ro.id);
        cashier.getParameters().put('department', 'service');
        return cashier;
    }
    
    /*
     * Page Reference to Search for a Customer
     */
    public PageReference SearchCustomer() {
        String searchLike;
        if(searchCustomerInput.length() <= 2) {
            return null;
        } else {
            searchLike = '%'+String.escapeSingleQuotes(searchCustomerInput)+'%';
        }
        
        /*
        List<List<sObject>>  results = [FIND :searchInput IN ALL FIELDS RETURNING Account(Id, Name), dealer__Service_Index__c (Name, Id, dealer__Veh_Owner__c)];
        customers = ((List<Account>)results[0]);
        vehicles  = ((List<dealer__Service_Index__c>)results[1]);
        */
        
        customers = [Select a.HomePhone, a.MobilePhone, a.MailingStreet, a.MailingState, a.MailingPostalCode, a.MailingCity, a.Email, a.Name, 
                        a.LastName, a.Id, a.FirstName, a.AccountId, a.DoNotCall, a.Phone,
                            (Select Name, dealer__Carline__c, dealer__Licence__c, dealer__Last_6__c, dealer__Last_Service__c, dealer__Open_Repair_Orders__c,
                                dealer__Make__c, dealer__VIN__c, dealer__Stock_Number__c, dealer__Year__c, dealer__Last_Odometer__c
                                From dealer__Service_Vehicles__r) 
                    From Contact a 
                    where 
                        (a.Name like :searchLike
                            or a.HomePhone like :searchLike 
                            or a.MobilePhone like :searchLike
                        )
                    limit 200];
                        
        custSize = customers.size();                
        if(custSize<1) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No Customer Records Found'));
        }
        return null;
    }
    
    /*
     * Page Reference to Search for a vehicle
     */
    public PageReference SearchVehicle() {
        String searchLike;
        if(searchVehicleInput.length() <= 2) {
            return null;
        } else {
            searchLike = '%'+String.escapeSingleQuotes(searchVehicleInput)+'%';
        }
        
        vehicles = [Select Name, dealer__Carline__c, dealer__Licence__c, dealer__Make__c, dealer__VIN__c, dealer__Stock_Number__c, 
                                dealer__Year__c, dealer__Veh_Owner__c, dealer__Veh_Owner_Contact__r.Name, dealer__Last_6__c, dealer__Last_Service__c,  dealer__Last_Odometer__c
                     From dealer__Service_Vehicle__c
                     Where 
                        (Name like :searchLike 
                            or dealer__Licence__c like :searchLike
                            or dealer__VIN__c like :searchLike
                            or dealer__Stock_Number__c like :searchLike
                        ) limit 50];
                        
        vehSize = vehicles.size();              
        if(vehSize<1) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'No Service Vehicle Records Found'));
        }                
        return null;                
    }
    
    /*
     *  Page Reference - Update the Service Estimate
     */
    public PageReference updateEstimate() {
        if(this.estimateApprovedBy == null || this.estimateApprovalMethod == null || this.estimateNotes == null || this.newEstimate == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'All estimate update fields are required.'));
            return null;
        } else {
            
            dealer__Service_Repair_Order__c dro = [Select Id, dealer__Estimate__c from dealer__Service_Repair_Order__c where Id =:this.ro.Id limit 1];
            dro.dealer__Estimate__c = this.newEstimate;
            ro.dealer__Estimate__c = this.newEstimate;
            update dro;
            
            // Perform Event Save & Return previous page.
            Task tsk = new Task(
                ActivityDate=Date.today(),
                Description=String.valueOf(this.estimateNotes),
                Status='Completed',
                OwnerId=UserInfo.getUserId(),
                Subject=String.valueOf('Estimate updated amount of $'+dro.dealer__Estimate__c+' on '+this.ro.Name),
                Type=String.valueOf(this.estimateApprovalMethod+' Contact via: '+this.estimateApprovalMethod),
                WhatId=this.ro.Id
            );
            insert tsk;
            
            this.newEstimate = null;
            this.estimateApprovalMethod = null;
            this.estimateApprovedBy = null; 
            this.estimateNotes = null;
            
            return Page.ServiceRepairOrder;
        }
    } 
    
    /*
     * Page Reference - Direct user to Update Estimate Page
     */
    public PageReference updateEstaimtePageReference() {
        return Page.ServiceRepairOrderUpdateEstimate;
    }
    
    /*
     * Page Reference - Add Vehicele Page
     */
    public PageReference addVehicle() {
        PageReference addVehiclePage = Page.ServiceVehicleNew;
        return null;
    }    
    
    /*
     * Get New Vehicle Key Prefix as a String
     */
    public String getNewVehicleResource() {
        String d = dealer__Service_Vehicle__c.sObjectType.getDescribe().getKeyPrefix();
        return '/'+d+'/e?';
    }
    
    /*
     * Get Service History as a JSON String
     */
    public String getServiceHistoryJSON() {
        return ServiceHistory.serviceHistoryJSON(ro.dealer__Vehicle__c);
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                          //
    //  REMOTE ACTIONS                                                                          //
    //                                                                                          //
    //                                                                                          //
    //////////////////////////////////////////////////////////////////////////////////////////////

    /*
     * Get Operation Code based on String of OpCode
     */
    @RemoteAction
    public static dealer__StandardOpCode__c getOpCode(String opcode) {
        Integer sLength = opcode.length();
                opcode  = opcode+'%';
                
        if(sLength >= 2) {
            return [Select Id, Name, dealer__Concern__c, dealer__Estimate__c, dealer__Op_Code_Description__c, 
                        dealer__Service_Type__c, dealer__Book_Time__c, dealer__Pay_Type__c
                        from dealer__StandardOpCode__c
                        where Name Like :opcode
                        and dealer__Active__c = true
                        limit 1];
        } else {
            return null;
        }
    }
   
    /*
     * This method creates the Service Estimate and Service Estimate Lines
     */
    @RemoteAction 
    public static PageReference CreateServiceEstimate(String jsonString){
        ServiceRepairOrder_JSONParser.RORoot roDat = ServiceRepairOrder_JSONParser.parse(jsonString);
        dealer__Service_Estimate__c    se   =   new dealer__Service_Estimate__c(); 
        List<dealer__Service_Estimate_Line__c>      sel   =   new List<dealer__Service_Estimate_Line__c>();
        String RecordTypeIdServiceEstimate = Schema.SObjectType.dealer__Service_Estimate__c.getRecordTypeInfosByName().get('Service Estimate').getRecordTypeId();
        se.dealer__Customer__c = roDat.Customer;
        se.dealer__Service_Vehicle__c = roDat.Vehicle;
        se.RecordTypeId  = RecordTypeIdServiceEstimate;
        se.dealer__Current_Mileage__c=Decimal.valueOf(roDat.Mileage);
        // Get Estimate Line Based on Line Totals
        Decimal sumLineEsts = Decimal.valueOf('0.00');
        for(ServiceRepairOrder_JSONParser.ROData tmpL : roDat.data) {
            sumLineEsts+=Decimal.valueOf(tmpL.Est);
        }
        se.dealer__Estimated_Pack__c = sumLineEsts;
        Database.SaveResult insResult = Database.Insert(se);
        String roInsResultId = string.valueOf(insResult.getId());
        if(roInsResultId==null) {
            new ServiceEstimateException('Failed to create Service Estimate.');
        }
        for(ServiceRepairOrder_JSONParser.ROData line : roDat.data) {
                        
                dealer__Service_Estimate_Line__c job = new dealer__Service_Estimate_Line__c(
                                                            dealer__Book_Time__c=Double.valueOf(line.BookTime),
                                                            dealer__Description__c=line.Concern,
                                                            dealer__Labor_Operation__c = line.Id,
                                                            dealer__Service_Estimate__c = roInsResultId
                                                        );
                System.debug('Estimate Line '+job);                                                                          
                sel.add(job);            
            }
            insert(sel);
        PageReference ServiceEstimate = new ApexPages.StandardController(se).view();
        ServiceEstimate.setRedirect(true);
        return ServiceEstimate; 
    }
    
    /*
     * Create the repair order based on the JSON String passed containing the Repair order object and the job lines as a nested array
     */
    @RemoteAction
    public static PageReference CreateRepairOrder(String jsonString) {
        
        dealer__Service_Repair_Order__c    s   =   new dealer__Service_Repair_Order__c(); 
        List<dealer__Service_Job__c>      jl   =   new List<dealer__Service_Job__c>();
        
        ServiceRepairOrder_JSONParser.RORoot roDat = ServiceRepairOrder_JSONParser.parse(jsonString);
        
        dealer__DMS_Settings__c serviceSettings = [Select Id, dealer__Service_Current_Invoice_Number__c
                                                                        from dealer__DMS_Settings__c
                                                                        where Name = 'ActiveSettings' limit 1];
                                                                        
        serviceSettings.dealer__Service_Current_Invoice_Number__c += 1;
        String invoiceName = String.valueOf(serviceSettings.dealer__Service_Current_Invoice_Number__c);

        // Check Multi-Company mode to see if we are to prefix the RO# with Company Location
        dealer__FixedOperationsSettings__c fixedOpsSettings = dealer__FixedOperationsSettings__c.getOrgDefaults();
        if(fixedOpsSettings.dealer__Multi_Company_Mode__c==true) {
            User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
            if(u.Division!=null) {
                invoiceName=u.Division+'-'+invoiceName;
            }
        }
        
        s.Name = 'RO#'+invoiceName;
        s.dealer__RO_Number__c = String.valueOf(invoiceName);
        system.debug('the customer id is'+roDat.Customer);
        s.dealer__Customer__c = roDat.Customer;
        s.dealer__Service_Advisor__c = roDat.Advisor;
        s.dealer__Create_Date_Time__c= DateTime.now();
        s.dealer__Vehicle__c = roDat.Vehicle;
        s.dealer__Mileage_In__c = Decimal.valueOf(roDat.Mileage);
        s.dealer__Tag__c = roDat.Tag;
        s.dealer__Comments__c=roDat.Comments;
        
        // Get Estimate Line Based on Line Totals
        Decimal sumLineEsts = Decimal.valueOf('0.00');
        for(ServiceRepairOrder_JSONParser.ROData tmpL : roDat.data) {
            sumLineEsts+=Decimal.valueOf(tmpL.Est);
        }
        s.dealer__Estimate__c=sumLineEsts;
        
        if(roDat.PromiseTime != '' && roDat.PromiseDate != '') {
            s.dealer__Promise_Time__c=roDat.PromiseTime;
            s.dealer__Promise_Date__c=Date.parse(roDat.PromiseDate);
        }
        
        if(roDat.Waiter=='true') {
            s.dealer__Waiting__c=true;
        }
        
        Database.SaveResult insResult = Database.Insert(s);
        String roInsResultId = string.valueOf(insResult.getId());
        if(roInsResultId==null) {
            new ServiceRepairOrderException('Failed to create repair order.');
        }
        // Update RO Incrimental Counter
        update(serviceSettings);
        
            // Insert Service Lines
            for(ServiceRepairOrder_JSONParser.ROData line : roDat.data) {
                        
                String lConcern =  line.Concern;
                if(lConcern.length()>255) {
                   lConcern.left(255); 
                }       
                
                dealer__Service_Job__c job = new dealer__Service_Job__c(
                                                            Name=line.OpCode,
                                                            dealer__Op_Code__c = line.OpCode,
                                                            dealer__Line_Number__c=Decimal.valueOf(line.LineNumber),
                                                            dealer__Labor_Type__c=line.PayMethod,
                                                            dealer__Book_Time__c=Double.valueOf(line.BookTime),
                                                            dealer__CustomerConcern__c=lConcern,
                                                            dealer__Estimate__c=Decimal.valueOf(line.Est),
                                                            dealer__Standard_Operation_Code__c = line.Id,
                                                            dealer__Service_Repair_Order__c = roInsResultId
                                                        );
                System.debug('Job Line '+job);                                        
                                                        
                jl.add(job);            
                
            }
            
            insert(jl);
        
        // Update Service Vehicle Open RO Count
        dealer__Service_Vehicle__c svehicle = [Select Id, dealer__Open_Repair_Orders__c from dealer__Service_Vehicle__c where Id = :s.dealer__Vehicle__c limit 1];
        if(svehicle.dealer__Open_Repair_Orders__c==null) { svehicle.dealer__Open_Repair_Orders__c=1; } 
            else { svehicle.dealer__Open_Repair_Orders__c = svehicle.dealer__Open_Repair_Orders__c + 1; }
        update svehicle;
            
        PageReference RepairOrderPage = new ApexPages.StandardController(s).view();
        RepairOrderPage.setRedirect(true);
        
        return RepairOrderPage;                                                                 
    }   
    
    /*
     * Load the Service Job Lines to the DOM Object on the page
     */
    @RemoteAction
    public static List<dealer__Service_Job__c> loadServiceJobLines(String masterRecordId) {
        return [Select d.dealer__Stat__c, d.dealer__Standard_Operation_Code__c, d.dealer__Standard_Operation_Code__r.dealer__Service_Type__c,
                        d.dealer__Standard_Operation_Code__r.dealer__Op_Code_Description__c, d.dealer__Service_Repair_Order__c, 
                        d.dealer__RO_Number__c, d.dealer__RO_Invoice_Date_Time__c, d.dealer__Parts_Cost__c, d.dealer__Op_Code__c, 
                        d.dealer__Line_Number__c, d.dealer__Labor_Type__c, d.dealer__Labor_Rate__c, d.dealer__Labor_Charges__c, 
                        d.dealer__Job_Start__c, d.dealer__Job_Finish__c, d.dealer__Estimate__c, d.dealer__Correction__c, 
                        d.dealer__CustomerConcern__c, d.dealer__Cause__c, d.dealer__Book_Time__c, d.dealer__Actual_Time__c, dealer__Currently_Active__c,
                        d.Name, d.LastModifiedDate, d.LastModifiedById, d.dealer__Line_Total__c, d.dealer__Sublet_Total__c, d.dealer__Parts_Total__c,
                        d.Id, d.CreatedDate, d.CreatedById, 
                            (Select Id, Name, dealer__Counterman__c, dealer__Core__c, dealer__Cost__c, dealer__Price__c, dealer__List__c, 
                                dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Part__c, dealer__Price_Level__c, dealer__Transaction_Code__c, 
                                dealer__Part_Number__c, dealer__Part_Description__c, dealer__Bin__c, dealer__Extended_Price__c, dealer__Job_Line__c
                                 From dealer__Parts_Lines__r)
                        From dealer__Service_Job__c d
                        where d.dealer__Service_Repair_Order__c = :masterRecordId 
                        order by d.dealer__Line_Number__c asc
                        limit 100];
    }
    
    /*
     * Add a single service line
     */
    @RemoteAction
    public static dealer__Service_Job__c addServiceLine(String joblinexml) {
        
        Dom.Document doc    =   new Dom.Document();
        doc.load(joblinexml);
        Dom.XMLNode invoice =   doc.getRootElement();
        
        ID mastRecord       =   invoice.getChildElement('serviceroid', null).getText();
        String RONumber     =   invoice.getChildElement('servicename', null).getText();

            dealer__Service_Job__c job = new dealer__Service_Job__c(
                                                Name=RONumber+'-'+invoice.getChildElement('LineNumber', null).getText(),
                                                dealer__Line_Number__c=Decimal.valueOf(invoice.getChildElement('LineNumber', null).getText()),
                                                dealer__Book_Time__c=Decimal.valueOf(invoice.getChildElement('BookTime', null).getText()),
                                                dealer__CustomerConcern__c=invoice.getChildElement('Concern', null).getText(),
                                                dealer__Estimate__c=Decimal.valueOf(invoice.getChildElement('Est', null).getText()),
                                                dealer__Labor_Type__c=invoice.getChildElement('PayMethod', null).getText(),
                                                dealer__Op_Code__c=invoice.getChildElement('OpCode', null).getText(),
                                                dealer__Standard_Operation_Code__c=invoice.getChildElement('Id',null).getText(),
                                                dealer__Service_Repair_Order__c=invoice.getChildElement('serviceroid',null).getText()
                                            );
            insert job;
        
        if(job.Id != null) {
           return [Select d.dealer__Stat__c, d.dealer__Standard_Operation_Code__c, d.dealer__Standard_Operation_Code__r.dealer__Service_Type__c,
                            d.dealer__Standard_Operation_Code__r.dealer__Op_Code_Description__c, d.dealer__Service_Repair_Order__c, 
                            d.dealer__RO_Number__c, d.dealer__RO_Invoice_Date_Time__c, d.dealer__Parts_Cost__c, d.dealer__Op_Code__c, 
                            d.dealer__Line_Number__c, d.dealer__Labor_Type__c, d.dealer__Labor_Rate__c, d.dealer__Labor_Charges__c, 
                            d.dealer__Job_Start__c, d.dealer__Job_Finish__c, d.dealer__Estimate__c, d.dealer__Correction__c, 
                            d.dealer__CustomerConcern__c, d.dealer__Cause__c, d.dealer__Book_Time__c, d.dealer__Actual_Time__c, 
                            d.Name, d.LastModifiedDate, d.LastModifiedById, d.dealer__Line_Total__c, d.dealer__Sublet_Total__c, d.dealer__Parts_Total__c,
                            d.Id, d.CreatedDate, d.CreatedById, 
                                (Select Id, Name, dealer__Counterman__c, dealer__Core__c, dealer__Cost__c, dealer__Price__c, dealer__List__c, 
                                    dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Part__c, dealer__Price_Level__c, dealer__Transaction_Code__c, 
                                    dealer__Part_Number__c, dealer__Part_Description__c, dealer__Bin__c, dealer__Extended_Price__c From dealer__Parts_Lines__r)
                            From dealer__Service_Job__c d
                            where d.Id = :job.Id limit 1];
        } else {
            throw new ServiceRepairOrderException('Error creating new repair line');    
        }
    }
   
   
    ///////////////////////////////////////////////////
    //                                              //
    //  Supporting Classes and Exception Handling   //
    //                                              //
    //////////////////////////////////////////////////
    
    /*
     * Wrapper Class to collect Job Lines
     */
    public class jobLineWrapper {
        public dealer__Service_Job__c jL {get;set;}
        public boolean selected {get;set;}
        
        public jobLineWrapper(dealer__Service_Job__c j) {
            this.jL = j;
            this.selected = false;
        }
    } 

    /*
     * Exception Overloading
     */
    public class ServiceEstimateException extends Exception{}
    public class ServiceRepairOrderException extends Exception {}
}