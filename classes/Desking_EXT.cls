/**
 * Desking Controller
 */

/**
 * 2016-06-23   |Jarrett Kuljis |
 * Cleanup of the code that was incorrectly introduced via external developers
 *
 * 2016-06-30   |Jarrett Kuljis |W-000373
 * Stock-in of trade vehicles was transposing Make/Model

 * 2016-08-04   |Sneha Utture   |Case1964
 * Update Buyer Account with Buyer Contact if its a person account

 */
public class Desking_EXT {

    public dealer__Deal__c deal {get;set;}
    public list<dealer__DMS_Settings__c> dealDefaults = dealer__DMS_Settings__c.getall().values();
    public dealer__SalesDeskLogSettings__c config {get;set;}
    public Contact buyer;
    public Contact cobuyer;
    public String dealTitle;
    public String lender;
    public String tradeInJSON {get;set;}
    public String tradeInJSONData {get;set;}
    public dealer__Vehicle_Inventory__c vehicle {get;set;}
    // public dealFees fees {get;set;}
    public String formId {get;set;}
    public String kitMFG {get;set;}
    public String kitNumber {get;set;}
    public String kitDescription {get;set;}
    public List<dealer__Parts_Kit__c> kitList {get;set;}
    public String kitResultSize {get;set;}
    public dealer__Deal__c dealFormObject;
    public List<FormsWrapper> listFormWrap{get;set;}
    public String jsonDataToInsert {get; set; }
    public String dmsDealStatus{get;set;} //KVP used to hold DMS setting deal status value
    public String selectedPartNumber{get;set;} 

    // Boolean values to render the pencil and calculator symbol on deal screen (added by kvp)
    public Boolean iswarrPrem   {get;set;} 
    public Boolean isMainPrem   {get;set;} 
    public Boolean isGAPPrem    {get;set;} 
    public Boolean isOtherPrem  {get;set;}  
    //public static dealer__Trade_In__c tradeInToUpdate{get;set;}
    public dealer__Vehicle_Inventory__c vehicleInventory{get;set;}
    public list<dealer__Vehicle_Inventory__c> inventoryVehicleList{get;set;}
    List<dealer__Appraisal_Vehicle__c> appraisalVehList;
    public Map<String, dealer__Trade_In__c> vinToTradeMap;// = new Map<String, dealer__Trade_In__c>();
    public Map<String, dealer__Deal_Status_Map_Setting__c> dealStatus;// = dealer__SalesUp_Status_Settings__c.getall();
    
    public String baseURL { get { return System.URL.getSalesforceBaseUrl().toExternalForm(); } }
    public String baseURLNonManaged { get { return System.URL.getSalesforceBaseUrl().toExternalForm().replace('dealer.', 'c.'); } }
    
    public dealer__We_Owe__c weOwe {get; set; }
    
    public String escDescription {get;set;}
    public String escCode {get;set;}
    public String escType {get;set;}
    public List<dealer__Service_Contract__c> escResults {get;set;}
    
    public String deleteProductId {get;set;}
    public String selectedContractType {get; set;}
    public String escSelectedId {get;set;}
    public Double gapRollupValue{get; set;}

    // Trade 1-3 Support
    public dealer__Sales_up__c td1{get;set;}        
    public dealer__Sales_up__c td2{get;set;}      
    public dealer__Sales_up__c td3{get;set;}
    
    public String seletedTabId{get;set;} //Used to hold the current tab id to redirect (initializing from VF page as param)
    
    public List<dealer__Service_Contract__c> soldOnProposal {
        get {
            if(deal.Id!=null) {
                return [SELECT dealer__Contract_Template__c, dealer__Cost__c, dealer__Gross__c, 
                                            dealer__Customer_Contact__c, dealer__Customer__c, dealer__Deductable__c, dealer__Description__c, 
                                            dealer__End_Date__c, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c,
                                            dealer__Plan_Code__c, dealer__Product_Code__c, dealer__Sale_Price__c, dealer__Service_Vehicle__c, 
                                            dealer__Start_Date__c, dealer__Vehicle_Inventory__c, dealer__Type__c, Name, Id 
                                            FROM dealer__Service_Contract__c 
                                            Where dealer__Car_Deal__c =: deal.Id
                                            Limit 100];             
            } else {
                return new List<dealer__Service_Contract__c>();
            }
        }
        set;
    }
     
    public List<dealer__Form__c> forms { get { return [Select Id, dealer__Active__c, 
                                                       dealer__Revision_Date__c, dealer__Sequence__c, 
                                                       dealer__Library__c, dealer__Page_Name__c, dealer__Proofed_by__c, dealer__Form_ID__c, dealer__Print_Type__c, CreatedDate, dealer__DocumentContentId__c, dealer__Flatten__c,
                                                       Name
                                                       FROM dealer__Form__c 
                                                       WHERE dealer__Active__c = true 
                                                       ORDER BY dealer__Sequence__c ASC
                                                       LIMIT 1000]; } }
    
    public List<dealer__Service_Contract__c> avaialbleContracts { get { return [SELECT dealer__Cost__c, dealer__Deductable__c, dealer__Description__c, dealer__End_Date__c, dealer__Expiration_Mileage__c, 
                                                                                dealer__Expiration_Months__c, dealer__Odometer_at_Sale__c, dealer__Plan_Code__c, dealer__Product_Code__c, dealer__Sale_Price__c, 
                                                                                dealer__Service_Vehicle__c, dealer__Start_Date__c, dealer__Vehicle_Inventory__c, dealer__Customer__c, dealer__Customer_Contact__c,
                                                                                dealer__Company_Number__c, dealer__Contract_Template__c, CreatedDate, Id, Name 
                                                                                FROM dealer__Service_Contract__c
                                                                               Where dealer__Contract_Template__c = true
                                                                               limit 1000]; }}

