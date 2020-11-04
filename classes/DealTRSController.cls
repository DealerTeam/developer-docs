/**
 * DealTRSController
 * @description
 */
public with sharing class DealTRSController {

    /**
     * @description 
     */
    String currentId;
    
    //DealTRS variables
    
    /**
     * @description 
     */
    public String action {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public String retJSON {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public Map < String, String > urlParams = new Map < String, String > ();
    
    /**
     * @description 
     */
    Map < String, Schema.SObjectField > field_map {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public String searchQuery {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public Integer pageNumber {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public Integer pageSize {
        get;
        set;
    }
    
    /**
     * @description 
     */
    private String dealId, formId;
    
    /**
     * @description 
     */
    public string processInstanceId {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public boolean isCobuyerSearch {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public Id casheirRecordId {
        get;
        set;
    }

    /**
     * @description 
     */
    public dealer__Deal__c dealRecord {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public dealer__Sales_Up__c salesup {
        get;
        set;
    }
    
    /**
     * @description 
     */
    public List < dealer__Deal__c > relatedDeals {
        get;
        set;
    }

    /**
     * @description Configration and custom setting values
     */
    public DeskingConfiguration__mdt deskingConfig {
        get;
        set;
    }

    /**
     * @description 
     */
    public List<DeskingSubtabConfiguration__mdt> deskingSubTabConfig {
        get;
        private set;
    }

    /**
     * @description 
     */
    public Map<String, dealer__DeskingComponentConfiguration__mdt> deskingComponentConfiguration {
        get;
        set;
    }

    /**
     * @description 
     */
    public DeskingUserSetting__c mySettings {
        get;
        set;
    }
          
    /**
     * DealTRSController
     * @description Constructor with no standard controller (not loaded via VF Pgae)
     */
    public DealTRSController() 
    {
        searchQuery = '';
        currentId = ApexPages.currentPage().getParameters().get('id');

        urlParams = ApexPages.currentPage().getParameters();
        if (ApexPages.currentPage().getParameters().get('isCobuyerSearch') != null)
            isCobuyerSearch = true;
        else
            isCobuyerSearch = false;

        // Set the Action
        if (urlParams.get('action') != null) {
            action = urlParams.get('action');
        }

        if (urlParams.get('dealId') != null) {
            currentId = urlParams.get('dealId');
        }

        try {
            formId = ApexPages.currentPage().getParameters().get('formId');
        } catch (Exception e) {}

        if (formId != null && !formId.equals('')) {
            dealer__form__c myForms = [Select id, name, dealer__Impact_Code__c from dealer__Form__c where id =: formId];
            retJSON = myForms.dealer__Impact_Code__c;
        }

        //create map for Picklist Values
        getPicklistFieldDescribe();

    }

    /**
     * DealTRSController 
     * @param  controller 
     * @description
     */
    public DealTRSController(ApexPages.StandardController controller) 
    {

        if(!Test.isRunningTest()){
        // Get the desking configuration file
        deskingConfig = DealTRSController.config('dealer__Default_Desking_Configuration');        
        deskingSubTabConfig = DealTRSController.subTabConfig('dealer__Default_Desking_Configuration');
        deskingComponentConfiguration = DealTRSController.componentConfiguration('dealer__Default_Desking_Configuration');
        }
        // Setup defaults for the user
        mySettings = DealTRSController.userSettings(UserInfo.getUserId());

        currentId = ApexPages.currentPage().getParameters().get('id');
        if (ApexPages.currentPage().getParameters().get('isCobuyerSearch') != null)
            isCobuyerSearch = true;
        else
            isCobuyerSearch = false;
        urlParams = ApexPages.currentPage().getParameters();

        // Set the Action
        if (urlParams.get('action') != null) {
            action = urlParams.get('action');
        }

        if (urlParams.get('dealId') != null) {
            currentId = urlParams.get('dealId');
        }

        System.debug('**Constructor: v - ' + action + ',dealId - ' + currentId);

        //create map for Picklist Values
        getPicklistFieldDescribe();

        salesup = new dealer__Sales_Up__c();
        dealRecord = new dealer__Deal__c();

        relatedDeals = loadRelatedDeals();
        
        System.debug(currentId); 
    }

    /**
     * config 
     * @param  apiName 
     * @return static
     * @description
     */
    public static DeskingConfiguration__mdt config(String apiName) 
    {
        try {
            DeskingConfiguration__mdt config = [SELECT QualifiedApiName, Label, NamespacePrefix, MasterLabel, DeveloperName, Id 
                        FROM DeskingConfiguration__mdt 
                        WHERE QualifiedApiName =:apiName];
            return config;
        } Catch(QueryException e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * subTabConfig 
     * @param  configApiName 
     * @return List<DeskingSubtabConfiguration__mdt>
     * @description
     */
    public static List<DeskingSubtabConfiguration__mdt> subTabConfig(String configApiName)  
    {
        try {
            return [SELECT Visible__c, Icon_Class__c, DeskingConfiguration__c, DeskingConfiguration__r.QualifiedApiName, Subtab__c, href__c, elementId__c, 
                        Order__c, Label, QualifiedApiName, NamespacePrefix, Id, DeveloperName, MasterLabel, CustomLabel__c 
                        FROM DeskingSubtabConfiguration__mdt
                        WHERE DeskingConfiguration__r.QualifiedApiName =:configApiName
                        ORDER BY Order__c ASC];
        } Catch(QueryException e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * componentConfiguration 
     * @param  configApiName 
     * @return Map<String, DeskingComponentConfiguration__mdt>
     * @description
     */
    public static Map<String, DeskingComponentConfiguration__mdt> componentConfiguration(String configApiName) 
    {
        Map<String, DeskingComponentConfiguration__mdt> dcomp = new Map<String, DeskingComponentConfiguration__mdt>();
        for(DeskingComponentConfiguration__mdt dcc : [SELECT Id, Active__c, ComponentId__c, MangedComponent__c FROM DeskingComponentConfiguration__mdt WHERE DeskingConfiguration__r.QualifiedApiName=:configApiName]) {
            dcomp.put(dcc.ComponentId__c, dcc);
        }
        return dcomp;
    }

    /**
     * userSettings 
     * @param  userId 
     * @return DeskingUserSetting__c
     * @description
     */
    public static DeskingUserSetting__c  userSettings(Id userId) 
    {
            
        DeskingUserSetting__c myst = DeskingUserSetting__c.getInstance(userId);
        
        System.debug(myst);

        if(myst.Id==null) {
        
            System.debug('Inside default loop');

            myst = new DeskingUserSetting__c(SetupOwnerId=userId, CustomerView__c=false, DisplayGrossAsPercent__c=false);
        }

        System.debug(myst);

        return myst;
    }

    /**
     * insertUserSettings 
     * @param  userId 
     * @return void
     * @description
     */
    public static void insertUserSettings(Id userId) 
    {
        DeskingUserSetting__c myst = DeskingUserSetting__c.getInstance(userId);
        if(myst.Id==null) {
            insert new DeskingUserSetting__c(SetupOwnerId=userId, CustomerView__c=false, DisplayGrossAsPercent__c=false);
        } 
    }

    /**
     * loadRelatedDeals
     * @return List<daeler__Deal__c>
     * @description used to set a list of related deals when the controller is instantiated.
     */
    public List < dealer__Deal__c > loadRelatedDeals() 
    {
        if (currentId == null)
            return null;

        // Get list of associate
        dealRecord = [SELECT Id, dealer__Sales_Lead__c FROM dealer__Deal__c WHERE Id =: currentId];

        if (dealRecord.dealer__Sales_Lead__c != null) {
            salesup = [SELECT Id, Name, dealer__Car_Deal__c, dealer__Sold__c FROM dealer__Sales_Up__c WHERE Id =: dealRecord.dealer__Sales_Lead__c LIMIT 1];
        }

        return [SELECT Id, Name, dealer__Vehicle__r.Name, dealer__Deal_Type__c, dealer__Deal_ID__c FROM dealer__Deal__c WHERE dealer__Sales_Lead__c != null AND dealer__Sales_Lead__c =: dealRecord.dealer__Sales_Lead__c ORDER BY CreatedDate ASC];
    }

    /**
     * getDealKeyPrefix
     * @return String
     * @description gets the deal object key prefix
     */
    public String getDealKeyPrefix() 
    {
        Schema.DescribeSObjectResult r = dealer__Deal__c.sObjectType.getDescribe();
        return r.getKeyPrefix();
    }

    /**
     * crudAction
     * @return PageReference
     * @description router for all action calls
     */
    public PageReference crudAction() 
    {
        urlParams = ApexPages.currentPage().getParameters();
        System.debug(urlParams);


        // Set the Action
        if (urlParams.get('action') != null) {
            action = urlParams.get('action');
        }

        //Clone deal
        if (urlParams.get('action') == 'clone_deal') {
            retJSON = cloneDeal();
        }

        // David Changes start Here 4-4-2016
        if (action == 'create_rebates') {
            retJSON = updateDiscount();
        }
        if (action == 'update_rebates') {
            retJSON = updateDiscount();
        }
        if (action == 'delete_rebates') {
            retJSON = destroyDiscount();
        }
        if (action == 'create_fee') {
            retJSON = createFee();
        }
        if (action == 'update_fee') {
            retJSON = updateFee();
        }
        if (action == 'delete_fees') {
            retJSON = destroyFee();
        }
    
        if (action == 'create_dealtax') {
            retJSON = upsertTaxLine();
        }

        if(action == 'delete_taxtransitem') {
            retJSON = deleteTaxTansactionItem();
            return null;
        }
        if(action == 'update_taxtransitem') {
            retJSON = upsertTaxTransactionItem();
            return null;
        }

        if(action == 'refresh_fees') {
            system.debug('refresh');
        }
        if (action == 'update_dealtax') {
            retJSON = upsertTaxLine();
            system.debug(retJSON);
            return null;
        }
        if (action == 'delete_dealtax') {
            retJSON = destroyTaxLine();
        }
        if (action == 'renew_tax_lines') {
            retJSON = renewTaxLines();
        }

        if (action == 'update_deal') {
            retJSON = updateDeal();
        }

        if (action == 'delete_deal') {
            retJSON = deleteDeal();
        }

        if (action == 'delete_tradein') {
            retJSON = deleteTradeIn();
        }

        if (action == 'create_afterMarket') {
            retJSON = upsertAfterMarket();
        }
        if (action == 'update_afterMarket') {
            retJSON = upsertAfterMarket();
        }
        if (action == 'delete_afterMarket') {
            retJSON = deleteAfterMarket();
        }

        if (action == 'create_tradein') {
            retJSON = createTradeIn();
        }

        if (action == 'update_tradein') {
            retJSON = updateTradeIn();
        }

        if (action == 'delete_contract') {
            retJSON = deleteContract();
        }

        if (action == 'update_accounts') {
            retJSON = updateAccounts();
        }

        if (action == 'insert_account') {
            retJSON = insertAccount();
        }

        if (action == 'update_contract') {
            retJSON = updateContract();
        }

        if (action == 'create_contract') {
            retJSON = insertContract();
        }

        if (action == 'submit_approval') {
            retJSON = getSubmitApproval();
        }

        if (action.equals('create_NewDealForm')) {
            retJSON = getSelectedForm();
        }
        if (action.equals('delete_LaserForm')) {
            retJSON = deleteLaserDealForm();
        }
        if (action.equals('delete_ImpactForm')) {
            retJSON = deleteImpactDealForm();
        }

        if (action == 'create_salesup') {
            retJSON = createSalesUp();
        }

        /* Cashier Actions */
        if (action == 'create_cashier') {
            retJSON = createCashierEntry();
        }

        if (action == 'delete_cashier') {
            retJSON = deleteCashierEntry();
        }

        if (action == 'update_cashier') {
            retJSON = updateCashierEntry();
        }
        return null;
    }

    /**
     * getDealContentDocuments
     * @return String
     * @description Lookups documents linked to the Deal
     */
    public string getDealContentDocuments() 
    {

        List < ContentDocumentLink > lstContent = new List < ContentDocumentLink > ();
        lstContent = [SELECT id, ContentDocument.LatestPublishedVersionId, ContentDocument.Title FROM ContentDocumentLink WHERE LinkedEntityId =: currentId];
        return JSON.serialize(lstContent);
    }

    /**
     * getUserReadLookup
     * @return String
     * @description performs the server side searching for the user inputs
     */
    public String getUserReadLookup() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        List < User > listUserLookup = new List < User > ();

        System.debug(customerId);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listUserLookup = getUserReadById();
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listUserLookup = getUserReadById();
        } else {
            System.debug('searching by SOSL');
            listUserLookup = getUserRead();
        }

        if (listUserLookup == null) {
            listUserLookup = new List < User > ();
        }

        return JSON.serialize(listUserLookup);
    }

    /**
     * getUserRead 
     * @return List < User >
     * @description Read User by SOSL
     */
    public List < User > getUserRead() 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        // SOSL Execute
        List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING User(Id, Name) LIMIT 50];
        List < User > cResults = (List < User > ) soslResults[0];

        return cResults;
    }

    /**
     * getUserReadById 
     * @return List < User >
     * @description Read User by Id/No Id
     */
    public List < User > getUserReadById() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for customer based on Name,Phone,Mobile,Email
        List < User > listUser = new List < User > ();

        if (customerId == null || customerId == '') {
            listUser = [select Id, Name
                from User
                Order By LastModifiedDate DESC
                limit 50
            ];
        } else {
            listUser = [select Id, Name
                from User
                Where Id =: customerId
                limit 1
            ];
        }

        System.debug(listUser);
        return listUser;
    }

    /**
     * getPicklistValues 
     * @return String
     * @description Retrieve Picklist Values
     */ 
    public String getPicklistValues() 
    {
        String fieldName = action;
        Schema.DescribeFieldResult fieldResult =
            field_map.get(fieldName).getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        //set the picklist values in a list
        List < String > options = new List < String > ();
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getValue());
        }

        return JSON.serializePretty(options);
    }

    /**
     * getDefaultStatusValue 
     * @return String
     * @description
     */
    public String getDefaultStatusValue() 
    {
        Schema.DescribeFieldResult fr = dealer__Deal__c.dealer__Status__c.getDescribe();
        List < Schema.PicklistEntry > ple = fr.getPicklistValues();
        for (Schema.PicklistEntry e: ple) {
            if (e.isDefaultValue()) {
                return e.getValue();
            }
        }

        return null;
    }

    //==================== Location Lookup below


    /**
     * getLocationReadLookup 
     * @return String
     * @description Lookup for pick Location. IF we have a CustID execute based on ID, else Based on No ID.
     */
    public String getLocationReadLookup() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        List < dealer__Dealer_Location__c > listLocationLookup = new List < dealer__Dealer_Location__c > ();

        System.debug(customerId);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listLocationLookup = getLocationReadById();
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listLocationLookup = getLocationReadById();
        } else {
            System.debug('searching by SOSL');
            listLocationLookup = getLocationRead();
        }

        return JSON.serialize(listLocationLookup);
    }

    /**
     * getLocationRead 
     * @return List < dealer__Dealer_Location__c >
     * @description Read Location by SOSL
     */
    public List < dealer__Dealer_Location__c > getLocationRead() 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        // SOSL Execute
        List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Dealer_Location__c(Id, Name, dealer__Default_Days_to_First_Payment__c, dealer__Default_Rate__c, dealer__Default_Term__c) LIMIT 50];
        List < dealer__Dealer_Location__c > cResults = (List < dealer__Dealer_Location__c > ) soslResults[0];

        return cResults;
    }

    /**
     * getLocationReadById 
     * @return List < dealer__Dealer_Location__c >
     * @description Read Location by Id/No Id
     */
    public List < dealer__Dealer_Location__c > getLocationReadById() 
    {
        string locationId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for Location based on Name,Phone,Mobile,Email
        List < dealer__Dealer_Location__c > listLocation = new List < dealer__Dealer_Location__c > ();

        if (locationId == null || locationId == '') {
            listLocation = [select Id, Name, dealer__Default_Days_to_First_Payment__c, dealer__Default_Rate__c, dealer__Default_Term__c, dealer__Tax_Delivery_Address__c
                from dealer__Dealer_Location__c
                Order By LastModifiedDate DESC
                limit 50
            ];
        } else {
            listLocation = [select Id, Name, dealer__Default_Days_to_First_Payment__c, dealer__Default_Rate__c, dealer__Default_Term__c, dealer__Tax_Delivery_Address__c
                from dealer__Dealer_Location__c
                Where Id =: locationId
                limit 1
            ];
        }

        System.debug(listLocation);
        return listLocation;
    }
    
    //====================Location Lookup code above

    /**
     * getImageVehicle description
     * @return String
     * @description Image Inventory of current vehicle
     */
    public String getImageVehicle() 
    {
        List < dealer__Inventory_Images__c > listImage = new List < dealer__Inventory_Images__c > ();
        string vid = '';

        //Get the current vehicle id
        for (dealer__deal__c d: [select id, dealer__Vehicle__c from dealer__deal__c where id =: currentId]) {
            vid = d.dealer__Vehicle__c;
        }

        //Get the Image Inventories of respective vehicle & return
        listImage = [select id, dealer__Image_URL__c from dealer__Inventory_Images__c where dealer__Vehicle_Inventory__c =: vid and dealer__Sequence_Number__c = 0];
        return JSON.serialize(listImage);
    }

    /**
     * getVehicleReadLookup 
     * @return String
     * @description Get Vehicle for Lookup - IF we have a CustID execute based on ID, else Based on No ID 
     */
    public String getVehicleReadLookup() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        List < dealer__Vehicle_Inventory__c > listVehicleLookup = new List < dealer__Vehicle_Inventory__c > ();

        System.debug(customerId);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listVehicleLookup = getVehicleReadById();
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listVehicleLookup = getVehicleReadById();
        } else {
            System.debug('searching by SOSL');
            listVehicleLookup = getVehicleRead();
        }

        if (listVehicleLookup != null && listVehicleLookup.size() > 0) {
            return JSON.serialize(listVehicleLookup);
        } else {
            return '[]';
        }

        //return JSON.serialize(listVehicleLookup);
    }

    /**
     * getVehicleRead 
     * @return List < dealer__Vehicle_Inventory__c >
     * @description
     */
    public List < dealer__Vehicle_Inventory__c > getVehicleRead() 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        // SOSL Execute
        List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Vehicle_Inventory__c(Id, Name, RecordTypeId, RecordType.Name,
                dealer__Exterior_Color__c, dealer__Interior_Color__c, dealer__Vehicle_Type__c, dealer__Coded_Cost__c, dealer__Mileage__c, dealer__VIN__c,
                dealer__Trim_Level__c, dealer__Invoice_Price__c, dealer__Conversion_Cost__c, dealer__Status_Code__c,
                dealer__Model_Code__c, dealer__New_Used_Other__c,
                dealer__Ramp_Operation__c, dealer__Ramp_Type__c, dealer__Ramp_Location__c, dealer__Work_in_Process__c, dealer__Year__c, dealer__Stock_Number__c,
                dealer__Make__c, dealer__Model__c, dealer__Vehicle_Cost__c, dealer__Purchase_Price__c, dealer__Retail_Price__c, dealer__Conversion_Price__c WHERE dealer__In_Stock__c = true AND RecordType.Name != 'Rental')
            LIMIT 50
        ];
        List < dealer__Vehicle_Inventory__c > cResults = (List < dealer__Vehicle_Inventory__c > ) soslResults[0];

        return cResults;
    }

    /**
     * getVehicleReadById 
     * @return List < dealer__Vehicle_Inventory__c >
     * @description Read dealer__Vehicle_Inventory__c by Id/No Id
     */
    public List < dealer__Vehicle_Inventory__c > getVehicleReadById() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for customer based on Name
        List < dealer__Vehicle_Inventory__c > listVehicle = new List < dealer__Vehicle_Inventory__c > ();

        if (customerId == null || customerId == '') {
            listVehicle = [select Id, Name, RecordTypeId, RecordType.Name,
                dealer__Exterior_Color__c, dealer__Interior_Color__c, dealer__Vehicle_Type__c, dealer__Coded_Cost__c, dealer__Mileage__c, dealer__VIN__c,
                dealer__Trim_Level__c, dealer__Invoice_Price__c, dealer__Conversion_Cost__c, dealer__Status_Code__c,
                dealer__Model_Code__c, dealer__New_Used_Other__c,
                dealer__Ramp_Operation__c, dealer__Ramp_Type__c, dealer__Ramp_Location__c, dealer__Work_in_Process__c, dealer__Year__c, dealer__Stock_Number__c,
                dealer__Make__c, dealer__Model__c, dealer__Vehicle_Cost__c, dealer__Purchase_Price__c, dealer__Retail_Price__c, dealer__Conversion_Price__c,
                (select id, dealer__Image_URL__c from dealer__Inventory_Images__r where dealer__Sequence_Number__c = 0)
                from dealer__Vehicle_Inventory__c WHERE dealer__In_Stock__c = true AND RecordType.Name != 'Rental'
                Order By LastModifiedDate DESC
                limit 50
            ];
        } else {
            listVehicle = [select Id, Name, RecordTypeId, RecordType.Name,
                dealer__Exterior_Color__c, dealer__Interior_Color__c,  dealer__Vehicle_Type__c, dealer__Coded_Cost__c, dealer__Mileage__c, dealer__VIN__c,
                dealer__Trim_Level__c, dealer__Invoice_Price__c, dealer__Conversion_Cost__c, dealer__Status_Code__c,
                dealer__Model_Code__c, dealer__New_Used_Other__c,
                dealer__Ramp_Operation__c, dealer__Ramp_Type__c, dealer__Ramp_Location__c, dealer__Work_in_Process__c, dealer__Year__c, dealer__Stock_Number__c,
                dealer__Make__c, dealer__Model__c, dealer__Vehicle_Cost__c, dealer__Purchase_Price__c, dealer__Retail_Price__c, dealer__Conversion_Price__c,
                (select id, dealer__Image_URL__c from dealer__Inventory_Images__r where dealer__Sequence_Number__c = 0)
                from dealer__Vehicle_Inventory__c 
                Where Id =: customerId AND dealer__In_Stock__c = true AND RecordType.Name != 'Rental'
                limit 1
            ];
        }

        System.debug(listVehicle);
        return listVehicle;
    }

    /**
     * getSerVehicleReadLookup 
     * @return String
     * @description Get Service Vehicle for Lookup. IF we have a CustID execute based on ID, else Based on No ID.
     */
    public String getSerVehicleReadLookup() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        List < dealer__Service_Vehicle__c > listVehicleLookup = new List < dealer__Service_Vehicle__c > ();

        System.debug(customerId);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listVehicleLookup = getSerVehicleReadById();
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listVehicleLookup = getSerVehicleReadById();
        } else {
            System.debug('searching by SOSL');
            listVehicleLookup = getSerVehicleRead();
        }

        return JSON.serialize(listVehicleLookup);
    }

    /**
     * getSerVehicleRead 
     * @return List < dealer__Service_Vehicle__c >
     * @description Read dealer__Service_Vehicle__c by SOSL
     */
    public List < dealer__Service_Vehicle__c > getSerVehicleRead() 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        // SOSL Execute
        List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Service_Vehicle__c(Id, Name, dealer__Vehicle_Type__c, dealer__VIN__c,
            dealer__Trim_Level__c, dealer__Status_Code__c, dealer__Model_Code__c,
            dealer__Year__c, dealer__Last_Odometer__c, dealer__Ext_Color__c, dealer__Int_Color__c,
            dealer__Make__c, dealer__Stock_Number__c, dealer__Carline__c) LIMIT 50];
        List < dealer__Service_Vehicle__c > cResults = (List < dealer__Service_Vehicle__c > ) soslResults[0];

        return cResults;
    }

    /**
     * getSerVehicleReadById 
     * @return List < dealer__Service_Vehicle__c >
     * @description Read dealer__Service_Vehicle__c by Id/No Id
     */
    public List < dealer__Service_Vehicle__c > getSerVehicleReadById() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for customer based on Name
        List < dealer__Service_Vehicle__c > listVehicle = new List < dealer__Service_Vehicle__c > ();

        if (customerId == null || customerId == '') {
            listVehicle = [select Id, Name, dealer__Vehicle_Type__c, dealer__VIN__c,
                dealer__Trim_Level__c, dealer__Status_Code__c, dealer__Model_Code__c,
                dealer__Year__c, dealer__Last_Odometer__c, dealer__Ext_Color__c, dealer__Int_Color__c,
                dealer__Make__c, dealer__Stock_Number__c, dealer__Carline__c
                from dealer__Service_Vehicle__c
                Order By LastModifiedDate DESC
                limit 50
            ];
        } else {
            listVehicle = [select Id, Name, dealer__Vehicle_Type__c, dealer__VIN__c,
                dealer__Trim_Level__c, dealer__Status_Code__c, dealer__Model_Code__c,
                dealer__Year__c, dealer__Last_Odometer__c, dealer__Ext_Color__c, dealer__Int_Color__c,
                dealer__Make__c, dealer__Stock_Number__c, dealer__Carline__c
                from dealer__Service_Vehicle__c
                Where Id =: customerId
                limit 1
            ];
        }

        System.debug(listVehicle);
        return listVehicle;
    }

    /**
     * getAppraisalsWithVehicle 
     * @return String
     * @description 
     */
    public String getAppraisalsWithVehicle() 
    {

        String dealId = Apexpages.currentPage().getParameters().get('dealId');
        List < dealer__Appraisal__c > listAppraisals = new List < dealer__Appraisal__c > ();

        dealer__Deal__c d = [SELECT Id, Name, dealer__Sales_lead__r.dealer__Customer_Account__c FROM dealer__Deal__c Where Id =: dealId];
        String customerId = d.dealer__Sales_Lead__r.dealer__Customer_Account__c;

        system.debug('DealId: ' + dealId + 'deal ' + customerId);
        //first look if there is an appraisal with the current deal's customer as a sales-up
        //if no results are found display the most recent 50 in decending order
        if (customerId != null) {
            listAppraisals = [SELECT Id, Name, dealer__Appraised_Value__c, dealer__Appraisal_Date__c, dealer__Requested_By__r.Name, dealer__Appraised_By__r.Name, dealer__ACV_Actual_Cash_Value__c, dealer__Trade_In__r.dealer__Pay_Off_Amount__c, dealer__Trade_In__r.dealer__Net__c, dealer__Trade_In__r.dealer__Trade_Allowance__c, dealer__Sales_Up__r.dealer__Customer_Account__c, dealer__Service_Vehicle__r.dealer__Last_6__c, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Trim_Level__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c
                FROM dealer__Appraisal__c
                WHERE dealer__Service_Vehicle__c != NULL And dealer__Sales_Up__r.dealer__Customer_Account__c =: customerId
                Order By LastModifiedDate DESC
                LIMIT 50
            ];
        }
        if (listAppraisals.size() == 0) {
            listAppraisals = [SELECT Id, Name, dealer__Appraised_Value__c, dealer__Appraisal_Date__c, dealer__Requested_By__r.Name, dealer__Appraised_By__r.Name, dealer__ACV_Actual_Cash_Value__c, dealer__Trade_In__r.dealer__Pay_Off_Amount__c, dealer__Trade_In__r.dealer__Net__c, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Trade_In__r.dealer__Trade_Allowance__c, dealer__Service_Vehicle__r.dealer__Last_6__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Trim_Level__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c
                FROM dealer__Appraisal__c
                WHERE dealer__Service_Vehicle__c != NULL
                Order By LastModifiedDate DESC
                LIMIT 50
            ];
        }

        return JSON.serialize(listAppraisals);
    }

    /**
     * getAppraisalReadLookup 
     * @return String
     * @description Get dealer__Appraisal_Vehicle__c for Lookup. IF we have a CustID execute based on ID, else Based on No ID .
     */
    public String getAppraisalReadLookup() 
    {

        //string customerId = ApexPages.currentPage().getParameters().get('custid');

        String dealId = Apexpages.currentPage().getParameters().get('dealId');
        List < dealer__Appraisal__c > listAppraisals = new List < dealer__Appraisal__c > ();

        dealer__Deal__c d = [SELECT Id, Name, dealer__Sales_lead__r.dealer__Customer_Account__c FROM dealer__Deal__c Where Id =: dealId];
        String customerId = d.dealer__Sales_Lead__r.dealer__Customer_Account__c;

        system.debug('DealId: ' + dealId + 'deal ' + customerId);

        List < dealer__Appraisal__c > listVehicleLookup = new List < dealer__Appraisal__c > ();

        System.debug('cust Id ' + customerId);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listVehicleLookup = getAppraisalReadById(customerId);
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listVehicleLookup = getAppraisalReadById(customerId);
        } else {
            System.debug('searching by SOSL');
            listVehicleLookup = getAppraisalRead();
        }

        if (listVehicleLookup == null) {
            listVehicleLookup = new List < dealer__Appraisal__c > ();
        }

        return JSON.serialize(listVehicleLookup);
    }

    /**
     * getAppraisalRead 
     * @return List < dealer__Appraisal__c >
     * @description Read dealer__Appraisal_Vehicle__c by SOSL. this implementation was never complete ?
     */
    public List < dealer__Appraisal__c > getAppraisalRead() 
    {
        // Get URL Parameters and SOSL

        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));
        system.debug(searchAsk);

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        searchAsk = '%' + searchAsk + '%';

        List < dealer__Appraisal__c > apvehList = [
            SELECT Id, Name, dealer__Appraised_Value__c, dealer__Appraisal_Date__c, dealer__Requested_By__r.Name, dealer__Appraised_By__r.Name, dealer__ACV_Actual_Cash_Value__c, dealer__Trade_In__r.dealer__Pay_Off_Amount__c, dealer__Trade_In__r.dealer__Net__c, dealer__Service_Vehicle__r.Name, dealer__Trade_In__r.dealer__Trade_Allowance__c, dealer__Sales_Up__r.dealer__Customer_Account__c, dealer__Service_Vehicle__r.dealer__Last_6__c, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Trim_Level__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c
            FROM dealer__Appraisal__c
            WHERE dealer__Service_Vehicle__c != Null
            And(Name like: searchAsk OR dealer__Service_Vehicle__r.dealer__Last_6__c like: searchAsk OR dealer__Service_Vehicle__r.dealer__Year__c like: searchAsk OR dealer__Service_Vehicle__r.dealer__Make__c like: searchAsk OR dealer__Service_Vehicle__r.dealer__Carline__c like: searchAsk OR dealer__Service_Vehicle__r.dealer__VIN__c like: searchAsk)
            LIMIT 50
        ];

        return apvehList;
    }

    /**
     * getAppraisalReadById 
     * @param  customerId 
     * @return List < dealer__Appraisal__c >
     * @description Read dealer__Appraisal_Vehicle__c by Id/No Id.
     */
    public List < dealer__Appraisal__c > getAppraisalReadById(String customerId) 
    {

        // Dynamic filters passed to this method to search for customer based on Name
        List < dealer__Appraisal__c > listVehicle = new List < dealer__Appraisal__c > ();

        if (customerId == null || customerId == '') {
            listVehicle = [SELECT Id, Name, dealer__Appraised_Value__c, dealer__Appraisal_Date__c, dealer__Requested_By__r.Name, dealer__Appraised_By__r.Name, dealer__ACV_Actual_Cash_Value__c, dealer__Trade_In__r.dealer__Pay_Off_Amount__c, dealer__Trade_In__r.dealer__Net__c, dealer__Trade_In__r.dealer__Trade_Allowance__c, dealer__Sales_Up__r.dealer__Customer_Account__c, dealer__Service_Vehicle__r.dealer__Last_6__c, dealer__Service_Vehicle__r.Name, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Trim_Level__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c
                FROM dealer__Appraisal__c
                WHERE dealer__Service_Vehicle__c != Null
                Order By LastModifiedDate DESC
                limit 50
            ];
        } else {
            system.debug('looking for customer vins');
            listVehicle = [SELECT Id, Name, dealer__Appraised_Value__c, dealer__Appraisal_Date__c, dealer__Requested_By__r.Name, dealer__Appraised_By__r.Name, dealer__ACV_Actual_Cash_Value__c, dealer__Trade_In__r.dealer__Pay_Off_Amount__c, dealer__Trade_In__r.dealer__Net__c, dealer__Trade_In__r.dealer__Trade_Allowance__c, dealer__Sales_Up__r.dealer__Customer_Account__c, dealer__Service_Vehicle__r.dealer__Last_6__c, dealer__Service_Vehicle__r.Name, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Trim_Level__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c
                FROM dealer__Appraisal__c
                WHERE dealer__Service_Vehicle__c != NULL And dealer__Sales_Up__r.dealer__Customer_Account__c =: customerId
                Order By LastModifiedDate DESC
                LIMIT 50
            ];
        }

        System.debug(listVehicle);
        return listVehicle;
    }

    /**
     * getAccountReadLookup 
     * @return String
     * @description Get Account for Lookup. IF we have a CustID execute based on ID, else Based on No ID.
     */
    public String getAccountReadLookup() 
    {
        string dealId = ApexPages.currentPage().getParameters().get('dealId');
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        List < Account > listAccountLookup = new List < Account > ();

        //get payors on account

        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            listAccountLookup = getAccountReadById();
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            listAccountLookup = getAccountReadById();
        } else {
            listAccountLookup = getAccountRead();
        }

        Map < Id, Account > accountMap = new Map < Id, Account > ();

        if (listAccountLookup == null) {
            listAccountLookup = new List < Account > ();
        } else if (listAccountLookup != null) {
            for (Account a: listAccountLookup) {
                accountMap.put(a.id, a);
            }
        }
        Set < Id > payeeIdSet = new Set < Id > ();
       // dealer__Deal__c d = [SELECT Id, dealer__Deferred_1_Payee__c, dealer__Deferred_2_Payee__c, dealer__Deferred_3_Payee__c FROM dealer__Deal__c WHERE Id =: dealId]; 
        for(dealer__Deal__c d : [SELECT Id, dealer__Deferred_1_Payee__c, dealer__Deferred_2_Payee__c, dealer__Deferred_3_Payee__c FROM dealer__Deal__c WHERE Id =: dealId]){
            if (d.dealer__Deferred_1_Payee__c != null && !payeeIdSet.contains(d.dealer__Deferred_1_Payee__c) && !accountMap.containsKey(d.dealer__Deferred_1_Payee__c)) {
                payeeIdSet.add(d.dealer__Deferred_1_Payee__c);
            }
            if (d.dealer__Deferred_2_Payee__c != null && !payeeIdSet.contains(d.dealer__Deferred_2_Payee__c) && !accountMap.containsKey(d.dealer__Deferred_2_Payee__c)) {
                payeeIdSet.add(d.dealer__Deferred_2_Payee__c);
            }
            if (d.dealer__Deferred_3_Payee__c != null && !payeeIdSet.contains(d.dealer__Deferred_3_Payee__c) && !accountMap.containsKey(d.dealer__Deferred_3_Payee__c)) {
                payeeIdSet.add(d.dealer__Deferred_3_Payee__c);
            }
        }

        
        if (payeeIdSet.size() > 0) {
            for (Account a: [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                    PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  BillingCountry,
                    BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c, 
                    dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                    from Account
                    Where Id in: payeeIdSet
                ]) {
                listAccountLookup.add(a);
            }
        }

        return JSON.serializePretty(listAccountLookup);
    }

    /**
     * getCashierAccountRead
     * @return String
     * @description
     */
    public String getCashierAccountRead()
    {
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        string cashierId = recordId != 'Id' ? recordId : null;
        string dealId = ApexPages.currentPage().getParameters().get('dealId');
        
        String customerId;
        List<Account> listAccount = new List<Account>();

        try{
            if(cashierId!= null){
                //get account from cashier record query
                customerId = [SELECT dealer__Customer__c FROM dealer__Cashering__c WHERE Id =:cashierId].dealer__Customer__c;
            } else {
                //get account from deal query -> return buyer
                customerId = [SELECT dealer__Buyer__c FROM dealer__Deal__c WHERE Id =:dealId].dealer__Buyer__c;
            }
        }catch(QueryException e){
            throw new QueryException(e.getMessage());
        }

        if(customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null){

            listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  BillingCountry,
                BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c, 
                dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                from Account
                Where Id =: customerId
                limit 1
            ];

        }else{
            if(String.valueOf(urlParams.get('filter[filters][0][value]')) != null){
                String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));
                List < List < sObject >> soslResults;
                soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING Account(Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState,
                    PersonMailingPostalCode, IsPersonAccount, Phone,  BillingCountry,
                    BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                    dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc) LIMIT 50];
                    listAccount = (List < Account > ) soslResults[0];
            } else {
                    listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                        PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  
                        BillingCountry, BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                        dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc 
                        from Account Order By LastModifiedDate DESC
                        limit 50
                    ];
            }

        }   
        List<Id> cashAccIdList = New List<Id>();
        //add cashiering accounts under the buyer
        for(dealer__Cashering__c c : [SELECT dealer__Customer__c FROM dealer__Cashering__c WHERE dealer__Deal__c =:dealId]){
            cashAccIdList.add(c.dealer__Customer__c);
        }
        if(cashAccIdList.size()>0){
            for(Account a : [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,   BillingCountry,
                BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                from Account
                Where Id in: cashAccIdList]){
                listAccount.add(a);
            }
        }
        //prevents duplicates of the same account
        Map<Id,Account> retAccounts = new Map<Id,Account>();
        for(Account a : listAccount){
            if(retAccounts.get(a.Id) == null){
                retAccounts.put(a.Id,a);
            }
        }

        return json.serialize(retAccounts.values());
    }

    /**
     * getAccountRead
     * @return List < Account >
     * @description Read account by SOSL
     */ 
    public List < Account > getAccountRead() 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        List < List < sObject >> soslResults;

        // SOSL Execute

        if (isCobuyerSearch) {

            soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING Account(Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState,
                MiddleName, PersonBirthdate, PersonMailingPostalCode, IsPersonAccount, Phone,   BillingCountry,
                BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc where IsPersonAccount = true) LIMIT 50];
        } else {
            soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING Account(Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState,
                MiddleName, PersonBirthdate, PersonMailingPostalCode, IsPersonAccount, Phone,   BillingCountry,
                BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc) LIMIT 50];
        }

        List < Account > cResults = (List < Account > ) soslResults[0];

        return cResults;
    }

    /**
     * getAccountReadById 
     * @return List < Account >
     * @description Read Account by Id/No Id
     */ 
    public List < Account > getAccountReadById() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for customer based on Name,Phone,Mobile,Email
        List < Account > listAccount = new List < Account > ();

        if (customerId == null || customerId == '') {
            if(dealId != null){}
            if (isCobuyerSearch) {
                listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                    MiddleName, PersonBirthdate,  PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  
                    BillingCountry, BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                    dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                    from Account where IsPersonAccount = true Order By LastModifiedDate DESC
                    limit 50
                ];
            }  else {
                listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                    MiddleName, PersonBirthdate,  PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  
                    BillingCountry, BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                    dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                    from Account Order By LastModifiedDate DESC
                    limit 50
                ];
            }

        } else {
            listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                PersonBirthdate,  PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,   BillingCountry,
                BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                from Account
                Where Id =: customerId
                limit 1
            ];
        }

        System.debug(listAccount);
        return listAccount;
    }

    /**
     * getCategoryRead 
     * @param  type 
     * @return  List < dealer__Kit_Category__c >
     * @description Get the Conversion Kit Lookups
     */
    public List < dealer__Kit_Category__c > getCategoryRead(string type) 
    {
        // Get URL Parameters and SOSL
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return null;
        }

        // SOSL Execute
        List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Kit_Category__c(Id, Name where dealer__Type__c =: type) LIMIT 50];
        List < dealer__Kit_Category__c > cResults = (List < dealer__Kit_Category__c > ) soslResults[0];

        return cResults;
    }

    /**
     * getCategoryReadLookup 
     * @return String
     * @description Get Category for lookup
     */
    public String getCategoryReadLookup() 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');
        string type = ApexPages.currentPage().getParameters().get('type');
        List < dealer__Kit_Category__c > listCategoryLookup = new List < dealer__Kit_Category__c > ();

        System.debug('Type - ' + type);
        if (customerId == null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID no ID');
            listCategoryLookup = getCategoryReadById(type);
        } else if (customerId != null && String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            listCategoryLookup = getCategoryReadById(type);
        } else {
            System.debug('searching by SOSL');
            listCategoryLookup = getCategoryRead(type);
        }

        return JSON.serializePretty(listCategoryLookup); // Send across as raw JSON Data
    }

    /**
     * getCategoryReadById 
     * @param  type 
     * @return List < dealer__Kit_Category__c >
     * @description Read dealer__Kit_Category__c by Id/No Id
     */
    public List < dealer__Kit_Category__c > getCategoryReadById(string type) 
    {
        string customerId = ApexPages.currentPage().getParameters().get('custid');

        // Dynamic filters passed to this method to search for customer based on Name,Phone,Mobile,Email
        List < dealer__Kit_Category__c > listCategory = new List < dealer__Kit_Category__c > ();

        if (customerId == null || customerId == '') {
            listCategory = [select Id, Name
                from dealer__Kit_Category__c where dealer__Type__c =: type
                Order By Name ASC
                limit 300
            ];
        } else {
            listCategory = [select Id, Name
                from dealer__Kit_Category__c where dealer__Type__c =: type
                and Id =: customerId
                limit 1
            ];
        }

        System.debug(listCategory);
        return listCategory;
    }

    //End of Category record fetch code

    /**
     * getBuyerAccount 
     * @return string
     * @description
     */
    public string getBuyerAccount() 
    {
        string dealId = ApexPages.currentPage().getParameters().get('dealId');
        dealer__Deal__c objDeal = getDealRecord()[0];
        set < Id > accIds = new Set < Id > ();
        accIds.add(objDeal.dealer__Buyer__c);
        accIds.add(objDeal.dealer__Co_Buyer__c);
        accIds.add(objDeal.dealer__Broker__c);
        List < Account > listAccount = new List < Account > ([select id, Phone,   BillingCountry, Name, FirstName, LastName, PersonEmail,
            PersonMobilePhone, PersonBirthdate,  PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonHomePhone,
            BillingStreet, BillingCity, BillingState, BillingPostalCode, IsPersonAccount, dealer__Billing_Email__c, MiddleName,
            dealer__Drivers_License_Number__pc, dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_State__pc  from Account
            where Id in: accIds
        ]);

        return JSON.serializePretty(listAccount);
    }

    /**
     * getUserJson 
     * @return string
     * @description
     */
    public string getUserJson(List < User > u) 
    {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();

        for (User objUser: u) {
            gen.writeStartObject();

            gen.writeStringField('custId', objUser.Id);
            gen.writeStringField('Name', objUser.Name);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        return gen.getAsString();
    }
	
    /**
     * selectedAccount 
     * @param  accId 
     * @return Account
     * @description
     */
    @RemoteAction
    public static Account selectedAccount(String accId)
    {
        
        system.debug('acc Id ' + accId);
        if(accId != null && accId != ''){
        	List<Account> listAccount = [select Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity,
                    PersonBirthdate,  PersonMailingState, PersonMailingPostalCode, IsPersonAccount, Phone,  
                    BillingCountry, BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
                    MiddleName, dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc
                    from Account Where id =: accId];
                    system.debug('acc res ' + listAccount);

            if(listAccount.size()>0) return listAccount[0];
        }
        return null;
    }
    
    /**
     * checkRoQueue 
     * @param  dealId 
     * @param  jobId  
     * @return dealer__Service_Repair_Order__c
     */
    @RemoteAction
    public static dealer__Service_Repair_Order__c checkRoQueue(String dealId, String jobId)
    {
        if([SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID].Status == 'Completed'){
            return [SELECT Id, Name, dealer__Deal__C FROM dealer__Service_Repair_Order__c Where dealer__Deal__c =: dealId];
        }
        return new dealer__Service_Repair_Order__c();
    }
    
    /**
     * createDeliveryRepairOrder 
     * @param  dealId 
     * @return Id
     * @description
     */
    @RemoteAction
    public static Id createDeliveryRepairOrder(String dealId) 
    {
        /* Add method to check to see if the Record Is Locked, as this is an
        ansync process, we need to notify the end user */
        try {
            if (Approval.isLocked(dealId)) {
                throw new DealTRSControllerException('Record is locked in an approval process.  Please contact current approver. ');
            }
        }
        Catch(NoAccessException e) {
            /*
            You need to go to
            Setup->Create-> Workflows and Approvals -> Process Automation Settings
            and set checkbox Enable record locking and unlocking in Apex as true

            */
        }
        try {
            DealQueueRo newDRO = new DealQueueRo(dealId);
            Id jobId = System.enqueueJob(newDRO);
            // DealTRSController.newDeliveryRO(dealId);
            return jobId;
        }
        Catch(Exception e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * closeDeal 
     * @param  dealId 
     * @return boolean
     * @description
     */
    @RemoteAction
    public static boolean closeDeal(String dealId) 
    {

        if (dealId == null || dealId == '')
            throw new DealTRSControllerException('closeDeal method requires a valid deal ID');

        List < dealer__Deal__c > deals = [SELECT Id, dealer__Sales_Lead__c, dealer__Deal_Date__c,
            dealer__Delivery_Date__c, dealer__Vehicle__c,
            dealer__Service_Vehicle__c, dealer__Mileage__c, dealer__Buyer__c,
            dealer__Buyer_Contact__c
            FROM dealer__Deal__c
            WHERE Id =: dealId
        ];
        deals[0].dealer__Deal_Close_Date__c = System.Today();
        deals[0].dealer__Status__c = 'Posted';
        try {
            update deals;
            dealer.DealAPI.closeDeals(deals);

            // Email the Connected Accounting System.
            String accountingPayload = '{"recordId" : "'+deals[0].Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "dealpost" }';
            dealer.Cashier.emailAsyncHandler(accountingPayload);            

        } Catch(Exception e) {

            throw new DealTRSControllerException(e.getMessage());
        }

        return true;
    }
    
    /**
     * removeSuggestedForm 
     * @param  dealId 
     * @param  formId 
     * @return string
     * @string
     */
    @RemoteAction 
    public static string removeSuggestedForm(Id dealId, Id formId)
    {
        System.assert(Schema.sObjectType.dealer__FormRef__c.fields.dealer__Deselected__c.isUpdateable(),'You do not have the required permissions to remove this Form Reference from this deal. Please see your administrator.');
        try{
            Deal__c deal = [SELECT Id, Store_Location__c From Deal__c WHERE Id =: dealId];
            Form__c form = [SELECT Name, Id, Page_Name__c FROM Form__c WHERE Id=:formId];
            insert new FormRef__c(Form__c=form.Id,
                                Location__c=deal.Store_Location__c,
                                Deselected__c=deal.Id);
        } catch(DMLException e) {
            throw new DealTRSControllerException(e.getMessage());
        } catch(QueryException e){
            throw new DealTRSControllerException(e.getMessage());
        }
        return 'Success';
    }

    /**
     * printFormBundle 
     * @param  dealId  
     * @param  formIds 
     * @return String
     */
    @RemoteAction
    public static String printFormBundle(Id dealId, List<String> formIds)
    {


        // Map to store existing deal forms for the deal 
        //Used to create deal forms for suggested forms that do not currently have a deal form.
        // <FormId,Deal_Form__c>
        Map<Id,Deal_Form__c> existingDealForms = new Map<Id,Deal_Form__c>();
        for(Deal_Form__c df : [SELECT Id, Deal__c, Form__c FROM Deal_Form__c WHERE Deal__c =: dealId ]){
            existingDealForms.put(df.Form__c, df);
        }

        list<dealer__Form__c> formList = new List<dealer__Form__c>();
        list<Deal_Form__c> newDealForms = new List<Deal_Form__c>();
        try{
            if(formIds.size() > 0){
                for(Form__c form: [SELECT Id, dealer__DocumentContentId__c, dealer__Page_Name__c, dealer__Print_Type__c, dealer__FDF_Code__c FROM dealer__Form__c WHERE Id In:formIds ]){
                    formList.add(form);
                    if(existingDealForms.get(form.Id) == null){
                        newDealForms.add(new Deal_Form__c(Name='DealForm + current datetime',Deal__c=dealId,Form__c=form.Id ));
                    }
                }
            }
        } catch (QueryException e){
            throw new DealTRSControllerException(e.getMessage());
        }

        if(formList.size() > 0){
			
            User u = [SELECT Id, UserPreferencesApexPagesDeveloperMode FROM User Where Id =: userInfo.getUserId()];
            //W-001763 Prevent print merge documents when developer mode is enabled
            if(u.UserPreferencesApexPagesDeveloperMode){
                throw new DealTRSControllerException('It is not possible to print multiple documents with developer mode enabled.');
            }
            
            String retString = dealer.FormAPI.mergeForms(dealId,formList);
            if(newDealForms.size() > 0){
                insert newDealForms;
            }
            return retString;
        }
        return null;
    }

    /**
     * createNewDealForms 
     * @param  dealForms 
     * @return void
     * @description
     */
    @future
    public static void createNewDealForms(String dealForms) 
    {
        try {
            List<Deal_Form__c> newDealForms = (List<Deal_Form__c>)json.deserialize(dealForms,Deal_Form__c.class);

            insert newDealForms;
        }
        Catch(Exception e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * createRemoteVFResource
     * @param  dealId
     * @return List < String >
     * @description
     */
    private static List < String > createRemoteVFResource(Id dealId, List < dealer__Form__c > forms) 
    {
        List < String > body = new List < String > ();
        for (dealer__Form__c f: forms) {
            system.assert(f.dealer__Page_Name__c != null, 'A form name must be included to print a laser form.');
            PageReference pdf = new PageReference('/apex/' + f.dealer__Page_Name__c);
            pdf.getParameters().put('id', dealId);
            try {
                body.add(EncodingUtil.base64Encode(pdf.getContent()));
            } catch (VisualforceException e) {
                throw new AuraHandledException('Problem printing document: ' + e.getMessage());
            }
        }

        return (body.size() > 0 ? body : new List < String > ());
    }

    /**
     * generateFDF 
     * @param  dealId 
     * @return Map < String, String >
     * @description
     */
    private static Map < String, String > generateFDF(Id dealId, List < dealer__Form__c > forms) {
        Map < String, String > formMap = new Map < String, String > ();
        for (dealer__Form__c f: forms) {
            if (f.dealer__FDF_Code__c != null && f.dealer__FDF_Code__c.Length() > 0) {

                String urlPR = '/apex/dealer__FormFDFData?fid=' + f.Id + '&did=' + dealId;
                PageReference p = new PageReference(urlPR);
                Blob uContent;
                if (Test.isRunningTest()) {
                    uContent = blob.valueof('TEST');
                } else {
                    uContent = p.getContent();
                }
                if (uContent != null) {
                    formMap.put(f.dealer__DocumentContentId__c, EncodingUtil.base64Encode(uContent));
                }
            }
        }
        return formMap.size() > 0 ? formMap : new Map < String, String > ();
    }

        public class formWrapper {
        String documentId;
        String docType;
        String content;
        String mergeData;

        public formWrapper(String documentId, String docType, String content, string mergeData) {
            documentId = documentId;
            docType = docType;
            content = content;
            mergedata = mergedata;
        }
    }

    /**
     * generateBodyJSON 
     * @return String
     * @description 
     */
    private static String generateBodyJSON(Map < String, String > fdfMap, List < String > forms) {
        Json j = new Json();

        JSONGenerator gen = JSON.createGenerator(true);
        List < formWrapper > formList = new List < formWrapper > ();

        for (String dId: fdfMap.keyset()) {
            formWrapper f = new formWrapper('', '', '', '');
            f.documentId = dId;
            f.docType = 'FDF';
            f.content = '';
            f.mergeData = fdfMap.get(dId);
            formList.add(f);
        }
        for (String pdf: forms) {
            formWrapper f = new formWrapper('', '', '', '');
            f.documentId = '';
            f.docType = 'Laser';
            f.content = pdf;
            f.mergeData = '';
            formList.add(f);
        }

        gen.writeStartObject();
        gen.writeFieldName('Forms');
        gen.writeObject(formList);
        gen.writeEndObject();

        system.debug('g ' + gen.getAsString());
        return gen.getAsString();
    }



    /*
    private static void accountingEmailInterface(String payload) {
        
            ApexClass[] apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'SageLiveEmailService' and NamespacePrefix = 'dtsa') limit 1];
            if(apexClass.size()==0)
                    return;
        
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass[0].Id limit 1]; 
            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];
            String emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;   
        
        try {

            if(Test.isRunningTest()) {
                emailHandle = 'fake@blackhole.org';
            }

            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {emailHandle};
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Asyncnronous Processing Request');
            mail.setPlainTextBody(payload);
        
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Accounting Interface - Posting service not enabled.'));            
        }         
    }
    */

    /**
     * newDeliveryRO 
     * @param  dealId 
     * @description
     */ 
    @future
    public static void newDeliveryRO(String dealId) 
    {
        try {
            dealer__Deal__c thedeal = [SELECT Id, dealer__Buyer__c, dealer__DeliveryRepairOrder__c, dealer__Vehicle__c,
                dealer__Vehicle__r.dealer__Mileage__c, dealer__VIN__c,
                dealer__Service_Vehicle__c, dealer__Store_Location__c, dealer__Mileage__c
                FROM dealer__Deal__c
                WHERE Id =: dealId
            ];
            dealer.ServiceRepairOrderAPI.createRepairOrderFromDeal(thedeal);
        }
        Catch(Exception e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * getPdfBody 
     * @return string
     * @description Get Merge PDF body
     */
    public string getPdfBody(List < dealer__Form__c > lstOfForms) 
    {
        Transient string body = '';
        Integer i = 0;
        if (lstOfForms != null && lstOfForms.size() > 0) {
            for (dealer__Form__c myForm: lstOfForms) {

                transient string base, jsonName = '{"DocumentContentId" : "' + myForm.Id + '","order" : ' + i;
                PageReference page = new PageReference('/apex/DealFormPDF?formId=' + myForm.Id);
                transient Blob pdfBlob;
                if (test.isRunningTest()) {
                    pdfBlob = blob.valueof('TEST');
                } else {
                    pdfBlob = page.getContent();
                }
                base = EncodingUtil.base64Encode(pdfBlob);
                jsonName += ',"content" : "' + base + '","type" : "Laser"}';
                if (body != '')
                    body += ',' + jsonName;
                else
                    body += jsonName;
                i++;
            }
        }
        return '[' + body + ']';
    }

    /**
     * doHttpRequest 
     * @param  body   
     * @param  isSave
     * @return string
     */
    public string doHttpRequest(string body, boolean isSave) 
    {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://apsv1.dealerteam.com/docgen/merge.php');
        req.setMethod('POST');
        req.setHeader('content-type', 'application/json');
        //body = '[{"order" : 1,"type" : "Laser","DocumentContentId" : "dfsdfsdfee","content" : "'+base+'"},{"order" : 2,"type" : "Laser","DocumentContentId" : "ffffseevvv","content" : "'+base2+'"}]';
        req.setBody(body);

        Http http = new Http();
        try {
            transient HTTPResponse res = http.send(req);
            String content = '{"body":"' + EncodingUtil.base64Encode(res.getBodyAsBlob()) + '"}';
            res = null;
            return content;
        } catch (Exception e) {}

        return null;
    }

    //==========   End of Merging Forms  ==============

    /**
     * deleteLaserDealForm 
     * @return String
     * @description
     */
    public String deleteLaserDealForm() 
    {
        String dealId = urlParams.get('dealId');
        String formId = urlParams.get('dealer__Form__c');
        System.debug('Deal Id == ' + dealId);
        System.debug('Form Id == ' + formId);
        List < dealer__Deal_Form__c > dealForm = [Select id, dealer__Form__r.Name from dealer__Deal_Form__c where dealer__Deal__c =: dealId AND dealer__Form__c =: formId];
        delete dealForm;

        return getSelectedLaserForm();
    }


    /**
     * deleteImpactDealForm 
     * @return String
     * @description
     */
    public String deleteImpactDealForm() 
    {
        String dealId = urlParams.get('dealId');
        String formId = urlParams.get('dealer__Form__c');
        System.debug('Deal Id == ' + dealId);
        System.debug('Form Id == ' + formId);

        List < dealer__Deal_Form__c > dealForm = [Select id, dealer__Form__r.Name from dealer__Deal_Form__c where dealer__Deal__c =: dealId AND dealer__Form__c =: formId];
        delete dealForm;
        return getSelectedImpactForm();
    }

    /**
     * getSelectedForm 
     * @return String
     * @description
     */
    public String getSelectedForm() 
    {
        dealer__Deal_Form__c dealForm = new dealer__Deal_Form__c();
        dealForm.Name = 'DealForm ' + System.now();
        dealForm.dealer__Deal__c = urlParams.get('dealId');
        dealForm.dealer__Form__c = urlParams.get('dealer__Form__c');

        insert dealForm;
        String name = urlParams.get('dealer__Form__r.dealer__Print_Type__c');
        String dealId = urlParams.get('dealId');
        String formId = urlParams.get('dealer__Form__c');
        List < dealer__Deal_Form__c > lstOfForm = [Select id, Name, dealer__Form__r.Name, dealer__Form__c, dealer__Deal__c, dealer__Form__r.dealer__Print_Type__c, dealer__Form__r.dealer__DocumentContentId__c, dealer__Form__r.dealer__Page_Name__c from dealer__Deal_Form__c where dealer__Form__r.dealer__Print_Type__c =: name and dealer__Deal__c =: dealId and dealer__Form__c =: formId];

        return JSON.serialize(lstOfForm);
    }

    /**
     * getDeal 
     * @return String
     * @description Get the deal record
     */
    public String getDeal() 
    {

        if (currentId == null) {
            //Return an Error message if no Id is specified in url
            return '{"error":"A proper Deal Id was not submitted with the read request."}';
        }
        List < dealer__Deal__c > lstDeal = getDealRecord();

        if (lstDeal != null && lstDeal.size() > 0) {
            return JSON.serialize(lstDeal);
        } else {
            return '[]';
        }
    }

    /**
     * getDealRecord 
     * @return List < dealer__Deal__c >
     * @description
     */ 
    public List < dealer__Deal__c > getDealRecord() 
    {

        //Query Deal using deal id parameter
        List <dealer__Deal__c> lstDeal = [select Id, Name,
            dealer__Aftermarket_Gross__c,
            dealer__Year__c,
            dealer__Make__c,
            dealer__Model__c,
            dealer__VIN__c,
            dealer__Trim_Level__c,
            dealer__Exterior_Color__c,
            dealer__Interior_Color__c,
            dealer__Days__c,
            dealer__Buyer__c,
            dealer__Buyer_City__c,
            dealer__Buyer_Address__c,
            dealer__Buyer__r.Name,
            dealer__Buyer__r.IsPersonAccount,
            dealer__Buyer__r.dealer__Tax_ID__c,
            dealer__County__c,
            dealer__Status__c,
            dealer__Service_Vehicle__c,
            dealer__Service_Vehicle__r.Name,
            dealer__Service_Vehicle__r.dealer__Veh_Owner__c,
            dealer__Deal_ID__c,
            dealer__Vehicle__r.dealer__Ramp_Location__c,
            dealer__Broker_Home_Phone__c,
            dealer__Broker_Mobile_Phone__c,
            dealer__Broker_Email__c,
            dealer__DeliveryRepairOrder__c,
            dealer__Buyer_County__c,
            dealer__Disposition__c,
            dealer__Buyer_Email__c,
            dealer__Buyer_Postal_Code__c,
            dealer__Buyer_State__c,
            dealer__Co_Buyer__r.isPersonAccount,
            dealer__Co_Buyer__r.dealer__Tax_ID__c,
            dealer__Buyer_Mobile_Phone__c,
            dealer__Buyer_Home_Phone__c,
            dealer__Co_Buyer__c,
            dealer__Co_Buyer__r.Name,
            dealer__Co_Buyer_Address__c,
            dealer__Co_Buyer_Drivers_Lic_State__c,                              
            dealer__Vehicle_Price__c,
            dealer__Conversion_Price__c,
            dealer__Vehicle__r.dealer__Conversion__r.dealer__Product_Tax_Code__c,
            dealer__Stock_Number__c,
            dealer__Mileage__c,
            dealer__Buyer_Drivers_License__c,
            dealer__Buyer_Drivers_License_Exp_Date__c,
            dealer__Buyer_Drivers_Lic_State__c, 
            dealer__Buyer_Middle_Name__c, 
            dealer__Co_Buyer_Drivers_License_Exp_Date__c,
            dealer__Co_Buyer_Drivers_License_Number__c,
            dealer__Buyer_Social_Security_Number__c,
            dealer__Co_Buyer_Social_Security_Number__c,
            dealer__Buyer_Birthdate__c,
            dealer__Co_Buyer_Birth_Date__c,
            dealer__Co_Buyer_Middle_Name__c, 
            dealer__Co_Buyer_City__c,
            dealer__Co_Buyer_County__c,
            dealer__Co_Buyer_Email__c,
            dealer__Co_Buyer_Home_Phone__c,
            dealer__Co_Buyer_Mobile_Phone__c,
            dealer__Co_Buyer_State__c,
            dealer__Co_Buyer_Postal_Code__c,
            dealer__Delivery_Date__c,
            dealer__Business_Department__c,
            dealer__Deal_Date__c,
            dealer__Deal_Close_Date__c,
            dealer__Broker__c,
            dealer__Broker__r.Name,
            dealer__Broker_Address__c,
            dealer__Broker_City__c,
            dealer__Broker_County__c,
            dealer__Broker_Postal_Code__c,
            dealer__Broker_State__c,
            dealer__Business_Title__c,
            dealer__Business_Address__c,
            dealer__Business_Phone__c,
            dealer__Business_Contracting_Name__c,
            dealer__Business_City__c,
            dealer__Business_State__c,
            dealer__Business_Postal_Code__c,
            dealer__Business_County__c,
            dealer__Business_Email__c,
            dealer__Company_Number__c,
            dealer__DeliveryRepairOrderStatus__c,
            dealer__ClientNotes__c,
            dealer__Conversion_Manufacturer__c,
            dealer__Conversion_Model__c,
            dealer__Conversion_Description__c,
            dealer__NUO__c,
            dealer__Vehicle__c,
            Buyer_Contact__c,
            EquipmentInventory__c,
            TaxableVehicleTotal__c,
            EquipmentInventoryPrice__c,
            dealer__Desk_Manager__c,
            dealer__Desk_Manager__r.Name,
            dealer__Sales_Lead__c,
            dealer__Sales_Lead__r.Name,
            dealer__Vehicle__r.Name,
            dealer__Vehicle__r.dealer__Stock_Number__c,
            dealer__Vehicle__r.dealer__Exterior_Color__c,
            dealer__Vehicle__r.dealer__Interior_Color__c,
            dealer__Vehicle__r.dealer__Vehicle_Type__c,
            dealer__Vehicle__r.dealer__Coded_Cost__c,
            dealer__Vehicle__r.dealer__Mileage__c,
            dealer__Vehicle__r.dealer__VIN__c,
            dealer__Vehicle__r.dealer__Trim_Level__c,
            dealer__Vehicle__r.dealer__Invoice_Price__c,
            dealer__Vehicle__r.dealer__Conversion_Cost__c,
            dealer__Vehicle__r.dealer__Status_Code__c,
            dealer__Vehicle__r.dealer__Model_Code__c,
            dealer__Vehicle__r.dealer__Work_in_Process__c,
            dealer__Vehicle__r.dealer__New_Used_Other__c,
            dealer__Vehicle__r.dealer__Year__c,
            dealer__Vehicle__r.dealer__Make__c,
            dealer__Vehicle__r.dealer__Model__c,
            dealer__Vehicle__r.dealer__Retail_Price__c,
            dealer__Vehicle__r.dealer__Purchase_Price__c,
            dealer__Vehicle__r.dealer__Days_in_Stock__c,
            dealer__Vehicle__r.dealer__Conversion_Price__c,
            dealer__Vehicle__r.RecordType.Name,
            dealer__Vehicle__r.dealer__Ramp_Operation__c,
            dealer__Vehicle__r.dealer__Ramp_Type__c,
            dealer__Vehicle__r.dealer__Conversion_Description__c,
            dealer__Vehicle__r.dealer__Conv_Model__c,
            dealer__Order__c,
            dealer__OrderNotes__c,
            dealer__DeliveryRepairOrder__r.Name,
            dealer__Finance_Institution_Account__c,
            dealer__Term__c,
            dealer__Vehicle__r.dealer__Vehicle_Cost__c,
            dealer__DeliveryRepairOrder__r.dealer__Status__c,
            dealer__Days_to_First__c,
            dealer__Payments_Per_Year__c,
            dealer__Rate__c,
            dealer__Amt_Financed__c,
            dealer__Monthly_Pymt__c,
            dealer__F_I_Manager__r.Name,
            dealer__Store_Location__c,
            dealer__Store_Location__r.Name,
            dealer__Store_Location__r.dealer__County__c,
            dealer__Store_Location__r.dealer__State__c,
            dealer__Store_Location__r.dealer__Company_Number__c,
            dealer__Store_Location__r.dealer__Default_Days_to_First_Payment__c,
            dealer__Store_Location__r.dealer__Default_Rate__c,
            dealer__Store_Location__r.dealer__Default_Term__c,
            dealer__Store_Location__r.dealer__Tax_Delivery_Address__c,
            dealer__Store_Location__r.dealer__Postal_Code__c,
            dealer__Store_Location__r.dealer__Tax_Trade__c,
            dealer__Store_Location__r.dealer__Tax_Trade_In_Used__c,
            dealer__Store_Location__r.dealer__Max_Trade_Tax_Amount__c	,
            dealer__Store_Location__r.dealer__Tax_Service_Contracts__c,
            dealer__Store_Location__r.dealer__Internal_Labor_Rate__c,
            dealer__Store_Location__r.dealer__Deal_Default_Labor_Rate__c,
            dealer__Auto_Insurance_Zip__c,
            dealer__Auto_Insurance_Company__c,
            dealer__Auto_Insurance_Agent__c,
            dealer__Auto_Insurance_Policy__c,
            dealer__Auto_Insurance_Effective_Date__c,
            dealer__Auto_Insurance_Expiration_Date__c,
            dealer__Auto_Insurance_COM_Deducatable__c,
            dealer__Auto_Insurance_COL_Deductable__c,
            dealer__Auto_Insurance_Address__c,
            dealer__Auto_Insurance_City__c,
            dealer__Auto_Insurance_State__c,
            dealer__Auto_Insurance_Contact__c,
            dealer__Auto_Insurance_Phone__c,
            dealer__Co_Buyer_Work_Phone__c,
            dealer__Salesperson_1__r.Name,
            dealer__Salesperson_2__r.Name,
            dealer__Service_Manager__r.Name,
            dealer__Delivery_City__c,
            dealer__Delivery_Phone__c,
            dealer__Delivery_State__c,
            dealer__Delivery_Postal_Code__c,
            dealer__Delivery_Mobile__c,
            dealer__Delivery_County__c,
            dealer__Delivery_Notes__c,
            dealer__Delivery_Email__c,
            dealer__Delivery_Street__c,
            dealer__Vehicle_Conversion_Gross__c,
            dealer__Vehicle_Gross__c,
            dealer__Vehicle_Cost__c,
            dealer__ConversionCost__c,
            dealer__Conversion_Discount__c,
            dealer__Vehicle_Discount__c,
            dealer__Deferred_1_Payee__c,
            dealer__Deferred_1_Payee__r.Name,
            dealer__Deferred_1_Payee__r.Id,
            dealer__Deferred_2_Payee__c,
            dealer__Deferred_2_Payee__r.Name,
            dealer__Deferred_2_Payee__r.Id,
            dealer__Deferred_3_Payee__c,
            dealer__Deferred_3_Payee__r.Name,
            dealer__Deferred_3_Payee__r.Id,
            dealer__Deferred_Date_1__c,
            dealer__Deferred_Date_2__c,
            dealer__Deferred_Date_3__c,
            dealer__Deferred_Down_1__c,
            dealer__Deferred_Down_2__c,
            dealer__Deferred_Down_3__c,
            dealer__Deferred_Note_1__c,
            dealer__Deferred_Note_2__c,
            dealer__Deferred_Note_3__c,
            dealer__GVWR__c,
            dealer__Doc_Fee__c,
            dealer__License_Fee__c,
            dealer__Registration_Title_Fee__c,
            dealer__Electronic_Filing_Fee__c,
            dealer__Tire_Fee__c,
            dealer__Smog_Cert__c,
            dealer__Posting_Template__c,
            /* Deferred Monies */
            dealer__Deposit__c,
            dealer__Down_Pymt__c,
            dealer__First_Payment_Date__c,
            dealer__Total_Additional_Equipment__c,
            dealer__Total_Service_Contracts_Premium__c,
            dealer__Buyer_First_Name__c,
            dealer__Buyer_Last_Name__c,
            dealer__Co_Buyer_First_Name__c,
            dealer__Co_Buyer_Last_Name__c,
            dealer__Sales_Tax__c,
            dealer__Equipment_Tax__c,
            dealer__Standard_Tax__c,
            dealer__Total_Tax__c,
            dealer__Tax_Zone__c,
            dealer__Tax_Zone__r.dealer__Rate__c,
            dealer__Tax_Zone__r.dealer__Postal_Code__c,
            dealer__Tax_Zone__r.dealer__Common_Name__c,
            dealer__Tax_Rate__c,
            dealer__isVehicleTax__c,
            dealer__isConvertionTax__c,
            dealer__Deal_Type__c,
            dealer__Rebate__c,
            dealer__Pickup_or_Delivery__c,
            dealer__Conversion_Gross_Percent__c,
            dealer__GAP_Gross_Percent__c,
            dealer__GAP_Gross__c,
            dealer__GAP_Cost__c,
            dealer__Maintenance_Gross_Percent__c,
            dealer__Maintenance_Cost__c,
            dealer__Maintenance_Gross__c,
            dealer__Other_Cost__c,
            dealer__Other_Gross__c,
            dealer__Other_Gross_Percent__c,
            dealer__Svc_Contracts_Gross_Percent__c,
            dealer__Vehicle_Gross_Percent__c,
            dealer__Warranty_Cost__c,
            dealer__Ext_Warr_Gross__c,
            dealer__Warranty_Gross_Percent__c,
            dealer__Total_Service_Contracts_Gross__c,
            dealer__Total_Service_Contracts_Cost__c,
            dealer__Total_Gross_Percent__c,
            dealer__Total_Deferred_Down__c,
            dealer__Total_Additional_Equipment_Cost__c,
            dealer__Total_Additional_Equipment_Gross__c,                               
            dealer__Total_Taxable_Equipment__c,
            dealer__Standard_Taxable__c,                              
            dealer__Trade_Net__c,
            dealer__Due_Upon_Delivery__c,
           	dealer__Total_Additional_Equipment_Gross_Percent__c,
			dealer__Out_the_Door__c,
            dealer__PricingStrategy__c,
            dealer__PricingStrategy__r.Name,
            dealer__PricingStrategy__r.dealer__Method__c
            FROM dealer__Deal__c WHERE id =: currentId
        ];

        // If certain defaults are not set, provide the defaults.
        List < dealer__Dealer_Location__c > locations = new List < dealer__Dealer_Location__c > ();
        if (lstDeal[0].dealer__Term__c == null ||
            lstDeal[0].dealer__Days__c == null ||
            lstDeal[0].dealer__Rate__c == null
        ) {
            // Lookup the defaults
            locations = [SELECT Id, dealer__Default_Days_to_First_Payment__c,
                dealer__Default_Rate__c, dealer__Default_Term__c,
                dealer__Default_Deal_Status__c
                FROM dealer__Dealer_Location__c
                WHERE Id =: lstDeal[0].dealer__Store_Location__c
                LIMIT 1
            ];

            // Set the defaults.
            lstDeal[0].dealer__Term__c = locations[0].dealer__Default_Term__c;
            lstDeal[0].dealer__Days__c = locations[0].dealer__Default_Days_to_First_Payment__c;
            lstDeal[0].dealer__Rate__c = locations[0].dealer__Default_Rate__c;

            //Vehicle Retail Price/Di
        }
        lstDeal[0].Vehicle_Price__c = lstDeal[0].Vehicle_Price__c == null ? 0 : lstDeal[0].Vehicle_Price__c;

        return lstDeal;
    }
    
    /**
     * getDealTypeValues 
     * @return String
     * @description 
     */
    public String getDealTypeValues() 
    {

        Schema.DescribeFieldResult fieldResult =
            field_map.get('dealer__Deal_Type__c').getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        //set the picklist values in a list
        List < Schema.PicklistEntry > options = new List < Schema.PicklistEntry > ();
        for (Schema.PicklistEntry f: ple) {
            if(f.getValue() == 'Equipment Only' || f.getValue() == 'Chassis / Conversion')
                options.add(f);
        }
        return JSON.serializePretty(options);
    }
    
    /**
     * getDealStatusValues 
     * @return String
     * @description
     */ 
    public String getDealStatusValues() 
    {

        System.debug('****deal Status');
        Schema.DescribeFieldResult fieldResult =
            field_map.get('dealer__Status__c').getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        //set the picklist values in a list
        List < Schema.PicklistEntry > options = new List < Schema.PicklistEntry > ();
        for (Schema.PicklistEntry f: ple) {
            options.add(f);
        }
        system.debug(JSON.serializePretty(options));
        return JSON.serializePretty(options);
    }

    /**
     * getTradeIns 
     * @return string
     * @description
     */
    public string getTradeIns() 
    {
        List < dealer__Trade_In__c > listTradeIn = new List < dealer__Trade_In__c > ();

        listTradeIn = [Select Id, dealer__ACV__c, Name, dealer__Pay_Off_Amount__c, dealer__Appraisal_Vehicle__c, dealer__Trim_Level__c,
            dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__VIN__c, dealer__Lost_Trade__c, dealer__Net__c, dealer__Recon__c,
            dealer__Odometer_at_Trade_In__c, dealer__Appraisal_Vehicle__r.dealer__Appraisal__c,dealer__Appraisal_Vehicle__r.dealer__Appraisal__r.Name, dealer__Appraisal_Vehicle__r.Name, dealer__Pay_Off_Account__c,
            dealer__Trade_Allowance__c, dealer__Pay_Off_Account__r.Name, dealer__Pay_Off_Account_Number__c, dealer__Pay_Off_Expiration_Date__c from dealer__Trade_In__c where dealer__Car_Deal__c =: currentId
        ];

        return JSON.serialize(listTradeIn);
    }

    /**
     * updateTradeIn 
     * @return String
     * @description Update Trade In
     */
    public String updateTradeIn() 
    {

        // Instantiate the TradeIn
        dealer__Trade_In__c tradeIn = new dealer__Trade_In__c();
        tradeIn.Id = (Id) urlParams.get('Id');
        tradeIn.dealer__Year__c = (String) urlParams.get('dealer__Year__c');
        tradeIn.dealer__Make__c = (String) urlParams.get('dealer__Make__c');
        tradeIn.dealer__Model__c = (String) urlParams.get('dealer__Model__c');
        tradeIn.dealer__VIN__c = (String) urlParams.get('dealer__VIN__c');
        tradeIn.dealer__Trim_Level__c = (String) urlParams.get('dealer__Trim_Level__c');

        // Decimal related values
        tradeIn.dealer__Odometer_at_Trade_In__c = (urlParams.get('dealer__Odometer_at_Trade_In__c') == null || urlParams.get('dealer__Odometer_at_Trade_In__c') == '') ? 0 : Decimal.valueOf(urlParams.get('dealer__Odometer_at_Trade_In__c'));
        tradeIn.dealer__Trade_Allowance__c = (urlParams.get('dealer__Trade_Allowance__c') == null || urlParams.get('dealer__Trade_Allowance__c') == '') ? 0 : Decimal.valueOf(urlParams.get('dealer__Trade_Allowance__c'));
        tradeIn.dealer__Pay_Off_Amount__c = (urlParams.get('dealer__Pay_Off_Amount__c') == null || urlParams.get('dealer__Pay_Off_Amount__c') == '') ? 0 : Decimal.valueOf(urlParams.get('dealer__Pay_Off_Amount__c'));
        tradeIn.dealer__ACV__c = (urlParams.get('dealer__ACV__c') == null || urlParams.get('dealer__ACV__c') == '') ? 0 : Decimal.valueOf(urlParams.get('dealer__ACV__c'));
        tradeIn.dealer__Net__c = tradeIn.dealer__Trade_Allowance__c - tradeIn.dealer__Pay_Off_Amount__c;
        try {
            update tradeIn;
            return '[]';
        } catch (DmlException e) {
            System.debug('');
            return '{"error":"trade in ' + tradeIn + ' ' + e.getMessage() + '"}';
        }
    }

    /**
     * updateDeal 
     * @return String
     * @description
     */
    public String updateDeal() 
    {

        // Insert Settings if no settings exist for this user
        DealTRSController.insertUserSettings(UserInfo.getUserId());

        // Required Deal ID
        if (currentId == null) {
            return '{"error":"A proper Deal Id was not submitted with the read request."}';
        }

        // List of Deal Records and related Deal Object for Update
        List < dealer__Deal__c > lstDeal = getDealRecord();
        Deal__c dealBefore;
        dealer__Deal__c objDeal = new dealer__Deal__c();
        if (lstDeal != null && lstDeal.size() > 0) {
            objDeal = lstDeal[0];
            dealBefore = lstDeal[0];
        }

        // Check Required Field, and set defaults
        if (objDeal.dealer__Deal_Date__c == null)
            objDeal.dealer__Deal_Date__c = Date.today();

        if (objDeal.dealer__Salesperson_1__c == null)
            objDeal.dealer__Salesperson_1__c = UserInfo.getUserId();
      

        //Get Deal Object fields
        Map < String, Schema.SObjectType > schemaMap = Schema.getGlobalDescribe();
        Map < String, Schema.SObjectField > fieldMap = schemaMap.get('dealer__Deal__c').getDescribe().fields.getMap();

        //update deal respective field from url param
        for (String param: urlParams.keyset()) {

            //as map keys are case sensitive use lower case for fetching fieldMap keys
            string fieldName = param.toLowerCase();

            //If parameter is a valid field of deal object
            if (fieldMap.keyset().contains(fieldName)) {

                //Describe field to check the type of field
                Schema.DescribeFieldResult fieldResult = fieldMap.get(fieldName).getDescribe();

                //If String / Phone / Email / Picklist / Reference / URL / Date / Datetime
                if ((fieldResult.getType() == Schema.DisplayType.EMAIL || fieldResult.getType() == Schema.DisplayType.PHONE ||
                        fieldResult.getType() == Schema.DisplayType.REFERENCE ||
                        fieldResult.getType() == Schema.DisplayType.TEXTAREA || fieldResult.getType() == Schema.DisplayType.STRING ||
                        fieldResult.getType() == Schema.DisplayType.PICKLIST || fieldResult.getType() == Schema.DisplayType.ENCRYPTEDSTRING ||
                        fieldResult.getType() == Schema.DisplayType.MULTIPICKLIST || fieldResult.getType() == Schema.DisplayType.URL) &&
                    !fieldResult.isCalculated() // to make sure its not a formula field
                ) {
                    objDeal.put(fieldName, String.valueOf(urlParams.get(param)));
                }
                //Boolean
                else if (fieldResult.getType() == Schema.DisplayType.Boolean && !fieldResult.isCalculated()) {
                    objDeal.put(fieldName,
                        (urlParams.get(param) == '') ? null : Boolean.valueOf(urlParams.get(param))
                    );
                }
                //Integer / Double /percent
                else if ((fieldResult.getType() == Schema.DisplayType.INTEGER || fieldResult.getType() == Schema.DisplayType.DOUBLE ||
                        fieldResult.getType() == Schema.DisplayType.PERCENT ||
                        fieldResult.getType() == Schema.DisplayType.CURRENCY) &&
                    !fieldResult.isCalculated()
                ) {
                    //Check the scale if >0 update with double value
                    if (fieldResult.getScale() > 0) {
                        objDeal.put(fieldName,
                            (urlParams.get(param) == '') ? null : Decimal.valueOf(urlParams.get(param))
                        );
                    }
                    //if 0 then update with Integer value
                    else {
                        objDeal.put(fieldName,
                            (urlParams.get(param) == '') ? null : Integer.valueOf(urlParams.get(param))
                        );
                    }
                }
                //Date / Datetime
                else if ((fieldResult.getType() == Schema.DisplayType.Date || fieldResult.getType() == Schema.DisplayType.Datetime) &&
                    !fieldResult.isCalculated()
                ) {
                    //System.debug('Date - ' + urlParams.get(param) + ',' + param);

                    objDeal.put(fieldName,
                        (urlParams.get(param) == '') ? null : Date.valueOf(urlParams.get(param))
                    );
                    System.debug('----->>>' + objDeal.get(fieldName) + '---');
                }    

            }
        }

        // Check to see if we have Accounts to Update
        if (urlParams.get('isBuyerUpdate') == 'true') {
            updateAccounts();
        }

        if (urlParams.get('isCoBuyerUpdate') == 'true') {
            updateCoBuyerAccount();
        }

        // Get dispositions and set the associated SalesUp disposition.
        List < dealer__SalesDispositions__c > dispositions = dealer__SalesDispositions__c.getall().values();
        Map < String, String > dealStatus = new Map < String, String > ();
        Map < String, String > dealDisposition = new Map < String, String > ();

        for (dealer__SalesDispositions__c obj: dispositions) {
            dealStatus.put(obj.dealer__Deal_Status__c, obj.dealer__SalesUp_Status__c);
            dealDisposition.put(obj.dealer__Deal_Status__c, obj.dealer__Disposition__c);
        }

        // if status is available set the value of the SalesUp based on the deal disposition
        List < dealer__Sales_Up__c > sups = new List < dealer__Sales_Up__c > ();
        if (dealStatus.get(objDeal.dealer__Status__c) != null && objDeal.dealer__Sales_Lead__c != null) {
            sups.add(new dealer__Sales_Up__c(Id = objDeal.dealer__Sales_Lead__c,
                // dealer__Car_Deal__c = objDeal.Id,
                dealer__Disposition__c = dealDisposition.get(objDeal.dealer__Disposition__c),
                dealer__Lead_Status__c = dealStatus.get(objDeal.dealer__Status__c)
            ));
        }

        // Get a SUM of all taxes assocaited and set the rate on the deal.
        Decimal taxRate = 0;
        for (dealer__Deal_Tax__c tx: [SELECT dealer__Tax_Percentage__c FROM dealer__Deal_Tax__c WHERE dealer__Deal__c =: objDeal.Id AND dealer__Tax_Percentage__c != null]) {
            taxRate += math.abs(tx.dealer__Tax_Percentage__c);
        }
        if (taxRate != null)
            objDeal.dealer__Tax_Rate__c = taxRate;

        // Update Equipment with new tax rate
        /* 
        Commented out due to concern with updating taxable parts entries unnecessarily 
        Any tax calcs should be moved to updateAftermarket()
        JVK 10-6-2017
        */

        List < dealer__After_Market__c > afterMarketDiscountItems = new List < dealer__After_Market__c > ();
        List < dealer__After_Market__c > afterMarketTaxUpdate = new List < dealer__After_Market__c > ();
        for (dealer__After_Market__c am: [SELECT Id, Type__c, Discount__c, dealer__Taxable__c, dealer__Parts_Kit__r.dealer__Item_Count__c, dealer__Tax_Rate__c, dealer__Sales_Tax__c, dealer__Part_Unit_Price__c, dealer__Part_Unit_Cost__c,
                dealer__Sale_Price__c, dealer__Misc_Tax_Code__c
                FROM dealer__After_Market__c
                WHERE dealer__Car_Deal__c =: objDeal.Id
            ]) {
            afterMarketDiscountItems.add(am);
            if (am.dealer__Tax_Rate__c != objDeal.dealer__Tax_Rate__c && am.dealer__Sale_Price__c != Null && am.dealer__Misc_Tax_Code__c == null) {

                am.dealer__Tax_Rate__c = objDeal.dealer__Tax_Rate__c;
                am.dealer__Misc_Tax_Code__c = null;

                if (am.dealer__Taxable__c == true) {
                    am.dealer__Sales_Tax__c = ((am.dealer__Tax_Rate__c / 100) * am.dealer__Sale_Price__c);
                }
                afterMarketTaxUpdate.add(am);
            }
        }

        // If Vehicle is set , set the Service Vehicle as well
        if (objDeal.dealer__Vehicle__c != null) {
            dealer__Service_Vehicle__c[] svcVehicle = [SELECT Id FROM dealer__Service_Vehicle__c WHERE dealer__Sales_Inventory__c =: objDeal.dealer__Vehicle__c limit 1];
            if (svcVehicle.size() == 1) {
                objDeal.dealer__Service_Vehicle__c = svcVehicle[0].Id;
            }
        }

        if (objDeal.Vehicle_Price__c == null) objDeal.Vehicle_Price__c = 0;
        if (objDeal.dealer__Vehicle_Discount__c == null) objDeal.dealer__Vehicle_Discount__c = 0;
        
        //Calculate total gross (%)
        Double grossSum = 0;
        if(objDeal.dealer__Vehicle_Gross_Percent__c != null) grossSum += objDeal.dealer__Vehicle_Gross_Percent__c;
        if(objDeal.dealer__Conversion_Gross_Percent__c != null) grossSum += objDeal.dealer__Conversion_Gross_Percent__c;
        if(objDeal.dealer__Warranty_Gross_Percent__c != null) grossSum += objDeal.dealer__Warranty_Gross_Percent__c;
        if(objDeal.dealer__GAP_Gross_Percent__c != null) grossSum += objDeal.dealer__GAP_Gross_Percent__c;
        if(objDeal.dealer__Maintenance_Gross_Percent__c != null) grossSum += objDeal.dealer__Maintenance_Gross_Percent__c;
        if(objDeal.dealer__Other_Gross_Percent__c != null) grossSum += objDeal.dealer__Other_Gross_Percent__c;
        if(objDeal.dealer__Svc_Contracts_Gross_Percent__c != null) grossSum += objDeal.dealer__Svc_Contracts_Gross_Percent__c;
        // if(objDeal.dealer__Vehicle_Gross_Percent__c != null) grossSum += objDeal.dealer__Vehicle_Gross_Percent__c;
        objDeal.dealer__Total_Gross_Percent__c = grossSum;
        
        
        // Perform Aggregate Results based on the Service Contract Sales that are actively against the Deal 
        AggregateResult[] contractResults = [SELECT SUM(dealer__Sale_Price__c) price, SUM(dealer__Gross__c) gross, SUM(dealer__Cost__c) cost
            FROM dealer__Service_Contract__c
            WHERE dealer__Car_Deal__c =: objDeal.Id
            GROUP BY dealer__Type__c
        ];


        // Prevent Nulls
        if (objDeal.dealer__Amt_Financed__c == null) objDeal.dealer__Amt_Financed__c = 0;
       
        if(objDeal.Buyer__c != null){
            Tax_Zones__c buyerTaxZone = TaxAPI.getAccountTaxZone(objDeal.Buyer__c);
            if(buyerTaxZone.Id != null){
                objDeal.Tax_Zone__c = buyerTaxZone.Id;
            }
        }

        if(String.valueOf(objDeal.Tax_Zone__c) != '' && objDeal.Tax_Zone__c!=null) {
            try {
                TaxAPI.removeTaxTransactionItems(objDeal);
                TaxAPI.calculateTaxes(objDeal);
                // TaxAPI.applyTaxZone(objDeal, new Tax_Zones__c(Id=objDeal.Tax_Zone__c));
            } Catch(Exception e) {
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}'; 
            }
        } else {
            TaxAPI.removeTaxTransactionItems(objDeal);
        }
        // Obtain updated tax sum and apply to the Deal.
        AggregateResult[] taxsum = [SELECT SUM(Tax__c) totalTax, SUM(Rate__c) totalRate FROM TaxTransactionItem__c WHERE DealTax__c=:objDeal.Id];
        
        objDeal.Standard_Tax__c = (Decimal)taxsum[0].get('totalTax') == null ? 0 : (Decimal)taxsum[0].get('totalTax') ;
        objDeal.Tax_Rate__c = (Decimal)taxsum[0].get('totalRate') == null ? 0 : (Decimal)taxsum[0].get('totalRate');
        objDeal.Total_Tax__c = objDeal.Standard_Tax__c + objDeal.Equipment_Tax__c;
        objDeal.Sales_Tax__c = objDeal.Total_Tax__c;

        objDeal.Total_Tax__c = objDeal.Total_Tax__c.setScale(2, RoundingMode.HALF_UP);
        objDeal.Sales_Tax__c = objDeal.Sales_Tax__c.setScale(2, RoundingMode.HALF_UP);

        
        
        if(objDeal.dealer__Service_Vehicle__c != null && objDeal.Deal_Type__c.contains('Equipment Only')){ //W-003107 - Checking Deal Type prevents this from running erroneously on standard deals
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c();
            sv.Id = objDeal.dealer__Service_Vehicle__c;
            if(objDeal.dealer__Service_Vehicle__r.dealer__Veh_Owner__c == null){
                sv.dealer__Veh_Owner__c = objDeal.dealer__Buyer__c;
                update sv;
            } 
        } 

        try {

            // If we have a SalesUp to Update Execute
            if (sups.size() > 0) {
                update sups;
            }
// 
            update afterMarketTaxUpdate;
            update objDeal;
            dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',objDeal.Id));

            return JSON.serialize(getDealRecord());

        } catch (Exception e) {
            return '{"error":"' + e.getMessage() + '"}';
        }
    }

    /**
     * updateBuyerAccount 
     * @return Boolean
     * @description
     */
    public Boolean updateBuyerAccount() 
    {
        if (urlParams.get('dealer__Buyer__c') != '') {
            Account a = new Account(
                FirstName = urlParams.get('dealer__Buyer_First_Name__c'),
                MiddleName = urlParams.get('dealer__Buyer_Middle_Name__c'),
                LastName = urlParams.get('dealer__Buyer_Last_Name__c')
            );

        }

        return false;
    }

    /**
     * updateCoBuyerAccount 
     * @return Boolean
     * @description
     */
    public Boolean updateCoBuyerAccount() 
    {
        
        system.debug('*** update cobuyer ***');
        
        if (urlParams.get('dealer__Co_Buyer__c') != '' && urlParams.get('dealer__Co_Buyer__c') != null) {
            
            Account objAccount = new Account();
            objAccount.Id = urlParams.get('dealer__Co_Buyer__c');
            
            if (urlParams.get('dealer__Co_Buyer_First_Name__c') != null && urlParams.get('dealer__Co_Buyer_First_Name__c') != '') { 
                objAccount.FirstName = String.valueOf(urlParams.get('dealer__Co_Buyer_First_Name__c'));
            }
            //MiddleName
            if (urlParams.get('dealer__Co_Buyer_Middle_Name__c') != null && urlParams.get('dealer__Co_Buyer_Middle_Name__c') != '') { 
                objAccount.MiddleName = String.valueOf(urlParams.get('dealer__Co_Buyer_Middle_Name__c'));
            }
            //LastName
            if (urlParams.get('dealer__Co_Buyer_Last_Name__c') != null && urlParams.get('dealer__Co_Buyer_Last_Name__c') != '') { 
                objAccount.LastName = String.valueOf(urlParams.get('dealer__Co_Buyer_Last_Name__c'));
            }
            //Birthdate
            if (urlParams.get('dealer__co_buyer_birth_date__c') != null && urlParams.get('dealer__co_buyer_birth_date__c') != '') { 
                objAccount.PersonBirthdate = Date.valueOf(urlParams.get('dealer__co_buyer_birth_date__c'));
            }
            //Home Phone
            if (urlParams.get('dealer__Co_Buyer_Home_Phone__c') != null && urlParams.get('dealer__Co_Buyer_Home_Phone__c') != '') {
                objAccount.PersonHomePhone = String.valueOf(urlParams.get('dealer__Co_Buyer_Home_Phone__c'));
            } 
            //Work Phone
            if (urlParams.get('dealer__Co_Buyer_Work_Phone__c') != null && urlParams.get('dealer__Co_Buyer_Work_Phone__c') != '') {
                objAccount.Phone = String.valueOf(urlParams.get('dealer__Co_Buyer_Work_Phone__c'));
            } 
            //Address Street
            if (urlParams.get('dealer__Co_Buyer_Address__c') != null && urlParams.get('dealer__Co_Buyer_Address__c') != '') { 
                objAccount.PersonMailingStreet = objAccount.BillingStreet = String.valueOf(urlParams.get('dealer__Co_Buyer_Address__c'));
            }
            //Address City
            if (urlParams.get('dealer__Co_Buyer_City__c') != null && urlParams.get('dealer__Co_Buyer_City__c') != '') { 
                objAccount.PersonMailingCity = objAccount.BillingCity = String.valueOf(urlParams.get('dealer__Co_Buyer_City__c'));
            }
            //Address State
            if (urlParams.get('dealer__Co_Buyer_State__c') != null && urlParams.get('dealer__Co_Buyer_State__c') != '') { 
                objAccount.PersonMailingState = objAccount.BillingState = String.valueOf(urlParams.get('dealer__Co_Buyer_State__c'));
            }
            //Address Postal Code
            if (urlParams.get('dealer__Co_Buyer_Postal_Code__c') != null && urlParams.get('dealer__Co_Buyer_Postal_Code__c') != '') { 
                objAccount.PersonMailingPostalCode = objAccount.BillingPostalCode = String.valueOf(urlParams.get('dealer__Co_Buyer_Postal_Code__c'));
            }
            //Driving License #
            if (urlParams.get('dealer__Co_Buyer_Drivers_License_Number__c') != null && urlParams.get('dealer__Co_Buyer_Drivers_License_Number__c') != '') { 
                objAccount.dealer__Drivers_License_Number__pc = String.valueOf(urlParams.get('dealer__Co_Buyer_Drivers_License_Number__c'));
            }
            //Driving License State
            if (urlParams.get('dealer__Co_Buyer_Drivers_Lic_State__c') != null && urlParams.get('dealer__Co_Buyer_Drivers_Lic_State__c') != '') { 
                objAccount.dealer__Drivers_License_State__pc = String.valueOf(urlParams.get('dealer__Co_Buyer_Drivers_Lic_State__c'));
            } 
            //Driving License Exp. Date
            if (urlParams.get('dealer__Co_Buyer_Drivers_License_Exp_Date__c') != null && urlParams.get('dealer__Co_Buyer_Drivers_License_Exp_Date__c') != '') { 
                objAccount.dealer__Drivers_License_Expiration_Date__pc = Date.valueOf(urlParams.get('dealer__Co_Buyer_Drivers_License_Exp_Date__c'));
            } 
           
            //County
          /*  if (urlParams.get('dealer__Co_Buyer_County__c') != null && urlParams.get('dealer__Co_Buyer_County__c') != '') { 
                objAccount.dealer__County__c = String.valueOf(urlParams.get('dealer__Co_Buyer_County__c'));
            }*/
                
			system.debug('**** co-buyer ' + objAccount);
            

            try {
                if (objAccount.Id == null) {
                	insert objAccount;
                } else {
                    update objAccount;
                }
                return true;
            }
            Catch(DmlException e) {
                throw new DealTRSControllerException(e.getDMLMessage(0));
            }

        }

        return false;
    }

    /**
     * createTradeIn 
     * @return String
     * @description Create Trade In record
     */
    public String createTradeIn() 
    {

        try {
            if (currentId == null) {
                return '{"error":"A proper Deal Id was not submitted with the create request."}';
            }
            dealer__Trade_In__c objTradeIn = new dealer__Trade_In__c();
            dealer__Appraisal__c appraisal = new dealer__Appraisal__c();

            if (urlParams.get('dealer__Appraisal_Vehicle__c') != null && urlParams.get('dealer__Appraisal_Vehicle__c') != '') {
                objTradeIn.dealer__Appraisal_Vehicle__c = String.valueOf(urlParams.get('dealer__Appraisal_Vehicle__c'));
            }
            if (urlParams.get('dealer__ACV__c') != null && urlParams.get('dealer__ACV__c') != '') {
                objTradeIn.dealer__ACV__c = Decimal.valueOf(urlParams.get('dealer__ACV__c'));
            }
            if (urlParams.get('dealer__Trade_Allowance__c') != null && urlParams.get('dealer__Trade_Allowance__c') != '') {
                objTradeIn.dealer__Trade_Allowance__c = Decimal.valueOf(urlParams.get('dealer__Trade_Allowance__c'));
            }
            if (urlParams.get('dealer__Recon__c') != null && urlParams.get('dealer__Recon__c') != '') {
                objTradeIn.dealer__Recon__c = Decimal.valueOf(urlParams.get('dealer__Recon__c'));
            }
            if (urlParams.get('dealer__Pay_Off_Amount__c') != null && urlParams.get('dealer__Pay_Off_Amount__c') != '') {
                objTradeIn.dealer__Pay_Off_Amount__c = Decimal.valueOf(urlParams.get('dealer__Pay_Off_Amount__c'));
            }
            if (urlParams.get('dealer__Profit__c') != null && urlParams.get('dealer__Profit__c') != '') {
                objTradeIn.dealer__Profit__c = Decimal.valueOf(urlParams.get('dealer__Profit__c'));
            }
            if (urlParams.get('dealer__Net__c') != null && urlParams.get('dealer__Net__c') != '') {
                objTradeIn.dealer__Net__c = Decimal.valueOf(urlParams.get('dealer__Net__c'));
            }
            if (urlParams.get('Name') != null && urlParams.get('Name') != '') {
                objTradeIn.Name = String.valueOf(urlParams.get('Name'));
            }
            if (urlParams.get('dealer__Car_Deal__c') != null && urlParams.get('dealer__Car_Deal__c') != '') {
                objTradeIn.dealer__Car_Deal__c = String.valueOf(urlParams.get('dealer__Car_Deal__c'));
            }
            if (urlParams.get('dealer__Year__c') != null && urlParams.get('dealer__Year__c') != '') {
                objTradeIn.dealer__Year__c = String.valueOf(urlParams.get('dealer__Year__c'));
            }
            if (urlParams.get('dealer__Make__c') != null && urlParams.get('dealer__Make__c') != '') {
                objTradeIn.dealer__Make__c = String.valueOf(urlParams.get('dealer__Make__c'));
            }
            if (urlParams.get('dealer__Model__c') != null && urlParams.get('dealer__Model__c') != '') {
                objTradeIn.dealer__Model__c = String.valueOf(urlParams.get('dealer__Model__c'));
            }
            if (urlParams.get('dealer__Trim_Level__c') != null && urlParams.get('dealer__Trim_Level__c') != '') {
                objTradeIn.dealer__Trim_Level__c = String.valueOf(urlParams.get('dealer__Trim_Level__c'));
            }
            if (urlParams.get('dealer__VIN__c') != null && urlParams.get('dealer__VIN__c') != '') {
                objTradeIn.dealer__VIN__c = String.valueOf(urlParams.get('dealer__VIN__c'));
            }
            if (urlParams.get('dealer__Odometer_at_Trade_In__c') != null && urlParams.get('dealer__Odometer_at_Trade_In__c') != '') {
                objTradeIn.dealer__Odometer_at_Trade_In__c = Decimal.valueOf(urlParams.get('dealer__Odometer_at_Trade_In__c'));
            }
            //Display Error if the trade in vehicle exists on the trade already.
            List < dealer__Trade_In__c > existingTradeList = new List < dealer__Trade_In__c > ();
            existingTradeList = [SELECT Id, dealer__Car_Deal__c, dealer__Vin__c FROM dealer__Trade_In__c WHERE dealer__Car_Deal__c =: currentId AND dealer__Vin__c =: objTradeIn.dealer__VIN__c];
            if (existingTradeList.size() > 0) {
                return '{"error":"This trade in vehicle already exists on this deal. Please choose another vehicle"}';
            }
            objTradeIn.dealer__Car_Deal__c = currentId;
            insert objTradeIn;
            if (urlParams.get('dealer__Appraisal__c') != null && urlParams.get('dealer__Appraisal__c') != '') {

                appraisal.Id = String.valueOf(urlParams.get('dealer__Appraisal__c'));
                appraisal.dealer__Trade_In__c = objTradeIn.Id;
                appraisal.dealer__Deal__c = String.valueOf(urlParams.get('dealer__Car_Deal__c'));
                update appraisal;

                // Obtain who appraised the trade, the service vehicle
                appraisal = [SELECT Id, Name, Service_Vehicle__c, Appraisal_Date__c, Appraised_By__c FROM Appraisal__c WHERE Id=:appraisal.Id LIMIT 1];

                objTradeIn.Appraisal_Date__c    = appraisal.Appraisal_Date__c;
                objTradeIn.Appraised_By__c      = appraisal.Appraised_By__c;
                objTradeIn.Service_Vehicle__c   = appraisal.Service_Vehicle__c;

                update objTradeIn;

            } else {
                    try{
                        dealer__Appraisal__c newAppraisal = createAppraisalFromTrade(objTradeIn);
                        dealer__Appraisal_Vehicle__c newAppraisalVehicle = createAppraisalVehicle(newAppraisal.Id,objTradeIn);
                        objTradeIn.dealer__Appraisal_Vehicle__c = newAppraisalVehicle.Id;
                        update objTradeIn;
                    } catch (Exception e){
                        return '{"error":"' + e.getMessage() + '"}';
                    }
            }
            //so we get the related apraisal.
            List < dealer__Trade_In__c > lstTrade = [Select Id, dealer__ACV__c, Name, dealer__Pay_Off_Amount__c, dealer__Appraisal_Vehicle__c, dealer__Trim_Level__c,
            dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__VIN__c, dealer__Lost_Trade__c, dealer__Net__c, dealer__Recon__c,
            dealer__Odometer_at_Trade_In__c, dealer__Appraisal_Vehicle__r.dealer__Appraisal__c,dealer__Appraisal_Vehicle__r.dealer__Appraisal__r.Name, dealer__Appraisal_Vehicle__r.Name, dealer__Pay_Off_Account__c,
            dealer__Trade_Allowance__c, dealer__Pay_Off_Account__r.Name, dealer__Pay_Off_Account_Number__c, dealer__Pay_Off_Expiration_Date__c from dealer__Trade_In__c where id =: objTradeIn.id
            ];
            return JSON.serialize(lstTrade);
        } catch (DmlException e) {
            return '{"error":"t2' + e.getMessage() + '"}';
        }
    }

    /**
     * createAppraisalFromTrade 
     * @param  trade 
     * @return dealer__Appraisal__c
     * @description
     */
    public dealer__Appraisal__c createAppraisalFromTrade(dealer__Trade_In__c trade)
    {
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        appraisal.dealer__Trade_In__c = trade.Id;
        appraisal.dealer__Deal__c = String.valueOf(urlParams.get('dealer__Car_Deal__c'));
        insert appraisal;
        return appraisal;
    }
    
    /**
     * createAppraisalVehicle 
     * @param  appraisalId 
     * @param  trade    
     * @return dealer__Appraisal_Vehicle__c
     */
    public dealer__Appraisal_Vehicle__c createAppraisalVehicle(Id appraisalId, dealer__Trade_In__c trade)
    {
        dealer__Deal__c deal = [SELECT Id, dealer__Sales_Lead__c FROM dealer__Deal__c WHERE Id =: currentId LIMIT 1];
        dealer__Appraisal_Vehicle__C av = new dealer__Appraisal_Vehicle__c();
        av.dealer__Appraisal__c=appraisalId;
        av.dealer__Make__c=trade.dealer__Make__c;
        av.dealer__Model__c=trade.dealer__Model__c; 
        av.dealer__New_Used_Other__c='Used'; 
        av.dealer__Sales_Up__c=deal.dealer__Sales_Lead__c; 
        av.dealer__Trim_Level__c=trade.dealer__Trim_Level__c; 
        av.dealer__VIN__c=trade.dealer__VIN__c; 
        av.dealer__Year__c=trade.dealer__Year__c;
        insert av;
        return av;
    }

    /**
     * getPartKitSoql 
     * @return String
     * @description
     */
    public String getPartKitSoql() 
    {

        String filters = getFilters();

        String querySoql = 'SELECT Id, Name, dealer__Description__c, dealer__Kit_Hours__c,' +
            'dealer__Kit_List__c, dealer__Kit_Cost__c, dealer__Kit_Notes__c, '+
            'dealer__labor_Sale__c,dealer__Labor_Hourly_Cost__c,dealer__Labor_Hourly_Sale__c, '+
            'dealer__Labor_Cost__c, dealer__Total_Cost__c,dealer__Category__c,dealer__Item_Count__c,' +
            'dealer__MFG__c, dealer__Sub_Category__c, dealer__Sub_Category__r.Name,' +
            'dealer__Category__r.Name, dealer__Matrix_Parts_Pricing__c, ' + 
            'dealer__MFG__r.Name, dealer__Kit_Price__c,dealer__Product_Tax_Code__c ' +
            'FROM dealer__Parts_Kit__c ' +
            'WHERE Id!=null AND dealer__Sell_on_Deals__c != False  '; 
        String querySosl = '';
        String keyWord = searchQuery;
        List < List < SObject >> searchList;

        if (searchQuery != '') {

            querySosl = 'FIND :keyWord IN ALL FIELDS RETURNING dealer__Parts_Kit__c (Id where Id!=null ' + filters + ')';
            searchList = search.query(querySosl);

            if (searchList[0] != null && searchList[0].size() > 0) {
                querySoql += ' and id in(' + getRecordIds(searchList[0]) + ')';
            }

        } else {
            querySoql += filters;
        }

        querySoql += ' ORDER BY Name ASC';

        return querySoql;
    }

    /**
     * getPartKits 
     * @return String
     * @description
     */
    public String getPartKits() 
    {

        pageSize = (urlParams.get('pageSize') != null) ? Integer.valueOf(urlParams.get('pageSize')) : 20;
        pageNumber = (urlParams.get('page') != null) ? Integer.valueOf(urlParams.get('page')) : 1;
        String querySoql = getPartKitSoql();

        List < dealer__Parts_Kit__c > partKits = Database.query(querySoql + ' limit :pageSize'); //(List<dealer__Parts_Kit__c>)setCon.getRecords();

        // Apply Matrix Price
        List<dealer__PriceMatrix__mdt> matrix = [SELECT Id, dealer__HighCost__c, dealer__LowCost__c, dealer__Multiplier__c, dealer__PaymentMethod__c, dealer__Location_Object__c, dealer__Location_Name__c FROM dealer__PriceMatrix__mdt WHERE dealer__PaymentMethod__c = 'I'];
        for (dealer__Parts_Kit__c pk: partKits) {
            for(dealer__PriceMatrix__mdt mtx : matrix) { 
                // pk.dealer__Kit_Cost__c
                if(pk.dealer__Kit_Cost__c >= mtx.dealer__LowCost__c && pk.dealer__Kit_Cost__c <= mtx.dealer__HighCost__c) {
                    pk.Matrix_Parts_Pricing__c = (pk.dealer__Kit_Cost__c * (mtx.dealer__Multiplier__c / 100)) + pk.dealer__Kit_Cost__c;
                }                    
            }
        }               

        if (partKits != null && !partKits.isEmpty()) {
            return JSON.serialize(partKits);
        }
        return '[]';
    }

    /**
     * getPartKitCount 
     * @return String
     * @description
     */
    public String getPartKitCount() 
    {
        String soql = 'select count(id) from dealer__Parts_Kit__c';
        AggregateResult res = Database.Query(soql);
        Integer count = integer.valueof(res.get('expr0'));
        return '{"total":"' + count + '"}';
    }

    /**
     * getcashierOptions 
     * @return String
     * @description
     */ 
    public String getcashierOptions() 
    {
        List < dealer__Payment_Methods__c > payment_options = new List < dealer__Payment_Methods__c > ();
        for (String s: dealer__Payment_Methods__c.getAll().keySet()) {
            payment_options.add(dealer__Payment_Methods__c.getInstance(s));
        }
        return JSON.serialize(payment_options);
    }

    /**
     * createCashierEntry 
     * @return String
     * @description
     */
    public String createCashierEntry() 
    {

        // Pre-Flight
        String paymentMethod = ApexPages.currentPage().getParameters().get('dealer__Payment_Method__c');
        Decimal amount = Decimal.valueOf(ApexPages.currentPage().getParameters().get('dealer__Amount__c'));
        Id dealId = (Id) ApexPages.currentPage().getParameters().get('dealId');
        String authCode = (String) ApexPages.currentPage().getParameters().get('dealer__Credit_Card_Authorization_Code__c');
        Id customerId;
        if(ApexPages.currentPage().getParameters().get('dealer__Customer__c[Id]') != null && ApexPages.currentPage().getParameters().get('dealer__Customer__c[Id]') != '' ) {
            customerId = (Id) ApexPages.currentPage().getParameters().get('dealer__Customer__c[Id]');
        }else if(ApexPages.currentPage().getParameters().get('dealer__Customer__c') != null && ApexPages.currentPage().getParameters().get('dealer__Customer__c') != '' ) {
        	customerId = ApexPages.currentPage().getParameters().get('dealer__Customer__c');
        }
        Boolean isDeposit = (ApexPages.currentPage().getParameters().get('dealer__Deposit__c')!=null) ? Boolean.valueOf(ApexPages.currentPage().getParameters().get('dealer__Deposit__c')) : false;

        // Get the Location from the Deal
        System.assert(paymentMethod != null && paymentMethod != '', 'Payment method required to create Cashiering Entry');
        System.assert(dealId != null, 'Deal Id required to create a Cashiering Entry');
        System.assert(customerId != null, 'Customer Id required to create Cashiering Entry');
        System.assert(amount != null, 'Amount required to create a Cashiering Entry');

        dealer__Deal__c location = new dealer__Deal__c();
        try {

            location = [SELECT dealer__Store_Location__c FROM dealer__Deal__c WHERE Id =: dealId];
            System.assert(location.dealer__Store_Location__c != null, 'Location does not appear to valid on this deal');

        }
        Catch(QueryException e) {
            throw new DealTRSControllerException('Error, unable to obtain Location from the Deal Record, ' + e.getMessage());
        }

        // insert a new cashier record
        dealer__Cashering__c cashRecord = new dealer__Cashering__c(
            dealer__Amount__c = amount,
            dealer__Credit_Card_Authorization_Code__c = authCode,
            dealer__MobilityDeal__c = dealId,
            dealer__Deal__c = dealId,
            dealer__Location__c = location.dealer__Store_Location__c,
            dealer__Payment_Method__c = paymentMethod,
            dealer__Customer__c = customerId,
            dealer__Deposit__c = isDeposit
        );

        try {
            insert cashRecord;
            casheirRecordId = cashRecord.Id;
            // Hook to Posting Engine if necessary
            String accountingPayload = '{"recordId" : "' + cashRecord.Id + '", "orgId" : "' + UserInfo.getOrganizationId() + '", "requestedBy" : "' + UserInfo.getUserId() + '", "action" : "cashier_receipt"}';
            dealer.Cashier.emailAsyncHandler(accountingPayload);

        }
        Catch(DmlException e) {
            throw new DealTRSControllerException(e.getMessage());
        }
        Catch(Exception e) {
            throw new DealTRSControllerException(e.getMessage());
        }

        return '';
    }

    /**
     * deleteCashierEntry 
     * @return String
     * @description
     */
    public String deleteCashierEntry() 
    {
        try {
            Id cashEntryId = (Id) ApexPages.currentPage().getParameters().get('Id');
            delete new dealer__Cashering__c(
                Id = cashEntryId
            );
            casheirRecordId = null;
            // Hook to Posting Engine if necessary
            String accountingPayload = '{"recordId" : "' + cashEntryId + '", "orgId" : "' + UserInfo.getOrganizationId() + '", "requestedBy" : "' + UserInfo.getUserId() + '", "action" : "cashier_receipt_delete"}';
            dealer.Cashier.emailAsyncHandler(accountingPayload);

        }
        Catch(DmlException e) {
            throw new DealTRSControllerException(e.getMessage());
        }
        Catch(Exception e) {
            throw new DealTRSControllerException(e.getMessage());
        }

        return getreadCashier();
    }

    /**
     * updateCashierEntry 
     * @return String
     * @description
     */
    public String updateCashierEntry() 
    {
         // Pre-Flight
         Boolean deposit;
         Id recordId = (Id)ApexPages.currentPage().getParameters().get('Id');
         String paymentMethod = ApexPages.currentPage().getParameters().get('dealer__Payment_Method__c');
         Decimal amount = Decimal.valueOf(ApexPages.currentPage().getParameters().get('dealer__Amount__c'));
         Id dealId = (Id)ApexPages.currentPage().getParameters().get('dealId');
         String authCode = (String)ApexPages.currentPage().getParameters().get('dealer__Credit_Card_Authorization_Code__c');
         String depositString =  (String)ApexPages.currentPage().getParameters().get('dealer__Deposit__c');
         deposit = depositString == 'true' ? true : false;
         Id customerId = ( (Id)ApexPages.currentPage().getParameters().get('dealer__Customer__c[Id]') != null ) ? (Id)ApexPages.currentPage().getParameters().get('dealer__Customer__c[Id]') : (Id)ApexPages.currentPage().getParameters().get('dealer__Customer__c') ;
        
         // cashier record
         dealer__Cashering__c cashRecord = new dealer__Cashering__c(
             Id=recordId,
             dealer__Amount__c=amount,
             dealer__Credit_Card_Authorization_Code__c=authCode,
             dealer__MobilityDeal__c=dealId,
             dealer__Deposit__c= deposit,
             dealer__Payment_Method__c=paymentMethod,
             dealer__Customer__c=customerId
         );

         try {
             update cashRecord;
             casheirRecordId = cashRecord.Id;
             String accountingPayload = '{"recordId" : "'+recordId+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "cashier_receipt_update"}';
             dealer.Cashier.emailAsyncHandler(accountingPayload);   
             return JSON.serialize([SELECT dealer__Amount__c, dealer__Credit_Card_Authorization_Code__c, dealer__MobilityDeal__c , dealer__Deposit__c , dealer__Payment_Method__c, dealer__Customer__c , dealer__Customer__r.Name FROM dealer__Cashering__c WHERE Id =: cashRecord.Id ]);          
         } Catch(DmlException e) {
             throw new DealTRSControllerException(e.getMessage());
         } Catch(Exception e) {
             throw new DealTRSControllerException(e.getMessage());
         }
    }

    /**
     * getreadCashier
     * @return String
     * @description
     */
    public String getreadCashier() 
    {
        System.assert(currentId != null, 'Current ID must be set');
        List < dealer__Cashering__c > cashEntries = [SELECT Id, Name, dealer__Deposit__c, dealer__Credit_Card_Authorization_Code__c,
            dealer__Amount__c, dealer__Payment_Method__c,
            dealer__MobilityDeal__c, dealer__Customer__c, dealer__Customer__r.Name
            FROM dealer__Cashering__c
            WHERE dealer__MobilityDeal__c =: currentId
            ORDER BY CreatedDate ASC
        ];
        return JSON.serialize(cashEntries);
    }
 
    /**
     * getreadCashierRow 
     * @return String
     * @description
     */
    public String getreadCashierRow() 
    {
        if (casheirRecordId == null) {
            return '[]';
        }
        List < dealer__Cashering__c > cashEntries = [SELECT Id, Name, dealer__Credit_Card_Authorization_Code__c,
            dealer__Amount__c, dealer__Deposit__c, dealer__Payment_Method__c,
            dealer__MobilityDeal__c, dealer__Customer__c, dealer__Customer__r.Name
            FROM dealer__Cashering__c
            WHERE Id =: casheirRecordId
            ORDER BY CreatedDate ASC
        ];
        return JSON.serialize(cashEntries);
    }

    /**********
     *
     * After Market Items - Parts and Sublet
     *
     */


    /**
     * upsertAfterMarket 
     * @return String
     * @description Create After Market record
     */
    public String upsertAfterMarket() 
    {
        try {
            if (currentId == null)
                return '{"error":"A proper Deal Id was not submitted with the create request."}';

            // create_afterMarket
            String models = urlParams.get('models');
            String locId = urlParams.get('locId');
            System.assert(locId != null, 'Location Id must be present to create After Market enties.');

            Decimal standardTaxRate;
            standardTaxRate = 0;

            // Get Location Defaults
            dealer__Dealer_Location__c location = [SELECT Id, Name, dealer__Tax_Misc__c, dealer__Tax_Local_Rate__c, dealer__Tax_Service__c, dealer__Tax_Parts__c FROM dealer__Dealer_Location__c WHERE Id =: locId LIMIT 1];
            Boolean laborTaxable = location.dealer__Tax_Service__c;
            Boolean partsTaxable = location.dealer__Tax_Parts__c;

            // do we have items coming over from the database?
            if (models != null) {

                // Deserialze directly to aftermarket items
                dealer__After_Market__c[] records = (dealer__After_Market__c[]) JSON.deserialize(models, List < dealer__After_Market__c > .class);

                // Setup my set for tax code lookups
                Set < Id > prodIds = new Set < Id > (); // Store the product tax code Ids
                Map < Id, dealer__Misc_Tax_Codes__c > taxCodes = new Map < Id, dealer__Misc_Tax_Codes__c > ();

                // Single items of Type Parts.
                if (this.action == 'create_afterMarket' && records.size() == 1 && records.get(0).dealer__Type__c == 'Part') {
                    // We need to get the Part record, if one does not exist, create from master.
                    // First isolate the location we are working within.
                    Id partMasterId = (Id) records.get(0).dealer__Part__c;

                    dealer__Parts_Inventory__c[] invExists = [SELECT Id, Name, dealer__Description__c, dealer__Parts_Master__r.dealer__Product_Tax_Code__c
                        FROM dealer__Parts_Inventory__c
                        WHERE dealer__Parts_Master__c =: partMasterId
                        AND dealer__Location__c =: locId
                        LIMIT 1
                    ];
                    records.get(0).dealer__Part__c = null;
                    if (invExists.size() == 0) {
                        List < dealer__Parts_Master__c > masterIds = new List < dealer__Parts_Master__c > ();
                        masterIds.add(new dealer__Parts_Master__c(Id = partMasterId));
                        Map < Id, dealer__Parts_Inventory__c > newPartMap = dealer.PartAPI.createInventoryFromMaster(masterIds, locId);
                        dealer__Parts_Inventory__c newP = newPartMap.get(partMasterId);
                        dealer__Parts_Master__c pm = [SELECT Id, dealer__Product_Tax_Code__c FROM dealer__Parts_Master__c WHERE Id =: partMasterId LIMIT 1];
                        if (pm.dealer__Product_Tax_Code__c != null) {
                            prodIds.add(pm.dealer__Product_Tax_Code__c);
                            records.get(0).dealer__Product_Tax_Code__c = pm.dealer__Product_Tax_Code__c;
                        }
                        records.get(0).dealer__Part__c = newP.Id;
                        // records.get(0).dealer__Description__c = newP.dealer__Description__c;
                    } else {
                        if (invExists[0].dealer__Parts_Master__r.dealer__Product_Tax_Code__c != null) {
                            prodIds.add(invExists[0].dealer__Parts_Master__r.dealer__Product_Tax_Code__c);
                            records.get(0).dealer__Product_Tax_Code__c = invExists[0].dealer__Parts_Master__r.dealer__Product_Tax_Code__c;
                        }
                        records.get(0).dealer__Part__c = invExists[0].Id;
                        // records.get(0).dealer__Description__c = invExists[0].dealer__Description__c;
                    }
                }

                // Single Item in the Parts Kit
                if (this.action == 'create_afterMarket' && records.size() == 1 && records.get(0).dealer__Type__c == 'Part Kit') {
                    // We are dealing with a new Part kit.
                    dealer__After_Market__c singlePK = records.get(0);
                    dealer__Parts_Kit__c partsKit = [SELECT Id, Name, dealer__Total_Cost__c, dealer__Kit_Price__c FROM dealer__Parts_Kit__c WHERE Id =: singlePK.dealer__Parts_Kit__c];
                    List < dealer__Parts_Kit_Item__c > pkis = [SELECT Id, Name, IsDeleted, dealer__Parts_Kit__c, dealer__Quantity__c,
                        dealer__Parts_Kit__r.Name, dealer__Extended_Cost__c,
                        dealer__Parts_Kit__r.dealer__Item_Count__c,
                        dealer__Extended_List__c, dealer__List__c, dealer__Cost__c,
                        dealer__Part_Description__c, dealer__Part_Name__c, dealer__Part__c,
                        dealer__Product_Tax_Code__c, dealer__Parts_Master__c,
                        dealer__Miscellaneous_Charge_Code__c, dealer__Sale_Price__c,
                        dealer__Miscellaneous_Charge_Code__r.Name
                        FROM dealer__Parts_Kit_Item__c
                        WHERE dealer__Parts_Kit__c =: singlePK.dealer__Parts_Kit__c
                        AND IsDeleted = false
                        AND dealer__Parts_Kit__c != null
                    ];

                    // Associate Local Parts Inventory Record with Line Items
                    Set < Id > masterSet = new Set < Id > ();
                    for (dealer__Parts_Kit_Item__c pitem: pkis) {
                        if (!masterSet.contains(pitem.dealer__Parts_Master__c)) {
                            masterSet.add(pitem.dealer__Parts_Master__c);
                        }
                    }
                    Map < Id, dealer__Parts_Inventory__c > partsInv = new Map < Id, dealer__Parts_Inventory__c > ();
                    for (dealer__Parts_Inventory__c pi: [SELECT Id, Name, dealer__Parts_Master__c FROM dealer__Parts_Inventory__c WHERE dealer__Parts_Master__c IN: masterSet and dealer__Location__c =: locId]) {
                        if (partsInv.get(pi.dealer__Parts_Master__c) == null) {
                            partsInv.put(pi.dealer__Parts_Master__c, pi);
                        }
                    }

                    // Identify parts not in set.
                    Set < Id > masterswithoutpart = new Set < Id > ();
                    for (Id ids: masterSet) {
                        if (partsInv.get(ids) == null && !masterswithoutpart.contains(ids)) {
                            masterswithoutpart.add(ids);
                        }
                    }

                    List < dealer__Parts_Inventory__c > newParts = new List < dealer__Parts_Inventory__c > ();
                    for (dealer__Parts_Master__c pm: [SELECT dealer__Applications__c, dealer__Core_Required__c,
                            dealer__Core_Value__c, dealer__Cost__c, dealer__Height__c,
                            dealer__Jobber_Price__c, dealer__Labor_Time__c, dealer__Length__c,
                            dealer__MAP__c, dealer__MFG_Comments__c, dealer__Manufacturer__c,
                            dealer__Pack_QTY__c, dealer__Part_Description__c,
                            dealer__Part_No_Display__c, dealer__Part_No__c,
                            dealer__Price_Tape_Date__c, dealer__Raw_Part_Number__c,
                            dealer__Retail_Price__c, dealer__Return_Code__c, dealer__UPC__c,
                            dealer__Warranty_Price__c, dealer__Weight__c, dealer__Width__c,
                            dealer__Catalog_Image__c, Id, Name
                            FROM dealer__Parts_Master__c
                            WHERE Id IN: masterswithoutpart
                        ]) {

                        dealer__Parts_Inventory__c newP = new dealer__Parts_Inventory__c(
                            dealer__Parts_Master__c = pm.Id,
                            dealer__Location__c = locId,
                            dealer__Part_No__c = pm.dealer__Part_No__c,
                            dealer__Description__c = pm.dealer__Part_Description__c,
                            dealer__MFG__c = pm.dealer__Manufacturer__c,
                            dealer__Cost__c = pm.dealer__Cost__c,
                            dealer__List__c = pm.dealer__Retail_Price__c,
                            dealer__Pack_QTY__c = pm.dealer__Pack_QTY__c
                        );

                        newParts.add(newP);

                    }

                    if (newParts.size() > 0) {

                        try {
                            insert newParts;
                        }
                        Catch(DmlException e) {
                            if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
                                System.debug('Inside the Custom Validation Handler');
                                throw new DealTRSControllerException(e.getDmlMessage(0));
                            } else {
                                System.debug('Exception without FIELD_CUSTOM_VALIDATION_EXCEPTION');
                                throw new DealTRSControllerException(e.getMessage());
                            }
                        }

                        for (dealer__Parts_Inventory__c newPInv: newParts) {
                            if (partsInv.get(newPInv.dealer__Parts_Master__c) == null) {
                                partsInv.put(newPInv.dealer__Parts_Master__c, newPInv);
                            }
                        }
                    }

                    // Must create local store inventory for parts never before sold in each store.


                    if (pkis.size() > 0) {

                        // Clear records to get ready to store the newly created parts.
                        records.clear();

                        // Add header
                        records.add(new dealer__After_Market__c(
                            // Properties from Part Kit Item
                            Name = singlePK.Name,
                            dealer__Parts_Kit__c = singlePK.dealer__Parts_Kit__c,
                            dealer__Description__c = singlePK.dealer__Description__c,
                            // Properties from Parent Part kit
                            dealer__Car_Deal__c = singlePK.dealer__Car_Deal__c,
                            dealer__Printable__c = singlePK.dealer__Printable__c,
                            dealer__Taxable__c = singlePK.dealer__Taxable__c,
                            dealer__Kit_Notes__c = 'Created from Kit',
                            dealer__Part_Cost__c = 0,
                            dealer__Parts_Sale__c = 0,
                            dealer__Part_Unit_Price__c = 0,
                            dealer__Part_Unit_Cost__c = 0,
                            dealer__Cost__c = partsKit.dealer__Total_Cost__c,
                            dealer__List_Price__c = partsKit.dealer__Kit_Price__c,
                            dealer__Type__c = 'Part Kit'
                        ));

                        // Obtain the Parts Matrix
                        List<dealer__PriceMatrix__mdt> matrix = [SELECT Id, dealer__HighCost__c, dealer__LowCost__c, dealer__Multiplier__c, dealer__PaymentMethod__c, dealer__Location_Object__c, dealer__Location_Name__c FROM dealer__PriceMatrix__mdt WHERE dealer__PaymentMethod__c = 'I'];                                               

                        // Iterate all Kit Items
                        for (dealer__Parts_Kit_Item__c pki: pkis) {
                            // Translate this prt kit itme.
                            if (pki.dealer__Parts_Master__c != null) {

                                // 
                                Decimal pkItemCost = pki.dealer__Cost__c;

                                // Process the Matrix and Apply the Parts
                                for(dealer__PriceMatrix__mdt mtx : matrix) {
                                    if(pkItemCost >= mtx.dealer__LowCost__c && pkItemCost <= mtx.dealer__HighCost__c) {
                                        pkItemCost = (pkItemCost * (mtx.dealer__Multiplier__c / 100)) + pkItemCost;
                                    }
                                }

                                records.add(new dealer__After_Market__c(
                                    // Properties from Part Kit Item
                                    Name = pki.dealer__Part_Name__c,
                                    dealer__Part__c = (partsInv.get(pki.dealer__Parts_Master__c) != null) ? partsInv.get(pki.dealer__Parts_Master__c).Id : null,
                                    dealer__Parts_Kit__c = pki.dealer__Parts_Kit__c,
                                    dealer__Description__c = pki.dealer__Part_Description__c,
                                    dealer__Quantity__c = pki.dealer__Quantity__c,
                                    dealer__Product_Tax_Code__c = pki.dealer__Product_Tax_Code__c,
                                    // Properties from Parent Part kit
                                    dealer__Car_Deal__c = singlePK.dealer__Car_Deal__c,
                                    dealer__Printable__c = singlePK.dealer__Printable__c,
                                    dealer__Taxable__c = singlePK.dealer__Taxable__c,
                                    dealer__Kit_Notes__c = 'Created from Kit',
                                    dealer__Part_Cost__c = pkItemCost,
                                    dealer__Parts_Sale__c = pki.dealer__Extended_List__c,
                                    dealer__Sale_Price__c = pki.dealer__Extended_List__c,
                                    dealer__Cost__c = pki.dealer__Extended_Cost__c,
                                    dealer__List_Price__c = pki.dealer__List__c,
                                    dealer__Type__c = 'Part'
                                ));
                            }

                            // Iterate the Misc. Charges
                            if (pki.dealer__Miscellaneous_Charge_Code__c != null) {
                                records.add(new dealer__After_Market__c(
                                    // Properties from Part Kit Item
                                    Name = pki.dealer__Miscellaneous_Charge_Code__r.Name,
                                    dealer__Parts_Kit__c = pki.dealer__Parts_Kit__c,
                                    dealer__Description__c = pki.dealer__Miscellaneous_Charge_Code__r.Name,
                                    dealer__Quantity__c = pki.dealer__Quantity__c,
                                    dealer__Product_Tax_Code__c = pki.dealer__Product_Tax_Code__c,
                                    dealer__Car_Deal__c = singlePK.dealer__Car_Deal__c,
                                    dealer__Printable__c = singlePK.dealer__Printable__c,
                                    dealer__Taxable__c = singlePK.dealer__Taxable__c,
                                    dealer__Kit_Notes__c = 'Created from Kit',
                                    dealer__Part_Cost__c = 0,
                                    dealer__Parts_Sale__c = 0,
                                    dealer__Part_Unit_Price__c = 0,
                                    dealer__Part_Unit_Cost__c = 0,
                                    dealer__Cost__c = pki.dealer__Sale_Price__c,
                                    dealer__List_Price__c = pki.dealer__Sale_Price__c,
                                    dealer__Sale_Price__c = pki.dealer__Sale_Price__c,
                                    dealer__Type__c = 'Misc'
                                ));
                            }
                        }

                        // If there is labor add a labor line, labor is at the header level of the Kit
                        if (singlePK.dealer__Labor_Sale__c != null && singlePK.dealer__Labor_Sale__c > 0) {
                            records.add(new dealer__After_Market__c(
                                // Properties from Part Kit Item
                                Name = 'Labor',
                                dealer__Type__c = 'Labor',
                                dealer__Description__c = 'Kit Labor',
                                dealer__Parts_Kit__c = singlePK.dealer__Parts_Kit__c,
                                dealer__Car_Deal__c = singlePK.dealer__Car_Deal__c,
                                dealer__Printable__c = singlePK.dealer__Printable__c,
                                dealer__Taxable__c = laborTaxable,
                                dealer__Kit_Notes__c = 'Created from Kit',
                                dealer__Labor_Hourly_Cost__c = singlePK.dealer__Labor_Hourly_Cost__c,
                                dealer__Labor_Hourly_Sale__c = singlePK.dealer__Labor_Hourly_Sale__c,
                                dealer__Labor_Sale__c = singlePK.dealer__Labor_Sale__c,
                                dealer__Sale_Price__c = singlePK.dealer__Labor_Sale__c,
                                dealer__Labor_Cost__c = singlePK.dealer__Labor_Cost__c,
                                dealer__Labor_Hours__c = singlePK.dealer__Hours__c,
                                dealer__Quantity__c = 1

                            ));
                        }
                    }
                }

                // Loop over all standard items
                for (dealer__After_Market__c am: records) {
                    // Product tax code to set for future lookup
                    if (!prodIds.contains(am.dealer__Product_Tax_Code__c) && am.dealer__Product_Tax_Code__c != null) {
                        prodIds.add(am.dealer__Product_Tax_Code__c);
                    }
                }

                //  loop through Tax Codes where Product ID and Location ID match the aftermarket item
                for (dealer__Misc_Tax_Codes__c tc: [SELECT Id, Name, dealer__Percent__c, dealer__Product__c, dealer__Location__c, dealer__Taxable__c FROM dealer__Misc_Tax_Codes__c WHERE dealer__Product__c in: prodIds AND dealer__Location__c =: locId]) {
                    taxCodes.put(tc.dealer__Product__c, tc);
                }
                // - Misc Tax Logic - Wont save changes due to trigger
                for (dealer__After_Market__c am: records) {
                    if (!am.dealer__Taxable__c) {
                        am.dealer__Tax_Rate__c = 0;
                    }
                    if (am.dealer__Taxable__c) {
                        if (am.dealer__Type__c == 'Misc') {
                            if (location.dealer__Tax_Misc__c == 'None') {
                                am.dealer__Tax_Rate__c = 0;
                                system.debug('none');
                            }
                            if (location.dealer__Tax_Misc__c == 'All') { //deal tax
                                am.dealer__Tax_Rate__c = location.dealer__Tax_local_Rate__c;
                                system.debug('all');
                            }
                            if (location.dealer__Tax_Misc__c == 'Respect Misc. Charge Code Record') {
                                am.dealer__Tax_Rate__c = am.dealer__MiscChargeCode__r.dealer__PercentageBasedAmount__c;
                            }
                        }
                    }

                    if (taxCodes.get(am.dealer__Product_Tax_Code__c) != null) { // DO we have a special tax rule for this line?
                        System.debug('tax codes ' + taxCodes.get(am.dealer__Product_Tax_Code__c));
                        am.dealer__Misc_Tax_Code__c = taxCodes.get(am.dealer__Product_Tax_Code__c).Id;
                        // Set sales Tax calculation on this item
                        if (am.dealer__Sale_Price__c != null && taxCodes.get(am.dealer__Product_Tax_Code__c).dealer__Percent__c != null && am.dealer__Taxable__c == true) {
                            am.dealer__Sales_Tax__c = (taxCodes.get(am.dealer__Product_Tax_Code__c).dealer__Percent__c / 100) * am.dealer__Sale_Price__c;
                        } else {
                            am.dealer__Sales_Tax__c = 0;
                        }

                        System.debug(am.dealer__Sales_Tax__c);
                        // No special tax rules, so nothing is set.
                    } else {
                        am.dealer__Sales_Tax__c = 0;
                    }
                }

                // DML
                system.debug('records ' + records);

                try {
                    upsert records;
                    dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',currentId));
                }
                Catch(DmlException e) {
                    if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
                        System.debug('Inside the Custom Validation Handler');
                        throw new DealTRSControllerException(e.getDmlMessage(0));
                    } else {
                        System.debug('Exception without FIELD_CUSTOM_VALIDATION_EXCEPTION');
                        throw new DealTRSControllerException(e.getMessage());
                    }
                }

                // Store the transaction items 
                // Perform Tax Calculation of AfterMarket Items on Records
                Deal__c zoneDat = [SELECT Id, Tax_Zone__c FROM Deal__c WHERE Id=:currentId LIMIT 1];
                TaxAPI taxCalc = new TaxAPI();
                List<TaxAPI.afterMarketTaxRegions> taxItems = taxCalc.calculateAfterMarketItemsTax(records, new Tax_Zones__c(Id=zoneDat.Tax_Zone__c));
                List<After_Market__c> appliedTaxAM = new List<After_Market__c>();
                for(TaxAPI.afterMarketTaxRegions amt : taxItems) {

                    if(amt.aftermarketItem.Taxable__c) {
                        amt.aftermarketItem.Tax_Rate__c=amt.combinedRate;
                        amt.aftermarketItem.Sales_Tax__c=amt.tax;
                        appliedTaxAM.add(amt.aftermarketItem);
                    }
                }

                try {
                    upsert appliedTaxAM;
                    taxCalc.applyAfterMarketTaxes(taxItems);
                }
                Catch(DmlException e) {
                    if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
                        System.debug('Inside the Custom Validation Handler');
                        throw new DealTRSControllerException(e.getDmlMessage(0));
                    } else {
                        System.debug('Exception without FIELD_CUSTOM_VALIDATION_EXCEPTION');
                        throw new DealTRSControllerException(e.getMessage());
                    }
                }          

                List < Id > newRecordIds = new List < Id > ();
                for (dealer__After_Market__c am: records) {
                    newRecordIds.add(am.Id);
                }

                // String afterMarketRecords = getAfterMarkets();
                List < dealer__After_Market__c > aftermarketList = [SELECT dealer__ExtPrice__c, dealer__Discount__c, dealer__Car_Deal__r.Name, dealer__Cost__c, dealer__Description__c, Name, dealer__Taxable__c,
                    dealer__Sale_Price__c, dealer__List_Price__c, dealer__Vendor__c, dealer__MFG__c, dealer__MFG__r.Name, dealer__Quantity__c,
                    dealer__Company_Number__c, dealer__Parts_Kit__c, dealer__Parts_Kit__r.dealer__Item_Count__c, dealer__Parts_Kit__r.Name, dealer__Labor_Sale__c, dealer__Labor_Hourly_Sale__c,
                    dealer__Labor_Hourly_Cost__c, dealer__Part_Cost__c, dealer__Type__c, dealer__Part_Unit_Price__c, dealer__Part_Unit_Cost__c,
                    dealer__Parts_Sale__c, Id, dealer__Gross__c, dealer__Parts_Gross__c, dealer__Labor_Gross__c,
                    dealer__Order__c, dealer__Kit_Notes__c, dealer__Printable__c, dealer__Sub_Category__c, dealer__Category__c,
                    dealer__Hours__c, dealer__Labor_Cost__c, dealer__Labor_Hours__c, dealer__Sub_Category__r.Name, dealer__Tax_Rate__c, dealer__Category__r.Name,
                    dealer__Product_Tax_Code__c, dealer__Misc_Tax_Code__c, dealer__Misc_Tax_Code__r.Id, dealer__Misc_Tax_Code__r.Name,
                    dealer__Misc_Tax_Code__r.dealer__Percent__c, dealer__Sales_Tax__c, dealer__Misc_Tax_Code__r.dealer__Taxable__c,
                    /*dealer__miscchargecode_temp__c, dealer__miscchargecode_temp__r.Name,*/
                    dealer__MiscChargeCode__c, dealer__MiscChargeCode__r.Name, dealer__MiscChargeCode__r.dealer__PercentageBasedAmount__c
                    FROM dealer__After_Market__c where dealer__Car_Deal__c =: currentId AND Id in: newRecordIds order by dealer__Order__c
                ];
                system.debug(JSON.serialize(afterMarketList));
                return JSON.serialize(aftermarketList);
            }

            return '{"error":"Bad request"}';

        } catch (Exception e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }

    /**
     * getAfterMarkets 
     * @return String
     * @description
     */
    public String getAfterMarkets() 
    {
        List < dealer__After_Market__c > aftermarketList = [ SELECT dealer__ExtPrice__c, dealer__Discount__c, dealer__Car_Deal__r.Name, dealer__Cost__c,
            dealer__Description__c, Name, dealer__Taxable__c,
            dealer__Sale_Price__c, dealer__List_Price__c, dealer__Vendor__c, dealer__MFG__c, dealer__MFG__r.Name,
            dealer__Quantity__c,
            dealer__Company_Number__c, dealer__Parts_Kit__c, dealer__Parts_Kit__r.dealer__Item_Count__c, dealer__Parts_Kit__r.Name, dealer__Labor_Sale__c,
            dealer__Labor_Hourly_Cost__c, dealer__Labor_Hourly_Sale__c, dealer__Part_Cost__c, dealer__Type__c,
            dealer__Parts_Sale__c, Id, dealer__Gross__c, dealer__Parts_Gross__c, dealer__Labor_Gross__c,
            dealer__Order__c, dealer__Kit_Notes__c, dealer__Printable__c, dealer__Sub_Category__c, dealer__Category__c,
            dealer__Hours__c, dealer__Labor_Cost__c, dealer__Labor_Hours__c, dealer__Sub_Category__r.Name,
            dealer__Category__r.Name, dealer__Tax_Rate__c, dealer__Part_Unit_Price__c, dealer__Part_Unit_Cost__c,
            dealer__Product_Tax_Code__c, dealer__Misc_Tax_Code__c, dealer__Misc_Tax_Code__r.Id,
            dealer__Misc_Tax_Code__r.Name, dealer__Misc_Tax_Code__r.dealer__Percent__c, dealer__Sales_Tax__c,
            dealer__Misc_Tax_Code__r.dealer__Taxable__c,
            /* dealer__miscchargecode_temp__c, dealer__miscchargecode_temp__r.Name */
            dealer__MiscChargeCode__c, dealer__MiscChargeCode__r.Name, dealer__MiscChargeCode__r.dealer__PercentageBasedAmount__c
            FROM dealer__After_Market__c where dealer__Car_Deal__c =: currentId order by dealer__Order__c
        ];
        return JSON.serialize(aftermarketList);
    }

    /**
     * deleteAfterMarket
     * @return String
     * @description Delete After Market
     */
    public String deleteAfterMarket() 
    {
        try {
            /*dealer__After_Market__c objAfterMarket = [select Id from dealer__After_Market__c where id=:Id.valueOf(urlParams.get('Id')) limit 1];
            delete objAfterMarket;
            return '{"success":"true"}';*/
            string dealId = urlParams.get('dealId');
            string models = urlParams.get('models');
            if (models != null) {
                dealer__After_Market__c[] records = (dealer__After_Market__c[]) JSON.deserialize(models, List < dealer__After_Market__c > .class);
                Set < Id > recordToDelete = new Set < Id > ();

                List < dealer__After_Market__c > lstTODel = new List < dealer__After_Market__c > ();
                for (integer i = 0; i < records.size(); i++) {
                    recordToDelete.add(records[i].id);
                }
                lstTODel = [select id from dealer__After_Market__c where id IN: recordToDelete];

                delete lstTODel;
                dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
                //return '{"success":"true"}';
                return getAfterMarkets();
            }
            return '{"error":"Bad request"}';
        } catch (DmlException e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }

    /**
     * deleteTradeIn 
     * @return String
     * @description Delete Trade In
     */
    public String deleteTradeIn() 
    {
        List < Id > tradeIdList = new List < Id > ();
        List < dealer__Trade_In__c > lstTradeIn = new List < dealer__Trade_In__c > ();
        List < dealer__Appraisal__c > lstAppraisals = new List < dealer__Appraisal__c > ();

        for (dealer__Trade_In__c t: [select id from dealer__Trade_In__c where id =: currentId]) {
            tradeIdList.add(t.Id);
            lstTradeIn.add(new dealer__Trade_In__c(
                Id = t.Id
            ));
        }
        for (dealer__Appraisal__c a: [select Id from dealer__Appraisal__c where dealer__Trade_In__c in: tradeIdList]) {
            lstAppraisals.add(new dealer__Appraisal__c(
                Id = a.Id,
                dealer__Deal__c = Null
            ));
        }
        try {
            if (lstTradeIn != Null && lstTradeIn.size() > 0) {
                update lstAppraisals;
                delete lstTradeIn;
                return '{"success":"true"}';
            }
        } catch (DmlException e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }

        return '{"error":"A proper Trade In Id was not submitted with the delete request."}';
    }

    /**
     * deleteDeal 
     * @return String
     * @description Delete the deal record
     */
    public String deleteDeal() 
    {
        List < dealer__Deal__c > lstDeal = [select id, Name, dealer__Vehicle__r.Name, dealer__Buyer_Contact__r.Name, dealer__Buyer__r.name, dealer__Status__c from dealer__Deal__c where id =: currentId];

        if (lstDeal != null && lstDeal.size() > 0) {
            delete lstDeal;
            return '{"success":"true"}';
        }
        return '{"error":"A proper Deal Id was not submitted with the delete request."}';
    }

    /**
     * getParts
     * @return String
     * @description
     * @debug This method is incorrectly calling the dealer__Parts_Inventory__c object.
     *        It should instead be calling the Parts_Master__c object and returning the 
     *        appropriate values. 
     */
    public string getParts() 
    {
        //List<dealer__Parts_Inventory__c> parts = new List<dealer__Parts_Inventory__c>([select id, Name,dealer__MFG__c,dealer__List__c,dealer__Description__c,dealer__Cost__c,dealer__Product_Tax_Code__c from dealer__Parts_Inventory__c]);
        
        //Get Matrix for applicability
        List<dealer__PriceMatrix__mdt> matrix = [SELECT Id, dealer__HighCost__c, dealer__LowCost__c, dealer__Multiplier__c, dealer__PaymentMethod__c, dealer__Location_Object__c, dealer__Location_Name__c FROM dealer__PriceMatrix__mdt WHERE dealer__PaymentMethod__c = 'I'];

        String searchFilter = '%' + String.valueOf(urlParams.get('filter[filters][0][value]')) + '%';
        List < dealer__Parts_Master__c > partMaster = new List < dealer__Parts_Master__c > ();
        partMaster = [SELECT Id, Name, dealer__Part_Description__c, dealer__Manufacturer__c, dealer__Retail_Price__c, dealer__Cost__c, dealer__Part_No__c, dealer__Status__c FROM dealer__Parts_Master__c
            WHERE(
                dealer__Part_Description__c LIKE: searchFilter OR dealer__Manufacturer__c LIKE: searchFilter OR dealer__Part_No__c LIKE: searchFilter
            )
            //this will limit the search results on the 'Add Parts' Button 
            LIMIT 200
        ];

        // Process the Matrix and Apply the Parts
        for(dealer__Parts_Master__c pm : partMaster) {
            for(dealer__PriceMatrix__mdt mtx : matrix) {
                if(pm.dealer__Cost__c >= mtx.dealer__LowCost__c && pm.dealer__Cost__c <= mtx.dealer__HighCost__c) {
                    pm.dealer__Cost__c = (pm.dealer__Cost__c * (mtx.dealer__Multiplier__c / 100)) + pm.dealer__Cost__c;
                    System.debug('Setting new cost by Matrix of '+mtx.dealer__Multiplier__c);
                }
            }
        }

        return JSON.serialize(partMaster);
    }

    /**
     * getPicklistFieldDescribe
     * @return void
     * @description
     */ 
    public void getPicklistFieldDescribe() 
    {
        //Get Sobject type
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('dealer__Deal__c'); //From the Object Api name retrieving the SObject
        Schema.DescribeSObjectResult sobject_describe = targetType.getDescribe(); //describe the sobject
        field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
    }

    /**
     * getServiceContractPicklistValues 
     * @return string
     * @description
     */
    public string getServiceContractPicklistValues() 
    {
        string fieldName = urlParams.get('fieldName');
        Schema.DescribeSObjectResult dsr = dealer__Service_Contract__c.sObjectType.getDescribe();
        Schema.DescribeFieldResult fieldResult = dsr.fields.getMap().get(fieldName).getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        //set the picklist values in a list
        List < String > options = new List < String > ();
        options.add('--None--');
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getValue());
        }
        return JSON.serializePretty(options);
    }

    /**
     * getconversionMFGPicklistValues 
     * @return string
     * @description
     */
    public string getconversionMFGPicklistValues() 
    {
        Schema.DescribeSObjectResult dsr = dealer__Deal__c.sObjectType.getDescribe();
        Schema.DescribeFieldResult fieldResult = dsr.fields.getMap().get('dealer__Conversion_Manufacturer__c').getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        //set the picklist values in a list
        List < String > options = new List < String > ();
        options.add('--None--');
        for (Schema.PicklistEntry f: ple) {
            options.add(f.getValue());
        }
        return JSON.serializePretty(options);
    }

    /**
     * getAvailableContractSoql 
     * @return string
     * @description
     */
    public string getAvailableContractSoql() 
    {


        string filters = getFilters();
        String querySoql = 'Select dealer__Car_Deal__c,Name,dealer__Company_Number__c, dealer__Contract_Template__c,dealer__Cost__c,dealer__Customer_Contact__c,' +
            'dealer__Customer__c,dealer__Deductable__c,dealer__Description__c,dealer__Taxable__c,dealer__Printable__c,' +
            'dealer__End_Date__c,Id,dealer__Expiration_Mileage__c,dealer__Expiration_Months__c,dealer__Gross__c,' +
            'dealer__Odometer_at_Sale__c,dealer__Order__c,dealer__Plan_Code__c,dealer__Product_Code__c,' +
            'dealer__Sale_Price__c,dealer__Service_Vehicle__c,dealer__Start_Date__c,dealer__Type__c,' +
            'dealer__Vehicle_Inventory__c from dealer__Service_Contract__c where dealer__Contract_Template__c = true ';
        string querySosl = '';
        string keyWord = searchQuery;
        List < List < SObject >> searchList;
        if (searchQuery != '') {
            querySosl = 'FIND :keyWord IN ALL FIELDS RETURNING dealer__Service_Contract__c (Id where Id!=null and dealer__Contract_Template__c =true ' + filters + ')';
            searchList = search.query(querySosl);
            system.debug('>>' + querySosl);
            if (searchList[0] != null && searchList[0].size() > 0)
                querySoql += ' and id in(' + getRecordIds(searchList[0]) + ')';
        } else
            querySoql += filters;
        system.debug('soql>>' + querySoql);
        return querySoql;
    }

    /**
     * getmyDeskingSettings 
     * @return String
     * @description
     */
    public String getmyDeskingSettings() 
    {
        return JSON.serialize(mySettings);
    }

    /**
     * setDisplayAsGross 
     * @param  onoff 
     * @description
     */
    @RemoteAction
    public static void setDisplayAsGross(String onoff) 
    {
        DeskingUserSetting__c myCurrentSetting = DeskingUserSetting__c.getInstance(UserInfo.getUserId());
        if(onoff=='true') {
            myCurrentSetting.DisplayGrossAsPercent__c=true;
        } else {
            myCurrentSetting.DisplayGrossAsPercent__c=false;
        }

        try {
            update myCurrentSetting;
        } Catch(DmlException e) {
            throw new DealTRSControllerException(e.getMessage());
        }
    }

    /**
     * setCustomDisplay description
     * @description
     */
    @RemoteAction
    public static void setCustomDisplay() 
    {
        DeskingUserSetting__c myCurrentSetting = DeskingUserSetting__c.getInstance(UserInfo.getUserId());
        if(myCurrentSetting.CustomerView__c==false) {
            myCurrentSetting.CustomerView__c=true;
        } else {
            myCurrentSetting.CustomerView__c=false;
        }

        try {
            upsert myCurrentSetting;
        } Catch(DmlException e) {
            throw new DealTRSControllerException(e.getMessage());
        }        
    }

    /**
     * getAvailableContracts 
     * @return string
     * @description Return list of available Service contracts for warranty tab
     */
    public string getAvailableContracts() 
    {
        //Integer skip = Integer.valueOf(urlParams.get('skip'));
        Integer pageSize = Integer.valueOf(urlParams.get('pageSize'));

        string querySoql = getAvailableContractSoql();

        /*List<dealer__Service_Contract__c> availableServiceContract = [Select dealer__Car_Deal__c,Name,dealer__Company_Number__c, dealer__Contract_Template__c,dealer__Cost__c,dealer__Customer_Contact__c,
                                                 dealer__Customer__c,dealer__Deductable__c,dealer__Description__c,dealer__Taxable__c,dealer__Printable__c,
                                                 dealer__End_Date__c,id,dealer__Expiration_Mileage__c,dealer__Expiration_Months__c,dealer__Gross__c,
                                                 dealer__Odometer_at_Sale__c,dealer__Order__c,dealer__Plan_Code__c,dealer__Product_Code__c,
                                                 dealer__Sale_Price__c,dealer__Service_Vehicle__c,dealer__Start_Date__c,dealer__Type__c,
                                                 dealer__Vehicle_Inventory__c from dealer__Service_Contract__c where dealer__Contract_Template__c =:true ];*/
        List < dealer__Service_Contract__c > availableServiceContract = Database.query(querySoql + ' limit :pageSize');
        if (availableServiceContract != null && !availableServiceContract.isEmpty())
            return JSON.serialize(availableServiceContract);

        return '[]';
    }

    /**
     * getAvailableContractCount 
     * @return string
     * @description
     */
    public string getAvailableContractCount() 
    {
        string soql = 'select count(id) from dealer__Service_Contract__c where dealer__Contract_Template__c =true';
        AggregateResult res = Database.Query(soql);
        Integer count = integer.valueof(res.get('expr0'));
        return '{"total":"' + count + '"}';
    }

    /**
     * getDiscountTemplates 
     * @return string
     * @description Discount objects read from Database
     */
    public string getDiscountTemplates() 
    {

        List < dealer__Discount_Rebate__c > discs = [SELECT Id, dealer__Desc__c, dealer__Type__c, dealer__Amount__c, dealer__Gross__c, dealer__Taxable__c, Name FROM dealer__Discount_Rebate__c Where recordType.Name = 'Template'];

        if (discs.size() > 0) {
            return JSON.serializePretty(discs);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }
    
    /**
     * getRebates 
     * @return string
     * @description
     */
    public string getRebates() 
    {
        List < dealer__Discount_Rebate__c > discs = [SELECT Id, dealer__Deal__c, dealer__Desc__c, dealer__Type__c, dealer__Amount__c, dealer__Gross__c, dealer__Taxable__c, Name FROM dealer__Discount_Rebate__c WHERE dealer__Deal__c =: this.currentId AND Type__c = 'MFR Rebate'];

        if (discs.size() > 0) {
            return JSON.serializePretty(discs);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }
    
    /**
     * getDiscounts 
     * @return string
     * @description Discount objects read from Database
     */
    public string getDiscounts() 
    {

        List < dealer__Discount_Rebate__c > discs = [SELECT Id, dealer__Deal__c, dealer__Desc__c, dealer__Type__c, dealer__Amount__c, dealer__Gross__c, dealer__Taxable__c, Name FROM dealer__Discount_Rebate__c WHERE dealer__Deal__c =: this.currentId AND Type__c != 'MFR Rebate'];

        if (discs.size() > 0) {
            return JSON.serializePretty(discs);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }

    /**
     * updateDiscount 
     * @return string
     * @description
     */
    public string updateDiscount() 
    {

        RecordType tr = [SELECT Id FROM RecordType WHERE Name = 'Line Item'
            AND sObjectType = 'dealer__Discount_Rebate__c'
            LIMIT 1
        ];

        dealer__Discount_Rebate__c disc = new dealer__Discount_Rebate__c();

        disc.Name = String.valueOf(urlParams.get('Name'));

        disc.dealer__Deal__c = String.valueOf(urlParams.get('dealId'));
        disc.RecordTypeId = tr.Id;

        disc.dealer__Desc__c = String.valueOf(getValue(urlParams.get('dealer__Desc__c'), 'string'));
        disc.dealer__Type__c = String.valueOf(getValue(urlParams.get('dealer__Type__c'), 'string'));
        disc.dealer__Amount__c = Decimal.valueOf(String.valueOf(urlParams.get('dealer__Amount__c')));
        disc.dealer__Gross__c = String.valueOf(getValue(urlParams.get('dealer__Gross__c'), 'string'));

        disc.dealer__Taxable__c = Boolean.valueOf(urlParams.get('dealer__Taxable__c') != null ? urlParams.get('dealer__Taxable__c') : 'false');

        if (urlParams.get('Id') != null && urlParams.get('Id') != '') {
            disc.Id = Id.valueOf(urlParams.get('Id'));

            try {
                update disc;
            } catch (DmlException e) {
                System.debug('');
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }

        } else {

            try {
                insert disc;
            } catch (DmlException e) {
                System.debug('');
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }

        }
        return JSON.serializePretty(disc);
    }

    /**
     * destroyDiscount 
     * @return string
     * @description
     */
    public string destroyDiscount() 
    {
        dealer__Discount_Rebate__c disc = new dealer__Discount_Rebate__c();
        system.debug(this.currentId);
        disc.Id = Id.valueOf(urlParams.get('Id'));

        try {
            delete disc;
            //return '[]';
           return getDiscounts();
        } catch (DmlException e) {
            System.debug('');
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }

    /**
     * getGrossItems 
     * @return String
     * @description
     */
    public String getGrossItems() 
    {

        List < String > options = new List < String > ();

        Schema.DescribeFieldResult fieldResult =
            dealer__Discount_Rebate__c.dealer__Gross__c.getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();

        for (Schema.PicklistEntry f: ple) {
            options.add(f.getValue());
        }

        return JSON.serializePretty(options);

        //return '["FE","BE"]';
    }

    /**********
     *
     * DEAL TAX
     * *
     *
     */

    /**
     * getTaxTemplates 
     * @return string
     * @description Discount objects read from Database
     */
    public string getTaxTemplates() 
    {

        List < dealer__Deal_Tax__c > taxers = [SELECT Id, Name, dealer__Flat_Tax__c, dealer__Tax_Percentage__c, dealer__Type__c FROM dealer__Deal_Tax__c Where recordType.Name = 'Template'];

        if (taxers.size() > 0) {
            return JSON.serializePretty(taxers);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }


    /**
     * dealTaxes
     * @return List < dealer__Deal_Tax__c >
     * @description 
     */
    public List < dealer__Deal_Tax__c > dealTaxes() 
    {
        system.debug('DealTaxes '+ this.currentId);
        List < dealer__Deal_Tax__c > taxes = [SELECT Id, Name, dealer__Flat_Tax__c, dealer__Tax_Percentage__c, dealer__Equipment_Tax__c, dealer__Type__c FROM dealer__Deal_Tax__c WHERE dealer__Deal__c =: this.currentId];
            system.debug(taxes);
        return taxes;
    }

    /**
     * getDealTaxes 
     * @return string
     * @description Deal Tax objects read from Database
     */
    public string getDealTaxes() 
    {

        List < dealer__Deal_Tax__c > taxes = dealTaxes();

        if (taxes.size() > 0) {
            return JSON.serializePretty(taxes);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }

    /**
     * getDealMiscTaxes 
     * @return string
     * @description
     */
    public string getDealMiscTaxes() 
    {
        String DealId = ApexPages.currentPage().getParameters().get('dealId');
        String loc_id = urlParams.get('loc_id');
        String VehNewUsedOther;
        List < dealer__Misc_Tax_Codes__c > taxes = new List < dealer__Misc_Tax_Codes__c > ();

        for (dealer__deal__c d: [select id, dealer__Vehicle__c, dealer__Vehicle__r.dealer__New_Used_Other__c from dealer__deal__c where id =: DealId]) {
            if (d.dealer__Vehicle__c != null) {
                VehNewUsedOther = d.dealer__Vehicle__r.dealer__New_Used_Other__c;
                taxes = [Select id, name, dealer__Location__c, dealer__Percent__c, dealer__isChassis__c, dealer__isConversion__c, dealer__Taxable__c, dealer__New_Used_Other__c from dealer__Misc_Tax_Codes__c where dealer__Location__c =: loc_id AND(dealer__isChassis__c = true OR(dealer__isConversion__c = true AND dealer__New_Used_Other__c =: VehNewUsedOther)) AND dealer__Taxable__c = true];
            }
        }

        if (taxes.size() > 0) {
            return JSON.serializePretty(taxes);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }

    /**
     * getReadTaxItems
     * @return String
     * @description
     */
    public String getReadTaxItems() 
    {
        String dealId = String.valueOf(urlParams.get('dealId'));
        return JSON.serialize(TaxAPI.transactionItems(dealId));
    }
    
    /**
     * deleteTaxTansactionItem 
     * @return String
     * @description 
     */
    public String deleteTaxTansactionItem()
    {
        Id dealId = Id.valueOf(urlParams.get('dealId'));
        Id taxTransactionId = Id.valueOf(urlParams.get('Id'));

        System.assert(dealId!=null, 'DealID can not be null');
        System.assert(taxTransactionId!=null, 'TaxtransactionId can not be null');
        try{
            TaxTransactionItem__c ti = new TaxTransactionItem__c(Id=taxtransactionid);
            delete ti;
            TaxAPI.updateDealTotalTax(dealId);
        } catch(DmlException e){
            return 'ERROR ';
        }
        return JSON.serialize(TaxAPI.transactionItems(dealId));
    }
    
    /**
     * upsertTaxTransactionItem 
     * @return String
     * @description String
     */
    public String upsertTaxTransactionItem()
    {
        Id dealId = Id.valueOf(urlParams.get('dealId'));
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId);

        Id taxTransactionId = Id.valueOf(urlParams.get('Id'));

        System.assert(dealId!=null, 'DealID can not be null');
        System.assert(taxTransactionId!=null, 'TaxtransactionId can not be null');
        
        TaxTransactionItem__c existingTi = [SELECT ManualOverride__c FROM TaxTransactionItem__c WHERE Id =: taxTransactionId];
        
        Boolean manual = existingTi.ManualOverride__c && !Boolean.valueOf(urlParams.get('dealer__ManualOverride__c')) ? false : true;
        
        TaxTransactionItem__c ti =new TaxTransactionItem__c(
            Id = String.valueOf(urlParams.get('Id')),
            //If manual edit reverse engineer rate from the tax and taxable amount
            Rate__c = Decimal.valueOf(urlParams.get('dealer__Rate__c')),
            ManualOverride__c = manual
        );
        
        try {
            update ti;
            TaxAPI.calculateTaxes(deal);
            TaxAPI.updateDealTotalTax(dealId);

        } Catch(DmlException e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }

        return JSON.serialize(ti);
    }

    /**
     * upsertTaxLine 
     * @return string
     * @description
     */
    public string upsertTaxLine() 
    {

        // Get Record Type ID for "Line Items"
        RecordType tr = [SELECT Id FROM RecordType WHERE Name = 'Line Item'
            AND sObjectType = 'dealer__Deal_Tax__c'
            LIMIT 1
        ];

        dealer__Deal_Tax__c tax = new dealer__Deal_Tax__c();

        tax.dealer__Deal__c = String.valueOf(urlParams.get('dealId'));
        tax.RecordTypeId = tr.Id;
        tax.Name = String.valueOf(urlParams.get('Name'));
        tax.dealer__Type__c = String.valueOf(getValue(urlParams.get('dealer__Type__c'), 'string'));


        if (urlParams.get('dealer__Flat_Tax__c') != null && urlParams.get('dealer__Flat_Tax__c') != '') {
            tax.dealer__Flat_Tax__c = Decimal.valueOf(String.valueOf(urlParams.get('dealer__Flat_Tax__c')));
        }

        if (urlParams.get('dealer__Tax_Percentage__c') != null && urlParams.get('dealer__Tax_Percentage__c') != '') {
            tax.dealer__Tax_Percentage__c = Decimal.valueOf(String.valueOf(urlParams.get('dealer__Tax_Percentage__c')));
        }

        if (urlParams.get('dealer__Deal_Tax_Parent__c') != null && urlParams.get('dealer__Deal_Tax_Parent__c') != '') {
            tax.dealer__Deal_Tax_Parent__c = String.valueOf(getValue(urlParams.get('dealer__Deal_Tax_Parent__c'), 'string'));
        }

        //if(urlParams.get('dealer__Misc_Tax_Code__c')!=null && urlParams.get('dealer__Misc_Tax_Code__c')!=''){
        //  tax.dealer__Deal_Tax_Parent__c  = String.valueOf( getValue( urlParams.get('dealer__Misc_Tax_Code__c'),'string'));
        //}

        if (urlParams.get('Id') != null && urlParams.get('Id') != '') {
            tax.Id = Id.valueOf(urlParams.get('Id'));

            try {
                update tax;
                system.debug('update tax;');
            } catch (DmlException e) {
                System.debug('{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}');
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }

        } else {

            try {
                insert tax;
            } catch (DmlException e) {
                System.debug('{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}');
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }

        }
        System.debug('Tax - ' + JSON.serialize(tax));

        return JSON.serialize(tax);
    }

    /**
     * destroyTaxLine 
     * @return string
     * @description
     */
    public string destroyTaxLine() 
    {
        dealer__Deal_Tax__c tax = new dealer__Deal_Tax__c();
        Id taxRecordId = Id.valueOf(urlParams.get('Id'));
        // Possible update to Deal Record required
        tax = [SELECT Id, dealer__Deal__c, dealer__Type__c FROM dealer__Deal_Tax__c WHERE Id =: taxRecordId];

        try {
                dealer__Deal__c deal = new dealer__Deal__c();
                deal = new dealer__Deal__c(
                    Id = tax.dealer__Deal__c,
                    dealer__Tax_Zone__c = null
                );
                delete tax;
                return getDealTaxes();
        } catch (DmlException e) {
            System.debug(e.getMessage());
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }

    /**
     * getTaxZoneSearch 
     * @return String
     * @description
     */
    public String getTaxZoneSearch() 
    {
        String dealId =urlParams.get('dealId');
        String searchFilter = (urlParams.get('filter[filters][0][value]')!=null && urlParams.get('filter[filters][0][value]')!='') ? '%' + String.valueOf(urlParams.get('filter[filters][0][value]')) + '%' : null ;

        //acquire tax zone data from current deal
        Deal__c thisDeal = new Deal__c();
        DealAPI.deal dealWrapper = new DealAPI.deal();

        // 
        // Store Location
        // Buyer
        // Id
        if(dealId != null){
            thisDeal = [SELECT Id, Tax_Zone__c, 
                Tax_Zone__r.Name, Tax_Zone__r.City__c, Tax_Zone__r.County__c, Tax_Zone__r.Postal_Code__c,
                Tax_Zone__r.Rate__c, Tax_Zone__r.State__c, Tax_Zone__r.Common_Name__c,
                dealer__Broker__c, dealer__Buyer_Contact__c, dealer__Buyer__c, dealer__Co_Buyer_Contact__c, dealer__Co_Buyer__c, dealer__Deferred_1_Payee__c, 
                dealer__Deferred_2_Payee__c, dealer__Deferred_3_Payee__c, dealer__DeliveryRepairOrder__c, dealer__Desk_Manager__c, dealer__Finance_Institution_Account__c, 
                dealer__Internet_Member__c, dealer__Multi_Quote_Vehicle_1__c, dealer__Multi_Quote_Vehicle_2__c, dealer__Multi_Quote_Vehicle_3__c, 
                dealer__Sales_Lead__c, dealer__Salesperson_1__c, dealer__Salesperson_3__c, dealer__Salesperson_4__c, dealer__Service_Vehicle__c, 
                dealer__Store_Location__c, dealer__Vehicle__c, dealer__PricingStrategy__c
                FROM Deal__c WHERE Id =: dealId];

                dealWrapper.dealHeader = thisDeal;
        }

        //Map to store tax zones returned, we must always return the Tax Zone assigned to current deal.
        Map<Id, Tax_Zones__c> taxZoneMap = new Map<Id, Tax_Zones__c>();
        DealerMethodOverride__mdt classOverride = Utility.methodOverride('TaxOverride', 'searchZones');
        if(classOverride.Id!=null) {
            try {
                Type t = Type.forName('', classOverride.OverrideClass__c);
                TaxOverride tzs = (TaxOverride)t.newInstance();
                for(Tax_Zones__c tz : tzs.searchZones(searchFilter, 10, dealWrapper)){
                    taxZoneMap.put(tz.Id, tz);
                } 
            } Catch(Exception e) {
                throw new DealTRSControllerException(e.getMessage());
            }
        } else {
            TaxOverride to = new TaxOverride();
            for(Tax_Zones__c tz : to.searchZones(searchFilter, 10, new DealAPI.deal())){ // Pass the Deal to the API
                taxZoneMap.put(tz.Id, tz);
            } 
        }
        if(thisDeal.Tax_Zone__c != null){
            if(taxZoneMap.get(thisDeal.Tax_Zone__c) == null){
                taxZoneMap.put(thisDeal.Tax_Zone__c, thisDeal.Tax_Zone__r);
            }
        }
        return JSON.serializePretty(taxZoneMap.values());
    }

    /**
     * taxZonesByZip 
     * @return List < dealer__Tax_Zones__c > 
     * @description
     */
    public List < dealer__Tax_Zones__c > taxZonesByZip() 
    {
        String zipCode = String.valueOf(ApexPages.currentPage().getParameters().get('taxable_zip'));

        List < dealer__Tax_Zones__c > zones = [SELECT Id, dealer__Common_Name__c, dealer__City__c, dealer__County__c, dealer__Postal_Code__c, dealer__Rate__c, dealer__State__c
            FROM dealer__Tax_Zones__c
            WHERE dealer__Postal_Code__c =: zipCode
            AND(
                (dealer__Effective_Date__c < TODAY OR dealer__Effective_Date__c = null) AND(dealer__Expires_Date__c > TODAY OR dealer__Expires_Date__c = null)
            )

            LIMIT 100
        ];

        return zones;
    }

    /**
     * getTaxZones 
     * @return 
     * @description
     */
    public string getTaxZones() 
    {

        List < dealer__Tax_Zones__c > zones = taxZonesByZip();

        if (zones.size() > 0) {
            return JSON.serializePretty(zones);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }

    /**
     * getTaxZones 
     * @param  taxZoneId 
     * @return dealer__Tax_Zones__c
     * @description
     */
    public dealer__Tax_Zones__c getTaxZones(Id taxZoneId) 
    {
        return [SELECT Id, dealer__City__c, dealer__County__c, dealer__Postal_Code__c, dealer__Rate__c, dealer__State__c
            FROM dealer__Tax_Zones__c
            WHERE Id =: taxZoneId
            LIMIT 1
        ];
    }


    /**
     * renewTaxLines 
     * @return string
     * @description Called when the tax lines need to be calulated/re-calculated
     *              Updated to use new Tax Methods
     */ 
    public string renewTaxLines() {

        /* 
        System.debug('Called Renew Tax Lines');

        String zipCode = urlParams.get('taxable_zip');
        String dealId = urlParams.get('dealId'); 

        Deal__c dealTaxRenew = [SELECT Id, Tax_Zone__c FROM Deal__c WHERE Id=:dealId LIMIT 1];       
        
        System.assert(dealTaxRenew.Tax_Zone__c!=null, 'Tax zone may not be null when calling renewTaxLines');

        try {
            DealAPI.applyTaxZone(dealTaxRenew, new Tax_Zones__c(Id=dealTaxRenew.Tax_Zone__c));
        } Catch(Exception e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}'; 
        }
        */

        return JSON.serialize(true);        

        // String zipCode = urlParams.get('taxable_zip');
        // String dealId = urlParams.get('dealId');

        // // First Destroy All deal Taxes
        // List < dealer__Deal_Tax__c > deadTaxes = [SELECT Id, Name, dealer__Flat_Tax__c, dealer__Tax_Percentage__c, dealer__Type__c FROM dealer__Deal_Tax__c WHERE dealer__Deal__c =: dealId AND dealer__Tax_Zone__c != null AND recordType.Name = 'Line Item'];
        // delete deadTaxes;

        // RecordType rType = [SELECT Id from RecordType where DeveloperName = 'Line_Item'
        //     AND SobjectType = 'dealer__Deal_Tax__c'
        //     LIMIT 1
        // ];

        // List < dealer__Deal_Tax__c > newTaxes = new List < dealer__Deal_Tax__c > ();
        // for (dealer__Tax_Zones__c zone: taxZonesByZip()) {

        //     String state = (zone.dealer__State__c != null) ? zone.dealer__State__c + ':' : '';
        //     String county = (zone.dealer__County__c != null) ? zone.dealer__County__c + ':' : '';
        //     String city = (zone.dealer__City__c != null) ? zone.dealer__City__c : '';

        //     dealer__Deal_Tax__c newLine = new dealer__Deal_Tax__c(
        //         Name = state + county + city,
        //         RecordTypeId = rType.Id,
        //         dealer__Tax_Percentage__c = zone.dealer__Rate__c,
        //         dealer__Type__c = 'Tax Zone',
        //         dealer__Deal__c = dealId,
        //         dealer__Tax_Zone__c = zone.Id
        //     );

        //     newTaxes.add(newLine);
        // }

        // insert newTaxes;

        // Boolean returnTrue = true;

        // return JSON.serialize(returnTrue);
    }

    public string getMiscTaxCode() {
        String c_ptc = urlParams.get('c_ptc'); // Conversion product tax code id
        String loc_id = urlParams.get('loc_id'); // location id
        //if(c_ptc != null){
        List < dealer__Misc_Tax_Codes__c > codes = [SELECT Id, Name, dealer__Percent__c, dealer__Product__c, dealer__Location__c, dealer__Taxable__c FROM dealer__Misc_Tax_Codes__c WHERE dealer__Product__c =: c_ptc AND dealer__Location__c =: loc_id LIMIT 1];

        if (codes.size() > 0) {
            return JSON.serializePretty(codes);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }
    public string getmiscChargeCodes() {
        String dealId = urlParams.get('dealId');
        dealer__Deal__c d = [SELECT Id, Name, dealer__Store_Location__c from dealer__Deal__c where Id =: dealId];
        string locId = d.dealer__Store_Location__c;
        List < dealer__MiscChargeCode__c > items = [SELECT Id, Name, dealer__Location__c FROM dealer__MiscChargeCode__c WHERE dealer__Location__c =: locId ORDER BY Name ASC];
        if (items.size() > 0) {
            return JSON.serializePretty(items);

        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }

    }

    /**
     * getPostingTemplates 
     * @return String
     * @description Posting Template Selector
     */
    public String getPostingTemplates() {
        List<String> postingTemplates = new List<String>();
        for(dealer__PostingTemplate__c pt :[SELECT Id, Name FROM dealer__PostingTemplate__c WHERE dealer__Object_Name__c='Deal' and dealer__Active__c=true] ){
            postingTemplates.add(pt.Name);
        }
        return postingTemplates.size() > 0 ? JSON.serialize(postingTemplates) : '[]';
    }


    /**********
     *
     * CONTRACTS
     * *
     *
     */

    /**
     * getSelectedContracts
     * @return string
     * @description return list of selected contract based on "Contract Template" check box
     */
    public string getSelectedContracts() 
    {

        String dealId = urlParams.get('dealId');

        List < dealer__Service_Contract__c > selectedServiceContract = [Select dealer__Car_Deal__c, Name, dealer__Company_Number__c, dealer__Contract_Template__c, dealer__Cost__c, dealer__Customer_Contact__c,
            dealer__Customer__c, dealer__Discount__c, dealer__Deductable__c, dealer__Description__c, dealer__Taxable__c, dealer__Printable__c,
            dealer__End_Date__c, id, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c, dealer__Gross__c,
            dealer__Odometer_at_Sale__c, dealer__Order__c, dealer__Plan_Code__c, dealer__Product_Code__c,
            dealer__Sale_Price__c, dealer__Service_Vehicle__c, dealer__Start_Date__c, dealer__Type__c,
            dealer__Vehicle_Inventory__c from dealer__Service_Contract__c where dealer__Contract_Template__c =: false and dealer__Car_Deal__c =: dealId order by dealer__Order__c
        ];
        return JSON.serialize(selectedServiceContract);
    }

    /**
     * deleteContract
     * @return String
     * @description
     */
    public String deleteContract() 
    {
        try {
            /*System.debug('Service Contract to be deleted - '+urlParams.get('Id'));
            dealer__Service_Contract__c objSv = [select Id from dealer__Service_Contract__c where id=:Id.valueOf(urlParams.get('Id')) limit 1];
            delete objSv;
            return '{"success":"true"}';*/
            String dealId = urlParams.get('dealId');
            string models = urlParams.get('models');
            Set < Id > recordToDelete = new Set < Id > ();
            if (models != null) {
                dealer__Service_Contract__c[] records = (dealer__Service_Contract__c[]) JSON.deserialize(models, List < dealer__Service_Contract__c > .class);

                List < dealer__Service_Contract__c > lstTODel = new List < dealer__Service_Contract__c > ();
                for (integer i = 0; i < records.size(); i++) {
                    recordToDelete.add(records[i].id);
                }
                lstTODel = [select id from dealer__Service_Contract__c where id IN: recordToDelete];
                delete lstTODel;
                dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
                return '{"success":"true"}';
            }
            return '{"error":"Bad request"}';
        } catch (DmlException e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }

    /**
     * insertContract 
     * @return string
     * @description 
     */
    public string insertContract() 
    {
        try {
            String dealId = urlParams.get('dealId');
            string models = urlParams.get('models');
            if (models != null) {
                dealer__Service_Contract__c[] records = (dealer__Service_Contract__c[]) JSON.deserialize(models, List < dealer__Service_Contract__c > .class);
                system.debug('>>' + records);
                List < dealer__Service_Contract__c > svcContract = new List < dealer__Service_Contract__c > ();
                for (dealer__Service_Contract__c svc: records) {
                    svc.id = null;
                    svcContract.add(svc);

                }

                insert svcContract;
                dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
                return JSON.serialize(svcContract);
            }
            return '{"error":"Bad request"}';
        } catch (Exception ex) {
            return '{"error":"' + ex.getMessage() + ',' + ex.getStackTraceString() + ' LINE: ' + ex.getLineNumber() + '"}';
        }
    }

    /**
     * insertAccount
     * @return String
     * @description method to insert account data
     */
    public String insertAccount() 
    {
        /*
        // Implied values are derived from the urlParams
        Account a = new Account();
        a.FirstName         =   (String)urlParams.get('dealer__Co_Buyer_First_Name__c');
        a.LastName          =   (String)urlParams.get('dealer__Co_Buyer_Last_Name__c');
        a.PersonHomePhone   =   (String)urlParams.get('dealer__Co_Buyer_Home_Phone__c');
        a.PersonMobilePhone =   (String)urlParams.get('dealer__Co_Buyer_Mobile_Phone__c');
        a.PersonMailingStreet=  (String)urlParams.get('dealer__Co_Buyer_Address__c');
        a.PersonMailingCity =   (String)urlParams.get('dealer__Co_Buyer_City__c');
        a.PersonMailingState=   (String)urlParams.get('dealer__Co_Buyer_State__c');
        a.PersonMailingPostalCode = (String)urlParams.get('dealer__Co_Buyer_Postal_Code__c');
        System.debug(a);
        try {
            insert a;
            return JSON.serialize(new List<Account>{a});
        } Catch(DmlException e) {
            return '{"error":"'+e.getMessage()+','+e.getStackTraceString()+' LINE: '+e.getLineNumber()+'"}';
        }
        */
        return '{"Error":"method deprecated"}';
    }

    /**
     * updateAccounts
     * @return String
     * @description Inserts or updates and account object passed into the method by URL Parameters.
     */
    public String updateAccounts() 
    {
        
        system.debug('** update buyer **');    
		
        try {
            Account objAccount = new Account();
            RecordType objRec = [SELECT Id, Name FROM RecordType 
                                 WHERE sObjectType = 'Account' AND IsPersonType = True limit 1];
            
            //Get Account Buyer id
            if (urlParams.get('dealer__buyer__c') != null && urlParams.get('dealer__buyer__c') != '') {
                objAccount.Id = String.valueOf(urlParams.get('dealer__buyer__c'));

            } else {
                if (objRec.Id != null)
                    objAccount.RecordTypeId = objRec.Id;
            }
            
            //*** Person Account ***
            if (urlParams.get('dealer__buyer__r[ispersonaccount]') == 'true') {
				
                //Home Phone
                if (urlParams.get('dealer__buyer_home_phone__c') != null && urlParams.get('dealer__buyer_home_phone__c') != '') {
                    objAccount.PersonHomePhone = objAccount.Phone = String.valueOf(urlParams.get('dealer__buyer_home_phone__c'));
                } 
                //FirstName
                if (urlParams.get('dealer__buyer_first_name__c') != null && urlParams.get('dealer__buyer_first_name__c') != '') { 
                    objAccount.FirstName = String.valueOf(urlParams.get('dealer__buyer_first_name__c'));
                }
                //MiddleName
                if (urlParams.get('dealer__buyer_middle_name__c') != null && urlParams.get('dealer__buyer_middle_name__c') != '') { 
                    objAccount.MiddleName = String.valueOf(urlParams.get('dealer__buyer_middle_name__c'));
                }
                //LastName
                if (urlParams.get('dealer__buyer_last_name__c') != null && urlParams.get('dealer__buyer_last_name__c') != '') { 
                    objAccount.LastName = String.valueOf(urlParams.get('dealer__buyer_last_name__c'));
                }
                //Birthdate
                if (urlParams.get('dealer__buyer_birthdate__c') != null && urlParams.get('dealer__buyer_birthdate__c') != '') { 
                   	objAccount.PersonBirthdate = Date.valueOf(urlParams.get('dealer__buyer_birthdate__c'));
                }
                //Address Street
                if (urlParams.get('dealer__buyer_address__c') != null && urlParams.get('dealer__buyer_address__c') != '') { 
                    objAccount.PersonMailingStreet = objAccount.BillingStreet = String.valueOf(urlParams.get('dealer__buyer_address__c'));
                }
                //Address City
                if (urlParams.get('dealer__buyer_city__c') != null && urlParams.get('dealer__buyer_city__c') != '') { 
                    objAccount.PersonMailingCity = objAccount.BillingCity = String.valueOf(urlParams.get('dealer__buyer_city__c'));
                }
                //Address State
                if (urlParams.get('dealer__buyer_state__c') != null && urlParams.get('dealer__buyer_state__c') != '') { 
                    objAccount.PersonMailingState = objAccount.BillingState = String.valueOf(urlParams.get('dealer__buyer_state__c'));
                }
                //Address Postal Code
                if (urlParams.get('dealer__buyer_postal_code__c') != null && urlParams.get('dealer__buyer_postal_code__c') != '') { 
                    objAccount.PersonMailingPostalCode = objAccount.BillingPostalCode = String.valueOf(urlParams.get('dealer__buyer_postal_code__c'));
                }
				//Driving License #
                if (urlParams.get('dealer__buyer_drivers_license__c') != null && urlParams.get('dealer__buyer_drivers_license__c') != '') { 
                    objAccount.dealer__Drivers_License_Number__pc = String.valueOf(urlParams.get('dealer__buyer_drivers_license__c'));
                }
                //Driving License State
                if (urlParams.get('dealer__buyer_drivers_lic_state__c') != null && urlParams.get('dealer__buyer_drivers_lic_state__c') != '') { 
                    objAccount.dealer__Drivers_License_State__pc = String.valueOf(urlParams.get('dealer__buyer_drivers_lic_state__c'));
                } 
                //Driving License Exp. Date
                if (urlParams.get('dealer__buyer_drivers_license_exp_date__c') != null && urlParams.get('dealer__buyer_drivers_license_exp_date__c') != '') { 
                    objAccount.dealer__Drivers_License_Expiration_Date__pc = Date.valueOf(urlParams.get('dealer__buyer_drivers_license_exp_date__c'));
                } 
            } else {

                //Address Street
                if (urlParams.get('dealer__buyer_address__c') != null && urlParams.get('dealer__buyer_address__c') != '') { 
                    objAccount.BillingStreet = String.valueOf(urlParams.get('dealer__buyer_address__c'));
                }
                //Address City
                if (urlParams.get('dealer__buyer_city__c') != null && urlParams.get('dealer__buyer_city__c') != '') { 
                    objAccount.BillingCity = String.valueOf(urlParams.get('dealer__buyer_city__c'));
                }
                //Address State
                if (urlParams.get('dealer__buyer_state__c') != null && urlParams.get('dealer__buyer_state__c') != '') { 
                    objAccount.BillingState = String.valueOf(urlParams.get('dealer__buyer_state__c'));
                }
                //Address Postal Code
                if (urlParams.get('dealer__buyer_postal_code__c') != null && urlParams.get('dealer__buyer_postal_code__c') != '') { 
                    objAccount.BillingPostalCode = String.valueOf(urlParams.get('dealer__buyer_postal_code__c'));
                }
                //LastName
                if (urlParams.get('dealer__buyer_last_name__c') != null && urlParams.get('dealer__buyer_last_name__c') != '') { 
                    objAccount.LastName = String.valueOf(urlParams.get('dealer__buyer_last_name__c'));
                }
            }
       
            //Email
            if (urlParams.get('dealer__buyer_email__c') != null && urlParams.get('dealer__buyer_email__c') != '') {
                objAccount.dealer__Billing_Email__c = String.valueOf(urlParams.get('dealer__buyer_email__c'));
            }
            //County: Move this field to dealer package??
            if (urlParams.get('dealer__buyer_county__c') != null && urlParams.get('dealer__buyer_county__c') != '') { 
                // objAccount.dealer__County__c = String.valueOf(urlParams.get('dealer__buyer_county__c'));
            }
    
			system.debug('**** account ' + objAccount);
            if (objAccount.Id == null) {
                insert objAccount;
            } else {
                upsert objAccount;
            }

            return JSON.serialize(new List < Account > {
                objAccount
            });

        } catch (DmlException ex) {
            return '{{"error":"' + ex.getMessage() + ',' + ex.getStackTraceString() + ' LINE: ' + ex.getLineNumber() + '"}';
        } catch (Exception ex) {
            return '{"error":"' + ex.getMessage() + ',' + ex.getStackTraceString() + ' LINE: ' + ex.getLineNumber() + '"}';
        }
    }

    /**
     * updateContract 
     * @return String
     * @description
     */
    public String updateContract() 
    {
        try {
            String dealId = urlParams.get('dealId');
            string models = urlParams.get('models');
            if (models != null) {
                dealer__Service_Contract__c[] records = (dealer__Service_Contract__c[]) JSON.deserialize(models, List < dealer__Service_Contract__c > .class);
                system.debug('records '+records[0].dealer__Discount__c);
                update records;
                Set < Id > ids = new Set < Id > ();
                for (dealer__Service_Contract__c af: records)
                    ids.add(af.Id);
                List < dealer__Service_Contract__c > svcList = [Select  dealer__Discount__c, dealer__Car_Deal__c, Name, dealer__Company_Number__c, dealer__Contract_Template__c, dealer__Cost__c, dealer__Customer_Contact__c,
                    dealer__Customer__c, dealer__Deductable__c, dealer__Description__c, dealer__Taxable__c, dealer__Printable__c,
                    dealer__End_Date__c, id, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c, dealer__Gross__c,
                    dealer__Odometer_at_Sale__c, dealer__Order__c, dealer__Plan_Code__c, dealer__Product_Code__c,
                    dealer__Sale_Price__c, dealer__Service_Vehicle__c, dealer__Start_Date__c, dealer__Type__c,
                    dealer__Vehicle_Inventory__c from dealer__Service_Contract__c where id in: ids order by dealer__Order__c
                ];
                dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
                return JSON.serialize(svcList);
            }
            return '{"error":"Bad request"}';

        } catch (Exception ex) {
            return '{"error":"' + ex.getMessage() + ',' + ex.getStackTraceString() + ' LINE: ' + ex.getLineNumber() + '"}';
        }
    }

    /*** Lender Methods ***/
    
    /**
     * getFinanceCompany 
     * @return String
     * @description
     */
    public String getFinanceCompany() 
    {
        List < dealer__Finance_Company__c > listFiCo = new List < dealer__Finance_Company__c > ();
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        // First Lookup
        if (searchAsk == null) {

            listFiCo = [SELECT Id, Name, dealer__Active__c, dealer__Bank_Address__c, dealer__Bank_City__c, dealer__Bank_State__c, dealer__Bank_Zip__c, dealer__Calculation_Method__c, dealer__Comments__c, dealer__Company_Number__c, dealer__ExternalId__c, dealer__Days_in_Year__c, dealer__New_Vehicle_Rate__c, dealer__Phone__c, dealer__Purchase_Lease__c, dealer__Reserve_Calculation_Method__c, dealer__Reserve_Percentage__c, dealer__Screen_Order__c, dealer__Used_Vehicle_Rate__c FROM dealer__Finance_Company__c LIMIT 50];

        } else {

            // SOSL Execute
            List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Finance_Company__c(Id, Name, dealer__Active__c, dealer__Bank_Address__c, dealer__Bank_City__c, dealer__Bank_State__c, dealer__Bank_Zip__c, dealer__Calculation_Method__c, dealer__Comments__c, dealer__Company_Number__c, dealer__ExternalId__c, dealer__Days_in_Year__c, dealer__New_Vehicle_Rate__c, dealer__Phone__c, dealer__Purchase_Lease__c, dealer__Reserve_Calculation_Method__c, dealer__Reserve_Percentage__c, dealer__Screen_Order__c, dealer__Used_Vehicle_Rate__c WHERE dealer__Active__c = true) LIMIT 50];

            listFiCo = (List < dealer__Finance_Company__c > ) soslResults[0];

        }

        return JSON.serializePretty(listFiCo);
    }

    /**
     * cloneDeal 
     * @return string
     * @description For creating deep clone of current deal.
     */
    public string cloneDeal() 
    {

        SavePoint sp = Database.setSavePoint();
        List < dealer__Deal__c > deals = getDealRecord();
        dealer__Deal__c objClonedDeal = (deals[0]).clone(false, true, false, false);
        objClonedDeal.dealer__Deal_ID__c = String.valueOf(dealer.Utility.nextDealNumber());
        objClonedDeal.Name = objClonedDeal.dealer__Deal_ID__c;
        try {
            insert objClonedDeal;
        }
        Catch(DmlException e) {
            Database.rollback(sp);
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }

        // Get the Equipment
        List < dealer__After_Market__c > am = new List < dealer__After_Market__c > ();
        for (dealer__After_Market__c a: [SELECT dealer__ExtPrice__c, dealer__Car_Deal__c, dealer__Company_Number__c, dealer__Cost__c, dealer__Description__c,
                dealer__Labor_Sale__c, dealer__List_Price__c, dealer__Parts_Kit__c, dealer__Parts_Sale__c,
                dealer__Sale_Price__c, dealer__Vendor__c, dealer__Tax_Rate__c, dealer__Misc_Tax_Code__c,
                dealer__Product_Tax_Code__c, dealer__Gross__c, dealer__Parts_Kit__r.dealer__Item_Count__c, dealer__Labor_Hours__c, dealer__Taxable__c,
                dealer__Labor_Cost__c, dealer__Labor_Gross__c, dealer__Part_Cost__c, dealer__Parts_Gross__c,
                dealer__Sales_Tax__c, dealer__GrossDistribution__c, dealer__Part__c, dealer__MFG__c, dealer__Part_Unit_Price__c, dealer__Part_Unit_Cost__c,
                dealer__Category__c, dealer__Hours__c, dealer__Kit_Notes__c, 
                dealer__Order__c, dealer__Printable__c, dealer__Quantity__c, dealer__Sub_Category__c,
                dealer__Type__c, Id, Name
                FROM dealer__After_Market__c
                WHERE dealer__Car_Deal__c =: deals[0].Id
            ]) {
            dealer__After_Market__c anew = new dealer__After_Market__c();
            anew = a;
            anew.Id = null;
            anew.dealer__Car_Deal__c = objClonedDeal.Id;
            am.add(a);

        }

        // Get the Taxes
        List < dealer__Deal_Tax__c > taxItems = new List < dealer__Deal_Tax__c > ();
        for (dealer__Deal_Tax__c dt: [SELECT dealer__Deal_Tax_Parent__c, dealer__Deal__c, dealer__Flat_Tax__c, dealer__Tax_Percentage__c,
                dealer__Type__c, dealer__Tax_Zone__c, Name, Id
                FROM dealer__Deal_Tax__c
                WHERE dealer__Deal__c =: deals[0].Id
            ]) {

            dealer__Deal_Tax__c newTaxItem = new dealer__Deal_Tax__c();
            newTaxItem = dt;
            newTaxItem.Id = null;
            newTaxItem.dealer__Deal__c = objClonedDeal.Id;
            taxItems.add(newTaxItem);
        }

        // Get the Trade Records
        List < dealer__Trade_In__c > tradeRecordsToAdd = new List < dealer__Trade_In__c > ();
        for (dealer__Trade_In__c ti: [SELECT dealer__Car_Deal__c, dealer__ACV__c, dealer__Appraisal_Date__c, dealer__Appraisal_Vehicle__c, dealer__Appraised_By__c, dealer__Black_Book_Retail__c,
                dealer__Black_Book_Wholesale__c, dealer__Inventory_Vehicle__c, dealer__K_B_B_Retail__c, dealer__K_B_B_Wholesale_Value__c, dealer__Lost_Trade__c,
                dealer__Make__c, dealer__Model__c, dealer__NADA_Retail__c, dealer__NADA_Wholesale__c, dealer__Net__c, dealer__Odometer_at_Trade_In__c,
                dealer__Pay_Off_Account_Number__c, dealer__Pay_Off_Account__c, dealer__Pay_Off_Amount__c, dealer__Pay_Off_Expiration_Date__c, dealer__Pay_Off_To__c,
                dealer__Position__c, dealer__Profit__c, dealer__Recon__c, dealer__Service_Vehicle__c, dealer__Stock_Number__c, dealer__Trade_Allowance__c, dealer__Trim_Level__c,
                dealer__VIN__c, dealer__Year__c, Name, Id
                FROM dealer__Trade_In__c
                WHERE dealer__Car_Deal__c =: deals[0].Id
            ]) {

            dealer__Trade_In__c t = new dealer__Trade_In__c();
            t = ti;
            t.Id = null;
            t.dealer__Car_Deal__c = objClonedDeal.Id;
            tradeRecordsToAdd.add(t);

        }

        if (!am.isEmpty()) {
            try {
                insert am;
            }
            Catch(DmlException e) {
                Database.rollback(sp);
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }
        }

        if (!taxItems.isEmpty()) {
            try {
                insert taxItems;
            }
            Catch(DmlException e) {
                Database.rollback(sp);
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }
        }

        if (!tradeRecordsToAdd.isEmpty()) {
            try {
                insert tradeRecordsToAdd;
            }
            Catch(DmlException e) {
                Database.rollback(sp);
                return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
            }
        }

        return JSON.serializePretty(objClonedDeal);
    }

    /**********
     *
     * FORMS
     * *
     *
     */

    /**
     * getLaserForm 
     * @return String
     * @description Get from detail
     */
    public String getLaserForm() 
    {
        List < dealer__Form__c > listLaserForm = new List < dealer__Form__c > ();

        String dealId = urlParams.get('dealId');
        Deal__c thisDeal = FormAPI.lookupDeal(dealId);
        List < dealer__Deal_Form__c > removeImpactForm = [Select id, dealer__Form__c, dealer__Form__r.name, dealer__Form__r.dealer__Print_Type__c
            from dealer__Deal_Form__c where(dealer__Form__r.dealer__Print_Type__c =: 'Laser'
                OR dealer__Form__r.dealer__Print_Type__c =: 'FDF') and dealer__Deal__c =: dealId
        ];

        set < Id > removeItems = new set < Id > ();
        for (dealer__Deal_Form__c dealF: removeImpactForm) {
            removeItems.add(dealF.dealer__Form__c);
        }
        for(Form__c f : (List<Form__c>)JSON.deserialize(getApplicableForms(thisDeal),List<Form__c>.class)){
            if(!removeItems.contains(f.Id)){
                removeItems.add(f.Id);
            }
        }

        //Add to removeItems forms that have a form not assigned to deal's location
        Map<Id,Boolean> displayFormMap = new Map<Id, Boolean>();
        for(FormRef__c fr : [SELECT Id, Form__c, Location__c FROM FormRef__c WHERE Form__r.dealer__Active__c = true]){
            Boolean display = fr.Location__c == thisDeal.Store_Location__c ? true : false;
            if(displayFormMap.get(fr.Form__c) == null){
                displayFormMap.put(fr.Form__c, display);
            } else {
                if(displayFormMap.get(fr.Form__c) == false && display == true){
                    displayFormMap.put(fr.Form__c, display);
                }
            }
        }
        for(Id frmId :displayFormMap.keySet()){
            if(!displayFormMap.get(frmId)){
                if(!removeItems.contains(frmId)){
                    removeItems.add(frmId);
                }
            }
        }
        
        listLaserForm = [SELECT Id, Name, dealer__Print_Type__c, dealer__DocumentContentId__c, dealer__Page_Name__c, dealer__Flatten__c
            FROM dealer__Form__c
            WHERE(dealer__Print_Type__c =: 'Laser'
                OR dealer__Print_Type__c =: 'FDF')
            AND Id NOT IN: removeItems
            AND dealer__Active__c = true
            ORDER BY dealer__Sequence__c ASC, Name ASC
        ];

        return JSON.serialize(listLaserForm);
    }

    /**
     * buildFormRefQuery 
     * @param  thisDeal  
     * @param  printType 
     * @return String
     * @description
     */
    public static String buildFormRefQuery(Deal__c thisDeal, String printType)
    {
    List < String > removeItems = new List < String > ();
        for (dealer__Deal_Form__c dealF: [SELECT id, Form__c FROM Deal_Form__c where Deal__c =: thisDeal.Id]) {
            removeItems.add(dealF.Form__c);
        }
        for(FormRef__c formRef: [SELECT Id, Deselected__c, Form__c FROM FormRef__c WHERE Deselected__c =: thisDeal.Id]){
            removeItems.add(formRef.Form__c);
        }

        //Query Form_Ref__c for forms that exist in this location
        String query = 'SELECT Location__c, Deselected__c, Applicable__c, Form__c, '
                       +'Form__r.Name, Form__r.Page_Name__c,Form__r.Flatten__c,'
                       +'Form__r.dealer__Print_Type__c, Form__r.Active__c, Form__r.DocumentContentId__c '
                       +'FROM FormRef__c WHERE Location__c = \''+thisDeal.Store_Location__c+'\'  AND Form__r.Active__c = True AND Deselected__c = null';
        // 
        if(removeItems.size() > 0){
            String removeString = '(';
            for(integer i = 0; i < removeItems.size(); i++){
                if(i != removeItems.size() - 1){
                    removeString += ' \''+removeItems[i]+'\', ';
                } else {
                    removeString += ' \''+removeItems[i]+'\' )';
                }
            }
            query+= ' AND Form__c NOT IN '+removeString;
        }

        if(printType == 'Impact'){
            query+= ' AND Form__r.Print_Type__c = \'Impact\'';
        } else {
            query+=' AND (Form__r.Print_Type__c = \'Laser\' OR Form__r.Print_Type__c = \'FDF\') ';
        }
        return query;
    }
    
    /**
     * getApplicableForms 
     * @param  thisDeal 
     * @return String
     * @description
     */
    public String getApplicableForms(Deal__c thisDeal) 
    {
        String dealId = urlParams.get('dealId');
        String printType = urlParams.get('printType');
        //Need to query all fields on object

        String query = buildFormRefQuery(thisDeal, printType);
        List<Form__c> availableForms = new List<Form__c>();
        for(FormRef__c fr : Database.query(query)){
            if(fr.Form__r.Active__c){
                if(fr.Applicable__c == NULL || fr.Applicable__c == 'True'){
                    availableForms.add(fr.Form__r);
                } else {
                    //If there is a formula on the applicable field we need to evaluate it
                    Decimal eval = new EvalExpression(fr.Applicable__c).matching(thisDeal.getpopulatedfieldsasmap()).eval();
                    // '0' = False, '1' = True
                    if(eval == 1)   
                        availableForms.add(fr.Form__r);
                }    
            }
        }
        return JSON.serialize(availableForms);
    }

    /**
     * getApplicableForms 
     * @return String
     * @description
     */ 
    public String getApplicableForms() 
    {
        String dealId = urlParams.get('dealId');
        String printType = urlParams.get('printType');
        //Need to query all fields on object
        Deal__c thisDeal = FormAPI.lookupDeal(dealId);

        String query = buildFormRefQuery(thisDeal, printType);
        List<Form__c> availableForms = new List<Form__c>();
        for(FormRef__c fr : Database.query(query)){
            if(fr.Form__r.Active__c){
                if(fr.Applicable__c == NULL || fr.Applicable__c == 'True'){
                    availableForms.add(fr.Form__r);
                } else {
                    //If there is a formula on the applicable field we need to evaluate it
                    Decimal eval = new EvalExpression(fr.Applicable__c).matching(thisDeal.getpopulatedfieldsasmap()).eval();
                    // '0' = False, '1' = True
                    if(eval == 1)   
                        availableForms.add(fr.Form__r);
                }    
            }
        }
        return JSON.serialize(availableForms);
    }

    /**
     * @description
     */
    public class DealFormWrapper{
        List<Form__c> suggestedForms;
        List<Form__c> allForms;
    }

    /**
     * getImpactForm 
     * @return String
     * @description Get from detail
     */
    public String getImpactForm() 
    {
        List < dealer__Form__c > listImpactForm = new List < dealer__Form__c > ();
        String dealId = urlParams.get('dealId');
        List < dealer__Deal_Form__c > removeImpactForm = [Select id, dealer__Form__c, dealer__Form__r.name, dealer__Form__r.dealer__Print_Type__c
            from dealer__Deal_Form__c where dealer__Form__r.dealer__Print_Type__c =: 'Impact'
            and dealer__Deal__c =: dealId
        ];
        set < Id > removeItems = new set < Id > ();
        for (dealer__Deal_Form__c dealF: removeImpactForm) {
            removeItems.add(dealF.dealer__Form__c);
        }
        listImpactForm = [SELECT Id, name, dealer__Print_Type__c
            FROM dealer__Form__c
            WHERE dealer__Print_Type__c =: 'Impact'
            AND Id NOT IN: removeItems
            AND dealer__Active__c = true
            ORDER BY dealer__Sequence__c ASC, Name ASC
        ];
        return JSON.serialize(listImpactForm);
    }

    /**
     * getSelectedImpactForm 
     * @return String
     * @description Get selected Impact from list
     */
    public String getSelectedImpactForm() 
    {

        List < dealer__Deal_Form__c > listImpactForm = new List < dealer__Deal_Form__c > ();

        String dealId = urlParams.get('dealId');

        listImpactForm = [SELECT id, dealer__Form__c, dealer__Form__r.name, dealer__Form__r.dealer__Print_Type__c
            FROM dealer__Deal_Form__c
            WHERE dealer__Form__r.dealer__Print_Type__c =: 'Impact'
            AND dealer__Deal__c =: dealId
            ORDER BY dealer__Form__r.dealer__Sequence__c ASC, Name ASC
        ];

        return JSON.serialize(listImpactForm);
    }

    /**
     * getSelectedLaserForm 
     * @return String
     * @description Get selected Impact from list
     */
    public String getSelectedLaserForm() 
    {

        List < dealer__Deal_Form__c > listLaserForm = new List < dealer__Deal_Form__c > ();

        String dealId = urlParams.get('dealId');
        listLaserForm = [SELECT id, dealer__Form__r.Name, dealer__Form__c, dealer__Form__r.dealer__Print_Type__c,
            dealer__Form__r.dealer__DocumentContentId__c, dealer__Form__r.dealer__Flatten__c,
            dealer__Form__r.dealer__FDF_Code__c, dealer__Form__r.dealer__Page_Name__c
            FROM dealer__Deal_Form__c
            WHERE(dealer__Form__r.dealer__Print_Type__c =: 'Laser'
                OR dealer__Form__r.dealer__Print_Type__c =: 'FDF')
            AND dealer__Deal__c =: dealId
            ORDER BY dealer__Form__r.dealer__Sequence__c ASC, Name ASC
        ];
        if(listLaserForm.size() > 0)
        return JSON.serialize(listLaserForm);
        return '[]';
    }

    /**
     * getcompiledFDF 
     * @return String
     * @description Retreive FDF Blob
     */
    public String getcompiledFDF() 
    {

        String fid = urlParams.get('fid');
        String did = urlParams.get('did');
        String urlPR = '/apex/dealer__FormFDFData?fid=' + fid + '&did=' + did;

        PageReference p = new PageReference(urlPR);
        Blob uContetent;
        if (Test.isRunningTest()) {
            uContetent = blob.valueof('TEST');
        } else {
            uContetent = p.getContent();
        }

        return uContetent.toString();
    }

    /*** DEAL FROM SALES UP ****/
    
    /**
     * getRecentSalesUps 
     * @return string
     * @description Discount objects read from Database
     */
    public string getRecentSalesUps() 
    {

        List < dealer__Sales_Up__c > sups = null;

        if (String.valueOf(urlParams.get('filter[filters][0][value]')) == null) {

            sups = [SELECT Id, Name, dealer__Desired_Stock_Num__c, dealer__Desired_Stock_Num__r.Name, dealer__Lead_Type__c, dealer__Lead_Date__c FROM dealer__Sales_Up__c Where LastViewedDate != null ORDER BY LastViewedDate DESC limit 10];

        } else {
            String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

            // SOSL Execute
            List < List < sObject >> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Sales_Up__c(Id, Name, dealer__Desired_Stock_Num__c, dealer__Desired_Stock_Num__r.Name, dealer__Lead_Type__c, dealer__Lead_Date__c) LIMIT 50];

            sups = (List < dealer__Sales_Up__c > ) soslResults[0];
        }

        if (sups.size() > 0) {
            return JSON.serializePretty(sups);
        } else {
            // Return Empty array when nothing is returned.
            return '[]';
        }
    }

    /**
     * APPROVAL PROCESS METHODS
     * 
     */

    /**
     * getActiveApproval 
     * @return boolean
     * @description Get Active Approval Process
     */
    public boolean getActiveApproval() 
    {
        boolean isActive = false;

        //Get the list of all Active approval process for Deal Object
        for (ProcessDefinition process: [select id from ProcessDefinition where TableEnumOrId = 'dealer__Deal__c'
                and state = 'Active'
            ]) {
            isActive = true;
            break;
        }

        return isActive;
    }

    /**
     * getApprovalIsLocked 
     * @return string
     * @description Check if Approval process is in Progress
     */
    public string getApprovalIsLocked() 
    {
        //return Approval.isLocked(currentId);
        List < ProcessInstance > lstApproval = [Select Id From ProcessInstance WHERE TargetObjectId =: currentId AND Status = 'Pending'];
        boolean isLocked;
        if (lstApproval != null && lstApproval.size() > 0) {
            isLocked = true;
        } else {
            isLocked = false;
        }
        return '{"isLocked":' + isLocked + '}';
    }

    /**
     * refreshButtonPanels 
     * @return pagereference
     * @description
     */
    public pagereference refreshButtonPanels() 
    {
        return null;
    }

    /**
     * getApprovalHistory 
     * @return String
     * @description 
     */
    public String getApprovalHistory() 
    {
        List < ProcessInstance > lstApproval = new List < ProcessInstance > ();
        Set < Id > setActiveApprovals = new Set < Id > ();
        Map < Id, String > mapSteps = new Map < Id, String > ();

        //Get the list of all Active approval process for Deal Object
        for (ProcessDefinition process: [select id from ProcessDefinition where TableEnumOrId = 'dealer__Deal__c'
                and state = 'Active'
            ]) {
            setActiveApprovals.add(process.Id);
        }

        //Get the steps for respective approval process
        for (ProcessNode node: [select id, name, DeveloperName, ProcessDefinition.Name from processNode where processdefinitionid in: setActiveApprovals]) {
            mapSteps.put(node.id, node.Name);
        }

        lstApproval = [SELECT Id, status, (select id, ActorId, Actor.Name, OriginalActor.Name, createddate, ProcessInstanceId, StepNodeId, StepStatus,
            Comments from steps order by createddate desc), (SELECT Id, ActorId, Actor.Name, OriginalActor.Name, createdDate FROM Workitems) FROM ProcessInstance where targetobjectid =: currentId order by createddate desc];

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();

        for (ProcessInstance process: lstApproval) {
            if (process.status != 'Pending') {
                for (ProcessInstanceStep step: process.steps) {
                    gen.writeStartObject();
                    gen.writeStringField('Id', process.Id);
                    gen.writeStringField('Action', '');
                    gen.writeStringField('AssignedTo', (step.OriginalActor!=null) ? step.OriginalActor.Name : '');
                    gen.writeStringField('ActualApprover', (step.Actor!=null) ? step.Actor.Name : '');
                    gen.writeStringField('CreatedDate', step.CreatedDate.format('MM/dd/yyyy'));
                    gen.writeStringField('CreatedDateTime', step.CreatedDate.format('MM/dd/yyyy hh:mm:ss'));
                    gen.writeStringField('Comments', (step.Comments != null ? step.Comments : ''));
                    gen.writeStringField('StepStatus', (step.StepStatus == 'Started' ? 'Submitted' : step.StepStatus));
                    gen.writeStringField('OverallStatus', (step.StepStatus == 'Started' || step.StepStatus == 'Removed'? '' : step.StepStatus));
                    gen.writeStringField('StepName', (mapSteps.get(step.StepNodeId) != null ? mapSteps.get(step.StepNodeId) : (step.StepStatus == 'Started' ? 'Request Submitted' : '')));
                    gen.writeStringField('Step', (mapSteps.get(step.StepNodeId) != null ? step.CreatedDate.format('MM/dd/yyyy hh:mm:ss') + ' - ' + mapSteps.get(step.StepNodeId) : (step.StepStatus == 'Started' ? step.CreatedDate.format('MM/dd/yyyy hh:mm:ss') + ' - Request Submitted' : '')));
                    gen.writeEndObject();
                }
            } else if (process.steps.size() > 0) {
                for (ProcessInstanceWorkitem item: process.Workitems) {
                    gen.writeStartObject();

                    gen.writeStringField('Id', process.Id);
                    gen.writeStringField('ItemId', item.Id);
                    gen.writeStringField('ActorId', item.ActorId);
                    gen.writeStringField('Action', URL.getSalesforceBaseUrl().toExternalForm() + '/p/process/ProcessInstanceWorkitemWizardStageManager?id=' + item.id);
                    gen.writeStringField('Reassign', URL.getSalesforceBaseUrl().toExternalForm() + '/' + item.id + '/e?et=REASSIGN');
                    String originalActor = item.Actor != null ? item.OriginalActor.Name : '';
                    gen.writeStringField('AssignedTo', originalActor);
                    String actor = item.Actor != null ? item.Actor.Name : '';
                    gen.writeStringField('ActualApprover', actor);
                    gen.writeStringField('CreatedDate', item.CreatedDate.format('MM/dd/yyyy'));
                    gen.writeStringField('CreatedDateTime', item.CreatedDate.format('MM/dd/yyyy hh:mm:ss'));
                    gen.writeStringField('Comments', '');
                    gen.writeStringField('StepStatus', 'Pending');
                    gen.writeStringField('OverallStatus', 'Pending');
                    gen.writeStringField('StepName', (mapSteps.get(process.steps[0].StepNodeId) != null ? mapSteps.get(process.steps[0].StepNodeId) : ''));
                    gen.writeStringField('Step', (mapSteps.get(process.steps[0].StepNodeId) != null ? mapSteps.get(process.steps[0].StepNodeId) + ' - ' + item.CreatedDate.format('MM/dd/yyyy hh:mm:ss') : item.CreatedDate.format('MM/dd/yyyy hh:mm:ss') + ' - Pending for approval'));
                    gen.writeEndObject();

                }
            }
        }

        gen.writeEndArray();
        return gen.getAsString();
        //return JSON.serialize(lstApproval);
    }

    /**
     * getSubmitApproval 
     * @return String
     * @description
     */
    public String getSubmitApproval() 
    {
        		
        List<ProcessDefinition> approvalProcessList = [Select id, DeveloperName 
                                                       	from ProcessDefinition where TableEnumOrId = 'dealer__Deal__c' and state = 'Active']; 
        
        // Create an approval request for the Deal
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(currentId);
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(UserInfo.getUserId());
        Approval.ProcessResult result;
        
        if(!approvalProcessList.isEmpty()){
                
        	for (Integer count = 0; count < approvalProcessList.size(); count++){
                
				system.debug('approvalProcess name ' + approvalProcessList[count].DeveloperName + ' count ' + count);
                req1.setProcessDefinitionNameOrId(approvalProcessList[count].DeveloperName);
				
                // Submit the approval request 
                try{
                    result = Approval.process(req1);
                    if(result.isSuccess()) { break; }
                }catch(Exception e){
                    Integer tempCount = count+1;
                    if(tempCount == approvalProcessList.size() && !Test.isRunningTest()){
                        throw new DealTRSControllerException('No applicable approval process was found.');
                    }
                } 
        	}
        }
        return Json.serialize(result);
    }

    /**
     * recallApprovalProcess 
     * @return pagereference
     * @description
     */
    public pagereference recallApprovalProcess() 
    {
        return new PageReference('/' + processInstanceId + '/e?et=REMOVE&retURL=/apex/DealView?id=' + currentId + '#!delivery');
    }

    /**
     * UTILITY METHODS
     *
     */
    
    /**
     * getRecordIds 
     * @return string
     * @description method to concatenate ids of search results
     */
    @testVisible
    private string getRecordIds(List < SObject > sObjectList) 
    {
        string ids = '';
        integer i = 0;
        for (SObject nextObj: sObjectList) {
            i = i + 1;

            if (i == 1)
                ids = '\'' + nextObj.id + '\'';
            else
                ids = ids + ',\'' + nextObj.id + '\'';
        }
        return ids;
    }

    /**
     * getFilters 
     * @return string
     * @description
     */
    public string getFilters() 
    {
        Map < string, string > filterMap = getFilterMap();
        string filters = '';
        string val = '';
        for (string key: filterMap.keySet()) {
            val = filterMap.get(key);
            if (key == 'Name' && val.length() > 1) {
                //searchQuery = val;
                filters += ' and (Name like \'%' + val + '%\' or dealer__Description__c like \'%' + val + '%\')';
            } else
                filters += ' and ' + key + '=\'' + val + '\'';
        }
        return filters;
    }

    /**
     * getFilterMap 
     * @return Map < string, string >
     * @description
     */
    public Map < string, string > getFilterMap() 
    {
        Map < string, string > filterMap = new Map < string, string > ();
        for (Integer i = 0; i < 4; i++) {
            string key = 'filter[filters][' + i + '][field]';
            string value = 'filter[filters][' + i + '][value]';
            if (urlParams.containsKey(key)) {
                filterMap.put(urlParams.get(key), urlParams.get(value));
            } else {
                break;
            }
        }
        return filterMap;
    }

    /**
     * getValue 
     * @param  value 
     * @param  type
     * @return string
     * @description Get/POST variable cleaning
     */
    public string getValue(string value, string type) 
    {
        string defaultValue = (type == 'string') ? '' : '0';
        if (value != null) {
            if (value.trim() != '')
                return value;
            else
                return defaultValue;
        } else

            return defaultValue;
    }

    /**************** W-000901 begins*********************/

    /**
     * getAccountsForNewDeal 
     * @return string
     * @description To read accounts for creating new deal
     */
    public string getAccountsForNewDeal() 
    {
        // Get URL Parameters and SOSL
        List < Account > cResults = new List < Account > ();
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));
        string fieldName = string.valueOf(urlParams.get('filter[filters][0][field]'));

        Boolean isPerson = (fieldName == 'FirstName' || fieldName == 'LastName');

        if (searchAsk == null || searchAsk == '' || searchAsk.length() < 2) {
            return JSON.serializePretty(cResults);
        }



        List < List < sObject >> soslResults = new List < List < sObject >> ();

        // SOSL Execute


        soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING Account(Id, Name, FirstName, LastName, PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState,
            PersonMailingPostalCode, IsPersonAccount, Phone,   BillingCountry,
            BillingStreet, BillingCity, BillingState, BillingPostalCode, dealer__Tax_ID__c, dealer__Billing_Email__c,
            dealer__Drivers_License_Expiration_Date__pc, dealer__Drivers_License_Number__pc, dealer__Drivers_License_State__pc where IsPersonAccount =: isPerson) LIMIT 50];

        cResults = (List < Account > ) soslResults[0];

        return JSON.serializePretty(cResults);
    }

    /**
     * createSalesUp 
     * @return String
     * @description
     */
    public String createSalesUp() 
    {
        Savepoint sp;
        try {
            sp = Database.setSavepoint();
            Account objAccount = new Account();
            RecordType objRecPerson = [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Account'
                AND IsPersonType = true limit 1
            ];
            RecordType objRecBusiness = [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Account'
                AND IsPersonType = false limit 1
            ];
            if (urlParams.get('Id') != null && urlParams.get('Id') != '') {
                objAccount.Id = String.valueOf(urlParams.get('Id'));
                if (urlParams.get('IsPersonAccount') == 'true') {
                    if (urlParams.get('PersonMobilePhone') != null) {
                        objAccount.PersonMobilePhone = String.valueOf(urlParams.get('PersonMobilePhone'));
                    }
                    if (urlParams.get('PersonEmail') != null) {
                        objAccount.PersonEmail = String.valueOf(urlParams.get('PersonEmail'));
                    }
                    if (urlParams.get('FirstName') != null) {
                        objAccount.FirstName = String.valueOf(urlParams.get('FirstName'));
                    }
                    if (urlParams.get('LastName') != null) {
                        objAccount.LastName = String.valueOf(urlParams.get('LastName'));
                    }
                    if (urlParams.get('MiddleName') != null) {
                        objAccount.MiddleName = String.valueOf(urlParams.get('MiddleName'));
                    }
                } else if (urlParams.get('IsPersonAccount') == 'false') {
                    if (urlParams.get('PersonEmail') != null) {
                        objAccount.dealer__Billing_Email__c = String.valueOf(urlParams.get('PersonEmail'));
                    }
                    if (urlParams.get('Name') != null) {
                        objAccount.Name = String.valueOf(urlParams.get('Name'));
                    }

                }
            } else {
                //if(objRec.Id != null)
                if (urlParams.get('Name') != null && urlParams.get('Name') != '') {
                    if (objRecBusiness.Id != null) {
                        objAccount.RecordTypeId = objRecBusiness.Id;
                    }
                    if (urlParams.get('PersonEmail') != null) {
                        objAccount.dealer__Billing_Email__c = String.valueOf(urlParams.get('PersonEmail'));
                    }
                    if (urlParams.get('Name') != null) {
                        objAccount.Name = String.valueOf(urlParams.get('Name'));
                    }
                } else {
                    if (objRecPerson.Id != null) {
                        objAccount.RecordTypeId = objRecPerson.Id;
                    }
                    if (urlParams.get('PersonMobilePhone') != null) {
                        objAccount.PersonMobilePhone = String.valueOf(urlParams.get('PersonMobilePhone'));
                    }
                    if (urlParams.get('PersonEmail') != null) {
                        objAccount.PersonEmail = String.valueOf(urlParams.get('PersonEmail'));
                    }
                    if (urlParams.get('FirstName') != null) {
                        objAccount.FirstName = String.valueOf(urlParams.get('FirstName'));
                    }
                    if (urlParams.get('LastName') != null) {
                        objAccount.LastName = String.valueOf(urlParams.get('LastName'));
                    }
                    if (urlParams.get('MiddleName') != null) {
                        objAccount.MiddleName = String.valueOf(urlParams.get('MiddleName'));
                    }
                }
            }
            if (urlParams.get('Phone') != null) {
                objAccount.Phone = String.valueOf(urlParams.get('Phone'));
            }
            System.debug('Account>>>>>' + objAccount);
            upsert objAccount;

            dealer__Vehicle_Inventory__c objVehicle;
            if (urlParams.get('vehicleId') != null && urlParams.get('vehicleId') != '') {
                String vehId = String.valueOf(urlParams.get('vehicleId'));
                objVehicle = [SELECT Id, Name FROM dealer__Vehicle_Inventory__c where Id =: vehId Limit 1];
            }
            System.debug('Vehicle>>>>>' + objVehicle);
            //dealer__Sales_Up__c salesup;
            if (objAccount.Id != null) {
                salesup = new dealer__Sales_Up__c();
                salesup.dealer__Customer_Account__c = objAccount.Id;
                if (objVehicle != null) {
                    salesup.dealer__Desired_Stock_Num__c = objVehicle.Id;
                }

                salesup.dealer__Lead_Date__c = Date.TODAY();
                salesup.dealer__Lead_Status__c = 'Open';
                if(urlParams.get('LeadSource') != null){
                    salesup.dealer__Source__c = urlParams.get('LeadSource');
                }
                if(urlParams.get('LeadType') != null){
                    salesup.dealer__Lead_Type__c = urlParams.get('LeadType');
                }
                salesup.dealer__Salesperson_1__c = UserInfo.getUserId();
            }
            System.debug('SalesUp>>>>>' + salesup);
            insert salesup;

            if (salesup.Id != null) {
                // Get Sales Up Data and Link to Deal
                dealRecord = new dealer__Deal__c();
                ApexPages.currentPage().getParameters().put('salesup', salesup.Id);
                Sup2Deal objSup2Deal = new Sup2Deal(new ApexPages.StandardController(salesup));
                objSup2Deal.buildDealFromSalesUp();
                dealRecord = objSup2Deal.deal;

            }

            //if(dealRecord.dealer__Stock_Number__c == null) {
            //    //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Stock Number is Required');
            //    return '{"Error":"Stock Number is Required"}';        
            //}

            /*  Generate next number */
            if (dealRecord.Id == null) {

                List < dealer__deal__c > listDeal = new List < dealer__deal__c > ();
                Integer dealNo;

                //Get the deal number from Custom Settings

                if (Test.isRunningTest()) {
                    dealNo = 50;
                } else {
                    dealNo = dealer.Utility.nextDealNumber();
                }

                dealRecord.dealer__Deal_ID__c = String.valueOf(dealNo);
                dealRecord.Name = String.valueOf(dealNo);

                System.debug('the value is' + dealRecord);

                /*Begin W-000528  -- dr1 --*/

                Database.UpsertResult results = Database.upsert(dealRecord, true);
                if(salesup.Id != null){
                    dealer__Sales_Up__c sup =[SELECT Id, dealer__Car_Deal__c FROM dealer__Sales_Up__c WHERE Id=:salesup.Id]; 
                    if(sup.dealer__Car_Deal__c == null){
                        sup.dealer__Car_Deal__c = dealRecord.Id;
                        update sup;
                    }
                }

                List < dealer__Deal__c > deals = new List < dealer__Deal__c > ();
                deals.add(dealRecord);

            }
            return JSON.serializePretty(dealRecord);

            //return new PageReference('/apex/dealer__SalesUpNewDeal?salesup='+objSalesUp.Id);
            /*PageReference dealPage = new PageReference('/apex/dealer__SalesUpNewDeal?salesup='+objSalesUp.Id);
            dealPage.setRedirect(true);
            return dealPage;*/
        } catch (DmlException e) {
            Database.rollback(sp);
            //throw new mobException('Error creating Sales Up: ' + e.getMessage() );
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';

        } catch (Exception ex) {
            Database.rollback(sp);
            return '{"error":"' + ex.getMessage() + ',' + ex.getStackTraceString() + ' LINE: ' + ex.getLineNumber() + '"}';
        }
    }

    /**
     * createFee 
     * @return String
     * @description
     */
    public String createFee() 
    {
        if (currentId == null) {
            return '{"error":"A proper Deal Id was not submitted with the create request."}';
        }
        Map<String,dealer__Sales_Fee__c> feesOnDeal = new Map<String,dealer__Sales_Fee__c>();
        for(dealer__Sales_Fee__c ef : [SELECT Id, dealer__Fee_Name__c FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c =:currentId]){
            if(feesOnDeal.get(ef.dealer__Fee_Name__c) == null){
                feesOnDeal.put(ef.dealer__Fee_Name__c,ef);
            }
        }

        dealer__Sales_Fee__c fee = new dealer__Sales_Fee__c();
        if (urlParams.get('dealer__Fee_Name__c[Name]') != null && urlParams.get('dealer__Fee_Name__c[Name]') != ''){
            fee.dealer__Fee_Name__c = String.valueOf(urlParams.get('dealer__Fee_Name__c[Name]'));
            if(feesOnDeal.get(fee.dealer__Fee_Name__c) != null){
                return null;
            }
        }

        if (urlParams.get('dealer__Fee_Amount__c') != null && urlParams.get('dealer__Fee_Amount__c') != '')
            fee.dealer__Fee_Amount__c = Decimal.valueOf(urlParams.get('dealer__Fee_Amount__c'));

        if (urlParams.get('dealer__Discount__c') != null && urlParams.get('dealer__Discount__c') != '')
            fee.dealer__Discount__c = Decimal.valueOf(urlParams.get('dealer__Discount__c'));

        if (urlParams.get('dealer__Description__c') != null && urlParams.get('dealer__Description__c') != '')
            fee.dealer__Description__c = String.valueOf(urlParams.get('dealer__Description__c'));

         if (urlParams.get('dealer__Fee_Code__c') != null && urlParams.get('dealer__Fee_Code__c') != '')
            fee.dealer__Fee_Code__c = String.valueOf(urlParams.get('dealer__Fee_Code__c'));
        
         if (urlParams.get('dealer__Taxable__c') != null && urlParams.get('dealer__Taxable__c') != '')
            fee.dealer__Taxable__c = urlParams.get('dealer__Taxable__c') == 'true' ?true:false;

        //FEE DEFAULT FORMULA
        String fieldToCheck;
        if (urlParams.get('dealer__Default_Amount_Formula_Field__c') != null && urlParams.get('dealer__Default_Amount_Formula_Field__c') != ''){
           //fee.dealer__Default_Amount_Formula_Field__c = String.valueOf(urlParams.get('dealer__Default_Amount_Formula_Field__c'));
           fieldToCheck = String.valueOf(urlParams.get('dealer__Default_Amount_Formula_Field__c')).toLowerCase();//temp change after-logic to fee.dealer__Default_Amount_Formula_Field__c
        } else {
            system.debug('does not contain '+fieldToCheck);
        }  

        //If forumla field exists on fee object - > set the total to the formula field's value.
        Set<String> dealFields = Schema.SObjectType.dealer__Deal__c.fields.getMap().keySet();
        if(dealFields.contains(fieldToCheck)) {
           String query = 'SELECT '+fieldToCheck+' FROM dealer__Deal__c WHERE Id = \''+currentId+'\'';
            dealer__Deal__c deal = Database.query(query);
            if(deal.get(fieldToCheck) != null){
                fee.dealer__Fee_Amount__c = (Decimal)deal.get(fieldToCheck);
            }
        }   

        try {
            if (fee != null) {
                fee.dealer__Car_Deal__c = currentId;
                insert fee;
                return JSON.serialize(fee);
            } else {
                return '[]';
            }
        } catch (DmlException e) {
            return '{"error":"t2' + e.getMessage() + '"}';
        }
    }

    /**
     * getDealFees 
     * @return String
     * @description
     */
    public String getDealFees() 
    {
        List < dealer__Sales_Fee__c > fees = [SELECT Id, dealer__Discount__c, dealer__Description__c, dealer__Fee_Amount__c, dealer__Fee_Name__c, dealer__Sequence_Number__c, dealer__Fee_code__c, dealer__Default_Amount_Formula_Field__c, dealer__Taxable__c, dealer__Type__c FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c =: this.currentId];
        if (fees.size() > 0) {
            return JSON.serialize(fees);
        }
        return '[]';
    }

    /**
     * getFeeTemplates 
     * @return String
     * @description
     */
    public String getFeeTemplates() 
    {

        Id locId = [SELECT dealer__Store_Location__c FROM dealer__Deal__c WHERE Id =:currentId].dealer__Store_Location__c;
        dealer__Dealer_Location__c loc = [SELECT dealer__Deal_Fees__c FROM dealer__Dealer_Location__c WHERE Id =: locId];

        List < dealer.DealerShipLocationAPI.Fee > feeList =
            (List < dealer.DealerShipLocationAPI.Fee > ) JSON.Deserialize(loc.dealer__Deal_Fees__c, List < dealer.DealerShipLocationAPI.Fee > .class);
            //can possibly manually unparse and recreate json here to return subtracting fees that already exist.
        if (feeList.size() > 0) {
            return loc.dealer__Deal_Fees__c;
        } else {
            return '[]';
        }
    }

    /**
     * updateFee 
     * @return Sting
     * @description
     */
    public String updateFee() 
    {
        if (currentId == null) {
            return '{"error":"A proper Deal Id was not submitted with the create request."}';
        }
        system.debug('FEE ID ');
        dealer__Sales_Fee__c fee = new dealer__Sales_Fee__c();
        if (urlParams.get('Id') != null && urlParams.get('Id') != '')
            fee.Id = String.valueOf(urlParams.get('Id'));
        
        if(fee.Id != null){
            if (urlParams.get('dealer__Fee_Name__c[Name]') != null && urlParams.get('dealer__Fee_Name__c[Name]') != '')
            fee.dealer__Fee_Name__c = String.valueOf(urlParams.get('dealer__Fee_Name__c[Name]'));

            if (urlParams.get('dealer__Fee_Amount__c') != null && urlParams.get('dealer__Fee_Amount__c') != '')
                fee.dealer__Fee_Amount__c = Decimal.valueOf(urlParams.get('dealer__Fee_Amount__c'));

            if (urlParams.get('dealer__Discount__c') != null && urlParams.get('dealer__Discount__c') != '')
                fee.dealer__Discount__c = Decimal.valueOf(urlParams.get('dealer__Discount__c'));

            if (urlParams.get('dealer__Description__c') != null && urlParams.get('dealer__Description__c') != '')
                fee.dealer__Description__c = String.valueOf(urlParams.get('dealer__Description__c'));

            if(urlParams.get('dealer__Fee_Code__c') != null && urlParams.get('dealer__Fee_Code__c') != '')
                fee.dealer__Fee_Code__c = String.valueOf(urlParams.get('dealer__Fee_Code__c'));

            if (urlParams.get('dealer__Taxable__c') != null && urlParams.get('dealer__Taxable__c') != ''){
                fee.dealer__Taxable__c = urlParams.get('dealer__Taxable__c') == 'true' ?true:false;
            }
        }  
        try {
            if (fee != null) {
                system.debug('fee '+fee);
                update fee;
                updateDealFeeTotal(currentId);
                dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',currentId));
                return JSON.serialize(fee);
            } else {
                return '[]';
            }
        } catch (DmlException e) {
            return '{"error":"t2' + e.getMessage() + '"}';
        }
    }
    
    /**
     * refreshDefaultFees 
     * @param  dealId
     * @return void
     * @description
     */
    @RemoteAction
    public static void refreshDefaultFees(Id dealId)
    {
        
        //Ensure all deal fields are queried and values stored in memory.
        SObjectType objectType = Schema.getGlobalDescribe().get('dealer__Deal__c');
        List<SobjectField> fieldList = objectType.getDescribe().fields.getMap().values();
        
        List<String> fieldsToQuery = new List<String>();
        for(SobjectField s : objectType.getDescribe().fields.getMap().values()){
            fieldsToQuery.add(String.valueOf(s));
        }
        String query = 'SELECT '+String.join(fieldsToQuery,',')+' FROM dealer__Deal__c WHERE Id = \''+dealId+'\'';
        
        if(dealId != null){
            dealer.DealAPI.createDefaultFees(database.query(query));
            dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
        }
    }
    
    /**
     * updateDealFeeTotal 
     * @param  dealId 
     * @return void
     * @description
     */ 
    public void updateDealFeeTotal(Id dealId)
    {
        AggregateResult[] groupedResults
            = [SELECT SUM(dealer__Fee_Amount__c)sum, SUM(dealer__Discount__c)discount FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c = : dealId];
        dealer__Deal__c deal = new dealer__Deal__c();
        deal.Id = dealId;
        Double discount = groupedResults[0].get('discount') != null ? (Double)groupedResults[0].get('discount') : 0;
        deal.dealer__total_Fees__c = groupedResults[0].get('sum') != null ? (Double)groupedResults[0].get('sum') - discount : 0;
        update deal;
    }   
    
    /**
     * destroyFee 
     * @return String
     * @description
     */
    public String destroyFee() 
    {
        String dealId = urlParams.get('dealId');
        System.assert(ApexPages.currentPage().getParameters().get('Id')!=null, 'Trying to delete an Invalid Fee');
        dealer__Sales_Fee__c fee = new dealer__Sales_Fee__c();
        fee.Id = Id.valueOf(ApexPages.currentPage().getParameters().get('Id'));
        try {
            delete fee;
            dealAPI.applyDiscounts((Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId));
            return '[]';
        } catch (DmlException e) {
            return '{"error":"' + e.getMessage() + ',' + e.getStackTraceString() + ' LINE: ' + e.getLineNumber() + '"}';
        }
    }
    // Fees End

    /**
     * setasPrimaryDeal 
     * @param  dealId 
     * @return boolean
     * @description
     */
    @RemoteAction
    public static boolean setasPrimaryDeal(String dealId) 
    {

        dealer__Deal__c deal = [SELECT Id, dealer__Sales_Lead__c FROM dealer__Deal__c WHERE Id =: dealId LIMIT 1];
        dealer__Sales_Up__c sup = [SELECT Id, Name, dealer__Car_Deal__c FROM dealer__Sales_Up__c WHERE Id =: deal.dealer__Sales_Lead__c LIMIT 1];
        try {
            sup.dealer__Car_Deal__c = deal.Id;
            update sup;
        }
        Catch(DmlException e) {
            throw new DealTRSControllerException(e.getMessage());
        }

        return true;
    }

    /**
     * getPricingStrategy 
     * @return String
     * @description
     */
    public String getPricingStrategy() 
    {
        List <dealer__Parts_Service_Pricing_Strategy__c> listPS = new List <dealer__Parts_Service_Pricing_Strategy__c> ();
        String searchAsk = String.valueOf(urlParams.get('filter[filters][0][value]'));

        // First Lookup
        if (searchAsk == null) {

            listPS = [SELECT Id, Name, dealer__Active__c, dealer__Parts_Forumula_Base__c, dealer__Description__c, dealer__Company_Number__c, dealer__Default__c, dealer__Description_Formula__c, 
                            dealer__Formula_Operand__c, dealer__Method__c, dealer__Minimum_Parts_Gross_Proft__c, dealer__Order__c, OwnerId, dealer__Parts_Variable_Amount__c FROM dealer__Parts_Service_Pricing_Strategy__c WHERE dealer__Active__c = true LIMIT 50];

        } else {

            // SOSL Execute
            List <List<sObject>> soslResults = [FIND: searchAsk IN ALL FIELDS RETURNING dealer__Parts_Service_Pricing_Strategy__c(Id, Name, dealer__Active__c, dealer__Parts_Forumula_Base__c, dealer__Description__c, dealer__Company_Number__c, dealer__Default__c, dealer__Description_Formula__c, 
                                                    dealer__Formula_Operand__c, dealer__Method__c, dealer__Minimum_Parts_Gross_Proft__c, dealer__Order__c, OwnerId, dealer__Parts_Variable_Amount__c WHERE dealer__Active__c = true) LIMIT 50];

            listPS = (List<dealer__Parts_Service_Pricing_Strategy__c> ) soslResults[0];

        }

        return JSON.serializePretty(listPS);
    }

    /**
     * getSchedulePricing 
     * @return Boolean
     * @description
     */
    public Boolean getSchedulePricing()
    {
        Deal__c [] scheduleDeal = [SELECT Id, PricingStrategy__c, PricingStrategy__r.Method__c FROM Deal__c WHERE Id =: currentId];
        return scheduleDeal.size() > 0 && scheduleDeal[0].PricingStrategy__c != null && scheduleDeal[0].PricingStrategy__r.Method__c == 'Schedule' ? true : false;
    }

    /**
     * @descripton
     */
    public class DealTRSControllerException extends Exception {}
}