/**
* Date            |Developer            |Work#
* Notes
* -----------------------------------------------------------------------
*
* 09-27-2016      |Gaurav               |Case - 00002084
* To disable create new deal button if current user is not having access to 'DMSDealCreate_EXT' controller class
* 09-29-2016      |Sneha                |Case - 00002084
* Use Utility Class for class access check
*/

public with sharing class SalesDeskLogV2 {
    
    public Integer soldCount {get;set;}
    public Integer feGross {get;set;}
    public Integer beGross {get;set;}
    public Integer totalGross {get;set;}
    public Integer soldMTD {get;set;}
    public Integer feMTD {get;set;}
    public Integer beMTD {get;set;}
    public Integer tgMTD {get;set;}
    
    public Integer walkinCount {get;set;}
    public Integer phoneCount {get;set;}
    public Integer emailCount {get;set;}
    public Integer faxCount {get;set;}
    public Integer listCount {get;set;}
    public Integer referralCount {get;set;}
    public Integer otherCount {get;set;}
    
    public Boolean walkInUps {get;set;}
    public Boolean phoneUps {get;set;}
    public Boolean emailUps {get;set;}
    public Boolean faxUps {get;set;}
    public Boolean otherUps {get;set;}
    public Boolean listUps {get;set;}
    public Boolean referralUps {get;set;}
    public Boolean setToTrue {get { return true; } set; }
    public Boolean setToFalse {get { return false; } set; }
    
    public String trafficType = null;

    public DateTime ds {get;set;}
    public DateTime de {get;set;}
    public Date rundate {get;set;}
    
    public String selectedDivision {get;set;}
    public String userFilterSOQL {get;set;}
    public String userDealFilterSOQL {get;set;}
    public String trafficFilterSOQL {get;set;}
    public String filterUserID {get;set;}
    public String filterUserType {get;set;} 
    public String filterInStore {get;set;}
    
    public User runningUser;
    public Event datePickerSup {get;set;}
    public dealer__DMS_Settings__c dms {get; private set;}
    public dealer__CRMSettings__c crm {get;set;}
    public dealer__SalesDeskLogSettings__c config {get;set;}
    
    public List<Id> dealKeys = new List<Id>();
    public List<Id> salesUpKeys = new List<Id>();
    
    public Map<Id, String> s1List = new Map<Id, String>();
    public Map<Id, String> s2List = new Map<Id, String>();
    public Map<Id, String> manager= new Map<Id, String>();
    public Map<Id, String> finance= new Map<Id, String>();
    public Map<String, String> companies = new Map<String, String>();
    
    public static List<deskLogEntry> deskEntries = new List<deskLogEntry>();
    
    public List<User> loggedInSalesAssociates {get;set;}
    public List<salesRotation> upBoard = new List<salesRotation>(); 
    public list<SelectOption> CategoriesList=new list<SelectOption>();
    
    public List<String> dlType = new List<String>();
    public List<String> dlStatus=new List<String>();
    
    //Case - 00002084 : Declaration of SetupEntityAccess List    
    public boolean enableCreateDeal{get;set;}
    
    public String systemLogEntry = '';
     
    public List<selectOption> getCategories(){
        CategoriesList.add(new selectOption('Test','Test'));
        return CategoriesList;
    }
         
    public SalesDeskLogV2() { 
        // Get DMS Defaults
        // 
        runningUser = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        crm = dealer__CRMSettings__c.getInstance();
        config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        
        System.debug('Here');
        // If Config has not been set, save and reload
        if(config==null) 
            logSettings();
        
        System.debug('There');
            
        // Get Deal Types, Status from the CRM Settings
        // set them to a list of strings.
        loadDealType();
        loadDealStatus();
        
        setSearchDates();
        
        // logSettings();
        
        setCompanyNumber();
        
        // Populate List of Users
        loadUserLists();
        
        // Get Traffic Filter SOQL
        //trafficFilter();        
        
        //generateLog();
        
        //Case - 00002084 : Checking access of 'DMSDealCreate_EXT' Controller for current user        
        enableCreateDeal = Utility.classAccess('DMSDealCreate_EXT');
    }
    
    public void loadDealType() {
        // R,L,...
        // dealer__Desk_Log_Deal_Types__c  
        if(crm.dealer__Desk_Log_Deal_Types__c==null) {
            crm.dealer__Desk_Log_Deal_Types__c='R,L';
        }
        dlType = crm.dealer__Desk_Log_Deal_Types__c.split(',');
    }
    
    public void loadDealStatus(){
        // dealer__Desk_Log_Deal_Status__c 
        if(crm.dealer__Desk_Log_Deal_Status__c==null) {
            crm.dealer__Desk_Log_Deal_Status__c='A,U';
        }
        dlStatus = crm.dealer__Desk_Log_Deal_Status__c.split(',');
    }
    
    public void loadUserLists() {
        List<User> userListBuild = [select Id, Name from User where IsActive=true order by FirstName ASC];
        for(User u : userListBuild) {
            if(!s1List.containsKey(u.Id)) { s1List.put(u.Id, u.Name); }
            if(!s2List.containsKey(u.Id)) { s2List.put(u.Id, u.Name); }
            if(!manager.containsKey(u.Id)) { manager.put(u.Id, u.Name); }
            if(!finance.containsKey(u.Id)) { finance.put(u.Id, u.Name); }              
        }
    }
    
    public string deskLogJSON() {
        generateLog();
        return JSON.serializePretty(deskEntries);
    }
    
    public string getDeskLogJSON() {
        return deskLogJSON();   
    }
    //<name>logSettings</name>
    //<summary>Hierarchy setting used to keep non-sesssion / cookie based memory of the log settings per user</summary>
    public void logSettings() {
        
        if(dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId())==null) {
            config =  new dealer__SalesDeskLogSettings__c();
            config.dealer__TrafficType__c = 'ALL';
            config.dealer__RunDate__c=Date.today();
            config.dealer__CompanyNumbers__c=runningUser.Division;
            config.dealer__WalkIns__c=true;
            config.dealer__EmailUps__c=true;
            config.dealer__PhoneUps__c=true;
            config.dealer__faxUps__c=true;
            config.dealer__listUps__c=true;
            config.dealer__ReferralUps__c=true;
            config.dealer__OtherUps__c=true;
        } else {
            config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId()); 
        }
        /* 
        // setTrafficType(config.dealer__TrafficType__c);
        rundate =config.dealer__RunDate__c;
        datePickerSup.Custom_Search_Start_Date__c=rundate;
        
        phoneUps=config.dealer__PhoneUps__c;
        emailUps=config.dealer__EmailUps__c;
        walkInUps=config.dealer__WalkIns__c;
        faxUps=config.dealer__faxUps__c;
        listUps=config.dealer__listUps__c;
        referralups=config.dealer__ReferralUps__c;
        otherUps=config.dealer__OtherUps__c;
        */
    }
    
    //<name>getTrafficTypes</name>
    //<summary>Create select option in the form of Radio Buttons of the Traffic Types defined by user configuration</summary>
    public List<SelectOption> getTrafficTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ALL', 'All'));
        //options.add(new SelectOption('STORE', 'Store Visit'));
        //options.add(new SelectOption('FRESH', 'Fresh Visits'));
        //options.add(new SelectOption('NOVISIT', 'Did Not Visit'));    
        options.add(new SelectOption('INSTORE', 'In Store Now'));
        return options;
    }
    
    public String getUserSettingsJSON() {
        dealer__SalesDeskLogSettings__c userSettings = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        return JSON.serialize(userSettings);
    }
    
    public String getTrafficType() {
        return trafficType;
    }
    
    public void setTrafficType(String trafficType) {
        this.trafficType = trafficType;
    }
    
    //<name>setCompanyNumber</name>
    //<sumarry>Build list of company numbers out of the Division field set by admin in Users list</summary>
    public void setCompanyNumber() {
        List<AggregateResult> uCompany = [select Division from User where Division != null group by Division limit 100];
        for(AggregateResult u : uCompany) {
            companies.put(String.valueOf(u.get('Division')), String.valueOf(u.get('Division')));
        }   
    }
    
    public Map<String, String> getCompanies() {
        return companies;
    }
    
    public Map<Id, String> getS1List() {
        return s1List;
    }
    
    public Map<Id, String> getS2List() {
        return s2List;
    }
    
    public Map<Id, String> getManager() {
        return manager;
    }
    
    public Map<Id, String> getFinance() {
        return finance;
    }
    
    //<name>generateDeskLog</name>
    //<summary>Build the desk log based on inputs, settings</summary>
    public PageReference generateDeskLog() {
        
        // Set running date based on Event Object
        rundate = datePickerSup.Custom_Search_Start_Date__c;
        
        // Get Traffic Filter SOQL
        trafficFilter();
        
        // Check the User Settings
        updateUserSettings();
                
        // Generate the Log
        
        generateLog();
        
        // If Sys log Even Save 
        /*
        if(this.systemLogEntry!='') {
            dealer__System_Log__c syslog = new dealer__System_Log__c(dealer__SOQL__c=this.systemLogEntry);
            insert syslog;  
        }   
        */
        System.debug('Generating Traffic Log '+runningUser.Division+' '+rundate);
        //System.debug(getTrafficType()); 
        return null;
    }
    
    //<name>updateUserSettings</name>
    //<summary>Save last run settings for this user so the next visit to the desk log will act the same.</summary>
    public void updateUserSettings() {
        if(config==null) {
            System.debug('Config is blank, creating ...');
            config = new dealer__SalesDeskLogSettings__c(
                SetupOwnerId=UserInfo.getUserId(),
                dealer__TrafficType__c=getTrafficType(),
                dealer__RunDate__c=rundate,
                dealer__CompanyNumbers__c=runningUser.Division 
            );
        } else {
            System.debug('Config exists');
            // config   = new dealer__SalesDeskLogSettings__c();
            config.SetupOwnerId=UserInfo.getUserId();
            config.dealer__TrafficType__c = this.getTrafficType();
            config.dealer__RunDate__c=this.rundate;
            config.dealer__CompanyNumbers__c=runningUser.Division;
            config.dealer__WalkIns__c=this.walkInUps;
            config.dealer__EmailUps__c=this.emailUps;
            config.dealer__PhoneUps__c=this.phoneUps;
            config.dealer__faxUps__c=this.faxUps;
            config.dealer__listUps__c=this.listUps;
            config.dealer__ReferralUps__c=this.ReferralUps;
            config.dealer__OtherUps__c=this.OtherUps;
        }
        
        try {
            Database.Upsertresult result = Database.upsert(config);
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
        }
    }   
    
    //<name>deskLogEntry</name>
    //<summary>Wrapper of the data amalgimated to create the combined desk log</summary>
    public class deskLogEntry {
        
        public dealer__Sales_Up__c salesUp {get;set;}
        public dealer__Deal__c deal {get;set;}
        public String cssClass {get;set;}
        public String entryType {get;set;}
        
        public deskLogEntry(dealer__Sales_Up__c up, dealer__Deal__c deals, String css, String t) {
            salesUp = up;
            deal = deals;
            cssClass = css;
            entryType = t;
        }
    }

    //<name></name>
    //<summary></summary>
    public void generateLog() {
        
        // Get Keys 
        itemKeys();
            
        // Clear Log
        deskEntries.clear();
                
        // All car deals, their child sales up
        Map<Id, dealer__Deal__c> deals = carDeals();
        
        // All Sales Up with no Deal Connected
        List<dealer__Sales_Up__c> ups = salesUps();
        
        for(dealer__Sales_Up__c s : ups) {
            if(deals.containsKey(s.dealer__Car_Deal__c)) {
                deskEntries.add(new deskLogEntry(s, deals.get(s.dealer__Car_Deal__c), 'combinedRows', 'COMBINED'));
                deals.remove(s.dealer__Car_Deal__c);
            } else {
                deskEntries.add(new deskLogEntry(s, null, 'leadRows', 'SALESUP'));  
            }
        }
        
        for(dealer__Deal__c cd : deals.values()) {
            deskEntries.add(new deskLogEntry(null, cd, 'dealRows', 'DEAL'));
        }
        
        sumOfSales();
        System.debug('S1 Size# '+s1list.size());
        System.debug('Generate Log Method Complete');
    }
    
    public List<deskLogEntry> getdeskEntries() {
        return deskEntries;
    }
    
    public class salesRotation {
        public User salesperson {get;set;}
        public dealer__Sales_Up__c salesup {get;set;}
       
        public salesRotation(User u, dealer__Sales_Up__c up) {
            salesperson = u;
            salesup = up;
        }
    }
    
    public List<salesRotation> getUpBoard() {
        //rotationLogGenerate();
        return upBoard;
    }       
    
    public PageReference dropActiveSalesperson() {
        User[] u = [Select Id, dealer__With_Customer__c from User where Id =:salespersonResetId limit 1];
        if(u.size()>0) {
            u[0].dealer__With_Customer__c=false;
            update u;
        }
        
        rotationLogGenerate();
        return null;
    }
    
    public String salespersonResetId {
        get;
        set {
            salespersonResetId = value;
        }
    }         
    
    //<name>itemKeys</name>
    //<summary>Retrieve keys of all records that are on the desk log run date</summary>
    public void itemKeys() {
        
        List<dealer__Deal__c> dealList = [Select Id from dealer__Deal__c 
                    where ( dealer__Deal_Date__c =:rundate 
                    or dealer__Deal_Close_Date__c =:rundate
                    or dealer__Lead_Date__c =:rundate ) 
                    and dealer__Deal_Type__c IN:dlType
                    and dealer__Status__c IN:dlStatus
                    and dealer__Company_Number__c =:runningUser.Division                      
                    limit 1000];
        
        System.debug('DealListSize : '+dealList.size());
        
        List<dealer__Sales_Up__c> salesUpList = [select Id from dealer__Sales_Up__c 
                       where ( dealer__Car_Deal_Date__c =:rundate 
                       or dealer__Lead_Date__c =:rundate 
                       or dealer__First_Visit_Date__c =:rundate 
                       or dealer__Last_Visit_Date__c =:rundate 
                       or dealer__Sale_Date__c =:rundate 
                       or dealer__Latest_Appointment_Date__c =:rundate)
                       and dealer__Company_Number__c =:runningUser.Division
                       limit 1000];
        
        System.debug('SalesUpListSize : '+salesUpList.size());
        
        for(dealer__Deal__c d : dealList) {
            dealKeys.add(d.Id);
        }
        for(dealer__Sales_Up__c s : salesUpList) {
            salesUpKeys.add(s.Id);
        }
        System.debug('DealKeysCount: ('+dealKeys.size()+') SalesUpCount: ('+salesUpKeys.size()+')');
    }
    
    //<name>carDeals</name>
    //<summary>Collect all car deals based on the parameters set forth by the user</summary>
    public Map<Id, dealer__Deal__c>  carDeals() {
        System.debug('RunDate' + rundate);
        String dealSOQL = 'Select d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, '+ 'd.dealer__Model__c, d.dealer__Make__c, dealer__Year__c, '+
                        'd.dealer__Sales_Lead__c, d.dealer__NUO__c, d.dealer__Front_End_Gross__c,  d.dealer__Salesperson_2__r.Name,  d.dealer__Salesperson_1__r.Name, '+
                        'd.dealer__Desk_Manager__c, d.dealer__Deal_Date__c, d.dealer__Company_Number__c, d.dealer__Co_Buyer_Last_Name__c, '+
                        'd.dealer__Desk_Manager__r.Name, d.dealer__F_I_Manager__c, d.dealer__F_I_Manager__r.Name, d.dealer__Stock_Number__c, d.dealer__Vehicle__c, '+
                        'd.dealer__Co_Buyer_First_Name__c, d.dealer__Buyer_Last_Name__c, d.dealer__Buyer_First_Name__c, d.dealer__Back_End_Gross__c, d.dealer__Total_Gross__c, '+
                        'd.CreatedBy.Name, d.LastModifiedBy.Name, ' + 
                        'd.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, d.Id, d.CreatedDate, d.CreatedById, d.dealer__Status__c, '+
                        'd.dealer__Buyer_Contact__c, d.dealer__Co_Buyer_Contact__c, d.dealer__Desk_Manager__r.SmallPhotoUrl,d.dealer__Deal_Type__c, '+
                        'd.dealer__Salesperson_1__r.SmallPhotoUrl, d.dealer__Salesperson_2__r.SmallPhotoUrl, '+
                        'd.dealer__F_I_Manager__r.SmallPhotoUrl, '+
                        'd.dealer__Buyer_Contact__r.Name, d.dealer__Co_Buyer_Contact__r.Name, '+
                        'd.dealer__Buyer_Contact__r.Email, d.dealer__Co_Buyer_Contact__r.Email, '+
                        'd.dealer__Buyer_Contact__r.MobilePhone, d.dealer__Co_Buyer_Contact__r.MobilePhone, '+
                        'd.dealer__Buyer_Contact__r.HomePhone, d.dealer__Co_Buyer_Contact__r.HomePhone, '+
                        'd.dealer__Buyer_Contact__r.OtherPhone, d.dealer__Co_Buyer_Contact__r.OtherPhone, '+
                            '(Select Id, Name, dealer__ACV__c, dealer__Stock_Number__c, dealer__Trade_Allowance__c From dealer__Trade_Ins__r)  '+
                        'From dealer__Deal__c d '+
                        'where d.Id IN :dealKeys order by d.LastModifiedDate desc limit 1000 ';
                
                // Check dynamic SOQL for Filters
                /* Filters now controlled in the UI
                if(this.userDealFilterSOQL!=null) {
                    dealSOQL += this.userDealFilterSOQL;
                }
                */     
        
        System.debug(dealSOQL);     
        
        List<dealer__Deal__c> dealList = Database.query(dealSOQL);
        Map<Id, dealer__Deal__c> deals = new Map<Id, dealer__Deal__c>();
        
        if(dealList.size()==0) {
            System.Debug('SOQL Size 0 for rundate '+rundate);
            return new Map<Id, dealer__Deal__c>();
        }
        
        for(dealer__Deal__c d : dealList) {
            deals.put(d.Id, d);
            // Check Salespersons List and Add as appropriate
            if(d.dealer__Salesperson_1__c != null) { if(!s1List.containsKey(d.dealer__Salesperson_1__c)) { s1List.put(d.dealer__Salesperson_1__c, d.dealer__Salesperson_1__r.Name); }}
            if(d.dealer__Salesperson_2__c != null) { if(!s2List.containsKey(d.dealer__Salesperson_2__c)) { s2List.put(d.dealer__Salesperson_2__c, d.dealer__Salesperson_2__r.Name); }}
            if(d.dealer__Desk_Manager__c != null) { if(!manager.containsKey(d.dealer__Desk_Manager__c)) { manager.put(d.dealer__Desk_Manager__c, d.dealer__Desk_Manager__r.Name); }}
            if(d.dealer__F_I_Manager__c != null) { if(!finance.containsKey(d.dealer__F_I_Manager__c)) { finance.put(d.dealer__F_I_Manager__c, d.dealer__F_I_Manager__r.Name); }}
        }       
        
        if(deals.size()>0) {
            return deals;
        } else {
            return new Map<Id, dealer__Deal__c>();
        }
    }
    
    //<name>salesUps</name>
    //<summary>Collect Sales Ups with no Deal Attached and any appointments parented by the Sales Up</summary>
    public List<dealer__Sales_Up__c> salesUps() {
        this.selectedDivision = runningUser.Division;
        Date todayDate= System.today();
        System.debug('RunDate' + rundate);
        String salesUpSOQL = 'Select d.dealer__vAuto_Appraisal_Link__c, d.dealer__Trade_Year__c, dealer__Latest_Appointment_Date__c,d.dealer__Trade_Model__c, d.dealer__Trade_Make__c, '+
                                'd.dealer__Source__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, d.dealer__Model__c, d.dealer__Make__c,'+
                                            'd.dealer__Lead_Type__c, d.dealer__Lead_Status__c, d.dealer__Lead_Date__c, d.dealer__Internet_Customer__c, '+
                                            'd.dealer__In_Store__c, d.dealer__Greet_Meet__c, d.dealer__First_Store_Visit_Date__c, d.dealer__Desk_Manager_User__c,'+
                                            'd.dealer__Desired_Stock_Num__c, '+

                                            'd.dealer__Desired_Stock_Num__r.dealer__Stock_Number__c, '+

                                            'd.dealer__Year_High__c, d.dealer__VIN__c,'+
                                            'd.dealer__Demo__c, d.dealer__Company_Number__c, d.dealer__Comments__c, d.dealer__Last_Visit_Date__c,'+
                                            'd.dealer__Co_Buyer_Contact__c, d.dealer__Buyer_Contact__c, d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, '+

                                             'd.CreatedBy.Name, d.LastModifiedBy.Name, ' +

                                            'd.LastActivityDate, d.Id, d.CreatedDate, d.CreatedById, d.dealer__Salesperson_1__r.Name, d.dealer__Salesperson_2__r.Name,'+
                                            'd.dealer__Desk_Manager_User__r.Name, d.dealer__Present_Vehicle__c, d.dealer__Write_Up__c, d.dealer__Car_Deal__c,'+
                                            'd.dealer__Last_Store_Visit_Date__c, d.dealer__Salesperson_1__r.SmallPhotoUrl, d.dealer__Salesperson_2__r.SmallPhotoUrl,'+
                                            'd.dealer__Desk_Manager_User__r.SmallPhotoUrl, ' +
                                            'd.dealer__Co_Buyer_Contact__r.Name,d.dealer__Buyer_Contact__r.Name, '+
                                            'd.dealer__Co_Buyer_Contact__r.Email,d.dealer__Buyer_Contact__r.Email, '+
                                            'd.dealer__Buyer_Contact__r.MobilePhone, d.dealer__Co_Buyer_Contact__r.MobilePhone, '+
                                            'd.dealer__Buyer_Contact__r.HomePhone, d.dealer__Co_Buyer_Contact__r.HomePhone, '+
                                            'd.dealer__Buyer_Contact__r.OtherPhone, d.dealer__Co_Buyer_Contact__r.OtherPhone, '+
                                            'd.dealer__F_I_Manager__c, d.dealer__F_I_Manager__r.SmallPhotoUrl, dealer__F_I_Manager__r.Name, '+
                                                '(Select Id, Name, dealer__Confirmed__c, dealer__Notes__c, '+
                                                    'dealer__Assigned_To__c, dealer__DateTime__c, dealer__Appointment_Result__c, dealer__Company_Number__c '+
                                            'From dealer__Sales_Appointments__r) '+
                                            'From dealer__Sales_Up__c d '+
                                            'where d.Id IN:salesUpKeys order by d.LastModifiedDate desc limit 1000';
                                            
        
        // Check dynamic SOQL for Filters
        /* Filters now controlled on the UI
        if(this.userFilterSOQL!=null) {
            salesUpSOQL += this.userFilterSOQL;
        }
        
        if(this.trafficFilterSOQL!=null) {
            salesUpSOQL += this.trafficFilterSOQL;
        }
        
        if(this.trafficType == 'INSTORE') {
            salesUpSOQL += ' and d.dealer__In_Store__c = true ';
        }
        */
        
        
        // Default Counts
        this.walkinCount =  0;
        this.emailCount =   0;
        this.phoneCount =   0;
        this.faxCount   =   0;
        this.ListCount  =   0;
        this.OtherCount =   0;
        this.referralCount  =   0;
        // System.debug('@@@@'+salesUpSOQL);                               
        List<dealer__Sales_Up__c> upList =  Database.query(salesUpSOQL);
        
        // Log System Event
        this.systemLogEntry = salesUpSOQL;
        
        if(upList.size()>0) {
            
            for(dealer__Sales_Up__c s : upList) {
                
                if(s.dealer__Salesperson_1__c != null) { if(!s1List.containsKey(s.dealer__Salesperson_1__c)) { s1List.put(s.dealer__Salesperson_1__c, s.dealer__Salesperson_1__r.Name); }}
                if(s.dealer__Salesperson_2__c != null) { if(!s2List.containsKey(s.dealer__Salesperson_2__c)) { s2List.put(s.dealer__Salesperson_2__c, s.dealer__Salesperson_2__r.Name); }}
                if(s.dealer__Desk_Manager_User__c != null) { if(!manager.containsKey(s.dealer__Desk_Manager_User__c)) { manager.put(s.dealer__Desk_Manager_User__c, s.dealer__Desk_Manager_User__r.Name); }}
                if(s.dealer__F_I_Manager__c != null) { if(!finance.containsKey(s.dealer__F_I_Manager__c)) { finance.put(s.dealer__F_I_Manager__c, s.dealer__F_I_Manager__r.Name); }}
        
                if(s.dealer__Lead_Type__c == 'Walk-In') { this.walkinCount++; }
                if(s.dealer__Lead_Type__c == 'Email') { this.emailCount++; }
                if(s.dealer__Lead_Type__c == 'Phone') { this.phoneCount++; }
                
                if(s.dealer__Lead_Type__c == 'Fax') { this.faxCount++; }
                if(s.dealer__Lead_Type__c == 'List') { this.listCount++; }
                if(s.dealer__Lead_Type__c == 'Other') { this.otherCount++; }
                if(s.dealer__Lead_Type__c == 'Referral') { this.referralCount++; }
            }
            
            return upList;
            
        } else {
            return new List<dealer__Sales_Up__c>();
        }                                           
    }
    
    //<name>setSearchDates</name>
    //<summary>Sets the default search dates, if no date is specified by the controller</summary>
    public void setSearchDates() {
        
        if(datePickerSup == null) {
            datePickerSup = new Event();
        }
        
        if(datePickerSup.dealer__Custom_Search_End_Date__c==null || datePickerSup.dealer__Custom_Search_Start_Date__c==null) {
            datePickerSup.dealer__Custom_Search_End_Date__c=Date.today();
            datePickerSup.dealer__Custom_Search_Start_Date__c=Date.today();
        }
        
        rundate = datePickerSup.dealer__Custom_Search_Start_Date__c;
        ds = DateTime.newInstance(rundate.year(), rundate.month(), rundate.day());
        de = DateTime.newInstance(rundate.year(), rundate.month(), rundate.day(), 23, 59, 59);
        
        if(ApexPages.currentPage().getParameters().get('d') != null && ApexPages.currentPage().getParameters().get('d') != '') {
            String dateString =  ApexPages.currentPage().getParameters().get('d');
            Date dateLiteral  =  Date.valueOf(dateString);
            rundate = dateLiteral;
        }
    }
    
    public void sumOfSales() {
        
        AggregateResult[] ss = [Select sum(dealer__Front_End_Gross__c) fe,
                                     sum(dealer__Back_End_Gross__c) be,
                                     sum(dealer__Total_Gross__c) tg,
                                     sum(dealer__ValueOfOne__c) cnt
                                     from dealer__Deal__c 
                                     where dealer__Company_Number__c =:runningUser.Division
                                     and ( dealer__Status__c = 'A' or dealer__Status__c = 'U' )
                                     and dealer__Deal_Date__c = THIS_MONTH];
                                     
        this.soldMTD    =   Integer.valueOf(ss[0].get('cnt'));
        this.feMTD      =   Integer.valueOf(ss[0].get('fe'));
        this.beMTD      =   Integer.valueOf(ss[0].get('be'));
        this.tgMTD      =   Integer.valueOf(ss[0].get('tg'));   
        
        AggregateResult[] st =  [Select sum(dealer__Front_End_Gross__c) fe,
                                     sum(dealer__Back_End_Gross__c) be,
                                     sum(dealer__Total_Gross__c) tg,
                                     sum(dealer__ValueOfOne__c) cnt
                                     from dealer__Deal__c 
                                     where dealer__Company_Number__c =:runningUser.Division
                                     and ( dealer__Status__c = 'A' or dealer__Status__c = 'U' )
                                     and dealer__Deal_Date__c =:rundate];
                                     
        this.feGross    =   Integer.valueOf(st[0].get('fe'));
        this.soldCount  =   Integer.valueOf(st[0].get('cnt'));
        this.beGross    =   Integer.valueOf(st[0].get('be'));
        this.totalGross =   Integer.valueOf(st[0].get('tg'));                        
    }
    
    // <name>userFilter</name>
    // <summary>Prepare the Dynamic SOQL based on the drop down li for Salesperson, Manager or Company Number</summary>
    public void userFilter() {
        if(this.filterUserID!=null && this.filterUserType!=null) {
            if(this.filterUserType=='S1') {
                this.userFilterSOQL = ' and dealer__Salesperson_1__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
                this.userDealFilterSOQL = ' and dealer__Salesperson_1__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
            } 
            
            if(this.filterUserType=='S2') {
                this.userFilterSOQL = ' and dealer__Salesperson_2__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
                this.userDealFilterSOQL = ' and dealer__Salesperson_2__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
            }
            
            if(this.filterUserType=='DM') {
                this.userFilterSOQL = ' and dealer__Desk_Manager_User__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
                this.userDealFilterSOQL = ' and dealer__Desk_Manager__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\''; 
            }
            
            if(this.filterUserType=='FM') {
                this.userFilterSOQL = ' and dealer__F_I_Manager__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\'';
                this.userDealFilterSOQL = ' and dealer__F_I_Manager__c = \''+String.escapeSingleQuotes(this.filterUserID)+'\''; 
            }
            
            if(this.filterUserType=='STORE') {
                this.selectedDivision = String.escapeSingleQuotes(this.filterUserID);
            }   
        }
        
        if(this.filterUserType == 'ALL') {
            this.userFilterSOQL = null;
            this.userDealFilterSOQL = null;
        }
        
        this.generateLog();
    }
    
    //<name>trafficFilter</name>
    //<summary>Filter traffic by the selected radio options</summary>
    public void trafficFilter() {
        this.trafficFilterSOQL  =   ' and (  ';
        
        if(this.walkInUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'Walk-In\' or dealer__Lead_Type__c = \'Walk In\' or ';
        
        if(this.emailUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'Email\' or ';
        
        if(this.phoneUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'Phone\' or '; 
        
        if(this.FaxUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'Fax\' or '; 
            
        if(this.ListUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'List\' or '; 
        if(this.OtherUps==true)
            this.trafficFilterSOQL += ' dealer__Lead_Type__c = \'Other\' or '; 
        if(this.referralUps==true) 
            this.trafficFilterSOQL += ' dealer__Source__c = \'Referral\' or';   
            
        this.trafficFilterSOQL = trafficFilterSOQL.substring(0, trafficFilterSOQL.length()-3);  
        this.trafficFilterSOQL += ' ) ';    
        
        
        
        
        // And Check for Referral
        
        
        
        System.debug(this.trafficFilterSOQL);
        
        this.generateLog();
    }
    
    public void rotationLogGenerate() {
        
        // Get Logged in Sales Associates
        upBoard.clear();
        
        
        loggedInSalesAssociates = [Select Id, Name, SmallPhotoUrl, dealer__With_Customer__c, LastLoginDate 
                                        from User 
                                        where LastLoginDate = TODAY
                                        And (Profile.Name like '%Salesperson%' 
                                                or Profile.Name like '%Sales Associate%'
                                                or Profile.Name like '%Administrator%')
                                        And Division =:runningUser.Division     
                                        limit 100];

        dealer__Sales_Up__c[] upList = [Select Id, Name, dealer__Salesperson_1__c 
                                        from dealer__Sales_Up__c 
                                        where dealer__Salesperson_1__c IN: loggedInSalesAssociates 
                                        and dealer__Lead_Date__c = TODAY
                                        and dealer__In_Store__c = true];
        
        Map<Id, dealer__Sales_Up__c> upMap = new Map<Id, dealer__Sales_Up__c>();
        for(dealer__Sales_Up__c loggedUp : upList) {
            upMap.put(loggedUp.dealer__Salesperson_1__c, loggedUp);
        }
        
        System.debug(loggedInSalesAssociates);
        
        for(User salesman : loggedInSalesAssociates) {
            upBoard.add(new salesRotation(salesman, upMap.get(salesman.Id)));
        }        
    }   
    
    @RemoteAction
    public static boolean updateUserSettingsRemote(String us) {
        // JSON Payload
        /*
            {
                dealer__RunDate__c : value,
                dealer__TrafficType__c : value
                ...
            }
        */
        
        // Parse JSON
        dealer__SalesDeskLogSettings__c userSettings = (dealer__SalesDeskLogSettings__c)JSON.deserialize(us, dealer__SalesDeskLogSettings__c.class);
        
        // Append ID to object if record exists.
        dealer__SalesDeskLogSettings__c config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(config!=null) {
            userSettings.Id = config.Id;
        }
        userSettings.SetupOwnerId = UserInfo.getUserId();   
        
        try {
            Database.Upsertresult result = Database.upsert(userSettings);
            return true;
        } catch(System.DMLException e) {
            System.debug(e);
            return false;
        }
        return true;
    }
    
    @RemoteAction 
    public static boolean updateInStore(String sid) {
        dealer__Sales_Up__c s = [Select Id, dealer__In_Store__c from dealer__Sales_Up__c where Id=:sid limit 1];
        if(s==null) {
            return false;
        }
        
        // Set Inverse
        if(s.dealer__In_Store__c == true) {
            s.dealer__In_Store__c=false;
        } else {
            s.dealer__In_Store__c=true;
        }
        
        update s;
        
        return true;
    }
    
    @RemoteAction
    public static boolean updateSalesStep(String idstep) {
        String[] s = idstep.split(':');
        
        if(s[0]==null || s[1]==null) {
            return false;
        }
        
        // Set checkbox
        dealer__Sales_Up__c up = [Select Id, dealer__Greet_Meet__c, dealer__Write_Up__c, dealer__Demo__c, dealer__Present_Vehicle__c  from dealer__Sales_Up__c where Id =:s[0] limit 1];
        if(s[1]=='dealer__Greet_Meet__c') {
            if(up.dealer__Greet_Meet__c==true) { 
                up.dealer__Greet_Meet__c = false; 
                update up;
                return true;
            } else {
                up.dealer__Greet_Meet__c = true;
                update up;
                return true;
            }
        }   
        
        if(s[1]=='dealer__Demo__c') {   
            if(up.dealer__Demo__c==true) { 
                up.dealer__Demo__c = false; 
                update up;
                return true;
            } else {
                up.dealer__Demo__c = true;
                update up;
                return true;
            }
        }
        
        if(s[1]=='dealer__Write_Up__c') {
            if(up.dealer__Write_Up__c==true) { 
                up.dealer__Write_Up__c = false; 
                update up;
                return true;
            } else {
                up.dealer__Write_Up__c = true;
                update up;
                return true;
            }           
        }
        
        if(s[1]=='dealer__Present_Vehicle__c') {
            if(up.dealer__Present_Vehicle__c==true) { 
                up.dealer__Present_Vehicle__c = false; 
                update up;
                return true;
            } else {
                up.dealer__Present_Vehicle__c = true;
                update up;
                return true;
            }           
        }       
        
        return false;
    }
    
    @RemoteAction
    public static boolean setAppointmentStatus(String sidStat) {
        String[] s = sidStat.split(':');
        
        if(s[0]==null || s[1]==null) {
            return false;
        }
        
        dealer__Sales_Appointment__c sa = [Select Id, dealer__Appointment_Result__c,dealer__Sales_Up__c from dealer__Sales_Appointment__c where Id =:s[0] limit 1];
        
        if(sa==null) {
            return false;
        }
        
        if(s[1]=='Show') {
            sa.dealer__Appointment_Result__c = 'Show';
            update sa;
            return true;
            
        } else if(s[1]=='No-Show') {
            sa.dealer__Appointment_Result__c = 'No-Show';
            update sa;
            return true;
        }
        
        return false;
    }

    // Update Team Member (Accepts rIDtIDtKey = record_ID,team_member_ID,team_member_key ) 
    @RemoteAction
    public static boolean setTeamMemberDeal(String rIDtIDtKey) {
        String[] s = rIDtIDtKey.split(':');
        
        if(s[0]==null || s[1]==null || s[2]==null) {
            return false;
        }

        // s[0] = record_id
        // s[1] = team_member_id
        // s[2] = team_member_key

        // Possible Keys (s1, s2, dm, fi?)
        // DR
        dealer__Deal__c d = [Select Id, dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Desk_Manager__c, dealer__F_I_Manager__c  from dealer__Deal__c where Id =:s[0] limit 1];
        system.debug('Deal >>'+d);
        if(s[2]=='s1'){

            d.dealer__Salesperson_1__c = s[1];
            system.debug('Deal >>'+s[1]+d);
            update d;

            return true;

        } else if(s[2]=='s2'){

            d.dealer__Salesperson_2__c = s[1];
            update d;
            
            return true;

        } else if(s[2]=='dm') {

            d.dealer__Desk_Manager__c = s[1];
            update d;
            
            return true;

        } else if(s[2]=='fi') {

            d.dealer__F_I_Manager__c = s[1];
            update d;
            
            return true;

        } else {
            return false;
        }

        return false;
    }

    // Update Team Member (Accepts rIDtIDtKey = record_ID,team_member_ID,team_member_key ) 
    @RemoteAction
    public static boolean setTeamMemberSalesUp(String rIDtIDtKey) {
        String[] s = rIDtIDtKey.split(':');
        
        if(s[0]==null || s[1]==null || s[2]==null) {
            return false;
        }

        // s[0] = record_id
        // s[1] = team_member_id
        // s[2] = team_member_key

        // Possible Keys (s1, s2, dm, fi?)
        // DR
        dealer__Sales_Up__c d = [Select Id, dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Desk_Manager__c, dealer__F_I_Manager__c  from dealer__Sales_Up__c where Id =:s[0] limit 1];

        if(s[2]=='s1'){

            d.dealer__Salesperson_1__c = s[1];
            update d;

            return true;

        } else if(s[2]=='s2'){

            d.dealer__Salesperson_2__c = s[1];
            update d;
            
            return true;

        } else if(s[2]=='dm') {

            d.dealer__Desk_Manager_User__c = s[1];
            update d;
            
            return true;

        } else if(s[2]=='fi') {

            d.dealer__F_I_Manager__c = s[1];
            update d;
            
            return true;

        } else {
            return false;
        }
                           
        return false;
    }
}