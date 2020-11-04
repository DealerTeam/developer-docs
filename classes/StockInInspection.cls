/**
* Date            |Developer            |Work#
* Notes
* --

*2016.07.12       |Sneha                |T-00869
*   Added Null Check to avoid null pointer exception
*/
public with sharing class StockInInspection {

    private String svcVehID { get; set;}
    private String appraisalTypeId { get; set;}
    public String supId { get; set;}
    public dealer__Sales_Up__c sup { get; set; }
    
    public String recId {get; set;}
    public String recEditIds{get; set;}
    public Decimal purchaseAmt { get; set; }
    public String stockNumber { get; set; }
    public String invoiceRef { get; set; }
    
    public dealer__Appraisal__c appraisal {get;set;}
    public dealer__Appraisal_Vehicle__c appraisalVeh { get; set; }
    public dealer__Appraisal_Vehicle__c appraisalVehicle;
    public dealer__Inspection_Report__c inspection {get;set;}
    public dealer__Service_Vehicle__c serviceVeh { get; set; }
    
    public dealer__Inspection_Report_Lines__c inspectionReportLine { get; set;}
    public dealer__Inspection_Report_Lines__c inspectionRL{ get; set;}
     public dealer__Inspection_Report_Lines__c inspectionRLPopup{ get; set;}
    public dealer__Service_Vehicle__c serviceVehicle { get; set; }
    
    public String vinNumber { get; set;}
    public String apprId { get; set;}
    public String selectedVehicle{get; set;}
    public Decimal appraisalValue { get; set; }
    public Decimal ReconditioningTotalCost{get;set;}
    
    public String imageName { get; set; }
    public dealer__Purchase_Order__c pOrder { get; set; }
    
    public String body {get; set;}
    public String driverdoor {get; set;}
    public String passengerdoor {get; set;}
    public String driverfront_wheel {get; set;}
    public String driverrear_wheel {get; set;}
    public String passengerfront_wheel {get; set;}
    public String passengerrear_wheel {get; set;}
    
    public String passengerfront_yellow_tire {get; set;}
    public String passengerfront_red_tire {get; set;}
    public String passengerrear_yellow_tire {get; set;}
    public String passengerrear_red_tire {get; set;}
    
    public String driverfront_yellow_tire {get; set;}
    public String driverfront_red_tire {get; set;}
    public String driverrear_yellow_tire {get; set;}
    public String driverrear_red_tire {get; set;}
    
    public String passengerfront_yellow_brake {get; set;}
    public String passengerfront_red_brake {get; set;}
    public String passengerrear_yellow_brake {get; set;}
    public String passengerrear_red_brake {get; set;}
    
    public String driverfront_yellow_brake {get; set;}
    public String driverfront_red_brake {get; set;}
    public String driverrear_yellow_brake {get; set;}
    public String driverrear_red_brake {get; set;}
    
    public String door {get; set;}
    public String tire {get; set;}
    public String brake {get; set;}
    public String interior {get; set;}
    public String mechanical {get; set;}
    public String wheel {get; set;}
    public String vid;
    
    public String driverfront_body{get;set;}
    public String driverrear_body{get;set;}
    public String passengerfront_body{get;set;}
    public String passengerrear_body{get;set;}
    
    //Getter setter for x and y co ordinates.
    public decimal xCoord{get;set;}
    public decimal yCoord{get;set;}
    
    public decimal xCoordDriverDoor{get;set;}
    public decimal yCoordDriverDoor{get;set;}
    
    public decimal xCoordPassengerDoor{get;set;}
    public decimal yCoordPassengerDoor{get;set;}
    
    public decimal xCoordPassengerFrontDoor{get;set;}
    public decimal yCoordPassengerFrontDoor{get;set;}
    
    public decimal xCoordPassengerRearDoor{get;set;}
    public decimal yCoordPassengerRearDoor{get;set;}
    
    public decimal xCoordDriverFrontDoor{get;set;}
    public decimal yCoordDriverFrontDoor{get;set;}
    
    public decimal xCoordDriverRearDoor{get;set;}
    public decimal yCoordDriverRearDoor{get;set;}
    public String imageStyleClass{get;set;}

    public list<dealer__DMS_Settings__c> dealDefaults = dealer__DMS_Settings__c.getall().values();
    
    public StockInInspection( ApexPages.StandardController controller ) {
        
        
        vid = ApexPages.currentPage().getParameters().get('vid');

        /* Get all of the fields to the controller for inclusion */
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Appraisal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        //System.debug('---fieldnames--'+M.get('dealer__vRank__c')); 
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            controller.addFields(af);
        }  

        appraisal = (dealer__Appraisal__c)controller.getRecord();
        if(Utility.IsBlank(appraisal.Id)){
            appraisal.OwnerId = userInfo.getUserId();
        }
        
        selectedVehicle = appraisal.dealer__service_vehicle__c;
        System.debug('---appraisal----'+appraisal.id);
        //System.debug('---appraisal----'+appraisal.dealer__vRank__c);
        
        supId  =  ApexPages.currentPage().getParameters().get('sid');
        apprId  =  ApexPages.currentPage().getParameters().get('id');

        //inspectionReportLine = new dealer__Inspection_Report_Lines__c(); 
        inspection = new dealer__Inspection_Report__c();
        
        pOrder = new dealer__Purchase_Order__c();
        
        appraisalTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Appraisal' LIMIT 1].Id;
            
        if (!Utility.IsBlank(supId)) {
            sup = fetchSalesUp();
            appraisal.Sales_Up__c =  supId; 
        }

        init();
    }
    //KVP
    //Return phone number of account(bussiness Account/person Account)
    public String getContactPhone(){
        String phone;
        if(serviceVeh != null){
                phone =  !Utility.isBlank(serviceVeh.dealer__Veh_Owner_Contact__r.MobilePhone) ? serviceVeh.dealer__Veh_Owner_Contact__r.MobilePhone                         
                         :!Utility.isBlank(serviceVeh.dealer__Veh_Owner_Contact__r.Phone) ? serviceVeh.dealer__Veh_Owner_Contact__r.Phone
                         :!Utility.isBlank(serviceVeh.dealer__Veh_Owner_Contact__r.OtherPhone) ? serviceVeh.dealer__Veh_Owner_Contact__r.OtherPhone
                         :null;      
        }
      return phone;
    }
     
    public dealer__Appraisal__c newAppraisal(){
        dealer__Appraisal__c newAppraisal = new dealer__Appraisal__c();
        if(Utility.IsBlank(newAppraisal.Id)){
            newAppraisal.OwnerId = userInfo.getUserId();
        }
        if (!Utility.IsBlank(supId)) {
            sup = fetchSalesUp();
            newAppraisal.Sales_Up__c =  supId;
            if(sup.RecordType.DeveloperName == 'Standard_Sales_Up'){
                newAppraisal.dealer__Acquisition_method__c = 'Trade-in';
            }
            if(sup.RecordType.DeveloperName == 'Curb Purchase'){
                newAppraisal.dealer__Acquisition_method__c = 'Curb_Purchase';
            }
            newAppraisal.Store_Location__c = sup.dealer__Store_Location__c;
            
            System.debug('---------sup-----------'+sup);
            
        }
        newAppraisal.Type__c = (newAppraisal.dealer__Sales_Up__c != null) ? 'Retail' : 'Wholesale' ;
        if(newAppraisal.dealer__Sales_Up__c == null){
            newAppraisal.dealer__Acquisition_method__c = 'Auction';
        }
        
        newAppraisal.Transportation__c = (newAppraisal.Transportation__c == null) ? 0.00 : newAppraisal.Transportation__c;
        newAppraisal.Certification__c = (newAppraisal.Certification__c == null) ? 0.00 : newAppraisal.Certification__c;
        newAppraisal.Auction_Fee__c = (newAppraisal.Auction_Fee__c == null) ? 0.00 : newAppraisal.Auction_Fee__c;
        
        decimal mechEst = (inspection.Mechanical_Recon__c == null) ? 0.00 : inspection.Mechanical_Recon__c;
        decimal bodyEst = (inspection.Body_Glass_Recon__c == null) ? 0.00 : inspection.Body_Glass_Recon__c;
        decimal intEst =  (inspection.Interior_Recon__c == null) ? 0.00 : inspection.Interior_Recon__c;
        decimal tireEst = (inspection.Tires_Recon__c == null) ? 0.00 : inspection.Tires_Recon__c;
        decimal brakeEst = (inspection.Brakes_Recon__c == null) ? 0.00 : inspection.Brakes_Recon__c;
       
        newAppraisal.Expected_Costs__c = newAppraisal.Transportation__c + newAppraisal.Certification__c + newAppraisal.Auction_Fee__c + 
                                        mechEst + bodyEst + intEst + tireEst + brakeEst;
        //appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c;
        
        newAppraisal.Asking_Price__c = (newAppraisal.Asking_Price__c == null) ? 0.00 : newAppraisal.Asking_Price__c;
        newAppraisal.Profit_Objective__c = (newAppraisal.Profit_Objective__c == null) ? 0.00 : newAppraisal.Profit_Objective__c;
        newAppraisal.Expected_Costs__c = (newAppraisal.Expected_Costs__c == null) ? 0.00 : newAppraisal.Expected_Costs__c;
        
        appraisalValue = newAppraisal.Appraised_Value__c;
        //dmsDealStatus = !dealDefaults.isEmpty() ? dealDefaults[0].dealer__Deal_status_for_inventory__c : null;
        newAppraisal.Asking_Price__c = dealDefaults[0].dealer__Asking_Price__c;
        newAppraisal.Profit_Objective__c = dealDefaults[0].dealer__Profit_Objective__c;
        newAppraisal.Certification__c = dealDefaults[0].dealer__Certification__c;
        newAppraisal.Transportation__c = dealDefaults[0].dealer__Transportation__c;
        newAppraisal.Auction_Fee__c = dealDefaults[0].dealer__Auction_Fee__c;
        newAppraisal.Expected_Costs__c = newAppraisal.Transportation__c + newAppraisal.Certification__c + newAppraisal.Auction_Fee__c;
        
        System.debug('-----newAppraisal-----------'+newAppraisal);
        return newAppraisal;
    }
    // Method to get the fields from the field set
    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Appraisal__c.FieldSets.Valuation.getFields();
    }

    // Method to initilize the objects values
    public void init(){
        System.debug('---appraisal.Sales_Up__c---'+appraisal.Sales_Up__c);
        supId = appraisal.Sales_Up__c;
        System.debug('---------supId---------'+supId);
        if (!Utility.IsBlank(supId)) {
            sup = fetchSalesUp();
            if(sup.RecordType.DeveloperName == 'Standard_Sales_Up'){
                appraisal.dealer__Acquisition_method__c = 'Trade-in';
            }
            if(sup.RecordType.DeveloperName == 'Curb Purchase'){
                appraisal.dealer__Acquisition_method__c = 'Curb_Purchase';
            }
            appraisal.Store_Location__c = sup.dealer__Store_Location__c;
            
            System.debug('---------sup-----------'+sup);
            
        }
        
        fetchDefaultServiceVeh();
        fetchServiceVehFromVIN();
        fetchServiceVehInfo();
        
        appraisal.Type__c = (appraisal.dealer__Sales_Up__c != null) ? 'Retail' : 'Wholesale' ;
        if(appraisal.dealer__Sales_Up__c == null){
            appraisal.dealer__Acquisition_method__c = 'Auction';
        }
        
        appraisal.Transportation__c = (appraisal.Transportation__c == null) ? 0.00 : appraisal.Transportation__c;
        appraisal.Certification__c = (appraisal.Certification__c == null) ? 0.00 : appraisal.Certification__c;
        appraisal.Auction_Fee__c = (appraisal.Auction_Fee__c == null) ? 0.00 : appraisal.Auction_Fee__c;
        
        decimal mechEst = (inspection.Mechanical_Recon__c == null) ? 0.00 : inspection.Mechanical_Recon__c;
        decimal bodyEst = (inspection.Body_Glass_Recon__c == null) ? 0.00 : inspection.Body_Glass_Recon__c;
        decimal intEst  = (inspection.Interior_Recon__c == null) ? 0.00 : inspection.Interior_Recon__c;
        decimal tireEst = (inspection.Tires_Recon__c == null) ? 0.00 : inspection.Tires_Recon__c;
        decimal brakeEst= (inspection.Brakes_Recon__c == null) ? 0.00 : inspection.Brakes_Recon__c;
        //Sum of all reconditioning line items to display in appriasal form (pdf)
        ReconditioningTotalCost =  mechEst + bodyEst + intEst + tireEst + brakeEst; 
         
        appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c + 
                                        mechEst + bodyEst + intEst + tireEst + brakeEst;
        //appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c;
        
        appraisal.Asking_Price__c = (appraisal.Asking_Price__c == null) ? 0.00 : appraisal.Asking_Price__c;
        appraisal.Profit_Objective__c = (appraisal.Profit_Objective__c == null) ? 0.00 : appraisal.Profit_Objective__c;
        appraisal.Expected_Costs__c = (appraisal.Expected_Costs__c == null) ? 0.00 : appraisal.Expected_Costs__c;
        
        appraisalValue = appraisal.Appraised_Value__c;
        //appraisal.Appraised_Value__c = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
        //this.appraisal = getApprsl();
        fetchImageName();
        if(appraisal.Id == null){
            //serviceVeh.dealer__Body_Type_Picklist__c = 'Sedan';
            //Checking if service vehicle body type values exist in the body type Picklist values
            set<String> picklistSet =  new set<String>();
            Schema.DescribeFieldResult fieldResult = dealer__Service_Vehicle__c.dealer__Body_Type_Picklist__c.getDescribe();
               for( Schema.PicklistEntry f : fieldResult.getPicklistValues())
               {
                  picklistSet.add(f.getValue());
               }     
            serviceVeh.dealer__Body_Type_Picklist__c = serviceVeh.dealer__Body_Type__c != null && picklistSet.contains(serviceVeh.dealer__Body_Type__c) ? serviceVeh.dealer__Body_Type__c : 'Sedan';
            //Setting the image based on body type.
            //imageName = 'Sedan.jpg';
            imageName =   serviceVeh.dealer__Body_Type_Picklist__c+'.jpg';
            //dmsDealStatus = !dealDefaults.isEmpty() ? dealDefaults[0].dealer__Deal_status_for_inventory__c : null;
            if(!dealDefaults.isEmpty()){
                appraisal.Asking_Price__c = dealDefaults[0].dealer__Asking_Price__c;
                appraisal.Profit_Objective__c = dealDefaults[0].dealer__Profit_Objective__c;
                appraisal.Certification__c = dealDefaults[0].dealer__Certification__c;
                appraisal.Transportation__c = dealDefaults[0].dealer__Transportation__c;
                appraisal.Auction_Fee__c = dealDefaults[0].dealer__Auction_Fee__c;
            }

            //T-00869 : begins
            if(appraisal.Transportation__c!=null && appraisal.Certification__c!=null && appraisal.Auction_Fee__c!=null){
                appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c;
            }    
            //T-00869 : ends        
            
        }
        initLineItem();
        
    }
    
     
    
    // Method to create inspection Line
    public void initLineItem(){
        inspectionReportLine = new dealer__Inspection_Report_Lines__c();
        inspectionRLPopup = new dealer__Inspection_Report_Lines__c();
    }
    
    // Method to fetch the sales up
    public dealer__Sales_Up__c fetchSalesUp(){
        
        return [SELECT Id, Name,dealer__Trade_VIN__c,dealer__Trade_Year__c,dealer__Trade_Make__c,dealer__Trade_Model__c,
                dealer__Trade_Trim_Level__c,dealer__Trade_Mileage__c,dealer__Trade_Body_Type__c,dealer__Trade_Comments__c,  
                dealer__Salesperson_1__c, RecordType.DeveloperName, dealer__Store_Location__c 
                FROM dealer__Sales_Up__c WHERE id =:supId];
    }
    
    
    // Method to fetch default vehicle information
    public void fetchDefaultServiceVeh(){
        //dealer__Appraisal_Vehicle__c appraisalVehicle;
         vid = ApexPages.currentPage().getParameters().get('vid');
        try{

            if(vid != null){
                appraisalVehicle = [Select Id, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, dealer__Appraisal__c
                FROM dealer__Appraisal_Vehicle__c 
                WHERE dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c != null AND dealer__Service_Vehicle__c = :vid];
                selectedVehicle = vid; 
            }else if(vid == null){
                appraisalVehicle = [Select Id, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, dealer__Appraisal__c
                FROM dealer__Appraisal_Vehicle__c 
                WHERE dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c != null ORDER BY createdDate ASC LIMIT 1];
                selectedVehicle = appraisalVehicle.dealer__Service_Vehicle__c;
            }
            vinNumber = appraisalVehicle.dealer__Service_Vehicle__r.dealer__Vin__c;
            //}
            System.debug('----selectedVehicle---'+selectedVehicle);
        }catch(Exception e){
            appraisalVehicle = new dealer__Appraisal_Vehicle__c();
        }
    }
    
    // Method to get all the service vehicle for current sales Up
    public List<SelectOption> getServiceVehicles() {
        List<SelectOption> options = new List<SelectOption>();
        List<dealer__Appraisal_Vehicle__c> appraisalVehicleLst = new List<dealer__Appraisal_Vehicle__c>();
        //Id vehId = ApexPages.currentPage().getParameters().get('vid');
        appraisalVehicleLst = [Select Id, dealer__MakeModelYearTrim__c, dealer__Service_Vehicle__c FROM dealer__Appraisal_Vehicle__c 
                WHERE  dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c != null ORDER BY createdDate DESC];
       /* if(vehId==null){
            appraisalVehicleLst = appraisalVehicleLst;
        }else {
            appraisalVehicle = [Select Id, dealer__MakeModelYearTrim__c, dealer__Service_Vehicle__c FROM dealer__Appraisal_Vehicle__c 
                WHERE  dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c = :vehId];
            appraisalVehicleLst[0] = appraisalVehicle;
            //selectedVehicle = vehId;
        }*/
        
        
        for (Integer i=0; i < appraisalVehicleLst.size(); i++) {
            options.add(new SelectOption(appraisalVehicleLst[i].dealer__Service_Vehicle__c, appraisalVehicleLst[i].dealer__MakeModelYearTrim__c));
        }
        
        return options;
    }
    
    //Method to call on change of service vehicle in page.
    public void changeVehicle(){
        fetchServiceVehInfo();
        saveInspection();
    }
    // Method to fetch the vehicle related information Like Service Vehicle, Appraisal, Inspection Report
    public void fetchServiceVehInfo(){
        System.debug('--selectedVehicle--'+selectedVehicle);
        try{
            
            if(!Utility.IsBlank(supId)){
                dealer__Appraisal_Vehicle__c apprVehicle = new dealer__Appraisal_Vehicle__c();
                apprVehicle = [Select Id, dealer__MakeModelYearTrim__c, dealer__Service_Vehicle__c, dealer__Appraisal__c FROM dealer__Appraisal_Vehicle__c 
                    WHERE  dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c =:selectedVehicle ORDER BY createdDate DESC LIMIT 1];
                System.debug('----apprVehicle-----'+apprVehicle);
              //Checking the person account enabled or not, if enabled retrieving person account, mobile, homephone, otherphone, email
                serviceVeh = [SELECT Id, Name, dealer__Vin__c,  dealer__Year__c,  dealer__Make__c,  dealer__Carline__c,  dealer__Trim_Level__c, dealer__Int_Color__c, 
                            dealer__Last_Odometer__c,  dealer__Body_Type__c, dealer__Licence__c, dealer__Licence_State__c, dealer__Sales_Inventory__c,
                            dealer__Veh_Owner__c,dealer__Veh_Owner_Contact__c, dealer__Veh_Owner_Contact__r.name,dealer__Veh_Owner_Contact__r.MobilePhone,
                            dealer__Veh_Owner_Contact__r.Phone,dealer__Veh_Owner_Contact__r.OtherPhone,dealer__Veh_Owner_Contact__r.Email,dealer__Veh_Owner_Contact__r.HomePhone,  
                            dealer__Veh_Owner_Contact__r.MailingStreet,dealer__Veh_Owner_Contact__r.MailingState,
                            dealer__Veh_Owner_Contact__r.MailingCity,dealer__Veh_Owner_Contact__r.MailingPostalCode, 
                            dealer__Body_Type_Picklist__c, dealer__Ext_Color__c, dealer__Transmission_Type__c,  
                            (Select Id, Name, OwnerId, dealer__Acquisition_method__c, dealer__ACV_Actual_Cash_Value__c, 
                            dealer__Anticipated_Retail_Price__c, dealer__Appraised_Value_SYS__c, dealer__Appraised_Value_Changed__c, 
                            dealer__Appraised_By__c, dealer__Appraised_Value__c , dealer__Asking_Price__c   , dealer__Auction_Fee__c, 
                            dealer__Black_Book_Finance_Advance__c, dealer__Black_Book_Retail__c, dealer__Black_Book_Wholesale__c, 
                            dealer__Certification__c, dealer__Expected_Costs__c, dealer__Inspection_Report__c, dealer__Inventory_Vehicle__c, 
                            dealer__KBB_Private_Party__c, dealer__KBB_Trade_In__c, dealer__MMR_Retail__c, dealer__MMR_Wholesale__c, dealer__NADA_Loan__c, 
                            dealer__NADA_Retail__c, dealer__NADA_Trade_In__c, dealer__Profit_Objective__c, dealer__Reconditioning__c, dealer__Salesperson_1__c, 
                            dealer__Sales_Up__c, dealer__Service_Vehicle__c, dealer__Status__c, dealer__Store_Location__c, dealer__Trade_In_Mileage__c, 
                            dealer__Trade_In_VIN__c, dealer__Transportation__c, dealer__Type__c, dealer__Vehicle_Notes__c, dealer__Vehicle_Owner__c, 
                            dealer__vAuto_Adj_Cost_to_Market__c, dealer__vAuto_Adj_of_Market__c, dealer__vAuto_Like_Mine__c, dealer__vAuto_Market_Days_Supply__c, 
                            dealer__vAuto_Price_Rank__c, dealer__vRank__c, dealer__Lost_Appraisal__c,dealer__Appraisal_Date__c, createdDate  
                            FROM Appraisals__r WHERE dealer__Sales_Up__c =:supId AND dealer__Service_Vehicle__c = :apprVehicle.dealer__Service_Vehicle__c),
                            (Select Id, Name, dealer__Acquisition_Method__c, dealer__Action_Item_Count__c, dealer__Advisor__c, dealer__Agreed_to_ToS__c, 
                            dealer__Alignment__c, dealer__Balance_Recommended__c, dealer__Battery_1_Actual_CCA__c, dealer__Body_Desc__c, dealer__Body_Est__c, 
                            dealer__Body_Type__c, dealer__Brake_DF__c, dealer__Brake_DR__c, dealer__Brake_PF__c, dealer__Brake_PR__c, dealer__Brake_Fluid__c, 
                            dealer__Brake_Lights__c, dealer__Transmission_Fluid__c, dealer__Cylinders__c, dealer__Exterior_Color__c, dealer__Mechanical_Est__c, 
                            Interior_Est__c, Tire_Recon_Est__c, Brake_Recon_Est__c, Internal_Comments__c, 
                            dealer__Mechanical_Recon__c, Body_Glass_Recon__c, Interior_Recon__c, Tires_Recon__c, Brakes_Recon__c  
                            FROM Inspection_Reports__r WHERE dealer__Sales_Up__c =:supId AND dealer__Service_Vehicle__c = :apprVehicle.dealer__Service_Vehicle__c) 
                            FROM dealer__Service_Vehicle__c
                            WHERE Id = :apprVehicle.dealer__Service_Vehicle__c LIMIT 1];
                
               
                vinNumber = serviceVeh.dealer__Vin__c;
                System.debug('-------vinNumber--------'+vinNumber); 
                //appraisal =  new dealer__Appraisal__c();
                /*
                if(!serviceVeh.Appraisals__r.isEmpty()){
                    appraisal = serviceVeh.Appraisals__r[0]; 
                } else appraisal = newAppraisal();
                */
                System.debug('---------appraisal--------'+newAppraisal());
                appraisal = (!serviceVeh.Appraisals__r.isEmpty()) ? serviceVeh.Appraisals__r[0] : newAppraisal();
                
                inspection = (!serviceVeh.Inspection_Reports__r.isEmpty() ) ? serviceVeh.Inspection_Reports__r[0] : new dealer__Inspection_Report__c();
                System.debug('--------inspection----'+inspection);
                // assigning blank value
                body = ''; driverdoor = ''; passengerdoor = ''; driverfront_wheel = ''; driverrear_wheel = ''; 
                passengerfront_wheel = ''; passengerfront_wheel = '';
                passengerfront_yellow_tire = ''; passengerfront_red_tire = ''; passengerrear_yellow_tire = ''; passengerrear_red_tire = ''; 
                driverfront_yellow_tire = ''; driverfront_red_tire = ''; driverrear_yellow_tire = ''; driverrear_red_tire = '';
                passengerfront_yellow_brake = ''; passengerfront_red_brake = ''; passengerrear_yellow_brake = ''; passengerrear_red_brake = '';
                driverfront_yellow_brake = ''; driverfront_red_brake = ''; driverrear_yellow_brake = ''; driverrear_red_brake = '';
                getInspectionReportLines();
                //fetchDefaultServiceVeh();
                
                
            }
            
            if(Utility.IsBlank(supId)){
                
                serviceVeh = [SELECT Id, Name, dealer__Vin__c,  dealer__Year__c,  dealer__Make__c,  dealer__Carline__c,  dealer__Trim_Level__c,  
                    dealer__Last_Odometer__c,  dealer__Body_Type__c, dealer__Licence__c, dealer__Licence_State__c, dealer__Sales_Inventory__c,
                    dealer__Veh_Owner__c, dealer__Veh_Owner__r.Phone, dealer__Veh_Owner_Contact__r.Email, dealer__Veh_Owner__r.PersonEmail, 
                    dealer__Body_Type_Picklist__c, dealer__Ext_Color__c,dealer__Transmission_Type__c
                    FROM dealer__Service_Vehicle__c
                    WHERE Id = :appraisal.dealer__Service_Vehicle__c LIMIT 1];
            
                inspection = [Select Id, Name, dealer__Acquisition_Method__c, dealer__Action_Item_Count__c, dealer__Advisor__c, dealer__Agreed_to_ToS__c, 
                    dealer__Alignment__c, dealer__Balance_Recommended__c, dealer__Battery_1_Actual_CCA__c, dealer__Body_Desc__c, dealer__Body_Est__c, 
                    dealer__Body_Type__c, dealer__Brake_DF__c, dealer__Brake_DR__c, dealer__Brake_PF__c, dealer__Brake_PR__c, dealer__Brake_Fluid__c, 
                    dealer__Brake_Lights__c, dealer__Transmission_Fluid__c, dealer__Cylinders__c, dealer__Exterior_Color__c, dealer__Mechanical_Est__c, 
                    Interior_Est__c, Tire_Recon_Est__c, Brake_Recon_Est__c, Internal_Comments__c , dealer__Mechanical_Recon__c  , Body_Glass_Recon__c, Interior_Recon__c, Tires_Recon__c, Brakes_Recon__c
                    FROM Inspection_Report__c WHERE Id =:appraisal.dealer__Inspection_Report__c LIMIT 1];
                
                vinNumber = serviceVeh.dealer__Vin__c;
                inspection = inspection;
            } 
            
        }catch(Exception e){
            //appraisal = new dealer__Appraisal__c();
            serviceVeh = new dealer__Service_Vehicle__c(); 
            inspection = new dealer__Inspection_Report__c();
        }
    }
    
    // Method to fetch the previous Appraisal for the current Service Vehicle
    public List<dealer__Appraisal__c> getPreviousAppraisals(){
        List<dealer__Appraisal__c> appraisals = new List<dealer__Appraisal__c>();
        try{
            if(!Utility.IsBlank(selectedVehicle)){
                appraisals = [SELECT Id, Owner.Name, Name, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, 
                            dealer__Service_Vehicle__r.Veh_Owner__c, dealer__Appraised_By__c, dealer__ACV_Actual_Cash_Value__c,
                            CreatedDate, dealer__Appraised_Value__c, dealer__Expected_Costs__c  
                            FROM dealer__Appraisal__c 
                            WHERE dealer__Service_Vehicle__c =:selectedVehicle AND dealer__Sales_Up__c != :supId];
            
            }
        }catch(Exception e){
            appraisals = new List<dealer__Appraisal__c>();
        }
        return appraisals;
    }
    
    // Method to fetch the Service Vehicle from VIN number
    public void fetchServiceVehFromVIN(){
        if(!Utility.IsBlank(vinNumber)){
            try{
                serviceVehicle = [SELECT Id, Name, dealer__Vin__c,  dealer__Year__c,  dealer__Make__c,  dealer__Carline__c,  dealer__Trim_Level__c,  
                    dealer__Last_Odometer__c,  dealer__Body_Type__c, dealer__Licence__c, dealer__Licence_State__c, dealer__Sales_Inventory__c,
                    dealer__Veh_Owner__c, dealer__Veh_Owner__r.Phone, dealer__Veh_Owner_Contact__r.Email, dealer__Veh_Owner__r.PersonEmail, 
                    dealer__Body_Type_Picklist__c, dealer__Ext_Color__c
                    FROM dealer__Service_Vehicle__c
                    WHERE dealer__Vin__c = :vinNumber LIMIT 1]; 
                //serviceVeh.dealer__Year__c = serviceVehicle.dealer__Year__c;
                serviceVeh = serviceVehicle;
                    
            }catch(Exception e){
                serviceVehicle = new dealer__Service_Vehicle__c();
                serviceVehicle = serviceVeh;
            }
        }
    }
    
    // Method to save the Inspection Report Line
      public PageReference saveInspectionReportLine(){
        
        
        saveInspection();
        inspectionReportLine.dealer__Inspection_Report__c = inspection.Id;
        /*
        inspectionReportLine.dealer__Repair_Estimate__c = (inspectionReportLine.dealer__Repair_Estimate__c == null) ? 0.00 : inspectionReportLine.dealer__Repair_Estimate__c;
        
        if(inspectionReportLine.dealer__Repair_Type__c == 'Body/Glass' || inspectionReportLine.dealer__Repair_Type__c == 'Doors' || inspectionReportLine.dealer__Repair_Type__c == 'Wheels'){
            inspection.Body_Est__c = (inspection.Body_Est__c == null) ? (0.00 + inspectionReportLine.dealer__Repair_Estimate__c) : inspection.Body_Est__c + inspectionReportLine.dealer__Repair_Estimate__c;
        }
        
        if(inspectionReportLine.dealer__Repair_Type__c == 'Tires'){
            inspection.Tire_Recon_Est__c = (inspection.Tire_Recon_Est__c == null) ? ( 0.00 + inspectionReportLine.dealer__Repair_Estimate__c) : inspection.Tire_Recon_Est__c + inspectionReportLine.dealer__Repair_Estimate__c;
        }
        
        if(inspectionReportLine.dealer__Repair_Type__c == 'Brakes'){
            inspection.Brake_Recon_Est__c = (inspection.Brake_Recon_Est__c == null) ? ( 0.00 + inspectionReportLine.dealer__Repair_Estimate__c) : inspection.Brake_Recon_Est__c + inspectionReportLine.dealer__Repair_Estimate__c;
        }
        
        if(inspectionReportLine.dealer__Repair_Type__c == 'Interior'){
            inspection.Interior_Est__c = (inspection.Mechanical_Est__c == null) ? ( 0.00 + inspectionReportLine.dealer__Repair_Estimate__c) : inspection.Interior_Est__c + inspectionReportLine.dealer__Repair_Estimate__c;
        }
        if(inspectionReportLine.dealer__Repair_Type__c == 'Mechanical'){
            inspection.Mechanical_Est__c = (inspection.Mechanical_Est__c == null) ? ( 0.00 + inspectionReportLine.dealer__Repair_Estimate__c) : inspection.Mechanical_Est__c + inspectionReportLine.dealer__Repair_Estimate__c;
        }
        */
        try{
            upsert inspection;
            insert inspectionReportLine;
            System.debug('---inspectionReportLine---'+inspectionReportLine);
        }catch(Exception e){
            System.debug('---inspectionReportLine---'+e.getMessage());
        }
        initLineItem();
        PageReference pageRef = Page.vehicleInspection;
        if(supId != null){
            //Added 
            //selectedVehicle = vid; 
            pageRef.getParameters().put('sid', supId);
            pageRef.getParameters().put('vid', selectedVehicle);
            pageRef.setRedirect(true);
            return pageRef;
        }else{
            return null;
        }
    }
    
    // Method to save the Inspection Report Line on popup
      public PageReference saveInspectionRLPopup(){
        
        System.debug('Coodinate Values are'+xCoord+yCoord);
        saveInspection();
        
        inspectionRLPopup.dealer__Inspection_Report__c = inspection.Id;
        if(xCoord != null && xCoord != 0){
            inspectionRLPopup.dealer__damageCoordinateX__c = xCoord;
        }
        if(yCoord != null && yCoord != 0){
            inspectionRLPopup.dealer__damageCoordinateY__c = yCoord;
        }
        try{
            upsert inspection;
            insert inspectionRLPopup;
        }catch(Exception e){
            System.debug('---inspectionReportLine---'+e.getMessage());
        }
        //Method to clear the data in inspectionReportLine,inspectionRLPopup
        initLineItem();
        PageReference pageRef = Page.vehicleInspection;
        if(supId != null){
            //Added 
            pageRef.getParameters().put('sid', supId);
            pageRef.getParameters().put('vid', selectedVehicle);
            pageRef.setRedirect(true);
            return null;
        }else{
            return null;
        }
    }
    
    // Method to get all the Inspection Report Line From Inspection
    public List<dealer__Inspection_Report_Lines__c> getInspectionReportLines(){
        
        List<dealer__Inspection_Report_Lines__c> inspectionLines = new List<dealer__Inspection_Report_Lines__c>();
        //if(inspection.Id != null){
            inspectionLines = [Select Id, Name, dealer__Repair_Type__c, dealer__Repair_Estimate__c, dealer__Repair_Description__c, dealer__Notes__c, 
                dealer__Inspection_Report__c, dealer__Diagram_Reference_Number__c, dealer__damageCoordinateY__c, dealer__damageCoordinateX__c, dealer__Hidden_Value__c 
                FROM dealer__Inspection_Report_Lines__c
                WHERE dealer__Inspection_Report__c = :inspection.Id];
            System.debug('getInspectionReportLinessssssssss'+inspection.Id);
            System.debug('Coordinate backend values are'+inspectionLines);
            for(dealer__Inspection_Report_Lines__c line :inspectionLines){

                /*
                if(line.dealer__Repair_Type__c == 'Body/Glass'){
                    body = '1';
                }else if(line.dealer__Repair_Type__c == 'Doors'){
                    door = '1';
                }else if(line.dealer__Repair_Type__c == 'Wheels'){
                    wheel = '1';
                }else if(line.dealer__Repair_Type__c == 'Tires'){
                    tire = '1';
                }else if(line.dealer__Repair_Type__c == 'Brakes'){
                    brake = '1';
                }else if(line.dealer__Repair_Type__c == 'Interior'){
                    interior = '1';
                }else if(line.dealer__Repair_Type__c == 'Mechanical'){
                    mechanical = '1';
                }
                */
                if(line.Hidden_Value__c == 'default_body'){
                    body = '1';
                    //xCoord = line.dealer__damageCoordinateX__c;
                    //yCoord = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_driverdoor'){
                    driverdoor = '1';
                    //added to get the driver door coordinates
                    //xCoordDriverDoor = line.dealer__damageCoordinateX__c;
                    //yCoordDriverDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_passengerdoor'){
                    passengerdoor = '1';
                    //added to get the passenger door coordinates
                    //xCoordPassengerDoor = line.dealer__damageCoordinateX__c;
                    //yCoordPassengerDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_driverdoor'){
                    driverdoor = '1';
                    //added to get the driver door coordinates
                    //xCoordDriverDoor = line.dealer__damageCoordinateX__c;
                    //yCoordDriverDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_driverfront-wheel'){
                    driverfront_wheel = '1';
                }else if(line.Hidden_Value__c == 'default_driverrear-wheel'){
                    driverrear_wheel = '1';
                }else if(line.Hidden_Value__c == 'default_passengerfront-wheel'){
                    passengerfront_wheel = '1';
                }else if(line.Hidden_Value__c == 'default_passengerrear-wheel'){
                    passengerrear_wheel = '1';
                }else if(line.Hidden_Value__c == 'passengerfront_yellow_tire'){
                    passengerfront_yellow_tire = '1';
                }else if(line.Hidden_Value__c == 'passengerfront_red_tire'){
                    passengerfront_red_tire = '1';
                }else if(line.Hidden_Value__c == 'passengerrear_yellow_tire'){
                    passengerrear_yellow_tire = '1';
                }else if(line.Hidden_Value__c == 'passengerrear_red_tire'){
                    passengerrear_red_tire = '1';
                }else if(line.Hidden_Value__c == 'driverfront_yellow_tire'){
                    driverfront_yellow_tire = '1';
                }else if(line.Hidden_Value__c == 'driverfront_red_tire'){
                    driverfront_red_tire = '1';
                }else if(line.Hidden_Value__c == 'driverrear_yellow_tire'){
                    driverrear_yellow_tire = '1';
                }else if(line.Hidden_Value__c == 'driverrear_red_tire'){
                    driverrear_red_tire = '1';
                }else if(line.Hidden_Value__c == 'passengerfront_yellow_brake'){
                    passengerfront_yellow_brake = '1';
                }else if(line.Hidden_Value__c == 'passengerfront_red_brake'){
                    passengerfront_red_brake = '1';
                }else if(line.Hidden_Value__c == 'passengerrear_yellow_brake'){
                    passengerrear_yellow_brake = '1';
                }else if(line.Hidden_Value__c == 'passengerrear_red_brake'){
                    passengerrear_red_brake = '1';
                }else if(line.Hidden_Value__c == 'driverfront_yellow_brake'){
                    driverfront_yellow_brake = '1';
                }else if(line.Hidden_Value__c == 'driverfront_red_brake'){
                    driverfront_red_brake = '1';
                }else if(line.Hidden_Value__c == 'driverrear_yellow_brake'){
                    driverrear_yellow_brake = '1';
                }else if(line.Hidden_Value__c == 'driverrear_red_brake'){
                    driverrear_red_brake = '1';
                }
                //Added recently
                else if(line.Hidden_Value__c == 'default_passengerfront-body'){
                    passengerfront_body = '1';
                    //xCoordPassengerFrontDoor = line.dealer__damageCoordinateX__c;
                    //yCoordPassengerFrontDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_passengerrear-body'){
                    passengerrear_body = '1';
                    //xCoordPassengerRearDoor = line.dealer__damageCoordinateX__c;
                    //yCoordPassengerRearDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_driverfront-body'){
                    driverfront_body = '1';
                    //xCoordDriverFrontDoor = line.dealer__damageCoordinateX__c;
                    //yCoordDriverFrontDoor = line.dealer__damageCoordinateY__c;
                }else if(line.Hidden_Value__c == 'default_driverrear-body'){
                    driverrear_body = '1';
                    //xCoordDriverRearDoor = line.dealer__damageCoordinateX__c;
                    //yCoordDriverRearDoor = line.dealer__damageCoordinateY__c;
                }
                
                //returning the coordinate values.
                System.debug('Coordinate values are'+line.dealer__damageCoordinateX__c+line.dealer__damageCoordinateY__c);
                
            }
        //} 
        
        return inspectionLines; 
    }
    
    // Added By KVP Method to fetch invoice Logo for appraisal form (pdf)
    public String getInvoiceLogo() {
         Id recordId = ApexPages.currentPage().getParameters().get('sid');
         Id loc;
         if(recordId != null){
            loc = [SELECT Store_Location__c FROM Sales_Up__c WHERE Id=:recordId].Store_Location__c;
            system.debug('loc '+loc);
         }
       
        if(loc != null){
            return DealershipLocationAPI.formLogoURL(loc);
        }else{
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
    }
    
    // Method to calculate Appraisal value
    public PageReference calcAppraialValue(){
        appraisal.Asking_Price__c = (appraisal.Asking_Price__c == null) ? 0.00 : appraisal.Asking_Price__c;
        appraisal.Profit_Objective__c = (appraisal.Profit_Objective__c == null) ? 0.00 : appraisal.Profit_Objective__c;
        appraisal.Expected_Costs__c = (appraisal.Expected_Costs__c == null) ? 0.00 : appraisal.Expected_Costs__c;
        appraisalValue = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
        
        return null;
    }
    
    // Method to save the Appraisal, Inspection Report, Service Vehicle
    public PageReference saveInspection() {

        try{
            System.debug('-----serviceVeh.dealer__Body_Type_Picklist__c-------'+serviceVeh.dealer__Body_Type_Picklist__c);
            String bodyType = serviceVeh.dealer__Body_Type_Picklist__c; 
            serviceVeh.dealer__Body_Type__c = bodyType;
            serviceVeh.dealer__Vin__c = vinNumber;
            upsert serviceVeh;
            System.debug('--serviceVeh--'+serviceVeh);
            
            
            //inspection = new dealer__Inspection_Report__c();
//            inspection.dealer__Internal_Comments__c = (supId != null) ? sup.dealer__Trade_Comments__c : '';
            inspection.RecordTypeId = appraisalTypeId;
            inspection.dealer__Sales_Up__c = (supId != null) ? supId : null;
            //inspection.dealer__Service_Vehicle__c = serviceVeh.Id;
            inspection.dealer__Service_Vehicle__c = selectedVehicle;
            upsert inspection;
            System.debug('--inspection--'+inspection);
            
            appraisal.dealer__Sales_Up__c = (supId != null) ? supId : null;
            appraisal.dealer__Service_Vehicle__c = serviceVeh.Id;
            appraisal.dealer__Inspection_Report__c = inspection.Id; 
            appraisal.dealer__Appraised_By__c = userInfo.getUserId();
            appraisal.dealer__ACV_Actual_Cash_Value__c = appraisal.Asking_Price__c;
            if(appraisal.dealer__Appraisal_Date__c == null){
                appraisal.dealer__Appraisal_Date__c = System.today();
            }
            decimal mechEst = (inspection.Mechanical_Recon__c == null) ? 0.00 : inspection.Mechanical_Recon__c;
            decimal bodyEst = (inspection.Body_Glass_Recon__c == null) ? 0.00 : inspection.Body_Glass_Recon__c;
            decimal intEst =  (inspection.Interior_Recon__c == null) ? 0.00 : inspection.Interior_Recon__c;
            decimal tireEst = (inspection.Tires_Recon__c == null) ? 0.00 : inspection.Tires_Recon__c;
            decimal brakeEst = (inspection.Brakes_Recon__c == null) ? 0.00 : inspection.Brakes_Recon__c;
            
            appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c + 
                                        mechEst + bodyEst + intEst + tireEst + brakeEst;
            appraisal.dealer__Appraised_Value_SYS__c = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            if(appraisalValue == null || appraisalValue == 0.00 || appraisalValue == 0){
                appraisalValue = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            }
            appraisal.Appraised_Value__c = appraisalValue;
            appraisalValue = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            appraisal.dealer__Appraised_Value_Changed__c = (appraisalValue != appraisal.dealer__Appraised_Value_SYS__c) ? true : false;
            System.debug('--appraisal1--'+appraisal);
            upsert appraisal;
            System.debug('--appraisal2--'+appraisal);
            if(Utility.IsBlank(supId)){
                
                appraisalVehicle.dealer__Sales_Up__c = supId;
                appraisalVehicle.dealer__Service_Vehicle__c = serviceVeh.Id;
                System.debug('--appraisalVeh--'+appraisalVehicle);
                upsert appraisalVehicle;
            }
            appraisalVehicle = [Select Id, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, dealer__Appraisal__c
                FROM dealer__Appraisal_Vehicle__c 
                WHERE dealer__Sales_Up__c =:supId AND dealer__Sales_Up__c != null AND dealer__Service_Vehicle__c != null AND dealer__Service_Vehicle__c = :selectedVehicle];
            appraisalVehicle.dealer__Appraisal__c = appraisal.Id;
            System.debug('--appraisalVeh--'+appraisalVehicle);
            upsert appraisalVehicle;
            if(appraisal.Lost_Appraisal__c == true){
                delete inspection;
                delete appraisal;
            }
        }catch(Exception e){                            
            System.debug('ERROR MESSAGE:'+e.getMessage());
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter Year, Make, Model!');
            ApexPages.addMessage(errMsg);
            return null;
        }
        
        PageReference pageRef = Page.vehicleInspection;
        if(supId != null){
            pageRef.getParameters().put('sid', supId);
            pageRef.getParameters().put('vid', selectedVehicle);
            
            pageRef.setRedirect(true);
            return pageRef;
        }else{
            return null;
        }
        
        /*
        PageReference appraisalPage = new ApexPages.StandardController(appraisal).view();
        appraisalPage.setRedirect(true);
        return appraisalPage;
        */
    }
    
    // Method to save the Appraisal, Inspection Report, Service Vehicle
    public PageReference saveAndCloseInspection() {
        saveInspection();
        /*
        try{
            System.debug('--serviceVeh--'+serviceVeh);
            String bodyType = serviceVeh.dealer__Body_Type_Picklist__c; 
            serviceVeh.dealer__Body_Type__c = bodyType;
            serviceVeh.dealer__Vin__c = vinNumber;
            upsert serviceVeh;
            
            //inspection = new dealer__Inspection_Report__c();
            inspection.dealer__Internal_Comments__c = (supId != null) ? sup.dealer__Trade_Comments__c : '';
            inspection.RecordTypeId = appraisalTypeId;
            inspection.dealer__Sales_Up__c = (supId != null) ? supId : null;
            inspection.dealer__Service_Vehicle__c = serviceVeh.Id;
            System.debug('--inspection--'+inspection.Transmission_Fluid__c);
            upsert inspection;

            appraisal.dealer__Sales_Up__c = (supId != null) ? supId : null;
            appraisal.dealer__Service_Vehicle__c = serviceVeh.Id;
            appraisal.dealer__Inspection_Report__c = inspection.Id; 
            appraisal.dealer__Appraised_By__c = userInfo.getUserId();
            
            decimal mechEst = inspection.Mechanical_Est__c = (inspection.Mechanical_Est__c == null) ? 0.00 : inspection.Mechanical_Est__c;
            decimal bodyEst = inspection.Body_Est__c = (inspection.Body_Est__c == null) ? 0.00 : inspection.Body_Est__c;
            decimal intEst = inspection.Interior_Est__c = (inspection.Interior_Est__c == null) ? 0.00 : inspection.Interior_Est__c;
            decimal tireEst = inspection.Tire_Recon_Est__c = (inspection.Tire_Recon_Est__c == null) ? 0.00 : inspection.Tire_Recon_Est__c;
            decimal brakeEst = inspection.Brake_Recon_Est__c = (inspection.Brake_Recon_Est__c == null) ? 0.00 : inspection.Brake_Recon_Est__c;
             
            appraisal.Expected_Costs__c = appraisal.Transportation__c + appraisal.Certification__c + appraisal.Auction_Fee__c + 
                                            mechEst + bodyEst + intEst + tireEst + brakeEst;
            appraisal.dealer__Appraised_Value_SYS__c = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            if(appraisalValue == null || appraisalValue == 0.00 || appraisalValue == 0){
                appraisalValue = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            }
            appraisal.Appraised_Value__c = appraisalValue;
            appraisalValue = appraisal.Asking_Price__c - (appraisal.Profit_Objective__c + appraisal.Expected_Costs__c);
            appraisal.dealer__Appraised_Value_Changed__c = (appraisalValue != appraisal.dealer__Appraised_Value_SYS__c) ? true : false;
            upsert appraisal;
            System.debug('--appraisal--'+appraisal);
            if(Utility.IsBlank(supId)){
                
                appraisalVehicle.dealer__Sales_Up__c = supId;
                appraisalVehicle.dealer__Service_Vehicle__c = serviceVeh.Id;
                System.debug('--appraisalVeh--'+appraisalVehicle);
                upsert appraisalVehicle;
            }
            appraisalVehicle.dealer__Appraisal__c = appraisal.Id;
            System.debug('--appraisalVeh--'+appraisalVehicle);
            upsert appraisalVehicle;
            if(appraisal.Lost_Appraisal__c == true){
                delete inspection;
                delete appraisal;
            }
        }catch(Exception e){                            
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter Year, Make, Model!');
            ApexPages.addMessage(errMsg);
        }
        */
        PageReference pageRef;
        if(supId != null){
            pageRef = new PageReference('/'+supId);
            return pageRef;
        }else{
            Schema.DescribeSObjectResult result = dealer__Appraisal__c.sObjectType.getDescribe();
            pageRef = new PageReference('/' + result.getKeyPrefix() + '/o');
            return pageRef;
        }
    }
    
    // Method to get the image name
    public void fetchImageName() {
        imageName = serviceVeh.Body_Type_Picklist__c;
        if(imageName == 'Station Wagon'){
            imageName = 'Station_Wagon'+'.jpg';
            imageStyleClass = 'mainStationWagon';
        }else{
            imageName = imageName+'.jpg';
        }
        if(imageName == 'Sedan.jpg'){
            imageStyleClass = 'mainSedan';
        }
        if(imageName == 'SUV.jpg'){
            imageStyleClass = 'mainSUV';
        }
        if(imageName == 'PickUp.jpg'){
            imageStyleClass = 'mainPickUp';
        }
        if(imageName == 'Van.jpg'){
            imageStyleClass = 'mainVan';
        }
        if(imageName == 'hatchback.jpg'){
            imageStyleClass = 'mainHatchBack';
        }
        System.debug('--imageName--'+imageName);
    }
    
    public PageReference stockInServiceVehicle() {

        dealer__Vehicle_Inventory__c invVeh = new dealer__Vehicle_Inventory__c();
        String invVehId ='';

        if (serviceVeh != null) {

            invVeh.dealer__Vin__c = serviceVeh.dealer__Vin__c;
            invVeh.dealer__Year__c = serviceVeh.dealer__Year__c;
            invVeh.dealer__Make__c = serviceVeh.dealer__Make__c;
            invVeh.dealer__Model__c = serviceVeh.dealer__Carline__c;
            invVeh.dealer__Trim_Level__c = serviceVeh.dealer__Trim_Level__c;
            invVeh.dealer__Mileage__c = serviceVeh.dealer__Last_Odometer__c;
            invVeh.dealer__Body_Type__c = serviceVeh.dealer__Body_Type__c;
            invVeh.dealer__License__c = serviceVeh.dealer__Licence__c;
            //invVeh.dealer__Licence_State__c = serviceVeh.dealer__Licence_State__c;

            invVeh.dealer__Stock_Number__c = stockNumber;
            invVeh.dealer__Invoice_Reference__c = invoiceRef;
            invVeh.dealer__Purchase_Price__c = purchaseAmt;

            invVeh.dealer__Purchase_Date__c = date.today();
            invVeh.dealer__Inventory_Date__c = date.today();

            insert invVeh;
            // Once vehicle is in inventory, update the service vehicle
            serviceVeh.dealer__Sales_Inventory__c = invVeh.Id;

            update serviceVeh;

            System.debug(serviceVeh);
            PageReference invPage = new PageReference('/'+invVeh.Id);
            return invPage;
        }  else {
            return null;
        }
    }
    
    public PageReference stockInServiceVehicles() {

        dealer__Vehicle_Inventory__c invVeh = new dealer__Vehicle_Inventory__c();
        String invVehId ='';

        if (serviceVeh != null) {

            invVeh.dealer__Vin__c = serviceVeh.dealer__Vin__c;
            invVeh.dealer__Year__c = serviceVeh.dealer__Year__c;
            invVeh.dealer__Make__c = serviceVeh.dealer__Make__c;
            invVeh.dealer__Model__c = serviceVeh.dealer__Carline__c;
            invVeh.dealer__Trim_Level__c = serviceVeh.dealer__Trim_Level__c;
            invVeh.dealer__Mileage__c = serviceVeh.dealer__Last_Odometer__c;
            invVeh.dealer__Body_Type__c = serviceVeh.dealer__Body_Type__c;
            invVeh.dealer__License__c = serviceVeh.dealer__Licence__c;
            //invVeh.dealer__Licence_State__c = serviceVeh.dealer__Licence_State__c;

            invVeh.dealer__Stock_Number__c = stockNumber;
            invVeh.dealer__Invoice_Reference__c = invoiceRef;
            invVeh.dealer__Purchase_Price__c = purchaseAmt;

            invVeh.dealer__Purchase_Date__c = date.today();
            invVeh.dealer__Inventory_Date__c = date.today();

            insert invVeh;
            // Once vehicle is in inventory, update the service vehicle
            serviceVeh.dealer__Sales_Inventory__c = invVeh.Id;

            update serviceVeh;

            System.debug(serviceVeh);
            
            
            //**************************************************************
            
            Id pOrderRecordTypeId = Schema.SObjectType.dealer__Purchase_Order__c.getRecordTypeInfosByName().get('Vehicle Purchase').getRecordTypeId();
            pOrder.dealer__VIN__c = serviceVeh.dealer__Vin__c;
            pOrder.dealer__Year__c = serviceVeh.dealer__Year__c;
            pOrder.dealer__Make__c = serviceVeh.dealer__Make__c;
            pOrder.dealer__Model__c = serviceVeh.dealer__Carline__c;
            pOrder.dealer__VIN__c = serviceVeh.dealer__Vin__c;
            pOrder.RecordTypeId = pOrderRecordTypeId;
            try{
                insert pOrder;
            }catch(Exception e){
                
            }
            
            PageReference pageRef = Page.PurchaseOrder;
            pageRef.getParameters().put('id', pOrder.Id);
            //PageReference invPage = new PageReference('/apex/dealer.PurchaseOrder/?id='+pOrder.Id);
            return pageRef;
            //**************************************************************
            
            //PageReference invPage = new PageReference('/'+invVeh.Id);
            //return invPage;
        }  else {
            return null;
        }
    }
    
    public PageReference createPurchaseOrder() {
        Id pOrderRecordTypeId = Schema.SObjectType.dealer__Purchase_Order__c.getRecordTypeInfosByName().get('Vehicle Purchase').getRecordTypeId();
        pOrder.dealer__VIN__c = serviceVeh.dealer__Vin__c;
        pOrder.dealer__Year__c = serviceVeh.dealer__Year__c;
        pOrder.dealer__Make__c = serviceVeh.dealer__Make__c;
        pOrder.dealer__Model__c = serviceVeh.dealer__Carline__c;
        pOrder.dealer__VIN__c = serviceVeh.dealer__Vin__c;
        pOrder.RecordTypeId = pOrderRecordTypeId;
        try{
            insert pOrder;
        }catch(Exception e){
            
        }
        
        PageReference pageRef = Page.PurchaseOrder;
        pageRef.getParameters().put('id', pOrder.Id);
        //PageReference invPage = new PageReference('/apex/dealer.PurchaseOrder/?id='+pOrder.Id);
        return pageRef;
        
    }
    public PageReference deleteLineItem(){
    //public void deleteLineItem(){
      
        try{
           // upsert inspection;
           System.debug('DELETE IDDDDDDDDDDDDDDDDDDDDD'+recId);
             //Added 
             //String vid = ApexPages.currentPage().getParameters().get('vid');
             //selectedVehicle = vid;
            delete [Select Id FROM dealer__Inspection_Report_Lines__c WHERE id =:ApexPages.currentPage().getParameters().get('recId')];
            //System.debug('---inspectionReportLine---'+inspectionReportLine);
            //getInspectionReportLines();
        }catch(Exception e){
            System.debug('---inspectionReportLine---'+e.getMessage());
        }
        
        PageReference pageRef = Page.vehicleInspection;
        //if(supId != null){
            pageRef.getParameters().put('sid', supId);
            pageRef.getParameters().put('vid', selectedVehicle);
            pageRef.setRedirect(true);
            return pageRef;
        //}else{
          //  return null;
        //}
    }
    
    public void editLineItem(){
        System.debug('test1111111111111111111111111111111'+recEditIds);
        inspectionRL = [SELECT id, Repair_Type__c, Repair_Description__c, Tread_Depth__c, Brake_Wear__c, Notes__c, Repair_Estimate__c FROM  dealer__Inspection_Report_Lines__c WHERE id =:ApexPages.currentPage().getParameters().get('recEditId')];
        System.debug('TESTTTTTTTTTTTTTTTTTTTT'+ApexPages.currentPage().getParameters().get('recEditId'));
    }
    
    public void updateIRL(){
    update inspectionRL ;
        //System.debug('updateeeeeeeeeeeee'+ApexPages.currentPage().getParameters().get('recEditId'));
    } 
    
    public void updateInspectionReportLine(){
        update inspectionRL ;
    }
    
    // Method to delete inspection 
    
    // Setup Vin Decoder remote Action.
    @RemoteAction
        public static Map<String,Object> decodedVin(String vin){

            List<String> trims = new List<String>();
            Map<String,Object> v = new Map<String,Object>();

            v.put('dealer__VIN__c', vin );

            if( String.valueOf( v.get('dealer__VIN__c') ).length()==17 ) {
                VINDecoder vd = new VINDecoder();
                
                vd.DecodeVIN( String.valueOf( v.get('dealer__VIN__c') ) );
                VINDecoder_DataOneSoftware.DecodeResponseStruct ddat = vd.decode;

                System.debug( ddat.query_responses.unique_request.common_data.basic_data );

                v.put('dealer__Year__c', string.valueOf( ddat.query_responses.unique_request.common_data.basic_data.year ) );
                v.put('dealer__Make__c', string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.make) );
                v.put('dealer__Carline__c', string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.model) );
                /******************* start KVP******************/
                //Checking if service vehicle body type values exist in the body type Picklist values
                set<String> bodyTypePicklistValues =  new set<String>();
                Schema.DescribeFieldResult fieldResult = dealer__Service_Vehicle__c.dealer__Body_Type_Picklist__c.getDescribe();
                   for( Schema.PicklistEntry f : fieldResult.getPicklistValues()){
                      bodyTypePicklistValues.add(f.getValue());
                   }
                string VinBodyType = string.valueOf(ddat.query_responses.unique_request.common_data.basic_data.body_type); 
                String vehBodyType = (!bodyTypePicklistValues.isEmpty() && bodyTypePicklistValues.contains(VinBodyType)) ? VinBodyType : 'Sedan' ; 

                v.put('dealer__Body_Type_Picklist__c', vehBodyType );
                /******************* end KVP******************/
                System.debug( vd.modelKeys.size() );

                for(VINDecoder_DataOneSoftware.StyleData sd : vd.modelKeys) {
                    trims.add(sd.basic_data.trim);
                }
                v.put('dealer__Trim_Level__c', trims );

            }

            return v;
        }

}