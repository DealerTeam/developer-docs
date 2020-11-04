public with sharing class RentalAgreement_EXT {
    
    public Contact custAccount { get; set; }
    public dealer__Rental_Rates__c rates { get; set; }
    public dealer__Rental_Agreements__c agreement;
    // public dealer__RentalSettings__c rs { get { return dealer__RentalSettings__c.getOrgDefaults(); } }
    public list<dealer__DMS_Settings__c> dealDefaults = dealer__DMS_Settings__c.getall().values();
    public List<dealer__Driver__c> objDriverList{get;set;}
    public List<RADriverWrapperClass> objRADriverWrapperList{get;set;}
    public Boolean renderAddDriver{get;set;}
    public Boolean renderSave{get;set;}
    public Decimal discountValue{get;set;}
    public Decimal discountPercentage{get;set;}
    public Decimal SubTotal{get;set;}
    public String zeroString{get;set;}
    public Contact objContact{get;set;}
    public Dealer_Location__c loc {get;set;}
    public Decimal amountDue {get;set;}
    public String contractFormName {get;set;}
    public String receiptFormName {get;set;}
    
    
    public Decimal defaultTaxRate { 
        get { 
            
            Decimal defRate = dealDefaults[0].dealer__Default_Tax_Rate__c;
            
            // Use Location based taxes if available
                if(loc != null && loc.Tax_Local_Rate__c != null && loc.Tax_Local_Rate__c > 0 ){
                    defRate = loc.dealer__Tax_Local_Rate__c;
                    if(loc.Tax_Local_Rental_Addition__c!= null && loc.Tax_Local_Rental_Addition__c>0) {
                        defRate += loc.Tax_Local_Rental_Addition__c;
                    }
                }
            return defRate; 
        }
    }
    
    public String dHomePhone   {  get;  set;  }
    public String dMobilePhone   {   get;   set;   }
    public String dEmail    {  get;  set;   }
    //what in the world is going on here.
    public String baseURL { get { return URL.getSalesforceBaseUrl().toExternalForm().replace('dealer.', 'c.'); } }
    private Task stact;
    
    public RentalAgreement_EXT(ApexPages.StandardController stdController) {
        objDriverList = new List<dealer__Driver__c>();
        discountValue = 0.0;
        discountPercentage = 0.0;
        SubTotal = 0.0;
        zeroString = '$0.00';
        objContact = new Contact();
        //objDriverList.add(new dealer__Driver__c());
        
        renderSave = false;
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Rental_Agreements__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        
        contractFormName = DealerMetadata.getConfigValue('RentalContractFormName');
        receiptFormName = DealerMetadata.getConfigValue('RentalReceiptFormName');
        if(!Test.isRunningTest()) {      
            stdController.addFields(af);
        }
        
        this.agreement = (dealer__Rental_Agreements__c)stdController.getRecord();
        
        // Set Location to user location by default
        if(agreement.Location__c == null) {
            User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
            loc = [SELECT Id, Name, Company_Contracting_Name__c, Main_Phone__c, Street__c, City__c, State__c, Postal_Code__c, Tax_Local_Rate__c, Tax_Local_Rental_Addition__c FROM Dealer_Location__c WHERE Company_Number__c =: u.Division LIMIT 1];
            if(loc != null){
                agreement.Location__c = loc.Id;
            }
        }else{
            loc = [SELECT Id, Name,Company_Contracting_Name__c, Main_Phone__c, Street__c, City__c, State__c, Postal_Code__c, Tax_Local_Rate__c, Tax_Local_Rental_Addition__c FROM Dealer_Location__c WHERE Id =: agreement.Location__c LIMIT 1];
        }
        
        if(agreement.Id == null) {
            renderAddDriver = true;
            System.debug('**** Null ID? ****');
            if(agreement.Mileage_Limit_Daily__c == null){
                agreement.Mileage_Limit_Daily__c = Integer.valueOf(DealerMetadata.getConfigValue('DailyMileageLimit'));
            }
            if(agreement.Excess_Miles_Fee__c == null){            
                agreement.Excess_Miles_Fee__c = Double.valueOf(DealerMetadata.getConfigValue('ExcessMileageFee'));
            }            
            if(agreement.Re_Fuel_Fee__c == null) {
                agreement.Re_Fuel_Fee__c = Double.valueOf(DealerMetadata.getConfigValue('RefuelingFee'));
            }
            if(agreement.Fuel_Charge_per_Gallon__c == null) {
                agreement.Fuel_Charge_per_Gallon__c = Double.valueOf(DealerMetadata.getConfigValue('FuelChargePerGallon'));
            }                        
            
        }else{
            discountPercentage = this.agreement.dealer__Discount_Percentage__c;
            if(this.agreement.Discount__c != null && this.agreement.Discount__c>0){
                this.agreement.Discount__c = -(this.agreement.Discount__c);                
            }
            discountValue = this.agreement.Discount__c;
            System.debug('Discount old value'+discountValue);            
            objDriverList = [SELECT Id, Name, Birth_Date__c, Mobile_Phone__c, License_Number__c, Licence_State__c, 
                             Licence_Expiration_Date__c FROM dealer__Driver__c WHERE dealer__Rental_Agreements__c =: agreement.Id ORDER BY CreatedDate DESC];
            if(this.agreement.Agreement_Status__c == 'Void'){
                renderAddDriver = false;
            }else{
                renderAddDriver = true;
            }
            
             if(this.agreement.dealer__Total_Payments__c != null && this.agreement.dealer__Total_Payments__c >0){
                amountDue = this.agreement.TotalEstimatedCharges__c - this.agreement.dealer__Total_Payments__c;
            }else{
                amountDue = this.agreement.TotalEstimatedCharges__c;
            }
        }
        
        // Default Customer Fields
        Contact custAccount = this.getCustomer();
        if(custAccount!=null){
            this.agreement.Drivers_Lic__c = custAccount.Drivers_License_Number__c;
            this.agreement.Drivers_Lic_State__c = custAccount.Drivers_License_State__c;
            this.agreement.Drivers_Lic_Exp__c = custAccount.Drivers_License_Expiration_Date__c;
            this.agreement.Drivers_Birthdate__c = custAccount.Birthdate;
            //this.agreement.Drivers_Birthdate__c = custAccount.Birthdate;
        }
        
    }
    
    public List<dealer__Cashering__c> getCashiering(){
        
        try{
            return [SELECT dealer__Payment_Method__c, dealer__Amount__c  
                    FROM dealer__Cashering__c WHERE dealer__Rental_Agreement__c =: agreement.Id Limit 1000];
        } catch(QueryException e){
            return new List<dealer__Cashering__c>();
        }
    } 
         
    
    public List<Rental_Fee__c> getRentalFees(){
        try{
            return [SELECT Fee_Name__c, Amount__c FROM Rental_Fee__c WHERE REntal_Agreement__c =: agreement.Id];
        } catch(QueryException e){
            return new List<Rental_Fee__c>();
        }
    }
    
    public PageReference save() {
        
        dealer__Vehicle_Inventory__c unit   =   this.getUnit();
        unit.Rental_Status__c  =  'Available';
        
        update unit;
        
        try {
            this.agreement.Agreement_Status__c = 'Open';
            this.agreement.Return_Date__c     = this.agreement.Date_DUE_In__c;    
            this.agreement.Return_Time__c      = this.agreement.Time_DUE_IN__c;

            //W-002701 Begins: String manipulation to get a datetime value for using classic/lightning interchangeably 
            //Set the Datetime fields for return/in/out fields
            String oldTimeIn = this.agreement.Time_DUE_IN__c;
            List<String> timeInParts = oldTimeIn.left(5).split(':', 2);
            Time formattedTimeIn = Time.newInstance(integer.valueOf(timeInParts[0]), integer.valueOf(timeInParts[1]), 0, 0);
            if(oldTimeIn.right(2) == 'PM'){
            formattedTimeIn = formattedTimeIn.addHours(12);
            }
            this.agreement.DateTime_DUE_IN__c = Datetime.newInstance(this.agreement.Date_DUE_In__c, formattedTimeIn);

            String oldTimeOut = this.agreement.Time_OUT__c;
            List<String> timeOutParts = oldTimeOut.left(5).split(':', 2);
            Time formattedTimeOut = Time.newInstance(integer.valueOf(timeOutParts[0]), integer.valueOf(timeOutParts[1]), 0, 0);
            if(oldTimeOut.right(2) == 'PM'){
            formattedTimeOut = formattedTimeOut.addHours(12);
            }
            this.agreement.DateTime_Out__c = Datetime.newInstance(this.agreement.Date_Out__c, formattedTimeOut);
            this.agreement.Return_DateTime__c = this.agreement.DateTime_DUE_IN__c;
            //W-002701 Ends
            
            this.agreement.Discount__c = discountValue;
            this.agreement.Discount_Percentage__c = discountPercentage;
            if(discountValue== 0 && discountPercentage!=0){                    
                this.agreement.Discount__c = null;
            }
            if(discountPercentage ==0 && discountValue !=0){                    
                this.agreement.Discount_Percentage__c = null;
            }
            if(discountValue != null && discountValue>0 ){                    
                this.agreement.Discount__c = -(discountValue);
            }
            System.debug('discountValue-->>'+discountValue);System.debug('discountPercentage-->>'+discountPercentage);
            System.debug('agreement.Discount_Percentage__c -->>'+this.agreement.Discount_Percentage__c); 
            System.debug('agreement.Discount__c -->>'+this.agreement.Discount__c);
            upsert(agreement);
            SYstem.debug('Agreement Two -->>'+agreement);
        } catch(System.DMLException e) {
            ApexPages.addMEssages(e);
            return null;
        }
        
        // Update Drivers Lic, Birthdate
        Contact custAccount = this.getCustomer();
        
        // Update vehicle
        unit.Rental_Status__c  =  'Checked Out';
        unit.Mileage__c      =  this.agreement.Mileage_Out__c;
        
        update unit;
        custAccount.Drivers_License_Number__c = this.agreement.Drivers_Lic__c;
        custAccount.Drivers_License_State__c = this.agreement.Drivers_Lic_State__c ;
        custAccount.Drivers_License_Expiration_Date__c = this.agreement.Drivers_Lic_Exp__c;
        custAccount.Birthdate = this.agreement.Drivers_Birthdate__c;
        
        update custAccount;
        
        List<dealer__Driver__c> objDriverListToInsert = new List<dealer__Driver__c>();
        
        if(objDriverList.size()>0  && agreement.Id != null){
            for(dealer__Driver__c objDriver : objDriverList){        
                if(objDriver.Name != null){
                    objDriver.dealer__Rental_Agreements__c = agreement.Id;
                    objDriverListToInsert.add(objDriver);
                }
            }
        }
        if(objDriverListToInsert.size()>0){
            upsert objDriverListToInsert;
        }
        
        return (new ApexPages.Standardcontroller(agreement)).view();
        
    }
    
    // Adding row on Driver Information section when clicked from New/Edit page
    public void addRow(){
        try{
            objDriverList.add(new dealer__Driver__c());
        }catch(Exception e){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage() + e.getLineNumber()));
            
        }
    }  
    
    public PageReference voidReasonSave(){
        this.agreement.Agreement_Status__c = 'Void';
        update agreement;
        PageReference redirectToRA = new PageReference('/'+agreement.Id);
        return redirectToRA;
    }
    
    public dealer__Driver__c getDrivers(){
        if(objDriverList.size() > 0){
        	return objDriverList[0];
        }
        return null;
    }
    
    
    public PageReference completeRental() {
        
        SavePoint sp = Database.setSavePoint();

        dealer__Vehicle_Inventory__c unit   =   this.getUnit();
        unit.Rental_Status__c  =  'Available';
        unit.Mileage__c        =  this.agreement.Return_Mileage__c;
        
        if(unit.Mileage__c > this.agreement.Return_Mileage__c) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Return Mileage may not be greater than current Vehicle Mileage.'));
            return null;
        }

        try {
            update unit;  
            this.agreement.Agreement_Status__c = 'Closed';
            this.agreement.Date_DUE_In__c = this.agreement.Return_Date__c;
            upsert(agreement);
        } catch(System.DMLException e) {
            Database.rollBack(sp);
            ApexPages.addMessages(e);
            return null;
        }
        
        Contact custAccount = this.getCustomer();
        
        // Store activity to record completed activity
        stact = new Task(
            whatID = this.agreement.Id, // Rental Contract ID 
            //WhoId = this.custAccount.Id,
            OwnerId = UserInfo.getUserId(),
            subject = 'Rental Return', 
            description = 'Processed Rental Return',
            Status = 'Completed', 
            priority = 'Normal',
            ActivityDate = date.today()
        );
        
        
        try {
            insert stact;  
        } catch(Exception e) {
            Database.rollBack(sp);
            ApexPages.addMessages(e);
            return null;
        }    

        // Alert foreign general ledger 
        try {
            String accountingPayload = '{"recordId" : "'+agreement.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "rental"}';
            Cashier.emailAsyncHandler(accountingPayload);
        } Catch(Exception e) {
            Database.rollBack(sp);
            ApexPages.addMessages(e);
            return null;
        }

        
        return (new ApexPages.Standardcontroller(agreement)).view();
    }
    
    public PageReference changeStatusToVoid(){
        
        //Check if payment > 0
        if(this.agreement.Total_Payments__c!=null && this.agreement.Total_Payments__c > 0){
            
            //Add error message if payment is done
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error,'Cannot void Rental Agreement after collecting money from customer.'));
            return null;
        }
        PageReference voidReasonPage = new PageReference('/apex/RentalAgreementVoidReason?id='+agreement.Id);      
        return voidReasonPage;
    }
    
    public PageReference ModifyClosedRental() {
        
        dealer__Vehicle_Inventory__c unit   =   this.getUnit();
        unit.Rental_Status__c  =  'Checked Out';
        
        try {
            this.agreement.Agreement_Status__c = 'Open';
            upsert(agreement);
        } catch(System.DMLException e) {
            ApexPages.addMEssages(e);
            return null;
        }  
        
        // Store activity to record completed activity
        stact = new Task(
            whatID = this.agreement.Id, // Rental Contract ID 
            OwnerId = UserInfo.getUserId(),
            subject = 'Re-Opened Rental Contract', 
            description = 'Re-Opened Rental Contract',
            Status = 'Completed', 
            priority = 'Normal',
            ActivityDate = date.today()
        );
        
        try {
            insert stact;  
            System.debug('Inserted closed activity recording re-open of rental contract');
        } catch(Exception e) {System.debug(e);}        
        
        return (new ApexPages.Standardcontroller(agreement)).view();
    }
    
    public PageReference PrintContract() {
        PageReference contractPage = Page.RentalContractPDF; 
        // contractPage.setRedirect(true);
        return contractPage; 
    }
    
    public PageReference processReturn() {
        PageReference completeContract = new ApexPages.Pagereference('/apex/RentalProcessReturn?id='+agreement.Id);
        //completeContract.setRedirect(true);
        return completeContract;
    }
    
    public Contact getCustomer() {
        if(agreement.Contact__c != null) {
            
            return [Select Id, FirstName, LastName, HomePhone, MailingStreet, MailingCity, MailingState, 
                    MailingPostalCode, Email, MobilePhone, Birthdate, RecordTypeId, Drivers_License_Number__c,Drivers_License_Expiration_Date__c,Drivers_License_State__c 
                    from Contact 
                    where Id = :agreement.dealer__Contact__c Limit 1];
            
        } else {
            return null;
        }
    }
    
    public dealer__Vehicle_Inventory__c getUnit() {
        if(agreement.Rental_Vehicle__c != null){
            return [Select Id, dealer__Rental_Status__c, dealer__Mileage__c from dealer__Vehicle_Inventory__c where Id = :agreement.Rental_Vehicle__c limit 1];
        } else { 
            return null;
        }
    }
    
    /* ****************************************************************
* Author: Techila Global Services Pvt Ltd.
* Modified Date: 15-July-2016
* Description: Make changes in controller for adding Drivers for Rental Agreements
****************************************************************** */
    
    //Action method for editing Rental Agreement
    public PageReference edit(){
        if(this.agreement.Mileage_Limit_Daily__c == null){
            this.agreement.Mileage_Limit_Daily__c = Double.valueOf(DealerMetadata.getConfigValue('DailyMileageLimit'));

        }
        PageReference editPage = new PageReference('/apex/RentalAgreement?id='+agreement.Id+'/e');
        //editPage.setRedirect(true);
       // return ApexPages.currentPage();
        
        return editPage;
    }
    
    @RemoteAction
    public static Double inventoryMileage(String vehicleId) {
        return [Select Id, dealer__Mileage__c from dealer__Vehicle_Inventory__c where Id =: vehicleId limit 1].dealer__Mileage__c;
    }
    
    //Method is adding row in Driver Information section for Rental Agreement's Detail page
    public void addRowOnEdit(){
        objRADriverWrapperList = new List<RADriverWrapperClass>();
        dealer__Driver__c objDriverNew = new dealer__Driver__c();
        objRADriverWrapperList.add(new RADriverWrapperClass(objDriverNew));
        renderSave = true;
        renderAddDriver = false;
    }
    
    // Method for Saving Driver Information for Rental Agreement's Detail page
    public void SaveOnEdit(){
        // Disable Save button and Enable Add Driver button for addition of more drivers on Rental Agreement record
        renderSave = false;
        renderAddDriver = true;
        List<dealer__Driver__c> objDriverListToInsertOne = new List<dealer__Driver__c>();
        for(RADriverWrapperClass objRADriverWrapperClass : objRADriverWrapperList){
            if(objRADriverWrapperClass.objWrapperDriver != null){
                objRADriverWrapperClass.objWrapperDriver.dealer__Rental_Agreements__c = agreement.Id;
                objDriverList.add(objRADriverWrapperClass.objWrapperDriver);
                objDriverListToInsertOne.add(objRADriverWrapperClass.objWrapperDriver);
            }
        }
        if(objDriverListToInsertOne.size()>0){
            upsert objDriverListToInsertOne ;
        }
        
    }
    //method to autopopulate driver's information of selected contact
    public void populateDriverInfo(){
        objContact = [SELECT Id, dealer__Drivers_License_Number__c, dealer__Drivers_License_Expiration_Date__c, dealer__Drivers_License_State__c, Birthdate FROM Contact WHERE ID =: this.agreement.Contact__c];
        this.agreement.dealer__Drivers_Lic__c = objContact.dealer__Drivers_License_Number__c;
        this.agreement.dealer__Drivers_Lic_State__c = objContact.dealer__Drivers_License_State__c;
        this.agreement.dealer__Drivers_Lic_Exp__c = objContact.dealer__Drivers_License_Expiration_Date__c;
        this.agreement.dealer__Drivers_Birthdate__c = objContact.Birthdate;
        System.debug('Contact Info-->'+objContact);
    }
    public void cancelDriver(){
        objDriverList.remove(objDriverList.size()-1);
    }
    
    //Method for deleting driver information from Rental Agreement's Detail Page
    public PageReference deleteDriver(){
        String DriverId = ApexPages.currentPage().getParameters().get('DriverId');
        if(DriverId != null){ 
            dealer__Driver__c objDriver = [Select id from dealer__Driver__c where id =: DriverId limit 1];
            delete objDriver;
        }
        PageReference redirect = new PageReference('/apex/RentalAgreementView?id='+agreement.Id);
        redirect.setRedirect(true);
        return redirect;
    }
    
    //Wrapper class for adding Driver Information row on Rental Agreement page
    public class RADriverWrapperClass{
        public dealer__Driver__c objWrapperDriver{get;set;}
        
        public RADriverWrapperClass(dealer__Driver__c objWrapperDriver){
            this.objWrapperDriver = objWrapperDriver;
        }
    }
    
}