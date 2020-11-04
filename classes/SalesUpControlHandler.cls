/**
*   W-001431
**/
public class SalesUpControlHandler {
        
    /** Lists **/
    List<Id> salesUpIds = new List<Id>();
    List<Service_Vehicle__c> newSerVehList =  new List<Service_Vehicle__c>();
    List<String> vin = new List<String>();
     
    /** Sets and Maps **/
    //Stores Stock number of desired vehicle
    Set<Id> stock = new Set<Id>();
    public static Set<Id> accounts = new Set<Id>();
    public static Set<Id> buyers = new Set<Id>();
    //Stores SUP Trade VIN
    Set<String> vinNoSet =  new Set<String>();
    //Stores User IDs who owns records
    Set<Id> setActiveUserIds= new Set<Id>();
    //Stores dealer__Trade_VIN__c
    Set<String> newVinNoSet = new Set<String>(); 
    Set<Id> serVehicleIds = new Set<Id>();   
    Set<Id> setOwnerIds = new Set<Id>();  

    Boolean fetchDeals;

    //Stores Accounts and Contacts affected
    public static Map<Id, Account> custAccounts;
    public static Map<Id, Contact> customers;
    Map<Id,dealer__Dealer_Location__c> locations;
    Map<String, Id> locationByCompanyNumber;
    Map<Id, User> userRecords;
    //Stores vin numbers and service vehicles  
    Map<String,Service_Vehicle__c> serVehMap = new Map<String,Service_Vehicle__c>(); 
    public static Map<Id, dealer__Vehicle_Inventory__c> inv;
    public static Map<Id,dealer__Sales_Up__c> carDealsId = new Map <Id,dealer__Sales_Up__c>();
    Map<String,String> leadStatus = new Map <String,String>();
    Map<Id,Service_Vehicle__c> svMap = new Map<Id,Service_Vehicle__c>(); 

    //Custom Settings
    public List<dealer__SalesDispositions__c> dispositions = dealer__SalesDispositions__c.getall().values();

    public static Map<Id, dealer__Service_Vehicle__c> serVehicleMap = null;
    public static List<dealer__Desired_Vehicle__c> dv = null;
    public static Map<Id, Map<Id, Desired_Vehicle__c>> dvMap = new Map<Id, Map<Id, Desired_Vehicle__c>>();
    public static Map<Id, dealer__Service_Vehicle__c> svOld = null;
    public static List<dealer__Appraisal_Vehicle__c> appraisalVehList = null;
    // Retreive Sales up prefix from custom setting.
    dealer__CRMSettings__c orgSettings = dealer__CRMSettings__c.getOrgDefaults();
    dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
    
    String nameString;
    
    /** 
  *   Stores Sales Up related IDs
  *  @param Sales Up list
  **/ 
    public void mapData(List<dealer__Sales_Up__c> salesUpList){
        boolean fetchBuyers = false;
        boolean fetchCust = false;
        fetchDeals = false;
        for(dealer__Sales_Up__c up : salesUpList) {                   
    
            if(up.dealer__Trade_VIN__c != null){
               vinNoSet.add(up.dealer__Trade_VIN__c);
            }
            
            if(up.Id != null){
               salesUpIds.add(up.Id);
            }

            //Prevent getCarDealStatus from recursion
            if(up.dealer__Car_Deal__c != null && !carDealsId.keyset().contains(up.dealer__Car_Deal__c)){
                carDealsId.put(Up.dealer__Car_Deal__c, up);  
                fetchDeals = true;
            }

            if(up.dealer__Desired_Stock_Num__c != null) {
                stock.add(up.dealer__Desired_Stock_Num__c);             
            }
            
            if(up.dealer__Desired_Stock_Num__c == null && up.dealer__VIN__c != null ){
                vin.add(up.dealer__VIN__c);
            }
            
            if(up.dealer__Service_Vehicle__c != null) {
                serVehicleIds.add(up.dealer__Service_Vehicle__c);             
            }
            
            if(up.dealer__Buyer_Contact__c != null && !buyers.contains(up.dealer__Buyer_Contact__c)) {
                buyers.add(up.dealer__Buyer_Contact__c);
                fetchBuyers = true;
            }

            if(up.dealer__Customer_Account__c != null && !accounts.contains(up.dealer__Customer_Account__c)) {
                accounts.add(up.dealer__Customer_Account__c);
                fetchCust = true;
            }
            
            // Owner IDs for mapping of Division
            if(up.OwnerId!=null) {
                setOwnerIds.add(up.OwnerId);
            }
            
            if(up.dealer__Salesperson_1__c!=null){
                setOwnerIds.add(up.dealer__Salesperson_1__c);
            }
            
            if(up.dealer__Salesperson_2__c!=null){
                setOwnerIds.add(up.dealer__Salesperson_2__c);
            }
        } 
        //Only run getCustomers when account is not in custAccounts variable
        if(fetchCust == true){
            getCustomers();    
        }

        //Only run getBuyers when contact is not in customers variable
        if(fetchBuyers == true){
            getBuyers();    
        }
    } 
    
    /**
  *  Fetch Account and Contact records affected
  **/
    private void getCustomers(){
        
        Integer queryLimit;
        queryLimit = checklimits(accounts.size() + buyers.size());
        if(queryLimit > 0){
          SalesUpControlHandler.custAccounts = new Map<Id, Account>([SELECT Id, Name, FirstName, LastName, PersonEmail, PersonMailingStreet, PersonMailingCity, 
                                                            PersonMailingState, PersonMailingPostalCode, Phone, PersonMobilePhone, PersonHomePhone
                                                            FROM Account WHERE Id IN:accounts LIMIT : queryLimit]); 
        }
    }
    private void getBuyers(){
        
        Integer queryLimit;
        queryLimit = checklimits(accounts.size() + buyers.size());
        if(queryLimit > 0){ 
          SalesUpControlHandler.customers = new Map<Id, Contact>([SELECT Phone, MobilePhone, LastName, HomePhone, FirstName, Email, Description, 
                                                            MailingCity, MailingState, MailingCountry, MailingPostalCode , MailingStreet 
                                                            FROM Contact WHERE Id IN:buyers LIMIT : queryLimit]); 
        }
    }
  
    public void handleIsBefore(List<dealer__Sales_Up__c> salesUpList){

        getSvMap();
        getRecordOwners();
        //getAllLocations();
        getInventoryRecords();
        if(fetchDeals == true){
            getCarDealStatus(salesUpList);
        }
        createUpdateServiceVehicles(salesUpList);
        associateServiceVehicle(salesUpList);
        getSupNamePrefix();
        setSalesUpFields(salesUpList);

        //update first and last name on sales up with contact name
        for(dealer__Sales_Up__c sup : salesUpList){
            if(sup.dealer__Buyer_Contact__c != null && (sup.dealer__FirstName__c == null || sup.dealer__FirstName__c == '') && (sup.dealer__LastName__c == null || sup.dealer__LastName__c == '')){
                sup.dealer__FirstName__c = customers.get(sup.dealer__Buyer_Contact__c).FirstName;
                sup.dealer__LastName__c = customers.get(sup.dealer__Buyer_Contact__c).LastName;
            }
        }
    }
    
    /**
  *  Fetch Locations
  **/
    private void getAllLocations(){
    
        Integer queryLimit;
        queryLimit = checklimits(5000);
        if(queryLimit > 0){
            locations = new Map<Id, dealer__Dealer_Location__c>([SELECT Id, dealer__Company_Number__c 
                                                                    FROM dealer__Dealer_Location__c 
                                                                    LIMIT : queryLimit]);
            locationByCompanyNumber = new Map<String, Id>();
            for(dealer__Dealer_Location__c l : locations.values()){
                locationByCompanyNumber.put(l.dealer__Company_Number__c, l.Id);
                locations.put(l.Id, l);
            }
        }
    }

    private void getSvMap(){
        Integer queryLimit;
        queryLimit = checklimits(5000);
        if(queryLimit > 0){
            if(!svMap.isEmpty()){
                svMap.clear();
            }

            svMap = new Map<Id, dealer__Service_Vehicle__c>([SELECT id, Name, dealer__VIN__c, dealer__Veh_Owner_Contact__c, dealer__Veh_Owner__c,dealer__Year__c, dealer__Trim_Level__c, 
                                        dealer__Make__c, dealer__Carline__c, dealer__Body_Type__c,dealer__Last_Odometer__c,
                                        Conversion__c
                                    FROM Service_Vehicle__c 
                                    WHERE dealer__VIN__c IN:vinNoSet OR Id IN:serVehicleIds LIMIT : queryLimit]);
        }
    }
    
