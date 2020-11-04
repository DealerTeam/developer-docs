/**
 * DealControlHandler
 * @description This class is exclusively for handling trigger context operations on the Deal__c object
 */
public class DealControlHandler {

    /**
     * @description
     */
    public Set<String> enumbers                             {get;set;}
    
    /**
     * @description
     */
    public Set<String> companies                            {get;set;}
    
    /**
     * @description
     */
    public Set<String> customerExternalReference            {get;set;}
    
    /**
     * @description
     */
    public Set<ID> customerIds                              {get;set;}
    
    /**
     * @description
     */
    public Set<Id> accountIds                               {get;set;}
    
    /**
     * @description
     */
    public Set<String> vehicleExtRef                        {get;set;}
    
    /**
     * @description
     */
    public Set<Account> accountsToUpdate                    {get;set;}
    
    /**
     * @description
     */
    public Map<Id, Contact> custContacts                    {get;set;}
    public Map<Id, List<Contact>> relatedContacts           {get;set;}
    
    /**
     * @description
     */
    public Map<Id, Account> custAccounts                    {get;set;}
    
    /**
     * @description
     */
    public Map<String, Contact> contactKey                  {get;set;}
    
    /**
     * @description
     */
    public Map<Id, User> activeUserMap                      {get;set;}
    
    /**
     * @description
     */
    public Map<Id, Vehicle_Inventory__c> vehicleMap         {get;set;}
    
    /**
     * @description
     */
    public Map<Id,dealer__Deal__c> SalesUpID                {get;set;}
    
    /**
     * @description
     */
    public Map<String, String> dealStatus                   {get;set;}
    
    /**
     * @description
     */
    public List<dealer__SalesDispositions__c> dispositions  {get;set;}

    /**
     * @description
     */
     public Map<String, DMSConfig__mdt> dmsConfiguration {get;set;}

    /**
     * DealControlHandler
     * @description
     */
    public DealControlHandler(){}
    
    /**
     * DealControlHandler 
     * @param  triggerNew 
     * @description
     */
    public DealControlHandler(List<dealer__Deal__c> triggerNew)
    {
        this.initLists();
        this.loadLists(triggerNew);
    }

    /**
     * setDefaults
     * @param  triggerNew
     * @return void
     * @description Set defaults in deal create based on the mapped configurations
     */
    public void setDefaults(List<Deal__c> triggerNew)
    {

        dmsConfiguration = new Map<String, DMSConfig__mdt>();
        for(DMSConfig__mdt dmsC : [SELECT Description__c, Enabled__c, DefaultValue__c, QualifiedApiName, Value__c,
                                            NamespacePrefix, DeveloperName, Id 
                                        FROM DMSConfig__mdt]) {
            

            dmsConfiguration.put(dmsC.DeveloperName, dmsC);

        }

        Set<Id> locIds = new Set<Id>();
        // Iterate Deals and set deafults
        for(Deal__c d : triggerNew)
        {
            if(d.Deal_Date__c == null){
                d.Deal_Date__c = date.today();
            }
            d.BuyerSaveToAccount__c = getConfigValue('BuyerSaveToAccount') == 'TRUE' ? true : false;
            d.CoBuyerSaveToAccount__c = getConfigValue('CoBuyerSaveToAccount') == 'TRUE' ? true : false;
            
        }
    }

    /**
    * @method getConfigValue
    * @description compares a string for dmsConfiguration records and returns the subscriber value if present otherwise the packaged default
    * @param  configName configName description
    * @return String value of the given configuration 
    */
    private string getConfigValue(String configName)
    {
        if(dmsConfiguration.get(configName) != null){
            //First choice is if there is an override value
            if(dmsConfiguration.get(configName).DefaultValue__c != null){
                return dmsConfiguration.get(configName).DefaultValue__c;
            }
            //Second choice is the packaged default
            else if(dmsConfiguration.get(configName).Value__c != null){
                return dmsConfiguration.get(configName).Value__c;
            }
            else{
                system.debug('The given dmsConfig: ' + configName + ' did not have a value.');
                throw new DealControlHandlerException('The dmsConfiguration: ' + configName + ' has no value, please notify your administrator.');
            }
        }

        else {
            system.debug('The given dmsConfig: ' + configName + ' was not found.');
            throw new DealControlHandlerException('The dmsConfiguration: ' + configName + ' was not found, please notify your administrator.');
        }
    }

    /**
     * dataLoadSupport 
     * @param  triggerNew 
     * @return List<Deal__c>
     * @description Foreign key support for data loading
     */
    public List<Deal__c> dataLoadSupport(List<Deal__c> triggerNew) 
    {
        // Perform the SOQL Logic
        Map<String, User> activeUserEmployeeTable  = new Map<String, User>();
        Map<String, Vehicle_Inventory__c> vehicleKey = new Map<String, Vehicle_Inventory__c>();

        for(Id uId : activeUserMap.keySet()) {
            activeUserEmployeeTable.put(activeUserMap.get(uId).EmployeeNumber, activeUserMap.get(uId));
        }

        if(vehicleExtRef.size() > 0){
            for(Vehicle_Inventory__c v : [SELECT Id, VIN__c, Stock_Number__c FROM Vehicle_Inventory__c where Stock_Number__c IN:vehicleExtRef] ) {
                vehicleMap.put(v.Id, v);
                vehicleKey.put(v.Stock_Number__c, v);
            }
        }
        

        // Perform Mapping Events
        for(Deal__c d : triggerNew) {
            // 1) Buyer Contact based on External ID
            if(d.Buyer_Contact__c==null && d.Customer_Key__c!=null && contactKey.get(d.Customer_Key__c)!=null) {
                d.Buyer_Contact__c = contactKey.get(d.Customer_Key__c).Id;
            }
            // 2) Vehicle based on External ID or Stock#
            if(d.Vehicle__c==null && d.Vehicle_Key__c!=null && vehicleKey.get(d.Vehicle_Key__c)!=null) {
                d.Vehicle__c = vehicleKey.get(d.Vehicle_Key__c).Id;
            }
            // 3) Match User Records based on Employee Numbers, both Directions
            if(d.Salesperson_1_Number__c!=null && activeUserEmployeeTable.get(d.Salesperson_1_Number__c)!=null) {
                d.Salesperson_1__c = activeUserEmployeeTable.get(d.Salesperson_1_Number__c).Id;
            }
            if(d.Salesperson_2_Number__c!=null && activeUserEmployeeTable.get(d.Salesperson_2_Number__c)!=null) {
                d.Salesperson_2__c = activeUserEmployeeTable.get(d.Salesperson_2_Number__c).Id;
            }
            if(d.Desk_Manager_Number__c!=null && activeUserEmployeeTable.get(d.Desk_Manager_Number__c)!=null) {
                d.Desk_Manager__c = activeUserEmployeeTable.get(d.Desk_Manager_Number__c).Id;
            }
            if(d.F_I_Manager_Number__c!=null && activeUserEmployeeTable.get(d.F_I_Manager_Number__c)!=null) {
                d.F_I_Manager__c = activeUserEmployeeTable.get(d.F_I_Manager_Number__c).Id;
            }

        }
        return triggerNew;
    }
    public List<Deal__c> setConversionDescription(List<Deal__c> triggerNew){
        
        //Stores a list of Vehicle Inventory to query from the updated records
        Set<Id> vehicleIds = new Set<Id>();
        for(Deal__c deal : triggerNew){
            if(deal.Vehicle__c != null){
                vehicleIDs.add(deal.Vehicle__c);
            } 
        }
        //Query vehicles and create a map of vehicle data
        Map<Id, Vehicle_Inventory__c> vehicleMap = new Map<Id, Vehicle_Inventory__c>();
        for(Vehicle_Inventory__c v : [SELECT Id, Conversion_Description__c FROM Vehicle_Inventory__c WHERE Id IN: vehicleIDs]){
            vehicleMap.put(v.Id, v);
        }

        //Loop Deals in update / insert call and set conversion description from data inside vehicle map
        for(Deal__c deal : triggerNew){
            if(deal.Vehicle__c != null){
                deal.Conversion_Description__c = vehicleMap.get(deal.Vehicle__c).Conversion_Description__c;
            }
        }
        return triggerNew;
    }
    /**
     * setDealDispositionBasedOnStatus 
     * @param  triggerNew 
     * @return List<Deal__c>
     * @descripton // 1) Set Owner Id// 2) Set Location & Company Number// 3) Set Status by Disposition
     */
    public List<Deal__c> setDealDispositionBasedOnStatus(List<Deal__c> triggerNew) 
    {

        Map<String, SalesDispositions__c> dispositionMap = new Map<String, SalesDispositions__c>();  // Based on disposition status
        for(SalesDispositions__c dispositions : dealer__SalesDispositions__c.getall().values()) {
            dispositionMap.put(dispositions.dealer__Deal_Status__c, dispositions);
        }
        // Process Records
        for(Deal__c d : triggerNew) {
            d.Disposition__c = (dispositionMap.get(d.Status__c)!=null) ? dispositionMap.get(d.Status__c).Disposition__c : d.Disposition__c;
        }
        return triggerNew;
    }

