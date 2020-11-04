global with sharing class DeskLog_EXT {
    
    private final List<dealer__Traffic_Log__c> trafficLog;
    
    public List<deskEntry> deskEntries = new list<deskEntry>();
    public Map<Id, String> s1List = new Map<Id, String>();
    public Map<Id, String> s2List = new Map<Id, String>();
    public Map<Id, String> manager= new Map<Id, String>();
        
    public DateTime ds {get;set;}
    public DateTime de {get;set;}
    public Date d {get;set;}
    public boolean filterLeads {get; set;}
    public boolean filterTraffic {get; set;}
    public boolean filterAppointments {get; set;}
    public boolean filterDeals {get; set;}
    public boolean filterInStore {get;set;}
    
    public Decimal frontEndGross {get;set;}
    public Decimal backEndGross {get;set;}
    public Decimal totalGross {get { return backEndGross + frontEndGross; } private set; }
    public Integer trafficCount {get;set;}
    public Integer leadcount {get;set;}
    public Integer apptCount {get;set;}
    public Integer dealCount {get;set;}
    
    public String filterUserID {get;set;}
    public String filterUserType {get;set;}
    
    public List<User> loggedInSalesAssociates {get;set;}
    public List<salesRotation> upBoard = new List<salesRotation>();
    public String CompanyNumber{get;set;}
    public String CompanyNumber1{get;set;}
    
    public String activeDivision {get;set;}
    
    public List<SelectOption> getCompanyNumbers()
    {
        List<SelectOption> ComNumbers = new List<SelectOption>();
        ComNumbers.add(new selectOption('--None--','--None--'));
        ComNumbers.add(new selectOption('Location 1','Location 1'));
        ComNumbers.add(new selectOption('Location 2','Location 2'));
        return ComNumbers;    
    }
    
    Event datePickerSup = new Event();
    
    public Event getProxyDate() { 
        if(datePickerSup.dealer__Custom_Search_End_Date__c==null || datePickerSup.dealer__Custom_Search_Start_Date__c==null) {
            datePickerSup.dealer__Custom_Search_End_Date__c=Date.today();
            datePickerSup.dealer__Custom_Search_Start_Date__c=Date.today();
        }
        return datePickerSup; 
    }   
    
    public String salespersonResetId {
        get;
        set {
            salespersonResetId = value;
        }
    }
    
    public void setProxyDate(Event datePickerSup) {
        this.datePickerSup = datePickerSup;
    }
    
    public void setSearchDates() {
        d = datePickerSup.dealer__Custom_Search_Start_Date__c;
        ds = DateTime.newInstance(d.year(), d.month(), d.day());
        de = DateTime.newInstance(d.year(), d.month(), d.day(), 23, 59, 59);
    }
    
    public DeskLog_EXT(ApexPages.standardSetController s) {
        clearCache();
        
        User runningUser = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
        this.activeDivision = runningUser.Division;
        
        this.trafficLog = s.getSelected();
        this.filterAppointments=true;
        this.filterDeals=true;
        this.filterLeads=true;
        this.filterTraffic=true;
        this.filterInStore=false;
        getProxyDate();
        generateDeskLog();
        rotationLogGenerate();
    }
    
    public void rotationLogGenerate() {
        // Get Logged in Sales Associates
        upBoard.clear();
        
        // Code changed as Record Sharing settings the prefered way of exposing or hiding this data.
        /*
        String COmpanyCondition;
        if(Companynumber1!=null && Companynumber1!='--None--'){
            System.debug('>>>>1'+Companynumber1);
             COmpanyCondition=' And Division=:Companynumber1 ';
        }

        String QueryString='Select Id, Name, SmallPhotoUrl, dealer__With_Customer__c, LastLoginDate '+
                                        'from User '+
                                        'where LastLoginDate = TODAY '+
                                        'And (Profile.Name like \'%Salesperson%\' '+
                                        'or Profile.Name like \'%Sales Associate%\' '+
                                        'or Profile.Name like \'%Administrator%\')';
         
         if(COmpanyCondition!=null){
         QueryString=QueryString+COmpanyCondition;
         }
         QueryString=QueryString+'limit 100';
        loggedInSalesAssociates = database.query(QueryString); 
        */
        
        
        loggedInSalesAssociates = [Select Id, Name, SmallPhotoUrl, dealer__With_Customer__c, LastLoginDate 
                                        from User 
                                        where LastLoginDate = TODAY
                                        And (Profile.Name like '%Salesperson%' 
                                                or Profile.Name like '%Sales Associate%'
                                                or Profile.Name like '%Administrator%')
                                        And Division =:activeDivision   
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
    
    public PageReference dropActiveSalesperson() {
        User[] u = [Select Id, dealer__With_Customer__c from User where Id =:salespersonResetId limit 1];
        if(u.size()>0) {
            u[0].dealer__With_Customer__c=false;
            update u;
        }
        
        rotationLogGenerate();
        return null;
    }
    
    public Map<Id, String> getS1List() {
        return s1List;
    }
    
    public Map<Id, String> getS2List() {
        return s2List;
    }
    
    public Map<Id, String> getManager() {
        String removed = manager.remove(null);
        return manager; 
    }
    
    public List<salesRotation> getUpBoard() {
        return upBoard;
    }
    
    public void clearCache() {
        this.frontEndGross=0;
        this.backEndGross=0;
        this.leadcount=0;
        this.trafficCount=0;
        this.apptCount=0;
        this.dealCount=0;
        this.deskEntries.clear();       
    }
    
    public PageReference generateDeskLog() {
        clearCache();
        setSearchDates();
        
        if(filterTraffic  && filterInStore==false) { trafficItems(); }
        if(filterLeads) { leadItems(); }
        if(filterAppointments && filterInStore==false) { apptItems(); }
        if(filterDeals && filterInStore==false) { dealItems(); }
        
        /*
        if(filterInStore==true) {
            leadItems();
            Integer i = 0;
            List<Integer> rids = new List<Integer>();
            for(deskEntry myDeskEntries : deskEntries) {
                if(myDeskEntries.up.dealer__In_Store__c==false) {
                    rids.add(i);
                }
                i++;
            }
            
            if(rids.size()>0){
                System.debug(rids.size()+' '+deskEntries.size());
                System.debug(deskEntries);
                for(Integer r = 0; r <= rids.size(); r++) {
                    System.debug('Removing '+r);
                    System.debug(deskEntries[r]);
                    if(!deskEntries.isEmpty()) { 
                        deskEntries.remove(r);
                    }
                }
            }
        }
        */
        
        return null;
    }
    
    public List<deskEntry> getDeskEntries() {
        return sortByDate(deskEntries, 'Asc');
    }
    
    public class deskEntry {
        
        public String deskEntryType {get;set;}
        public Datetime eventDateTime {get;set;}
        public String localDateTime {get;set;}
        public dealer__Traffic_Log__c traffic {get;set;}
        public dealer__Sales_Up__c up {get;set;}
        public dealer__Sales_Appointment__c appt {get;set;}
        public dealer__Deal__c deal {get;set;}
    
        public deskEntry(String dt, DateTime e, String lt, dealer__Traffic_Log__c t, dealer__Sales_Up__c u, dealer__Sales_Appointment__c a, dealer__Deal__c d) {

                    deskEntryType   =   dt;
                    eventDateTime   =   e;
                    localDateTime   =   e.format();
                    traffic         =   t;  
                    up              =   u;
                    appt            =   a;
                    deal            =   d;
        }
    }
    
    public class salesRotation {
        public User salesperson {get;set;}
        public dealer__Sales_Up__c salesup {get;set;}
       
        public salesRotation(User u, dealer__Sales_Up__c up) {
            salesperson = u;
            salesup = up;
        }
    }
    
    public void trafficItems() {
        System.debug('Gathering Traffic');
        
        System.debug(ds+' - '+de);
        
        list<dealer__Traffic_Log__c> tl = new list<dealer__Traffic_Log__c>();
        
        tl = [Select d.dealer__Write_Up__c, d.dealer__Type__c, d.dealer__Traffic_Notes__c, d.dealer__Split_Deals_Count__c, d.dealer__Source__c, 
                                                    d.dealer__Sold__c, d.dealer__Shopper__c,
                                                    d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, d.dealer__Sales_Lead__c, d.dealer__On_Demo__c, 
                                                    d.dealer__Location__c, d.dealer__Last_Name__c, d.dealer__Is_New_Up__c, d.dealer__In_Store__c, d.dealer__First_Name__c, 
                                                    d.dealer__Date_In__c, d.dealer__Data_Capture_Rate__c, d.dealer__Customer_Name__c, d.dealer__Customer_Contact__c, 
                                                    d.dealer__Company_Number__c, d.dealer__CCC_Rep__c, d.SystemModstamp, d.OwnerId, d.Name, d.LastModifiedDate, 
                                                    d.LastModifiedById, d.LastActivityDate, d.IsDeleted, d.Id, d.CreatedDate, d.CreatedById, d.dealer__Salesperson_1__r.ManagerId,
                                                    d.dealer__Caller_Id_FirstName__c, d.dealer__Caller_Id_LastName__c, d.dealer__Calling_Number__c, d.dealer__Call_Profile_Link__c,
                                                    d.dealer__Call_Termination_Cause__c, d.dealer__Conversation_Start__c, d.dealer__Conversation_End__c,
                                                    d.dealer__Salesperson_1__r.Name, d.dealer__Salesperson_2__r.Name
                                                From dealer__Traffic_Log__c d
                                                Where d.dealer__Date_In__c >= :ds
                                                And d.dealer__Date_In__c <= :de
                                                And d.dealer__Fresh_Call__c = true
                                                And d.dealer__Sales_Lead__c = null
                                                And d.dealer__Company_Number__c = :activeDivision
                                                limit 500];
        System.debug('Traffic Results '+tl.size()); 
        Set<String> phoneList = new Set<String>();
        
        if(tl.size()>0) {
            for(dealer__Traffic_Log__c t : tl) {
                // Add Filter Lists
                
                if(t.dealer__Type__c=='Phone' && !phoneList.contains(t.dealer__Calling_Number__c)) {
                    this.trafficCount++;
                    phoneList.add(t.dealer__Calling_Number__c);
                }
                
                if(!s1List.containsKey(t.dealer__Salesperson_1__c)) { s1List.put(t.dealer__Salesperson_1__c, t.dealer__Salesperson_1__r.Name); }
                if(!s2List.containsKey(t.dealer__Salesperson_2__c)) { s2List.put(t.dealer__Salesperson_2__c, t.dealer__Salesperson_2__r.Name); }
                //if(!manager.contains(t.dealer__Salesperson_1__r.ManagerId)) { manager.add(t.dealer__Salesperson_1__r.ManagerId); }
                deskEntries.add(new deskEntry('Traffic', t.CreatedDate, '', t, null, null, null));
                 
            }
        }                                   
    }
    
    public void leadItems() {
        System.debug('InStore Only'+this.filterInStore);
        DateTime lvS = DateTime.newInstance(d.year(), d.month(), d.day(), 0, 0, 0);
        DateTime lvE = DateTime.newInstance(d.year(), d.month(), d.day(), 23, 59, 59);
       
     list<dealer__Sales_Up__c> ups = [Select Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                                SystemModstamp, LastActivityDate, dealer__ADF_File_Name__c, dealer__Car_Deal__c, dealer__Co_Buyer__c, 
                                                                dealer__Color_Preference_Ext__c, dealer__Color_Preference_Int__c, dealer__Comments__c, 
                                                                dealer__Cost_of_Lead__c, dealer__Customer_Account__c, dealer__Demo__c, dealer__Desired_Stock_Num__c, 
                                                                dealer__Desk_Manager__c, dealer__Follow_Up__c, dealer__Greet_Meet__c, dealer__Internet_Customer__c, 
                                                                dealer__Lead_Status__c, dealer__Lead_Type__c, dealer__Make__c, dealer__Model__c, dealer__NUO__c, 
                                                                dealer__Present_Vehicle__c, dealer__Price_High__c, dealer__Price_Low__c, dealer__Sale_Date__c, 
                                                                dealer__Shopper__c, dealer__Source__c, dealer__Trade_Comments__c, dealer__Trade_Make__c, dealer__Trade_Mileage__c, 
                                                                dealer__Trade_Model__c, dealer__Trade_VIN__c, dealer__Trade_Year__c, dealer__Traffic_Log_Entry__c, 
                                                                dealer__Transmission__c, dealer__Trim__c, dealer__Write_Up__c, dealer__Year_High__c, dealer__Year_To__c, 
                                                                dealer__Buyer_Contact__c, dealer__Buyer_Contact__r.Name,
                                                                dealer__Co_Buyer_Contact__c, dealer__Salesperson_1__r.Name, dealer__Salesperson_2__r.Name, 
                                                                dealer__CCC_Rep__c, dealer__Desk_Manager_User__c, dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Buy_or_Lease__c, 
                                                                dealer__VIN__c, dealer__Lead_Origination_Service__c, dealer__Finance_Method__c, dealer__Internet_Lead_Request_Time__c, 
                                                                dealer__Timeframe__c, dealer__Company_Number__c, dealer__Assign_Follow_Up_To__c, dealer__Managers_Note__c, dealer__Response_Time__c, 
                                                                dealer__Lead_Date__c, dealer__Desired_Monthly_Payment__c, dealer__Pre_qualified_Loan_Amount__c, dealer__FirstName__c, 
                                                                dealer__LastName__c, dealer__Phone__c, dealer__Mobile__c, dealer__Email__c, dealer__Trade_Trim_Level__c, 
                                                                dealer__Is_Open__c, dealer__Current_Monthly_Payment__c, dealer__Event_Driven_Lead__c, dealer__Team_Leader__c,
                                                                dealer__Desk_Manager_User__r.Name, dealer__In_Store__c, dealer__Last_Store_Visit_Date__c
                                                            From dealer__Sales_Up__c
                                                            where ( dealer__Lead_Date__c =:d or 
                                                                (
                                                                    dealer__Last_Store_Visit_Date__c >= :lvS
                                                                    and dealer__Last_Store_Visit_Date__c <= :lvE
                                                                )
                                                            )
                                                            And dealer__Lead_Status__c!='Duplicate'
                                                            And dealer__Company_Number__c =:activeDivision
                                                            limit 500];
                                                            
        if(this.filterInStore==true) {
            System.debug('InStore Only');
            ups.clear();
            ups = [Select Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
                                                                SystemModstamp, LastActivityDate, dealer__ADF_File_Name__c, dealer__Car_Deal__c, dealer__Co_Buyer__c, 
                                                                dealer__Color_Preference_Ext__c, dealer__Color_Preference_Int__c, dealer__Comments__c, 
                                                                dealer__Cost_of_Lead__c, dealer__Customer_Account__c, dealer__Demo__c, dealer__Desired_Stock_Num__c, 
                                                                dealer__Desk_Manager__c, dealer__Follow_Up__c, dealer__Greet_Meet__c, dealer__Internet_Customer__c, 
                                                                dealer__Lead_Status__c, dealer__Lead_Type__c, dealer__Make__c, dealer__Model__c, dealer__NUO__c, 
                                                                dealer__Present_Vehicle__c, dealer__Price_High__c, dealer__Price_Low__c, dealer__Sale_Date__c, 
                                                                dealer__Shopper__c, dealer__Source__c, dealer__Trade_Comments__c, dealer__Trade_Make__c, dealer__Trade_Mileage__c, 
                                                                dealer__Trade_Model__c, dealer__Trade_VIN__c, dealer__Trade_Year__c, dealer__Traffic_Log_Entry__c, 
                                                                dealer__Transmission__c, dealer__Trim__c, dealer__Write_Up__c, dealer__Year_High__c, dealer__Year_To__c, 
                                                                dealer__Buyer_Contact__c, dealer__Buyer_Contact__r.Name,
                                                                dealer__Co_Buyer_Contact__c, dealer__Salesperson_1__r.Name, dealer__Salesperson_2__r.Name, 
                                                                dealer__CCC_Rep__c, dealer__Desk_Manager_User__c, dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Buy_or_Lease__c, 
                                                                dealer__VIN__c, dealer__Lead_Origination_Service__c, dealer__Finance_Method__c, dealer__Internet_Lead_Request_Time__c, 
                                                                dealer__Timeframe__c, dealer__Company_Number__c, dealer__Assign_Follow_Up_To__c, dealer__Managers_Note__c, dealer__Response_Time__c, 
                                                                dealer__Lead_Date__c, dealer__Desired_Monthly_Payment__c, dealer__Pre_qualified_Loan_Amount__c, dealer__FirstName__c, 
                                                                dealer__LastName__c, dealer__Phone__c, dealer__Mobile__c, dealer__Email__c, dealer__Trade_Trim_Level__c, 
                                                                dealer__Is_Open__c, dealer__Current_Monthly_Payment__c, dealer__Event_Driven_Lead__c, dealer__Team_Leader__c,
                                                                dealer__Desk_Manager_User__r.Name, dealer__In_Store__c 
                                                            From dealer__Sales_Up__c
                                                            where ( dealer__Lead_Date__c =:d or 
                                                                (
                                                                    dealer__Last_Store_Visit_Date__c >= :lvS
                                                                    and dealer__Last_Store_Visit_Date__c <= :lvE
                                                                )
                                                            )
                                                            And dealer__In_Store__c = true
                                                            And dealer__Company_Number__c =:activeDivision
                                                            limit 500];         
        }                                                   
                                                            
        System.debug('Up Results '+ups.size());                                     
        if(ups.size()>0) {
            for(dealer__Sales_Up__c u : ups) {
                this.leadcount++;
                if(!s1List.containsKey(u.dealer__Salesperson_1__c)) { s1List.put(u.dealer__Salesperson_1__c, u.dealer__Salesperson_1__r.Name); }
                if(!s2List.containsKey(u.dealer__Salesperson_1__c)) { s2List.put(u.dealer__Salesperson_2__c, u.dealer__Salesperson_2__r.Name); }
                if(!(manager.containsKey(u.dealer__Desk_Manager_User__c) && u.dealer__Desk_Manager_User__c!=null)) { 
                        manager.put(u.dealer__Desk_Manager_User__c, u.dealer__Desk_Manager_User__r.Name); 
                }
                
                deskEntries.add(new deskEntry('Sales Up', u.CreatedDate, '', null, u, null, null));
                
                
            }
        }                                                               
                                                                
    }
    
    public void dealItems() {
        
        /*
        String COmpanyCondition;
        if(Companynumber!='--None--'){
            System.debug('>>>>1'+Companynumber);
             COmpanyCondition=' And dealer__Company_number__c=:Companynumber ';
        }
        String QueryString='Select d.dealer__Vehicle__c, d.dealer__Stock_Number__c, d.dealer__Status__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c,'+
                            'd.dealer__NUO__c, d.dealer__Internet_Customer__c, d.dealer__Front_End_Gross__c, d.dealer__F_I_Manager__c,'+
                                                'd.dealer__Desk_Manager__c, d.dealer__Deal_Type__c, d.dealer__Deal_ID__c, d.dealer__Deal_Date__c, d.dealer__Deal_Category__c, '+
                                                'dealer__Company_Number__c,d.dealer__Co_Buyer_Last_Name__c, d.dealer__Co_Buyer_First_Name__c, d.dealer__Co_Buyer_Contact__c, d.dealer__Buyer_Last_Name__c, '+
                                                'd.dealer__Buyer_First_Name__c, d.dealer__Buyer_Email__c, d.dealer__Buyer_Contact__c, d.dealer__Back_End_Gross__c, d.OwnerId, '+
                                                'd.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, d.CreatedDate, d.CreatedById, '+
                                                'd.dealer__Salesperson_2__r.Name, d.dealer__Salesperson_1__r.Name, d.dealer__Desk_Manager__r.Name, '+
                                                '(Select Id, Name, dealer__Stock_Number__c from dealer__Trade_Ins__r) '+
                                                'From dealer__Deal__c d '+
                                                'where d.dealer__Deal_Date__c =:d ';
                                                
                                                
        if(COmpanyCondition!=null) QueryString=QueryString+COmpanyCondition;
        QueryString=QueryString+'limit 500';
        list<dealer__Deal__c> deals=database.query(QueryString);                                        
        */
        
                            
        list<dealer__Deal__c> deals = [Select d.dealer__Vehicle__c, d.dealer__Stock_Number__c, d.dealer__Status__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, 
                                                d.dealer__NUO__c, d.dealer__Internet_Customer__c, d.dealer__Front_End_Gross__c, d.dealer__F_I_Manager__c, dealer__Company_Number__c,
                                                d.dealer__Desk_Manager__c, d.dealer__Deal_Type__c, d.dealer__Deal_ID__c, d.dealer__Deal_Date__c, d.dealer__Deal_Category__c, 
                                                d.dealer__Co_Buyer_Last_Name__c, d.dealer__Co_Buyer_First_Name__c, d.dealer__Co_Buyer_Contact__c, d.dealer__Buyer_Last_Name__c, 
                                                d.dealer__Buyer_First_Name__c, d.dealer__Buyer_Email__c, d.dealer__Buyer_Contact__c, d.dealer__Back_End_Gross__c, d.OwnerId, 
                                                d.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, d.CreatedDate, d.CreatedById,
                                                d.dealer__Salesperson_2__r.Name, d.dealer__Salesperson_1__r.Name, d.dealer__Desk_Manager__r.Name,
                                                    (Select Id, Name, dealer__Stock_Number__c from dealer__Trade_Ins__r)
                                        From dealer__Deal__c d
                                        where d.dealer__Deal_Date__c =:d
                                        And d.dealer__Company_Number__c =:activeDivision
                                        limit 500];
                                        
        if(deals.size()>0) {
            for(dealer__Deal__c d : deals) {
                this.dealCount++;
                if(d.dealer__Status__c=='A'||d.dealer__Status__c=='U'||d.dealer__Status__c=='C') { // Accepted & Capped 
                    this.frontEndGross+=d.dealer__Front_End_Gross__c;
                    this.backEndGross+=d.dealer__Back_End_Gross__c;
                }
                if(!s1List.containsKey(d.dealer__Salesperson_1__c)) { s1List.put(d.dealer__Salesperson_1__c, d.dealer__Salesperson_1__r.Name); }
                if(!s1List.containsKey(d.dealer__Salesperson_1__c)) { s1List.put(d.dealer__Salesperson_1__c, d.dealer__Salesperson_2__r.Name); }
                if(!(manager.containsKey(d.dealer__Desk_Manager__c) && d.dealer__Desk_Manager__c!=null)) { 
                        manager.put(d.dealer__Desk_Manager__c, d.dealer__Desk_Manager__r.Name); 
                }
                deskEntries.add(new deskEntry('Deal', d.dealer__Deal_Date__c, '', null, null, null, d));
            }
        }                               
    }
    
    public void apptItems() {
        list<dealer__Sales_Appointment__c> appts = [Select d.dealer__Vehicle__c, d.dealer__Time__c, d.dealer__Set_By__c, d.dealer__Sales_Up__c, d.dealer__Notes__c, d.dealer__Date__c, 
                                                            d.dealer__Customer__c, d.dealer__Confirmed__c, d.dealer__Assigned_To__c, d.OwnerId, d.Name, d.LastModifiedDate, 
                                                            d.LastModifiedById, d.LastActivityDate, d.Id, d.CreatedDate, d.CreatedById, d.dealer__DateTime__c,
                                                            d.dealer__Assigned_To__r.Name 
                                                    From dealer__Sales_Appointment__c d
                                                    where d.dealer__Date__c = :d
                                                    and d.dealer__Company_Number__c =:activeDivision
                                                    limit 500];
        
        if(appts.size()>0) {
            for(dealer__Sales_Appointment__c a : appts) {
                this.apptCount++;
                if(!s1List.containsKey(a.dealer__Assigned_To__c)) { s1List.put(a.dealer__Assigned_To__c, a.dealer__Assigned_To__r.Name); }
                deskEntries.add(new deskEntry('Appointment', a.dealer__DateTime__c, '', null, null, a, null));
            }
        }
    }
    
    public static list<deskEntry> sortByDate(list<deskEntry> wrapperObject,String sortingOrder) {
        if(wrapperObject == null || wrapperObject.size() <= 1){
            return wrapperObject ;
        }
        List<deskEntry> lessSelectOption = new List<deskEntry>();
        List<deskEntry> greaterSelectOption = new List<deskEntry>();
        integer pivot = wrapperObject.size() / 2;
        
        //save the pivot and remove it from the wrapper list
        deskEntry pivotValue = wrapperObject[pivot];
        wrapperObject.remove(pivot);        
        for(deskEntry SO : wrapperObject){
            if(sortingOrder == 'Desc'){
                if(SO.eventDateTime > pivotValue.eventDateTime){
                    lessSelectOption.add(SO);
                }else if(SO.eventDateTime <= pivotValue.eventDateTime){
                    greaterSelectOption.add(SO);   
                }
            }else{
                if(SO.eventDateTime <= pivotValue.eventDateTime){
                    lessSelectOption.add(SO);
                }else if(SO.eventDateTime > pivotValue.eventDateTime){
                    greaterSelectOption.add(SO);   
                }
            }
        }
        list<deskEntry> sortedSelectOptions = new list<deskEntry>(); 
        sortedSelectOptions.addAll(sortByDate(lessSelectOption,'Desc'));
        sortedSelectOptions.add(pivotValue);
        sortedSelectOptions.addAll(sortByDate(greaterSelectOption,'Desc'));
        return SortedSelectOptions;
    }
    
    public void activateFilter() {
        System.debug('>>>>>>'+CompanyNumber+''+filterLeads+' '+filterTraffic+' '+this.filterDeals+' '+this.filterDeals);
        System.debug(datePickerSup);
        generateDeskLog();
    }
    
    public void userFilter() {
        System.debug(filterUserID+' '+filterUserType);
        // filter out existing Array
        generateDeskLog();
        List<deskEntry> filteredEntries = new List<deskEntry>();
        
            for(deskEntry d : deskEntries) {
                // Lead Filter
                System.debug('Looping'+d.deskEntryType);
                if(d.deskEntryType=='Sales Up') {
                    System.debug(d.up.dealer__Salesperson_1__c);
                    if(d.up.dealer__Salesperson_1__c==filterUserId && filterUserType=='S1') {
                        filteredEntries.add(d);
                    }
                    if(d.up.dealer__Salesperson_2__c==filterUserId && filterUserType=='S2') {
                        filteredEntries.add(d);
                    }
                    if(d.up.dealer__Desk_Manager_User__c==filterUserId && filterUserType=='SM') {
                        filteredEntries.add(d);
                    }                   
                }
                // Traffic Fitler
                if(d.deskEntryType=='Traffic') {
                    if(d.traffic.dealer__Salesperson_1__c==filterUserId && filterUserType=='S1') {
                        filteredEntries.add(d);
                    }
                    if(d.traffic.dealer__Salesperson_2__c==filterUserId && filterUserType=='S2') {
                        filteredEntries.add(d);
                    }
                }
                
                // Car Deals
                if(d.deskEntryType=='Deal') {
                    if(d.deal.dealer__Salesperson_1__c==filterUserId && filterUserType=='S1') {
                        filteredEntries.add(d);
                    }
                    if(d.deal.dealer__Salesperson_2__c==filterUserId && filterUserType=='S2') {
                        filteredEntries.add(d);
                    }
                    if(d.deal.dealer__Desk_Manager__c==filterUserId && filterUserType=='SM') {
                        filteredEntries.add(d);
                    }                                       
                }
                
                // Appointments
                if(d.deskEntryType=='Appointment') {
                    if(d.appt.dealer__Assigned_To__c==filterUserId) {
                        filteredEntries.add(d); 
                    }
                }
            }
            
        deskEntries.clear();
        deskEntries.addAll(filteredEntries);
    }

     
}