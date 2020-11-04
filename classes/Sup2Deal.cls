public with sharing class Sup2Deal {

    public Deal__c deal {get;set;}
    List<Appraisal_Vehicle__c> appraisalVehList;
    public Vehicle_Inventory__c vehicle {get;set;}       
    public Dealer_Location__c location {get;set;} 
    public Id Conversion {get;set;} 
    public Id SalesUpId{get;set;}     


    public Sup2Deal( ApexPages.StandardController stdController ) {

        appraisalVehList = new List<Appraisal_Vehicle__c>();    
        
        SalesUpId = ApexPages.currentPage().getParameters().get('salesup');
        // Sales Up Passed as primary Record
        if(SalesUpId != null) {
            // Get Sales Up Data and Link to Deal
            deal = new Deal__c();
            deal.BuyerSaveToAccount__c = true;
            deal.CoBuyerSaveToAccount__c = true;

            buildDealFromSalesUp();
        }
    }

    public pagereference dealPage(){

        /*  Generate next number */
        if(deal.Id == null) {

            List<deal__c> listDeal = new List<deal__c>();
            Integer dealNo;
            
            //Get the deal number from Custom Settings

            if(Test.isRunningTest()){
                dealNo = 50;
                } else {
                    dealNo = Utility.nextDealNumber();     
                }

                deal.Deal_ID__c = String.valueOf(dealNo);            
                deal.Name = String.valueOf(dealNo);

                /*Begin W-000528  -- dr1 --*/
                try{
                    Database.UpsertResult results = Database.upsert(deal,true);
                    if(SalesUpId != null){
                        Sales_Up__c sup =[SELECT Id, Car_Deal__c FROM Sales_Up__c WHERE Id=:SalesUpId]; 
                        if(sup.Car_Deal__c == null){
                            sup.Car_Deal__c = this.deal.Id;
                            update sup;
                        }
                    }
                     
                     Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'DEAL CREATED: ' + deal.Id ));
                     }catch(DmlException e) {
                    // throw new mobException('Error creating Sales Up: ' + e.getMessage() );
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'DML Error >>'+ e.getMessage()));
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '<a href="/'+SalesUpId+'">Go Back to SalesUp</a>'));

                Pagereference pg= new Pagereference('/apex/SalesUpNewDeal?error=yes');
                return pg;
                
                }catch(exception e){
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error >>'+ e.getMessage()));
                    Pagereference pg= new Pagereference('/apex/SalesUpNewDeal?error=yes');
                    return pg;
                }
            //upsert deal;
            /*End W-000528  -- dr1 */ 

            //Method to populate sales-up's related Appraisals with deal number
            if(Conversion != null && deal.Deal_Type__c == 'Equipment Only'){
                DealAPI.createAfterMarketItems(Conversion, deal);
            }

            // Method call to save data in Trade In Object
            saveTradesData(); // --> then add this trade (Id) to appraisal

            DealAPI.deal dealData = new DealAPI.deal();
            dealData.dealHeader = deal;

            Tax_Zones__c [] availableZones = TaxAPI.getAvailableTaxZonesDeal('', dealData);
            if(availableZones.size() == 1){
                system.debug('One Tax Zone Was Returned - Add To deal Automatically and apply it');
                deal.Tax_Zone__c = availableZones[0].Id;
            }

			deal = DealCalculations.setDealTotals(deal);
            update deal;
        } 
        
        PageReference pg = new PageReference('/lightning/r/dealer__Deal__c/' + this.deal.id + '/view');
        return pg;
    }
    //update appraisal with deal number and trade vehicle
    public void updateAppraisal(List<Trade_In__c> TradeList){

        List<Appraisal__c> appraisals = new List<Appraisal__c>();

        for(Appraisal__c ap : [SELECT Id, Deal__c, Trade_In__c, Service_Vehicle__r.VIN__c, Sales_Up__c From Appraisal__c where Sales_Up__c =: SalesUpId ]){
            
        for(Trade_In__c t : TradeList){
            if(t.VIN__c == ap.Service_Vehicle__r.VIN__c){
                ap.Trade_In__c = t.Id;
            }
        }
        appraisals.add(new Appraisal__c(
            Id = ap.id,
            Deal__c = deal.Id,
            Trade_In__c = ap.Trade_In__c
            ));
        }  
        if(appraisals.size()>0){
        try {
            upsert appraisals;
            }catch(Exception e){
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'While updating appraisals: '+ e.getMessage()));
            }
        }
    }


    public void buildDealFromSalesUp() {

        /* Select the SalesUp and Related Data */
        Sales_Up__c sup = [SELECT Id, Buyer_Contact__c, Buyer_Contact__r.FirstName, Buyer_Contact__r.MiddleName, Buyer_Contact__r.LastName, Buyer_Contact__r.MobilePhone, Buyer_Contact__r.Email, Buyer_Contact__r.Drivers_License_Number__c, Buyer_Contact__r.Drivers_License_State__c, Buyer_Contact__r.Drivers_License_Expiration_Date__c, Buyer_Contact__r.Birthdate, Co_Buyer_Contact__c, Customer_Account__c, Customer_Account__r.IsPersonAccount,
        Co_Buyer__c, Desired_Stock_Num__c, Salesperson_1__c, Salesperson_2__c, 
        Desk_Manager_User__c, F_I_Manager__c,
        Trade_Comments__c, Trade_Make__c, Trade_Mileage__c, Trade_Model__c,
        Trade_VIN__c, Trade_Year__c, Service_Vehicle__c, Store_Location__c, 
        RecordType.DeveloperName, ConversionPartsKit__c,
            (Select Id, Name, Appraisal__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, 
            Service_Vehicle__c, Trim_Level__c, VIN__c, Year__c,
            Service_Vehicle__r.Stock_Number__c, Service_Vehicle__r.Last_Odometer__c, 
            Appraisal__r.Appraised_Value__c, Appraisal__r.ACV_Actual_Cash_Value__c, 
            Sales_Up__r.Customer_Account__r.Name, 
            Sales_Up__r.Customer_Account__c, 
            Appraisal__r.Appraisal_Date__c
            FROM Appraisal_Vehicles__r 
            Order By CreatedDate DESC)
        FROM Sales_Up__c 
        WHERE Id=:ApexPages.currentPage().getParameters().get('salesup')
        LIMIT 1];

        // Check to see if a service vehicle is present on the Sup.  If present on the SUP populate the Service Vehicle on the Deal
        if(sup.Service_Vehicle__c!=null && sup.RecordType.DeveloperName == 'Equipment_Only') {
            Service_Vehicle__c svcVehicle = [SELECT Id, Name, Carline__c, VIN__c, Stock_Number__c, 
            Make__c, Conversion__c, Vehicle_Type__c, Ext_Color__c, 
            Int_Color__c, Body_Type__c, Body_Style__c, Year__c,
            Trim_Level__c, Last_Odometer__c 
            FROM Service_Vehicle__c
            WHERE Id=:sup.Service_Vehicle__c LIMIT 1];

            deal.Service_Vehicle__c =   svcVehicle.Id;
            deal.VIN__c     =   svcVehicle.VIN__c;
            deal.Year__c    =   svcVehicle.Year__c;
            deal.Make__c    =   svcVehicle.Make__c;
            deal.Model__c   =   svcVehicle.Carline__c;
            deal.Trim_Level__c = svcVehicle.Trim_Level__c;
            deal.Mileage__c =   svcVehicle.Last_Odometer__c;
            deal.Exterior_Color__c  =   svcVehicle.Ext_Color__c;
            deal.Interior_Color__c  =   svcVehicle.Int_Color__c;
            deal.Deal_Type__c = 'Equipment Only'; 
        }
        else if(sup.Service_Vehicle__c==null && sup.RecordType.DeveloperName == 'Equipment_Only') {

            deal.Deal_Type__c = 'Equipment Only'; 
        }

        deal.Deal_Date__c = Date.today();
        deal.Sales_Lead__c = sup.Id;

        if(sup.ConversionPartsKit__c != null){
            Conversion = sup.ConversionPartsKit__c;
        }
        // Assign the Location Record
        if(sup.Store_Location__c!=null){

            deal.Store_Location__c = sup.Store_Location__c; 

            this.location = [SELECT Id ,VehicleTaxDefault__c, TaxConversion__c, Default_Days_to_First_Payment__c, Default_Rate__c, Default_Term__c, Postal_Code__c,Tax_Delivery_Address__c FROM Dealer_Location__c WHERE Id =:deal.Store_Location__c LIMIT 1];
            

        } else {

            User u  = [Select Id, Division from User where Id =:UserInfo.getUserId() limit 1];     

            if(u.Division==null) {
                throw new mobException('User MUST have Division set.');
            }

            this.location = [SELECT Id , VehicleTaxDefault__c, TaxConversion__c, Default_Days_to_First_Payment__c, Default_Rate__c, Default_Term__c, Postal_Code__c,Tax_Delivery_Address__c FROM Dealer_Location__c WHERE Company_Number__c =:u.Division LIMIT 1];
            deal.Store_Location__c = location.Id;
        } 

        // Get Defaults from the Location Record
        if(this.location!=null) {
            deal.Days_to_First__c = this.location.Default_Days_to_First_Payment__c;

            //Vehicle / Conversion Tax Defaults
            deal.IsVehicleTax__c = this.location.VehicleTaxDefault__c;
            deal.isConvertionTax__c = this.location.TaxConversion__c;

            if(this.location.Default_Rate__c != null) {
                deal.Rate__c = this.location.Default_Rate__c;     
            }
            deal.Term__c = this.location.Default_Term__c;
        }
        deal.Payments_Per_Year__c = 12;
        deal.Salesperson_1__c = sup.Salesperson_1__c;
        deal.Salesperson_2__c = sup.Salesperson_2__c;
        deal.Desk_Manager__c  = sup.Desk_Manager_User__c;
        deal.F_I_Manager__c   = sup.F_I_Manager__c;
        deal.Service_Vehicle__c = sup.Service_Vehicle__c;
        System.debug('Appraisal Vehicles  - '+sup.Appraisal_Vehicles__r.size());
        if(sup.Appraisal_Vehicles__r.size() > 0){  // W-000901
            appraisalVehList = sup.Appraisal_Vehicles__r;
        }
        if(sup.Desired_Stock_Num__c!=null) { 
            populateVehicle( sup.Desired_Stock_Num__c ); 
        }
        //populate sales up
        //populateAppraisalWithDeal(sup);


        if(sup.Customer_Account__c != null) {
            populateBuyerData(sup.Customer_Account__c); 
            if(sup.Buyer_Contact__c != null && sup.Customer_Account__r.IsPersonAccount == false){
                populateB2BContactData(sup);
            }
        } else if(sup.Buyer_Contact__c!=null) {
            // Get Account Id from Contact.
            Contact buyer = [Select Id, AccountId from Contact where Id=:sup.Buyer_Contact__c limit 1];
            populateBuyerData(buyer.AccountId); 
        }


        if(sup.Co_Buyer__c != null) {
            populateCoBuyerData(sup.Co_Buyer__c); 
            } else if(sup.Co_Buyer_Contact__c!=null) {

                Contact cobuyer = [Select Id, AccountId from Contact where Id=:sup.Co_Buyer_Contact__c limit 1];
                populateCoBuyerData(cobuyer.AccountId); 
            }

        // Setting Other default Fields
        deal.Pickup_or_Delivery__c = 'Pickup';

        if(deal.Deal_Type__c==null) {
            deal.Deal_Type__c = 'Chassis / Conversion';
        }


    }

    public void populateVehicle(String vehId) {

        Vehicle_Inventory__c v = [SELECT Year__c, Vehicle_Type__c, Vehicle_Size__c, Trim_Level__c,
            Vehicle_Cost__c, VIN__c, Stock_Number__c, Status_Code__c, 
            Sale_Date__c, Retail_Price__c, Reserve_Price__c, New_Tires__c, 
            NUO__c, Model__c, Model_Code__c, Mileage__c, 
            Memo_Two__c, Memo_One__c, Make__c, Location__c, 
            License__c, License_Exp__c, Inventory_Date__c, 
            In_Stock__c, Holdback__c, Days_in_Stock__c, Coded_Cost__c, 
            Body_Type__c, Keyless_Entry_Code__c, Demo_Indicator__c, 
            Ignition_Key_Code__c, MSRP__c, Pack__c, 
            Exterior_Color__c, Title_Type__c, Fuel_Type__c, Work_in_Process__c,
            Invoice_Price__c,Conversion__c,Conversion_Cost__c, Conversion_Price__c, Conversion_Description__c,Conv_Model__c
            FROM Vehicle_Inventory__c 
            WHERE Id = :vehId
            AND IsDeleted=false 
            LIMIT 1];

        deal.Vehicle__c = v.Id;
        deal.Stock_Number__c = v.Stock_Number__c;
        deal.Year__c = v.Year__c;
        deal.Make__c = v.Make__c;
        deal.Model__c = v.Model__c;
        deal.VIN__c = v.VIN__c;
        deal.NUO__c = v.NUO__c;
        deal.Mileage__c = v.Mileage__c;
        deal.Ext_Color__c = v.Exterior_Color__c;
        deal.Trim_Level__c = v.Trim_Level__c;
        // deal.Licence__c = v.License__c;
        // deal.License_Expiration__c = v.License_Exp__c;

        deal.List_Price__c = v.MSRP__c;
        deal.Sale_Cost__c = v.Vehicle_Cost__c;        
        deal.Sale_Price__c = v.Retail_Price__c;
        
        deal.Vehicle_Price__c = v.Retail_Price__c;
        deal.Vehicle_Cost__c = v.Vehicle_Cost__c;

        deal.Conversion_Price__c = v.Conversion_Price__c;

        vehicle = v;
    }

    public void saveTradesData(){
        List<Trade_In__c> listTradeIn = new List<Trade_In__c>();
        Integer i=1;

        if(deal.Deal_Type__c == 'Equipment Only') {
            return;
        }
        Set<Id> appraisalIdSet = new Set<Id>();
        for(Appraisal_Vehicle__c av : appraisalVehList){
            if(av.Appraisal__c != null && !appraisalIdSet.contains(av.Appraisal__c))
                appraisalIdSet.add(av.Appraisal__c);
        }
        Map<Id,LoanPayoff__c> loanPayoffMap = new Map<Id,LoanPayoff__c>();//appraisal Id , Loan Payoff  

        for(LoanPayoff__c lp : [SELECT Id, Appraisal__c, PayoffAmount__c FROM LoanPayoff__c WHERE Appraisal__c  IN: appraisalIdSet]){
            if(loanPayoffMap.get(lp.Appraisal__c) == null)
                loanPayoffMap.put(lp.Appraisal__c, lp);
        }


        for(Appraisal_Vehicle__c objApp: appraisalVehList){
            Trade_In__c trade = new Trade_In__c();
            string tradeName = '('+deal.Name+')';
            if(objApp.Year__c!=null){
                tradeName+=' '+objApp.Year__c;
            }
            if(objApp.Make__c!=null){
                tradeName+=' '+objApp.Make__c;
            }
            if(objApp.Model__c!=null){
                tradeName+=' '+objApp.Model__c;
            }

            trade.Name = tradeName;                    
            trade.Car_Deal__c                =   deal.id;            
            trade.Position__c                =   i;
            trade.Service_Vehicle__c         =   objApp.Service_Vehicle__c;
            trade.Appraisal_Vehicle__c       =   objApp.id;


            //ww-2080 Revisit Below line to use new LoanPayof__c object
            trade.Pay_Off_Amount__c          =   loanPayoffMap.get(objApp.appraisal__c) == null || loanPayoffMap.get(objApp.appraisal__c).PayoffAmount__c == null ? 0 : loanPayoffMap.get(objApp.Appraisal__c).PayOffAmount__c;   
            // trade.Pay_Off_Amount__c          =   (objApp.Appraisal__r.Loan_Payoff_Amount__c)==null ? 0 :objApp.Appraisal__r.Loan_Payoff_Amount__c;
            trade.Trade_Allowance__c         =   (objApp.Appraisal__r.Appraised_Value__c) == null ? 0 : objApp.Appraisal__r.Appraised_Value__c;
            trade.Pay_Off_Expiration_Date__c =   objApp.Appraisal__r.Appraisal_Date__c;             
            trade.ACV__c                     =   (objApp.Appraisal__r.ACV_Actual_Cash_Value__c) == null ? 0 :objApp.Appraisal__r.ACV_Actual_Cash_Value__c;
            trade.VIN__c                     =   objApp.VIN__c;
            trade.Stock_Number__c            =   objApp.Service_Vehicle__r.Stock_Number__c;
            trade.Odometer_at_Trade_In__c    =   objApp.Service_Vehicle__r.Last_Odometer__c;
            trade.Lost_Trade__c              =   false;
            trade.Year__c                    =   objApp.Year__c;
            trade.Make__c                    =   objApp.Make__c;
            trade.Model__c                   =   objApp.Model__c;
            trade.Trim_Level__c              =   objApp.Trim_Level__c;
            trade.Net__c                     =   trade.Trade_Allowance__c - trade.Pay_Off_Amount__c;
            trade.Pay_Off_Account__c         =   objApp.Sales_Up__r.Customer_Account__c;                            
            
            listTradeIn.add(trade);         
        }
        
        if(listTradeIn.size()>0){
            try {
                insert listTradeIn;
                if(SalesUpId != null)
                 updateAppraisal(listTradeIn);
                }catch(Exception e)
                {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                }
            }
        }

        public void populateBuyerData(Id acctId) {
        //System.debug('Buyer Contact - '+contact);      

            /* Check to see if this contact has an account Id and populate the buyer account lookup */
            if(acctId!=null) {
                deal.Buyer__c=acctId;
                List<Account> listAccount =[select id, Phone,FirstName, LastName,IsPersonAccount,PersonMobilePhone,PersonHomePhone, PersonEmail , BillingCountry, 
                            Tax_ID__c,Billing_Email__c, //SU1
                            Drivers_License_Expiration_Date__pc, Drivers_License_Number__pc,Drivers_License_State__pc,   //SU1
                            BillingStreet, BillingCity, BillingState, BillingPostalCode, PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode,
                            ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode                  
                             from Account where id=:acctId limit 1];
    
                            System.debug('Buyer Account - '+listAccount[0]);
    
                            if(listAccount[0].PersonHomePhone != null) {
                                deal.Buyer_Home_Phone__c = listAccount[0].PersonHomePhone; 
                                } else {
                                    deal.Buyer_Home_Phone__c = listAccount[0].Phone; 
                                }
                                deal.Buyer_Mobile_Phone__c=listAccount[0].PersonMobilePhone; 
                                deal.Buyer_Email__c=listAccount[0].PersonEmail ; 
    
                // SU1 begins
                if(listAccount[0].Drivers_License_Number__pc != null) {
                    deal.Buyer_Drivers_License__c = listAccount[0].Drivers_License_Number__pc; 
                }
                
                if(listAccount[0].Drivers_License_Expiration_Date__pc != null) {
                    deal.Buyer_Drivers_License_Exp_Date__c = listAccount[0].Drivers_License_Expiration_Date__pc; 
                    }else{
                        deal.Buyer_Drivers_License_Exp_Date__c = null;
                    }
                // SU1 ends
                if(listAccount[0].IsPersonAccount){
                    deal.Buyer_First_Name__c = listAccount[0].FirstName;
                    deal.Buyer_Last_Name__c =  listAccount[0].LastName;
                }
                
                if( listAccount[0].BillingStreet != null ) {
    
                    //deal.Buyer_County__c=listAccount[0].BillingCountry ; // Country VS County - BillingCounty Doesnt exist
                    deal.Buyer_Address__c=listAccount[0].BillingStreet ; 
                    deal.Buyer_City__c=listAccount[0].BillingCity ; 
                    deal.Buyer_State__c=listAccount[0].BillingState ;
                    deal.Buyer_Postal_Code__c=listAccount[0].BillingPostalCode ;
    
                } else if (listAccount[0].PersonMailingStreet != null) {
                    deal.Buyer_Address__c=listAccount[0].PersonMailingStreet ; 
                    deal.Buyer_City__c=listAccount[0].PersonMailingCity ; 
                    deal.Buyer_State__c=listAccount[0].PersonMailingState ;
                    deal.Buyer_Postal_Code__c=listAccount[0].PersonMailingPostalCode ;
                    
                }else if(listAccount[0].ShippingStreet != null){
                    deal.Buyer_Address__c=listAccount[0].ShippingStreet ; 
                    deal.Buyer_City__c=listAccount[0].ShippingCity ; 
                    deal.Buyer_State__c=listAccount[0].ShippingState ;
                    deal.Buyer_Postal_Code__c=listAccount[0].ShippingPostalCode ;
    
                }

            }
        }

        public void populateCoBuyerData(Id acctId) {        

            if(acctId!=null) {
                deal.Co_Buyer__c=acctId;
                List<Account> listAccount =[select id, Phone, PersonHomePhone, PersonMobilePhone, PersonEmail ,BillingCountry, 
                        Tax_ID__c,Billing_Email__c,  //SU1
                        Drivers_License_Expiration_Date__pc, Drivers_License_Number__pc,Drivers_License_State__pc, //SU1
                        BillingStreet, BillingCity, BillingState, BillingPostalCode,PersonMailingStreet,PersonMailingCity,PersonMailingState,PersonMailingPostalCode from Account where id=:acctId limit 1];

                        System.debug('Co Buyer Account - '+listAccount[0]);
            // SU1 begins
            if(listAccount[0].PersonHomePhone != null) {
                deal.Co_Buyer_Home_Phone__c = listAccount[0].PersonHomePhone; 
                } else {
                    deal.Co_Buyer_Home_Phone__c = listAccount[0].Phone; 
                }
            // SU1 ends
            
            deal.Co_Buyer_Mobile_Phone__c=listAccount[0].PersonMobilePhone ; 
            deal.Co_Buyer_Email__c=listAccount[0].PersonEmail ; 
            
            // SU1 begins
            if(listAccount[0].Drivers_License_Number__pc != null) {
                deal.Co_Buyer_Drivers_License_Number__c = listAccount[0].Drivers_License_Number__pc; 
            }
            
            if(listAccount[0].Drivers_License_Expiration_Date__pc != null) {
                deal.Co_Buyer_Drivers_License_Exp_Date__c = listAccount[0].Drivers_License_Expiration_Date__pc; 
                }else{
                    deal.Co_Buyer_Drivers_License_Exp_Date__c = null;
                }

                if( listAccount[0].BillingStreet != null ) {

                //deal.Buyer_County__c=listAccount[0].BillingCountry ; // Country VS County - BillingCounty Doesnt exist
                deal.Co_Buyer_Address__c=listAccount[0].BillingStreet ; 
                deal.Co_Buyer_City__c=listAccount[0].BillingCity ; 
                deal.Co_Buyer_State__c=listAccount[0].BillingState ;
                deal.Co_Buyer_Postal_Code__c=listAccount[0].BillingPostalCode ;   

                } else if (listAccount[0].PersonMailingStreet != null) {
                    deal.Co_Buyer_Address__c=listAccount[0].PersonMailingStreet ; 
                    deal.Co_Buyer_City__c=listAccount[0].PersonMailingCity ; 
                    deal.Co_Buyer_State__c=listAccount[0].PersonMailingState ;
                    deal.Co_Buyer_Postal_Code__c=listAccount[0].PersonMailingPostalCode ;   
                }
            // SU1 ends
        }
        
        System.debug('Co buyer Deal details -'+deal);
    }

    /**
    This method provides the tax settings for the deal when the deal is created
    */
    public void populateDealTaxLines(){

        // Get necessasary record type
        RecordType rType = [SELECT Id from RecordType where DeveloperName = 'Line_Item' AND SobjectType ='dealer__Deal_Tax__c' LIMIT 1];
 
        // There are two options based on the Location, the tax is either set by the Locations Zip or the Customers Zip
        System.assert(location!=null, 'No Location is set on the Deal record. Unable to associate the default tax zone.');
        System.assert(location.Postal_Code__c!=null, 'The Location record has no postal code specified. Unable to associate the default tax zone.');
        System.assert(deal.Buyer__c!=null, 'No buyer is specified on this deal record.  Unable to associate the default tax zone.');

        // If the system is set to tax by customer address this value is TRUE
        Boolean taxByCustomerAddress = location.Tax_Delivery_Address__c;
        String taxZip;

        // Determine the search based on Zip
        Account buyer = [SELECT Id, Name, PersonMailingPostalCode, BillingPostalCode FROM Account WHERE Id =: deal.Buyer__c];
        if(taxByCustomerAddress && ( buyer.PersonMailingPostalCode !=null || buyer.BillingPostalCode != null)) {
            taxZip = (buyer.PersonMailingPostalCode!=null) ? buyer.PersonMailingPostalCode : buyer.BillingPostalCode;
        } else {
            taxZip=location.Postal_Code__c;
        }

        // Iterate matched tax rows and assign
        List<Deal_Tax__c> newTaxes = new List<Deal_Tax__c>();
        List<Deal__c> dealTaxUpdate = new List<Deal__c>();
        for (Tax_Zones__c zone : [SELECT Id, City__c, County__c, Postal_Code__c, Rate__c, State__c FROM Tax_Zones__c WHERE Postal_Code__c =: taxZip limit 1] ) {

            String state = (zone.State__c!=null) ? zone.State__c+':' : '';
            String county = (zone.County__c!=null) ? zone.County__c+':' : '';
            String city = (zone.City__c!=null) ? zone.City__c : '';
            String taxZoneName = state + county + city;

            Deal_Tax__c newLine = new Deal_Tax__c(
                Name = taxZoneName,
                RecordTypeId = rType.Id,
                Tax_Percentage__c = zone.Rate__c,
                Type__c = 'Tax Zone',
                Deal__c = deal.Id,
                Tax_Zone__c = zone.Id
                );
            newTaxes.add(newLine);
            dealTaxUpdate.add(new Deal__c(Id=deal.Id, Tax_Zone__c=zone.Id));
        }

        try {
            
            insert newTaxes;
            update dealTaxUpdate;

        }catch(Exception e) {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }        
    }
    /**
    * @method populateB2BContactData
    * @description Applies contact data to buyer fields for b2b deals
    * @param  supRecord supRecord description
    */
    public void populateB2BContactData(Sales_Up__c supRecord)
    {
        deal.Buyer_Contact__c = supRecord.Buyer_Contact__c;
        deal.Buyer_First_Name__c = supRecord.Buyer_Contact__r.FirstName;
        deal.Buyer_Middle_Name__c = supRecord.Buyer_Contact__r.MiddleName;
        deal.Buyer_Last_Name__c = supRecord.Buyer_Contact__r.LastName;
        deal.Buyer_Mobile_Phone__c = supRecord.Buyer_Contact__r.MobilePhone;
        deal.Buyer_Email__c = supRecord.Buyer_Contact__r.Email;
        deal.Buyer_Drivers_License__c = supRecord.Buyer_Contact__r.Drivers_License_Number__c;
        deal.Buyer_Drivers_Lic_State__c = supRecord.Buyer_Contact__r.Drivers_License_State__c;
        deal.Buyer_Drivers_License_Exp_Date__c = supRecord.Buyer_Contact__r.Drivers_License_Expiration_Date__c;
        deal.Buyer_Birthdate__c = supRecord.Buyer_Contact__r.Birthdate;
    }

    /**
    * @method populateTotals
    * @description calculates total and payment related fields upon initial deal creation from sales up
    */
    public void populateTotals()
    {
        deal.Vehicle_Price__c = deal.Vehicle_Price__c > 0 ? deal.Vehicle_Price__c : 0;
        deal.Conversion_Price__c = deal.Conversion_Price__c > 0 ? deal.Conversion_Price__c : 0;
        deal.Total_Additional_Equipment__c = deal.Total_Additional_Equipment__c > 0 ? deal.Total_Additional_Equipment__c : 0;
        deal.Total_Service_Contracts_Premium__c = deal.Total_Service_Contracts_Premium__c > 0 ? deal.Total_Service_Contracts_Premium__c : 0;
        deal.Total_Fees__c = deal.Total_Fees__c > 0 ? deal.Total_Fees__c : 0;
        deal.Total_Tax__c = deal.Total_Tax__c > 0 ? deal.Total_Tax__c : 0;
        deal.Total_Deferred_Down__c = deal.Total_Deferred_Down__c > 0 ? deal.Total_Deferred_Down__c : 0;
        deal.Down_Pymt__c = deal.Down_Pymt__c > 0 ? deal.Down_Pymt__c : 0;
        deal.Down_Pymt__c = deal.Down_Pymt__c > 0 ? deal.Down_Pymt__c : 0;
        deal.Rebate__c = deal.Rebate__c > 0 ? deal.Rebate__c : 0;
        deal.Trade_Net__c = deal.Trade_Net__c == null ? deal.Trade_Net__c : 0;


        deal.Out_the_Door__c = deal.Vehicle_Price__c
							  + deal.Conversion_Price__c
							  + deal.Total_Additional_Equipment__c
							  + deal.Total_Service_Contracts_Premium__c
							  + deal.Total_Fees__c
							  + deal.Total_Tax__c;

		deal.Total_Cash_Down__c = deal.Total_Deferred_Down__c + deal.Down_Pymt__c;
		
		//Amount Financed
		deal.Due_Upon_Delivery__c = deal.Out_the_Door__c
								  - deal.Rebate__c
								  - deal.Total_Cash_Down__c
								  - deal.Trade_Net__c;
		//Monthly Payment

		deal.Monthly_Pymt__c = FinanceAPI.calculateMonthlyPayment(deal.Due_Upon_Delivery__c, deal.Rate__c, deal.Term__c, deal.Days_to_First__c);

		deal.dealer__Amt_Financed__c = deal.Monthly_Pymt__c * deal.Term__c;

		deal.FinanceCharge__c = deal.Amt_Financed__c - deal.Due_Upon_Delivery__c;
    }
 
    public class mobException extends Exception {}
}