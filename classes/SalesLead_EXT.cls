/**
* SalesLead_EXT - Cotnrols interaction wiht the salesup object
*
*/
global with sharing class SalesLead_EXT {
    
    public Boolean fromCreatePage {get; set;}
    public Boolean fromFDPage {get; set;}
    public String acctLabel {get; set;}
    public String supLabel {get;set;}
    public String nomatchstring {get;set;}
    public dealer__Sales_Up__c up;
    public List<dealer__Sales_Up__c> upList;
    public searchUps searchOptions {get;set;}
    public List<Contact> searchContactResults {get;set;}
    public List<dealer__Sales_Up__c> searchUpsResults {get;set;}
    public List<Account> searchAccountResults {get;set;}
    public dealer__DMS_Settings__c dms {get; private set;}
    public dealer__CRMSettings__c crm {get; private set;}
    public List<AvaliableSalesUp> activeSalesup {get; set;}


    //DEPRECATE
    // public List<VINDecoder_DataOneSoftware.StyleData> ModelKeyList;
    // public VINDecoder_DataOneSoftware.StyleData sdat;
    // public VINDecoder_DataOneSoftware.DecodeResponseStruct ddat;

    //NEW 
    @TestVisible transient VINDecoderDataObject.DecodeData ddat;
	@TestVisible transient VINDEcoderDataObject.Style sdat;
	public List<VINDecoderDataObject.Style> ModelKeyList = new List<VINDecoderDataObject.Style>();
    public List<VinDecoderAPI.OptionalEquipment> OptEquip = new List<VinDecoderAPI.OptionalEquipment>();
	public List<VinDecoderAPI.InstalledEquipment> InstalledEquipment = new List<VinDecoderAPI.InstalledEquipment>();
    
    //public list<dealer__Vehicle_Inventory__c> inventoryVehicleList{get;set;}

    public String SelectedStyleId;
    public Boolean matchEscape = false;
    public Boolean isMerge{get;set;}
    public dealer__Vehicle_Inventory__c vehicleInventory{get; set;} 
    public Boolean skipSearch {get; set;}
    public Boolean fromB2BAccount {get;set;}
    public Id businessAccountId {get;set;}

    // Duplicate Error Support for Native Duplciate Management
    private List<sObject> duplicateRecords;
    public List<sObject> getDuplicateRecords() {
        return this.duplicateRecords;
    }
    public Boolean hasDuplicateResult{get;set;}
    
    public List<dealer__Service_Vehicle__c> serVehicleList{get; set;} //Added by KVP
    private Boolean isDupFound;  //Used as flag variable that indicate the duplicate record count status (KVP)
    
    public Boolean isPersonsAccountsEnabled {
        get {return Utility.personsAccountsEnabled();}
        set; 
    }
    
    public integer searchUpCount {get;set;}
    public integer searchContactCount {get;set;}
    
    public VINDecoder vd = new VINDecoder(); 
    
    // Get field set for input page
    public List<Schema.FieldSetMember> getNewPageFields() {
        return SObjectType.dealer__Sales_Up__c.FieldSets.dealer__NewRecordFieldSet.getFields();
    }
    
    // LEX Preferred
    public Boolean getLexPreference() {
        User u = [Select UserPreferencesLightningExperiencePreferred from User where Id=:UserInfo.getUserId() limit 1];
        return u.UserPreferencesLightningExperiencePreferred;
    }       
    
    public SalesLead_EXT(ApexPages.StandardController c) {
        
        Schema.DescribeSObjectResult d =   Account.sObjectType.getDescribe(); 
        acctLabel =  d.getLabel();
        
        d =   dealer__Sales_Up__c.sObjectType.getDescribe(); 
        supLabel =  d.getLabel();
        
        nomatchstring = 'Create a New '+acctLabel+' and '+supLabel+', Does not Match Any Records Below';
        
        vehicleInventory  = new dealer__Vehicle_Inventory__c();

        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        // Get Custom Settings
        crm = dealer__CRMSettings__c.getInstance();
        
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Sales_Up__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {       
            c.addFields(af);
        }    
        
        
        searchUpsResults = new List<dealer__Sales_Up__c>();
        searchContactResults = new List<Contact>();
        
        up = (dealer__Sales_Up__c)c.getRecord();
        isMerge=false;
        User u =[SELECT Id, In_BDC__c from USER WHERE Id=:UserInfo.getUserId()];
        // Add Owner Id Default
        if(up.OwnerId==null)
            up.OwnerId=UserInfo.getUserId();
        
        // Declare search settings for duplicates
        searchOptions = new searchUps(isBlank(up.dealer__FirstName__c), 
                                      isBlank(up.dealer__LastName__c), 
                                      isBlank(up.dealer__Email__c), 
                                      isBlank(up.dealer__Phone__c), 
                                      isBlank(up.dealer__Mobile__c), 
                                      up.dealer__FirstName__c, 
                                      up.dealer__LastName__c, 
                                      up.dealer__Email__c,
                                      up.dealer__Phone__c,
                                      up.dealer__Mobile__c);

        if(up.dealer__Salesperson_1__c==null && crm.dealer__Default_SalesPerson1__c && !u.In_BDC__c ) {
            up.dealer__Salesperson_1__c=UserInfo.getUserId();
        } else if (u.In_BDC__c){
            up.dealer__CCC_Rep__c = u.Id;
        }
        
        if(up.dealer__Store_Location__c==null) {
            up.dealer__Store_Location__c = Utility.lookupUserLocation();
        }
        
        if(ApexPages.currentPage().getParameters().get('traffic')!='' && ApexPages.currentPage().getParameters().get('traffic')!=null)  {
            
            dealer__Traffic_Log__c tl = [Select Id, dealer__First_Name__c, dealer__Last_Name__c, dealer__Salesperson_1__c, dealer__Type__c 
                                         from dealer__Traffic_Log__c 
                                         where Id =:ApexPages.currentPage().getParameters().get('traffic') 
                                         limit 1];
            
            up.dealer__Traffic_Log_Entry__c = tl.Id;
            up.dealer__Lead_Type__c=tl.dealer__Type__c;
            
            up.dealer__FirstName__c=ApexPages.currentPage().getParameters().get('FirstName');
            up.dealer__LastName__c=ApexPages.currentPage().getParameters().get('LastName');
            up.dealer__Phone__c=ApexPages.currentPage().getParameters().get('phone');
            
            // If Get args blank access data via Traffic Log
            if(up.dealer__FirstName__c==null || up.dealer__LastName__c==null) {
                up.dealer__LastName__c=tl.dealer__First_Name__c;
                up.dealer__FirstName__c=tl.dealer__Last_Name__c;
            }
            
            if(tl.dealer__Salesperson_1__c!=null) {
                up.dealer__Salesperson_1__c = tl.dealer__Salesperson_1__c;
            }
            
            up.dealer__Lead_Date__c=Date.today();
        }
        
        /*if(ApexPages.currentPage().getParameters().get('customer')!='' && ApexPages.currentPage().getParameters().get('customer')!=null) {
            // Customer passed to new Sales Up, get customer data and populate page
            Contact[] contact = [Select Id, FirstName, LastName, Phone, MobilePhone, HomePhone, Email, CreatedDate, dealer__External_ID__c 
                                 from Contact where Id =:ApexPages.currentPage().getParameters().get('customer')
                                 limit 1];
            if(contact.size()>0) {
                up.dealer__FirstName__c=contact[0].FirstName;
                up.dealer__LastName__c=contact[0].LastName;
                up.dealer__Lead_Date__c=Date.Today();
                up.dealer__Buyer_Contact__c=contact[0].Id;
                up.dealer__Phone__c=contact[0].Phone;
                up.dealer__Mobile__c=contact[0].MobilePhone;
                up.dealer__Email__c=contact[0].Email;
            }                   
        }*/
        
        string parentRecordId='';
        
        Map<string,string> mapParameters = ApexPages.currentPage().getParameters();
        
        //Get parent record id
        for(String key :mapParameters.keyset()){
            
            //check for the parent value
            if(key.contains('_lkid')){
                parentRecordId = mapParameters.get(key);
            }
        }
        
        //Check if the parent record id is contact
        if(parentRecordId!='' && parentRecordId.startsWith('003')) {
            // Customer passed to new Sales Up, get customer data and populate page
            Contact[] contact = [Select Id, FirstName, LastName, Phone, MobilePhone, HomePhone, Email, CreatedDate, dealer__External_ID__c 
                                 from Contact where Id =:parentRecordId
                                 limit 1];
            if(contact!=null && contact.size()>0) {
                up.dealer__FirstName__c=contact[0].FirstName;
                up.dealer__LastName__c=contact[0].LastName;
                up.dealer__Lead_Date__c=Date.Today();
                up.dealer__Buyer_Contact__c=contact[0].Id;
                up.dealer__Phone__c=contact[0].Phone;
                up.dealer__Mobile__c=contact[0].MobilePhone;
                up.dealer__Email__c=contact[0].Email;
            }                   
        }
        
        //Check if the parent record id is account
        else if(parentRecordId!='' && parentRecordId.startsWith('001')) {
            Account[] account = [Select Id,Name, FirstName, LastName, Phone, PersonMobilePhone, PersonEmail, CreatedDate, isPersonAccount
                                 from Account where Id =:parentRecordId //and isPersonAccount=true
                                 limit 1];
            
            System.debug('account - '+account);
                fromB2BAccount = false;
            
            if(account!=null && account.size()>0 && account[0].isPersonAccount) {
                up.dealer__FirstName__c=account[0].FirstName;
                up.dealer__LastName__c=account[0].LastName;
                up.dealer__Lead_Date__c=Date.Today();
                //up.dealer__Buyer_Contact__c=contact[0].Id;
                up.dealer__Phone__c=account[0].Phone;
                up.dealer__Mobile__c=account[0].PersonMobilePhone;
                up.dealer__Email__c=account[0].PersonEmail;
            } else if (account != null && account.size() > 0 && !account[0].isPersonAccount) {
                fromB2BAccount = true;
                businessAccountId = account[0].Id;
            }                  
        }
                        
        activeSalesup = new List<AvaliableSalesUp>();
        
        // If controller search for duplicates page pre-populate search results
        if(ApexPages.currentPage().getUrl().containsIgnoreCase('SalesUpDuplicateSearch') && up.dealer__FirstName__c!=null) {
            
            fromFDPage = true;
            fromCreatePage = false;
            System.debug('fromFDPage is true');
            System.debug('fromCreatePage is false');
            System.debug('SalesLead_EXT: constructor: Searching existing for dupes' );
            this.searchExistingDataSOSL(searchOptions);
            
            System.debug('searchAccountResults = '+searchAccountResults.size());
            System.debug('searchContactResults = '+searchContactResults.size());
            System.debug('searchUpsResults = '+searchUpsResults.size());
            activeSalesup.clear();
            for(sales_up__c  s:searchUpsResults){
                AvaliableSalesUp thisPerson= new AvaliableSalesUp();
                thisPerson.junctionRecord=s;
                activeSalesup.add(thisPerson);
            }   
            System.debug('activeSalesup'+activeSalesup);    
            }              
        if(ApexPages.currentPage().getUrl().containsIgnoreCase('new')){
            fromFDPage = false;
            fromCreatePage = true;
        }
    }

    public List<SelectOption> getBusinessContacts(){
        if(businessAccountId != null){
             List<SelectOption> contacts = new List<SelectOption>();
            contacts.add(new SelectOption('','select..'));
            for(Contact c :[SELECT Id, Name From Contact WHERE AccountId =: businessAccountId]){
                contacts.add(new SelectOption(c.Id, c.Name));
            } 
            return contacts;
        }
       return new List<SelectOption>();
    }
    
    public void setSupFieldsFromContact() {
        if(this.up.Buyer_Contact__c != null){
        Contact c = [SELECT Id, FirstName,LastName, Phone, MobilePhone, Email FROM Contact Where Id =:this.up.dealer__Buyer_Contact__c];
        this.up.FirstName__c = c.FirstName != null ? c.FirstName : '';
        this.up.LastName__c = c.LastName != null ? c.LastName : '';
        this.up.LastName__c = c.LastName != null ? c.LastName : '';
        this.up.Phone__c = c.Phone != null ? c.Phone : '';
        this.up.Mobile__c = c.MobilePhone != null ? c.MobilePhone : '';
        this.up.Email__c = c.Email != null ? c.Email : '';
        }
    }
    /**
     * redirectLex - Determines the experience the user is expecting and directs them to the right new page
     * @return pageRefence
     * @notes based on the users preferences this method is called on page load to direct the user
     * user to the right location.
     */
    public PageReference redirectLex() {

        // Get UI Preferences
        if(UserInfo.getUiThemeDisplayed()=='Theme4d'  || UserInfo.getUiThemeDisplayed()=='Theme4t') {
            PageReference newSalesUpLex = Page.SalesUpNewLex;
            return newSalesUpLex;
        }
        return null;
    }
    
    public String singleQuotes(String str){
        return (str != null) ? '\'' + String.escapeSingleQuotes(str) + '\'' : null;
    }
    
    
    
    
    /**
    * @Method      : salesUpview
    * @Description : Redirecting the page to VINDeoderTradeIn page if any trade fields are empty (to pre-populate trade fields),
    or else standard view page            
    * @return      : pageReference   
    * @Param       : none
    */
    public pageReference salesUpview(){
        
        pageReference upPage = null;
        //Commented by KVP to clear the values of make, made, year, trim level (3/12/15)
        /* PageReference decoderPage = page.VINDecodeTradeIn;
        decoderPage.getparameters().put('id',up.id);
        upPage = isReturnToVINDecodeTradeIn() ? decoderPage : new ApexPages.Standardcontroller(up).view();
        */
        upPage = new ApexPages.Standardcontroller(up).view();
        upPage.setRedirect(true);
        
        return upPage;
    }
    
    /**
    * @Method      : customSave
    * @Description : Method to update the salesUp record for SalesupSave page.            
    * @return      : pageReference   
    * @Param       : none
    */
    public pageReference customSave(){
        pageReference upPage = null;
        searchTradeVIN();  
        try{
            upsert up;
            upPage = salesUpview();
        }catch(Exception e){
            Apexpages.addMessage(new Apexpages.Message(Apexpages.severity.ERROR, e.getMessage()));
        }
        return upPage;
    } 
    
    /**
    * @method     : Cancel
    * @Description: return the user to the cancel page
    */
        public PageReference cancel() {
            //Case#1993 begin
            //return new ApexPages.StandardController(up).cancel();
            String keyPrefix =dealer__Sales_Up__c.sobjecttype.getDescribe().getKeyPrefix() ;
            return new pagereference('/'+keyPrefix+'/o');
            //Case#1993 end
        }
        
    /**
    * @Method      : searchTradeVIN
    * @Description : Method to search Trade VIN of Sales up in service vehicle object in order to link salesup
    record with service vehicle
    * @return      : void  
    * @Param       : none 
    */
    public void searchTradeVIN(){
        
        serVehicleList = new list<dealer__Service_Vehicle__c>();
        List<dealer__Service_Vehicle__c> serviceVehs = new List<dealer__Service_Vehicle__c>();
        String filterCondition;
        
        if(!Utility.isBlank(up.dealer__Trade_VIN__c)) {
            
            filterCondition = 'where dealer__VIN__c = '+singleQuotes(up.dealer__Trade_VIN__c);
            // Need to prevent "List has no rows for assignment to SObject" error! - DR
            serviceVehs= database.query('select id, dealer__VIN__c,dealer__Year__c, dealer__Trim_Level__c, dealer__Make__c, dealer__Carline__c, dealer__Body_Type__c  from dealer__Service_Vehicle__c '+ filterCondition);
            if (serviceVehs.size() > 0) {
                dealer__Service_Vehicle__c serVehicle = serviceVehs[0];
                up.dealer__Service_Vehicle__c  = serVehicle.id;
                up.dealer__Trade_Year__c       = serVehicle.dealer__Year__c;
                up.dealer__Trade_Trim_Level__c = serVehicle.dealer__Trim_Level__c;
                up.dealer__Trade_Model__c      = serVehicle.dealer__Carline__c;
                up.dealer__Trade_Make__c       = serVehicle.dealer__Make__c;
                up.dealer__Trade_Body_Type__c  = serVehicle.dealer__Body_Type__c;
            }
            
        }
        if(serviceVehs.isEmpty() && up.dealer__Buyer_Contact__c !=null){  
            // DR Commented out - "unexpected token: =" error
            filterCondition = 'WHERE dealer__VIN__c = null AND dealer__Veh_Owner_Contact__c = ' +singleQuotes(up.dealer__Buyer_Contact__c); 
            serVehicleList = database.query('select id,name,dealer__VIN__c,dealer__Year__c,dealer__Make__c,dealer__Carline__c from dealer__Service_Vehicle__c '+ filterCondition);
            
        }
        
    }
    
    public String getUserName() {
        return UserInfo.getName();
    }
    
    public String getUserId() {
        return UserInfo.getUserId();
    }
    
    public dealer__Sales_Up__c getup() {
        return up;
    }
    
    public List<dealer__Sales_Up__c> getUpList() {
        List<dealer__Sales_Up__c> uList = new List<dealer__Sales_Up__c>();
        uList.add(up);
        return uList;
    }
    
    public Id selectedCustomerId {get;set;}
    public Id selectedAccountId {get;set;}
    
    public Integer searchCustomerSize {
        get {return searchContactResults.size();}
        set {}
    }
    public Integer searchAccountSize {
        get {
            System.debug('getting account size');
            
            if(searchAccountResults == null){
                System.debug('Search Account Results is null');
                return 0;
            }
            
            else{ 
                System.debug('Search Account Results not null: '+searchAccountResults.size());
                return searchAccountResults.size();
            }
        }
        set {}
    }
    
    public Integer searchUpsSize {
        get {return searchUpsResults.size();}
        set {}
    }
    
    
    public PageReference Create() {
        
        // Connect default user information
        User salesperson = [Select Id, ManagerId from User where Id = :UserInfo.getUserId() limit 1];
        
        if(up.dealer__Salesperson_1__c == null) {
            up.dealer__Salesperson_1__c = salesperson.Id;
        }
        
        if(salesperson.ManagerId != null && dms.dealer__Sales_Lead_Auto_Assign_Manager__c==true) {
            up.dealer__Desk_Manager_User__c = salesperson.ManagerId;    
        }
        
        // If CreateUp is passing Buyer_Contact__c, we know the customer record and should not be forced to search
        if(up.dealer__Buyer_Contact__c!=null && up.Id==null) {
            PageReference upPage;
            try{
                insert up;
                upPage = salesUpview();
                //upPage = new ApexPages.Standardcontroller(up).view();
                //upPage.setRedirect(true);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return upPage;
        }
        if(up.Id==null) {
            Account a = new Account();
            a.FirstName     =   up.dealer__FirstName__c;
            a.LastName      =   up.dealer__LastName__c;
            a.PersonEmail   =   up.dealer__Email__c;
            a.PersonHomePhone  =up.dealer__Phone__c;
            a.Phone         =   up.dealer__Phone__c; // Adding to allow phone field to display.
            a.PersonMobilePhone=up.dealer__Mobile__c;      
            
            insert a;
            
            // Get the Related Contact
            Contact[] c = [Select Id from Contact where AccountId =:a.Id limit 1];
            if(c.size()==1) {
                up.dealer__Buyer_Contact__c = c[0].Id;
            }
             if(up.dealer__Service_Vehicle__c  != null){
                dealer__Service_Vehicle__c sv  = [SELECT Id, Name, dealer__Vin__c,dealer__Year__c, dealer__Make__c, dealer__Carline__c,dealer__Trim_Level__c,dealer__Last_Odometer__c from dealer__Service_Vehicle__c where Id =: up.dealer__Service_Vehicle__c];
                up.dealer__Trade_VIN__c        = sv.dealer__Vin__c;
                up.dealer__Trade_Year__c       = sv.dealer__year__c;
                up.dealer__Trade_Make__c       = sv.dealer__Make__c;
                up.dealer__Trade_Model__c      = sv.dealer__Carline__c;
                up.dealer__Trade_Trim_Level__c = sv.dealer__Trim_Level__c;
                up.dealer__Trade_Mileage__c    = sv.dealer__Last_Odometer__c;
            }
            // Set the Account
            up.dealer__Customer_Account__c = a.Id; 
        }
        
        try{
            upsert up;
        }catch(Exception e){
            String eMessage = '';
            if(e.getTypeName().equalsIgnoreCase('System.DMLException')){
                eMessage = e.getDmlMessage(0);
            }
            else eMessage = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, eMessage));
            return null;
        }
        
        if(up.dealer__Traffic_Log_Entry__c != null) {
            System.debug('Up connect '+up.dealer__Traffic_Log_Entry__c);
            dealer__Traffic_Log__c tlog = [Select Id from dealer__Traffic_Log__c where Id =:up.dealer__Traffic_Log_Entry__c];
            tlog.dealer__Sales_Lead__c  = up.Id;
            update tlog;
        }
        return salesupview();
    }
    
    
    /**
    * SaveOverride
    */
    public PageReference saveDuplicateOverride() {
        System.debug('saveDuplicateOverride');
        Database.DMLOptions options = new Database.DMLOptions();
        options.DuplicateRuleHeader.AllowSave = true;
        Database.SaveResult sr2 = Database.Insert(up, options);
        if(!sr2.isSuccess()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error Saving Record : '+sr2.getErrors()));
            return null;
        }
        
        // Create the Account and link to the Sales Up
        Account a = new Account();
        a.FirstName     =   up.dealer__FirstName__c;
        a.LastName      =   up.dealer__LastName__c;
        a.PersonEmail   =   up.dealer__Email__c;
        a.PersonHomePhone  =up.dealer__Phone__c;
        //a.Phone  =up.dealer__Phone__c;
        a.PersonMobilePhone=up.dealer__Mobile__c;      
        
        insert a;
        
        // Get the Related Contact
        Contact[] c = [Select Id from Contact where AccountId =:a.Id limit 1];
        if(c.size()==1) {
            up.dealer__Buyer_Contact__c = c[0].Id;
        }
        
        // Set the Account
        up.dealer__Customer_Account__c = a.Id; 
        
        update up;
        
        return (new ApexPages.Standardcontroller(up)).view();    
    }
    
    
    public class searchUps {
        
        public boolean inFirstName {get; set;}
        public boolean inLastName {get;set;}
        public boolean inEmail {get;set;}
        public boolean inPhone {get;set;}
        public boolean inMobile {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public String upEmail {get;set;}
        public String upPhone {get;set;}
        public String upMobile {get;set;}
        
        public searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, 
                         string firstn, string lastn, string uemail, string uphone, string umobile) {
                             inFirstName =   inFirst;
                             inLastName  =   inLast;
                             inEmail     =   inEmailAddr;
                             inPhone     =   inPhoneNum;
                             inMobile    =   inMobileNum;
                             
                             firstName   =   firstn;
                             lastName    =   lastn;
                             upphone     =   uphone;
                             upmobile    =   umobile;
                             upEmail     =   uEmail;
                         }
    }
    
    public dealer__Sales_Up__c lookUp(String upID) {
        return [Select Id, dealer__LastName__c, dealer__FirstName__c, dealer__Mobile__c, dealer__Email__c, dealer__Phone__c from dealer__Sales_Up__c where Id = :upID limit 1];
    }
    
    public PageReference noMatch() {
        this.matchEscape = true;
        System.debug('Override '+this.matchEscape);
        return this.Create();
    }
    
    public PageReference attachLead() {
        // Used only to attach a lead to an existing customer account
        if(selectedAccountId==null) {
            return null;
        }
        
        System.assertNotEquals(selectedAccountId, null, 'the selected account ID is null in method attachLead');
        System.debug('AttachAccount '+selectedAccountId);

        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId=:selectedAccountId LIMIT 1];
        if(contacts.size()>0){
            up.dealer__Buyer_Contact__c = contacts[0].Id;
        }
         if(up.dealer__Service_Vehicle__c  != null){
                dealer__Service_Vehicle__c sv  = [SELECT Id, Name, dealer__Vin__c,dealer__Year__c, dealer__Make__c, dealer__Carline__c,dealer__Trim_Level__c,dealer__Last_Odometer__c from dealer__Service_Vehicle__c where Id =: up.dealer__Service_Vehicle__c];
                up.dealer__Trade_VIN__c        = sv.dealer__Vin__c;
                up.dealer__Trade_Year__c       = sv.dealer__year__c;
                up.dealer__Trade_Make__c       = sv.dealer__Make__c;
                up.dealer__Trade_Model__c      = sv.dealer__Carline__c;
                up.dealer__Trade_Trim_Level__c = sv.dealer__Trim_Level__c;
                up.dealer__Trade_Mileage__c    = sv.dealer__Last_Odometer__c;
            }
        up.dealer__Customer_Account__c=selectedAccountId;
        try{
            upsert up;
        }catch(Exception e){
            String eMessage = '';
            if(e.getTypeName().equalsIgnoreCase('System.DMLException')){
                eMessage = e.getDmlMessage(0);
            }
            else eMessage = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, eMessage));
            return null;
        }
        
        PageReference upPage = salesUpview();
        //Commented and calling salesUpView method to redirect
        //PageReference upPage = new ApexPages.Standardcontroller(up).view();
        //upPage.setRedirect(true);
        return upPage;
    }
    
    public Boolean isBlank(String s){
        if(s==null||s=='') {
            return false;
        } else {
            return true;
        }
    }
    
    
    /*******************************************************************************************************
    * @description Returns reference to the Service Vehicle version of VIN Decode
    * @return A reference to VINDecodeServiceVehicleStyleSelect.page
    * @author Mimi Sakarett
    * @date 2016.03.14
    */
    public PageReference customDoDecode(){
        PageReference vindecode = Page.VINDecodeServiceVehicleStyleSelect;
        vindecode.setRedirect(true);
        return vindecode;
    }
    
    
    public void doDecode() {
        vd.DecodeVIN(up.dealer__Trade_VIN__c);
        ddat = vd.decodeData;
        ModelKeyList = ddat.styles;
    }
    
    public PageReference decodeTradePage() {
        PageReference vdp = Page.VINDecodeTradeIn;
        vdp.setRedirect(true);
        return vdp;
    }
    
    public PageReference editTradeVINPage() {
        System.debug('##-## '+SelectedStyleId);
        if(SelectedStyleId != null) {
            sdat = vd.SelectedStyle(SelectedStyleId);
        }
        
        up.dealer__Trade_Year__c = ddat.common_data.year;
        up.dealer__Trade_Make__c = ddat.common_data.make;
        up.dealer__Trade_Model__c = ddat.common_data.model;
        
        if(ddat.common_data.body_type != null) {
            up.dealer__Trade_Body_Type__c = ddat.common_data.body_type;
        }
        if(sdat!=null) {
            if(sdat.basic_data != null) {
                up.dealer__Trade_Trim_Level__c = sdat.basic_data.trim;
            }
        }
        
        update up;
        PageReference vpage = salesUpview();
        //Commented and calling salesUpView method to redirect
        //PageReference vpage = new ApexPages.Standardcontroller(up).view();
        //vpage.setRedirect(true);
        return vpage;
    }
    
    public List<VINDecoderDataObject.Style> getModelKeyList() {
        return ModelKeyList;
    }
    
    public VINDecoderDataObject.DecodeData getDecode() {
        return ddat;
    }
    
    public String getSelectedStyleId() {
        return SelectedStyleId;
    }
    
    public void setSelectedStyleId(String SelectedStyleId) {
        this.SelectedStyleId = SelectedStyleId;
    }       
    
    public class SalesUpException extends Exception {}
    
    // inner class for maintaining checkbox
    public class AvaliableSalesUp{
        public Boolean isChecked {get; set;}
        public Integer counter {get; set;}
        public Sales_up__c junctionRecord {get; set;}
        public AvaliableSalesUp(){
            isChecked = false;
            counter = 0;
            junctionRecord = new Sales_up__c();
        }
        
    }
    public Integer ActiveRecordsCount{get;set;}
    
    public pageReference mergeRecords(){
        String pIDs='';
        System.debug('activeSalesup>>'+activeSalesup);
        ActiveRecordsCount=0;
        for(AvaliableSalesUp salesUp : activeSalesup){
            if(salesUp.isChecked){
                ActiveRecordsCount=ActiveRecordsCount+1;
                pIDs = pIDs + salesUp.junctionRecord.ID +':';
            }
        }
        System.debug('pIDs>>'+pIDs+'ActiveRecordsCount'+ActiveRecordsCount);
        if(ActiveRecordsCount ==2 || ActiveRecordsCount ==3){
            PageReference viewPage= new PageReference('/apex/MergeSalesup');
            viewPage.getParameters().put('pIDs',pIDs);
            viewPage.getParameters().put('Type','Sales_up__c');
            viewPage.setRedirect(true);
            return viewPage;
        }
        return null;
        
    }
    
    // used by visualforce page to get the vehicle object prefix - KVP
    public string getKeyPrefix(){
        Schema.DescribeSObjectResult r = Vehicle_Inventory__c.sObjectType.getDescribe();
        return r.getKeyPrefix();
    }
    // Method to fetch the current RecordType Name
    public String getRecordTypeName(){
        String recordTypeId = Apexpages.CurrentPage().getParameters().get('RecordType');
        return recordTypeId != null ? [Select developerName from recordtype where id=:recordTypeId].developerName :null;
    }
    
    public class UpException extends Exception {}
    
    //Added by KVP
    public dealer__Vehicle_Inventory__c getInventoryVehicle(){
        
        //vinToTradeMap = new Map<String, dealer__Trade_In__c>();
        System.debug('id of current page: '+ApexPages.currentPage().getParameters().get('id'));
        list<dealer__Sales_Up__c> trade = [SELECT dealer__Trade_Model__c, dealer__Service_Vehicle__c, 
                                           dealer__Service_Vehicle__r.dealer__Sales_Inventory__c, dealer__Trade_Year__c, dealer__Trade_Make__c, dealer__Trade_VIN__c, dealer__Trade_Trim_Level__c 
                                           FROM dealer__Sales_Up__c  WHERE id =:ApexPages.currentPage().getParameters().get('id') 
                                           and dealer__Service_Vehicle__r.dealer__Sales_Inventory__c = null];
        System.debug('Trade: '+trade);
        if(trade.size()>0){
            vehicleInventory.dealer__Trim_Level__c =trade[0].dealer__Trade_Trim_Level__c;
            vehicleInventory.dealer__VIN__c = trade[0].dealer__Trade_VIN__c;
            vehicleInventory.dealer__Year__c = trade[0].dealer__Trade_Year__c;
            vehicleInventory.dealer__Make__c = trade[0].dealer__Trade_Model__c;
            vehicleInventory.dealer__Model__c = trade[0].dealer__Trade_Make__c;
            //dealer__Sales_Inventory__c
            //inventoryVehList.add(vehicleInventory);
            return vehicleInventory;
        }
        
        return null;
        
    }
    
    public PageReference createInventory(){
        try{
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(id =up.dealer__Service_Vehicle__c);
            insert vehicleInventory;
            up.Lead_Status__c = dms.Salesup_status_for_inventory__c;
            update up;
        }catch(Exception e){
            ApexPages.addMessage(new Apexpages.message(Apexpages.severity.error,e.getMessage()));                   
        }
        return new PageReference('/'+up.id);
    }
    
    //*********************************************************************************************************************************
    public PageReference FindFromCreatePage(){
        fromFDPage = false;
        fromCreatePage = true;
        return FindDupes();
    }
    
    public PageReference FindDupesFromFD(){
        fromFDPage = true;
        fromCreatePage = false;
        return FindDupes();
    }
    
    /*******************************************************************************************************
    * @description Checks custom setting to determine whether to use native or non native duplicate catching
    * @return PageReference to SalesUpDuplicateSearch.page
    * @author Mimi Sakarett
    * @date 2016.02.08
    */
    public PageReference FindDupes(){
        System.debug('De dupe selection: '+crm.dealer__Native_or_Non_Native_Dupe_Catching__c);
        if(crm.dealer__Native_or_Non_Native_Dupe_Catching__c == 'Native'){
            System.debug('Native de dupe selected');
            List<DuplicateRule> duplicateRulesList = [SELECT Id, IsActive FROM DuplicateRule WHERE SobjectType = 'dealer__Sales_Up__c' AND IsActive = true];
            if(duplicateRulesList.isEmpty()) { 
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Active Duplicate Rules do not exist for Sales Ups. Activate Duplicate Rules or choose Non-Native Duplicate Management in Custom Settings.');
                ApexPages.addMessage(errorMessage);
                return null; 
            } 
            return NativeFindDupes();
        }
        //Non-native duplicate catching cannot function properly if there are active duplicate rules. Check for active rules and alert the user. 
        else if(crm.dealer__Native_or_Non_Native_Dupe_Catching__c == 'Non-Native'){
            System.debug('Non-Native de dupe selected');
            List<DuplicateRule> duplicateRulesList = [SELECT Id, IsActive FROM DuplicateRule WHERE SobjectType = 'dealer__Sales_Up__c' AND IsActive = true];
            if(!duplicateRulesList.isEmpty()) { 
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Active Duplicate Rules exist for Sales Ups. Deactivate these Duplicate Rules or choose Native Duplicate Management in Custom Settings.');
                ApexPages.addMessage(errorMessage);
                return null; 
            } 
            return NonNativeFindDupes();
        }
        else{
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Duplicate Detection Preference not set. Please choose Native or Non Native in CRMSettings.');
            ApexPages.addMessage(errorMessage);
            return null;
        }
    }
    
    /*******************************************************************************************************
    * @description Searches existing Accounts and Sales Ups for a match to the current Sales Up. 
    * @return PageReference to SalesUpDuplicateSearch.page
    * @author Mimi Sakarett
    * @date 2016.02.08
    */
    public PageReference NonNativeFindDupes(){
        List<Account> accounts = [Select Id, Name, FirstName, LastName, Phone ,PersonEmail, PersonHomePhone, PersonMobilePhone,PersonMailingStreet, 
                                  PersonMailingCity, PersonMailingState, PersonMailingPostalCode, IsPersonAccount From Account 
                                  where IsDeleted = false and Id =:up.dealer__Customer_Account__c limit 1];
        this.searchExistingDataSOSL(searchOptions);
        activeSalesup.clear();
        for(sales_up__c  s:searchUpsResults){
            AvaliableSalesUp thisPerson= new AvaliableSalesUp();
            thisPerson.junctionRecord=s;
            activeSalesup.add(thisPerson);
        }   
        
        //Added by KVP
        isDupFound =  (!searchContactResults.isEmpty() || !searchUpsResults.isEmpty()) ? true : false;

        
        System.debug('activeSalesup: '+activeSalesup);                  
        PageReference searchResultsPage = Page.SalesUpDuplicateSearch;
        searchResultsPage.setRedirect(false);
        return searchResultsPage;
    }
    
    //Native checking for existing duplicates
    public PageReference NativeFindDupes(){
        System.debug('NativeFindDupes');
        try{
            Database.SaveResult updateResult = Database.update(up, false);
            
            System.debug('updateResult = '+updateResult);
            if(!updateResult.isSuccess()) {
                
                // Mathcing Results ?
                System.debug('SalesLead_EXT: CreateSalesUpwithDupCheck: Failed to save ' + updateResult.getErrors());
                
                
                for(Database.Error error : updateResult.getErrors()) {
                    
                    /* Native Duplicate checking */
                    if(error instanceof Database.DuplicateError) {
                        
                        System.debug('inside dupe error');
                        
                        Database.DuplicateError duplicateError = (Database.DuplicateError)error;
                        Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();
                        
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.WARNING, 'Duplicate Warning : '+duplicateResult.getErrorMessage());
                        ApexPages.addMessage(errorMessage);
                        
                        this.duplicateRecords = new List<sObject>();
                        Datacloud.Matchresult[] matchResults = duplicateResult.getMatchResults();
                        
                        System.debug(matchResults);
                        
                        Datacloud.MatchResult matchResult = matchResults[0];
                        Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();
                        
                        for(Datacloud.Matchrecord matchRecord : matchRecords) {
                            this.duplicateRecords.add(matchRecord.getRecord());
                        }
                        
                        this.hasDuplicateResult = !this.duplicateRecords.isEmpty();
                        
                    } else {
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving record : '+error.getMessage());
                        ApexPages.addMessage(errorMessage);
                    }
                }
                
                return null;
            }
            else{
                return null;
            }
            
        } Catch(Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
        
    }
    
    
    //Sales Up Creation
    public PageReference CreateSU(){
        system.debug('CreateSu');
        if(up.dealer__Lead_Date__c==null) {
            up.dealer__Lead_Date__c=Date.Today();
        }

        //If 

        //MKS 8-31-2016 If the account or contact is set, return the detail page
        if(up.dealer__Customer_Account__c != null || up.dealer__Buyer_Contact__c != null){

            if(up.dealer__Customer_Account__c != null && up.dealer__Buyer_Contact__c != null && fromB2BAccount){
                system.debug('fromB2bCreate');
                Contact c = new Contact(Id=up.dealer__Buyer_Contact__c,
                        FirstName = this.up.FirstName__c,
                        LastName = this.up.LastName__c,
                        Phone = this.up.Phone__c,
                        MobilePhone = this.up.Mobile__c,
                        Email = this.up.Email__c
                    );
                    update c;
            }else{
                //If the Contact is attached with no Account, look for a matching Account and attach it
                if(up.dealer__Customer_Account__c == null){
                    List<Contact> c = [SELECT AccountId FROM Contact WHERE Id=:up.dealer__Buyer_Contact__c];
                    if(c.size() == 1){
                        up.dealer__Customer_Account__c = c[0].AccountId;
                    }
                }
                //If the Account is attached with no Contact, look for a matching Contact and attach it
                //First and Last name not assigned on Sales Up when created from Contact, so performed manually below
                if(up.dealer__Buyer_Contact__c == null){
                    List<Contact> c = [SELECT Id FROM Contact WHERE AccountId=:up.dealer__Customer_Account__c];
                    if(c.size() == 1){
                        up.dealer__Buyer_Contact__c = c[0].Id;
                    }
                }
            }
            
            try{
                insert up;
            }catch(Exception e){
                String eMessage = '';
                if(e.getTypeName().equalsIgnoreCase('System.DMLException')){
                    eMessage = e.getDmlMessage(0);
                }
                else{ 
                    System.debug(Logginglevel.ERROR,'the type of the error is: '+e.getTypeName());
                    eMessage = e.getMessage();
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, eMessage));
                return null;
            }
            //end MKS 8-31-2016

            PageReference newSupPageRef = new PageReference('/' + up.id);
            return newSupPageRef;
            
        }
        
        fromCreatePage = true;
        fromFDPage = false;
        System.debug('De dupe selection: '+crm.dealer__Native_or_Non_Native_Dupe_Catching__c);
        if(crm.dealer__Native_or_Non_Native_Dupe_Catching__c == 'Native'){
            System.debug('Native de dupe selected');
            return NativeCreateSU();
        }
        //Non-native duplicate catching cannot function properly if there are active duplicate rules. Check for active rules and alert the user. 
        else if(crm.dealer__Native_or_Non_Native_Dupe_Catching__c == 'Non-Native'){
            System.debug('Non-Native de dupe selected');
            List<DuplicateRule> duplicateRulesList = [SELECT Id, IsActive FROM DuplicateRule WHERE SobjectType = 'dealer__Sales_Up__c' AND IsActive = true];
            if(!duplicateRulesList.isEmpty()) { 
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Active Duplicate Rules exist for Sales Ups. Deactivate these Duplicate Rules or choose Native Duplicate Management in Custom Settings.');
                ApexPages.addMessage(errorMessage);
                return null; 
            } 
            return NonNativeCreateSU();
        }
        else{
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Duplicate Detection Preference not set. Please choose Native or Non Native in CRMSettings.');
            ApexPages.addMessage(errorMessage);
            return null;
        }
        
    }
    
    //Non Native Sales Up Creation
    public PageReference NonNativeCreateSU(){
        //check for existing accounts that match
        Account a = new Account();
        a.FirstName     =   up.dealer__FirstName__c;
        a.LastName      =   up.dealer__LastName__c;
        a.PersonEmail   =   up.dealer__Email__c;
        a.PersonHomePhone  =up.dealer__Phone__c;
        a.PersonMobilePhone=up.dealer__Mobile__c;
        
        searchOptions = new searchUps(isBlank(up.dealer__FirstName__c), 
                                      isBlank(up.dealer__LastName__c), 
                                      isBlank(up.dealer__Email__c), 
                                      isBlank(up.dealer__Phone__c), 
                                      isBlank(up.dealer__Mobile__c), 
                                      up.dealer__FirstName__c, 
                                      up.dealer__LastName__c, 
                                      up.dealer__Email__c,
                                      up.dealer__Phone__c,
                                      up.dealer__Mobile__c);
        
        searchExistingDataSOSL(searchOptions);
        
        //if the account exists, set the Sales Up's Account
        if(searchAccountResults.size() >= 1){
            System.debug('SalesLead_EXT: NonNativeCreateSU: Found one matching account');
            //return new PageReference('/apex/SalesUpChooseExisting');
            
            return new PageReference('/apex/SalesUpDuplicateSearch');
        }
        
        else{
            System.debug('SalesLead_EXT: NonNativeCreateSU: No matching accounts found');
            insert a;
            // Get the Related Contact
            Contact[] c = [Select Id from Contact where AccountId =:a.Id limit 1];
            if(c.size()==1) {
                up.dealer__Buyer_Contact__c = c[0].Id;
            }
            if(up.dealer__Service_Vehicle__c  != null){
                dealer__Service_Vehicle__c sv  = [SELECT Id, Name, dealer__Vin__c,dealer__Year__c, dealer__Make__c, dealer__Carline__c,dealer__Trim_Level__c,dealer__Last_Odometer__c from dealer__Service_Vehicle__c where Id =: up.dealer__Service_Vehicle__c];
                up.dealer__Trade_VIN__c        = sv.dealer__Vin__c;
                up.dealer__Trade_Year__c       = sv.dealer__year__c;
                up.dealer__Trade_Make__c       = sv.dealer__Make__c;
                up.dealer__Trade_Model__c      = sv.dealer__Carline__c;
                up.dealer__Trade_Trim_Level__c = sv.dealer__Trim_Level__c;
                up.dealer__Trade_Mileage__c    = sv.dealer__Last_Odometer__c;
            }
            
            // Set the Account
            up.dealer__Customer_Account__c = a.Id;
            try{
                upsert up;
            }catch(Exception e){
                String eMessage = '';
                if(e.getTypeName().equalsIgnoreCase('System.DMLException')){
                    eMessage = e.getDmlMessage(0);
                }
                else{ 
                    System.debug(Logginglevel.ERROR,'the type of the error is: '+e.getTypeName());
                    eMessage = e.getMessage();
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, eMessage));
                return null;
            }
            PageReference upview = (new ApexPages.Standardcontroller(up)).view();
            upview.setRedirect(false);
            return upview;
        }
    }
    
    
    //Native - Sales Up Creation
    public pageReference NativeCreateSU(){
        pagereference upPage;
        
        try {
            Database.SaveResult saveResult = Database.insert(up, false);
            
            System.debug('saveResult = '+saveResult);
            if(!saveResult.isSuccess()) {
                
                // Mathcing Results ?
                System.debug('SalesLead_EXT: NativeCreateSU: Failed to save ' + saveResult.getErrors());
                
                
                for(Database.Error error : saveResult.getErrors()) {
                    System.debug('error: '+error);
                    /* Native Duplicate checking */
                    if(error instanceof Database.DuplicateError) {
                        
                        System.debug('inside dupe error');
                        
                        Database.DuplicateError duplicateError = (Database.DuplicateError)error;
                        Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();
                        
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.WARNING, 'Duplicate Warning : '+duplicateResult.getErrorMessage());
                        ApexPages.addMessage(errorMessage);
                        
                        this.duplicateRecords = new List<sObject>();
                        Datacloud.Matchresult[] matchResults = duplicateResult.getMatchResults();
                        
                        System.debug(matchResults);
                        
                        Datacloud.MatchResult matchResult = matchResults[0];
                        Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();
                        
                        for(Datacloud.Matchrecord matchRecord : matchRecords) {
                            this.duplicateRecords.add(matchRecord.getRecord());
                        }
                        
                        this.hasDuplicateResult = !this.duplicateRecords.isEmpty();
                        
                    } else {
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving record : '+error.getMessage());
                        ApexPages.addMessage(errorMessage);
                    }
                }
                
                return null;
            }
            else{
                System.debug('SalesLead_EXT: NativeCreateSU: saveResult is a success');
            }
            
            
            // Create the Account and link to the Sales Up
            Account a = new Account();
            a.FirstName     =   up.dealer__FirstName__c;
            a.LastName      =   up.dealer__LastName__c;
            a.PersonEmail   =   up.dealer__Email__c;
            a.PersonHomePhone  =up.dealer__Phone__c;
            a.PersonMobilePhone=up.dealer__Mobile__c;      
            
            System.debug('SalesLead_EXT: NativeCreateSU: insert account');
            insert a;
            
            // Get the Related Contact
            Contact[] c = [Select Id from Contact where AccountId =:a.Id limit 1];
            if(c.size()==1) {
                up.dealer__Buyer_Contact__c = c[0].Id;
            }
            
            // Set the Account
            up.dealer__Customer_Account__c = a.Id; 
            
            System.debug('SalesLead_EXT: NativeCreateSU: update sales up after setting account and contact');
            
            update up;
            
        } Catch(Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        return (new ApexPages.Standardcontroller(up)).view();
    }
    
    
    public void searchExistingDataSOSL(searchUps searchOptions){
        String soslq = '(';
        if((searchOptions.firstName!=null&&searchOptions.firstName!='' && searchOptions.inFirstName) 
           || (searchOptions.lastName!=null&&searchOptions.lastName!='' && searchOptions.inLastName)){
               
               soslq += '(';
               if(searchOptions.firstName!=null&&searchOptions.firstName!='' && searchOptions.inFirstName) {
                   soslq+=''+String.escapeSingleQuotes(searchOptions.firstName)+' and ';
               }                                       
               if(searchOptions.lastName!=null&&searchOptions.lastName!='' && searchOptions.inLastName) {
                   soslq+=''+String.escapeSingleQuotes(searchOptions.lastName)+'';
               }
               soslq = soslq.removeEndIgnoreCase(' and ');
               soslq += ') OR ';
               
           }
        
        // Conditional Email, Phone 
        if((searchOptions.upEmail!=null&&searchOptions.upEmail!='' && searchOptions.inEmail) 
           || (searchOptions.upPhone!=null&&searchOptions.upPhone!='' && searchOptions.inPhone ) 
           || (searchOptions.upMobile!=null&&searchOptions.upMobile!='' && searchOptions.inMobile)) {
               
               
               if(searchOptions.upEmail!=null&&searchOptions.upEmail!='' && searchOptions.inEmail) 
               {soslq +=' '+String.escapeSingleQuotes(searchOptions.upEmail)+' OR ';}
               
               if(searchOptions.upPhone!=null&&searchOptions.upPhone!='' && searchOptions.inPhone ) 
               {soslq += ' '+String.escapeSingleQuotes(searchOptions.upPhone)+' OR '; }
               
               if(searchOptions.upMobile!=null&&searchOptions.upMobile!='' && searchOptions.inMobile) 
               {soslq += ' '+String.escapeSingleQuotes(searchOptions.upMobile)+'' ;}
               
           }
        
        soslq = soslq.removeEndIgnoreCase(' or ');
        
        soslq +=')';
        
        System.debug('soslq is: '+soslq);
        
        List<List<sObject>> soslResults = [FIND :soslq IN ALL FIELDS RETURNING Account (Id, Name, FirstName, LastName, Phone ,PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, IsPersonAccount, CreatedDate), 
                                           dealer__Sales_Up__c (Id, Name, dealer__FirstName__c, dealer__LastName__c, dealer__Email__c, dealer__Mobile__c, dealer__Phone__c, dealer__Lead_Status__c, dealer__Salesperson_1__c, dealer__Lead_Date__c, dealer__Make__c, dealer__Model__c,dealer__Lead_Type__c),
                                           Contact(Id, Name) LIMIT 50];
        
        System.debug('SOSL[0] = '+soslResults[0]);
        searchUpsResults = (List<dealer__Sales_Up__c>)soslResults[1];

        //MKS 8/19/16
        //Remove Sales Ups from the list that are not the correct status, as dictated by the crm object field dealer__Duplicate_Check_Statuses__c
       
        String statusesComma = crm.dealer__Duplicate_Check_Statuses__c;
        if(statusesComma != null && statusesComma.length()>0){
            List<String> statuses = statusesComma.split(', ');
            Set<String> setStatuses = new Set<String>(statuses);
            List<dealer__Sales_Up__c> filteredSups = new List<dealer__Sales_Up__c>();

            for(Sales_Up__c  s: searchUpsResults){
                if(setStatuses.contains(s.dealer__Lead_Status__c))
                    filteredSups.add(s);
            } 
            searchUpsResults.clear();
            searchUpsResults = filteredSups;
            //end MKS 8/19/16
        }
        


        searchAccountResults = (List<Account>)soslResults[0];
        searchContactResults = (List<Contact>)soslResults[2];
    }

    @RemoteAction
    public static List<IdentityApi.caller> lookupCallerId(String sParam) {
        return IdentityApi.callerIdentification(sParam);
    }
}