    /**
     * updateDealerFields 
     * @param  allDealer 
     * @return void
     * @description updateDealerFields Before Insert
     */
    public void updateDealerFields(List<dealer__Deal__c> allDealer) 
    {
        List<dealer__Vehicle_Inventory__c> vList = new List<dealer__Vehicle_Inventory__c>();
        // Data Maps for residual records
        if(vehicleExtRef.size() > 0){
            vList = [SELECT Id, dealer__VIN__c, dealer__Stock_Number__c FROM dealer__Vehicle_Inventory__c WHERE dealer__Stock_Number__c  IN:vehicleExtRef LIMIT 2000];
        }
        Map<String, dealer__Vehicle_Inventory__c> vehicleKey = new Map<String, dealer__Vehicle_Inventory__c>();
        for(dealer__Vehicle_Inventory__c dsv : vList) {
            vehicleKey.put(dsv.dealer__Stock_Number__c, dsv);
        }

        set<Id> accountIds = new set<Id>();
        for(dealer__Deal__c d : allDealer){
            if(!accountIds.contains(d.dealer__Buyer__c)){
                accountIds.add(d.dealer__Buyer__c);
            }
        }
        
        Map<Id, Account> acctMap = new Map<Id, Account>([SELECT Id, dealer__Pricing_Strategy__c FROM Account WHERE Id IN: accountIds]);

        for(dealer__Deal__c d : allDealer) {
            // Set disposition based on SalesDisposition custom setting
            for(dealer__SalesDispositions__c ds : dispositions) {
                if(d.dealer__Status__c == ds.dealer__Deal_Status__c) {
                    d.dealer__Disposition__c=ds.dealer__Disposition__c;
                }
            }
            // Set the Deal Record Owner ID Based on the Deal, SP1, SP2 // 9-25-15 JVK // if SP2 is inactive do not attempt to change.
            if(d.OwnerId!=d.dealer__Salesperson_1__c && d.OwnerId != d.dealer__Salesperson_2__c && d.dealer__Salesperson_1__c != null) {
                if(d.dealer__Salesperson_2__c!=null) {
                    // Check for Active SP2
                    if(activeUserMap.get(d.dealer__Salesperson_2__c)!=null) {
                        d.OwnerId = d.dealer__Salesperson_2__c;
                    }
                } else {
                    if(activeUserMap.get(d.dealer__Salesperson_1__c)!=null) {
                        d.OwnerId = d.dealer__Salesperson_1__c;
                    }
                }
            }
            // Set Customer and Vehicle Record // If Customer Key present and Veh Owner not, match ID's and associate.
            if(d.dealer__Buyer_Contact__c == null && d.dealer__Customer_Key__c != null) {
                if(contactKey.get(d.dealer__Customer_Key__c)!=null) {
                    d.dealer__Buyer_Contact__c = contactKey.get(d.dealer__Customer_Key__c).Id;
                }
            }
            // Vehicle
            if(d.dealer__Vehicle__c ==null && d.dealer__Vehicle_Key__c != null) {
                if(vehicleKey.get(d.dealer__Vehicle_Key__c)!=null) {
                    d.dealer__Vehicle__c = vehicleKey.get(d.dealer__Vehicle_Key__c).Id;
                }
            }
            // Cap VIN
            if(d.dealer__VIN__c!=null) { d.dealer__VIN__c.capitalize(); }

            for(User uMatch : activeUserMap.values()) {
                // Match Salesperson 1
                if(uMatch.EmployeeNumber == d.dealer__Salesperson_1_Number__c
                        && uMatch.Division == d.dealer__Company_Number__c
                        && (d.dealer__Salesperson_1_Number__c !=null
                        && d.dealer__Company_Number__c != null)) {

                    d.dealer__Salesperson_1__c=uMatch.Id;
                    d.OwnerId = d.dealer__Salesperson_1__c;

                }
                // Match Salesperson 2
                if(uMatch.EmployeeNumber == d.dealer__Salesperson_2_Number__c
                        && uMatch.Division == d.dealer__Company_Number__c
                        && (d.dealer__Salesperson_2_Number__c !=null && d.dealer__Company_Number__c != null)) {
                    d.dealer__Salesperson_2__c=uMatch.Id;

                    // Set SP2 to record owner
                    if(d.dealer__Salesperson_2__c!=null) {
                        if(d.OwnerId != d.dealer__Salesperson_1__c && d.OwnerId != d.dealer__Salesperson_2__c) {
                            d.OwnerId = d.dealer__Salesperson_2__c;
                        }
                    }
                }
                // Match DeskManager
                if(uMatch.EmployeeNumber == d.dealer__Desk_Manager_Number__c
                        && uMatch.Division == d.dealer__Company_Number__c
                        && (d.dealer__Desk_Manager_Number__c !=null && d.dealer__Company_Number__c != null)) {
                    d.dealer__Desk_Manager__c=uMatch.Id;
                }
                // Match FI
                if(uMatch.EmployeeNumber == d.dealer__F_I_Manager_Number__c
                        && uMatch.Division == d.dealer__Company_Number__c
                        && (d.dealer__F_I_Manager_Number__c !=null && d.dealer__Company_Number__c != null)) {
                    d.dealer__F_I_Manager__c=uMatch.Id;
                }
            }

            if(d.dealer__Buyer__c != null && d.dealer__PricingStrategy__c == null){
                d.dealer__PricingStrategy__c = acctMap.get(d.Buyer__c) != null && acctMap.get(d.dealer__Buyer__c).dealer__Pricing_Strategy__c != null ? acctMap.get(d.dealer__Buyer__c).dealer__Pricing_Strategy__c: d.dealer__PricingStrategy__c;
            }
        } // End of is Before
    }

    /**
     * customersToUpdateMethod 
     * @param  allDealer 
     * @return void
     * @description Update customersToUpdateMethod - After Insert Method
     */
    public void customersToUpdateMethod( List<dealer__Deal__c> allDealer) 
    {

        List<Contact> customersToUpdate = new List<Contact>();
        for(dealer__Deal__c d : allDealer) {
            if(d.dealer__Buyer__c!=null) {
                Account accountUpdateData      =   custAccounts.get(d.dealer__Buyer__c);

                Boolean performAccountUpdate   =   false;

                if(d.dealer__Buyer_Home_Phone__c!=null && (d.dealer__Buyer_Home_Phone__c != accountUpdateData.PersonHomePhone)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonHomePhone =   d.dealer__Buyer_Home_Phone__c;
                }
                if(d.dealer__Buyer_Mobile_Phone__c!=null && (d.dealer__Buyer_Mobile_Phone__c != accountUpdateData.PersonMobilePhone)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonMobilePhone = d.dealer__Buyer_Mobile_Phone__c;
                }
                if(d.dealer__Buyer_Email__c!=null && (d.dealer__Buyer_Email__c != accountUpdateData.PersonEmail)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonEmail =   d.dealer__Buyer_Email__c;
                }
                if(d.dealer__Buyer_Address__c!=null && (d.dealer__Buyer_Address__c != accountUpdateData.PersonMailingStreet)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonMailingStreet=d.dealer__Buyer_Address__c;
                }
                if(d.dealer__Buyer_City__c!=null && (d.dealer__Buyer_City__c != accountUpdateData.PersonMailingCity)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonMailingCity=d.dealer__Buyer_City__c;
                }
                if(d.dealer__Buyer_State__c!=null && (d.dealer__Buyer_State__c != accountUpdateData.PersonMailingState)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonMailingState=d.dealer__Buyer_State__c;
                }
                if(d.dealer__Buyer_Postal_Code__c!=null && (d.dealer__Buyer_Postal_Code__c != accountUpdateData.PersonMailingPostalCode)) {
                    performAccountUpdate=true;
                    accountUpdateData.PersonMailingPostalCode=d.dealer__Buyer_Postal_Code__c;
                }
                if(performAccountUpdate==true) {
                    if(accountUpdateData.FirstName!=null&&accountUpdateData.LastName!=null&&accountUpdateData.FirstName!=''&&accountUpdateData.LastName!='') {
                        accountsToUpdate.add(accountUpdateData);
                    }
                }
            }
            //end MKS4c//&& d.dealer__Buyer_Contact__c.getSObjectType().getDescribe().getName() == 'Contact'
            if(d.dealer__Buyer_Contact__c!=null && d.dealer__Buyer_Contact__c != d.dealer__Buyer__c && custContacts.get(d.dealer__Buyer_Contact__c) != null
                    && custAccounts.get( custContacts.get(d.dealer__Buyer_Contact__c).AccountId) != null
                    && !custAccounts.get( custContacts.get(d.dealer__Buyer_Contact__c).AccountId).isPersonAccount) {
                Contact contactUpdateData       =   custContacts.get(d.dealer__Buyer_Contact__c);
                Boolean performCustomerUpdate   =   false;

                if(d.dealer__Buyer_Home_Phone__c!=null && (d.dealer__Buyer_Home_Phone__c != contactUpdateData.HomePhone)) {
                    performCustomerUpdate=true;
                    contactUpdateData.HomePhone =   d.dealer__Buyer_Home_Phone__c;
                }
                if(d.dealer__Buyer_Mobile_Phone__c!=null && (d.dealer__Buyer_Mobile_Phone__c != contactUpdateData.MobilePhone)) {
                    performCustomerUpdate=true;
                    contactUpdateData.MobilePhone = d.dealer__Buyer_Mobile_Phone__c;
                }
                if(d.dealer__Buyer_Email__c!=null && (d.dealer__Buyer_Email__c != contactUpdateData.Email)) {
                    performCustomerUpdate=true;
                    contactUpdateData.Email =   d.dealer__Buyer_Email__c;
                }
                if(d.dealer__Buyer_Address__c!=null && (d.dealer__Buyer_Address__c != contactUpdateData.MailingStreet)) {
                    performCustomerUpdate=true;
                    contactUpdateData.MailingStreet=d.dealer__Buyer_Address__c;
                }
                if(d.dealer__Buyer_City__c!=null && (d.dealer__Buyer_City__c != contactUpdateData.MailingCity)) {
                    performCustomerUpdate=true;
                    contactUpdateData.MailingCity=d.dealer__Buyer_City__c;
                }
                if(d.dealer__Buyer_State__c!=null && (d.dealer__Buyer_State__c != contactUpdateData.MailingState)) {
                    performCustomerUpdate=true;
                    contactUpdateData.MailingState=d.dealer__Buyer_State__c;
                }
                if(d.dealer__Buyer_Postal_Code__c!=null && (d.dealer__Buyer_Postal_Code__c != contactUpdateData.MailingPostalCode)) {
                    performCustomerUpdate=true;
                    contactUpdateData.MailingPostalCode=d.dealer__Buyer_Postal_Code__c;
                }
                if(performCustomerUpdate==true) {
                    if(contactUpdateData.FirstName!=null&&contactUpdateData.LastName!=null&&contactUpdateData.FirstName!=''&&contactUpdateData.LastName!='') {
                        customersToUpdate.add(contactUpdateData);
                    }
                }
            }//end if buyer contact not null
        }//end iteration
        if(customersToUpdate.size()>0) {
            update customersToUpdate;
        }
        //Update Account list if populated
        if(accountsToUpdate.size()>0){
            List<Account> ListForUpdate = new List<Account>();
            ListForUpdate.addAll(accountsToUpdate);
            update ListForUpdate;
        }
    }
    //end if update context */