    public List<dealer__Deal_Payment__c> dealPayments { get {       if(deal != new dealer__Deal__c()) {
                                                                    return [Select Id, Name, dealer__Amount__c, dealer__Car_Deal__c, dealer__Due_Date__c, dealer__Notes__c, dealer__Received__c,
                                                                        dealer__Reference__c
                                                                        from dealer__Deal_Payment__c
                                                                        where dealer__Car_Deal__c =:deal.Id 
                                                                        limit 500];
                                                                        } else {
                                                                            return new List<dealer__Deal_Payment__c>();
                                                                        }
                                                            }
                                                     }                                                                           
    public List<SelectOption> getFinanceCompanies() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        for(dealer__Finance_Company__c f : [Select Id, Name from dealer__Finance_Company__c where dealer__Active__c = true order by dealer__Screen_Order__c ASC]) {
            options.add(new SelectOption(f.Id, f.Name));
        }
        return options;
    }

    public String trades { get {
                                List<dealer__Trade_In__c> tradelist = [SELECT Id, dealer__Service_Vehicle__c, dealer__Car_Deal__c, dealer__ACV__c, dealer__Odometer_at_Trade_In__c,
                                                                        dealer__Pay_Off_Account__c, dealer__Pay_Off_Account__r.Name, 
                                                                        dealer__Pay_Off_Amount__c, dealer__Pay_Off_Expiration_Date__c, dealer__Pay_Off_To__c, 
                                                                        dealer__Stock_Number__c, dealer__Trade_Allowance__c, dealer__VIN__c, dealer__Appraised_By__c, 
                                                                        dealer__Appraisal_Date__c, dealer__K_B_B_Wholesale_Value__c, dealer__K_B_B_Retail__c, 
                                                                        dealer__Black_Book_Wholesale__c, dealer__Black_Book_Retail__c, dealer__NADA_Wholesale__c, 
                                                                        dealer__NADA_Retail__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Lost_Trade__c, 
                                                                        dealer__Position__c, dealer__Inventory_Vehicle__c, dealer__Inventory_Vehicle__r.Name
                                                                        FROM dealer__Trade_In__c
                                                                        where dealer__Car_Deal__c =:deal.Id
                                                                        order by dealer__Position__c ASC
                                                                        limit 3];
                                    System.debug('-------tradelist--------'+tradelist);
                                    System.debug('-------JSON.serialize(tradelist)--------'+JSON.serialize(tradelist));
                                    return JSON.serialize(tradelist);                                                                     
                             }
                         }

    public String aftermarket { get { 
                                        List<dealer__After_Market__c> aftermarketList = [SELECT dealer__Car_Deal__c, dealer__Cost__c, dealer__Description__c, 
                                                                                            dealer__Sale_Price__c, dealer__List_Price__c, dealer__Vendor__c, 
                                                                                            dealer__Company_Number__c, dealer__Parts_Kit__c, dealer__Labor_Sale__c, 
                                                                                            dealer__Parts_Sale__c, Id 
                                                                                        FROM dealer__After_Market__c
                                                                                        Where dealer__Car_Deal__c =:deal.Id AND dealer__Car_Deal__c != null
                                                                                        Limit 100];
                                        return JSON.serialize(aftermarketList);
                                    }
                                }

    public String feedata { get {
                                        List<dealer__Sales_Fee__c> feeList = [Select Id, dealer__Car_Deal__c, dealer__Fee_Amount__c, dealer__Fee_Name__c 
                                                                                from dealer__Sales_Fee__c
                                                                                where dealer__Car_Deal__c =:deal.Id
                                                                                limit 100];
                                        return JSON.serialize(feeList); 
    }}                                                 
    
    public String getLender() {
        return lender;
    }
    
    public void setLender(String lender) {
        
    }
    
    public Desking_EXT(ApexPages.StandardController stdController){
        
        
        // Declare Empty instances of SalesUp for Trade-In Customer Reference
        td1 = new dealer__Sales_Up__c();
        td2 = new dealer__Sales_Up__c();
        td3 = new dealer__Sales_Up__c();

        gapRollupValue = 0;
        
        dmsDealStatus = !dealDefaults.isEmpty() ? dealDefaults[0].dealer__Deal_status_for_inventory__c : null;
        inventoryVehicleList = new list<dealer__Vehicle_Inventory__c>(); 
        appraisalVehList = new List<dealer__Appraisal_Vehicle__c>();
        //Kumar changes starts here
        listFormWrap = new List<FormsWrapper>();
        
        for(dealer__Form__c objForm: forms){
            listFormWrap.add(new FormsWrapper(objForm));
        }
        //Kumar changes ends here

        /* Get all of the fields to the controller for inclusion */
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Deal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            stdController.addFields(af);
        }   

        // Load Application Cache
        config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        dealStatus = dealer__Deal_Status_Map_Setting__c.getall();
        // Load the record from the database
        this.deal = (dealer__Deal__c)stdController.getRecord();
        
        // If we are working on an new deal load the defaults
        if(deal.Id == null)
            loadDefaults();

        if(deal.dealer__Vehicle__c!=null) {
            vehicle = lookupVehicle(deal.dealer__Vehicle__c);
        }

        if(deal.dealer__Status__c == null) { deal.dealer__Status__c='Incomplete';  }    

        if(deal.Buyer_State__c==null) {
            // Default deal state to the location of the $user
            deal.Buyer_State__c = 'CA';
        }    

        // Sales Up Passed as primary Record
        if(ApexPages.currentPage().getParameters().get('salesup')!=null) {
            // Get Sales Up Data and Link to Deal
            buildDealFromSalesUp();
        }
        
        // If Buyer, Co-Buyer, Company or Broker are passed as GET Method Arguments, load into Object.
        if(ApexPages.currentPage().getParameters().get('buyer')!=null) {
            buyer   =   Deal_EXT.lookupBuyer(ApexPages.currentPage().getParameters().get('buyer'));
            if(buyer != new Contact()) { 
                populateBuyerData(buyer);
            }
        }
        
        if(ApexPages.currentPage().getParameters().get('cobuyer')!=null) {
            cobuyer =   Deal_EXT.lookupBuyer(ApexPages.currentPage().getParameters().get('cobuyer'));
            if(cobuyer != new Contact()) { 
                populateCoBuyerData(cobuyer);
            }
        }

        // If Vehicel is Passed as an argument, load object
        if(ApexPages.currentPage().getParameters().get('vehicle')!=null) {
            populateVehicleById(ApexPages.currentPage().getParameters().get('vehicle'));
        }
        
        if(deal.id != null){
            weOwe = fetchWeOwe();
            //findTotalRollup(); // aaded by KVP to evaluate Back End Gross Value on deal
            rollupSummaries(); // added by KVP to render the symbols accordingly 30/15
            
        }
        
        
        inventoryVehicleList = fetchInventoryVehicle();
    }
    
        /**
         * KVP
         * Method Name : notLostTradeIn
         * Descripion  : Initialize the SelTradin to create Inventory
         */
        @RemoteAction
        public static dealer__Trade_In__c notLostTradeIn(String dealId){
           dealer__Trade_In__c selTradeIn = new dealer__Trade_In__c();
            if(dealId !=null){
                list<dealer__Trade_In__c> tradeInList = [Select d.dealer__Year__c, d.dealer__VIN__c, d.dealer__Service_Vehicle__c, d.dealer__Position__c, d.dealer__Pay_Off_To__c, 
                                                 d.dealer__Pay_Off_Expiration_Date__c, d.dealer__Pay_Off_Amount__c, d.dealer__Odometer_at_Trade_In__c, d.dealer__NADA_Wholesale__c, 
                                                 d.dealer__NADA_Retail__c, d.dealer__Model__c, d.dealer__Make__c, d.dealer__Lost_Trade__c, d.dealer__K_B_B_Wholesale_Value__c,
                                                 d.dealer__K_B_B_Retail__c, d.dealer__Car_Deal__c, d.dealer__Black_Book_Wholesale__c, d.dealer__Black_Book_Retail__c, d.dealer__Appraised_By__c,
                                                 d.dealer__Appraisal_Date__c, d.dealer__ACV__c, 
                                                 d.dealer__Inventory_Vehicle__c
                                                 From dealer__Trade_In__c d 
                                                 WHERE d.dealer__Car_Deal__c =: dealId
                                                 AND d.dealer__Lost_Trade__c = false
                                                 AND d.dealer__Service_Vehicle__c != null 
                                                 //AND (d.dealer__Car_Deal__r.dealer__Multi_Quote_Vehicle_1__c = null OR dealer__Multi_Quote_Vehicle_2__c = null OR dealer__Multi_Quote_Vehicle_3__c = null)
                                                 AND d.dealer__Inventory_Vehicle__c = null
                                                 order by d.dealer__Position__c LIMIT 3];
                                                
            
                selTradeIn = !tradeInList.isEmpty() ? tradeInList[0] : null;
            }
         
         return selTradeIn;
        }
        
        /**
         * KVP
         * Method Name : createInventory
         * Descripion  : Creating vehicle inventory record based on selTradein 
         */
        public pageReference createInventory(){
           
            if(!inventoryVehicleList.isEmpty()){
                try{
                    insert inventoryVehicleList;
                    System.debug('-------inventoryVehicleList------'+inventoryVehicleList);
                    //String dmsValue = deal.dealer__Status__c;
                    //deal.dealer__Status__c = dmsDealStatus;
                    //deal.dealer__Status__c = dmsValue;
                    update deal;
                    list<dealer__Trade_In__c> tradeInList = new list<dealer__Trade_In__c>();
                    for(dealer__Vehicle_Inventory__c inv :inventoryVehicleList){
                        dealer__Trade_In__c trade = vinToTradeMap.get(inv.dealer__VIN__c);
                        trade.dealer__Inventory_Vehicle__c = inv.id;
                        trade.dealer__Stock_Number__c = inv.dealer__Stock_Number__c; 
                        tradeInList.add(trade);     
                    }
                    update tradeInList;
                    dealer__Service_Vehicle__c sv = fetchSVFromDeal();
                    sv.dealer__Veh_Owner_Contact__c = deal.dealer__Buyer_Contact__c;
                    sv.dealer__Veh_Owner__c = deal.dealer__Buyer__c;
                    if(sv.id != null){
                        update sv;
                    } 
                    dealer__Vehicle_Inventory__c inVeh = fetchInVehFromDeal();
                    inVeh.dealer__In_Stock__c = false;
                    String dmsInvStatus = !dealDefaults.isEmpty() ? dealDefaults[0].dealer__Inventory_Status_for_Sold_Vehicle__c : null;
                    inVeh.dealer__Status_Code__c = dmsInvStatus;
                    if(inVeh.id != null){
                        update inVeh;
                    }
                    System.debug('-------tradeInList------'+tradeInList);
                }catch(Exception e){
                    ApexPages.addmessage(new Apexpages.message(Apexpages.severity.error,e.getMessage()));   
                    
                }
            }
            PageReference dealPage = new ApexPages.StandardController(deal).view();
            dealPage.setRedirect(true);
            return dealPage;
         //return null;
        }
        
        public dealer__Service_Vehicle__c fetchSVFromDeal(){
            dealer__Service_Vehicle__c sv;
            try{
                sv = [Select Id, Name, dealer__Sales_Inventory__c, dealer__Veh_Owner_Contact__c, dealer__Sales_Inventory__r.dealer__In_Stock__c, 
                    dealer__Sales_Inventory__r.dealer__Status_Code__c, dealer__Veh_Owner__c 
                    FROM dealer__Service_Vehicle__c WHERE dealer__Sales_Inventory__c =:deal.Vehicle__c LIMIT 1];
            }catch(Exception e){
                sv = new dealer__Service_Vehicle__c();
            }
            System.debug('------sv--------'+sv);
            return sv;
        }
        
        public dealer__Vehicle_Inventory__c fetchInVehFromDeal(){
            dealer__Vehicle_Inventory__c inVeh;
            try{
                inVeh = [Select Id, Name, dealer__In_Stock__c, dealer__Status_Code__c 
                        FROM dealer__Vehicle_Inventory__c WHERE Id =:deal.Vehicle__c LIMIT 1];
            }catch(Exception e){
                inVeh = new dealer__Vehicle_Inventory__c();
            }
            System.debug('------inVeh--------'+inVeh);
            return inVeh;
        }
    
    /**
     * KVP
     * Method Name : fetchInventoryVehicle
     * Descripion  : Method to fetch the data from Trade In record 
     */
    public List<dealer__Vehicle_Inventory__c> fetchInventoryVehicle(){
        List<dealer__Vehicle_Inventory__c> inventoryVehList = new List<dealer__Vehicle_Inventory__c>();
        vinToTradeMap = new Map<String, dealer__Trade_In__c>();
        list<dealer__Trade_In__c> tradeInList = [Select d.dealer__Year__c, d.dealer__VIN__c, d.dealer__Service_Vehicle__c, d.dealer__Position__c, d.dealer__Pay_Off_To__c, 
                                                 d.dealer__Pay_Off_Expiration_Date__c, d.dealer__Pay_Off_Amount__c, d.dealer__Odometer_at_Trade_In__c, d.dealer__NADA_Wholesale__c, 
                                                 d.dealer__NADA_Retail__c, d.dealer__Model__c, d.dealer__Make__c, d.dealer__Lost_Trade__c, d.dealer__K_B_B_Wholesale_Value__c,
                                                 d.dealer__K_B_B_Retail__c, d.dealer__Trade_Allowance__c, d.dealer__Car_Deal__c, d.dealer__Black_Book_Wholesale__c,
                                                 d.dealer__Black_Book_Retail__c, d.dealer__Appraised_By__c,
                                                 d.dealer__Appraisal_Date__c, d.dealer__ACV__c, dealer__Stock_Number__c,       
                                                 d.dealer__Inventory_Vehicle__c, d.dealer__Car_Deal__r.dealer__Store_Location__c,
                                                 
                                                 d.dealer__Service_Vehicle__r.dealer__Transmission_Type__c, 
                                                 d.dealer__Service_Vehicle__r.dealer__Body_Style__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Body_Type__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Company_Number__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Conversion_MFG__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Doors__c, 
                                                 d.dealer__Service_Vehicle__r.dealer__Drive_Type__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Engine_Description__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Engine_Displacement__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Engine_ID__c,
                                                 d.dealer__service_Vehicle__r.dealer__Ext_Color__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Hours__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Int_Color__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Licence__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Make__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Carline__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Model_Code__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Package_Code__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Trim_Level__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Vehicle_Type__c,
                                                 d.dealer__Service_Vehicle__r.dealer__VIN__c,
                                                 d.dealer__Service_Vehicle__r.dealer__Year__c,
                                                 d.dealer__Appraisal_Vehicle__r.dealer__Appraisal__r.dealer__Acquisition_method__c
                                                 From dealer__Trade_In__c d 
                                                 WHERE d.dealer__Car_Deal__c =: deal.Id
                                                 AND d.dealer__Lost_Trade__c = false
                                                 AND d.dealer__Service_Vehicle__c != null 
                                                 //AND (d.dealer__Car_Deal__r.dealer__Multi_Quote_Vehicle_1__c = null OR dealer__Multi_Quote_Vehicle_2__c = null OR dealer__Multi_Quote_Vehicle_3__c = null)
                                                 AND d.dealer__Inventory_Vehicle__c = null
                                                 order by d.dealer__Position__c LIMIT 3];
    
        for(dealer__Trade_In__c trade :tradeInList){
            vinToTradeMap.put(trade.dealer__VIN__c, trade);
            dealer__Vehicle_Inventory__c vehicleInventory = new dealer__Vehicle_Inventory__c();
            vehicleInventory.Purchase_Price__c = trade.dealer__Trade_Allowance__c;
            vehicleInventory.Stock_Number__c = trade.dealer__Stock_Number__c;
            vehicleInventory.dealer__Mileage__c = trade.dealer__Odometer_at_Trade_In__c;
            //vehicleInventory.Invoice_Reference__c = 
            vehicleInventory.dealer__VIN__c = trade.dealer__VIN__c;
            vehicleInventory.dealer__Year__c = trade.dealer__Year__c;
            vehicleInventory.dealer__Make__c = trade.dealer__Make__c; // Was reversed with Model
            vehicleInventory.dealer__Model__c = trade.dealer__Model__c; // Was reversed with Make
            vehicleInventory.dealer__Purchase_Date__c = System.today(); 
            vehicleInventory.dealer__Inventory_Date__c = System.today();
            vehicleInventory.dealer__Acquisition_Date__c = System.today();
            vehicleInventory.dealer__In_Stock__c = true;
            
            if(trade.dealer__Service_Vehicle__c != null)
            {
                vehicleInventory.dealer__Transmission_Type__c = trade.dealer__Service_Vehicle__r.dealer__Transmission_Type__c;
                vehicleInventory.dealer__Body_Style__c = trade.dealer__Service_Vehicle__r.dealer__Body_Style__c;
                vehicleInventory.dealer__Body_Type__c = trade.dealer__Service_Vehicle__r.dealer__Body_Type__c;
                vehicleInventory.dealer__Company_Number__c = trade.dealer__Service_Vehicle__r.dealer__Company_Number__c;
                vehicleInventory.dealer__Conv_MFG__c = trade.dealer__Service_Vehicle__r.dealer__Conversion_MFG__c;
                vehicleInventory.dealer__Doors__c = trade.dealer__Service_Vehicle__r.dealer__Doors__c;
                vehicleInventory.dealer__Drive_Type__c = trade.dealer__Service_Vehicle__r.dealer__Drive_Type__c;
                vehicleInventory.dealer__Engine_Description__c = trade.dealer__Service_Vehicle__r.dealer__Engine_Description__c;
                vehicleInventory.dealer__Engine_Displacement__c = trade.dealer__Service_Vehicle__r.dealer__Engine_Displacement__c;
                vehicleInventory.dealer__Engine_ID__c = trade.dealer__Service_Vehicle__r.dealer__Engine_ID__c;
                vehicleInventory.dealer__Exterior_Color__c = trade.dealer__service_Vehicle__r.dealer__Ext_Color__c;
                vehicleInventory.dealer__Hours__c = trade.dealer__Service_Vehicle__r.dealer__Hours__c; 
                vehicleInventory.dealer__Interior_Color__c = trade.dealer__Service_Vehicle__r.dealer__Int_Color__c;
                vehicleInventory.dealer__License__c = trade.dealer__Service_Vehicle__r.dealer__Licence__c;
                vehicleInventory.dealer__Model_Code__c = trade.dealer__Service_Vehicle__r.dealer__Model_Code__c;
                vehicleInventory.dealer__Package_Code__c = trade.dealer__Service_Vehicle__r.dealer__Package_Code__c;
                vehicleInventory.dealer__Trim_Level__c = trade.dealer__Service_Vehicle__r.dealer__Trim_Level__c;
                vehicleInventory.dealer__Vehicle_Type__c = trade.dealer__Service_Vehicle__r.dealer__Vehicle_Type__c;
            }
            if(trade.dealer__Appraisal_Vehicle__c != null){
                vehicleInventory.dealer__Acquisition_Method__c = trade.dealer__Appraisal_Vehicle__r.dealer__Appraisal__r.dealer__Acquisition_method__c;
            }
            
            if(!dealDefaults.isEmpty() && dealDefaults[0].dealer__In_Stock_Default_Status__c != null){
                vehicleInventory.dealer__Status_Code__c = dealDefaults[0].dealer__In_Stock_Default_Status__c;
            }
            vehicleInventory.dealer__Store_Location__c = trade.dealer__Car_Deal__r.dealer__Store_Location__c;
            inventoryVehList.add(vehicleInventory);
        }
        return inventoryVehList;
    }
    
    //Kumar changes starts here
    public pagereference mergeAndPrint(){
        String pageNames='';
                
        for(FormsWrapper wrap:listFormWrap ){
            if(wrap.selected && wrap.objForm.Page_Name__c!=null && wrap.objForm.Page_Name__c!=''){
                pageNames += wrap.objForm.Page_Name__c.trim()+',';
            }
        }
        pageNames =pageNames.removeEnd(',');
        if(pageNames =='' || pageNames ==null){
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least one form');
            ApexPages.addMessage(errMsg);
            return null;
        }
        Pagereference pg = new Pagereference('/apex/MergedPDF?id='+deal.Id+'&pageNames='+pageNames );
        return pg;
    }
    //Kumar changes ends here
        
    //////////////////////////////
    // GETTER Methods
    //////////////////////////////
    
    /*
     * getDealTitle() - returns the deal title based on the deal data
     */
    public String getdealTitle() {
        String dealNameTitle = 'New Deal';
        if(deal.Id==null) {
            return dealNameTitle;
        } else {
            dealNameTitle = deal.dealer__Stock_Number__c;
            if(deal.dealer__Buyer_Last_Name__c!=null && deal.dealer__Buyer_First_Name__c != null) { 
                dealNameTitle = dealNameTitle+' '+deal.dealer__Buyer_Last_Name__c+', '+deal.dealer__Buyer_First_Name__c; 
            }
            return dealNameTitle;
        }
    }
    
    public List<String> getTaxZoneCountyList () {
        String[] taxCounties = new String[]{};
        for(dealer__Tax_Zones__c tx : [select Id, dealer__County__c from dealer__Tax_Zones__c limit 500]) {
            taxCounties.add(tx.dealer__County__c);
        }
        return taxCounties;
    }

    //////////////////////////////
    // Supporting Methods
    //////////////////////////////
    
    public void loadDefaults(){
       if(dealDefaults[0].dealer__Deal_Number__c==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'System Configuration incomplete, please set a starting deal# in the DMS Settings'));
       }
       if(deal == new dealer__Deal__c()) {
            deal.dealer__Deal_Date__c = Date.today();
            deal.dealer__Rate__c = dealDefaults[0].dealer__Deal_Default_Rate__c;
            deal.dealer__Term__c = dealDefaults[0].dealer__Deal_Default_Term__c;
            deal.dealer__Days__c = dealDefaults[0].dealer__Deal_Default_Days__c;
            deal.Days_to_First__c= dealDefaults[0].dealer__Deal_Default_Days__c;
            deal.dealer__Payments_Per_Year__c = dealDefaults[0].dealer__Deal_Default_Payments_Per_Year__c;
            deal.dealer__Doc_Fee__c = dealDefaults[0].dealer__Deal_Doc_Fee_Retail__c;
            deal.dealer__Stock_Number__c = null;
       }

       // By default load secondary data objects
       if(deal.dealer__Vehicle__c!=null) {
            populateVehicleById(deal.dealer__Vehicle__c);
       }
    }

    public void buildDealFromSalesUp() {
        dealer__Sales_Up__c sup = [Select Id, dealer__Buyer_Contact__c, dealer__Co_Buyer_Contact__c, dealer__Desired_Stock_Num__c,
                                        dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Desk_Manager_User__c, dealer__F_I_Manager__c,
                                        dealer__Trade_Comments__c, dealer__Trade_Make__c, dealer__Trade_Mileage__c, dealer__Trade_Model__c,
                                        dealer__Trade_VIN__c, dealer__Trade_Year__c, dealer__Service_Vehicle__c, dealer__Store_Location__c, 
                                        
                                        
                                        (Select Id, Name, dealer__Interior_Color__c, dealer__Make__c, dealer__Model__c, dealer__New_Used_Other__c, 
                                        dealer__Service_Vehicle__c, dealer__Trim_Level__c, dealer__VIN__c, dealer__Year__c,
                                        dealer__Service_Vehicle__r.dealer__Stock_Number__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c, 
                                        dealer__Appraisal__r.dealer__Appraised_Value__c, dealer__Sales_Up__r.dealer__Customer_Account__r.Name, dealer__Sales_Up__r.dealer__Customer_Account__c, 
                                        dealer__Appraisal__r.dealer__Appraisal_Date__c
                                        FROM Appraisal_Vehicles__r 
                                        WHERE dealer__Appraisal__c != null Order By CreatedDate DESC)
                                        
                                        
                                        from dealer__Sales_Up__c 
                                        where Id=:ApexPages.currentPage().getParameters().get('salesup')
                                        limit 1];
        deal.dealer__Sales_Lead__c = sup.Id;
        if(sup.dealer__Store_Location__c!=null){
            deal.dealer__Store_Location__c = sup.dealer__Store_Location__c; // Added by KVP to populate Location
        }
        else {
            User u  = [Select Id, Division from User where Id =:UserInfo.getUserId() limit 1];
            dealer__Dealer_Location__c location = [Select Id from dealer__Dealer_Location__c where dealer__Company_Number__c =:u.Division limit 1];
            deal.dealer__Store_Location__c = location.Id;
        }     
        deal.dealer__Salesperson_1__c = sup.dealer__Salesperson_1__c;
        deal.dealer__Salesperson_2__c = sup.dealer__Salesperson_2__c;
        deal.dealer__Desk_Manager__c  = sup.dealer__Desk_Manager_User__c;
        deal.dealer__F_I_Manager__c   = sup.dealer__F_I_Manager__c;
        deal.dealer__Service_Vehicle__c = sup.dealer__Service_Vehicle__c;
        
        //tradeInJSON = '{"year":"'+sup.dealer__Trade_Year__c+'","make":"'+sup.dealer__Trade_Make__c+'","model":"'+sup.dealer__Trade_Model__c+'","mileage":"'+sup.dealer__Trade_Mileage__c+'","vin":"'+sup.dealer__Trade_VIN__c+'"}';
        //List<dealer__Appraisal_Vehicle__c> appraisalVehList = new List<dealer__Appraisal_Vehicle__c>();
        appraisalVehList = sup.Appraisal_Vehicles__r;
        tradeInJSON = JSON.serialize(appraisalVehList);
        System.debug('---tradeInJSON--'+tradeInJSON);
        
        if(sup.dealer__Desired_Stock_Num__c!=null) { 
            vehicle = lookupVehicle(sup.dealer__Desired_Stock_Num__c);
            populateVehicle(vehicle); 
        }                                
        if(sup.dealer__Buyer_Contact__c!=null) { 
            Contact buyer = [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState,
                       Birthdate, dealer__Drivers_License_Number__c, dealer__Drivers_License_Expiration_Date__c
                       from Contact 
                       where Id=:sup.dealer__Buyer_Contact__c
                       limit 1];
            populateBuyerData(buyer); 
        }
        if(sup.dealer__Co_Buyer_Contact__c!=null) {
            Contact cobuyer = [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState,
                       Birthdate, dealer__Drivers_License_Number__c, dealer__Drivers_License_Expiration_Date__c
                       from Contact 
                       where Id=:sup.dealer__Co_Buyer_Contact__c
                       limit 1];
            populateCoBuyerData(cobuyer); 
        }
    }
    // Method to insert Trade In records
    public void insertTradeIn(Integer count){
        for(Integer i=count; i<appraisalVehList.size(); i++){
            
        }
    }
    public static Contact lookupBuyer(String bid) {
        Contact[] b = [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState
                       from Contact 
                       where Id=:bid limit 1];
        if(b.size()!=1) { return null; }
        return b[0];
    } 

    public dealer__Vehicle_Inventory__c lookupVehicle(String vid) {
        return [Select dealer__Year__c, dealer__Vehicle_Type__c, dealer__Vehicle_Size__c, dealer__Trim_Level__c,
                                                                dealer__Vehicle_Cost__c, dealer__VIN__c, dealer__Stock_Number__c, dealer__Status_Code__c, 
                                                                dealer__Sale_Date__c, dealer__Retail_Price__c, dealer__Reserve_Price__c, dealer__New_Tires__c, 
                                                                dealer__NUO__c, dealer__Model__c, dealer__Model_Code__c, dealer__Mileage__c, 
                                                                dealer__Memo_Two__c, dealer__Memo_One__c, dealer__Make__c, dealer__Location__c, 
                                                                dealer__License__c, dealer__License_Exp__c, dealer__Inventory_Date__c, 
                                                                dealer__In_Stock__c, dealer__Holdback__c, dealer__Days_in_Stock__c, dealer__Coded_Cost__c, 
                                                                dealer__Body_Type__c, dealer__Keyless_Entry_Code__c, dealer__Demo_Indicator__c, 
                                                                dealer__Ignition_Key_Code__c, dealer__MSRP__c, dealer__Pack__c, 
                                                                dealer__Exterior_Color__c, dealer__Title_Type__c, dealer__Fuel_Type__c, dealer__Work_in_Process__c,
                                                                dealer__Invoice_Price__c  
                                                                From dealer__Vehicle_Inventory__c 
                                                                where Id = :vid
                                                                and IsDeleted=false 
                                                                Limit 1];
    }
    
    public void populateBuyerData(Contact contact) {
        Contact c = [Select Id, AccountId, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState,
                       Birthdate, dealer__Drivers_License_Number__c, dealer__Drivers_License_Expiration_Date__c
                       from Contact 
                       where Id=:contact.Id
                       limit 1];
        deal.dealer__Buyer_Contact__c = c.Id;
        deal.dealer__Buyer_First_Name__c = c.FirstName;
        deal.dealer__Buyer_Last_Name__c = c.LastName;
        deal.dealer__Buyer_Home_Phone__c = c.Phone;
        deal.dealer__Buyer_Mobile_Phone__c = c.MobilePhone;
        deal.dealer__Buyer_Email__c = c.Email;
        deal.dealer__Buyer_Birthdate__c = c.Birthdate;
        deal.dealer__Buyer_Drivers_License__c = c.dealer__Drivers_License_Number__c;
        deal.dealer__Buyer_Drivers_License_Exp_Date__c = c.dealer__Drivers_License_Expiration_Date__c;
        
        deal.dealer__Buyer_Address__c = c.MailingStreet;
        deal.dealer__Buyer_City__c = c.MailingCity;
        deal.dealer__Buyer_State__c = c.MailingState;
        deal.dealer__Buyer_Postal_Code__c = c.MailingPostalCode;

        /* Check to see if this contact has han account Id and populate the buyer account lookup */
        if(c.AccountId!=null) {
            deal.dealer__Buyer__c=c.AccountId;
        }
    }
    
    public void populateCoBuyerData(Contact contact) {
        Contact c = [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingPostalCode, MailingState,
                       Birthdate, dealer__Drivers_License_Number__c, dealer__Drivers_License_Expiration_Date__c
                       from Contact 
                       where Id=:contact.Id
                       limit 1];        
        deal.dealer__Co_Buyer_Contact__c = c.Id;
        deal.dealer__Co_Buyer_First_Name__c = c.FirstName;
        deal.dealer__Co_Buyer_Last_Name__c = c.LastName;
        deal.dealer__Co_Buyer_Home_Phone__c = c.Phone;
        deal.dealer__Co_Buyer_Mobile_Phone__c = c.MobilePhone;
        deal.dealer__Co_Buyer_Email__c = c.Email;
        deal.dealer__Co_Buyer_Birth_Date__c = c.Birthdate;
        deal.dealer__Co_Buyer_Drivers_License_Number__c = c.dealer__Drivers_License_Number__c;
        deal.dealer__Co_Buyer_Drivers_License_Exp_Date__c = c.dealer__Drivers_License_Expiration_Date__c;
        
        deal.dealer__Co_Buyer_Address__c = c.MailingStreet;
        deal.dealer__Co_Buyer_City__c = c.MailingCity;
        deal.dealer__Co_Buyer_State__c = c.MailingState;
        deal.dealer__Co_Buyer_Postal_Code__c = c.MailingPostalCode;
    }
    
    public void populateCompany(Account a) {
        deal.dealer__Business_Contracting_Name__c = a.Name;
        deal.dealer__Business_Address__c = a.BillingStreet;
        deal.dealer__Business_City__c = a.BillingCity;
        deal.dealer__Business_State__c = a.BillingState;
        deal.dealer__Business_Postal_Code__c = a.BillingPostalCode;
        deal.dealer__Business_Phone__c = a.Phone;
    }

    public void populateVehicle(dealer__Vehicle_Inventory__c vehicle) {
        dealer__Vehicle_Inventory__c v = [Select dealer__Year__c, dealer__Vehicle_Type__c, dealer__Vehicle_Size__c, dealer__Trim_Level__c,
                                                                dealer__Vehicle_Cost__c, dealer__VIN__c, dealer__Stock_Number__c, dealer__Status_Code__c, 
                                                                dealer__Sale_Date__c, dealer__Retail_Price__c, dealer__Reserve_Price__c, dealer__New_Tires__c, 
                                                                dealer__NUO__c, dealer__Model__c, dealer__Model_Code__c, dealer__Mileage__c, 
                                                                dealer__Memo_Two__c, dealer__Memo_One__c, dealer__Make__c, dealer__Location__c, 
                                                                dealer__License__c, dealer__License_Exp__c, dealer__Inventory_Date__c, 
                                                                dealer__In_Stock__c, dealer__Holdback__c, dealer__Days_in_Stock__c, dealer__Coded_Cost__c, 
                                                                dealer__Body_Type__c, dealer__Keyless_Entry_Code__c, dealer__Demo_Indicator__c, 
                                                                dealer__Ignition_Key_Code__c, dealer__MSRP__c, dealer__Pack__c, 
                                                                dealer__Exterior_Color__c, dealer__Title_Type__c, dealer__Fuel_Type__c, dealer__Work_in_Process__c,
                                                                dealer__Invoice_Price__c  
                                                                From dealer__Vehicle_Inventory__c 
                                                                where Id = :vehicle.Id
                                                                and IsDeleted=false 
                                                                Limit 1];
        deal.dealer__Vehicle__c = v.Id;
        deal.dealer__Stock_Number__c = v.dealer__Stock_Number__c;
        deal.dealer__Year__c = v.dealer__Year__c;
        deal.dealer__Make__c = v.dealer__Make__c;
        deal.dealer__Model__c = v.dealer__Model__c;
        deal.dealer__VIN__c = v.dealer__VIN__c;
        deal.dealer__NUO__c = v.dealer__NUO__c;
        deal.dealer__Mileage__c = v.dealer__Mileage__c;
        deal.dealer__Ext_Color__c = v.dealer__Exterior_Color__c;
        deal.dealer__Licence__c = v.dealer__License__c;
        deal.dealer__License_Expiration__c = v.dealer__License_Exp__c;

        deal.dealer__List_Price__c = v.dealer__MSRP__c;
        deal.dealer__Sale_Cost__c = v.dealer__Vehicle_Cost__c;        
        deal.dealer__Sale_Price__c = v.dealer__Retail_Price__c;
        
        vehicle = v;
    }

    public void populateVehicleById(String vid) {
        dealer__Vehicle_Inventory__c[] vehs = [Select dealer__Year__c, dealer__Vehicle_Type__c, dealer__Vehicle_Size__c, dealer__Trim_Level__c,
                                                                dealer__Vehicle_Cost__c, dealer__VIN__c, dealer__Stock_Number__c, dealer__Status_Code__c, 
                                                                dealer__Sale_Date__c, dealer__Retail_Price__c, dealer__Reserve_Price__c, dealer__New_Tires__c, 
                                                                dealer__NUO__c, dealer__Model__c, dealer__Model_Code__c, dealer__Mileage__c, 
                                                                dealer__Memo_Two__c, dealer__Memo_One__c, dealer__Make__c, dealer__Location__c, 
                                                                dealer__License__c, dealer__License_Exp__c, dealer__Inventory_Date__c, 
                                                                dealer__In_Stock__c, dealer__Holdback__c, dealer__Days_in_Stock__c, dealer__Coded_Cost__c, 
                                                                dealer__Body_Type__c, dealer__Keyless_Entry_Code__c, dealer__Demo_Indicator__c, 
                                                                dealer__Ignition_Key_Code__c, dealer__MSRP__c, dealer__Pack__c, 
                                                                dealer__Exterior_Color__c, dealer__Title_Type__c, dealer__Fuel_Type__c, dealer__Work_in_Process__c,
                                                                dealer__Invoice_Price__c  
                                                                From dealer__Vehicle_Inventory__c 
                                                                where Id = :vid
                                                                and IsDeleted=false 
                                                                Limit 1];
        if(vehs.size()==1) {
            vehicle = vehs[0];
            deal.dealer__Vehicle__c = vehicle.Id;
            deal.dealer__Stock_Number__c = vehicle.dealer__Stock_Number__c;
            deal.dealer__Year__c = vehicle.dealer__Year__c;
            deal.dealer__Make__c = vehicle.dealer__Make__c;
            deal.dealer__Model__c = vehicle.dealer__Model__c;
            deal.dealer__VIN__c = vehicle.dealer__VIN__c;
            deal.dealer__NUO__c = vehicle.dealer__NUO__c;
            deal.dealer__Mileage__c = vehicle.dealer__Mileage__c;
            deal.dealer__Ext_Color__c = vehicle.dealer__Exterior_Color__c;
            deal.dealer__Licence__c = vehicle.dealer__License__c;
            deal.dealer__License_Expiration__c = vehicle.dealer__License_Exp__c;            

            deal.dealer__List_Price__c = vehicle.dealer__MSRP__c;
            deal.dealer__Sale_Cost__c = vehicle.dealer__Vehicle_Cost__c;        
            deal.dealer__Sale_Price__c = vehicle.dealer__Retail_Price__c;            
        } else {
            vehicle = new dealer__Vehicle_Inventory__c();
        }
    }

    // Apply Config to Application Cache
    public static void setApplicationCache() {
        dealer__SalesDeskLogSettings__c config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(config==null) {    
            if(dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId())==null) {
                config =  new dealer__SalesDeskLogSettings__c();
                config.SetupOwnerId = UserInfo.getUserId();
                config.dealer__TrafficType__c = 'ALL';
                config.dealer__RunDate__c=Date.today();
                config.dealer__WalkIns__c=true;
                config.dealer__EmailUps__c=true;
                config.dealer__PhoneUps__c=true;
                config.dealer__faxUps__c=true;
                config.dealer__listUps__c=true;
                config.dealer__ReferralUps__c=true;
                config.dealer__OtherUps__c=true;
                insert config;
            }
        }
    }

    /////////////////////////////
    // Forms Functions
    /////////////////////////////
    /* -- Moved to their own class
    
    public PageReference formSetCode() {
        return null;
    }


    public Component.Apex.OutputText getFormComponent () {

        // Get Form from set FormId
        System.debug('Form execution method');
        System.debug(formId);

        Component.Apex.OutputText ot = new Component.Apex.OutputText() ;

        if(formId != null) {
            dealer__Form__c form = [Select Id, dealer__Impact_Code__c from dealer__Form__c where Id=:formId limit 1];
            ot.expressions.value = base64Decode(form.dealer__Impact_Code__c);
        }
        // ot.expressions.value = '||||4,4,{!LEFT(deal.Name, 5)}+4,32,{!deal.dealer__Year__c}+4,39,dealer__Make__c+4,47,dealer__orig_lic_plate__c+|||7,8,SELLERS_FIRST_LAST_NAME+|||10,6,BUYERS_FIRST_LAST_NAME+10,41,DATE_GOES_HERE+10,69,dealer__Sale_Price__c+|||||||||19,20,ODOMETER_GOES_HERE+||||||||||||31,4,BUYERS_FIRST_LAST_NAME+31,57,DATE_GOES_HERE+31,66,dealer__Buyer_Drivers_License__c+||||||37,4,dealer__Buyer_Contact__r.MailingStreet+37,34,dealer__Buyer_Contact__r.MailingCity+37,53,dealer__Buyer_Contact__r.MailingState+37,57,dealer__Buyer_Contact__r.MailingPostalCode+37,66,dealer__Buyer_Contact__r.Phone+|||||42,4,SELLERS_NAME_HERE+42,57,DATE_GOES_HERE+42,66,DISM_GOES_HERE+||||||48,4,SELLERS_STREET+48,34,SELLERS_CITY+48,53,SELLERS_STATE+48,57,SELLERS_ZIP+48,66,SELLERS_PHONE+';
        String frmCompiledCode  =   String.valueOf(ot.expressions.value);
        System.debug(frmCompiledCode);
        return ot ;
    }


    public void getAllFields() {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get('dealer__Deal__c').getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'select ' + commaSepratedFields + ' from dealer__Deal__c Limit 1';
 
        dealFormObject = Database.query(query);       
    }

    public Component.Apex.OutputText getCompiledForm() {
        getAllFields();
        Component.Apex.OutputText dvf = new Component.Apex.OutputText();
        if(formId != null) {
            dealer__Form__c form = [Select Id, dealer__Impact_Code__c from dealer__Form__c where Id=:formId limit 1];
            dvf.expressions.value = base64Decode(form.dealer__Impact_Code__c);
        }        
        // dvf.expressions.value = '||2,10,DLE#+2,30,{!deal.dealer__Deal_ID__c}+2,50,ROS+2,70,{!deal.dealer__Stock_Number__c}+||||6,2,{!deal.dealer__Buyer_First_Name__c}+6,30,{!deal.dealer__Co_Buyer_First_Name__c}+6,56,{!$Organization.Name}+|7,2,{!deal.dealer__Buyer_Address__c}+7,30,{!deal.dealer__Co_Buyer_Address__c}+7,56,{!$Organization.Street}+|8,2,{!deal.dealer__Buyer_City__c} {!deal.dealer__Buyer_State__c} {!deal.dealer__Buyer_County__c} {!deal.dealer__Buyer_Postal_Code__c}+8,30,{!deal.dealer__Co_Buyer_City__c} {!deal.dealer__Co_Buyer_State__c} {!deal.dealer__Co_Buyer_County__c} {!deal.dealer__Co_Buyer_Postal_Code__c}+8,56,{!$Organization.City} {!$Organization.State} {!$Organization.PostalCode}+||||||14,13,{!deal.dealer__Make__c}+|15,2,{!deal.dealer__NUO__c}+15,8,{!deal.dealer__Year__c}+15,13,{!deal.dealer__Model__c}+15,24,{!ROUND(deal.dealer__Mileage__c,0)}+15,36,{!deal.dealer__VIN__c}+|||||||||24,48,{!ROUND(deal.dealer__Down_Pymt__c,0)}+|25,5,{!deal.dealer__Rate__c}+25,13,{!deal.dealer__Amt_Financed__c}+25,25,{!deal.dealer__Amt_Financed__c}+25,35,{!deal.dealer__Amt_Financed__c}+25,48,{!deal.dealer__Amt_Financed__c+deal.dealer__Down_Pymt__c}+25,58,N/A+25,71,N/A+25,77,N/A+|26,58,N/A+26,71,N/A+26,77,N/A+|27,67,N/A+27,71,N/A+27,77,N/A+|28,67,N/A+28,71,N/A+28,77,N/A+|29,67,N/A+29,71,N/A+29,77,N/A+|30,67,N/A+30,71,N/A+30,77,N/A+|31,77,N/A+|||||36,5,{!deal.dealer__Term__c-1}+36,28,{!deal.dealer__Monthly_Pymt__c}+36,45,{!deal.dealer__First_Payment_Date__c}+|||||||||||||||||||';
        return dvf;
    }    

    public String base64Decode(String s) {
        Blob decodeBlob = EncodingUtil.base64Decode(s);
        String decodeString = decodeBlob.toString();
        if(!decodeString.contains('{!')) {
            return '';
        }
        return decodeString;
    } 
    */   

    /////////////////////////////
    //  Page References
    /////////////////////////////
    public PageReference save() {
        
       
        /* Sanity Check Deal */

        if(deal.dealer__Stock_Number__c == null) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Stock Number is Required');
            ApexPages.addMessage(myMsg);          
        }

        //Case 1964 Begin
        //Update Buyer Account with Buyer Contact if isPersonAccount true
        if(deal.dealer__Buyer_Contact__c!=null){
            List<Contact> listContact= [select id,AccountId from Contact where id=:deal.dealer__Buyer_Contact__c and Account.isPersonAccount=true];

            //If contact is a person account then populate account id in buyer account
            if(listContact!=null && listContact.size()>0){
                deal.dealer__Buyer__c = listContact[0].AccountId;
            }
        }
        //Case 1964 End

        /*  Generate next number */
        if(deal.Id == null) {

            System.debug('New Deal');

            dealer__DMS_Settings__c dmsSettings = [Select Id, dealer__Deal_Created_Default_Status__c, dealer__Deal_Number__c from dealer__DMS_Settings__c where Name = 'ActiveSettings' limit 1];
            Integer dealNo = Integer.valueOf(dmsSettings.dealer__Deal_Number__c);
            dealNo++;
            dmsSettings.dealer__Deal_Number__c = dealNo;
            update dmsSettings;

            deal.dealer__Deal_ID__c = String.valueOf(dealNo);
            deal.Name = String.valueOf(dealNo);

            System.debug('the value is'+deal);
            // Added By KVP for setting default status on deal creation
            if(dmsSettings.dealer__Deal_Created_Default_Status__c != null){
                deal.dealer__Status__c = dmsSettings.dealer__Deal_Created_Default_Status__c;
            }

            upsert deal;
            // Method call to save data in Trade In Object
            saveTradesData(jsonDataToInsert);
        } else {
            /*
            dealer__Sales_Up__c sup = [Select Id, dealer__Buyer_Contact__c, dealer__Co_Buyer_Contact__c, dealer__Desired_Stock_Num__c,
                                        dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Desk_Manager_User__c, dealer__F_I_Manager__c,
                                        dealer__Trade_Comments__c, dealer__Trade_Make__c, dealer__Trade_Mileage__c, dealer__Trade_Model__c,
                                        dealer__Trade_VIN__c, dealer__Trade_Year__c, dealer__Service_Vehicle__c, dealer__Car_Deal__c, dealer__Lead_Status__c
            
            
                                        from dealer__Sales_Up__c 
                                        where Id = :deal.dealer__Sales_Lead__c
                                        limit 1];
            if( (sup.dealer__Car_Deal__c == deal.id) && sup.dealer__Car_Deal__c != null && (dealDefaults[0].dealer__Deal_Status__c).contains(deal.dealer__Status__c) ){
                sup.dealer__Lead_Status__c = dealDefaults[0].dealer__Lead_Status__c;
                update sup;
            }
            */
            deal.Name = deal.dealer__Deal_ID__c;
            if(deal.dealer__Buyer_Last_Name__c != null) { deal.Name = deal.Name+' '+deal.dealer__Buyer_Last_Name__c; }
            if(deal.dealer__Buyer_First_Name__c != null) { deal.Name = deal.Name+', '+deal.dealer__Buyer_First_Name__c; }
            
            
            weOwe = fetchWeOwe();
            if(weOwe.id != null && dealStatus.get(deal.dealer__Status__c) != null){ // && dealStatus.get(deal.dealer__Status__c) != null added by kvp to handle Map nullpointer exception
                if(weOwe.dealer__Service_Repair_Order__c == null && dealStatus.get(deal.dealer__Status__c).dealer__We_Owe_Status__c != null){
                     weOwe.dealer__Status__c = dealStatus.get(deal.dealer__Status__c).dealer__We_Owe_Status__c;
                }
                update weOwe;
             }
             //Method to update the finanace gross value
             updateFinanceGross();
             findTotalRollup();
             
             update deal;
        }

        // Save Associated Fees
        // System.debug(fees);
        //PageReference dealPage = Page.Desking;
        //dealPage.getParameters().put('id', deal.id);
        //dealPage.setRedirect(true);
        /*PageReference dealPage = new ApexPages.StandardController(deal).view();
        if(seletedTabId == null){
            seletedTabId = ''+0;
        }
        //dealPage.getParameters().put('tabno', seletedTabId);
         
        //PageReference dealPage = new pageReference('/apex/Desking?id='+deal.id+'&tabno='+seletedTabId);
        //dealPage.setRedirect(true);
        //return dealPage;
        */
        PageReference dealPage = new ApexPages.StandardController(deal).view();
        if(seletedTabId == null){
            seletedTabId = '0';
        }
        //Initializing selectedTabId based on page and seletedTabId
        seletedTabId = returnTabId() != '0' ? returnTabId() : seletedTabId;
        dealPage.getParameters().put('tabno', seletedTabId);  
        dealPage.setRedirect(true);
        return dealPage;
    }
    //Method to return the tab index to redirect based on the current pagename
    public string returnTabId(){
        
            String pageName = Apexpages.currentPage().getUrl();

            if(pageName==null) { // Added to prevent test code failure
                pageName='dealer__Desking';
            }

            pageName = pageName.replaceFirst('/apex/','');   
            pageName = EncodingUtil.urlEncode(pageName, 'UTF-8');
            string[] pageNameList = pageName.split('%3F', 0);
            pageName = pageNameList[0];
            
            return  (pageName == 'dealer__DeskingAddEquipment' ) ? '6' : '0';

      }
    
    // Method to return back to deal
    public PageReference returnToDeal(){
        //PageReference dealPage = new pageReference('/apex/Desking?id='+deal.id+'&tabno='+seletedTabId);
        PageReference dealPage = new ApexPages.StandardController(deal).view();
        if(seletedTabId == null){
            seletedTabId = '0';
        }
        //Initializing selectedTabId based on page and seletedTabId
        seletedTabId = returnTabId() != '0' ? returnTabId() : seletedTabId;
        dealPage.getParameters().put('tabno', seletedTabId);  
        dealPage.setRedirect(true);
        return dealPage;
    }
    
    public List<SelectOption> getContractTypes(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = dealer__Service_Contract__c.dealer__Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        options.add(new SelectOption('All', 'All'));
        options.add(new SelectOption('None', '--None--'));
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
               
        return options;
    }
    
    public PageReference searchESC() {
        escResults = new List<dealer__Service_Contract__c>();
        String strLmt = 'LIMIT 100';
        String strQry = 'SELECT dealer__Contract_Template__c, dealer__Cost__c, dealer__Customer_Contact__c, dealer__Customer__c, dealer__Deductable__c, dealer__Description__c, dealer__End_Date__c, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c,dealer__Plan_Code__c, dealer__Product_Code__c, dealer__Sale_Price__c, dealer__Service_Vehicle__c, dealer__Start_Date__c, dealer__Vehicle_Inventory__c, dealer__Type__c, Name, Id FROM dealer__Service_Contract__c Where dealer__Contract_Template__c = true ';
        
        if(escDescription !='' && escDescription != null){
            String strDesc = '%' + escDescription + '%';
            strQry+= 'AND dealer__Description__c like :strDesc ' ;
        }
        if(escCode !='' && escCode != null){
            String strCode = '%' + escCode + '%';
            strQry+= 'AND dealer__Plan_Code__c like :strCode ' ;
        }
        if(selectedContractType !='' && selectedContractType != null){
            if(selectedContractType == 'All'){
                strQry = strQry;
            }else if(selectedContractType == 'None'){
                strQry+= 'AND dealer__Type__c = null ';
            }else {
                strQry+= 'AND dealer__Type__c = :selectedContractType ';
            }
        }
        escResults = Database.query(strQry+strLmt);
        
        System.debug('-----escResults------'+escResults);
        return null;
    }
    
    public PageReference resetResult() {
        escDescription = '';
        escCode = '';
        selectedContractType = '';
        escResults = new List<dealer__Service_Contract__c>();
        return null;
    }
    
    public PageReference selectProduct() {
        // Add Product to deal
        if(escSelectedId==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Service Contract ID, unable to Save to Proposal'));
            return null;
        }

        dealer__Service_Contract__c sc = [SELECT dealer__Contract_Template__c, dealer__Cost__c, 
                        dealer__Customer_Contact__c, dealer__Customer__c, dealer__Deductable__c, dealer__Description__c, 
                        dealer__End_Date__c, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c,
                        dealer__Plan_Code__c, dealer__Product_Code__c, dealer__Sale_Price__c, dealer__Service_Vehicle__c, 
                        dealer__Start_Date__c, dealer__Vehicle_Inventory__c, dealer__Type__c, Name, Id 
                        FROM dealer__Service_Contract__c
                        WHERE Id=:escSelectedId
                        LIMIT 1];

        dealer__Service_Vehicle__c[] vehicle = [Select Id from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c =: deal.dealer__Vehicle__c limit 1];
        dealer__Service_Contract__c addToDeal = new dealer__Service_Contract__c();
        addToDeal.dealer__Car_Deal__c = deal.Id;
        //addToDeal.dealer__Start_Date__c=deal.Proposed_Delivery_Date__c; // JVK3 IT#16965 - start date should be the proposed delivery date.
        addToDeal.dealer__Expiration_Months__c = sc.dealer__Expiration_Months__c;
        addToDeal.dealer__Expiration_Mileage__c = sc.dealer__Expiration_Mileage__c;
        addToDeal.dealer__Plan_Code__c = sc.dealer__Plan_Code__c;
        addToDeal.dealer__Product_Code__c = sc.dealer__Product_Code__c;
        addToDeal.dealer__Sale_Price__c = sc.dealer__Sale_Price__c;
        addToDeal.dealer__Customer_Contact__c = deal.dealer__Buyer_Contact__c;
        addToDeal.dealer__Service_Vehicle__c = vehicle.size() > 0 ? vehicle[0].Id : null;
        addToDeal.dealer__Description__c = sc.dealer__Description__c;
        addtoDeal.dealer__Cost__c = sc.dealer__Cost__c;
        if(deal.dealer__Buyer__c!=null) {
            addToDeal.dealer__Customer__c = deal.dealer__Buyer__c; // JVK3 IT16965 - Account should be linked
        }

        // DR added type selection 8-13-2015
        addtoDeal.type__c = sc.dealer__type__c;

        insert addToDeal;
        /********added by KVP*******/
        if(deal.id != null){
            findTotalRollup();
            rollupSummaryEvaluate();          
        }
        /***************************/
        return null; 
    }
    /************ Added by KVP ****************************/
    
    public void findTotalRollup(){
        gapRollupValue = 0;
       /* dealer__Deal__c gapRollUp = new dealer__Deal__c();
        gapRollUp = [SELECT Ext_Warr_Gross__c, dealer__Maintenance_Gross__c, dealer__Aftermarket_Gross__c, dealer__Finance_Gross__c,
                        dealer__GAP_Gross__c FROM dealer__Deal__c WHERE Id =: deal.Id];
                        System.debug('Gapppppppppppppppppppppp'+gapRollUp);
                        
                        if(gapRollUp.Ext_Warr_Gross__c != null){
                            gapRollupValue += gapRollUp.Ext_Warr_Gross__c;
                        }
                        if(gapRollUp.dealer__Maintenance_Gross__c != null){
                            gapRollupValue += gapRollUp.dealer__Maintenance_Gross__c;
                        }
                        if(gapRollUp.dealer__Aftermarket_Gross__c != null){
                            gapRollupValue += gapRollUp.dealer__Aftermarket_Gross__c;
                        }
                        if(gapRollUp.dealer__Finance_Gross__c != null){
                            gapRollupValue += gapRollUp.dealer__Finance_Gross__c;
                        }
                        if(gapRollUp.dealer__GAP_Gross__c != null){
                            gapRollupValue += gapRollUp.dealer__GAP_Gross__c;
                        }
        //Adding Premium gross total to the Back end Gross value on deal
        deal.dealer__Back_End_Gross__c += gapRollupValue;*/

        // DR 1-25-2016 - Using Ternary to prevent Null pointer exceptions. You cant add a null field. Ths was causing test failures
        deal.dealer__Back_End_Gross__c  = 
            (deal.Ext_Warr_Gross__c != null ? deal.Ext_Warr_Gross__c : 0) + 
            (deal.dealer__Maintenance_Gross__c != null ? deal.dealer__Maintenance_Gross__c : 0) + 
            (deal.dealer__Aftermarket_Gross__c != null ? deal.dealer__Aftermarket_Gross__c : 0) + 
            (deal.dealer__Finance_Gross__c != null ? deal.dealer__Finance_Gross__c : 0) + 
            (deal.dealer__GAP_Gross__c != null ? deal.dealer__GAP_Gross__c : 0);
        
        // DR 1-25-2016 - Using Ternary to prevent Null pointer exceptions. You cant add a null field. Ths was causing test failures 
        deal.dealer__Front_End_Gross__c = 
            (deal.Sale_Price__c != null ? deal.Sale_Price__c : 0) + (
            (deal.Trade_Allowance__c != null ? deal.Trade_Allowance__c : 0) - 
            (deal.Trade_Payoff__c != null ? deal.Trade_Payoff__c : 0))   - 
            (deal.Sale_Cost__c != null ? deal.Sale_Cost__c : 0);
        


        //deal.dealer__Back_End_Gross__c  = deal.Ext_Warr_Gross__c + deal.dealer__Maintenance_Gross__c + deal.dealer__Aftermarket_Gross__c + deal.dealer__Finance_Gross__c + deal.dealer__GAP_Gross__c;
        //deal.dealer__Front_End_Gross__c = deal.Sale_Price__c + (deal.Trade_Allowance__c - deal.Trade_Payoff__c)   - deal.Sale_Cost__c;
    } 
    public PageReference deleteProduct() {
        System.debug(deleteProductId);
        if(deleteProductId!=null) {
            dealer__Service_Contract__c svc = [Select Id from dealer__Service_Contract__c where Id=:deleteProductId limit 1];
            try {
                delete svc;
                //totalAftermarketItems(); // DR2 commented out
                /********added by KVP*******/
                if(deal.id != null){
                    findTotalRollup();
                    rollupSummaryEvaluate();
                    
                }
                /***************************/
            } catch (DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error removing product from proposal'));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No product Id to remove from proposal'));
        }

        return null;
    }
    
    @RemoteAction
    public static Boolean updateServiceContractSale(String scSale, String costType) { 
        String[] p = scSale.split('~');
        if(p.size()!=2) {
            return false;
        }

        dealer__Service_Contract__c[] sc = [Select Id from dealer__Service_Contract__c where Id=:p[0] limit 1];
        if(sc.size()==0) {
            return false;
        }
        if(costType == 'saleprice'){
            sc[0].dealer__Sale_Price__c = Decimal.valueOf(p[1]);
            
        }else if(costType == 'costprice'){
            sc[0].dealer__Cost__c = Decimal.valueOf(p[1]);
        }
        try {
            update sc;
        } Catch(DmlException e) {
            return false;
        }

        return true;

    }
    
    public PageReference newDeal() {
        Schema.DescribeSObjectResult r = dealer__Deal__c.sObjectType.getDescribe();  
        return new PageReference('/'+r.getKeyPrefix()+'/e');
    }
    
    public PageReference newDealPayment() {
        PageReference paymentPage = Page.DeskingPayment;
        paymentPage.getParameters().put('dealId', deal.Id);
        return paymentPage;
    }
    // AddedBy KVP
    public dealer__We_Owe__c fetchWeOwe(){
        try{
            return [SELECT id, Name, dealer__Car_Deal__c, dealer__Status__c, dealer__Service_Repair_Order__c FROM dealer__We_Owe__c WHERE dealer__Car_Deal__c =:deal.id LIMIT 1];
        }catch(Exception e){
            return new dealer__We_Owe__c();
        }
    }
    
     public String getInvoiceLogo() {
         if(deal.Id==null) {
             return '';
         } 

         Deal__c deal = [SELECT Store_Location__c FROM Deal__c WHERE Id=:deal.Id];

         if(deal.Store_Location__c != null){
             return DealershipLocationAPI.formLogoURL(deal.Store_Location__c);
         }else{
             Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
             String imageId = doc.Id;
             imageId = imageId.substring(0,15);
             return 'servlet/servlet.FileDownload?file='+imageId;
         }
    }

    // Advanced Equipment Search
    public PageReference searchEquipment() {
        kitList = new List<dealer__Parts_Kit__c>();

        if(kitMFG!=''&&kitMFG!=null) {
        kitList = [Select dealer__Description__c, dealer__Item_Count__c, dealer__Kit_Cost__c, dealer__Kit_Gross_Margin__c, dealer__Kit_List__c, 
                    dealer__Kit_Price__c, dealer__Labor_Cost__c, dealer__Labor_Sale__c, dealer__Manufacturer__c, Name, Id, dealer__Sell_on_Deals__c
                    from dealer__Parts_Kit__c
                    where dealer__Sell_on_Deals__c = true AND dealer__Manufacturer__c LIKE :'%'+kitMFG+'%'
                    limit 200];
        }

        if(kitDescription!=''&&kitDescription!=null) {
        kitList = [Select dealer__Description__c, dealer__Item_Count__c, dealer__Kit_Cost__c, dealer__Kit_Gross_Margin__c, dealer__Kit_List__c, 
                    dealer__Kit_Price__c, dealer__Labor_Cost__c, dealer__Labor_Sale__c, dealer__Manufacturer__c, Name, Id, dealer__Sell_on_Deals__c
                    from dealer__Parts_Kit__c
                    where  dealer__Sell_on_Deals__c = true AND dealer__Description__c LIKE :'%'+kitDescription+'%'
                    limit 200];
        } 


        if(kitDescription!=''&&kitDescription!=null && kitMFG!=''&&kitMFG!=null) {
        kitList = [Select dealer__Description__c, dealer__Item_Count__c, dealer__Kit_Cost__c, dealer__Kit_Gross_Margin__c, dealer__Kit_List__c, 
                    dealer__Kit_Price__c, dealer__Labor_Cost__c, dealer__Labor_Sale__c, dealer__Manufacturer__c, Name, Id, dealer__Sell_on_Deals__c
                    from dealer__Parts_Kit__c
                    where dealer__Sell_on_Deals__c = true AND dealer__Description__c =:kitDescription 
                    and dealer__Manufacturer__c  LIKE :'%'+kitMFG+'%'
                    limit 200];
        } 

        kitResultSize = kitList.size()+' results returned';                    
        
        System.debug(kitList);

        return null;
    }

    /////////////////////////////
    //  Wrapper Class for FEES
    /////////////////////////////
    /*
    public class dealFees {
        public Decimal license { get; set; }
        public Decimal miscLicense { get; set; }
        public Decimal cancellation { get; set; }
        public Decimal restock { get; set ; }
        public Decimal excise { get; set; }
        public Decimal electronicFile { get; set; }
        public Decimal tire { get; set; }
        public Decimal smogabatement { get; set; }
        public Decimal smogcert { get; set; }
        public Decimal stateRate { get; set; }
        public Decimal countyRate { get; set; }
        public Decimal cityRate { get; set; }

        public dealFees() {

        }
    }
    */


    /////////////////////////////
    //  Remote Actions
    /////////////////////////////
    
    /*
     * selectStockNumber() ARG: VehicleID
     */
    @RemoteAction
    public static List<dealer__Vehicle_Inventory__c> selectStockNumber(String stkid) {
        List<dealer__Vehicle_Inventory__c> inventory = [Select dealer__Year__c, dealer__Vehicle_Type__c, dealer__Vehicle_Size__c, dealer__Trim_Level__c,
                                                                dealer__Vehicle_Cost__c, dealer__VIN__c, dealer__Stock_Number__c, dealer__Status_Code__c, 
                                                                dealer__Sale_Date__c, dealer__Retail_Price__c, dealer__Reserve_Price__c, dealer__New_Tires__c, 
                                                                dealer__NUO__c, dealer__Model__c, dealer__Model_Code__c, dealer__Mileage__c, 
                                                                dealer__Memo_Two__c, dealer__Memo_One__c, dealer__Make__c, dealer__Location__c, 
                                                                dealer__License__c, dealer__License_Exp__c, dealer__Inventory_Date__c, 
                                                                dealer__In_Stock__c, dealer__Holdback__c, dealer__Days_in_Stock__c, dealer__Coded_Cost__c, 
                                                                dealer__Body_Type__c, dealer__Keyless_Entry_Code__c, dealer__Demo_Indicator__c, 
                                                                dealer__Ignition_Key_Code__c, dealer__MSRP__c, dealer__Pack__c, 
                                                                dealer__Exterior_Color__c, dealer__Title_Type__c, dealer__Fuel_Type__c, dealer__Work_in_Process__c,
                                                                dealer__Invoice_Price__c, dealer__Engine_Description__c, dealer__Transmission_Type__c 
                                                                From dealer__Vehicle_Inventory__c 
                                                                where Id = :stkid
                                                                and IsDeleted=false 
                                                                Limit 1];

        return inventory;
    }
    
    /*
     *  Lookup Contact records based on ID
     */
    @RemoteAction
    public static Contact lookupContact(String cid){
        return [Select Id, FirstName, LastName, Phone, MobilePhone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode
                From Contact
               where Id =:cid 
                Limit 1];
    }
    
    @RemoteAction
    public static Account lookupAccount(String aid) {
        return [SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude, Name, Type, Id, Phone 
                FROM Account
               Where Id =: aid
               limit 1];
    }
    
    @RemoteAction
    public static dealer__Tax_Zones__c getTaxZone(String statezone) {
        
        dealer__Tax_Zones__c  taxzone = new dealer__Tax_Zones__c();
        List<String> s = statezone.split(':');
        if(s.size()!=2) { return taxzone; }
        taxzone = [SELECT Id, dealer__City__c , dealer__County__c , dealer__Postal_Code__c , dealer__Rate__c, dealer__State__c 
                                    FROM dealer__Tax_Zones__c
                                    WHERE dealer__State__c =:s[0] and dealer__County__c =:s[1]
                                   LIMIT 1];

        return taxzone;
    }

    @RemoteAction
    public static boolean saveServiceContract(String serviceContractJSON) {
        System.debug(serviceContractJSON);
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(serviceContractJSON);

        // Create Service Contract Object
        dealer__Service_Contract__c contract = new dealer__Service_Contract__c();
        contract.dealer__Car_Deal__c            =   String.valueOf(m.get('deal_id'));
        contract.dealer__Contract_Template__c   =   false;
        contract.dealer__Sale_Price__c          =   Decimal.valueOf(String.valueOf(m.get('price')));

        System.debug(contract);

        return false;
    }
    
    public void saveTradesData(string tradeJSON) {
        
        List<dealer__Trade_In__c> tradeList = new List<dealer__Trade_In__c>();
        String jsonResponse = '{"tradeIn":[' +tradeJSON+ ']}';
        System.debug('------jsonResponse--------'+jsonResponse);
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(jsonResponse);   
        List<Object> lstTradeIn = (List<Object>)results.get('tradeIn');
        System.debug('-------lstTradeIn------'+lstTradeIn.size());
        for (Object tradeIn : lstTradeIn) {
            System.debug('-------tradeIn------'+tradeIn);
            // now get attributes for this customer.
            dealer__Trade_In__c trade = new dealer__Trade_In__c();
            Map<String, Object> tradeInAttributes  = (Map<String, Object>)tradeIn;
            // System.debug('-------tradeInAttributes------'+tradeInAttributes.values());
            // now loop through our customer attributes.
            if(tradeInAttributes!=null) {
            for (String attributeName : tradeInAttributes.keyset()) {
                System.debug('-------attributeName------'+attributeName);
                System.debug('-------tradeInAttributes.get(attributeName)------'+tradeInAttributes.get(attributeName));
                
                if(attributeName == 'serviceVehId'){
                    trade.dealer__Service_Vehicle__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'appraisalVehId'){
                    trade.dealer__Appraisal_Vehicle__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'number'){
                    trade.dealer__Position__c = Decimal.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'acv'){
                    trade.dealer__ACV__c = Decimal.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'allowance'){
                    trade.dealer__Trade_Allowance__c = Decimal.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'payoff'){
                    trade.dealer__Pay_Off_Amount__c = Decimal.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'vin'){
                    trade.dealer__VIN__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'stock'){
                    trade.dealer__Stock_Number__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'odometer'){
                    trade.dealer__Odometer_at_Trade_In__c = Decimal.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'lost'){
                    trade.dealer__Lost_Trade__c = Boolean.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'year'){
                    trade.dealer__Year__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'make'){
                    trade.dealer__Make__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'model'){
                    trade.dealer__Model__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'payoffAccount'){
                    trade.dealer__Pay_Off_Account__c = String.valueOf(String.valueOf(tradeInAttributes.get(attributeName)));
                }
                if(attributeName == 'payoffExp'){
                
                    //Date expDate = Date.newInstance(tradeInAttributes.get(attributeName));
                    //System.debug('PAYOFF1:'+String.valueOf(tradeInAttributes.get(attributeName)));
                    //System.debug('PAYOFF2:'+Date.valueOf(String.valueOf(tradeInAttributes.get(attributeName))));
                    String strDate = String.valueOf(tradeInAttributes.get(attributeName));
                    System.debug('-------strDate----'+strDate);
                    if(strDate != ''){
                        list<String> lstSplitDate = strDate.split('-');
                        Date myDate = date.newinstance(Integer.valueOf(lstSplitDate[0]), Integer.valueOf(lstSplitDate[1]), Integer.valueOf(lstSplitDate[2]));
                        trade.dealer__Pay_Off_Expiration_Date__c = myDate;
                    }
                    //trade.dealer__Pay_Off_Expiration_Date__c = expDate;
                }
                
             }
            // If VIN is present and Year,Make,Model not perform VIN Decode
            if(trade.dealer__VIN__c.length()==17 && (trade.dealer__Year__c==null && trade.dealer__Model__c == null && trade.dealer__Make__c == null)) {
                VINDecoder vd = new VINDecoder();
                
                vd.DecodeVIN(trade.dealer__VIN__c);
                VINDecoder_DataOneSoftware.DecodeResponseStruct ddat = vd.decode;
                
                trade.dealer__Year__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.year);
                trade.dealer__Make__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.make);
                trade.dealer__Model__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.model);
            }
             
             System.debug('-------trade---------'+trade);
             tradeList.add(trade);

            } // End null check
        }
        for(dealer__Trade_In__c trade :tradelist){
            trade.dealer__Car_Deal__c   =   deal.id;    
        }
        
        try {
            insert tradeList; 
        } catch (DmlException e) {
        }
        //return tradeList;
    }
    
    @RemoteAction
    public static dealer__Trade_In__c saveTrades(string tradeJSON) {
        Map<String, Object> t = (Map<String, Object>)JSON.deserializeUntyped(tradeJSON);
        Boolean isUpdate      = false;
        dealer__Trade_In__c trade = new dealer__Trade_In__c();
        if(String.valueOf(t.get('Id'))!=null && String.valueOf(t.get('Id'))!='') {
            isUpdate = true;
            trade = [Select Id, dealer__Year__c, dealer__Make__c, dealer__Model__c from dealer__Trade_In__c where Id=:String.valueOf(t.get('Id')) limit 1];
        } else {
            trade.dealer__Car_Deal__c   =   String.valueOf(t.get('deal'));
        }

        trade.dealer__Position__c   =   Decimal.valueOf(String.valueOf(t.get('number')));
        trade.dealer__ACV__c        =   Decimal.valueOf(String.valueOf(t.get('acv')));
        trade.dealer__Trade_Allowance__c    =   Decimal.valueOf(String.valueOf(t.get('allowance')));  
        trade.dealer__Pay_Off_Amount__c     =   Decimal.valueOf(String.valueOf(t.get('payoff')));
        trade.dealer__VIN__c                =   String.valueOf(t.get('vin'));
        trade.dealer__Stock_Number__c       =   String.valueOf(t.get('stock'));
        trade.dealer__Odometer_at_Trade_In__c=  Decimal.valueOf(String.valueOf(t.get('odometer')));
        trade.dealer__Lost_Trade__c         =   Boolean.valueOf(t.get('lost'));
        trade.dealer__Year__c               =   String.valueOf(t.get('year'));
        trade.dealer__Make__c               =   String.valueOf(t.get('make'));
        trade.dealer__Model__c              =   String.valueOf(t.get('model'));
        if(String.valueOf(t.get('payoffAccount')) == '000000000000000' || String.valueOf(t.get('payoffAccount')) == ''){
            trade.dealer__Pay_Off_Account__c = null;
        }else{
            trade.dealer__Pay_Off_Account__c = String.valueOf(t.get('payoffAccount'));
        }
        String strDate                      = String.valueOf(t.get('payoffExp'));
        if(strDate != ''){
            list<String> lstSplitDate = strDate.split('-');
            Date myDate = date.newinstance(Integer.valueOf(lstSplitDate[0]), Integer.valueOf(lstSplitDate[1]), Integer.valueOf(lstSplitDate[2]));
            trade.dealer__Pay_Off_Expiration_Date__c = myDate;
        }
        //trade.dealer__Pay_Off_Expiration_Date__c = Date.valueOf(t.get('payoffExp'));
        
        // If VIN is present and Year,Make,Model not perform VIN Decode
        if(trade.dealer__VIN__c.length()==17 && (trade.dealer__Year__c==null && trade.dealer__Model__c == null && trade.dealer__Make__c == null)) {
            VINDecoder vd = new VINDecoder();
            
            vd.DecodeVIN(trade.dealer__VIN__c);
            VINDecoder_DataOneSoftware.DecodeResponseStruct ddat = vd.decode;
            
            trade.dealer__Year__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.year);
            trade.dealer__Make__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.make);
            trade.dealer__Model__c = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.model);
        }


        if(isUpdate) {
            try {
                update trade; 
            } catch (DmlException e) {
                return null;
            }
        } else {
            try {
                insert trade; 
            } catch (DmlException e) {
                return null;
            }
        }
        return trade;
    }

    /**
    *   Add a new Aftermkarket item
    */
     public PageReference saveWeOweLineItem() { 

        list<dealer__Parts_Kit__c> pi = [SELECT Id, Name, dealer__Description__c, dealer__Kit_Cost__c, dealer__Kit_List__c
                                         FROM dealer__Parts_Kit__c WHERE Id =:selectedPartNumber limit 1];

        // TODO: Add part properties here
        //partItem = new addParts(); 
        if (pi.size() > 0) {

            // Build AM object to attach to 
            dealer__After_Market__c am  =   new dealer__After_Market__c();
            am.dealer__Car_Deal__c      =   deal.Id;
            am.Name                     =   pi[0].Name;
            am.dealer__Description__c   =   pi[0].dealer__Description__c;
            am.dealer__Cost__c          =   pi[0].dealer__Kit_Cost__c;
            am.dealer__Sale_Price__c    =   pi[0].dealer__Kit_List__c; // Set Sale Price to List Price

            try {
                insert am;
                //totalAftermarketItems(); // DR2 commented out
            } catch (DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to save the Part item.  Error: '+e));
                return null;            
            }
 
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to save the Part item.  Error: No results returned with ID:'+selectedPartNumber));

        }
        /********** passing tab number to return (added by KVP)************/
        PageReference dealPage = new ApexPages.StandardController(deal).view();
        if(seletedTabId == null){
            seletedTabId = '0';
        }
        //Initializing selectedTabId based on page and seletedTabId
        seletedTabId = returnTabId() != '0' ? returnTabId() : seletedTabId;
        dealPage.getParameters().put('tabno', seletedTabId);  
        dealPage.setRedirect(true);
        return dealPage;
    } 
    
    @RemoteAction
    public static dealer__After_Market__c addAfterMarketItem(String aftermarketjson) {
        dealer__After_Market__c am = new dealer__After_Market__c();

        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(aftermarketjson);
        am.dealer__Car_Deal__c = String.valueOf(m.get('dealId'));
        am.dealer__Sale_Price__c = (Double.valueOf(m.get('parts')) + Double.valueOf(m.get('labor')));
        am.dealer__Parts_Sale__c = Double.valueOf(m.get('parts'));
        am.dealer__Labor_Sale__c = Double.valueOf(m.get('labor'));
        am.dealer__Description__c= String.valueOf(m.get('description'));
        if(String.valueOf(m.get('kit'))!=null && String.valueOf(m.get('kit'))!= '') {
            am.dealer__Parts_Kit__c  = String.valueOf(m.get('kit'));
        }
        try {
            insert am;
        } catch(DmlException e) {
            return null;
        }

        return am;
    }
    
    
    @RemoteAction
    public static boolean deleteAftermarketItem(String aId) {
        dealer__After_Market__c[] deleteIds = [Select Id from dealer__After_Market__c where Id =: aId limit 1];
        // Added By KVP to delete We-Owe Lines
        dealer__We_Owe_Line__c[] weOweLineIds = [Select Id FROM dealer__We_Owe_Line__c WHERE dealer__After_Market_Id__c =:aId LIMIT 1];
        try {
            delete deleteIds;
            delete weOweLineIds;
        } catch (DmlException e) {
            return false;
        }
        return true;
    }

    @RemoteAction
    public static dealer__Sales_Fee__c saveFee(String feeJSON) {
        Boolean isUpdate   =    false;
        // Get Picklist Items 
        Schema.DescribeFieldResult fieldResult  =   dealer__Sales_Fee__c.dealer__Fee_Name__c.getDescribe();
        List<Schema.PickListEntry> feelist      =   fieldResult.getPicklistValues();
        Map<String, String> listOptions = new Map<String, String>();
        for(Schema.PicklistEntry pv : feelist) {
            listOptions.put(pv.getLabel(), pv.getValue());
        }

        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(feeJSON);
        if(String.valueOf(m.get('dealId'))=='' || String.valueOf(m.get('dealId'))==null) { return null; } 
        if(String.valueOf(m.get('feeName'))=='' || String.valueOf(m.get('dealId'))==null) { return null; }
        if(String.valueOf(m.get('feeAmount'))=='' || String.valueOf(m.get('feeAmount'))==null) { return null; }
        if(!listOptions.containsKey(String.valueOf(m.get('feeName')))) {
            return null;
        }

        dealer__Sales_Fee__c fee = new dealer__Sales_Fee__c();
        if(String.valueOf(m.get('feeId'))!=''&&String.valueOf(m.get('feeId'))!=null) {
            fee =  [Select Id from dealer__Sales_Fee__c where Id=:String.valueOf(m.get('feeId')) limit 1];
            isUpdate = true;
        } else {
            fee.dealer__Car_Deal__c     =   String.valueOf(m.get('dealId'));
        }

        fee.Name                    =   String.valueOf(m.get('feeName'));
        fee.dealer__Description__c  =   String.valueOf(m.get('feeName'));
        fee.dealer__Fee_Name__c     =   String.valueOf(m.get('feeName'));
        fee.dealer__Fee_Amount__c   =   Double.valueOf(m.get('feeAmount'));        

        if(isUpdate) {
            try {
                update fee;
                return fee;
            } catch(DmlException e) {
                return null;
            }
        } else {
            try {
                insert fee;
                return fee;
            } catch(DmlException e) {
                return null;
            }
        }
        return null;
    }

    @RemoteAction
    public static boolean saveImpactOnOff(String s) {
        dealer__SalesDeskLogSettings__c c = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(c==null) { 
            Desking_EXT.setApplicationCache(); 
            c = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        }
        Boolean enabled = false;
        if(s=='true') {
            enabled = true;
        }
        c.dealer__Enable_Impact_Forms__c = enabled;
        try {
            update c;
        } catch(DmlException e) {
            return false;
        }
        return true;
    }

    @RemoteAction
    public static boolean saveImpactPrinterName(String s) {
        dealer__SalesDeskLogSettings__c c = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(c==null) { 
            Desking_EXT.setApplicationCache(); 
            c = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        }
        c.dealer__Impact_Printer_Name__c = s;
        try {
            update c;
        } catch(DmlException e) {
            return false;
        }
        return true;
    }
    
    //Method to update finance gross
    public void updateFinanceGross(){
          
         if(deal.Finance_Institution_Account__c != null ){
            dealer__Finance_Company__c[] finCompany = [select dealer__Reserve_Percentage__c from dealer__Finance_Company__c where id=: deal.Finance_Institution_Account__c];
            if(finCompany.size() > 0){
                deal.dealer__Finance_Gross__c = finCompany[0].dealer__Reserve_Percentage__c != null ? (((deal.dealer__Rate__c/100) * deal.dealer__Amt_Financed__c) - ((deal.dealer__Buy_Rate__c/100) * deal.dealer__Amt_Financed__c)) * (finCompany[0].dealer__Reserve_Percentage__c/100) : null;
            }
         }
    }
    
    //Method to rollup all service contracts group by type and 
    public void rollupSummaries(){      
       //dealer__Deal__c updateDeal =  new dealer__Deal__c(id=carDealId);
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
         iswarrPrem = false;
         isMainPrem = false;
         isGAPPrem  = false;
         isOtherPrem = false; 
        if(dms.Service_Contract_For_Warr_Premium__c!=null) {
          system.debug('&&&&&dms.Service_Contract_For_Warr_Premium__c**'+dms.Service_Contract_For_Warr_Premium__c);
        }
        if(dms.Service_Contract_For_Gap_Premium__c!=null) {
          system.debug('&&&&&dms.Service_Contract_For_Gap_Premium__c**'+dms.Service_Contract_For_Gap_Premium__c);
        }
        if(dms.Service_Contract_For_Maint_Premium__c!=null) {
              system.debug('&&&&&dms.Service_Contract_For_Maint_Premium__c**'+dms.Service_Contract_For_Maint_Premium__c);
        }

        for(AggregateResult  ar : [Select  dealer__Car_Deal__c,dealer__Type__c, sum(dealer__Sale_Price__c),sum(dealer__Gross__c) 
                                 From dealer__Service_Contract__c WHERE dealer__Car_Deal__c = :deal.id
                                 group by dealer__Car_Deal__c, dealer__Type__c]){
             System.debug('***aggregate**:'+ar);                        
              
               if(dms != null && (String)ar.get('dealer__Type__c') == dms.Service_Contract_For_Warr_Premium__c){
                    deal.dealer__Warranty_Premium__c = (Double)ar.get('expr0');
                    deal.dealer__Ext_Warr_Gross__c   = (Double)ar.get('expr1');
                    iswarrPrem = true;
               }
               else if(dms != null && (String)ar.get('dealer__Type__c') == dms.Service_Contract_For_Gap_Premium__c){
                    deal.GAP_Premium__c       = (Double)ar.get('expr0');
                    deal.dealer__GAP_Gross__c = (Double)ar.get('expr1');
                    isGAPPrem = true;
               }
               else if(dms != null && (String)ar.get('dealer__Type__c')  == dms.Service_Contract_For_Maint_Premium__c){
                    deal.Maintenance_Premium__c       = (Double)ar.get('expr0');
                    deal.dealer__Maintenance_Gross__c = (Double)ar.get('expr1');
                    isMainPrem = true;
               }else{ 
                    deal.dealer__Other_Premium__c     = (Double)ar.get('expr0');
                    deal.dealer__Aftermarket_Gross__c = (Double)ar.get('expr1');
                    isOtherPrem = true;
               }     

        }//End of for
        
        if(!iswarrPrem){
             deal.dealer__Warranty_Premium__c = null;
             deal.dealer__Ext_Warr_Gross__c   = null;
        }
        if(!isGAPPrem){
              deal.GAP_Premium__c             = null;
              deal.dealer__GAP_Gross__c       = null;
        }
        if(!isMainPrem){
            deal.Maintenance_Premium__c       = null;
            deal.dealer__Maintenance_Gross__c = null;
        }
        if(!isOtherPrem){
            deal.dealer__Other_Premium__c     = null;
            deal.dealer__Aftermarket_Gross__c = null;
        }
        
       
   }
   
   
    //Method to rollup all service contracts group by type
    public void rollupSummaryEvaluate(){  
        rollupSummaries();
        System.debug('TEST:updateDeal::'+deal);
        if(deal.id != null){
            update deal;
        } 
    }
    
    public class FormsWrapper{
        public dealer__Form__c objForm{get;set;}
        public boolean selected {get;set;}
        
        public FormsWrapper(dealer__Form__c form){
            objForm = form;
            selected = false;
        }
    }
}