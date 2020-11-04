/**
* DMSDealCreate_EXT 
* @description Interacts with middleware and DealerTrack to create a Deal from SalesUp
*/

public with sharing class DMSDealCreate_EXT {
    //related records
    
    /**
     * @description
     */ 
    public dealer__Sales_Up__c sup {get;set;}
    
    /**
     * @description
     */ 
    public dealer__Vehicle_Inventory__c inv{get;set;} 
    
    /**
     * @description
     */ 
    private Contact con1;
    
    /**
     * @description
     */ 
    private Contact con2;
    
    /**
     * @description
     */ 
    public User sp1{get;set;}
    
    /**
     * @description
     */ 
    public User sp2{get;set;}
    
    /**
     * @description
     */ 
    public User fi{get;set;}
    
    /**
     * @description
     */ 
    public User dm {get;set;}
    
    /**
     * @description
     */ 
    public User bdc {get;set;}
    
    /**
     * @description
     */ 
    public dealer__Service_Contract__c sercon{get;set;}
    
    /**
     * @description
     */ 
    public dealer__Service_Vehicle__c trade{get;set;}
    
    /**
     * @description
     */ 
    public Account acc1 {get;set;}
    
    /**
     * @description
     */ 
    public Account acc2 {get;set;}
    
    /**
     * @description
     */ 
    public dealer__Appraisal_Vehicle__c aprveh {get;set;}
    
    /**
     * @description
     */ 
    public dealer__Dealer_Location__c loc {get;set;}

    //for testing 
    
    /**
     * @description
     */ 
    public String errConID, newConId;

    /**
     * @description
     */ 
    public List<dealer__Appraisal_Vehicle__c> tradeInsSup {get;set;}

    /**
     * @description
     */ 
    private Map<String, Object> jresp;
    
    /**
     * @description
     */ 
    public Map<String, Object> customers {get;set;}
    
    /**
     * @description
     */ 
    public List<Object> customerList {get;set;}
    
    /**
     * @description
     */ 
    public List<Map<String, Object>> custFields {get;set;}
    
    /**
     * @description
     */ 
    public Map<String, dealer__Appraisal_Vehicle__c> vinToAprVeh {get;set;}
    
    /**
     * @description
     */ 
    public Integer aprVehCount {get{
        if(loc.dealer__Include_Trade_In__c)return vinToAprVeh.keySet().size();
        else return 0;
    }
    set;}


    //Id of record from stdController
    
    /**
     * @description 
     */ 
    private final Id supId;

    //Native validation errors
    
    /**
     * @description
     */ 
    public String errorMessage {get;set;}

    //Update or insert SF objects

    /**
     * @description
     */
    public Boolean updCust, updSup, insDeal;

    /**
     * @description
     */
    public Boolean success {get;set;}

    //If validate fields is successful

    /**
     * @description
     */
    public Boolean valid {get;set;}

    //deal to be created
    
    /**
     * @description
     */
    public dealer__Deal__c newDeal {get;set;}

    //Response from DMS
    
    /**
     * @description
     */
    public String dmsRes {get;set;}
    
    /**
     * @description
     */
    public String customerNumber {get;set;}
    
    /**
     * @description
     */
    public String dealNumber {get;set;}
    
    /**
     * @description
     */
    public String result {get;set;}

    //To send to DMS
    
    /**
     * @description
     */
    public String jsonString {get;set;}

    /**
     * @description
     */
    public String calloutError{get;set;}

    //customer external ID
    
    /**
     * @description
     */
    public String custId {get;set;}
    
    /**
     * @description
     */
    public String custName {get;set;}

    //To indicate to middleware to create a new customer
    
    /**
     * @description
     */
    public String createNewValue{get;set;}

    /**
     * DMSDealCreate_EXT 
     * @param  stdController 
     * @return DMSDealCreate_EXT
     * @description
     */ 
    public DMSDealCreate_EXT(ApexPages.StandardController stdController) 
    {
        supId = stdController.getId();

        //gather related records: sales up, vehicle, service contract
        gatherInfo();
        validateFields();

        System.debug(valid);
    }

     /*
      * @Method      : gatherInfo
      * @Description : queries for related records needed for deal payload creation, sets private variables
      * @Param       : none
      * @return      : void  
      * @author Mimi Sakarett
      * @date 2016.05.17
      */
    
    /**
     * gatherInfo 
     * @return void
     * @description
     */ 
    public void gatherInfo()
    {
        this.sup = 
        [SELECT d.Id, d.dealer__Company_Number__c, d.dealer__Store_Location__c, 
            
            d.dealer__Desired_Stock_Num__r.dealer__Stock_Number__c, 
            d.dealer__Desired_Stock_Num__r.dealer__Mileage__c, d.dealer__Desired_Stock_Num__c, 
            d.dealer__Desired_Stock_Num__r.dealer__Year__c, d.dealer__Desired_Stock_Num__r.dealer__VIN__c,
            d.dealer__Desired_Stock_Num__r.dealer__Model__c, d.dealer__Desired_Stock_Num__r.dealer__Make__c, 
            d.dealer__Desired_Stock_Num__r.dealer__Retail_Price__c, 

            d.dealer__Trade_VIN__c, d.dealer__Trade_Make__c, d.dealer__Trade_Mileage__c, d.dealer__Trade_Model__c,
            d.dealer__Trade_Year__c, d.dealer__Trade_Body_Type__c,


            d.dealer__Salesperson_1__r.EmployeeNumber, d.dealer__Salesperson_1__r.Name, 
            d.dealer__CCC_Rep__r.EmployeeNumber, d.dealer__CCC_Rep__r.Name, 
            d.dealer__Salesperson_2__r.EmployeeNumber, d.dealer__Salesperson_2__r.Name, 
            d.dealer__Desk_Manager_User__r.EmployeeNumber, d.dealer__Desk_Manager_User__r.Name, 
            d.dealer__F_I_Manager__c, d.dealer__F_I_Manager__r.EmployeeNumber, d.dealer__F_I_Manager__r.Name, 
            


            d.dealer__Service_Vehicle__r.dealer__VIN__c, d.dealer__Service_Vehicle__r.dealer__Stock_Number__c,
            d.dealer__Service_Vehicle__r.dealer__Year__c, d.dealer__Service_Vehicle__r.dealer__Make__c,
            d.dealer__Service_Vehicle__r.dealer__Trim_Level__c, d.dealer__Service_Vehicle__r.dealer__Last_Odometer__c,
            d.dealer__Service_Vehicle__r.dealer__Carline__c,
            
            d.dealer__Customer_Account__r.PersonOtherPhone, d.dealer__Customer_Account__r.FirstName,
            d.dealer__Customer_Account__r.PersonMailingStreet, d.dealer__Customer_Account__r.PersonMailingCity, 
            d.dealer__Customer_Account__r.PersonMailingPostalCode, d.dealer__Customer_Account__r.PersonMailingState, 
            d.dealer__Customer_Account__r.PersonMobilePhone,  d.dealer__Customer_Account__r.dealer__External_ID__c,
            d.dealer__Customer_Account__r.PersonBirthdate, d.dealer__Customer_Account__r.PersonHomePhone,
            d.dealer__Customer_Account__r.LastName, d.dealer__Customer_Account__r.dealer__Drivers_License_Number__pc,
            d.dealer__Customer_Account__r.PersonEmail, d.dealer__Customer_Account__r.dealer__Gender__c,
            
            d.dealer__Buyer_Contact__c, d.dealer__Buyer_Contact__r.Birthdate,d.dealer__Buyer_Contact__r.Email,
            d.dealer__Buyer_Contact__r.HomePhone,d.dealer__Buyer_Contact__r.MailingAddress,
            d.dealer__Buyer_Contact__r.MobilePhone,d.dealer__Buyer_Contact__r.Phone,
            d.dealer__Buyer_Contact__r.dealer__Drivers_License_Expiration_Date__c,
            d.dealer__Buyer_Contact__r.dealer__Drivers_License_Number__c,d.dealer__Buyer_Contact__r.dealer__External_ID__c,
            d.dealer__Buyer_Contact__r.FirstName,
            d.dealer__Buyer_Contact__r.LastName, 

            d.dealer__Co_Buyer__c, d.dealer__Co_Buyer__r.PersonOtherPhone, d.dealer__Co_Buyer__r.FirstName,
            d.dealer__Co_Buyer__r.PersonMailingStreet, d.dealer__Co_Buyer__r.PersonMailingCity, 
            d.dealer__Co_Buyer__r.PersonMailingPostalCode, d.dealer__Co_Buyer__r.PersonMailingState, 
            d.dealer__Co_Buyer__r.PersonMobilePhone,  d.dealer__Co_Buyer__r.dealer__External_ID__c,
            d.dealer__Co_Buyer__r.PersonBirthdate, d.dealer__Co_Buyer__r.PersonHomePhone,
            d.dealer__Co_Buyer__r.LastName, d.dealer__Co_Buyer__r.dealer__Drivers_License_Number__pc,
            d.dealer__Co_Buyer__r.PersonEmail, d.dealer__Co_Buyer__r.dealer__Gender__c,

            d.dealer__Co_Buyer_Contact__c, d.dealer__Co_Buyer_Contact__r.Birthdate,d.dealer__Co_Buyer_Contact__r.Email,
            d.dealer__Co_Buyer_Contact__r.HomePhone,d.dealer__Co_Buyer_Contact__r.MailingAddress,
            d.dealer__Co_Buyer_Contact__r.MobilePhone,d.dealer__Co_Buyer_Contact__r.Phone,
            d.dealer__Co_Buyer_Contact__r.dealer__Drivers_License_Expiration_Date__c,
            d.dealer__Co_Buyer_Contact__r.dealer__Drivers_License_Number__c,d.dealer__Co_Buyer_Contact__r.dealer__External_ID__c,
            d.dealer__Co_Buyer_Contact__r.FirstName,
            d.dealer__Co_Buyer_Contact__r.LastName

            

            FROM dealer__Sales_Up__c d
            WHERE d.Id =:supId 
            LIMIT 1];
            


        inv = sup.dealer__Desired_Stock_Num__r;
        con1 = sup.dealer__Buyer_Contact__r;
        con2 = sup.dealer__Co_Buyer_Contact__r;
        sp1 = sup.dealer__Salesperson_1__r;
        sp2 = sup.dealer__Salesperson_2__r;
        fi  = sup.dealer__F_I_Manager__r;
        dm  = sup.dealer__Desk_Manager_User__r;
        bdc = sup.dealer__CCC_Rep__r;
        trade = sup.dealer__Service_Vehicle__r;
        acc1 = sup.dealer__Customer_Account__r;
        acc2 = sup.dealer__Co_Buyer__r;



        loc = [SELECT Id, dealer__OT_Company_Number__c, dealer__OT_Enterprise_Code__c, dealer__OT_Server_Name__c,
                    dealer__Default_Days_to_First_Payment__c, dealer__Include_Trade_In__c
                    FROM dealer__Dealer_Location__c 
                    WHERE Id=:sup.dealer__Store_Location__c];


        tradeInsSup = [SELECT av.Id, av.dealer__Year__c, av.dealer__Make__c, av.dealer__Model__c, av.dealer__Body_Type__c,
                            av.dealer__VIN__c,
                            
                            av.dealer__Appraisal__c, av.dealer__Appraisal__r.dealer__ACV_Actual_Cash_Value__c,
                            av.dealer__Appraisal__r.dealer__Lost_Appraisal__c, 

                            av.dealer__Service_Vehicle__c, av.dealer__Service_Vehicle__r.dealer__Stock_Number__c, 
                            av.dealer__Service_Vehicle__r.dealer__Last_Odometer__c,
                            av.dealer__Service_Vehicle__r.dealer__Ext_Color__c,

                            av.dealer__Service_Vehicle__r.dealer__VIN__c, 
                            av.dealer__Service_Vehicle__r.dealer__Year__c, av.dealer__Service_Vehicle__r.dealer__Make__c,
                            av.dealer__Service_Vehicle__r.dealer__Trim_Level__c, 
                            av.dealer__Service_Vehicle__r.dealer__Carline__c

                            FROM dealer__Appraisal_Vehicle__c av WHERE dealer__Sales_Up__c =:sup.Id];

        vinToAprVeh = new Map<String, dealer__Appraisal_Vehicle__c>();

        for(dealer__Appraisal_Vehicle__c v : tradeInsSup){
            vinToAprVeh.put(v.dealer__VIN__c, v);
        }
        
        if(tradeInsSup.size()>0) aprveh = tradeInsSup[0];

        //Get the dealer location, which contains OpenTrack credentials


        //Including the service contract which is location specific
        dealer__Service_Contract__c[] scontracts =  [SELECT Id, dealer__External_Id__c,dealer__Expiration_Months__c,dealer__SDRecordKey__c
            FROM dealer__Service_Contract__c 
            WHERE dealer__Contract_Template__c = True AND dealer__Location__c = :sup.dealer__Store_Location__c
            AND dealer__Default_on_Retail_Deals__c = True
            LIMIT 1];

        sercon = new dealer__Service_Contract__c();
        if(!scontracts.isEmpty()) {
            sercon = scontracts[0];
        }               
    }

    /**
    * @Method      : create
    * @Description : user has validated fields and wants to go ahead with deal creation
    * @Param       : none
    * @Return      : PageReference, either to failure page or new Deal page
    */
    public PageReference create()
    {
        String debugString = '';
        System.debug('Create Called.');
        
        //validate DTeam requirements
        if(validateFields()) errorMessage = 'Fields Validated!';
        else{
            return Page.DMSDealCreateResultsPage;
        }

        //create payload using JSON.serialize()
        String jsonPay = createPayloadSerialize();

        System.debug(jsonPay);

        //create request
        HttpRequest hReq = buildRequest(jsonPay);

        // Callout
        dmsRes = callOut(hReq);


        //Callout failed again with error read time out.
        if(dmsRes == null && calloutError == 'Read timed out')
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Deal Add failed due to time out. Please try again.'));
        }
        else
        {
            errorMessage = (String)jresp.get('message');
            String errorCode = (String)jresp.get('errorCode');
            customerNumber =  (String)jresp.get('customerNumber');
            dealNumber =  (String)jresp.get('dealNumber');
            success = (Boolean)jresp.get('success');

            //More than one customer match returned from DealerTrack DMS
            if(errorCode == 'X579'){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select one of the pre-existing customers below.'));
                custFields = new List<Map<String, Object>>();
                
                //get customer wrapper
                customers = (Map<String, Object>)jresp.get('customers');

                //get cusotmer data
                customerList = (List<Object>)customers.get('CustomerSearchResult');

                Map<String, Object> custInfoReplaceBlanks;

                //add each customer to the list
                for(Object o : customerList){
                    Map<String, Object> tmp = (Map<String, Object>)o;
                    custInfoReplaceBlanks = new Map<String, Object>();

                    for(String s : tmp.keySet()){
                        if(!(tmp.get(s) instanceof String)){
                            custInfoReplaceBlanks.put(s, 'xxx');
                        }
                        else{
                            custInfoReplaceBlanks.put(s, (String)tmp.get(s));
                        } 
                    }

                    custFields.add(custInfoReplaceBlanks);
                    
                }

                //create and populate the FullName field for easy viewing on VF page of full name
                for(Map<String,Object> m : custFields){
                    m.put('FullName', (String)m.get('FirstName')+' '+(String)m.get('LastName'));
                }
            }
            if(success) debugString = updateSF();
        }
        System.debug(jsonPay);
        System.debug(result);
        System.debug(debugString);
        return Page.DMSDealCreateResultsPage;
    }

    /**
    * @Method      : validateFields
    * @Description : performs validation checks on DealerTeam field requirements and sets the error message with details
    * @Param       : none
    * @return      : Boolean if validation is successful  
    */
    public Boolean validateFields()
    {

        valid = true;

        

        // Validate that Employee Numbers are present for the included employees
        String requiredEmployeeMessage = '';
        if(sp1!=null && sp1.EmployeeNumber==null) {
             requiredEmployeeMessage += ' Salesperson 1 Employee Number Required.';
             valid=false;
        }

        if(sp2!=null && sp2.EmployeeNumber==null) {
            requiredEmployeeMessage += ' Salesperson 2 Employee Number Required.';
            valid=false;
        }

        if(dm!=null && dm.EmployeeNumber==null) {
            requiredEmployeeMessage += ' Desk Manager Employee Number Required.';
            valid=false;
        }

        if(fi!=null && fi.EmployeeNumber==null) {
             requiredEmployeeMessage += ' Finance Manager 1 Employee Number Required.';
             valid=false;
        } 

        if(bdc!=null && bdc.EmployeeNumber==null) {
            requiredEmployeeMessage += ' BDC Employee Number Required.';
            valid=false;
        }        

        if(requiredEmployeeMessage!='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, requiredEmployeeMessage));
        }

        //MKS 8/2/16 moved the unique logic inside else, because this message appears if anyone is missing an employee number
        else {
            //Validate that each salesperson and manager on the Sales Up are unique. 
            //If the BDC Rep and the SP2 are the same, exclude the BDC rep.

            //if the bdc rep and sp2 are the same, only add bdc
            //if they are not the same, add both

            List<String> empNum = new List<String>();

            if(bdc != sp2 && bdc != null){
                empNum.add(bdc.EmployeeNumber);
            }
            if(sp2 != null){
                empNum.add(sp2.EmployeeNumber);
            }
            if(sp1 != null){
                empNum.add(sp1.EmployeeNumber);
            }
            if(fi != null){
                empNum.add(fi.EmployeeNumber);
            }
            if(dm != null){
                empNum.add(dm.EmployeeNumber);
            }
            
            Set<String> empNumSet = new Set<String>(empNum);

            
            if(empNumSet.size() < empNum.size()){
                
                errorMessage = 'Each employee assigned to the Sales Up must be unique.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
                System.debug(errorMessage);
                 valid = false;
            }
        } 

        if(inv == null){
            errorMessage = 'Must have attached desired vehicle to the Sales Up';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;
        }
        else if(inv.dealer__Retail_Price__c == null){
            errorMessage = 'The desired vehicle must have a retail price';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;
        }
        if(con1 == null && acc1 == null){
            errorMessage = 'Must have attached Customer to the Sales Up';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;
        }
        if(sp1 == null){
            errorMessage = 'Must have attached Salesperson to the Sales Up';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;
        }
        if(fi == null){
            errorMessage = 'Must have attached F & I Manager to the Sales Up';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;
        }

        //if the service contract exists and doesn't have external keys set, display a warning.
        if(sercon.Id != null && (sercon.dealer__SDRecordKey__c == null 
            || sercon.dealer__External_Id__c == null || sercon.dealer__External_Id__c == '')){
            errorMessage = 'The default Service Contract does not have the SD Record Key or the BO Record Key set';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, errorMessage));
            System.debug(errorMessage);
        }

        if(loc ==null || loc.dealer__OT_Company_Number__c == null || loc.dealer__OT_Company_Number__c == '' 
            || loc.dealer__OT_Enterprise_Code__c == null || loc.dealer__OT_Enterprise_Code__c == '' 
            || loc.dealer__OT_Server_Name__c == null || loc.dealer__OT_Server_Name__c == ''){

            errorMessage = 'Must have OpenTrack variables set for the Location. Contact your administrator';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            System.debug(errorMessage);
            valid = false;

        }
        
        return valid;
    }

    
    /**
    * @Method      : createPayloadSerialize
    * @Description : constructs a payload from the queried information to pass to middleware using JSON.Serialize
    * @Param       : none
    * @Return      : String the JSON payload
    */
    public String createPayloadSerialize()
    {

        DealFields df = new DealFields(loc);

        df.OTCompNum = loc.OT_Company_Number__c;
        df.OTEntCode = loc.OT_Enterprise_Code__c;
        df.OTSerNam = loc.OT_Server_Name__c;

        //df.CompanyNumber = sup.dealer__Company_Number__c;
        df.CompanyNumber = 'AD1';
        df.RecordType = 'F';
        df.VehicleType = 'U';
        df.SaleType = 'R';
        df.SearchName = acc1.LastName+', '+acc1.FirstName;
        df.StockNumber = inv.dealer__Stock_Number__c;
        df.VIN = inv.dealer__VIN__c;
        df.RetailPrice = ''+inv.dealer__Retail_Price__c;
        df.APR = '4.99';
        df.RetailTerm = '72';
        df.FinReserveOverride = 'N';
        df.BuyRate = '2';
        df.ReserveHoldbackPercent = '30';
        df.LoanOriginationFee = '0';
        df.InsuranceTerm = '1';
        df.TaxGroupKey = '""';//from dealsettingstable
        df.LendingSourceKey = '""';//from dealsettingstable
        df.GAPSource = '""';//from dealsettingstable
        df.GAPCode = '""';//from dealsettingstable
        df.AandHCode = '0';

        if(acc1!=null && acc1.dealer__External_ID__c !=null) {
            df.BuyerNumber = acc1.dealer__External_ID__c;
        }

        if(acc2 != null){
            df.CoBuyerNumber = acc2.dealer__External_ID__c;
        }

        //MKS 9/1/16 check setting for trade in on location object
        if(loc.dealer__Include_Trade_In__c){
            if(tradeInsSup.size() > 0){
                for(dealer__Appraisal_Vehicle__c ap : tradeInsSup){
                    TradeInFields tif = new TradeInFields(ap, ap.dealer__Appraisal__r, ap.dealer__Service_Vehicle__r);
                    if(tif.VIN == null || tif.VIN == '')                tif.VIN = sup.dealer__Trade_VIN__c;
                    if(tif.TradeYear == null || tif.TradeYear == '')    tif.TradeYear = sup.dealer__Trade_Year__c;
                    if(tif.TradeMake == null || tif.TradeMake == '')    tif.TradeMake = sup.dealer__Trade_Make__c;
                    if(tif.TradeModel == null || tif.TradeModel == '')  tif.TradeModel = sup.dealer__Trade_Model__c;
                    if(tif.TradeBody == null || tif.TradeBody == '')    tif.TradeBody = sup.dealer__Trade_Body_Type__c;

                    TradeInWrapper tw = new TradeInWrapper(tif);
                    df.addTradeIn(tw);
                }
            }
        }

        if(sercon!=null){
            ServiceContractFields scf = new ServiceContractFields(sercon);
            scf.CustomerKey = ''+acc1.dealer__External_ID__c;
            scf.VIN = ''+inv.dealer__VIN__c;
            if(inv.dealer__Mileage__c != null){
                scf.StartingOdometer = ''+inv.dealer__Mileage__c;
            }else scf.StartingOdometer = '0';
            ServiceContractWrapper scw = new ServiceContractWrapper(scf);

            df.addSerCon(scw);
        }

        if(sp1!=null){
            SalesPersonFields sp = new SalesPersonFields(sp1, 'S', 'P');
            SalesPersonWrapper spw = new SalesPersonWrapper(sp);
            df.addSalesPerson(spw);
        }
        if(sp2!=null){
            SalesPersonFields sp = new SalesPersonFields(sp2, 'S', '');
            SalesPersonWrapper spw = new SalesPersonWrapper(sp);
            df.addSalesPerson(spw);
        }
        if(fi !=null){
            SalesPersonFields sp = new SalesPersonFields(fi, 'F', '');
            SalesPersonWrapper spw = new SalesPersonWrapper(sp);
            df.addSalesPerson(spw);
        }
        if(dm !=null){
            SalesPersonFields sp = new SalesPersonFields(dm, 'M', '');
            SalesPersonWrapper spw = new SalesPersonWrapper(sp);
            df.addSalesPerson(spw);
        }
        if(bdc !=null && bdc !=sp2){
            SalesPersonFields sp = new SalesPersonFields(bdc, 'S', '');
            SalesPersonWrapper spw = new SalesPersonWrapper(sp);
            df.addSalesPerson(spw);
        }

        JSONWrapper jw = new JSONWrapper();
        jw.account = acc1;
        jw.createNew = this.createNewValue;
        if(acc2 != null) jw.cobuyer = acc2;
        DealWrapper dw = new DealWrapper(df);
        jw.dealwrapper = dw;

        jsonString = JSON.serialize(jw);
        return JSON.serialize(jw);
    }

    //begin inner classes
        public class JSONWrapper{
            public Account account;
            public Account cobuyer;
            public DealWrapper dealwrapper;
            public String createNew;
        }

        public class DealWrapper{
            public DealFields Deal;

            public DealWrapper(DealFields df){
                Deal = df;
            }
        }

        public class SalesPersonsClass
        {
            public List<SalesPersonFields> SalesPerson = new List<SalesPersonFields>();
        }

        public class TradeInsClass
        {
            public List<TradeInFields> TradeIn = new List<TradeInFields>() ;
        }

        public class ServiceContractsClass
        {
            public List<ServiceContractFields> ServiceContract = new List<ServiceContractFields>();
        }

        public class DealFields{
            TradeInsClass TradeIns = new TradeInsClass();
            SalesPersonsClass SalesPersons = new SalesPersonsClass();
            ServiceContractsClass ServiceContracts = new ServiceContractsClass();

            public String 
            OTCompNum, OTEntCode, OTSerNam, CreateNewCustomer,
            CompanyNumber, RecordType, VehicleType, SaleType, BuyerNumber, SearchName, 
            StockNumber, VIN, RetailPrice, APR, RetailTerm, FinReserveOverride, BuyRate, 
            ReserveHoldbackPercent, LoanOriginationFee, TaxGroupKey, LendingSourceKey, 
            GAPSource, GAPCode, DaysToFirstPayment, InsuranceTerm, AandHCode, TradeFromLease,
            CoBuyerNumber;

            public DealFields(dealer__Dealer_Location__c location){
                TradeFromLease = 'N';
                if(location.dealer__Default_Days_to_First_Payment__c != null){
                    DaysToFirstPayment = ''+location.dealer__Default_Days_to_First_Payment__c;
                }
                else DaysToFirstPayment = '0';
            }

            public void addSalesPerson(SalesPersonWrapper sp){
                SalesPersons.SalesPerson.add(sp.SalesPerson);
            }
            public void addTradeIn(TradeInWrapper ti){
                TradeIns.TradeIn.add(ti.TradeIn);
            }

            public void addSerCon(ServiceContractWrapper scw){
                ServiceContracts.ServiceContract.add(scw.ServiceContract);
            }
        }

        public class ServiceContractWrapper{
            public ServiceContractFields ServiceContract;

            public ServiceContractWrapper(ServiceContractFields scf){
                ServiceContract = scf;
            }
        }

        public class ServiceContractFields{
            public String VIN, CustomerKey, StartingOdometer, CoBuyerKey, ContractName, BORecordKey,
            ContractAmount, ContractExpirationMonths, ContractStartDate, ContractEndDate, SDRecordKey, 
            ServiceContractSequence, ContractExpirationMiles, EndingMiles;
            
            public ServiceContractFields(dealer__Service_Contract__c sc){
                BORecordKey = ''+sc.dealer__External_Id__c;
                ContractExpirationMonths = ''+sc.dealer__Expiration_Months__c;
                ContractName = 'AUCTION DIRECT WARRANTY';//hard
                ContractStartDate = Datetime.now().format('YYYYMMdd');
                ContractEndDate = Datetime.now().addMonths(60).format('YYYYMMdd');
                ContractAmount = '1995.00';//hard
                EndingMiles = '100000';//hard
                ContractExpirationMiles = '100000';
                SDRecordKey = ''+sc.dealer__SDRecordKey__c;
            }
        }

        public class TradeInWrapper{
            public TradeInFields TradeIn;

            public TradeInWrapper(TradeInFields tif){
                TradeIn = tif;
            }
        }

        public class TradeInFields{
            public String VIN, StockNumber, TradeYear, TradeMake, TradeModel, 
                TradeSaleGroup, TradeAllowance, TradeColor, ACV, PayoffAmount,
                Odometer, TradeBody;

            public TradeInFields(dealer__Appraisal_Vehicle__c av, dealer__Appraisal__c ap, dealer__Service_Vehicle__c sv){
                TradeSaleGroup = 'UC';

                if(av != null){
                    VIN = av.dealer__VIN__c;
                    TradeYear = av.dealer__Year__c;
                    TradeMake = av.dealer__Make__c;
                    TradeModel = av.dealer__Model__c;
                    TradeBody = av.dealer__Body_Type__c;
                }
                if(sv != null){
                    StockNumber = sv.dealer__Stock_Number__c;
                    TradeColor = sv.dealer__Ext_Color__c;
                    Odometer = ''+sv.dealer__Last_Odometer__c;
                }

                if(ap != null)
                    ACV = ''+ap.dealer__ACV_Actual_Cash_Value__c;
            }
        }

        public class SalesPersonWrapper{
            SalesPersonFields SalesPerson;

            public SalesPersonWrapper(SalesPersonFields spf){
                SalesPerson = spf;
            }
        }
        public class SalesPersonFields{
            public String SalesPersonID, SalesPersonType, SubType, SalesPersonName, SaleDate, CountUnit, 
            UnitCount, CommissionGross, RecordType;


            public SalesPersonFields(User u, String spType, String spSubType){
                SalesPersonID = u.EmployeeNumber;
                SalesPersonType = spType;
                SubType = spSubType;
                SalesPersonName = u.Name;
                SaleDate = Datetime.now().format('YYYYMMdd');
                UnitCount = '1';
                CommissionGross = '0';
                RecordType = '';

                if(spSubType == 'P'){
                    CountUnit = 'Y';
                }
            }
        }
    //End inner classes
    
    /**
    * @Method      : buildRequest
    * @Description : constructs the HttpRequest object, setting endpoint, method, body, etc
    * @Param       : String the JSON payload
    * @Return      : HttpRequest the HttpRequest with all variables set
    */
    public HttpRequest buildRequest(String payload) 
    {
        HttpRequest req = new HttpRequest();
        //req.setEndpoint('https://apsv1.dealerteam.com/api/dealertrack/dealCreateV2.php?');
        req.setEndpoint('https://apps.dealerteam.com/dealertrackdms/opentrack/dealadd');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');

        if(payload == null) {
            System.debug('Null payload.');
            return null;
        }
        
        req.setBody(payload);
        return req;
    }

    /**
    * @Method      : callOut
    * @Description : performs callout to the middleware, handles exceptions, and returns the response
    * @Param       : HttpRequest An HttpReuest with endpoint, method, body set
    * @Return      : String the response from the middleware
    */
    public String callOut(HttpRequest hreq)
    {
        //create HTTP object and do the callout.
        Http h = new Http();
            try{
                result = h.send(hreq).getBody();
                System.debug(result);
                jresp = (Map<String, Object>) JSON.deserializeUntyped(result);
                System.debug(jresp.get('success'));
                
                return result;
            }catch(CalloutException e){
                String result = h.send(hreq).getBody();
                System.debug('error result: '+result);
                //throw new dmsException('Callout failed '+e.getMessage());
                calloutError = e.getMessage();
                return null;
            }
    }

    /**
    * @Method      : updateSF
    * @Description : creates a Deal in DealerTeam
    * @Param       : none
    * @Return      : void
    */
    public String updateSF()
    {
        String debugString = '';
        //extract deal info
        Map<String, Object> dealInfoMap = (Map<String, Object>)jresp.get('dealFields');
        //Map<String, Object> dealInfoMap = (Map<String, Object>)dealInfoDMS.get('Deal');

        Boolean replaceExtId = false;
        String oldName = '';

        //update account
        if(acc1.dealer__External_ID__c == null || acc1.dealer__External_ID__c == '' || acc1.dealer__External_ID__c == 'AAAAAAAA'){
            acc1.dealer__External_ID__c = customerNumber;
            try{
                update acc1;
            } catch (DMLException e){
                System.debug(e.getMessage());
                
                List<Account> errAcct = [SELECT Id, FirstName, LastName FROM Account WHERE dealer__External_ID__c =:customerNumber];
                if(errAcct.size()>0){
                    for(Account y : errAcct){
                        y.dealer__External_ID__c = '';
                    }
                    oldName = errAcct[0].FirstName+' '+errAcct[0].LastName;
                }
                
                
                //errAcct.dealer__External_Id__c = '';
                acc1.dealer__External_ID__c = customerNumber;

                System.debug('the account external id is: '+customerNumber);
                update errAcct[0];
                update acc1;


                replaceExtId = true;
            } 
        }

        //update contact if it exists
        if(con1 != null && (con1.dealer__External_ID__c == null || con1.dealer__External_ID__c == '' || con1.dealer__External_ID__c == 'BBBBBBBB')){
            con1.dealer__External_ID__c = customerNumber;
            try{
                update con1;
            } catch (DMLException e){
                System.debug(e.getMessage());
                List<Contact> errCont = [SELECT Id, Name, dealer__External_ID__c FROM Contact WHERE dealer__External_ID__c =:customerNumber];
                if(errCont.size()>0){
                    for(Contact x : errCont){
                        x.dealer__External_ID__c = '';
                    }
                    oldName = errCont[0].Name;
                }
                con1.dealer__External_ID__c = customerNumber;
                newConId = con1.Id;

                update errCont;
                update con1;
                replaceExtId = true;
            } 
        }

        //update cobuyer
        if(acc2 != null ){
            if(acc2.dealer__External_ID__c == '' || acc2.dealer__External_ID__c == null){
                acc2.dealer__External_ID__c = (String)dealInfoMap.get('CoBuyerNumber');
                try{
                    update acc2;
                } catch (DMLException e){
                    System.debug(e.getMessage());
                    String fullError = e.getMessage();
                    String[] words = fullError.split('[^a-zA-Z0-9]');

                    String errorId;
                    for (String s : words){
                        if(s.contains('001E') && s != acc2.Id){
                            errorId = s;
                        }
                    }

                    Account errAcct = [SELECT Id, dealer__External_ID__c FROM Account WHERE Id =:errorId];
                    oldName = errAcct.Name;
                    errAcct.dealer__External_Id__c = '';
                    update errAcct;
                    update acc2;

                    replaceExtId = true;
                } 
            }

            if(con2.dealer__External_ID__c == '' || con2.dealer__External_ID__c == null){
                con2.dealer__External_ID__c = customerNumber;
                try{
                    update con2;
                } catch (DMLException e){
                    System.debug(e.getMessage());
                    String fullError = e.getMessage();
                    String[] words = fullError.split('[^a-zA-Z0-9]');

                    String errorId;
                    for (String s : words){
                        if(s.contains('003E') && s != con2.Id){
                            errorId = s;
                        }
                    }

                    Contact errCont = [SELECT Id, dealer__External_ID__c FROM Contact WHERE Id =:errorId];
                    oldName = errCont.Name;
                    errCont.dealer__External_Id__c = '';
                    update errCont;
                    update con2;

                    replaceExtId = true;
                }
            
            }   
        }

        if(replaceExtId){ 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Customer Number belonged to '+oldName));
        }

        Date capDate = null;
        if((String)dealInfoMap.get('DateCapped') != '00010101'){
            //capDate = Utility.stringToDate((String)dealInfoMap.get('DateCapped'));
        }
        String warranty = 'No';
        if(Double.valueOf(dealInfoMap.get('ServiceContractAmount')) > 0) warranty = 'Yes';

        //Create Deal
        newDeal = new dealer__Deal__c(
            dealer__Company_Number__c = sup.dealer__Company_Number__c,
            dealer__Store_Location__c = sup.dealer__Store_Location__c,
            dealer__Sales_Lead__c = sup.Id,
            dealer__Salesperson_1__c = sp1.Id,
            dealer__Salesperson_1_Name__c = sp1.Name,
            dealer__Salesperson_1_Number__c = sp1.EmployeeNumber,
            dealer__F_I_Manager__c = fi.Id,
            dealer__F_I_Manager_Name__c = fi.Name,
            dealer__F_I_Manager_Number__c = fi.EmployeeNumber,

            dealer__Buyer__c = acc1.Id,
            dealer__Buyer_Address__c = acc1.PersonMailingStreet, 
            dealer__Buyer_Birthdate__c = acc1.PersonBirthdate, 
            dealer__Buyer_City__c = acc1.PersonMailingCity, 
            
            //dealer__Buyer_County__c, 
            //dealer__Buyer_Drivers_License_Exp_Date__c = acc1.dealer__Drivers_License_Expiration_Date__pc, 
            //dealer__Buyer_Drivers_License__c = acc1.dealer__Drivers_License_Number__c, 
            dealer__Buyer_Email__c = acc1.PersonEmail, 
            dealer__Buyer_First_Name__c = acc1.FirstName, 
            dealer__Buyer_Gender__c = acc1.dealer__Gender__c, 
            dealer__Buyer_Home_Phone__c = acc1.PersonHomePhone, 
            dealer__Buyer_Last_Name__c = acc1.LastName, 
            dealer__Buyer_Mobile_Phone__c = acc1.PersonMobilePhone, 
            dealer__Buyer_Postal_Code__c = acc1.PersonMailingPostalCode, 
            //dealer__Buyer_Social_Security_Number__c, 
            dealer__Buyer_State__c = acc1.PersonMailingState, 
            dealer__Buyer_Work_Phone__c = acc1.PersonOtherPhone,
            
            dealer__Vehicle__c = inv.Id,
            dealer__Year__c = inv.dealer__Year__c,
            dealer__Make__c = inv.dealer__Make__c,
            dealer__Model__c = inv.dealer__Model__c,
            dealer__Stock_Number__c = inv.dealer__Stock_Number__c,
            dealer__VIN__c = inv.dealer__VIN__c,

            dealer__Deal_ID__c = sup.dealer__Company_Number__c+':'+dealNumber,
            Name = dealNumber+' '+acc1.LastName+', '+acc1.FirstName,

            dealer__Warranty__c = warranty,

            dealer__GAP_Premium__c = Double.valueOf(dealInfoMap.get('GAPPremium')),
            dealer__GAP_Cost__c = Double.valueOf(dealInfoMap.get('GAPCost')),

            dealer__Total_Cash_Down__c = Double.valueOf(dealInfoMap.get('DownPayment')),
            dealer__Rate__c = Integer.valueOf(dealInfoMap.get('BuyRate')),
            dealer__Term__c = Integer.valueOf(dealInfoMap.get('RetailTerm')),
            dealer__Amt_Financed__c = Double.valueOf(dealInfoMap.get('AmountFinanced')),
            dealer__Front_End_Gross__c = Double.valueOf(dealInfoMap.get('CommissionableGross')),
            dealer__Back_End_Gross__c = Double.valueOf(dealInfoMap.get('TotalFandIReserve')),
            dealer__Finance_Gross__c = Double.valueOf(dealInfoMap.get('FinanceReserve')),

            dealer__Deal_Close_Date__c = capDate,
            dealer__Deal_Date__c = Utility.stringToDate((String)dealInfoMap.get('DealDate')),
            dealer__Deal_Type__c = (String)dealInfoMap.get('SaleType'),

            dealer__Trade_Allowance__c = Double.valueOf(dealInfoMap.get('TradeAllowance')),
            dealer__Trade_Payoff__c = Double.valueOf(dealInfoMap.get('TradePayoff')),
            

            dealer__Last_Pymt_Date__c = Utility.stringToDate((String)dealInfoMap.get('DateLastPayment')),
            dealer__First_Payment_Date__c = Utility.stringToDate((String)dealInfoMap.get('DateFirstPayment')),
            dealer__List_Price__c = Double.valueOf(dealInfoMap.get('MSRP')),
            dealer__Monthly_Pymt__c = Double.valueOf(dealInfoMap.get('FinancedPayment')),
            dealer__NUO__c = (String)dealInfoMap.get('VehicleType'),
            dealer__Down_Pymt__c = Double.valueOf(dealInfoMap.get('DownPayment')),
            dealer__Deposit__c = Double.valueOf(dealInfoMap.get('DepositReceived')),
            dealer__Financial_Inst__c = '',
            dealer__Ext_Warr_Gross__c = Double.valueOf(dealInfoMap.get('ServiceContractAmount')) - Double.valueOf(dealInfoMap.get('ServiceContractCost'))
        );

        //If contact present,
            if(con1 != null){
                newDeal.dealer__Buyer_Contact__c = con1.Id;
            }

        //If co-buyer present, set fields
            if(acc2 != null){
                newDeal.dealer__Co_Buyer__c = acc2.Id;
                newDeal.dealer__Co_Buyer_Address__c = acc2.PersonMailingStreet; 
                newDeal.dealer__Co_Buyer_City__c = acc2.PersonMailingCity; 
                //newDeal.dealer__Co_Buyer_County__c; 
                //newDeal.dealer__Co_Buyer_Drivers_License_Exp_Date__c = acc2.dealer__Co_Drivers_License_Expiration_Date__pc; 
                //newDeal.dealer__Co_Buyer_Drivers_License__c = acc2.dealer__Co_Drivers_License_Number__c; 
                newDeal.dealer__Co_Buyer_Email__c = acc2.PersonEmail; 
                newDeal.dealer__Co_Buyer_First_Name__c = acc2.FirstName; 
                newDeal.dealer__Co_Buyer_Gender__c = acc2.dealer__Gender__c; 
                newDeal.dealer__Co_Buyer_Home_Phone__c = acc2.PersonHomePhone; 
                newDeal.dealer__Co_Buyer_Last_Name__c = acc2.LastName; 
                newDeal.dealer__Co_Buyer_Mobile_Phone__c = acc2.PersonMobilePhone; 
                newDeal.dealer__Co_Buyer_Postal_Code__c = acc2.PersonMailingPostalCode; 
                //newDeal.dealer__Co_Buyer_Social_Security_Number__c; 
                newDeal.dealer__Co_Buyer_State__c = acc2.PersonMailingState; 
                newDeal.dealer__Co_Buyer_Work_Phone__c = acc2.PersonOtherPhone;

                if(con2 != null){
                    newDeal.dealer__Co_Buyer_Contact__c = con2.Id; 
                }
            }
        
        //Check if Salesperson 2 and/or Desk Manager populated, then set fields on deal
            if(sp2 != null){
                newDeal.dealer__Salesperson_2__c = sp2.Id;
                newDeal.dealer__Salesperson_2_Name__c = sp2.Name;
                newDeal.dealer__Salesperson_2_Number__c = sp2.EmployeeNumber;
                
            }

            if(dm != null){
                newDeal.dealer__Desk_Manager__c = dm.Id;
                newDeal.dealer__Desk_Manager_Name__c = dm.Name;
                newDeal.dealer__Desk_Manager_Number__c = dm.EmployeeNumber;
            }

        insert newDeal;

        //Create Trade In(s)
        if(trade != null && loc.dealer__Include_Trade_In__c){
            newDeal.dealer__Service_Vehicle__c = trade.Id;

                Map<String, Object> tradeIns = (Map<String, Object>)dealInfoMap.get('TradeIns');

                //if there are multiple trades present
                if(tradeIns.get('TradeIn') instanceof List<Object>){
                    List<Object> trades = (List<Object>) tradeIns.get('TradeIn');
                    List<dealer__Trade_In__c> tradesToInsert = new List<dealer__Trade_In__c>();
                    for(Object o : trades){
                        Map<String, Object> tradeInfo = (Map<String,Object>) o;

                        //Get the records related to this trade in
                        String curVIN = (String)tradeInfo.get('VIN');
                        dealer__Appraisal_Vehicle__c av = vinToAprVeh.get(curVIN);
                        dealer__Service_Vehicle__c sv = av.dealer__Service_Vehicle__r;


                        dealer__Trade_In__c newTrade = new dealer__Trade_In__c();
                            newTrade.dealer__Pay_Off_Amount__c = Double.valueOf(tradeInfo.get('PayoffAmount'));
                            newTrade.dealer__ACV__c = Double.valueOf(tradeInfo.get('ACV'));
                            newTrade.dealer__Trade_Allowance__c = Double.valueOf(tradeInfo.get('TradeAllowance'));
                            
                            newTrade.dealer__Car_Deal__c = newDeal.Id;

                            if(sv != null){
                                newTrade.dealer__VIN__c = sv.dealer__VIN__c;
                                newTrade.dealer__Service_Vehicle__c = sv.Id;
                                newTrade.dealer__Stock_Number__c = sv.dealer__Stock_Number__c;
                                newTrade.dealer__Trim_Level__c = sv.dealer__Trim_Level__c;
                                newTrade.dealer__Year__c = sv.dealer__Year__c;
                                newTrade.dealer__Odometer_at_Trade_In__c = sv.dealer__Last_Odometer__c;
                                newTrade.dealer__Model__c = sv.dealer__Carline__c;
                                newTrade.dealer__Make__c = sv.dealer__Make__c;
                            }

                            if(av != null)
                                newTrade.dealer__Appraisal_Vehicle__c = av.Id;

                        tradesToInsert.add(newTrade);
                    }

                    insert tradesToInsert;
                }

                //if there is only one trade present
                else {
                    Map<String, Object> tradeIn = (Map<String, Object>)tradeIns.get('TradeIn');

                    dealer__Trade_In__c newTrade = new dealer__Trade_In__c(
                        dealer__ACV__c = Double.valueOf(tradeIn.get('ACV')),
                        dealer__Stock_Number__c = trade.dealer__Stock_Number__c,
                        dealer__Car_Deal__c = newDeal.Id,
                        dealer__Service_Vehicle__c = trade.Id,
                        dealer__Trade_Allowance__c = Double.valueOf(tradeIn.get('TradeAllowance')),
                        dealer__VIN__c = trade.dealer__VIN__c,
                        dealer__Trim_Level__c = trade.dealer__Trim_Level__c,
                        dealer__Year__c = trade.dealer__Year__c,
                        dealer__Odometer_at_Trade_In__c = trade.dealer__Last_Odometer__c,
                        dealer__Model__c = trade.dealer__Carline__c,
                        dealer__Make__c = trade.dealer__Make__c,
                        dealer__Pay_Off_Amount__c = Double.valueOf(tradeIn.get('PayoffAmount')),
                        dealer__Appraisal_Vehicle__c = aprveh.Id
                    );
                    String payoffdate = (String)tradeIn.get('PayoffExpireDate');
                    if(payoffdate.length() == 8){
                        newTrade.dealer__Pay_Off_Expiration_Date__c = Utility.stringToDate(payoffdate);
                    }
                System.debug('before insert: '+newTrade);
                insert newTrade;
                System.debug('after insert: '+newTrade);
            }   
        }
        
        //Create Service Contract
            Map<String, Object> serviceConts = (Map<String, Object>)dealInfoMap.get('ServiceContracts');
            Map<String, Object> serviceCont = (Map<String, Object>)serviceConts.get('ServiceContract');
            dealer__Service_Contract__c sc = new dealer__Service_Contract__c(
                    dealer__Car_Deal__c = newDeal.Id,
                    dealer__Cost__c = Double.valueOf(serviceCont.get('ContractCost')),
                    dealer__Deductable__c = Double.valueOf(serviceCont.get('ContractDeductible')),
                    dealer__Description__c = (String)serviceCont.get('ContractName'),
                    dealer__Expiration_Mileage__c = Integer.valueOf(serviceCont.get('ContractExpirationMiles')),
                    dealer__Expiration_Months__c = Integer.valueOf(serviceCont.get('ContractExpirationMonths')),
                    dealer__Odometer_at_Sale__c = Integer.valueOf(serviceCont.get('StartingOdometer')),
                    dealer__Sale_Price__c = Double.valueOf(serviceCont.get('ContractAmount')),
                    dealer__Start_Date__c = Utility.stringToDate((String)serviceCont.get('ContractStartDate'))
                );

            if(serviceCont.get('PlanCode') instanceof String) sc.dealer__Plan_Code__c = (String)serviceCont.get('PlanCode');
            if(serviceCont.get('ProductCode') instanceof String) sc.dealer__Product_Code__c = (String)serviceCont.get('ProductCode');
        
            // service contracts must have a term greater than 0, set to 1 if Zero
            if(sc.dealer__Expiration_Months__c==null || sc.dealer__Expiration_Months__c==0)
                sc.dealer__Expiration_Months__c=1;

            try {
                insert sc;
            } Catch(DmlException e) {
                
            }

        //Create Fees and Aftermarket Items
            Map<String, Object> dealFees = (Map<String, Object>)dealInfoMap.get('Fees');
            List<Object> fees = (List<Object>)dealFees.get('DealFee');

            List<dealer__Sales_Fee__c> salesFees = new List<dealer__Sales_Fee__c>();
            List<dealer__After_Market__c> amFees = new List<dealer__After_Market__c>();

            for(Object o : fees){
                Map<String, Object> fee = (Map<String,Object>)o;

                if((String)fee.get('RecordType') == 'A'){
                    dealer__After_Market__c tmp = new dealer__After_Market__c(
                        Name = dealNumber+' SC-'+inv.dealer__Stock_Number__c+' '+(String)fee.get('SequenceNumber'),
                        dealer__Car_Deal__c = newDeal.Id,
                        dealer__Description__c = (String)fee.get('Description'),
                        dealer__Cost__c = Double.valueOf(fee.get('Cost')),
                        dealer__Sale_Price__c = Double.valueOf(fee.get('AMOFeeAmount'))
                        );

                    amFees.add(tmp);
                }

                else{
                    dealer__Sales_Fee__c tmp = new dealer__Sales_Fee__c(
                        Name = dealNumber+' SC-'+inv.dealer__Stock_Number__c+' '+(String)fee.get('SequenceNumber'),
                        dealer__Car_Deal__c = newDeal.Id,
                        dealer__Description__c = (String)fee.get('Description'),
                        dealer__Fee_Amount__c = Double.valueOf(fee.get('AMOFeeAmount')),
                        dealer__Type__c = (String)fee.get('RecordType'),
                        dealer__Sequence_Number__c = Integer.valueOf(fee.get('SequenceNumber'))
                        );

                    salesFees.add(tmp);
                }
            }

        if(salesFees.size() > 0) insert salesFees;
        if(amFees.size() > 0) insert amFees;

        //Set sale price and sale cost based on deal type
            String saleType = (String)dealInfoMap.get('SaleType');
            if(saleType == 'R' || saleType == 'W' || saleType == 'F' || saleType == '2'){
                System.debug('setting sale price of deal: '+Double.valueOf(dealInfoMap.get('RetailPrice')));
                newDeal.dealer__Sale_Price__c = Double.valueOf(dealInfoMap.get('RetailPrice'));
                Double saleCost, vehicleCost, internalCost, addsToCostTotal;

                vehicleCost = Double.valueOf(dealInfoMap.get('VehicleCost'));
                internalCost = Double.valueOf(dealInfoMap.get('InternalCost'));
                addsToCostTotal = Double.valueOf(dealInfoMap.get('AddsToCostTotal')); 

                saleCost = vehicleCost+internalCost+addsToCostTotal;

                newDeal.dealer__Sale_Cost__c = saleCost;
            }
        update newDeal;

        //Update Sales Up
            dealer__Sales_Up__c up = new dealer__Sales_Up__c(
                Id = sup.Id,
                dealer__Car_Deal__c = newDeal.Id
                );

        upsert up;
        return debugString;  
    }

    /**
    * @Method      : createNewCust
    * @Description : user has selected to create a new customer in DealerTrack
    * @Param       : none
    * @Return      : DMSDealCreatePage
    */
    public PageReference createNewCust()
    {
        //If the user wants to create a new Customer for the Buyer
        if(acc1.dealer__External_ID__c == null || acc1.dealer__External_ID__c == ''){
            //set jsonwrapper variable to create new customer for buyer
            createNewValue = 'buyer';
        }
        //If the user wants to create a new Customer for the Co-Buyer
        else if(acc2 != null){
            //set jsonwrapper variable to create new customer for cobuyer
            createNewValue = 'cobuyer';
        }
        //If the user accessed this method in failure
        else{
            System.debug(LoggingLevel.ERROR, 'The Buyer has an external ID but the user was still able to click the Create New Customer button.');
        }
        
        customers = null;
        return Page.DMSDealCreatePage;
    }

    /**
    * @Method      : addCustInfo
    * @Description : user has selected a customer in VF, insert the info in the payload
    * @Param       : none
    * @Return      : DMSDealCreatePage
    */
    public PageReference addCustInfo()
    {
        if(acc1.dealer__External_ID__c == null || acc1.dealer__External_ID__c == ''){
            //update contact
            if(con1 != null){
               con1.dealer__External_ID__c = custId;
                update con1; 
            }

            //update account
            acc1.dealer__External_ID__c = custId;
            update acc1;
        }
        else if(acc2 != null){
            System.debug('account 1 external ID not blank: '+acc1.dealer__External_ID__c);
            //update contact
            if(con2 != null){
               con2.dealer__External_ID__c = custId;
                update con2; 
            }
            
            //update account
            acc2.dealer__External_ID__c = custId;
            update acc2;
        }
        else{
            System.debug(LoggingLevel.ERROR, 'The Buyer has an external ID but the user was still able to click the Select Customer button.');
        }
        
        customers = null;
        return Page.DMSDealCreatePage;
    }

    /**
    * @Method      : cancel
    * @Description : user has decided to return to sales up page
    * @Param       : none
    * @Return      : PageReference to sales up page
    */
    public PageReference cancel()
    {
        PageReference supView = (new ApexPages.Standardcontroller(sup)).view();
        return supView;
    }

    /**
    * @Method      : viewDeal
    * @Description : simple redirection to deal page
    * @Param       : none
    * @Return      : PageReference to deal page
    */
    public PageReference viewDeal()
    {
        PageReference dealView = (new ApexPages.Standardcontroller(newDeal)).view();
        return dealView;
    }

    /**
     * @description
     */
    public class dmsException extends Exception {}
}