    /**
     * salesUpMethod 
     * @param  allDealer 
     * @return void
     * @description pdate SalesUpMethod - After Method
     */ 
    public void salesUpMethod( List<dealer__Deal__c> allDealer ) 
    {

		Map<Id, Deal__c> dealMap = new Map<Id, Deal__c>();
        dealer__DMS_Settings__c dealControlsSalesUpSetting = dealer__DMS_Settings__c.getValues('ActiveSettings');
        Boolean dealControlsSalesUp = false;
        
        //If SalesUp has a deal attached, sup status is updated by deal status
        if(dealControlsSalesUpSetting != null && dealControlsSalesUpSetting.dealer__Deal_Status_Controls_Sales_Up_Status__c) {
            dealControlsSalesUp = true;
        }

        // Get List of Sales Up ID's
        // Change Sales Up Status Based on Deal Status
        for(dealer__Deal__c suList : allDealer) {
       
            //  Get the Sales Up Associated With the Deal.
            //  Prepares a reverse association of the SalesUP to the Deal
            if(suList.dealer__Sales_Lead__c != null){
                //Associate the related Sales Up with the updated Deal
                SalesUpID.Put(suList.dealer__Sales_Lead__c, suList);
            }
            
            dealMap.put(suList.Id, suList);
        }

        Map<Id, dealer__Sales_Up__c> Salesups = new Map<Id, dealer__Sales_Up__c> ([Select ID,dealer__Car_Deal__c, dealer__Desired_Stock_Num__c, dealer__Car_Deal__r.dealer__Status__c, dealer__Lead_Status__c, dealer__Change_Status__c
            								from dealer__Sales_Up__c where ID=:SalesUpID.keyset()]);
        
        boolean changed = false;
        for(dealer__Sales_Up__c s : Salesups.values()){
                
            s.dealer__Change_Status__c = true;
            //deal status
            String currentStatus = SalesUpID.get(s.Id).dealer__Status__c;

            if(dealStatus.get(currentStatus) != null && 
               (s.dealer__Lead_Status__c != dealStatus.get(currentStatus))){
                   s.dealer__Lead_Status__c = dealStatus.get(currentStatus);
                   changed = true;
               }
        }
        
        Integer size = 10000;
        Integer qLimit = 1;
        if(Limits.getLimitQueryRows() - Limits.getQueryRows() > size){
                qLimit = size;
            
        } else if (Limits.getLimitQueryRows() - Limits.getQueryRows() > qLimit){      
              qLimit = Limits.getLimitQueryRows() - Limits.getQueryRows();
        }
        List<dealer__Sales_Up__c> supsWithDeal = [Select ID, dealer__Car_Deal__c, dealer__Desired_Stock_Num__c
            										from dealer__Sales_Up__c where dealer__Car_Deal__c=:dealMap.keySet() LIMIT: qLimit];
        
        for(dealer__Sales_Up__c s: supsWithDeal){
       
            if(s.dealer__Desired_Stock_Num__c != dealMap.get(s.dealer__Car_Deal__c).dealer__Vehicle__c ){
                s.dealer__Desired_Stock_Num__c = dealMap.get(s.dealer__Car_Deal__c).dealer__Vehicle__c; 
                changed = true;
                if(Salesups.containsKey(s.Id)){
                    Salesups.get(s.Id).dealer__Desired_Stock_Num__c = s.dealer__Desired_Stock_Num__c;
                }else{
                    Salesups.put(s.Id, s);
                }
            }
        }
        
        if(SalesUpCreateflag.firstrun && changed) {
            
            SalesUpCreateflag.firstrun=false;
            try{
                update Salesups.values();
            }catch(Exception e){
                e.getMessage();
            }
        }
    }

    /**
     * initLists 
     * @return void
     * @description
     */ 
    private void initLists() 
    {
        this.enumbers                   = new Set<String>();
        this.companies                  = new Set<String>();
        this.customerExternalReference  = new Set<String>();
        this.customerIds                = new Set<ID>();
        this.accountIds                 = new Set<Id>();
        this.vehicleExtRef              = new Set<String>();
        this.accountsToUpdate           = new Set<Account>();
        this.custContacts               = new Map<Id, Contact>();
        this.relatedContacts            = new Map<Id, List<Contact>>();
        this.activeUserMap              = new Map<Id, User>();
        this.contactKey                 = new Map<String, Contact>();
        this.SalesUpID                  = new Map<Id,dealer__Deal__c>();
        this.vehicleMap                 = new Map<Id, Vehicle_Inventory__c>();
        this.dealStatus                 = new Map<String, String>();
        this.dispositions               = new List<dealer__SalesDispositions__c>();
    }

    /**
     * loadLists 
     * @param  allDealer 
     * @return void
     * @description
     */ 
    private void loadLists( List<dealer__Deal__c> allDealer ) 
    {

        for ( dealer__Deal__c en: allDealer  ) {
            if(!enumbers.contains(en.dealer__Salesperson_1_Number__c)) {
                enumbers.add(en.dealer__Salesperson_1_Number__c);
            }
            if(!enumbers.contains(en.dealer__Salesperson_2_Number__c)) {
                enumbers.add(en.dealer__Salesperson_2_Number__c);
            }
            if(!enumbers.contains(en.dealer__Desk_Manager_Number__c)) {
                enumbers.add(en.dealer__Desk_Manager_Number__c);
            }
            if(!enumbers.contains(en.dealer__F_I_Manager_Number__c)) {
                enumbers.add(en.dealer__F_I_Manager_Number__c);
            }
            if(!companies.contains(en.dealer__Company_Number__c)) {
                companies.add(en.dealer__Company_Number__c);
            }
            if(en.dealer__Customer_Key__c  != null && (!customerExternalReference.contains(en.dealer__Customer_Key__c))) {
                customerExternalReference.add(en.dealer__Customer_Key__c);
            }
            if(en.dealer__Vehicle_Key__c != null && (!vehicleExtRef.contains(en.dealer__Vehicle_Key__c))) {
                vehicleExtRef.add(en.dealer__Vehicle_Key__c);
            }
            // Buyer Record ID
            if(en.dealer__Buyer_Contact__c != null) {
                customerIds.add(en.dealer__Buyer_Contact__c);
            }
            // Co-Buyer Record ID
            if(en.Co_Buyer_Contact__c!=null) {
                customerIds.add(en.Co_Buyer_Contact__c);
            }
            //Buyer Account ID
            if(en.dealer__Buyer__c != null) {
                accountIds.add(en.dealer__Buyer__c);
            }
            //Buyer Account ID
            if(en.dealer__Co_Buyer__c != null) {
                accountIds.add(en.dealer__Co_Buyer__c);
            }
        }

        for(Contact c : [SELECT Id, AccountId, External_ID__c, FirstName, MiddleName, LastName, MobilePhone, HomePhone, Phone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode, Drivers_License_Number__c, Drivers_License_State__c, Drivers_License_Expiration_Date__c, Birthdate FROM Contact WHERE External_ID__c IN: customerExternalReference OR Id IN: customerIds OR (AccountId IN: accountIds AND AccountId != null)]) {
            this.custContacts.put(c.Id, c);
            this.contactKey.put(c.External_ID__c, c);
            if(this.relatedContacts.get(c.AccountId) == null){
                this.relatedContacts.put(c.AccountId, new List<Contact>());
                this.relatedContacts.get(c.AccountId).add(c);
            }else{
                this.relatedContacts.get(c.AccountId).add(c);
            }
        }

        // Create a User Map to search users to see if they are active
        this.activeUserMap = (!this.enumbers.isEmpty()) ? new Map<Id, User>([SELECT Id, EmployeeNumber, Division FROM User WHERE EmployeeNumber IN:enumbers AND IsActive = true]) : new Map<Id, User>();
        this.custAccounts = (!this.accountIds.isEmpty()) ? new Map<Id, Account>([SELECT Id, FirstName, LastName, MiddleName, PersonEmail, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, Phone, PersonMobilePhone, PersonHomePhone, IsPersonAccount, Drivers_License_Number__pc, Drivers_License_State__pc, Drivers_License_Expiration_Date__pc, PersonBirthdate, Tax_ID__c, PersonContactId FROM Account WHERE Id IN:accountIds]) : new Map<Id, Account>();

        dispositions = dealer__SalesDispositions__c.getall().values();
        for(dealer__SalesDispositions__c obj: dispositions) {
            dealStatus.put(obj.dealer__Deal_Status__c, obj.dealer__SalesUp_Status__c);
        }
    }

    /**
     * sumTaxes 
     * @param  triggerNew 
     * @return void
     * @description
     */ 
    public void sumTaxes(List<Deal__c> triggerNew)
    {
        // Get a list of deals
        Set<Id> dealIds = new Set<Id>();
        for(Deal__c deal : triggerNew)
        {
            dealIds.add(deal.Id);
        }

        // Iterate an aggregate list
        Map<Id, Decimal> totalTax = new Map<Id, Decimal>();
        for(AggregateResult a : [SELECT DealTax__c, SUM(Tax__c) totalTax FROM TaxTransactionItem__c WHERE Id IN:dealIds Group By DealTax__c]) {
            totalTax.put((Id)a.get('DealTax__c'), (Decimal)a.get('totalTax'));
        }

        // Apply Values to the Deal
        for(Deal__c deal : triggerNew)
        {
            if(totalTax.get(deal.Id)!=null) {
                deal.Sales_Tax__c = totalTax.get(deal.Id);
            }
        }
    }

    /**
     * salesFeesUpdateMethod 
     * @param  triggerNewMap 
     * @param  triggerOldMap 
     * @return void
     * @description
     */ 
    public void salesFeesUpdateMethod(Map<Id, Deal__c> triggerNewMap, Map<Id, Deal__c> triggerOldMap)
    {
        //If vehicle is changed on a deal, refresh default deal fees.
        List<Deal__C> changedDeals = new List<Deal__c>();
        for (Deal__c newDeal : triggerNewMap.values()) {
            if(newDeal.Vehicle__c != triggerOldMap.get(newDeal.Id).Vehicle__c){
                changedDeals.add(newDeal);
            }
        }  
        if(changedDeals != null){
            try{
                deleteDealFees(changedDeals);
                createDefaultFees(changedDeals);
            } catch (DmlException e){
                throw new DmlException(e.getMessage());
            }
        }     
    }

    /**
     * deleteDealFees 
     * @param  deals 
     * @return void
     * @description
     */ 
    public void deleteDealFees(List<Deal__c> deals)
    {
        Set<Id> dealIds = new set<Id>();
        for(Deal__c d : deals){
            dealIds.add(d.Id);
        }
        List<Sales_Fee__c> feesToDelete = new List<Sales_Fee__c>();
        try{
            feesToDelete = [SELECT Id FROM Sales_Fee__c WHERE Car_Deal__c In: dealIds];
        }catch(QueryException e){
            e.getMessage();
        }
        if(feesToDelete.size() > 0){
            try{
                delete feesToDelete;
            }catch(DmlException e){
                throw new DmlException(e.getMessage());
            } 
        }
    }
    
