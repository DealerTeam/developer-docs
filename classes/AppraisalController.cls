/**
 * AppraisalController
 * @description Allows creation of Appraisal Records with Edit/Save/Delete functionality. Runs VIN Decoder for Trade Ins and allows changes for Line Items. 
 */
public with sharing class AppraisalController {

    /**
     * @description The appraisal property stores a public scoped instance of the appraisal object for reference within the visualforce controller extension
     */ 
    public dealer__Appraisal__c appraisal {get; set;}

    /**
     * @description
     */
    public dealer__Sales_Up__c sup {get;set;}
    
    /**
     * @description
     */
    public dealer__Service_Vehicle__c serviceVehicle {get; set;}  
    
    /**
     * @description
     */
    public List<dealer__Service_Estimate_Line__c> estimateLines = new List<dealer__Service_Estimate_Line__c>();
    
    /**
     * @description
     */
    public List<SelectOption> repairType{get;set;}
    
    /**
     * @description
     */
    public string reconRepairType{get;set;}
    
    /**
     * @description
     */
    public String reconDescription {get;set;}
    
    /**
     * @description
     */ 
    public String reId {get;set;}
    
    /**
     * @description
     */
    public Id editId {get; set;}
    
    /**
     * @description
     */
    public Decimal reconEstimate {get;set;}
    
    /**
     * @description
     */
    public Decimal tradeAllowance{get;set;}
    
    /**
     * @description
     */
    public Decimal payOffAmount{get;set;}
    
    /**
     * @description
     */ 
    public Decimal totalReconValue{get;set;}
    
    /**
     * @description
     */
    public boolean isApproval{get;set;}
    
    /**
     * @description
     */
    public Decimal serviceVehicleMileage {get;set;}
    
    /**
     * @description
     */
    public boolean editReExpense{get;set;}
    
    /**
     * @description
     */
    public dealer__Trade_In__c tradeRecord{get;set;}
    
    /**
     * @description
     */
    public dealer__Appraisal__c appraisalOne{get;set;}
    
    /**
     * @description
     */
    public LoanPayoff__c loanPayoff {get;set;}
    
    /**
     * @description
     */
    public Boolean isDecode {get;set;}

    /**
     * @description
     */
    @TestVisible transient VINDecoderDataObject.DecodeData ddat;
    
    /**
     * @description
     */
    @TestVisible transient VINDEcoderDataObject.Style sdat;
    
    /**
     * @description
     */
    public List < VINDecoderDataObject.Style > ModelKeyList = new List < VINDecoderDataObject.Style > ();
    
    /**
     * @description
     */
    public List < VinDecoderAPI.OptionalEquipment > OptEquip = new List < VinDecoderAPI.OptionalEquipment > ();
    
    /**
     * @description
     */
    public List < VinDecoderAPI.InstalledEquipment > InstalledEquipment = new List < VinDecoderAPI.InstalledEquipment > ();

    /**
     * @description
     */ 
    public VINDecoder vd = new VINDecoder();
    
    /**
     * @description
     */ 
    public String SelectedStyleId;

    /**
     * @description
     */
    public List < SelectOption > engineSelect = new List < SelectOption > ();
    
    /**
     * selectedEngine 
     * @return String
     * @description
     */
    public String selectedEngine 
    {
        get;
        set;
    }
    
    public List < SelectOption > transmissionSelect = new List < SelectOption > ();
    
    /**
     * @description
     */
    public String selectedTransmission {get;set;}

    /**
     * @description
     */
    public Boolean vinDecoderActive 
    {
        get {
            return dealer.SecureVDCSettings.active();
        }
        private set;
    }

    /**
     * @description
     */
    public AppraisalConfiguration__mdt appraisalSettings 
    {
        get {
            try {
                if(!Test.isRunningTest()){
                    AppraisalConfiguration__mdt[] appraisalMetaData = [SELECT DefaultDiagramId__c FROM AppraisalConfiguration__mdt WHERE QualifiedApiName ='dealer__Default_Appraisal_Configuration' LIMIT 1];
                    System.assert(!appraisalMetaData.isEmpty(), 'Appraisal Default Configuration does not appear to be set, please create the dealer__Default_Appraisal_Configuration metadata file.');
                    return appraisalMetaData[0]; 
                } else {
                    return new AppraisalConfiguration__mdt();
                }

            } Catch(QueryException e) {
                throw new AppraisalException(e.getMessage());
            }
        }
        set;
    }

    /**
     * @description
     */
    public String appraisalSettingsJSON 
    {
        get {
            return JSON.serialize(appraisalSettings);
        }
        set;
    }
    
    /**
     * AppraisalController
     * @description Constructor - Allows Trade In record to be created from Sales Up or Deal and populates Account/Sales Person
     */
    public AppraisalController(ApexPages.StandardController controller) 
    {

        appraisal = new dealer__Appraisal__c(); 

        tradeAllowance=0;
        payOffAmount=0;
        editReExpense=false;
        isApproval=false;
        tradeRecord = new dealer__Trade_In__c();
        appraisalOne = new dealer__Appraisal__c();
        serviceVehicleMileage = 0;

        //Check if appraisal has an active approval process
        for(ProcessDefinition p: [select id from ProcessDefinition where TableEnumOrId ='dealer__Appraisal__c' and state='Active']){
            isApproval=true;
        }
        
        // Support Loading from a trade record
        if(ApexPages.currentPage().getParameters().get('tradeid')!=null) {
            appraisal = [Select Id from dealer__Appraisal__c 
            where dealer__Trade_In__c=:ApexPages.currentPage().getParameters().get('tradeid')
            limit 1];  
            ApexPages.currentPage().getParameters().put('id', appraisal.Id);
        }
        // End W-000326
        
        
        
        serviceVehicle = new dealer__Service_Vehicle__c();
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Appraisal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.add('dealer__Sales_Up__r.dealer__FirstName__c');
        af.add('dealer__Sales_Up__r.dealer__LastName__c');
        af.add('dealer__Sales_Up__r.dealer__Home_Phone__c');
        af.add('dealer__Sales_Up__r.dealer__Mobile__c');
        af.add('dealer__Sales_Up__r.dealer__Email__c');
        af.add('dealer__Service_Estimate__r.dealer__Estimate_Total__c');
        af.add('dealer__Service_Estimate__r.dealer__LineCount__c');

        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            controller.addFields(af);
        }

        this.appraisal = (dealer__Appraisal__c)controller.getRecord();

        loanPayoff = fetchLoanPayoff();
        
        if(appraisal.dealer__Requested_By__c ==null) {
            appraisal.dealer__Requested_By__c =UserInfo.getUserId();
        }
        
        // Support create new from SalesUp
        if(ApexPages.currentPage().getParameters().get('sid')!=null) {
         sup  = [SELECT Id, Name, dealer__Store_Location__c, dealer__Service_Vehicle__c, 
         dealer__Trade_VIN__c, dealer__Trade_Make__c, dealer__Trade_Mileage__c, dealer__Trade_Model__c, 
         dealer__Trade_Trim_Level__c, dealer__Trade_Comments__c, dealer__Trade_Year__c, 
                                       dealer__Trade_Appraised_Value__c, dealer__Customer_Account__c,                      //W-000395
                                       dealer__Salesperson_1__c                                                            //W-000786
                                       FROM dealer__Sales_Up__c 
                                       where Id =:ApexPages.currentPage().getParameters().get('sid') 
                                       limit 1];
                                       appraisal.dealer__Store_Location__c     =   sup.dealer__Store_Location__c;
                                       appraisal.dealer__Sales_Up__c           =   sup.Id;
                                       appraisal.dealer__Service_Vehicle__c    =   sup.dealer__Service_Vehicle__c;
                                   }

        // Support creation from a Deal
        if(ApexPages.currentPage().getParameters().get('did')!=null) {
            dealer__Deal__c dealrecord = [Select Id, dealer__Store_Location__c from dealer__Deal__c 
            where Id=:ApexPages.currentPage().getParameters().get('did') limit 1];
            appraisal.dealer__Deal__c = dealRecord.Id;
            if(appraisal.dealer__Store_Location__c==null && dealRecord.dealer__Store_Location__c!=null) {
                appraisal.dealer__Store_Location__c=dealRecord.dealer__Store_Location__c;
            }
        }
        
        if(appraisal.dealer__Service_Vehicle__c!=null) {
            serviceVehicle = [SELECT Id, Name, dealer__VIN__c, dealer__Year__c, dealer__Conversion__c, dealer__Make__c, dealer__Carline__c, dealer__Ext_Color__c, dealer__Int_Color__c,
            dealer__Last_Odometer__c, dealer__Body_Type__c, dealer__Conversion_MFG__c,dealer__Trim_Level__c, dealer__Veh_Owner__c, dealer__Body_Style__c, dealer__Model_Code__c, 
            dealer__Veh_Owner_Contact__c, dealer__VIN_Not_Present__c
            FROM dealer__Service_Vehicle__c WHERE Id = :appraisal.dealer__Service_Vehicle__c];
            if (serviceVehicle != null) {
                serviceVehicleMileage = serviceVehicle.dealer__Last_Odometer__c == null ? 0 : serviceVehicle.dealer__Last_Odometer__c;
            }
        }

        if(sup != null){
            //W-000395
            //Populate Service Vehicle's Veh Owner Account from Sales UP's Customer Account
            if(sup.dealer__Customer_Account__c != null){
                serviceVehicle.dealer__Veh_Owner__c = sup.dealer__Customer_Account__c;
            }
            sup.dealer__Trade_Mileage__c = (sup.dealer__Trade_Mileage__c != null) ? sup.dealer__Trade_Mileage__c : 0;
            appraisal.dealer__Odometer__c = (serviceVehicle.dealer__Last_Odometer__c > sup.dealer__Trade_Mileage__c) ? serviceVehicle.dealer__Last_Odometer__c : sup.dealer__Trade_Mileage__c;

            //Populate Appraised By from Sales UP's Salesperson1
            if(sup.dealer__Salesperson_1__c != null){        
                appraisal.dealer__Appraised_By__c = sup.dealer__Salesperson_1__c;
            }
        }

        if(appraisal.dealer__Service_Estimate__c!=null) {
            estimateLines = getEstimateLines();
        }
        
        if(appraisal.dealer__Service_Estimate__r.dealer__LineCount__c>0) {
            appraisal.dealer__Reconditioning__c=appraisal.dealer__Service_Estimate__r.dealer__Estimate_Total__c;  
        }

        getTradeAllowance();                 
    }

    /**
     * populateRepairTypePicklist 
     * @return void
     * @description
     */ 
    public void populateRepairTypePicklist()
    {
        Schema.DescribeFieldResult fieldDescription = dealer__Service_Estimate_Line__c.dealer__Repair_Type__c.getDescribe();
        
        repairType = new list<SelectOption>();
        
        for (Schema.Picklistentry picklistEntry : fieldDescription.getPicklistValues())
        {
            repairType.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
    }

    /**
     * getTradeAllowance
     * @return void
     * @description Within deal, be able to save or delete Trade In
     */ 
    public void getTradeAllowance()
    {

        //If trade in exists
        if(appraisal.dealer__Trade_In__c!=null){
            //W-000593 - Added fields to soql 
            List<dealer__Trade_In__c> listTrade = [select id,dealer__Trade_Allowance__c,dealer__Pay_Off_Amount__c,dealer__Stock_Number__c,
            dealer__Inventory_Vehicle__c,dealer__Net__c,dealer__Car_Deal__c,dealer__VIN__c,Name,                                               
            dealer__Year__c,dealer__Make__c,dealer__Model__c,dealer__Trim_Level__c,
            dealer__Odometer_at_Trade_In__c from dealer__Trade_In__c where id=:appraisal.dealer__Trade_In__c];
            
            if(listTrade !=null && listTrade.size()>0){
                tradeAllowance = listTrade[0].dealer__Trade_Allowance__c;
                payOffAmount = listTrade[0].dealer__Pay_Off_Amount__c;
                tradeRecord = listTrade[0];//W-000593 - required to get id when delete is called
            }
        }  
    }

    /**
     * returnToDeal 
     * @return PageReference
     * @description After savign Trade record return to Deal
     */ 
    public PageReference returnToDeal() 
    {
        if(appraisal.dealer__Deal__c==null) {
            return null;
        }
        dealer__Deal__c dealPage = [Select Id from dealer__Deal__c where Id=:appraisal.dealer__Deal__c limit 1];
        PageReference rt = new ApexPages.StandardController(dealPage).view();
        rt.setRedirect(true);
        return rt;
    }

    /**
     * returnToSalesUp 
     * @return PageReference
     * @description After saving Trade record return to active Sales Up 
     */ 
    public PageReference returnToSalesUp()
    {
        if(appraisal.dealer__Sales_Up__c==null) {
            return null;
        }
        dealer__Sales_Up__c supPage = [Select Id from dealer__Sales_Up__c where Id=:appraisal.dealer__Sales_Up__c limit 1];
        PageReference rt = new ApexPages.StandardController(supPage).view();
        rt.setRedirect(true);
        return rt;
    }

    /**
     * save
     * @return PageReference
     * @description Saves Trade Record unless the Vehicle is already associated with a Deal, in which case it updates Appraisal's trade record
     */
    public PageReference save() 
    {

        List<dealer__Service_Vehicle__c> matchByVIN = [SELECT Id FROM dealer__Service_Vehicle__c WHERE dealer__VIN__c=:serviceVehicle.dealer__VIN__c LIMIT 1];
        if(matchByVIN.size()==1) {
            serviceVehicle.Id=matchByVIN[0].Id;
        }
        
        Savepoint sp = Database.setSavepoint();

        Utility.updateRelatedObjects(appraisal);

        appraisal.dealer__Appraisal_Date__c = (appraisal.dealer__Appraisal_Date__c==null) ? System.Today() : appraisal.dealer__Appraisal_Date__c;
    
        Map<Id, dealer__Service_Vehicle__c> existingVehicleMap = new Map<Id, dealer__Service_Vehicle__c>();        
        Map<String, dealer__Service_Vehicle__c> existingVINMap = new Map<String, dealer__Service_Vehicle__c>();
        Map<Id, dealer__Appraisal_Vehicle__c> existingAppraisalVehicleMap = new Map<Id, dealer__Appraisal_Vehicle__c>();
        
        for(dealer__Service_Vehicle__c sv : [SELECT Id, Name, dealer__VIN__c,dealer__Veh_Owner__c,
            dealer__Ext_Color__c,dealer__Trim_Level__c, dealer__Last_Odometer__c,
            dealer__Int_Color__c,dealer__Body_Type_Picklist__c,dealer__Conversion_MFG__c,Conversion__c
            FROM dealer__Service_Vehicle__c 
            WHERE Id=:serviceVehicle.id 
            OR dealer__VIN__c =:serviceVehicle.dealer__VIN__c 
            LIMIT 200]) {
                if(sv.dealer__Last_Odometer__c == null){
                    sv.dealer__Last_Odometer__c = 0;
                }
                existingVehicleMap.put(sv.Id, sv);
                existingVINMap.put(sv.dealer__VIN__c, sv);                                   
        }


        try {
            if(serviceVehicle!=new dealer__Service_Vehicle__c() && serviceVehicle.dealer__VIN__c!=null) {

                if(serviceVehicle.id == null && existingVINMap.get(serviceVehicle.dealer__VIN__c) == null)
                {
                    servicevehicle.dealer__Last_Odometer__c = appraisal.dealer__Odometer__c != null ? appraisal.dealer__Odometer__c : 0;
                    insert serviceVehicle;
                }
                else
                {
                    if(serviceVehicle.dealer__VIN__c != existingVehicleMap.get(serviceVehicle.Id).dealer__VIN__c 
                        && existingVINMap.get(serviceVehicle.dealer__VIN__c)!=null){
                            if(appraisal.dealer__Odometer__c > existingVINMap.get(serviceVehicle.dealer__VIN__c).dealer__Last_Odometer__c){
                                serviceVehicle.dealer__Last_Odometer__c = appraisal.dealer__Odometer__c;
                            }
                            update serviceVehicle;
                        }
                        else if(serviceVehicle.dealer__VIN__c != existingVehicleMap.get(serviceVehicle.Id).dealer__VIN__c 
                            && existingVINMap.get(serviceVehicle.dealer__VIN__c)==null){

                                serviceVehicle = new dealer__Service_Vehicle__c(
                                    Name=serviceVehicle.Name,
                                    dealer__VIN__c=serviceVehicle.dealer__VIN__c,
                                    dealer__Last_Odometer__c=appraisal.dealer__Odometer__c,
                                    dealer__Make__c=serviceVehicle.dealer__Make__c,
                                    dealer__CarLine__c=serviceVehicle.dealer__CarLine__c,
                                    dealer__Year__c=serviceVehicle.dealer__Year__c,
                                    dealer__Body_Type_Picklist__c=serviceVehicle.dealer__Body_Type_Picklist__c,
                                    dealer__Trim_Level__c=serviceVehicle.dealer__Trim_Level__c,
                                    dealer__Conversion_MFG__c=serviceVehicle.dealer__Conversion_MFG__c,
                                    dealer__Conversion__c=serviceVehicle.dealer__Conversion__c,
                                    dealer__Ext_Color__c=serviceVehicle.dealer__Ext_Color__c,
                                    dealer__Int_Color__c=serviceVehicle.dealer__Int_Color__c,
                                    dealer__Veh_Owner__c=serviceVehicle.dealer__Veh_Owner__c
                                );

                                insert serviceVehicle;

                            }else{
                                if(serviceVehicle.dealer__Last_Odometer__c != null){
                                    if(appraisal.dealer__Trade_In__c != null){
                                        if(tradeRecord.dealer__Odometer_at_Trade_In__c > serviceVehicle.dealer__Last_Odometer__c){
                                            serviceVehicle.dealer__Last_Odometer__c = tradeRecord.dealer__Odometer_At_Trade_In__c;
                                            appraisal.dealer__Odometer__c = serviceVehicle.dealer__Last_Odometer__c;
                                            System.debug(appraisal.dealer__Odometer__c);
                                            update serviceVehicle;
                                        }
                                        if(tradeRecord.dealer__Odometer_At_Trade_In__c != appraisal.dealer__Odometer__c){
                                            appraisal.dealer__Odometer__c = tradeRecord.dealer__Odometer_At_Trade_In__c;
                                            System.debug(appraisal.dealer__Odometer__c);
                                        }
                                    }
                                          
                                }
                                if(appraisal.dealer__Odometer__c > existingVINMap.get(serviceVehicle.dealer__VIN__c).dealer__Last_Odometer__c){
                                    serviceVehicle.dealer__Last_Odometer__c = appraisal.dealer__Odometer__c;
                                    system.debug(existingVINMap.get(serviceVehicle.dealer__VIN__c).dealer__Last_Odometer__c);
                                    update serviceVehicle;
                                }

                            }
                        }
                        appraisal.dealer__Service_Vehicle__c = serviceVehicle.Id;

                        if (isDecode = true && vd.decodeError == '') {
                            VinDecoderAPI.storeDecodeData(serviceVehicle.Id, null, JSON.serialize(InstalledEquipment), JSON.serialize(OptEquip));
                        }
                    }

                    String tradeInMessage='';
            // Check to see if a Trade record needs to be created
            if(appraisal.dealer__Deal__c != null && serviceVehicle.dealer__VIN__c!=null) {

                saveTradeRecord(); //
                
                if(appraisal.dealer__Trade_In__c!=null ) { // we have an update
                    tradeRecord.Id = appraisal.dealer__Trade_In__c;
                    update tradeRecord;

                    // appraisal.dealer__Loan_Payoff_Amount__c = tradeRecord.dealer__Pay_Off_Amount__c;
                    loanPayoff.PayoffAmount__c = tradeRecord.dealer__Pay_Off_Amount__c;
                    tradeInMessage = 'Trade Record Updated';
                    System.debug(tradeRecord);
                    System.debug(appraisal);

                } else { 
                        //is this vehicle already on the deal?
                        List<dealer__Trade_In__c> existingDealTradeIn = [SELECT dealer__Car_Deal__c, dealer__Vin__c, dealer__Pay_Off_Amount__c, dealer__Odometer_at_Trade_In__c
                        FROM dealer__Trade_In__c 
                        WHERE dealer__Vin__c =:tradeRecord.dealer__Vin__c 
                        AND dealer__Car_Deal__c =: appraisal.dealer__Deal__c];

                        System.debug(existingDealTradeIn);

                        //if this vehicle doesn't exist on deal insert
                        if(existingDealTradeIn.size() == 0){
                            try{
                                insert tradeRecord;
                                // appraisal.dealer__Loan_Payoff_Amount__c = tradeRecord.dealer__Pay_Off_Amount__c;
                                loanPayoff.PayoffAmount__c = tradeRecord.dealer__Pay_Off_Amount__c;
                                tradeInMessage = 'Trade Record Created';
                                appraisal.dealer__Trade_In__c = tradeRecord.id;

                                System.debug(tradeRecord);
                                System.debug(appraisal);

                                // dealer__Trade_In__c tradeRecordTest = [SELECT dealer__Car_Deal__c, dealer__Vin__c, dealer__Pay_Off_Amount__c, dealer__Odometer_at_Trade_In__c FROM dealer__Trade_In__c WHERE ID=:tradeRecord.Id ];
                                // System.debug(tradeRecordTest);

                            }
                            catch(Exception e){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
                            }
                        }
                        //if this vehicle DOES exist on the deal we do NOT want to insert a new trade record 
                        // Instead we want to update this appraisal's trade record with the trade record on the deal
                        if(existingDealTradeIn.size() == 1){
                            appraisal.dealer__Trade_In__c = existingDealTradeIn[0].Id;
                            // appraisal.dealer__Loan_Payoff_Amount__c = existingDealTradeIn[0].dealer__Pay_Off_Amount__c;
                            loanPayoff.PayoffAmount__c = existingDealTradeIn[0].dealer__Pay_Off_Amount__c;

                        }
                        if(existingDealTradeIn.size() > 1){
                           throw new appraisalException('Duplicates of this trade vehicle found on the deal. Please delete one instance of this vehicle and try again.');
                           Database.rollback(sp);
                       }

                   }               
                }

                if(appraisal.dealer__Deal__c != null) {
                    dealer__Deal__c dealRecordSalesUp = [Select Id, dealer__Sales_Lead__c from dealer__Deal__c where Id=:appraisal.dealer__Deal__c limit 1];
                    appraisal.dealer__Sales_Up__c = dealRecordSalesUp.dealer__Sales_Lead__c;
                }
                //remove trade in if there is no deal attached.
                if(appraisal.dealer__Deal__c == null && appraisal.dealer__Trade_In__c != null){
                    appraisal.dealer__Trade_In__c = null;
                }

                upsert appraisal;

            
                // Associate a Service Estimate with this appraisal.
                if(appraisal.dealer__Service_Estimate__c==null) {
                    dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                        dealer__Appraisal__c=appraisal.Id,
                        dealer__Appraisal_VIN__c=serviceVehicle.dealer__VIN__c,
                        dealer__Company__c=appraisal.dealer__Store_Location__c,
                        dealer__Service_Vehicle__c=serviceVehicle.Id
                        );
                    
                    insert se;
                    
                    appraisal.dealer__service_estimate__c=se.Id;
                    update appraisal;


            }
            
            loanPayoff.Appraisal__c = appraisal.Id;
            try{
                upsert loanPayoff;
            } catch (DmlException e){
                throw new appraisalException(e.getMessage());
            }


            // add this Appraisal.ID to the Service_Vehicle__c on the sales up while creating appraisal from sales up
            if(ApexPages.currentPage().getParameters().get('sid')!=null){

                dealer__Sales_Up__c sup = [SELECT Id, dealer__Service_Vehicle__c FROM dealer__Sales_Up__c WHERE Id =: ApexPages.currentPage().getParameters().get('sid')];
                
                if(sup.dealer__Service_Vehicle__c == null){
                    sup.dealer__Service_Vehicle__c = serviceVehicle.Id;
                    sup.dealer__Trade_VIN__c = serviceVehicle.dealer__VIN__c;
                    update sup;
                }

                List<dealer__Appraisal_Vehicle__c> appraisalVehicles = [SELECT Id, dealer__Sales_Up__c FROM dealer__Appraisal_Vehicle__c WHERE dealer__Sales_Up__c =: sup.id];
                    if(appraisalVehicles.size() > 0){
                        for(Integer i = 0; i< appraisalVehicles.size(); i++){
                            appraisalVehicles[i].dealer__Appraisal__c = appraisal.Id;
                        }
                        update appraisalVehicles;
                    }
            }

            return new PageReference('/' + appraisal.Id);
        
        } catch(DmlException e) {
            System.debug(appraisal);

            if(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ''+e.getDmlMessage(0)));
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
            }

            return null;            

        } catch (Exception e) {
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
            return null;
        }
    }

    /**
     * deleteRecord 
     * @return PageReference
     * @description Deletes Trade record, otherwise gives error message
     */
    public PageReference deleteRecord() 
    {
        try {
            if(tradeRecord.Id!=null) {
                delete tradeRecord;
            }
            
            if(appraisal.Id != null) {
            delete appraisal;
        }
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }
        
        Schema.DescribeSObjectResult r = dealer__Appraisal__c.sObjectType.getDescribe();
        PageReference pr = new PageReference('/'+r.getKeyPrefix()+'/o');
        pr.setRedirect(true);
        return pr;
    }

    /**
     * createInventoryRecord 
     * @return PageReference 
     * @description
     */ 
    public PageReference createInventoryRecord() 
    {

        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
            Name='test',
            dealer__VIN__c=serviceVehicle.dealer__VIN__c,
            dealer__Make__c=serviceVehicle.dealer__Make__c,
            dealer__Model__c=serviceVehicle.dealer__Carline__c,
            dealer__Stock_Number__c=serviceVehicle.dealer__VIN__c.right(8),
            dealer__Year__c=serviceVehicle.dealer__Year__c,
            dealer__Mileage__c=serviceVehicle.dealer__Last_Odometer__c
            );
        
        try {
            insert inv;
            PageReference pr = new PageReference('/'+inv.Id);
            pr.setRedirect(true);
            return pr;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
            return null;
        }
        return null;
    }
    
    /**
     * saveTradeRecord
     * @return void
     * @description Save Trade Recode with Appriasal Values
     */ 
    public void saveTradeRecord() 
    {

        System.debug(appraisal);
        System.debug(tradeRecord);

        if(appraisal.dealer__Deal__c==null) {
            return;
        }

        // Get the Service Vehicle from the Database
        if(serviceVehicle.Id!=null) {
            serviceVehicle=[SELECT ID, dealer__Body_Style_Id__c, dealer__Body_Style__c, dealer__Body_Type__c, dealer__Carline__c, dealer__Comments__c, dealer__Company_Number__c, dealer__Conversion_MFG__c, dealer__Customer_Key__c, dealer__Doors__c, dealer__Drive_Type__c, dealer__Engine_Description__c, dealer__Engine_Displacement__c, dealer__Engine_ID__c, dealer__Equipment_Number__c, dealer__Ext_Color__c, dealer__External_ID__c, dealer__Horsepower__c, dealer__Hours__c, dealer__In_Service_Date__c, dealer__Int_Color__c, dealer__Key_1__c, dealer__Key_2__c, dealer__Last_6__c, dealer__Last_Activity__c, dealer__Last_Odometer__c, dealer__Last_Service__c, dealer__Licence_State__c, dealer__Licence__c, dealer__Make_Code__c, dealer__Make__c, dealer__Marketing_ID__c, dealer__Model_Code__c, dealer__Open_Repair_Orders__c, dealer__Package_Code__c, dealer__Recommendations__c, dealer__Sale_Date__c, dealer__Sales_Inventory__c, dealer__Search_Names__c, dealer__Service_Interval_Average_Days__c, dealer__Service_Interval_Average_Odometer__c, dealer__Status_Code__c, dealer__Stock_Number__c, dealer__Style_Id__c, dealer__Transmission_Type__c, dealer__Trim_Level__c, dealer__VIN_Decode_Id__c, dealer__VIN_Not_Present__c, dealer__VIN__c, dealer__Veh_Owner_Contact__c, dealer__Veh_Owner__c, dealer__Vehicle_Description__c, dealer__Vehicle_Type__c, dealer__Warranty_Exp_Date__c, dealer__Warranty_Exp_Miles__c, dealer__Year__c, dealer__Body_Type_Picklist__c, dealer__Last_8__c, dealer__Conversion__c, Name FROM dealer__Service_Vehicle__C WHERE Id =:serviceVehicle.Id LIMIT 1];
        }

        tradeRecord.Name=serviceVehicle.dealer__Year__c+' '+serviceVehicle.dealer__Make__c+' '+serviceVehicle.dealer__Carline__c;
        if(tradeRecord.Id==null){//to avoid Field is not writeable error
            tradeRecord.dealer__Car_Deal__c             =   appraisal.dealer__Deal__c;
        }


        System.debug('Setting up trade values based on service vehicle');

        tradeRecord.dealer__VIN__c=serviceVehicle.dealer__VIN__c;
        tradeRecord.dealer__Year__c=serviceVehicle.dealer__Year__c;
        tradeRecord.dealer__Make__c=serviceVehicle.dealer__Make__c;
        tradeRecord.dealer__Model__c=serviceVehicle.dealer__Carline__c;
        tradeRecord.dealer__Trim_Level__c=serviceVehicle.dealer__Trim_Level__c;
        tradeRecord.dealer__Service_Vehicle__c = serviceVehicle.Id;

        System.debug('Associating Appraisal Values');

        tradeRecord.dealer__Appraisal_Date__c   =   appraisal.dealer__Appraisal_Date__c;
        tradeRecord.dealer__Appraised_By__c     =   appraisal.dealer__Appraised_By__c;
        tradeRecord.dealer__Recon__c            =   appraisal.dealer__Reconditioning__c;
        tradeRecord.dealer__ACV__c              =   (appraisal.dealer__ACV_Actual_Cash_Value__c == null) ? 0 : appraisal.dealer__ACV_Actual_Cash_Value__c;
        if(tradeRecord.dealer__Odometer_at_Trade_In__c ==null) { tradeRecord.dealer__Odometer_at_Trade_In__c = appraisal.dealer__Odometer__c; }
        System.debug('Calc allowance, payoff, net, profit');

        tradeRecord.dealer__Trade_Allowance__c = (tradeAllowance == null) ? 0 : tradeAllowance;
        tradeRecord.dealer__Pay_Off_Amount__c  = (payOffAmount == null) ? 0 : payOffAmount; //(appraisal.dealer__Loan_Payoff_Amount__c !=null) ? appraisal.dealer__Loan_Payoff_Amount__c : 0; //(payOffAmount == null) ? 0 : payOffAmount;
        tradeRecord.dealer__Net__c             = tradeRecord.dealer__Trade_Allowance__c - tradeRecord.dealer__Pay_Off_Amount__c;
        tradeRecord.dealer__Profit__c = tradeRecord.dealer__Trade_Allowance__c - tradeRecord.dealer__ACV__c;
        

        System.debug(tradeRecord);
    }
        
    /**
     * saveLine
     * @return PageReference 
     * @description Save Estimate Line and Reload Appraisal
     */ 
    public PageReference saveLine() 
    {
            // Save Estimate Line and ReLoad Appraisal
            
            if (reconDescription == NULL || reconDescription == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Please add a valid Reconditioning Expense description'));
                } else if(reconEstimate == 0 || reconEstimate == NULL){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Please please add valid Reconditioning Expense price'));
                    } else { 
                        dealer__Service_Estimate_Line__c newLine = new dealer__Service_Estimate_Line__c(
                            dealer__Service_Estimate__c=appraisal.dealer__Service_Estimate__c,
                            dealer__Description__c=reconDescription,
                            dealer__Repair_Type__c=reconRepairType,
                            dealer__Repair_Estimate__c=reconEstimate,
                            dealer__Labor__c=reconEstimate 
                            );
                        try {
                            insert newLine;
                            appraisal.dealer__Reconditioning__c=getReconTotalLine();
                            update appraisal;
                // System.debug(newLine);
                } Catch(DmlException e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
                    return null;            
                }

                PageReference p = Page.AppraisalWorksheet;
                p.getParameters().put('Id', appraisal.Id);
                p.setRedirect(false);
                
            }
            
            editId = NULL; 
            return null;
    }
        
    /**
     * editLine 
     * @return PageReference
     * @description Save Estimate Line and Reload Appraisal
     */ 
    public PageReference editLine() 
    {
            // Save Estimate Line and ReLoad Appraisal

            if (reconDescription == NULL || reconDescription == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Please add a valid Reconditioning Expense description'));
                return null;
                } else if(reconEstimate == 0 || reconEstimate == NULL){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Please please add a valid Reconditioning Expense price'));
                    return null;
                    } else { 

                        dealer__Service_Estimate_Line__c editLine = [SELECT Id,Name, dealer__Service_Estimate__c, dealer__Description__c, dealer__Repair_Estimate__c, 
                        dealer__Repair_Type__c, dealer__Labor__c
                        FROM dealer__Service_Estimate_Line__c
                        WHERE Id =: editId
                        ];
                        editline.dealer__Repair_Type__c=reconRepairType;
                        editline.dealer__Description__c=reconDescription;
                        editline.dealer__Repair_Estimate__c=reconEstimate;
                        editline.dealer__Labor__c=reconEstimate; 


                        try {
                            update editLine;
                            appraisal.dealer__Reconditioning__c=getReconTotalLine();
                            update appraisal;            
                            } Catch(DmlException e) {

                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
                                return null;            
                            }

                            PageReference p = Page.AppraisalWorksheet;
                            p.getParameters().put('Id', appraisal.Id);
                            p.setRedirect(false);
                            editId = NULL;


                        }

            return null;
    }

    /**
     * deleteLine
     * @return PageReference 
     * @description Delete Estimate Line and reload Appraisal
     */
    public PageReference deleteLine() 
    {


            dealer__Service_Estimate_Line__c deleteLine = [SELECT Id,Name, dealer__Service_Estimate__c, dealer__Description__c, dealer__Repair_Estimate__c,
            dealer__Labor__c
            FROM dealer__Service_Estimate_Line__c
            WHERE Id =: reId
            ];

        try {
            delete deleteLine;
        }Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error : '+e.getMessage()));
            return null;            
        }

        appraisal.dealer__Reconditioning__c=getReconTotalLine();
        PageReference p = Page.AppraisalWorksheet;
        p.getParameters().put('Id', appraisal.Id);
        p.setRedirect(false);                                 

        return null;
    }

    /**
     * fetchLoanPayoff 
     * @return LoanPayoff__c
     * @description Shows Bank Information for Bank Loans on the appraised Vehicle
     */
    public LoanPayoff__c fetchLoanPayoff() 
    {
       LoanPayoff__c loanPayoff = new LoanPayoff__c();
        if(appraisal.Id != null ){
            try{
                loanPayoff = [SELECT AccountNumber__c, Appraisal__c, 
                              BankCity__c, BankName__c, BankState__c, BankStreetAddress__c, PaymentMethod__c,
                              BankWireName__c, BankZip__c, LienholderPhone__c, 
                              PayoffAmount__c, PayoffExpiration__c, RoutingNumber__c, Name, Id
                              FROM LoanPayoff__c 
                              WHERE Appraisal__c =: appraisal.Id LIMIT 1]; 

            } catch(QueryException e){} //no need to throw an exception here    
        }
        return loanPayoff;
    }

    /**
     * getEstimateLines 
     * @return List<dealer__Service_Estimate_Line__c>
     * @description
     */
    public List<dealer__Service_Estimate_Line__c> getEstimateLines() 
    {
        return [ Select Id, Name, dealer__Description__c , dealer__Repair_Estimate__c , dealer__Labor__c ,
        dealer__Repair_Type__c ,dealer__Service_Estimate__c
        FROM dealer__Service_Estimate_Line__c 
        WHERE dealer__Service_Estimate__c =:appraisal.dealer__Service_Estimate__c ];
    }

    /**
     * getReconTotalLine 
     * @return Decimal
     * @description Show Service Estimate Total from Appraisal
     */
    public Decimal getReconTotalLine() 
    {
        return [ Select dealer__Service_Estimate__r.dealer__Estimate_Total__c
        FROM dealer__Appraisal__c
        WHERE Id=:appraisal.Id].dealer__Service_Estimate__r.dealer__Estimate_Total__c;

    }

    /**
     * getServiceVehicleByVIN 
     * @param VIN 
     * @return List<dealer__Service_Vehicle__c>
     * @description
     */
    public List<dealer__Service_Vehicle__c> getServiceVehicleByVIN(String VIN) 
    {
        return [SELECT ID, dealer__Body_Style_Id__c, dealer__Body_Style__c, dealer__Body_Type__c, dealer__Carline__c, dealer__Comments__c, dealer__Company_Number__c, dealer__Conversion_MFG__c, 
        dealer__Customer_Key__c, dealer__Doors__c, dealer__Drive_Type__c, dealer__Engine_Description__c, dealer__Engine_Displacement__c, 
        dealer__Engine_ID__c, dealer__Equipment_Number__c, dealer__Ext_Color__c, dealer__External_ID__c, dealer__Horsepower__c, dealer__Hours__c, 
        dealer__In_Service_Date__c, dealer__Int_Color__c, dealer__Key_1__c, dealer__Key_2__c, dealer__Last_6__c, dealer__Last_Activity__c, 
        dealer__Last_Odometer__c, dealer__Last_Service__c, dealer__Licence_State__c, dealer__Licence__c, dealer__Make_Code__c, dealer__Make__c, 
        dealer__Marketing_ID__c, dealer__Model_Code__c, dealer__Open_Repair_Orders__c, dealer__Package_Code__c, dealer__Recommendations__c, 
        dealer__Sale_Date__c, dealer__Sales_Inventory__c, dealer__Search_Names__c, dealer__Service_Interval_Average_Days__c, 
        dealer__Service_Interval_Average_Odometer__c, dealer__Status_Code__c, dealer__Stock_Number__c, dealer__Style_Id__c, 
        dealer__Transmission_Type__c, dealer__Trim_Level__c, dealer__VIN_Decode_Id__c, dealer__VIN_Not_Present__c, dealer__VIN__c, 
        dealer__Veh_Owner_Contact__c, dealer__Veh_Owner__c, dealer__Vehicle_Description__c, dealer__Vehicle_Type__c, dealer__Warranty_Exp_Date__c, 
        dealer__Warranty_Exp_Miles__c, dealer__Year__c, dealer__Body_Type_Picklist__c, dealer__Last_8__c, dealer__Conversion__c, Name 
        FROM dealer__Service_Vehicle__C 
        WHERE dealer__VIN__c =:serviceVehicle.dealer__VIN__c LIMIT 1];             
    }

    /**
     * getData 
     * @param  vin 
     * @return Map<String, Object>  
     * @description Show user an error when VIN Decode fails  
     */ 
    @remoteAction
    public static Map<String, Object> getData(String vin) 
    {                
        /* W-000785 Begin */
        try{        
            Map<String, Object> results = dealer.VinDecodeRemote.decodedVin(vin);
            return results;
        }catch(Exception e){            
                Map<String, Object> errorResults = new Map<String, Object>();
                errorResults.put('Error', e.getMessage());
                return errorResults;              
        }
            /* W-000785 End */        
    }            

    /**
     * forms 
     * @return pagereference
     * @description
     */ 
    public pagereference forms()
    {
        PageReference p = Page.AppraisalForms;
        p.getParameters().put('Id', appraisal.Id);
        return p;
    }

    /**
     * saveVehicleDamage 
     * @param  s 
     * @return boolean
     * @description Returns true if Vehcile Damage was sucessfully saved
     */ 
    @RemoteAction
    public static boolean saveVehicleDamage(String s) 
    {
        /*
        *   0 = MPI ID
        *   1 = Body Damage URL
        */
        String[] parts = s.split('~');

        if(parts.size()!=2) {
            return false;
        }

        dealer__Appraisal__c mp = [Select Id from dealer__Appraisal__c where Id =:parts[0] limit 1];
        mp.dealer__Body_Damage_URL__c = parts[1];

        update mp;

        return true;
    }

    /**
     * retrieveBankName
     * @return void
     * @description Gets Name of Bank from first Wire on the Account
     */ 
    public void retrieveBankName()
    {
        if(appraisalOne.dealer__Vehicle_Owner__c != null){
            // appraisal.First_Bank_Wire_Name__c = [SELECT Id, Name FROM Account WHERE Id =: appraisalOne.dealer__Vehicle_Owner__c].Name;
        }
    }

   /**
    * doDecode
    * @param  VIN 
    * @description Get year/make/model for  Vin Decode
    */ 
    public void doDecode(String VIN) 
    {
        vd.DecodeVIN(VIN);
        ddat = vd.decodeData;
        ModelKeyList = ddat.styles;

        //Get year/make/model for VINDecodeStyleSeelctAppraisal page
        if (ddat != null && ddat.common_data != null) {
            serviceVehicle.Year__c = ddat.common_data.year;
            serviceVehicle.Make__c = ddat.common_data.make;
            serviceVehicle.CarLine__c = ddat.common_data.model;
            serviceVehicle.Body_Type__c = ddat.common_data.body_type;
            this.serviceVehicle.Name = serviceVehicle.Year__c + ' ' + serviceVehicle.Make__c + ' ' + serviceVehicle.Carline__c;
        }
    }

    /**
     * doDecodePage 
     * @return PageReference
     * @description Start Decode, otherwise display error message
     */ 
    public PageReference doDecodePage() 
    {
        if (this.serviceVehicle.VIN__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'VIN must be present'));
            return null;
        }
        doDecode(this.serviceVehicle.VIN__c);
        isDecode = true;
        PageReference pager = Page.VINDecodeStyleSelectAppraisal;
        if(ApexPages.currentPage().getParameters().get('sid') != null){
            pager.getParameters().put('sid', ApexPages.currentPage().getParameters().get('sid'));
        }
        return pager;
    }

    /**
     * vinNotPresent
     * @return PageReference
     * @description
     */ 
    public PageReference vinNotPresent() 
    {
        this.serviceVehicle.VIN_Not_Present__c = true;
        return Page.AppraisalWorksheet;
    }

    /**
     * editPage
     * @return PageReference
     * @description Determine whether Vehicle is new record, populate transmission fields, get list of optional equipment and get list of installed equipment.
     */
    public PageReference editPage() 
    {
        Sales_Up__c sup;
        if (ApexPages.currentPage().getParameters().get('sid')!=null) {
            sup = [SELECT Id, Name, Trade_Year__c, Trade_Make__c, Trade_Model__c, Trade_Trim_Level__c, Trade_Mileage__c FROM Sales_Up__c WHERE Id =: ApexPages.currentPage().getParameters().get('sid') LIMIT 1];
        }
        if (SelectedStyleId != null) {
            ddat = vd.decodeData;
            sdat = vd.SelectedStyle(SelectedStyleId);
        }

        // Determine if Vehicle exists or if this is a new record
        Service_Vehicle__c[] ev = [Select d.Year__c, d.Warranty_Exp_Miles__c, d.Warranty_Exp_Date__c, d.Vehicle_Type__c,
            d.Vehicle_Description__c, d.Veh_Owner__c, d.Veh_Owner_Contact__c, d.VIN__c,
            d.Trim_Level__c, d.Transmission_Type__c, d.Stock_Number__c, d.Sales_Inventory__c,
            d.Recommendations__c, d.Package_Code__c, d.Make__c, d.Make_Code__c, d.Licence__c,
            d.Last_Service__c, d.Last_Odometer__c, d.Last_Activity__c, d.Last_6__c, d.Key_2__c,
            d.Key_1__c, d.Int_Color__c, d.In_Service_Date__c, d.Ext_Color__c,
            d.Equipment_Number__c, d.Engine_ID__c, d.Engine_Displacement__c, d.Engine_Description__c,
            d.Drive_Type__c, d.Company_Number__c, d.Comments__c, d.Carline__c, d.Body_Style_Id__c,
            d.SystemModstamp, d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, d.IsDeleted, d.Id,
            d.CreatedDate, d.CreatedById
            From Service_Vehicle__c d
            Where Id =: this.serviceVehicle.Id limit 1
        ];

        if (ev.size() > 0) {
            serviceVehicle.Name = ev[0].Name;
        }
        if (ddat != null && ddat.common_data != null) {
            serviceVehicle.Year__c = ddat.common_data.year;
            serviceVehicle.Make__c = ddat.common_data.make;
            serviceVehicle.CarLine__c = ddat.common_data.model;
            serviceVehicle.Body_Type__c = ddat.common_data.body_type;
            this.serviceVehicle.Name = serviceVehicle.Year__c + ' ' + serviceVehicle.Make__c + ' ' + serviceVehicle.Carline__c;
        } else if (ddat != null && ddat.styles.size() > 0 && ddat.styles[0].vehicle_id != null && ddat.styles[0].basic_data != null) {
            serviceVehicle.Year__c = ddat.styles[0].basic_data.year;
            serviceVehicle.Make__c = ddat.styles[0].basic_data.make;
            serviceVehicle.Carline__c = ddat.styles[0].basic_data.model;
            this.serviceVehicle.Name = serviceVehicle.Year__c + ' ' + serviceVehicle.Make__c + ' ' + serviceVehicle.Carline__c;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, ' + vd.decodeError));
            system.debug('Unable to decode VIN ' + vd.decodeError);
            return null;
        }

        if (sup != null) {
            serviceVehicle.Last_Odometer__c = sup.Trade_Mileage__c;
        }

        if (sdat != null) {
            if (sdat.basic_data != null) {
                serviceVehicle.Trim_Level__c = sdat.basic_data.trim;
                serviceVehicle.Model_Code__c = String.valueOf(sdat.basic_data.model_number);
                serviceVehicle.Doors__c = Decimal.valueOf(sdat.basic_data.doors);
                serviceVehicle.Drive_Type__c = sdat.basic_data.drive_type;

                if (!Utility.isBlank(sdat.basic_data.body_subtype)) {
                    serviceVehicle.Body_Style__c = sdat.basic_data.body_subtype;
                } else if (ddat != null) {
                    serviceVehicle.Body_Style__c = ddat.common_data.body_type;
                }
            }
        }

        if (sdat.engines != null && sdat.engines.size() > 0) {
            serviceVehicle.Engine_Description__c = sdat.engines[0].name;
            serviceVehicle.Engine_Displacement__c = Decimal.valueOf(sdat.engines[0].displacement);
            serviceVehicle.Engine_Id__c = sdat.engines[0].engine_id;
            for (VINDecoderDataObject.Engine engine: sdat.engines) {
                engineSelect.add(new SelectOption(engine.engine_id, engine.name));
            }
        }

        //check list size before accessing 0th record
        if (sdat.transmissions != null && sdat.transmissions.size() > 0) {
            //populate transmission related fields 
            serviceVehicle.Transmission_Type__c = sdat.transmissions[0].name + ' (' + sdat.transmissions[0].type + ')';
            for (VINDecoderDataObject.Transmission transmission: sdat.transmissions) {
                transmissionSelect.add(new SelectOption(transmission.transmission_id, transmission.name));
            }
        }

        // Get Optional Equipment
        if (sdat.optional_equipment != null) {
            for (VINDecoderDataObject.OptionalEquipment oe: sdat.optional_equipment) {
                // Get List of OptionalEquipment in this Category
                List < VINDecoderDataObject.OptionalEquipmentDetails > opEdList = oe.options;
                for (VINDecoderDataObject.OptionalEquipmentDetails opEd: opEdList) {
                    VinDecoderAPI.OptionalEquipment optEquipList = new VinDecoderAPI.OptionalEquipment(
                        false,
                        oe.category,
                        opEd.name,
                        opEd.description,
                        opEd.install_type,
                        opEd.order_code,
                        opEd.option_id
                    );
                    this.OptEquip.add(optEquipList); //tk222
                }
            }
        }
        // Get Installed Equipment
        if (sdat.installed_equipment != null) {
            for (VINDEcoderDataObject.InstalledEquipment ie: sdat.installed_equipment) {
                List < VINDecoderDataObject.InstalledEquipmentDetails > ieList = ie.equipment;
                for (VINDecoderDataObject.InstalledEquipmentDetails opIq: ieList) {
                    VinDecoderAPI.InstalledEquipment inEqList = new VinDecoderAPI.InstalledEquipment(
                        true,
                        ie.category,
                        opIq.name,
                        opIq.values[0]
                    );
                    this.InstalledEquipment.add(inEqList);
                }
            }
        }

        PageReference pager = Page.AppraisalWorksheet;
        if(ApexPages.currentPage().getParameters().get('sid') != null){
            pager.getParameters().put('sid', ApexPages.currentPage().getParameters().get('sid'));
            system.debug('return page ==== ' + pager);
        }
        return pager;

    }

    /**
     * getModelKeyList
     * @return List < VINDEcoderDataObject.Style >
     * @description
     */ 
    public List < VINDEcoderDataObject.Style > getModelKeyList() 
    {
        return ModelKeyList;
    }

    /**
     * getDecode 
     * @return VINDecoderDataObject.DecodeData
     * @description
     */ 
    public VINDecoderDataObject.DecodeData getDecode() 
    {
        return ddat;
    }

    /**
     * getSelectedStyleId
     * @return String
     * @description Shows Style Id
     */
    public String getSelectedStyleId() 
    {
        return SelectedStyleId;
    }

    /**
     * setSelectedStyleId
     * @description Set Style Id
     */
     public void setSelectedStyleId(String SelectedStyleId) 
    {
        this.SelectedStyleId = SelectedStyleId;
    }

    /**
     * getEngineSelect 
     * @return List < SelectOption >
     * @description Shows selected Engine
     */
    public List < SelectOption > getEngineSelect() 
    {
        return engineSelect;
    }

    /**
     * getTransmissionSelect
     * @return List < SelectOption > 
     * @description Shows selected Transmission
     */ 
    public List < SelectOption > getTransmissionSelect() 
    {
        return transmissionSelect;
    }
    
    /**
     * getOptEquip
     * @return List < VinDecoderAPI.OptionalEquipment >
     * @description Shows list of Optional Equipment
     */ 
    public List < VinDecoderAPI.OptionalEquipment > getOptEquip() 
    {
        return OptEquip;
    }

    /**
     * getInstalledEquipment 
     * @return List < VinDecoderAPI.InstalledEquipment
     * @description Shows list of Installed Equipment
     */
    public List < VinDecoderAPI.InstalledEquipment > getInstalledEquipment() 
    {
        return InstalledEquipment;
    }

    /**
     * getIsDecode
     * @return boolean
     * @description Returns true if Vin is Decoded successfully
     */ 
    public boolean getIsDecode()
    {
        return isDecode;
    }

    /**
     * @description
     */
    public class AppraisalException extends Exception {}

}