    /**
  *  Fetch Active Users who own SUP records
  **/
    private void getRecordOwners(){
        
        Integer queryLimit;
        queryLimit = checklimits(5000);
        if(queryLimit > 0){
            userRecords = new Map<Id, User>([SELECT Id, Division 
                                             FROM User 
                                             WHERE IsActive = true and Id IN:setOwnerIds 
                                             LIMIT : queryLimit]);
            for(Id i : userRecords.keySet()){
                setActiveUserIds.add(i);
            }
        }
    }
    
  /**
   *    Get vehicle information By Stocknumber OR VIN 
   **/
    private void getInventoryRecords(){
        
        Integer queryLimit;
        queryLimit = checklimits(10000);
        if(queryLimit > 0){
          inv = new Map<Id, dealer__Vehicle_Inventory__c>([SELECT d.dealer__Year__c, 
                                    d.dealer__VIN__c, d.dealer__Trim_Level__c, 
                                    d.dealer__NUO__c, d.dealer__Model__c, d.dealer__Make__c, d.dealer__In_Stock__c, 
                                    d.dealer__Company_Number__c, d.Name, d.Id, d.dealer__Conversion__c,
                                    d.dealer__Exterior_Color__c, d.dealer__Interior_Color__c, d.dealer__Transmission_Type__c
                                    FROM dealer__Vehicle_Inventory__c d 
                                    WHERE d.Id IN:stock OR d.dealer__VIN__c IN:vin
                                    LIMIT : queryLimit]);
        }        
    }
    
    /**
   *    Get Deals Status By Car Deal Ids in SUPs 
   **/
    private void getCarDealStatus(List<dealer__Sales_Up__c> salesUpList){
         
        Integer queryLimit;
        queryLimit = checklimits(5000);
        if(queryLimit > 0){
			Map<Id, dealer__Deal__c> dealMap = new Map<Id, dealer__Deal__c>();
            
            for(dealer__Deal__c c:[SELECT ID, dealer__Sales_Lead__c, dealer__Deal_Date__c, dealer__Status__c, dealer__Vehicle__c 
                                   FROM dealer__Deal__c 
                                   WHERE ID=:carDealsId.keyset() LIMIT : queryLimit]){

                c.dealer__Sales_Lead__c = carDealsId.get(c.Id).Id;
                dealMap.put(c.Id, c);
            }
            
            //Set stock based on primary deal vehicle
            for(dealer__Sales_Up__c s: salesUpList){

                if(s.dealer__Car_Deal__c != null){
                    if(dealMap.get(s.dealer__Car_Deal__c).dealer__Vehicle__c != s.dealer__Desired_Stock_Num__c){
                        s.dealer__Desired_Stock_Num__c = dealMap.get(s.dealer__Car_Deal__c).dealer__Vehicle__c;
                    }
                }
            }
            
        }
    }

    /**
     * assignEndUser Aligns End User Accounts and End Contacts
     * Context: Before Insert, Before Update
     * @param  triggerNew List of Sales ups in update call
     */ 
    public void alignEndUser(List<Sales_Up__c> triggerNew)
    {   
        Set<Id> contactSet    = new Set<Id>();
        Set<Id> accountSet    = new Set<Id>();
        Set<Id> businessAccSet = new Set<Id>();
        
        for(Sales_Up__c sup : triggerNew){
            if(sup.EndUser__c != null){
                contactSet.add(sup.EndUser__c);
            } else if(sup.End_User__c != null && sup.EndUser__c == null){
                accountSet.add(sup.End_User__c);
            }
        }

        Map<Id, Account> accountMap = new Map<Id, Account>();
        if(accountSet.size() > 0){
            for(Account a :[SELECT Id, isPersonAccount, PersonContactId, PersonContact.Id,  PersonContact.Name FROM Account WHERE Id IN:accountSet]){
                accountMap.put(a.Id, a);
                if(!a.isPersonAccount){
                    //Business Account
                    businessAccSet.add(a.Id);
                }
            }
        }

        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        if(contactSet.size() > 0){
            for(Contact c :[SELECT Id, isPersonAccount, AccountId, Account.Id, Account.Name FROM Contact WHERE Id IN:contactSet]){
                contactMap.put(c.Id, c);
            }
        }

        Map<Id, List<Contact>> businessContactMap = new Map<Id, List<Contact>>(); // Map Acc Id List Contacts
        if(businessAccSet.size() > 0){
            for(Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId IN: businessAccSet]){
                if(c.AccountId != null){
                    if(businessContactMap.get(c.AccountId) == null){
                        businessContactMap.put(c.AccountId, new List<Contact>{c});
                    } else {
                        businessContactMap.get(c.AccountId).add(c);
                    }
                }
            }
        }
        
        List<endUserHelper> supEndUserList = new List<endUserHelper>();
        for(Sales_Up__c sup : triggerNew){
            endUserHelper eu = new endUserHelper(sup, new Contact(), new Account());
            if(sup.EndUser__c != null){ // Contact if both are filled has precedence
                
                eu.contact = contactMap.get(sup.EndUser__c);
                
                if(eu.contact.AccountId != null){
                    eu.account = new Account(Id=eu.contact.AccountId);
                }

            } else if(sup.End_User__c != null && sup.EndUser__c == null){ //Account 
               
                eu.account = accountMap.get(sup.End_User__c);
                
                if(eu.account.isPersonAccount){
                    eu.contact = new Contact(Id=eu.account.PersonContactId);
                } else {
                    if(businessContactMap.get(eu.account.Id) != null && businessContactMap.get(eu.account.Id).size() == 1){
                        eu.contact = businessContactMap.get(eu.account.Id)[0];
                    }
                }

            }

            supEndUserList.add(eu);
        }