    /**
     * createDefaultFees 
     * @return void
     * @description
     */
    public void createDefaultFees(List < Deal__c > deals) 
    {
        Map<id, Deal__c> newMap = new Map<id,Deal__c>();
        Set < Id > dealIdSet = new Set < Id > ();

        //Keep a copy of the deals in memory for the Eval function.
        for (dealer__Deal__c d: deals) {
            newMap.put(d.Id,d);
            dealIdSet.add(d.Id);
        }
        //Acquire location - Also ensure each deal object has its cooresponding location in memory
        Map < Id, List < LocationFee__c > > locationFeeMap = new Map < Id, List < LocationFee__c > > (); //dealer_location, Fee object
        deals = new List < dealer__Deal__c > ();        for (dealer__Deal__c d: [SELECT Id, dealer__Store_Location__c FROM dealer__Deal__c WHERE Id IN: dealIdSet]) {
            locationFeeMap.put(d.dealer__Store_Location__c, new List<LocationFee__c>());
            deals.add(d);
        }

        // Acquire Sales Fees for each location.
        LocationFee__c [] fees = [SELECT Active__c, DefaultCost__c, DefaultOnInvoice__c, DefaultPrice__c, Description__c, 
                                    FeeCode__c, InvoiceType__c, Taxable__c, FeeMaster__c, Location__c, 
                                    QuickPrice__c, QuickCost__c, Name, Id, Printable__c
                                    FROM LocationFee__c WHERE Location__c IN:locationFeeMap.KeySet()];

        for(LocationFee__c fee: fees) {
            locationFeeMap.get(fee.Location__c).add(fee);
        }

        List < dealer__Sales_Fee__c > salesFees = new List < dealer__Sales_Fee__c > ();
        for (dealer__Deal__c d: deals) {
            if (locationFeeMap.get(d.dealer__Store_Location__c) != null && locationFeeMap.get(d.dealer__Store_Location__c).size() > 0) {
                
                for (LocationFee__c fee: locationFeeMap.get(d.dealer__Store_Location__c)) {
                    
                    Boolean defaultOnDeals = fee.DefaultOnInvoice__c;
                    Decimal feeAmount = Decimal.valueOf(String.ValueOf(new EvalExpression(fee.DefaultPrice__c).matching(newMap.get(d.Id).getpopulatedfieldsasmap()).eval()));
                    Decimal feeCost = Decimal.valueOf(String.ValueOf(new EvalExpression(fee.DefaultCost__c).matching(newMap.get(d.Id).getpopulatedfieldsasmap()).eval()));

                    if (defaultOnDeals){
                        salesFees.add(new dealer__Sales_Fee__c(
                            dealer__Car_Deal__c = d.Id,
                            dealer__Description__c = fee.Description__c,
                            dealer__Fee_Code__c = fee.FeeCode__c,
                            dealer__Default_Amount_Formula_Field__c = fee.QuickPrice__c,
                            dealer__Taxable__c = fee.Taxable__c,
                            dealer__Printable__c = fee.Printable__c,
                            dealer__Fee_Amount__c = feeAmount,
                            FeeCost__c = feeCost,
                            dealer__Fee_Name__c = fee.Name
                        ));
                    }
                }

            }
        }
        if (salesFees.size() > 0) {
            try {
                insert salesFees;
            } catch (DmlException e) {
                throw new DmlException(e.getMessage());
            }
        }
    }

    /**
     * updateOpportunity 
     * @param  triggerNew 
     * @return void
     * @description
     */ 
    public void updateOpportunity(List<dealer__Deal__c> triggerNew)
    {

        List<dealer__DMS_Settings__c> dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];

        if(!dms.isEmpty()){

            if(dms[0].dealer__SalesCloudConnector__c == true){
                
                //Get field mapping from Deal to Opportunity
                List<SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__r.label, dealer__SourceField__r.label, 
                                dealer__MappedObject__r.label, dealer__MappedField__r.label, dealer__MappedField__r.QualifiedApiName, dealer__SourceField__r.QualifiedApiName
                                FROM dealer__SalesCloudConnectorMapping__mdt 
                                WHERE dealer__SourceObject__r.QualifiedApiName = 'dealer__Deal__c' AND dealer__MappedObject__r.QualifiedApiName = 'Opportunity'];
                
                List<Opportunity> updateList = new List<Opportunity>();
                Map<String, dealer__Sales_Up__c> supMap = new Map<String, dealer__Sales_Up__c>(); 
                List<dealer__Sales_Up__c> supList = [SELECT Id, dealer__Opportunity__c, dealer__Car_Deal__c FROM dealer__Sales_Up__c WHERE dealer__Car_Deal__c IN: triggerNew];
                for(dealer__Sales_Up__c sup :supList){
                    supMap.put(sup.dealer__Car_Deal__c, sup);
                }
                //Iterate over deals in trigger.New
                for(dealer__Deal__c d : triggerNew){
                    
                    if(supMap.get(d.Id) != null){
                        Id oppId = supMap.get(d.Id).dealer__Opportunity__c != null ? supMap.get(d.Id).dealer__Opportunity__c : null;
                    
                        //Only perform update if the deal is the primary deal on a sales up and opportunity exists 
                        if(oppId != null){
                            
                            Opportunity newOpp = new Opportunity();
                            newOpp.Id = oppId;
                            
                            //Iterate over mapped fields, for each field map the data from the sales up to the opp
                            for(SalesCloudConnectorMapping__mdt field : sc){
                                if(field.dealer__MappedField__c != null){
                                    newOpp.put(field.dealer__MappedField__r.QualifiedApiName, d.get(field.dealer__SourceField__r.QualifiedApiName));
                                    if(field.dealer__MappedField__r.QualifiedApiName == 'CloseDate' && d.get(field.dealer__SourceField__r.QualifiedApiName) == null){
                                        newOpp.CloseDate = Date.newInstance(1970, 1, 1);
                                    }
                                }
                            }
                            updateList.add(newOpp);
                        }
                    }
                }
                update updateList;
            }
        } 
    }

    /**
     * updateRelatedPricing 
     * @param  triggerNew    
     * @param  triggerOldMap 
     * @return void
     * @description 
     */ 
    public void updateRelatedPricing(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap)
    {
        
        List<Deal__C> changedDeals = new List<Deal__c>();
        for (Deal__c newDeal : triggerNew) {
            if(newDeal.dealer__PricingStrategy__c != triggerOldMap.get(newDeal.Id).dealer__PricingStrategy__c){
                changedDeals.add(newDeal);
            }
        }

        if(changedDeals.size() > 0){
            set<Id> pmIds = new set<Id>();
            set<Id> psIds = new set<Id>();        
            for(dealer__Deal__c d : changedDeals){
                if(d.dealer__PricingStrategy__c != null){
                    if(!psIds.contains(d.dealer__PricingStrategy__c)){
                        psIds.add(d.dealer__PricingStrategy__c);
                    }
                }
            }
            
            Map<Id, Parts_Service_Pricing_Strategy__c> psMap = new Map<Id, Parts_Service_Pricing_Strategy__c>();
            //Get pricing strategy and related records that need pricing updates
            if(psIds.size() > 0){
                psMap.putAll([SELECT Id, dealer__Method__c FROM dealer__Parts_Service_Pricing_Strategy__c WHERE Id IN: psIds]);
            }
            List<dealer__After_Market__c> amList = [SELECT Id, dealer__Car_Deal__c, dealer__Part__c, dealer__Part__r.dealer__Parts_Master__c, dealer__Parts_Kit__c, dealer__Parts_Kit__r.dealer__ScheduledPrice__c, dealer__Part_Unit_Price__c, dealer__Parts_Sale__c, dealer__Sale_Price__c FROM dealer__After_Market__C WHERE dealer__Car_Deal__c IN: changedDeals];
            List<dealer__After_Market__c> amUpdate = new List<dealer__After_Market__c>();
            // List<dealer__Deal__c> dealsUpdate = new List<dealer__Deal__c>();

            for(dealer__After_Market__c a : amList){
                if(a.dealer__Part__c != null && a.dealer__Part__r.dealer__Parts_Master__c != null){
                    if(!pmIds.contains(a.dealer__Part__r.dealer__Parts_Master__c)){
                        pmIds.add(a.dealer__Part__r.dealer__Parts_Master__c);
                    }
                }
                
            }
            List<dealer__Parts_Kit_Item__c> pkiList = new List<Parts_Kit_Item__c>();
            if(pmIds.size() > 0){
                pkiList = [SELECT dealer__Parts_Master__c, dealer__Extended_List__c, dealer__ScheduledPrice__c FROM dealer__Parts_Kit_Item__c WHERE dealer__Parts_Master__c IN: pmIds];
            }
            map<Id, dealer__Parts_Kit_Item__c> pkiMap = new map<Id, dealer__Parts_Kit_Item__c>();
            for(dealer__Parts_Kit_Item__c pki : pkiList){
                pkiMap.put(pki.dealer__Parts_Master__c, pki);
            }
            
            for(dealer__Deal__c d : changedDeals){
                //proceed if related pricing strategy method = Schedule
                if(d.dealer__PricingStrategy__c != null){
                    if(psMap.get(d.dealer__PricingStrategy__c).dealer__Method__c == 'Schedule'){
                        //update After Market records with scheduled price
                        for(dealer__After_Market__c am : amList){
                            if(am.dealer__Car_Deal__c == d.Id && am.dealer__Part__c != null && am.dealer__Part__r.dealer__Parts_Master__c != null && pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c) != null){
                                am.dealer__Parts_Sale__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c : am.dealer__Parts_Sale__c;
                                am.dealer__Sale_Price__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c : am.dealer__Sale_Price__c;
                                amUpdate.add(am);
                            }
                        }
                    }
                    else if(psMap.get(d.dealer__PricingStrategy__c).dealer__Method__c != 'Schedule'){
                        //update After Market records with list price
                        for(dealer__After_Market__c am : amList){
                            if(am.dealer__Car_Deal__c == d.Id && am.dealer__Part__c != null && am.dealer__Part__r.dealer__Parts_Master__c != null && pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c) != null){
                                am.dealer__Parts_Sale__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c : am.dealer__Parts_Sale__c;
                                am.dealer__Sale_Price__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c : am.dealer__Sale_Price__c;
                                amUpdate.add(am);
                            }
                        }
                    }
                }
                else{
                    for(dealer__After_Market__c am : amList){
                            if(am.dealer__Car_Deal__c == d.Id && am.dealer__Part__c != null && am.dealer__Part__r.dealer__Parts_Master__c != null && pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c) != null){
                                am.dealer__Parts_Sale__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c == am.dealer__Parts_Sale__c && pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c : am.dealer__Parts_Sale__c;
                                am.dealer__Sale_Price__c = pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__ScheduledPrice__c == am.dealer__Sale_Price__c && pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c != null ? pkiMap.get(am.dealer__Part__r.dealer__Parts_Master__c).dealer__Extended_List__c : am.dealer__Sale_Price__c;
                                amUpdate.add(am);
                            }
                        }
                }
            }
            if(amUpdate.size() > 0){
                update amUpdate;
            }  
        }
         
    }
    //Updates conversion_price__c based on pricing strategy
    public void updateSchedulePricing(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        List<Deal__C> changedDeals = new List<Deal__c>();
        if(triggerOldMap != null){
            for (Deal__c newDeal : triggerNew) {

                if(newDeal.dealer__PricingStrategy__c != triggerOldMap.get(newDeal.Id).dealer__PricingStrategy__c || newDeal.dealer__Vehicle__c != triggerOldMap.get(newDeal.Id).dealer__Vehicle__c){
                    changedDeals.add(newDeal);
                }
            }
        }
        else{
            changedDeals = triggerNew;
        }
        if(changedDeals.size() > 0){
            set<Id> psIds = new set<Id>();
            set<Id> viIds = new set<Id>();
            
            for(dealer__Deal__c d : changedDeals){
                if(d.dealer__PricingStrategy__c != null){
                    if(!psIds.contains(d.dealer__PricingStrategy__c)){
                        psIds.add(d.dealer__PricingStrategy__c);
                    }
                }
                    if(!viIds.contains(d.dealer__Vehicle__c)){
                        viIds.add(d.dealer__Vehicle__c);
                    }
                
            }
            Map<Id, Vehicle_Inventory__c> viMap = new Map<Id, Vehicle_Inventory__c>();
            Map<Id, Parts_Service_Pricing_Strategy__c> psMap = new Map<Id, Parts_Service_Pricing_Strategy__c>();
            if(viIds.size() > 0){
                viMap.putall([SELECT Id, dealer__Conversion_Price__c, dealer__Conversion__r.dealer__ScheduledPrice__c FROM dealer__Vehicle_Inventory__c WHERE Id IN: viIds]);
            }
            if(psIds.size() > 0){
                psMap.putAll([SELECT Id, dealer__Method__c FROM dealer__Parts_Service_Pricing_Strategy__c WHERE Id IN: psIds]);
            }

            for(dealer__Deal__c d : changedDeals){
                //proceed if related pricing strategy method = Schedule
                if(d.dealer__PricingStrategy__c != null){
                    if(psMap.get(d.dealer__PricingStrategy__c).dealer__Method__c == 'Schedule'){
                        if(d.dealer__Vehicle__c != null){
                            dealer__Vehicle_Inventory__c vi = viMap.get(d.dealer__Vehicle__c);
                                if(vi.dealer__Conversion__c != null){
                                    if(vi.dealer__Conversion__r.dealer__ScheduledPrice__c != null && vi.dealer__Conversion__r.dealer__ScheduledPrice__c > 0){
                                        d.dealer__Conversion_Price__c = vi.dealer__Conversion__r.dealer__ScheduledPrice__c;
                                    }
                                }
                                        
                        }
                    }
                    else if(psMap.get(d.dealer__PricingStrategy__c).dealer__Method__c != 'Schedule'){
                        if(d.dealer__Vehicle__c != null){
                            dealer__Vehicle_Inventory__c vi = viMap.get(d.dealer__Vehicle__c);
                            if(vi.dealer__Conversion_Price__c > 0 && vi.dealer__Conversion_Price__c != null){
                                d.dealer__Conversion_Price__c = vi.dealer__Conversion_Price__c;
                            }
                        }
                    }
                }
                else{
                    if(d.dealer__Vehicle__c != null){
                        dealer__Vehicle_Inventory__c vi = viMap.get(d.dealer__Vehicle__c);
                        if(vi.dealer__Conversion__r.dealer__ScheduledPrice__c == d.dealer__Conversion_Price__c && vi.dealer__Conversion_Price__c != null){
                            d.dealer__Conversion_Price__c = vi.dealer__Conversion_Price__c;
                        }
                    }
                }
            }
        }
        
    }
    /**
     * handleAccountUpdate updates buyer and co buyer fields from b2c account when buyer/cobuyer account is changed on a deal
     * @param  triggerNew    trigger.New
     * @param  triggerOldMap trigger.OldMap
     */
    public void handleAccountUpdate(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        //Set buyer/co buyer fields to those from Account when account lookup is changed, ignore buyer/cobuyer swap
        List<Deal__c> updatedBuyer = new List<Deal__c>();
        List<Deal__c> updatedCoBuyer = new List<Deal__c>();
        for(Deal__c deal : triggerNew){
            if(deal.Buyer__c != null && deal.Buyer__c != triggerOldMap.get(deal.Id).Buyer__c && deal.Buyer__c != triggerOldMap.get(deal.Id).Co_Buyer__c){
                if(!updatedBuyer.contains(deal)){
                    updatedBuyer.add(deal);
                }
            }
            if(deal.Co_Buyer__c != null && deal.Co_Buyer__c != triggerOldMap.get(deal.Id).Buyer__c && deal.Co_Buyer__c != triggerOldMap.get(deal.Id).Co_Buyer__c){
                if(!updatedCoBuyer.contains(deal)){
                    updatedCoBuyer.add(deal);
                }
            }
        }
        //Populate buyer fields from the selected b2c buyer account
        for(Deal__c deal : updatedBuyer){
            Account buyer = custAccounts.get(deal.Buyer__c);
            if(buyer.isPersonAccount == true){       
                deal.Buyer_Contact__c = buyer.PersonContactId;
                deal.Buyer_First_Name__c = buyer.FirstName;
                deal.Buyer_Middle_Name__c = buyer.MiddleName;
                deal.Buyer_Home_Phone__c = buyer.PersonHomePhone;
                deal.Buyer_Mobile_Phone__c = buyer.PersonMobilePhone;
                deal.Buyer_Email__c = buyer.PersonEmail;
                deal.Buyer_Drivers_License__c = buyer.Drivers_License_Number__pc;
                deal.Buyer_Drivers_Lic_State__c = buyer.Drivers_License_State__pc;
                deal.Buyer_Drivers_License_Exp_Date__c = buyer.Drivers_License_Expiration_Date__pc;
                deal.Buyer_Last_Name__c = buyer.LastName;
                deal.Buyer_Address__c = buyer.PersonMailingStreet;
                deal.Buyer_City__c = buyer.PersonMailingCity;
                deal.Buyer_State__c = buyer.PersonMailingState;
                deal.Buyer_Postal_Code__c = buyer.PersonMailingPostalCode;
                deal.Buyer_Birthdate__c = buyer.PersonBirthdate;
            //Set the contact if b2b buyer has exactly 1 related contact
            } else if(relatedContacts.get(deal.Buyer__c) != null && relatedContacts.get(deal.Buyer__c).size() == 1){
                deal.BuyerSaveToAccount__c = false;
                deal.Buyer_Contact__c = relatedContacts.get(deal.Buyer__c)[0].Id;
            //Set buyer fields to null for other b2b scenarios
            } else{
                deal.BuyerSaveToAccount__c = false;
                deal.Buyer_Contact__c = null;
                deal.Buyer_First_Name__c = null;
                deal.Buyer_Middle_Name__c = null;
                deal.Buyer_Home_Phone__c = null;
                deal.Buyer_Mobile_Phone__c = null;
                deal.Buyer_Email__c = null;
                deal.Buyer_Drivers_License__c = null;
                deal.Buyer_Drivers_Lic_State__c = null;
                deal.Buyer_Drivers_License_Exp_Date__c = null;
                deal.Buyer_Last_Name__c = null;
                deal.Buyer_Address__c = null;
                deal.Buyer_City__c = null;
                deal.Buyer_State__c = null;
                deal.Buyer_Postal_Code__c = null;
                deal.Buyer_Social_Security_Number__c = null;
                deal.Buyer_Birthdate__c = null;
            }
        }
        //Populate co-buyer fields from the selected b2c co-buyer account
        for(Deal__c deal : updatedCoBuyer){
            Account buyer = custAccounts.get(deal.Co_Buyer__c);
            if(buyer.isPersonAccount == true){       
                deal.Co_Buyer_Contact__c = buyer.PersonContactId;
                deal.Co_Buyer_First_Name__c = buyer.FirstName;
                deal.Co_Buyer_Middle_Name__c = buyer.MiddleName;
                deal.Co_Buyer_Home_Phone__c = buyer.PersonHomePhone;
                deal.Co_Buyer_Mobile_Phone__c = buyer.PersonMobilePhone;
                deal.Co_Buyer_Email__c = buyer.PersonEmail;
                deal.Co_Buyer_Drivers_License_Number__c = buyer.Drivers_License_Number__pc;
                deal.Co_Buyer_Drivers_Lic_State__c = buyer.Drivers_License_State__pc;
                deal.Co_Buyer_Drivers_License_Exp_Date__c = buyer.Drivers_License_Expiration_Date__pc;
                deal.Co_Buyer_Last_Name__c = buyer.LastName;
                deal.Co_Buyer_Address__c = buyer.PersonMailingStreet;
                deal.Co_Buyer_City__c = buyer.PersonMailingCity;
                deal.Co_Buyer_State__c = buyer.PersonMailingState;
                deal.Co_Buyer_Postal_Code__c = buyer.PersonMailingPostalCode;
                deal.Co_Buyer_Birth_Date__c = buyer.PersonBirthdate;
            
            //Set the co-buyer contact if b2b buyer account has exactly 1 related contact
            }else if(relatedContacts.get(deal.Co_Buyer__c) != null && relatedContacts.get(deal.Co_Buyer__c).size() == 1){
                deal.CoBuyerSaveToAccount__c = false;
                deal.Co_Buyer_Contact__c = relatedContacts.get(deal.Co_Buyer__c)[0].Id;
            
            //Set co-buyer fields to null for other b2b scenarios
            } else{
                deal.Co_Buyer_Contact__c = null;
                deal.Co_Buyer_First_Name__c = null;
                deal.Co_Buyer_Middle_Name__c = null;
                deal.Co_Buyer_Home_Phone__c = null;
                deal.Co_Buyer_Mobile_Phone__c = null;
                deal.Co_Buyer_Email__c = null;
                deal.Co_Buyer_Drivers_License_Number__c = null;
                deal.Co_Buyer_Drivers_Lic_State__c = null;
                deal.Co_Buyer_Drivers_License_Exp_Date__c = null;
                deal.Co_Buyer_Last_Name__c = null;
                deal.Co_Buyer_Address__c = null;
                deal.Co_Buyer_City__c = null;
                deal.Co_Buyer_State__c = null;
                deal.Co_Buyer_Postal_Code__c = null;
                deal.Co_Buyer_Social_Security_Number__c = null;
                deal.Co_Buyer_Birth_Date__c = null;
            }
        }
    }
    /**
     * handleAccountUpdate updates buyer and co buyer fields from b2b contact when buyer/cobuyer contact is changed on a deal
     * @param  triggerNew    trigger.New
     * @param  triggerOldMap trigger.OldMap
     */
    public void handleContactUpdate(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        //Set buyer/co buyer fields to those from Contact when contact lookup is changed on b2b deals, ignore buyer/cobuyer swap
        List<Deal__c> updatedBuyer = new List<Deal__c>();
        List<Deal__c> updatedCoBuyer = new List<Deal__c>();
        for(Deal__c deal : triggerNew){
            Account buyerAcct = custAccounts.get(deal.Buyer__c);
            Account coBuyerAcct = custAccounts.get(deal.Co_Buyer__c);
            if(deal.Buyer_Contact__c != null && deal.Buyer_Contact__c != triggerOldMap.get(deal.Id).Buyer_Contact__c && deal.Buyer_Contact__c != triggerOldMap.get(deal.Id).Co_Buyer_Contact__c && buyerAcct != null && buyerAcct.isPersonAccount == false){
                if(!updatedBuyer.contains(deal)){
                    updatedBuyer.add(deal);
                }
            }
            if(deal.Co_Buyer__c != null && deal.Co_Buyer__c != triggerOldMap.get(deal.Id).Buyer__c && deal.Co_Buyer__c != triggerOldMap.get(deal.Id).Co_Buyer__c && coBuyerAcct != null && coBuyerAcct.isPersonAccount == false){
                if(!updatedCoBuyer.contains(deal)){
                    updatedCoBuyer.add(deal);
                }
            }
        }

        //Populate buyer fields from the selected b2c buyer contact
        for(Deal__c deal : updatedBuyer){
            Contact buyer = custContacts.get(deal.Buyer_Contact__c);
            if(buyer != null){
                deal.Buyer_First_Name__c = buyer.FirstName;
                deal.Buyer_Middle_Name__c = buyer.MiddleName;
                deal.Buyer_Home_Phone__c = buyer.HomePhone;
                deal.Buyer_Mobile_Phone__c = buyer.MobilePhone;
                deal.Buyer_Email__c = buyer.Email;
                deal.Buyer_Drivers_License__c = buyer.Drivers_License_Number__c;
                deal.Buyer_Drivers_Lic_State__c = buyer.Drivers_License_State__c;
                deal.Buyer_Drivers_License_Exp_Date__c = buyer.Drivers_License_Expiration_Date__c;
                deal.Buyer_Last_Name__c = buyer.LastName;
                deal.Buyer_Address__c = buyer.MailingStreet;
                deal.Buyer_City__c = buyer.MailingCity;
                deal.Buyer_State__c = buyer.MailingState;
                deal.Buyer_Postal_Code__c = buyer.MailingPostalCode;
                deal.Buyer_Birthdate__c = buyer.Birthdate;
            }
        }
        //Populate co-buyer fields from the selected b2c co-buyer account
        for(Deal__c deal : updatedCoBuyer){
            Contact buyer = custContacts.get(deal.Co_Buyer_Contact__c);
            if(buyer != null){
                deal.Co_Buyer_First_Name__c = buyer.FirstName;
                deal.Co_Buyer_Middle_Name__c = buyer.MiddleName;
                deal.Co_Buyer_Home_Phone__c = buyer.HomePhone;
                deal.Co_Buyer_Mobile_Phone__c = buyer.MobilePhone;
                deal.Co_Buyer_Email__c = buyer.Email;
                deal.Co_Buyer_Drivers_License_Number__c = buyer.Drivers_License_Number__c;
                deal.Co_Buyer_Drivers_Lic_State__c = buyer.Drivers_License_State__c;
                deal.Co_Buyer_Drivers_License_Exp_Date__c = buyer.Drivers_License_Expiration_Date__c;
                deal.Co_Buyer_Last_Name__c = buyer.LastName;
                deal.Co_Buyer_Address__c = buyer.MailingStreet;
                deal.Co_Buyer_City__c = buyer.MailingCity;
                deal.Co_Buyer_State__c = buyer.MailingState;
                deal.Co_Buyer_Postal_Code__c = buyer.MailingPostalCode;
                deal.Co_Buyer_Birth_Date__c = buyer.Birthdate;
            }
            
            
        }
    }

    /**
     * updateAccount pushes changes made to buyer/cobuyer fields to the associated account when the saveToAccount boolean is selected for either buyer or cobuyer
     * @param  triggerNew    trigger.New
     * @param  triggerOldMap trigger.OldMap
     */
    public void updateAccount(List<dealer__Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        List<Account> updatedAccts = new List<Account>();
        for(Deal__c deal : triggerNew){
            Account buyer = custAccounts.get(deal.Buyer__c);
            Account coBuyer = custAccounts.get(deal.Co_Buyer__c);
            Account buyerAcct = new Account(Id = deal.Buyer__c);
            Account coBuyerAcct = new Account(Id = deal.Co_Buyer__c);
            Boolean updateNeeded = false;

            //Check if buyer data has changed and update account if buyerSaveToAccount__c is enabled
            if(deal.BuyerSaveToAccount__c == true && deal.Buyer__c != null && deal.Buyer__c == triggerOldMap.get(deal.Id).Buyer__c && buyer.isPersonAccount == true){
                if(triggerOldMap.get(deal.Id).Buyer_First_Name__c != deal.Buyer_First_Name__c){
                    buyerAcct.FirstName = deal.Buyer_First_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Middle_Name__c != deal.Buyer_Middle_Name__c){
                    buyerAcct.MiddleName = deal.Buyer_Middle_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Home_Phone__c != deal.Buyer_Home_Phone__c){
                    buyerAcct.PersonHomePhone = deal.Buyer_Home_Phone__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Mobile_Phone__c != deal.Buyer_Mobile_Phone__c){
                    buyerAcct.PersonMobilePhone = deal.Buyer_Mobile_Phone__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Email__c != deal.Buyer_Email__c){
                    buyerAcct.PersonEmail = deal.Buyer_Email__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Drivers_License__c != deal.Buyer_Drivers_License__c){
                    buyerAcct.Drivers_License_Number__pc = deal.Buyer_Drivers_License__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Drivers_Lic_State__c != deal.Buyer_Drivers_Lic_State__c){
                    buyerAcct.Drivers_License_State__pc = deal.Buyer_Drivers_Lic_State__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Drivers_License_Exp_Date__c != deal.Buyer_Drivers_License_Exp_Date__c){
                    buyerAcct.Drivers_License_Expiration_Date__pc = deal.Buyer_Drivers_License_Exp_Date__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Last_Name__c != deal.Buyer_Last_Name__c){
                    buyerAcct.LastName = deal.Buyer_Last_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Address__c != deal.Buyer_Address__c){
                    buyerAcct.BillingStreet = deal.Buyer_Address__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_City__c != deal.Buyer_City__c){
                    buyerAcct.BillingCity = deal.Buyer_City__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_State__c != deal.Buyer_State__c){
                    buyerAcct.BillingState = deal.Buyer_State__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Postal_Code__c != deal.Buyer_Postal_Code__c){
                    buyerAcct.BillingPostalCode = deal.Buyer_Postal_Code__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Buyer_Birthdate__c != deal.Buyer_Birthdate__c){
                    buyerAcct.PersonBirthdate = deal.Buyer_Birthdate__c;
                    updateNeeded = true;
                }
                if(updateNeeded == true && !updatedAccts.contains(buyerAcct)){
                    updatedAccts.add(buyerAcct);
                }
            }
            //Check if co buyer data has changed and update account if coBuyerSaveToAccount__c is enabled
            if(deal.CoBuyerSaveToAccount__c == true && deal.Co_Buyer__c != null && deal.Co_Buyer__c == triggerOldMap.get(deal.Id).Co_Buyer__c && coBuyer.isPersonAccount == true){
                if(triggerOldMap.get(deal.Id).Co_Buyer_First_Name__c != deal.Co_Buyer_First_Name__c){
                    coBuyerAcct.FirstName = deal.Co_Buyer_First_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Middle_Name__c != deal.Co_Buyer_Middle_Name__c){
                    coBuyerAcct.MiddleName = deal.Co_Buyer_Middle_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Home_Phone__c != deal.Co_Buyer_Home_Phone__c){
                    coBuyerAcct.PersonHomePhone = deal.Co_Buyer_Home_Phone__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Mobile_Phone__c != deal.Co_Buyer_Mobile_Phone__c){
                    coBuyerAcct.PersonMobilePhone = deal.Co_Buyer_Mobile_Phone__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Email__c != deal.Co_Buyer_Email__c){
                    coBuyerAcct.PersonEmail = deal.Co_Buyer_Email__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Drivers_License_Number__c != deal.Co_Buyer_Drivers_License_Number__c){
                    coBuyerAcct.Drivers_License_Number__pc = deal.Co_Buyer_Drivers_License_Number__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Drivers_Lic_State__c != deal.Co_Buyer_Drivers_Lic_State__c){
                    coBuyerAcct.Drivers_License_State__pc = deal.Co_Buyer_Drivers_Lic_State__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Drivers_License_Exp_Date__c != deal.Co_Buyer_Drivers_License_Exp_Date__c){
                    coBuyerAcct.Drivers_License_Expiration_Date__pc = deal.Co_Buyer_Drivers_License_Exp_Date__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Last_Name__c != deal.Co_Buyer_Last_Name__c){
                    coBuyerAcct.LastName = deal.Co_Buyer_Last_Name__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Address__c != deal.Co_Buyer_Address__c){
                    coBuyerAcct.PersonMailingStreet = deal.Co_Buyer_Address__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_City__c != deal.Co_Buyer_City__c){
                    coBuyerAcct.PersonMailingCity = deal.Co_Buyer_City__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_State__c != deal.Co_Buyer_State__c){
                    coBuyerAcct.PersonMailingState = deal.Co_Buyer_State__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Postal_Code__c != deal.Co_Buyer_Postal_Code__c){
                    coBuyerAcct.PersonMailingPostalCode = deal.Co_Buyer_Postal_Code__c;
                    updateNeeded = true;
                }
                if(triggerOldMap.get(deal.Id).Co_Buyer_Birth_Date__c != deal.Co_Buyer_Birth_Date__c){
                    coBuyerAcct.PersonBirthdate = deal.Co_Buyer_Birth_Date__c;
                    updateNeeded = true;
                }
                if(updateNeeded == true && !updatedAccts.contains(coBuyerAcct)){
                    updatedAccts.add(coBuyerAcct);
                }
            }
        }

        if(updatedAccts.size() > 0){
            update updatedAccts;
        }
    }


    /**
     * updateVehiclePricing updates vehicle related fields on insert
     * @param  triggerNew triggerNew inserted deals
     */
    public static void updateVehiclePricing(List<Deal__c> triggerNew){
        Set<Id> vIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.Vehicle__c != null){
                vIds.add(d.Vehicle__c);
            }

            else if(d.Vehicle__c == null){
                d.ConversionDeal__c = true; //Move this value to DMS Setting?
                d.Vehicle_Price__c = 0;
                d.Conversion_Price__c = 0;
                d.Vehicle_Cost__c = 0;
                d.ConversionCost__c = 0;
            }
        }

        if(vIds.size() > 0){
            Map<Id, Vehicle_Inventory__c> viMap = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Vehicle_Cost__c, Conversion_Cost__c, Retail_Price__c, Conversion_Price__c, Conversion__c FROM Vehicle_Inventory__c WHERE Id IN: vIds]);

            for(Deal__c d : triggerNew){
                //Update fields to newly changed vehicle
                if(d.Vehicle__c != null && viMap.get(d.Vehicle__c) != null){
                    d.ConversionDeal__c = viMap.get(d.Vehicle__c).Conversion__c != null ? true : false;
                    d.Vehicle_Price__c = viMap.get(d.Vehicle__c).Retail_Price__c != null ? viMap.get(d.Vehicle__c).Retail_Price__c : 0;
                    d.Conversion_Price__c = viMap.get(d.Vehicle__c).Conversion_Price__c != null ? viMap.get(d.Vehicle__c).Conversion_Price__c : 0;
                    d.Vehicle_Cost__c = viMap.get(d.Vehicle__c).Vehicle_Cost__c != null ? viMap.get(d.Vehicle__c).Vehicle_Cost__c : 0;
                    d.ConversionCost__c = viMap.get(d.Vehicle__c).Conversion_Cost__c != null ? viMap.get(d.Vehicle__c).Conversion_Cost__c : 0;
                }
                //Otherwise set values to 0
                else{
                    d.ConversionDeal__c = true; //Move this value to DMS Setting?
                    d.Vehicle_Price__c = 0;
                    d.Conversion_Price__c = 0;
                    d.Vehicle_Cost__c = 0;
                    d.ConversionCost__c = 0;
                }
            }
        }
    }

    /**
     * updateVehiclePricing updates vehicle related fields on update
     * @param  triggerNew triggerNew updated deals
     */
    public static void updateVehiclePricing(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        Set<Id> vIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.Vehicle__c != null && d.Vehicle__c != triggerOldMap.get(d.Id).Vehicle__c){
                vIds.add(d.Vehicle__c);
            }

            else if(d.Vehicle__c == null && d.Order__c == false){
                d.ConversionDeal__c = true; //Move this value to DMS Setting?
                // d.Vehicle_Price__c = 0;
                // d.Conversion_Price__c = 0;
                // d.Vehicle_Cost__c = 0;
                // d.ConversionCost__c = 0;
            }
        }

        if(vIds.size() > 0){
            Map<Id, Vehicle_Inventory__c> viMap = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Vehicle_Cost__c, Conversion_Cost__c, Retail_Price__c, Conversion_Price__c, Conversion__c FROM Vehicle_Inventory__c WHERE Id IN: vIds]);

            for(Deal__c d : triggerNew){
                //Update fields to newly changed vehicle
                if(d.Vehicle__c != null && viMap.get(d.Vehicle__c) != null){
                    d.ConversionDeal__c = viMap.get(d.Vehicle__c).Conversion__c != null ? true : false;
                    d.Vehicle_Price__c = viMap.get(d.Vehicle__c).Retail_Price__c != null ? viMap.get(d.Vehicle__c).Retail_Price__c : 0;
                    d.Conversion_Price__c = viMap.get(d.Vehicle__c).Conversion_Price__c != null ? viMap.get(d.Vehicle__c).Conversion_Price__c : 0;
                    d.Vehicle_Cost__c = viMap.get(d.Vehicle__c).Vehicle_Cost__c != null ? viMap.get(d.Vehicle__c).Vehicle_Cost__c : 0;
                    d.ConversionCost__c = viMap.get(d.Vehicle__c).Conversion_Cost__c != null ? viMap.get(d.Vehicle__c).Conversion_Cost__c : 0;
                }
                //Otherwise set values to 0
                else if(d.Order__c == false){
                    d.ConversionDeal__c = true; //Move this value to DMS Setting?
                    // d.Vehicle_Price__c = 0;
                    // d.Conversion_Price__c = 0;
                    // d.Vehicle_Cost__c = 0;
                    // d.ConversionCost__c = 0;
                }
            }
        }
    }

    /**
     * updateVehiclePricingTotals updates price and cost totals on insert and update
     * @param  triggerNew triggerNew inserted or updated deals
     */
    public static void updateVehiclePricingTotals(List<Deal__c> triggerNew){
        for(Deal__c d : triggerNew){
            d.Vehicle_Price__c = d.Vehicle_Price__c != null ? d.Vehicle_Price__c : 0;
            d.Conversion_Price__c = d.Conversion_Price__c != null ? d.Conversion_Price__c : 0;
            d.Vehicle_Cost__c = d.Vehicle_Cost__c != null ? d.Vehicle_Cost__c : 0;
            d.ConversionCost__c = d.ConversionCost__c != null ? d.ConversionCost__c : 0;
            d.Vehicle_Discount__c = d.Vehicle_Discount__c != null ? d.Vehicle_Discount__c : 0;
            d.Conversion_Discount__c = d.Conversion_Discount__c != null ? d.Conversion_Discount__c : 0;
            d.Sale_Price__c = d.Vehicle_Price__c + d.Conversion_Price__c;
            d.TotalVehicleCost__c = d.Vehicle_Cost__c + d.ConversionCost__c;
            d.TotalVehicleDiscount__c = d.Vehicle_Discount__c + d.Conversion_Discount__c;
        }
    }

    /**
     * updateVehicleGross Calculates chassis, conversion and total vehicle gross and percents
     * @param  triggerNew triggerNew inserted or updated deals
     */
    public static void updateVehicleGross(List<Deal__c> triggerNew){
        for(Deal__c d : triggerNew){
            d.Vehicle_Gross__c = d.Vehicle_Price__c - d.Vehicle_Cost__c;
            d.Vehicle_Conversion_Gross__c = d.Conversion_Price__c - d.ConversionCost__c;
            d.TotalVehicleGross__c = d.Vehicle_Gross__c + d.Vehicle_Conversion_Gross__c;
            if(d.TotalVehicleGross__c != null && d.TotalVehicleCost__c > 0){
                d.TotalVehicleGrossPercent__c = (d.TotalVehicleGross__c / d.TotalVehicleCost__c) * 100; 
            }
            else{
                d.TotalVehicleGrossPercent__c = null;
            }

            d.EquipmentInventoryCost__c = d.EquipmentInventoryCost__c != null ? d.EquipmentInventoryCost__c : 0;
            d.EquipmentInventoryPrice__c = d.EquipmentInventoryPrice__c != null ? d.EquipmentInventoryPrice__c : 0;
            d.EquipmentInventoryGross__c = d.EquipmentInventoryPrice__c - d.EquipmentInventoryCost__c;
        }
    }

    /**
     * updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal
     * @param  triggerNew inserted deals
     */
    public static void updateVehicleMasterInfo(List<Deal__c> triggerNew){
        Set<Id> vmIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.Order__c == true && d.VehicleMaster__c != null && d.Vehicle__c == null){
                vmIds.add(d.VehicleMaster__c);
            }
        }

        if(vmIds.size() > 0){
            Map<Id, VehicleModel__c> vmMap = new Map<Id, VehicleModel__c>([SELECT Id, Year__c, Make__c, Model__c, Trim__c FROM VehicleModel__c WHERE Id IN: vmIds]);

            for(Deal__c d : triggerNew){
                if(d.Order__c == true && d.VehicleMaster__c != null && vmMap.get(d.VehicleMaster__c) != null && d.Vehicle__c == null){
                    d.Year__c = vmMap.get(d.VehicleMaster__c).Year__c;
                    d.Make__c = vmMap.get(d.VehicleMaster__c).Make__c;
                    d.Model__c = vmMap.get(d.VehicleMaster__c).Model__c;
                    d.Trim_Level__c = vmMap.get(d.VehicleMaster__c).Trim__c;
                }
            }
        }
    }

    /**
     * updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal
     * @param  triggerNew updated deals
     */
    public static void updateVehicleMasterInfo(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        Set<Id> vmIds = new Set<Id>();
        List<Deal__c> changedDeals = new List<Deal__c>();
        for(Deal__c d : triggerNew){
            if(d.Order__c == true && d.VehicleMaster__c != null && d.VehicleMaster__c != triggerOldMap.get(d.Id).VehicleMaster__c && d.Vehicle__c == null){
                vmIds.add(d.VehicleMaster__c);
                changedDeals.add(d);
            }
            else if(d.Order__c == true && d.VehicleMaster__c == null && triggerOldMap.get(d.Id).VehicleMaster__c != null && d.Vehicle__c == null){
                d.Year__c = null;
                d.Make__c = null;
                d.Model__c = null;
                d.Trim_Level__c = null;
                d.VIN__c = null;
                d.NUO__c = null;
            }
        }

        if(vmIds.size() > 0){
            Map<Id, VehicleModel__c> vmMap = new Map<Id, VehicleModel__c>([SELECT Id, Year__c, Make__c, Model__c, Trim__c FROM VehicleModel__c WHERE Id IN: vmIds]);

            for(Deal__c d : changedDeals){
                if(d.Order__c == true && d.VehicleMaster__c != null && vmMap.get(d.VehicleMaster__c) != null){
                    d.Year__c = vmMap.get(d.VehicleMaster__c).Year__c;
                    d.Make__c = vmMap.get(d.VehicleMaster__c).Make__c;
                    d.Model__c = vmMap.get(d.VehicleMaster__c).Model__c;
                    d.Trim_Level__c = vmMap.get(d.VehicleMaster__c).Trim__c;
                    d.VIN__c = null;
                    d.NUO__c = null;
                }
            }
        }
    }

    /**
     * preventDeleteEquipmentOrders Deletes equipment inventory records of Record Type Order when removed from Deal 
     * @param  triggerNew    triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */
    public static void preventDeleteEquipmentOrders(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        Set<Id> eiIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.EquipmentInventory__c != triggerOldMap.get(d.Id).EquipmentInventory__c && triggerOldMap.get(d.Id).EquipmentInventory__c != null){
                eiIds.add(triggerOldMap.get(d.Id).EquipmentInventory__c);
            }
        }

        if(eiIds.size() > 0){
            Map<Id, EquipmentInventory__c> eiMap = new Map<Id, EquipmentInventory__c>([SELECT Id FROM EquipmentInventory__c WHERE Id IN: eiIds AND RecordType.Name = 'Order']);
        
            for(Deal__c d : triggerNew){
                if(d.EquipmentInventory__c != triggerOldMap.get(d.Id).EquipmentInventory__c && triggerOldMap.get(d.Id).EquipmentInventory__c != null){
                    if(eiMap.get(triggerOldMap.get(d.Id).EquipmentInventory__c) != null){
                        d.addError(new DealControlHandlerException('This deal has an Equipment Inventory of Record Type Order. That record must be deleted before selecting a new Equipment Inventory record.'));
                    }
                }        
            
            }
        }
    }

    /**
     * populateEquipmentPricing Sets Equipment Inventory pricing fields on inserted deals with equipmentInventory__c
     * @param  triggerNew triggerNew description
     */
    public static void updateEquipmentPricing(List<Deal__c> triggerNew){
        Set<Id> eiIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.EquipmentInventory__c != null){
                eiIds.add(d.EquipmentInventory__c);
            }
        }

        if(eiIds.size() > 0){
            Map<Id, EquipmentInventory__c> eiMap = new Map<Id, EquipmentInventory__c>([SELECT Id, Cost__c, RetailPrice__c FROM EquipmentInventory__c WHERE Id IN: eiIds]);

            for(Deal__c d : triggerNew){
                if(d.EquipmentInventory__c != null && eiMap.get(d.EquipmentInventory__c) != null){
                    d.EquipmentInventoryCost__c = eiMap.get(d.EquipmentInventory__c).Cost__c != null ? eiMap.get(d.EquipmentInventory__c).Cost__c : 0;
                    d.EquipmentInventoryPrice__c = eiMap.get(d.EquipmentInventory__c).RetailPrice__c != null ? eiMap.get(d.EquipmentInventory__c).RetailPrice__c : 0;
                }
            }
        }
    }

    /**
     * populateEquipmentPricing Sets Equipment Inventory pricing fields on updated deals if equipmentInventory__c was changed
     * @param  triggerNew triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */
    public static void updateEquipmentPricing(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        Set<Id> eiIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            if(d.EquipmentInventory__c != null && d.EquipmentInventory__c != triggerOldMap.get(d.Id).EquipmentInventory__c){
                eiIds.add(d.EquipmentInventory__c);
            }

            else if(d.EquipmentInventory__c == null){
                d.EquipmentInventoryCost__c = 0;
                d.EquipmentInventoryPrice__c = 0;
            }
        }

        if(eiIds.size() > 0){
            Map<Id, EquipmentInventory__c> eiMap = new Map<Id, EquipmentInventory__c>([SELECT Id, Cost__c, RetailPrice__c FROM EquipmentInventory__c WHERE Id IN: eiIds]);

            for(Deal__c d : triggerNew){
                //Update fields to newly changed vehicle
                if(d.EquipmentInventory__c != null && eiMap.get(d.EquipmentInventory__c) != null){
                    d.EquipmentInventoryCost__c = eiMap.get(d.EquipmentInventory__c).Cost__c != null ? eiMap.get(d.EquipmentInventory__c).Cost__c : 0;
                    d.EquipmentInventoryPrice__c = eiMap.get(d.EquipmentInventory__c).RetailPrice__c != null ? eiMap.get(d.EquipmentInventory__c).RetailPrice__c : 0;
                }
            }
        }
    }

    /**
     * updateRelatedEquipmentInventory Update pricing on Order type EquipmentInventory__c records if pricing on deal changes
     * @param  triggerNew    triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */
    public static void updateRelatedEquipmentInventory(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        Set<Id> eiIds = new Set<Id>();
        List<Deal__c> changedDeals = new List<Deal__c>();
        List<EquipmentInventory__c> eiList = new List<EquipmentInventory__c>();
        for(Deal__c d : triggerNew){
            if(d.EquipmentInventory__c != null && triggerOldMap.get(d.Id).EquipmentInventory__c == d.EquipmentInventory__c){
                if(d.EquipmentInventoryCost__c != triggerOldMap.get(d.Id).EquipmentInventoryCost__c || d.EquipmentInventoryPrice__c != triggerOldMap.get(d.Id).EquipmentInventoryPrice__c){
                    eiIds.add(d.EquipmentInventory__c);
                    changedDeals.add(d);
                }
            }
        }

        if(eiIds.size() > 0){
            Map<Id, EquipmentInventory__c> eiMap = new Map<Id, EquipmentInventory__c>([SELECT Id, Cost__c, RetailPrice__c FROM EquipmentInventory__c WHERE Id IN: eiIds AND RecordType.DeveloperName = 'Order']);
            for(Deal__c d : changedDeals){
                if(eiMap.get(d.EquipmentInventory__c) != null && (eiMap.get(d.EquipmentInventory__c).Cost__c != d.EquipmentInventoryCost__c || eiMap.get(d.EquipmentInventory__c).RetailPrice__c != d.EquipmentInventoryPrice__c)){
                    EquipmentInventory__c ei = new EquipmentInventory__c(Id = d.EquipmentInventory__c, Cost__c = d.EquipmentInventoryCost__c, RetailPrice__c = d.EquipmentInventoryPrice__c);
                    eiList.add(ei);
                }
            }
            if(eiList.size() > 0){
                update eiList;
            }
        }
    }

	public class DealControlHandlerException extends Exception{}

    public void updateSalesTeam(List<Deal__c> triggerNew, Map<Id, Deal__c> triggerOldMap){
        List<Deal__c> changedDeals = new List<Deal__c>();
        Set<Id> userIds = new Set<Id>();
        for(Deal__c d : triggerNew){
            //Check if Salesperson 1 changed
            if(d.Salesperson_1__c != triggerOldMap.get(d.Id).Salesperson_1__c){
                if(d.Salesperson_1__c == null){
                    d.Salesperson_1_Name__c = null;
                    d.Salesperson_1_Number__c = null;
                }
                else{
                    changedDeals.add(d);
                    userIds.add(d.Salesperson_1__c);
                }
            }

            //Check if Salesperson 2 changed
            if(d.Salesperson_2__c != triggerOldMap.get(d.Id).Salesperson_2__c){
                if(d.Salesperson_2__c == null){
                    d.Salesperson_2_Name__c = null;
                    d.Salesperson_2_Number__c = null;
                }
                else{
                    changedDeals.add(d);
                    userIds.add(d.Salesperson_2__c);
                }
            }

            //Check if Desk Manager changed
            if(d.Desk_Manager__c != triggerOldMap.get(d.Id).Desk_Manager__c){
                if(d.Desk_Manager__c == null){
                    d.Desk_Manager_Name__c = null;
                    d.Desk_Manager_Number__C = null;
                }
                else{
                    changedDeals.add(d);
                    userIds.add(d.Desk_Manager__c);
                }
            }

            //Check if F&I Manager changed
            if(d.F_I_Manager__c != triggerOldMap.get(d.Id).F_I_Manager__c){
                if(d.F_I_Manager__c == null){
                    d.F_I_Manager_Name__c = null;
                    d.F_I_Manager_Number__c = null;
                }
                else{
                    changedDeals.add(d);
                    userIds.add(d.F_I_Manager__c);
                }
            }
        }
        if(userIds.size() > 0){
            Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Name, EmployeeNumber FROM User WHERE Id IN: userIds]);
            //Update the Name and Number fields for each user
            for(Deal__c d : changedDeals){
                d.Salesperson_1_Name__c = userMap.get(d.Salesperson_1__c) != null ? userMap.get(d.Salesperson_1__c).Name : d.Salesperson_1_Name__c;
                d.Salesperson_1_Number__c = userMap.get(d.Salesperson_1__c) != null ? userMap.get(d.Salesperson_1__c).EmployeeNumber : d.Salesperson_1_Number__c;

                d.Salesperson_2_Name__c = userMap.get(d.Salesperson_2__c) != null ? userMap.get(d.Salesperson_2__c).Name : d.Salesperson_2_Name__c;
                d.Salesperson_2_Number__c = userMap.get(d.Salesperson_2__c) != null ? userMap.get(d.Salesperson_2__c).EmployeeNumber : d.Salesperson_2_Number__c;

                d.Desk_Manager_Name__c = userMap.get(d.Desk_Manager__c) != null ? userMap.get(d.Desk_Manager__c).Name : d.Desk_Manager_Name__c;
                d.Desk_Manager_Number__c = userMap.get(d.Desk_Manager__c) != null ? userMap.get(d.Desk_Manager__c).EmployeeNumber : d.Desk_Manager_Number__c;

                d.F_I_Manager_Name__c = userMap.get(d.F_I_Manager__c) != null ? userMap.get(d.F_I_Manager__c).Name : d.F_I_Manager_Name__c;
                d.F_I_Manager_Number__c = userMap.get(d.F_I_Manager__c) != null ? userMap.get(d.F_I_Manager__c).EmployeeNumber : d.F_I_Manager_Number__c;

            }
        }
    }

    /**
    * setDealGross
    * @description Runs on insert and update to calculate front and back gross based on custom metadata type record eval string
    * @param  triggerNew    triggerNew description
    * @param  triggerOldMap triggerOldMap description
    */
    public void setDealGross(List<Deal__c> triggerNew)
    {
        //Access metadata
        for(Deal__c d : triggerNew){
            if(dmsConfiguration.get('DealFrontEndGross') != null){
                //If there is a subscriber-created value "defaultValue__c" use that, otherwise use package default "value__c"
                Decimal frontEnd = dmsConfiguration.get('DealFrontEndGross').DefaultValue__c != null ? new EvalExpression(dmsConfiguration.get('DealFrontEndGross').DefaultValue__c).matching(d.getpopulatedfieldsasmap()).eval() : new EvalExpression(dmsConfiguration.get('DealFrontEndGross').Value__c).matching(d.getpopulatedfieldsasmap()).eval();
                system.debug(frontEnd);
                d.Front_End_Gross__c = frontEnd;
            }

            if(dmsConfiguration.get('DealBackEndGross') != null){
                //If there is a subscriber-created value "defaultValue__c" use that, otherwise use package default "value__c"
                Decimal backEnd = dmsConfiguration.get('DealBackEndGross').DefaultValue__c != null ? new EvalExpression(dmsConfiguration.get('DealBackEndGross').DefaultValue__c).matching(d.getpopulatedfieldsasmap()).eval() : new EvalExpression(dmsConfiguration.get('DealBackEndGross').Value__c).matching(d.getpopulatedfieldsasmap()).eval();
                system.debug(backEnd);
                d.Back_End_Gross__c = backEnd;
            }
        }
    }

	/**
	* updateFinanceGross
	* @description Calculates finance gross based on finance company and deal values
	*/
    public void updateFinanceGross(List<Deal__c> triggerNew)
	{
        Set<Id> finIds = new Set<Id>();

        for(Deal__c d : triggerNew){
            if(d.Finance_Institution_Account__c != null){
                finIds.add(d.Finance_Institution_Account__c);
            }
        }

        if(finIds.size() > 0){
            Map<Id, Finance_Company__c> finCompany = new Map<Id, Finance_Company__c>([SELECT Id, Reserve_Percentage__c FROM Finance_Company__c WHERE Id IN: finIds]);

            if(finCompany.size() > 0){
                for(Deal__c deal : triggerNew){
                    if(deal.Amt_Financed__c != null && deal.Buy_Rate__c != null && deal.Finance_Institution_Account__c != null && finCompany.get(deal.Finance_Institution_Account__c) != null ){
                        deal.Finance_Gross__c = finCompany.get(deal.Finance_Institution_Account__c).Reserve_Percentage__c != null ? (((deal.Rate__c/100) * deal.Amt_Financed__c) - ((deal.Buy_Rate__c/100) * deal.Amt_Financed__c)) * (finCompany.get(deal.Finance_Institution_Account__c).Reserve_Percentage__c/100) : null;
                    }
                }
            }
        }

         
    }
}