        for(endUserHelper eu : supEndUserList){
            eu.sup.EndUser__c = eu.contact != null ? eu.contact.Id: null;
            eu.sup.End_User__c = eu.account != null ? eu.account.Id: null;
        }

    }

    public class endUserHelper{
        Sales_Up__c sup;
        public account account;
        public contact contact;

        public endUserHelper(Sales_Up__c sup, Contact contc, Account acct){
            this.sup = sup;
            this.contact = contc;
            this.account = acct;
        }
    }

    /**
   *    Create new Service Vehicle when SUP Trade Vin is set
   *    Update related Service Vehicle Contact and Account
   *    with SUP Contact and Account data
   *    @param List<dealer__Sales_Up__c> salesUpList
   **/
    private void createUpdateServiceVehicles(List<dealer__Sales_Up__c> salesUpList){
        if(svMap.isEmpty()){
            getSvMap();
        }
        for(Service_Vehicle__c sv : svMap.values()){
            if(vinNoSet.contains(sv.dealer__VIN__c)){
                serVehMap.put(sv.dealer__VIN__c.toUpperCase(), sv);
            }
        }
        
        for(dealer__Sales_Up__c up : salesUpList) {
                  
            if(up.dealer__Trade_VIN__c != null){
                
                /* Capitalize VIN fields  */ 
                up.dealer__Trade_VIN__c = up.dealer__Trade_VIN__c.toUpperCase();           

                if(up.dealer__VIN__c != null){
                    up.dealer__VIN__c = up.dealer__VIN__c.toUpperCase();            
                } 
      
                if(!serVehMap.isEmpty() && serVehMap.containsKey(up.dealer__Trade_VIN__c)){
                     
                    if(up.dealer__Buyer_Contact__c != null || up.dealer__Customer_Account__c != null) {
                        
                        if(up.dealer__Buyer_Contact__c != null){
                            serVehMap.get(up.dealer__Trade_VIN__c).dealer__Veh_Owner_Contact__c = up.dealer__Buyer_Contact__c;
                        } 
                         
                        if(up.dealer__Customer_Account__c != null){
                             serVehMap.get(up.dealer__Trade_VIN__c).dealer__Veh_Owner__c  = up.dealer__Customer_Account__c;
                        }
                        
                        if(!newSerVehList.contains(serVehMap.get(up.dealer__Trade_VIN__c))){
                            newSerVehList.add(serVehMap.get(up.dealer__Trade_VIN__c));    
                        }
                    }
                     
                    up.dealer__Service_Vehicle__c =  serVehMap.get(up.dealer__Trade_VIN__c).Id;
                    serVehicleIds.add(serVehMap.get(up.dealer__Trade_VIN__c).Id);
                     
                } else {
                    Service_Vehicle__c sv = new Service_Vehicle__c();
                    sv.dealer__VIN__c           = up.dealer__Trade_VIN__c;
                    sv.dealer__Year__c          = up.dealer__Trade_Year__c;
                    sv.dealer__Trim_Level__c    = up.dealer__Trade_Trim_Level__c;
                    sv.dealer__Carline__c       = up.dealer__Trade_Model__c;
                    sv.dealer__Last_Odometer__c = up.dealer__Trade_Mileage__c;
                    sv.dealer__Make__c          = up.dealer__Trade_Make__c;
                    sv.dealer__Body_Type__c     = up.dealer__Trade_Body_Type__c;
                    
                    if(up.dealer__Buyer_Contact__c != null) { 
                        sv.dealer__Veh_Owner_Contact__c = up.dealer__Buyer_Contact__c;
                  }
                    if(up.dealer__Customer_Account__c != null) {
                        sv.dealer__Veh_Owner__c  = up.dealer__Customer_Account__c;
                    }
                    
                    newSerVehList.add(sv);
                    newVinNoSet.add(up.dealer__Trade_VIN__c);
                }
             }
        }
    }
    
    /**
   *    Insert new service vehicles & 
   *    Updates account/contact owners fields on existing service vehicles
   *    @param List<dealer__Sales_Up__c> salesUpList
     * */
    private void associateServiceVehicle(List<dealer__Sales_Up__c> salesUpList){

        Map<String,Service_Vehicle__c> newSerVehMap = new Map<String,Service_Vehicle__c>(); 
        if(!newSerVehList.isEmpty()){

            if(Limits.getDmlRows() + newSerVehList.size() < Limits.getLimitDmlRows()){
                upsert newSerVehList;

                //refresh our map of service vehicles
                getSvMap();
            }
            if(svMap.isEmpty()){
                getSvMap();
            }
            for(Service_Vehicle__c sv : svMap.values()){
                if(newVinNoSet.contains(sv.dealer__VIN__c)){
                    newSerVehMap.put(sv.dealer__VIN__c,sv);
                }
            }
            
            //Associate newly created service vehicles to Sales Up
            for(dealer__Sales_Up__c up : salesUpList) {
                if(!newSerVehMap.isEmpty() && newSerVehMap.get(up.dealer__Trade_VIN__c)!=null){
                    up.dealer__Service_Vehicle__c   = newSerVehMap.get(up.dealer__Trade_VIN__c).id;
                }
            } 
        }
    }
    
    /**
     *     Set Sales Up Name Prefix
     * */
    private void getSupNamePrefix(){
        
        String orgPrefix = orgSettings.dealer__Sales_Up_Record_Prefix__c;
        if(String.isBlank(nameString)) nameString = '';
        
        if(orgPrefix != null) {
            nameString = orgPrefix+': ';
        } else {
            // Set org Setting if not set
            orgSettings.dealer__Sales_Up_Record_Prefix__c = 'SALES UP';
            
            if(!Test.isRunningTest()) {
                upsert orgSettings;
            } 
            
            nameString = orgSettings.dealer__Sales_Up_Record_Prefix__c+': ';
        }
    }    
    
    /**
     *     Map Sales
     **/
    private void setSalesUpFields(List<dealer__Sales_Up__c> salesUpList){

        //Will be set true if an untouched sales up with salesperson 1 or 2 is found
        Boolean untouchedLead = false;
        String leadStatus = '';
        for(dealer__Sales_Up__c nup : salesUpList) {
            if((nup.dealer__Salesperson_1__c != null || nup.dealer__Salesperson_2__c != null) && 
               nup.dealer__Lead_Status__c == 'Untouched') {
                untouchedLead = true;
            }
        }

        if(untouchedLead == true){
            leadStatus = DealerMetadata.getConfigValue('SalesUpUntouchedLeadStatus');
        }


        if(String.isBlank(nameString)) nameString = '';
        for(dealer__Sales_Up__c nup : salesUpList) {
            
          if(nup.dealer__First_Store_Visit_Date__c !=null && 
              (nup.dealer__Lead_Status__c=='Sold' || nup.dealer__Lead_Status__c=='Pending')){
                nup.dealer__Post_Sale__c=true;
            }
                            
            if(nup.dealer__Lead_Status__c=='Sold'){
                nup.dealer__Sold__c=true;
            } 
            
            // Set the disposition based on the custom setting table
            for(dealer__SalesDispositions__c ds : dispositions) {
                if(nup.dealer__Lead_Status__c==ds.dealer__SalesUp_Status__c){
                    nup.dealer__Disposition__c=ds.dealer__Disposition__c;
                }
            }                
            
            // Set Company Number based on the Division set in the Owner ID Field
            if(nup.dealer__Salesperson_1__c != null && userRecords.get(nup.dealer__Salesperson_1__c) != null
               && nup.dealer__Company_Number__c == null) {
                   nup.dealer__Company_Number__c = userRecords.get(nup.dealer__Salesperson_1__c).Division;
            }
            
            // Begin Name Logic
            if((nup.dealer__FirstName__c == null || nup.dealer__LastName__c == null) &&
               !dealer.Utility.personsAccountsEnabled()) {
                nup.addError('First Name and Last Name must be populated on the Sales Up');
            }

            if(nup.dealer__FirstName__c!=null) {
                nameString += nup.dealer__FirstName__c.capitalize();
            }
            if(nup.dealer__LastName__c!=null) { 
                nameString +=' '+nup.dealer__LastName__c.toLowerCase().capitalize(); 
            }
            
            // Fill the namestring if there is a non-person account selected and First/Last are not set.
            if(nup.dealer__FirstName__c == null 
               && nup.dealer__LastName__c== null 
               && nup.dealer__Customer_Account__c != null
               && custAccounts.get(nup.dealer__Customer_Account__c)!=null) {
                   nameString += ' '+custAccounts.get(nup.dealer__Customer_Account__c).Name;
               }
            
            // Set SP1 || SP2 as record owner
            if(crm.dealer__Record_Owner_Match_Salesperson__c && 
               nup.dealer__Salesperson_1__c !=null && setActiveUserIds.contains(nup.dealer__Salesperson_1__c) &&
               nup.OwnerId != nup.dealer__Salesperson_1__c) {
                   
                   nup.OwnerId = nup.dealer__Salesperson_1__c; 
            }
            if(crm.dealer__Record_Owner_Match_Salesperson__c && 
               nup.dealer__Salesperson_2__c !=null && setActiveUserIds.contains(nup.dealer__Salesperson_2__c) &&
               nup.OwnerId != nup.dealer__Salesperson_2__c){ 
                   
                   nup.OwnerId = nup.dealer__Salesperson_2__c;   
            }
            
            if((nup.dealer__Salesperson_1__c != null || nup.dealer__Salesperson_2__c != null) && 
               nup.dealer__Lead_Status__c == 'Untouched' && leadStatus != null & leadStatus != '') {
                nup.dealer__Lead_Status__c = leadStatus;
            }
      
            if(nup.dealer__First_Store_Visit_Date__c !=null && nup.dealer__Last_Store_Visit_Date__c != null) {
                 
                 if(!nup.dealer__Last_Store_Visit_Date__c.isSameDay(nup.dealer__First_Store_Visit_Date__c)) {
                     nup.dealer__Be_Back__c=true;
                 } else {
                     nup.dealer__Be_Back__c=false;    
                 }
            }

            String vehString = ' ';
            // Populate desired vehicle data
            if(nup.dealer__Desired_Stock_Num__c != null && inv.get(nup.dealer__Desired_Stock_Num__c) != null) {
                nup.dealer__Year_High__c            =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Year__c;
                nup.dealer__Make__c                 =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Make__c;
                nup.dealer__Model__c                =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Model__c;
                nup.dealer__Trim__c                 =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Trim_Level__c;
                nup.dealer__VIN__c                  =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__VIN__c;
                nup.dealer__NUO__c                  =   inv.get(nup.dealer__Desired_Stock_Num__c).dealer__NUO__c;
                
                nup.dealer__Color_Preference_Ext__c = inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Exterior_Color__c;
                nup.dealer__Color_Preference_Int__c = inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Interior_Color__c;
                nup.dealer__Transmission__c         = inv.get(nup.dealer__Desired_Stock_Num__c).dealer__Transmission_Type__c; 
                vehString += nup.dealer__Year_High__c.toLowerCase().capitalize()+' '+nup.dealer__Make__c.toLowerCase().capitalize()+' '+nup.dealer__Model__c.toLowerCase().capitalize();
                if(nup.ConversionPartsKit__c == null && inv.get(nup.dealer__Desired_Stock_Num__c).Conversion__c != null){
                    nup.ConversionPartsKit__c = inv.get(nup.dealer__Desired_Stock_Num__c).Conversion__c;
                }
            }
            
            //Name Must Be Less than 80 Characters
            if((nameString.length() + vehString.length()) > 80 ) {
                nup.Name = nameString.abbreviate( 80 - (vehString.length()) ) + vehString;
            } else {
                nup.Name = nameString+vehString;
            }
            nup.Name = nup.Name.trim();        
            nameString = '';
            
            if(nup.dealer__Car_Deal__c!=null && crm.dealer__Complete_Sales_Steps_upon_Sale__c) {              
                    nup.dealer__Demo__c = true;
                    nup.dealer__Greet_Meet__c = true;
                    nup.dealer__Present_Vehicle__c = true;
                    nup.dealer__Write_Up__c = true;                
            }

            if(SalesUpControlHandler.serVehicleMap == null) {
                //Get Service Vehicle records affected by this lead 
                SalesUpControlHandler.serVehicleMap = new Map<Id, dealer__Service_Vehicle__c>();
                if(svMap.isEmpty()){
                    getSvMap();
                }
                for(Service_Vehicle__c sv : svMap.values()){
                    if(serVehicleIds.contains(sv.Id)){
                        SalesUpControlHandler.serVehicleMap.put(sv.Id, sv);
                    }
                }

            } 
            if(nup.Service_Vehicle__c != null && nup.Desired_Stock_Num__c != null){
                Service_Vehicle__c sv = SalesUpControlHandler.serVehicleMap.get(nup.Service_Vehicle__c) != null ? SalesUpControlHandler.serVehicleMap.get(nup.Service_Vehicle__c) : new Service_Vehicle__c(); 
            
                if(nup.ConversionPartsKit__c == null && sv != null && sv.Conversion__c != null ){
                    nup.ConversionPartsKit__c = sv.Conversion__c;
                } 
            }
            
        }
    }
 
    private Integer checkLimits(Integer size){    
      
        Integer qLimit = 0;
        if(Limits.getLimitQueryRows() - Limits.getQueryRows() > size){
                return size;
            
        } else if (Limits.getLimitQueryRows() - Limits.getQueryRows() > qLimit){      
              return Limits.getLimitQueryRows() - Limits.getQueryRows();
        }
    
        return qLimit;
    }
    
    public void OnBeforeInsert(List<dealer__Sales_Up__c> salesUpList){
        
        for(dealer__Sales_Up__c nup : salesUpList) {

            if(nup.dealer__Customer_Account__c != null){
                if(custAccounts.get(nup.dealer__Customer_Account__c).FirstName != null && custAccounts.get(nup.dealer__Customer_Account__c).FirstName != '')
                    nup.dealer__FirstName__c = custAccounts.get(nup.dealer__Customer_Account__c).FirstName;
                if(custAccounts.get(nup.dealer__Customer_Account__c).LastName != null && custAccounts.get(nup.dealer__Customer_Account__c).LastName != '')
                    nup.dealer__LastName__c = custAccounts.get(nup.dealer__Customer_Account__c).LastName;
                if(nup.dealer__Phone__c==null) { nup.dealer__Phone__c = custAccounts.get(nup.dealer__Customer_Account__c).Phone; }
                if(nup.dealer__Home_Phone__c==null) { nup.dealer__Home_Phone__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonHomePhone; }
                if(nup.dealer__Mobile__c==null) { nup.dealer__Mobile__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMobilePhone; }
                if(nup.dealer__Email__c==null) { nup.dealer__Email__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonEmail; }
                if(nup.dealer__Mailing_Street__c==null) { nup.dealer__Mailing_Street__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingStreet; }
                if(nup.dealer__Mailing_City__c==null) { nup.dealer__Mailing_City__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingCity; }
                if(nup.dealer__Mailing_State__c==null) { nup.dealer__Mailing_State__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingState; }
                if(nup.dealer__Mailing_Zip__c==null) { nup.dealer__Mailing_Zip__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingPostalCode; }
            }
            else if (nup.dealer__Buyer_Contact__c != null){
                nup.dealer__FirstName__c = customers.get(nup.dealer__Buyer_Contact__c).FirstName;
                nup.dealer__LastName__c = customers.get(nup.dealer__Buyer_Contact__c).LastName;
                if(nup.dealer__Phone__c==null) { nup.dealer__Phone__c = customers.get(nup.dealer__Buyer_Contact__c).Phone; }
                if(nup.dealer__Home_Phone__c==null) { nup.dealer__Home_Phone__c = customers.get(nup.dealer__Buyer_Contact__c).HomePhone; }
                if(nup.dealer__Mobile__c==null) { nup.dealer__Mobile__c = customers.get(nup.dealer__Buyer_Contact__c).MobilePhone; }
                if(nup.dealer__Email__c==null) { nup.dealer__Email__c = customers.get(nup.dealer__Buyer_Contact__c).Email; }
                if(nup.dealer__Mailing_Street__c==null) { nup.dealer__Mailing_Street__c = customers.get(nup.dealer__Buyer_Contact__c).MailingStreet; }
                if(nup.dealer__Mailing_City__c==null) { nup.dealer__Mailing_City__c = customers.get(nup.dealer__Buyer_Contact__c).MailingCity; }
                if(nup.dealer__Mailing_State__c==null) { nup.dealer__Mailing_State__c = customers.get(nup.dealer__Buyer_Contact__c).MailingState; }
                if(nup.dealer__Mailing_Zip__c==null) { nup.dealer__Mailing_Zip__c = customers.get(nup.dealer__Buyer_Contact__c).MailingPostalCode; }
            }       
            
            String ownId, locId;
            User own;
            if(nup.dealer__Store_Location__c == null) //W-000581 to prevent for records coming from ADF with Queue as salesUp owners
            {
                ownId = nup.OwnerID;
                own = userRecords.get(ownId);
                if ( userRecords.get(ownId) != null ) {
                    getAllLocations();
                    locId = locationByCompanyNumber.get(own.Division);
                }

            }
      
            if(locId != null &&  nup.dealer__Store_Location__c == null)
                nup.dealer__Store_Location__c = locId;          
            
            if(own != null && own.Division != null && nup.dealer__Company_Number__c == null)
                nup.dealer__Company_Number__c = own.Division;
        }
  }
    
  public void OnBeforeUpdate(Map<Id,dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList){

        Map<Id, Sales_Up__c> supsChangedVehicle = new Map<Id, Sales_Up__c>();
        Map<Id, Desired_Vehicle__c> existingDVMap = new Map<Id, Desired_Vehicle__c>();
    
        for(dealer__Sales_Up__c nup : salesUpList){
            
            if(nup.dealer__Customer_Account__c != oldSalesUpMap.get(nup.Id).dealer__Customer_Account__c && nup.dealer__Customer_Account__c != null){
                nup.dealer__FirstName__c = custAccounts.get(nup.dealer__Customer_Account__c).FirstName;
                nup.dealer__LastName__c = custAccounts.get(nup.dealer__Customer_Account__c).LastName;
                nup.dealer__Phone__c = custAccounts.get(nup.dealer__Customer_Account__c).Phone; 
                nup.dealer__Home_Phone__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonHomePhone; 
                nup.dealer__Mobile__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMobilePhone; 
                nup.dealer__Email__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonEmail; 
                nup.dealer__Mailing_Street__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingStreet; 
                nup.dealer__Mailing_City__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingCity; 
                nup.dealer__Mailing_State__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingState; 
                nup.dealer__Mailing_Zip__c = custAccounts.get(nup.dealer__Customer_Account__c).PersonMailingPostalCode; 
            
            }else if (nup.dealer__Buyer_Contact__c != oldSalesUpMap.get(nup.Id).dealer__Buyer_Contact__c && nup.dealer__Buyer_Contact__c != null){

                nup.dealer__FirstName__c = customers.get(nup.dealer__Buyer_Contact__c).FirstName;
                nup.dealer__LastName__c = customers.get(nup.dealer__Buyer_Contact__c).LastName;
                nup.dealer__Phone__c = customers.get(nup.dealer__Buyer_Contact__c).Phone; 
                nup.dealer__Home_Phone__c = customers.get(nup.dealer__Buyer_Contact__c).HomePhone; 
                nup.dealer__Mobile__c = customers.get(nup.dealer__Buyer_Contact__c).MobilePhone; 
                nup.dealer__Email__c = customers.get(nup.dealer__Buyer_Contact__c).Email; 
                nup.dealer__Mailing_Street__c = customers.get(nup.dealer__Buyer_Contact__c).MailingStreet; 
                nup.dealer__Mailing_City__c = customers.get(nup.dealer__Buyer_Contact__c).MailingCity; 
                nup.dealer__Mailing_State__c = customers.get(nup.dealer__Buyer_Contact__c).MailingState; 
                nup.dealer__Mailing_Zip__c = customers.get(nup.dealer__Buyer_Contact__c).MailingPostalCode; 
            }
            
            //Delete stock (vehicle) if primary deal is deleted
            if(oldSalesUpMap.get(nup.Id).dealer__Car_Deal__c != null && nup.dealer__Car_Deal__c == null){
                nup.dealer__Desired_Stock_Num__c = null;
            }
            //Delete primary desired vehicle if vehicle inventory is changed and desired vehicle was not (to keep them in sync)
            if(nup.dealer__Desired_Stock_Num__c != oldSalesUpMap.get(nup.Id).dealer__Desired_Stock_Num__c && nup.DesiredVehicle__c == oldSalesUpMap.get(nup.Id).DesiredVehicle__c){
                nup.DesiredVehicle__c = null;
                supsChangedVehicle.put(nup.Id, nup);
            }

        
            //Set the Company Number if the Location changed 
            if(oldSalesUpMap.get(nup.Id)!=null 
                && nup.dealer__Store_Location__c != null
                && oldSalesUpMap.get(nup.Id).dealer__Store_Location__c != nup.dealer__Store_Location__c){

                    getAllLocations();
                   
                    if(locations.get(nup.dealer__Store_Location__c) != null){
                        nup.dealer__Company_Number__c = locations.get(nup.dealer__Store_Location__c).dealer__Company_Number__c;
                    }
            }
            
            //Check against Previous Data in Trigger
            if(oldSalesUpMap.get(nup.Id)!=null 
                && nup.dealer__In_Store__c && !oldSalesUpMap.get(nup.Id).dealer__In_Store__c) {
     
                    if(nup.dealer__First_Store_Visit_Date__c==null) {
                        nup.dealer__First_Store_Visit_Date__c=DateTime.now();
                    }
            }
        }

        if(supsChangedVehicle.size() > 0){
            for(Desired_Vehicle__c relatedDV : [SELECT Id, dealer__Year__c, dealer__Make__c, dealer__Model__c,
                dealer__Trim_Level__c, dealer__Sales_Up__c, dealer__Vehicle_Inventory__c, Conversion__c
                FROM dealer__Desired_Vehicle__c WHERE dealer__Sales_Up__c IN:supsChangedVehicle.keyset() AND Vehicle_Inventory__c != null]){

                existingDVMap.put(relatedDV.Vehicle_Inventory__c, relatedDV);
            }

                
        }     
        for(Sales_Up__c sup : supsChangedVehicle.values()){
            if(existingDVMap.get(sup.Desired_Stock_Num__c) != null){
                sup.DesiredVehicle__c = existingDVMap.get(sup.Desired_Stock_Num__c).Id;
            }
        }
    }
      
    public void handleIsAfter(List<dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList, Map<ID, dealer__Sales_Up__c> salesUpMap){
    		
            //List to hold updated trade service vehicles owner and owner contact values with salesup customer account and buyer.(kvp)
            List<dealer__Desired_Vehicle__c> desiredVehicles = new List<dealer__Desired_Vehicle__c>();
            List<dealer__Appraisal_Vehicle__c> appraisalVehicles = new List<dealer__Appraisal_Vehicle__c>(); //used to store appriasal vehicle records
            List<Sales_Up__Share> upShare = new List<Sales_Up__Share>();
            Sales_Up__Share sp1Share;
            Sales_Up__Share sp2Share;
            Set<Id> customersToUpdateSet = new Set<Id>();
            Set<Id> accountsToUpdateSet = new Set<Id>();
            List<Contact> customersToUpdate = new List<Contact>();
            List<Account> accountsToUpdate = new List<Account>();
        	
            if(SalesUpControlHandler.serVehicleMap == null) {
                //Get Service Vehicle records affected by this lead 
                SalesUpControlHandler.serVehicleMap = new Map<Id, dealer__Service_Vehicle__c>();
                if(svMap.isEmpty()){
                    getSvMap();
                }
                for(Service_Vehicle__c sv : svMap.values()){
                    if(serVehicleIds.contains(sv.Id)){
                        SalesUpControlHandler.serVehicleMap.put(sv.Id, sv);
                    }
                }

            } 
        
            // Collect Desired Vehicles to ensure when a stock number is added, it is created in the desired vehicle object
            if(Trigger.size > 0 && SalesUpControlHandler.dv == null || (SalesUpControlHandler.dv != null && SalesUpControlHandler.dv.size() == 0)) { 

                SalesUpControlHandler.dv=[SELECT Id, dealer__Year__c, dealer__Make__c, dealer__Model__c,
                        dealer__Trim_Level__c, dealer__Sales_Up__c, dealer__Vehicle_Inventory__c, Conversion__c
                        FROM dealer__Desired_Vehicle__c 
                        WHERE dealer__Sales_Up__c IN:salesUpIds ];
                                                                            
                SalesUpControlHandler.appraisalVehList = [SELECT d.dealer__Year__c, d.dealer__Trim_Level__c, d.dealer__Service_Vehicle__c,
                        d.dealer__Sales_Up__c, d.dealer__Model__c, d.dealer__Make__c 
                        FROM dealer__Appraisal_Vehicle__c d
                        WHERE d.dealer__Sales_Up__c IN:salesUpIds ]; 
            }

            
            for(dealer__Sales_Up__c su : salesUpList){
                Map<Id, dealer__Desired_Vehicle__c> dvSupMap = new Map<Id, dealer__Desired_Vehicle__c>();
                for(dealer__Desired_Vehicle__c d : SalesUpControlHandler.dv){
                    if(d.Sales_Up__c == su.Id && !dvSupMap.containsKey(d.Vehicle_Inventory__c)){
                        dvSupMap.put(d.Vehicle_Inventory__c, d);
                        system.debug(dvSupMap);
                    }
                }
                
                if(!dvMap.containsKey(su.Id)){
                    dvMap.put(su.Id, dvSupMap);
                }
                else if(dvMap.containsKey(su.Id)){
                    dvMap.get(su.Id).putAll(dvSupMap);
                }
            }
            
        
            //List to hold updated trade service vehicles 
            List<dealer__Service_Vehicle__c> tradeServiceVehList = new List<dealer__Service_Vehicle__c>();
            Set<String> tradeSVIds = new Set<String>();

            // Get Set of service vehicles to see if an update is necessary
            for(dealer__Sales_Up__c nup : salesUpList) {
                tradeSVIds.add(nup.dealer__service_Vehicle__c);
            }
          
          
            if( SalesUpControlHandler.svOld == null ){
                SalesUpControlHandler.svOld = new Map<Id, dealer__Service_Vehicle__c>();
                if(svMap.isEmpty()){
                    getSvMap();
                }
                for(Service_Vehicle__c sv : svMap.values()){
                    if(tradeSVIds.contains(sv.Id)){
                        svOld.put(sv.Id, sv);
                    }
                }
            }
        
            for(dealer__Sales_Up__c nup : salesUpList) {

                if(nup.dealer__Service_Vehicle__c != null && SalesUpControlHandler.svOld.containsKey(nup.dealer__Service_Vehicle__c)){

                    // Check to see if the records are different and thus require update
                    if(SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c)!=null && 
                        (
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Veh_Owner__c !=  nup.dealer__Customer_Account__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Veh_Owner_Contact__c !=  nup.dealer__Buyer_Contact__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Year__c != nup.dealer__Trade_Year__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Trim_Level__c != nup.dealer__Trade_Trim_Level__c || 
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Carline__c != nup.dealer__Trade_Model__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Last_Odometer__c != nup.dealer__Trade_Mileage__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Make__c != nup.dealer__Trade_Make__c ||
                           SalesUpControlHandler.svOld.get(nup.dealer__Service_Vehicle__c).dealer__Body_Type__c != nup.dealer__Trade_Body_Type__c
                        )){

                        dealer__Service_Vehicle__c dealerSV = new dealer__Service_Vehicle__c(id = nup.dealer__service_Vehicle__c);
                        dealerSV.dealer__Veh_Owner__c         = nup.dealer__Customer_Account__c;
                        dealerSV.dealer__Veh_Owner_Contact__c = nup.dealer__Buyer_Contact__c;
                        if(nup.dealer__Trade_Year__c != null){
                           dealerSV.dealer__Year__c  = nup.dealer__Trade_Year__c;
                        }
                        if(nup.dealer__Trade_Trim_Level__c != null){
                           dealerSV.dealer__Trim_Level__c  = nup.dealer__Trade_Trim_Level__c;
                        } 
                        if(nup.dealer__Trade_Model__c != null){
                           dealerSV.dealer__Carline__c = nup.dealer__Trade_Model__c;
                        }
                        if(nup.dealer__Trade_Mileage__c != null){
                           dealerSV.dealer__Last_Odometer__c = nup.dealer__Trade_Mileage__c;
                        }
                        if(nup.dealer__Trade_Make__c != null){
                           dealerSV.dealer__Make__c  = nup.dealer__Trade_Make__c;
                        }
                        if(nup.dealer__Trade_Body_Type__c != null){
                           dealerSV.dealer__Body_Type__c  = nup.dealer__Trade_Body_Type__c; 
                        }
                        tradeServiceVehList.add(dealerSV);
                    }
                }
              
                // Create Desired Vehicles Map if not exists
                Boolean itemExists = false;
                Boolean appraisalExists = false;

                for(dealer__Desired_Vehicle__c idv : SalesUpControlHandler.dv) {
                    
                    if(nup.Id == idv.dealer__Sales_Up__c) {
                        if(nup.dealer__Desired_Stock_Num__c == idv.dealer__Vehicle_Inventory__c) {
                            itemExists=true;
                        }
                        if(idv.dealer__Year__c == nup.dealer__Year_High__c && 
                            idv.dealer__Make__c == nup.dealer__Make__c && 
                            idv.dealer__Model__c == nup.dealer__Model__c) {
                                itemExists=true;
                        }   
                    }
                }

                //checking whether appraisal vehicle exist or not
                for(dealer__Appraisal_Vehicle__c av : SalesUpControlHandler.appraisalVehList){
                
                    if(nup.Id == av.dealer__Sales_Up__c && 
                       nup.dealer__Service_Vehicle__c == av.dealer__Service_Vehicle__c) {
                        appraisalExists = true;                    
                    }
                }

                if(!itemExists && 
                    (nup.dealer__Desired_Stock_Num__c != null || 
                    (nup.dealer__Year_High__c!=null && nup.dealer__Make__c != null && nup.dealer__Model__c != null))) {
                    
                    dealer__Desired_Vehicle__c ndv = new dealer__Desired_Vehicle__c();
                    ndv.dealer__Vehicle_Inventory__c = (nup.dealer__Desired_Stock_Num__c!=null)?nup.dealer__Desired_Stock_Num__c:null;
                    ndv.dealer__Sales_Up__c = nup.Id;
                    ndv.dealer__Year__c = (nup.dealer__Year_High__c!=null)?nup.dealer__Year_High__c:null;
                    ndv.dealer__Make__c = (nup.dealer__Make__c!=null)?nup.dealer__Make__c:null;
                    ndv.dealer__Model__c= (nup.dealer__Model__c!=null)?nup.dealer__Model__c:null;
                    ndv.dealer__Trim_Level__c = (nup.dealer__Trim__c!=null)?nup.dealer__Trim__c:null; 
                    ndv.dealer__VIN__c = (nup.dealer__VIN__c!=null)?nup.dealer__VIN__c:null;
                    ndv.dealer__New_Used_Other__c = (nup.dealer__NUO__c!=null)?nup.dealer__NUO__c:null;

                    desiredVehicles.add(ndv);
                }   

                //W-002588 Start
                Service_Vehicle__c sv1 = SalesUpControlHandler.serVehicleMap.get(nup.Service_Vehicle__c) != null ? SalesUpControlHandler.serVehicleMap.get(nup.Service_Vehicle__c) : new Service_Vehicle__c();
                Vehicle_Inventory__c vi1 = SalesUpControlHandler.inv.get(nup.dealer__Desired_Stock_Num__c) != null ? inv.get(nup.dealer__Desired_Stock_Num__c) : new Vehicle_Inventory__c();
                if(nup.ConversionPartsKit__c != null || (nup.dealer__Desired_Stock_Num__c != null && vi1 != null && vi1.Conversion__c != null)){
                    List<Desired_Vehicle__c> dvl = createDesiredVehiclesConversion(nup);
                    if(dvl.size() > 0 ) desiredVehicles.addAll(dvl);
                }   
                //W-002588 End

                //If the current service vehicle not exist under appraisal vehicle records then create a new appraisal record.
                if(!appraisalExists && nup.dealer__Service_Vehicle__c != null){
                    
                    dealer__Appraisal_Vehicle__c  appraisalVeh = new dealer__Appraisal_Vehicle__c();
                    appraisalVeh.dealer__Sales_Up__c = nup.id;
                    appraisalVeh.dealer__Service_Vehicle__c = nup.dealer__Service_Vehicle__c;
                    
                    if(!SalesUpControlHandler.serVehicleMap.isEmpty() && SalesUpControlHandler.serVehicleMap.containsKey(nup.dealer__Service_Vehicle__c)){
                        appraisalVeh.dealer__Year__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__Year__c;
                        appraisalVeh.dealer__Make__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__Make__c;
                        appraisalVeh.dealer__Model__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__Carline__c;
                        appraisalVeh.dealer__Trim_Level__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__Trim_Level__c;
                        appraisalVeh.dealer__VIN__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__VIN__c;
                        appraisalVeh.dealer__Body_Type__c = SalesUpControlHandler.serVehicleMap.get(nup.dealer__Service_Vehicle__c).dealer__Body_Type__c;
                    } 
                    appraisalVehicles.add(appraisalVeh);
                }
                
                //Set Record Sharing for SP1 
                if(nup.dealer__Salesperson_1__c!=null && nup.OwnerId!=nup.dealer__Salesperson_1__c && 
                   setActiveUserIds.contains(nup.dealer__Salesperson_1__c)){
                    sp1Share = new Sales_Up__Share();
                    
                    //Setting ID of Record to Share
                    sp1Share.ParentId = nup.Id;
                    
                    // Set ID of User/Group to Share with
                    sp1Share.UserOrGroupId = nup.dealer__Salesperson_1__c; 
                    
                    // Set Access Level
                    sp1Share.AccessLevel = 'edit';               
                    
                    // Set Apex Sharing Reason
                    sp1Share.RowCause = Schema.Sales_Up__Share.RowCause.Manual;
                    
                    upShare.add(sp1Share);
                }
                
                //Set Record Sharing for SP2 
                if(nup.dealer__Salesperson_2__c!=null && nup.OwnerId!=nup.dealer__Salesperson_2__c && setActiveUserIds.contains(nup.dealer__Salesperson_2__c)){
                    sp2Share = new Sales_Up__Share();
                    
                    //Setting ID of Record to Share               
                    sp2Share.ParentId = nup.Id;
                    
                    // Set ID of User/Group to Share with
                    sp2Share.UserOrGroupId = nup.dealer__Salesperson_2__c;
                    
                    // Set Access Level
                    sp2Share.AccessLevel = 'edit';
                    
                    // Set Apex Sharing Reason
                    sp2Share.RowCause = Schema.Sales_Up__Share.RowCause.Manual;
                    
                    upShare.add(sp2Share);
                } 


                // If contact info like email, mobile phone #, address changed in the sales up, update the Account and Contact
                // added street,city,zip on 5/7/14 - Jarrett Kuljis
                // start MKS4c
                // MKS5a removed && Trigger.size==1
                if(nup.dealer__Customer_Account__c != null) {
                    if(custAccounts == null){
                        getCustomers();
                    }
                    Account accountUpdateData       =   custAccounts.get(nup.dealer__Customer_Account__c);
                    Boolean performAccountUpdate   =   false;
                    
                    if(nup.dealer__Phone__c!=null && (nup.dealer__Phone__c != accountUpdateData.Phone)) {
                        performAccountUpdate=true;
                        accountUpdateData.Phone =   nup.dealer__Phone__c;   
                    }
                    if(nup.dealer__Home_Phone__c!=null && (nup.dealer__Home_Phone__c != accountUpdateData.PersonHomePhone)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonHomePhone =   nup.dealer__Home_Phone__c;   
                    }
                    if(nup.dealer__Mobile__c!=null && (nup.dealer__Mobile__c != accountUpdateData.PersonMobilePhone)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonMobilePhone = nup.dealer__Mobile__c;
                    } 
                    if(nup.dealer__Email__c!=null && (nup.dealer__Email__c != accountUpdateData.PersonEmail)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonEmail =   nup.dealer__Email__c;
                    }
                    
                    if(nup.dealer__Mailing_Street__c!=null && (nup.dealer__Mailing_Street__c != accountUpdateData.PersonMailingStreet)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonMailingStreet=nup.dealer__Mailing_Street__c;
                    }
                    
                    if(nup.dealer__Mailing_City__c!=null && (nup.dealer__Mailing_City__c != accountUpdateData.PersonMailingCity)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonMailingCity=nup.dealer__Mailing_City__c;
                    }

                    if(nup.dealer__Mailing_State__c!=null && (nup.dealer__Mailing_State__c != accountUpdateData.PersonMailingState)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonMailingState=nup.dealer__Mailing_State__c;
                    }
                    
                    if(nup.dealer__Mailing_Zip__c!=null && (nup.dealer__Mailing_Zip__c != accountUpdateData.PersonMailingPostalCode)) {
                        performAccountUpdate=true;
                        accountUpdateData.PersonMailingPostalCode=nup.dealer__Mailing_Zip__c;
                    }                
                    
                    if(performAccountUpdate) {
                        Boolean namesPopulated = accountUpdateData.FirstName!=null && accountUpdateData.LastName!=null && 
                                       accountUpdateData.FirstName!=''&& accountUpdateData.LastName!='';
                        if(namesPopulated && !accountsToUpdateSet.contains(accountUpdateData.Id)) {
                            accountsToUpdateSet.add(accountUpdateData.Id);
                            Account aClean = new Account(Id=accountUpdateData.Id, 
                                                            FirstName=accountUpdateData.FirstName,
                                                            LastName=accountUpdateData.LastName,
                                                            PersonEmail=accountUpdateData.PersonEmail,
                                                            PersonMobilePhone=accountUpdateData.PersonMobilePhone,
                                                            PersonHomePhone=accountUpdateData.PersonHomePhone,
                                                            Phone=accountUpdateData.Phone
                                                        );
                            accountsToUpdate.add(aClean);
                        }
                    }
                }
                //end MKS4c

                if(nup.dealer__Buyer_Contact__c!=null) {
                    Contact contactUpdateData       =   customers.get(nup.dealer__Buyer_Contact__c);
                    Boolean performCustomerUpdate   =   false;
                    
                    if(nup.dealer__Phone__c!=null && (nup.dealer__Phone__c != contactUpdateData.Phone)) {
                        performCustomerUpdate=true;
                        contactUpdateData.Phone =   nup.dealer__Phone__c;   
                    }
                    if(nup.dealer__Home_Phone__c!=null && (nup.dealer__Home_Phone__c != contactUpdateData.HomePhone)) {
                        performCustomerUpdate=true;
                        contactUpdateData.HomePhone =   nup.dealer__Home_Phone__c;   
                    }
                    if(nup.dealer__Mobile__c!=null && (nup.dealer__Mobile__c != contactUpdateData.MobilePhone)) {
                        performCustomerUpdate=true;
                        contactUpdateData.MobilePhone = nup.dealer__Mobile__c;
                    } 
                    if(nup.dealer__Email__c!=null && (nup.dealer__Email__c != contactUpdateData.Email)) {
                        performCustomerUpdate=true;
                        contactUpdateData.Email =   nup.dealer__Email__c;
                    }
                    
                    if(nup.dealer__Mailing_Street__c!=null && (nup.dealer__Mailing_Street__c != contactUpdateData.MailingStreet)) {
                        performCustomerUpdate=true;
                        contactUpdateData.MailingStreet=nup.dealer__Mailing_Street__c;
                    }
                    
                    if(nup.dealer__Mailing_City__c!=null && (nup.dealer__Mailing_City__c != contactUpdateData.MailingCity)) {
                        performCustomerUpdate=true;
                        contactUpdateData.MailingCity=nup.dealer__Mailing_City__c;
                    }

                    if(nup.dealer__Mailing_State__c!=null && (nup.dealer__Mailing_State__c != contactUpdateData.MailingState)) {
                        performCustomerUpdate=true;
                        contactUpdateData.MailingState=nup.dealer__Mailing_State__c;
                    }
                    
                    if(nup.dealer__Mailing_Zip__c!=null && (nup.dealer__Mailing_Zip__c != contactUpdateData.MailingPostalCode)) {
                        performCustomerUpdate=true;
                        contactUpdateData.MailingPostalCode=nup.dealer__Mailing_Zip__c;
                    }                
                    
                    if(performCustomerUpdate) {

                        Boolean namesPopulated = contactUpdateData.FirstName!=null && contactUpdateData.LastName!=null &&
                                       contactUpdateData.FirstName!='' && contactUpdateData.LastName!='';
                        if(namesPopulated && !customersToUpdateSet.contains(contactUpdateData.Id)) {
                            customersToUpdateSet.add(contactUpdateData.Id);
                            customersToUpdate.add(contactUpdateData);
                        }
                    }
                }            
            }//end iteration over Trigger.new
            
            // Post Desired Vehicles
            if(desiredVehicles.size()>0) {
                upsert desiredVehicles;
            }
            
            if(appraisalVehicles.size()>0) {
                insert appraisalVehicles;
            }
            
            // Update Sharing Records
            Database.SaveResult[] lsr = Database.insert(upShare,false);
            
            // Create counter
            Integer i=0;
            
            // Process the save results
            for(Database.SaveResult sr : lsr){
                if(!sr.isSuccess()){
                    // Get the first save result error
                    Database.Error err = sr.getErrors()[0];
                    
                    // Check if the error is related to a trivial access level
                    // Access levels equal or more permissive than the object's default 
                    // access level are not allowed. 
                    // These sharing records are not  and thus an insert exception is 
                    // acceptable. 
                    if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                                   &&  err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
                        trigger.newMap.get(upShare[i].ParentId).
                          addError(
                           'Unable to grant sharing access due to following exception: '
                           + err.getMessage());
                    } 
                }
                i++;
            }//end processing save results
                    
            // Update Contact list if populated
            if(customersToUpdate.size()>0) {
                update customersToUpdate;            
            }

            //Update Account list if populated
            if(accountsToUpdate.size()>0){
                update accountsToUpdate;
            }
         
        Profiler.limits();
    }

    /**
     *  Updates or Creates the Desired Vehicle record with the attached Conversion (parts kit lookup)
     *  
     * @test - SalesUpDomainLayer.testCreateDesiredVehicle
     */
    private List<Desired_Vehicle__c> createDesiredVehiclesConversion(Sales_Up__c sup){///comment
        // either sales up conversion exists or the service_Vehile__r.Conversion__c exists
        List<Desired_Vehicle__c> desiredVehicles = new List<Desired_Vehicle__c>();
        Desired_Vehicle__c dVeh = new Desired_Vehicle__c();
        Service_Vehicle__c sv = SalesUpControlHandler.serVehicleMap.get(sup.Service_Vehicle__c) != null ? SalesUpControlHandler.serVehicleMap.get(sup.Service_Vehicle__c) : new Service_Vehicle__c(); 
        Vehicle_Inventory__c vi = inv.get(sup.dealer__Desired_Stock_Num__c) != null ? inv.get(sup.dealer__Desired_Stock_Num__c) : new Vehicle_Inventory__c();
        if(sup.Desired_Stock_Num__c != null){
            if (sup.ConversionPartsKit__c != null && (sv!= null && vi.Conversion__c != null && sup.ConversionPartsKit__c == vi.Conversion__c) ){
                if(dvMap.get(sup.Id) != null && dvMap.get(sup.Id).get(sup.Desired_Stock_Num__c) != null){
                    dVeh = dvMap.get(sup.Id).get(sup.Desired_Stock_Num__c);
                    dVeh.Conversion__c = sup.ConversionPartsKit__c;
                    dVeh.Year__c = (sup.Year_High__c!=null)?sup.Year_High__c:null;
                    dVeh.Make__c = (sup.Make__c!=null)?sup.Make__c:null;
                    dVeh.Model__c= (sup.Model__c!=null)?sup.Model__c:null;
                    dVeh.Trim_Level__c = (sup.Trim__c!=null)?sup.Trim__c:null;
                    dVeh.VIN__c = (sup.VIN__c!=null)?sup.VIN__c:null;
                    dVeh.New_Used_Other__c = (sup.NUO__c!=null)?sup.NUO__c:null;
                    desiredVehicles.add(dVeh);
                }
                else{
                    desiredVehicles.add(new Desired_Vehicle__c(
                        Conversion__c = vi.Conversion__c,
                        Vehicle_Inventory__c = (sup.Desired_Stock_Num__c!=null)?sup.Desired_Stock_Num__c:null,
                        Sales_Up__c = sup.Id,
                        Year__c = (sup.Year_High__c!=null)?sup.Year_High__c:null,
                        Make__c = (sup.Make__c!=null)?sup.Make__c:null,
                        Model__c= (sup.Model__c!=null)?sup.Model__c:null,
                        Trim_Level__c = (sup.Trim__c!=null)?sup.Trim__c:null,
                        VIN__c = (sup.VIN__c!=null)?sup.VIN__c:null,
                        New_Used_Other__c = (sup.NUO__c!=null)?sup.NUO__c:null
                    ));
                }
            } else if(sup.ConversionPartsKit__c != null && (sv != null && sup.ConversionPartsKit__c != vi.Conversion__c)){
                if(dvMap.get(sup.Id) != null && dvMap.get(sup.Id).get(sup.Desired_Stock_Num__c) != null){
                    dVeh = dvMap.get(sup.Id).get(sup.Desired_Stock_Num__c);
                    dVeh.Conversion__c = sup.ConversionPartsKit__c;
                    dVeh.Year__c = (sup.Year_High__c!=null)?sup.Year_High__c:null;
                    dVeh.Make__c = (sup.Make__c!=null)?sup.Make__c:null;
                    dVeh.Model__c= (sup.Model__c!=null)?sup.Model__c:null;
                    dVeh.Trim_Level__c = (sup.Trim__c!=null)?sup.Trim__c:null;
                    dVeh.VIN__c = (sup.VIN__c!=null)?sup.VIN__c:null;
                    dVeh.New_Used_Other__c = (sup.NUO__c!=null)?sup.NUO__c:null;
                    desiredVehicles.add(dVeh);
                }
                else{
                    desiredVehicles.add(new Desired_Vehicle__c(
                        Conversion__c = vi.Conversion__c,
                        Vehicle_Inventory__c = (sup.Desired_Stock_Num__c!=null)?sup.Desired_Stock_Num__c:null,
                        Sales_Up__c = sup.Id,
                        Year__c = (sup.Year_High__c!=null)?sup.Year_High__c:null,
                        Make__c = (sup.Make__c!=null)?sup.Make__c:null,
                        Model__c= (sup.Model__c!=null)?sup.Model__c:null,
                        Trim_Level__c = (sup.Trim__c!=null)?sup.Trim__c:null,
                        VIN__c = (sup.VIN__c!=null)?sup.VIN__c:null,
                        New_Used_Other__c = (sup.NUO__c!=null)?sup.NUO__c:null
                    ));
                }
                desiredVehicles.add(new Desired_Vehicle__c(
                    Conversion__c = sup.ConversionPartsKit__c,
                    Sales_Up__c = sup.Id
                ));
            } 

        }
        return desiredVehicles;
    }
    /**
     *  Handles creating or updating existing opportunity when sales up is inserted if Sales Cloud Connector setting is enabled
     *  
     *
     */
    public void createOpportunity(List<dealer__Sales_Up__c> triggerNew){

        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

        if(! dms.isEmpty()){
            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Sales Up to Opportunity
                List<SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__r.label, dealer__SourceField__r.label, 
                                dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                FROM dealer__SalesCloudConnectorMapping__mdt 
                                WHERE dealer__SourceObject__r.QualifiedApiName = 'dealer__Sales_Up__c' AND dealer__MappedObject__r.QualifiedApiName = 'Opportunity'];
                
                List<Id> oppIds = new List<Id>();
                Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
                for(dealer__Sales_Up__c sup : triggerNew){
                    oppIds.add(sup.dealer__Opportunity__c);
                }

                List<Opportunity> oppList = [SELECT Id, dealer__Sales_Up__C FROM Opportunity WHERE Id IN: oppIds];
                List<Opportunity> updateList = new List<Opportunity>();
                for(Opportunity opp : oppList){
                    oppMap.put(opp.Id, opp);
                }

                for(dealer__Sales_Up__c sup : triggerNew){
                    
                    //Logic for sales ups not created from a new opp
                    if(sup.dealer__Opportunity__c == null){
                        String s = sup.Name;
                        
                        Opportunity newOpp = new Opportunity();
                        newOpp.dealer__Sales_Up__c = sup.Id;
                        newOpp.name = s.replace('SALES UP', 'OPPORTUNITY');
                        newOpp.CloseDate = Date.newInstance(1970, 1, 1);
                        
                        for(SalesCloudConnectorMapping__mdt field : sc){
                            if(field.dealer__MappedField__c != null){
                                newOpp.put(field.dealer__MappedField__r.QualifiedApiName, sup.get(field.dealer__SourceField__r.QualifiedApiName));
                            }
                        }
                        updateList.add(newOpp);
                    }

                    //Indicates this was created by the opp trigger
                    if(sup.dealer__Opportunity__c != null){
                        oppMap.get(sup.dealer__Opportunity__c).dealer__Sales_Up__c = sup.Id;
                        updateList.add(oppMap.get(sup.dealer__Opportunity__c));
                    }
                }
                try{
                upsert updateList;
                } catch(DmlException e){
                    system.debug('Error updating opportunities: ' + e.getMessage());
                }
            }
        }
    }

    public void updateOpportunity(List<dealer__Sales_Up__c> triggerNew){

            List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

            if(! dms.isEmpty()){

                if(dms[0].dealer__SalesCloudConnector__c == true){
                    
                    //Get field mapping from Sales Up to Opportunity
                    List<SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__r.label, dealer__SourceField__r.label, 
                                    dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                    FROM dealer__SalesCloudConnectorMapping__mdt 
                                    WHERE dealer__SourceObject__r.QualifiedApiName = 'dealer__Sales_Up__c' AND dealer__MappedObject__r.QualifiedApiName = 'Opportunity'];
                    
                    List<Opportunity> updateList = new List<Opportunity>();
                    List<dealer__Sales_Up__c> supCreateOpp = new List<dealer__Sales_Up__c>();

                    //Iterate over sales ups in trigger.New
                    for(dealer__Sales_Up__c sup : triggerNew){
                        
                        //Only perform update if there is a referenced Opportunity 
                        if(sup.dealer__Opportunity__c != null){
                            
                            Opportunity newOpp = new Opportunity();
                            newOpp.Id = sup.dealer__Opportunity__c;
                            
                            //Iterate over mapped fields, for each field map the data from the sales up to the opp
                            for(SalesCloudConnectorMapping__mdt field : sc){
                                if(field.dealer__MappedField__c != null){
                                    newOpp.put(field.dealer__MappedField__r.QualifiedApiName, sup.get(field.dealer__SourceField__r.QualifiedApiName));
                                }
                            }
                            updateList.add(newOpp);
                        }
                        if(sup.dealer__Opportunity__c == null){
                            supCreateOpp.add(sup);
                        }
                    }
                    createOpportunity(supCreateOpp);
                    upsert updateList;
                }
            }  
    }

    /**
     * Updates vehicle fields via the Desired Vehicle record in desiredVehicle__c
     *
     *
     */
    public void updateFromDesiredVehicle(List<dealer__Sales_Up__c> triggerNew, Map<Id, dealer__Sales_Up__c> oldMap){
        List<dealer__Sales_Up__c> supList = new List<dealer__Sales_Up__c>();
        Set<Id> dvIds = new Set<Id>();
        for(dealer__Sales_Up__c sup : triggerNew){
            if(sup.DesiredVehicle__c != oldMap.get(sup.Id).DesiredVehicle__c){
                dvIds.add(sup.DesiredVehicle__c);
            }
        }
        if(dvIds.size() > 0){
            Map<Id, dealer__Desired_Vehicle__c> desiredVehicleMap = new Map<Id, dealer__Desired_Vehicle__c>([SELECT Id, Conversion__c, Exterior_Color__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, Trim_Level__c, Vehicle_Inventory__c, VIN__c, Year__c FROM dealer__Desired_Vehicle__c WHERE Id IN: dvIds]);

            for(dealer__Sales_Up__c updateSup : triggerNew){

                //Check if both desired vehicle and vehicle inventory were changed simultaneously, ignore the DV update
                if(desiredVehicleMap.get(updateSup.DesiredVehicle__c) != null && desiredVehicleMap.get(updateSup.DesiredVehicle__c).Vehicle_Inventory__c == updateSup.Desired_Stock_Num__c){
                    updateSup.ConversionPartsKit__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Conversion__c;
                    updateSup.Color_Preference_Ext__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Exterior_Color__c;
                    updateSup.Color_Preference_Int__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Interior_Color__c;
                    updateSup.Make__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Make__c;
                    updateSup.Model__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Model__c;
                    updateSup.NUO__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).New_Used_Other__c;
                    updateSup.Trim__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Trim_Level__c;
                    updateSup.Desired_Stock_Num__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Vehicle_Inventory__c;
                    updateSup.VIN__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).VIN__c;
                    updateSup.Year_High__c = desiredVehicleMap.get(updateSup.DesiredVehicle__c).Year__c;

                    String vehString = ' ';
                    if(updateSup.Year_High__c != null && updateSup.Make__c != null && updateSup.Model__c != null){
                        vehString += updateSup.dealer__Year_High__c.toLowerCase().capitalize()+' '+updateSup.dealer__Make__c.toLowerCase().capitalize()+' '+updateSup.dealer__Model__c.toLowerCase().capitalize();
                    }
                    
                    if(updateSup.dealer__FirstName__c!=null) {
                        nameString += updateSup.dealer__FirstName__c.capitalize();
                    }
                    if(updateSup.dealer__LastName__c!=null) { 
                        nameString +=' '+updateSup.dealer__LastName__c.toLowerCase().capitalize(); 
                    }
                    
                    // Fill the namestring if there is a non-person account selected and First/Last are not set.
                    if(updateSup.dealer__FirstName__c == null 
                    && updateSup.dealer__LastName__c== null 
                    && updateSup.dealer__Customer_Account__c != null
                    && custAccounts.get(updateSup.dealer__Customer_Account__c)!=null) {
                        nameString += ' '+custAccounts.get(updateSup.dealer__Customer_Account__c).Name;
                    }
                    //Name Must Be Less than 80 Characters
                    if((nameString.length() + vehString.length()) > 80 ) {
                        updateSup.Name = nameString.abbreviate( 80 - (vehString.length()) ) + vehString;
                    } else {
                        updateSup.Name = nameString+vehString;
                    }
                    updateSup.Name = updateSup.Name.trim();        
                    nameString = '';
                }
            
                

            }
                
        }
        
    }
}