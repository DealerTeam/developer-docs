global class TestClassUtil 
{   
    /************** inserting record into standard opcode object ****************/
    global String insertStdOpcode(){
        dealer__StandardOpCode__c oc = new dealer__StandardOpCode__c();
        oc.Name = '99PROD';
        oc.dealer__Pay_Type__c = 'C';
        oc.dealer__Company_Number__c = 'Test Opcode';
        insert oc;
        return oc.Id; 
    } 
    
    /************** Inserting record into service job object ********************/
    global String insertServiceJob(){
        dealer__Service_Job__c  sj = new dealer__Service_Job__c ();
        sj.dealer__Service_Repair_Order__c = insertServiceRepairOrder();
        sj.dealer__Stat__c = 'Open';
        sj.dealer__Standard_Operation_Code__c = insertStdOpcode();
        sj.dealer__Parts_Cost__c = 100;
        sj.dealer__Op_Code__c = 'Test opcode';
        sj.dealer__Line_Number__c = 100;
        sj.dealer__Labor_Type__c = 'C';
        sj.dealer__Labor_Rate__c = 'Test Rate';
        sj.dealer__Labor_Charges__c = 100;
        sj.dealer__Job_Start__c = System.Now();
        sj.dealer__Job_Finish__c = System.Now ()+ 10; 
        sj.dealer__Estimate__c = 100;
        sj.dealer__Correction__c = 'Test long text correction';
        sj.dealer__CustomerConcern__c = 'Test long text customer concern';
        sj.dealer__Cause__c = 'Test cause';
        sj.dealer__Book_Time__c = 3;
        sj.dealer__Actual_Time__c = 123;
        sj.Name = 'Test Name';
        sj.dealer__Parts_Total__c = 100;
        
        insert sj;
        return sj.Id;
        
    }
    
    /************* Inserting record into form object **********************/
    global String insertForm(){
        dealer__Form__c  form = new dealer__Form__c ();
        form.dealer__Active__c = True;
        form.dealer__Form_ID__c = '75';
        form.dealer__FPDF_File_Name__c = 'Test Form Name';
        form.dealer__Impact_Code__c = 'This is a test Impact Code';
        form.dealer__Library__c = True;
        form.dealer__Page_Name__c = 'This is a test page name';
        form.dealer__Print_Type__c = 'Laser';
        //form.dealer__Proofed_by__c
        form.dealer__Revision_Date__c = System.Today();
        form.dealer__Sequence__c= 123321;
        insert form;
        return form.Id;
    }
    
    /************ Inserting record into parts kit object **************/
    global String insertPartsKit(){
        dealer__Parts_Kit__c pk = new dealer__Parts_Kit__c();
        pk.Name = 'Test part kit';
        pk.dealer__Description__c = 'This is a test pk description';
        insert pk;
        return pk.id;
    }
    
    /************ Inserting record into We Owe object ***************/
    global String insertWeOwe(){
        dealer__We_Owe__c weOwe = new dealer__We_Owe__c();
        weOwe.dealer__Code__c = 'TEST';
        weOwe.dealer__Cost__c = 100;
        weOwe.dealer__Description__c = 'Floor Mats';
        weOwe.dealer__RetailPrice__c = 125;
        weOwe.dealer__Parts_Department_Reviewed__c = true;
        weOwe.dealer__Car_Deal__c = insertCarDeal();
        weOwe.dealer__Service_Repair_Order__c = insertServiceRepairOrder();
        insert weOwe; 
        return weOwe.Id;
    }
    
    /*********** Inserting record into We Owe Lines Object **************/
    global String insertWeOweLines(){
        dealer__We_Owe_Line__c wwLines = new dealer__We_Owe_Line__c();
        wwLines.dealer__After_Market_Id__c = '25';
        wwLines.dealer__Cost__c = 500;
        wwLines.dealer__Description__c = 'This is a test description';
        wwLines.dealer__Labor_Hours__c = 5;
        wwLines.dealer__Labor_Sale__c = 10;
        wwLines.dealer__List_Price__c = 190;
        wwLines.dealer__Parts_Sale__c = 20;
        wwLines.dealer__Sale_Price__c = 120;
        wwLines.dealer__We_Owe__c = insertWeOwe();
        wwLines.dealer__Taxable__c = TRUE;
        wwLines.dealer__Parts_Kit__c = insertPartsKit();
        insert wwLines;
        return wwLines.Id;
    }
    
    /*********** Insert Account **************/
    global String insertAccount()
    {
        Account accRec = new Account();
        accRec.Name = TestClassUtil.generateRandomString(6)+' Corp';
        accRec.Type = 'Customer - Direct';
        
        insert accRec;
        return accRec.id;
    }
    
    /********** Insert Contact **************/
    global String insertContact()
    {
        Contact conRec = new Contact();
        conRec.AccountId = insertAccount();
        conRec.LastName = TestClassUtil.generateRandomString(8);
        conRec.FirstName = 'testFirstName';
        conRec.Email = TestClassUtil.generateRandomString(5)+'@example.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        
        insert conRec;
        return conRec.id;
    
    }

    global static Id createLocation() {
        dealer__Dealer_Location__c loc = new dealer__Dealer_Location__c();
        loc.Name = TestClassUtil.generateRandomString(8);
        loc.dealer__Company_Number__c = TestClassUtil.generateRandomString(3);
        loc.dealer__City__c = 'Redding';
        loc.dealer__State__c= 'CA';
        loc.dealer__Postal_Code__c='96001';
        insert loc; 
        return loc.Id;
    }
    global static dealer__Dealer_Location__c insertDealerLocation(String companyNumber, String companyName) {
        dealer__Dealer_Location__c loc = new dealer__Dealer_Location__c();
        loc.Name = companyName;
        loc.dealer__Company_Number__c = companyNumber;
        loc.dealer__City__c = 'Redding';
        loc.dealer__State__c= 'CA';
        loc.dealer__Postal_Code__c='96001';
        
        // Insert InvoiceLogo if does not exist.
        Document doc = new Document();
        doc.Name = 'InvoiceLogo';
        doc.DeveloperName = 'InvoiceLogo';
        if([Select Id from Document Where DeveloperName = 'InvoiceLogo'].size() == 0){
            doc.FolderId = userinfo.getUserId();
            insert doc;
        }
        loc.Logo_Name__c='InvoiceLogo';
        
        // Check to see if there is an existing location
		Dealer_Location__c[] matchedLocations = [SELECT Id, Name, Company_Number__c, City__c, State__c, Postal_Code__c FROM Dealer_Location__c WHERE Company_Number__c =:companyNumber OR Name=:companyName LIMIT 1];
        if(matchedLocations.size()==1) {
            return matchedLocations[0];
        }
        
        insert loc; 
        return loc;       
    }
    
    /********** Insert dealer__Parts_Invoice__c ***********/
    
    global String insertPartsInvoice()
    { 
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
        pi.dealer__Customer__c = insertAccount();
        pi.Location__c = insertDealerLocation('111','testCompany').Id;
        pi.dealer__Customer_Contact__c = insertContact();
        pi.Name = 'Test Invoice';
        pi.dealer__Comapny_Number__c = 'Location 1';
        pi.dealer__Deposit__c = 100;
        pi.dealer__Invoice_Number__c = 'inv1234';
        
        insert pi;
        return pi.id;
    
    }

    /******** Parts Master and Part Entry **********/
    global static dealer__Parts_Master__c insertPartsMaster() {
        
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'Oil Filter';
        pm.dealer__Retail_Price__c = 99.99;
        pm.dealer__Cost__c = 9.99;
        pm.Manufacturer__c = 'FD';
        insert pm;

        return pm;

    }   

    global static dealer__Parts_Inventory__c insertPartInventory(Id master, Id location) {

        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 1;
        part.dealer__Part_No__c = 'FL1A';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = master;
        part.dealer__Location__c = location;

        insert part; 

        return part;        
    } 

    /******** Purchase Orders *****************/
    global static dealer__Purchase_Order__c insertPartsPO(Id invnetoryId) {

        // Create Vendor Account
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;        

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;        

        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = invnetoryId;
        poline.dealer__Part_Quantity__c = 9;
        
        poline.dealer__Amount__c = 45;
        insert poline;

        return po;        
    }
    
    /******** Insert dealer__Service_Repair_Order__c *************/
    
    global String insertServiceRepairOrder()
    {
        dealer__Service_Repair_Order__c spo = new dealer__Service_Repair_Order__c();
        
        spo.dealer__Customer__c = insertAccount();
        spo.dealer__Deposit__c = 100;
        spo.dealer__Customer_Contact__c = insertContact();
        spo.Name = 'Test Service Repair Order';
        spo.dealer__Customer_Charges__c = 50;
        spo.dealer__Company_Number__c = 'Location 1';
        spo.dealer__Tax__c = 30;
        spo.dealer__Shop_Supplies__c = 20;
        spo.dealer__RO_Number__c = 'RO100';
        spo.dealer__Mileage_In__c = 10;
        spo.dealer__Mileage_Out__c = 5;
        
        insert spo;
        return spo.id;
    }
    
    /************* Insert dealer__Service_Vehicle__c ***********/
    String serviceVehicleId = '';
    global String insertServiceVehicle()
    {
        dealer__Service_Vehicle__c SV = new dealer__Service_Vehicle__c();
        SV.dealer__Year__c = '2014';
        SV.dealer__Veh_Owner_Contact__c = insertContact();
        SV.dealer__VIN__c = 'B54998';
        SV.dealer__Stock_Number__c = '1234';
        SV.dealer__Make__c = 'Test';
        SV.dealer__Licence__c = 'Test';
        SV.dealer__Last_Service__c = System.today();
        SV.dealer__Carline__c = '2014';
        SV.dealer__Last_6__c = 'B54998';
        
        insert SV;
        serviceVehicleId = SV.id;
        return SV.id;
    }
    
    /********* Insert dealer__Inspection_Report__c *************/
    global String insertInspectionReport()
    {
        return null;
    }
    /********* Insert dealer__Service_Appointment__c ***********/
    
    global String insertServiceAppointment()
    {
        dealer__Service_Appointment__c SA = new dealer__Service_Appointment__c();
        SA.Name = 'Test Appointment';
        SA.dealer__Date_Time__c = System.now();
        SA.dealer__External_Id__c = '12345';
        SA.dealer__Vehicle__c = insertServiceVehicle();
        SA.dealer__Mileage__c = 100;
        
        insert SA;
        return SA.id;  
    }
    
    //********** Custom Settings dealer__DMS_Settings__c ***********/
    global void insertDMSSettings()
    {
        DMS_Settings__c dms = new DMS_Settings__c();
        dms.Name = 'ActiveSettings';
        dms.Service_Current_Invoice_Number__c = 30093;
        dms.Service_Job_Line_Number__c = 8;
        //dms.State_Tax_Rate__c = 7.75;
        dms.Parts_Current_Invoice_Number__c = 50115;
        dms.Parts_Current_Quote_Number__c = 20028;
        dms.Default_Tax_Rate__c = 7.75;
        dms.Service_Appointment_Sequence_Number__c=2000;
        dms.Deal_Status_Controls_Sales_Up_Status__c = true;
        dms.Deal_Number__c = 1000;
        dms.In_Stock_Default_Status__c = 'Untouched';
        dms.Assign_Stock_Number_by_Sequence__c = true;
        dms.Deal_status_for_inventory__c='Sold';

        insert dms;

        // Add default application logo
        if([Select Id from Document Where DeveloperName = 'InvoiceLogo'].size() == 0) {
            Document doc = new Document();
            doc.Name = 'InvoiceLogo';
            doc.DeveloperName = 'InvoiceLogo';
            doc.FolderId = userinfo.getUserId();
            doc.Body = Blob.valueOf('DT Logo');
            insert doc;                
        }
    }

    global void insertVINDecoderSetup() {

        dealer__VINDecoderCS__c instance = new dealer__VINDecoderCS__c(Name='ActiveSettings',
                                               dealer__DecoderName__c='Data One Software',
                                               dealer__DecoderClientID__c='6310',
                                               dealer__DecoderAPI_URL__c='https://api.dataonesoftware.com/webservices/vindecoder/decode',
                                               dealer__DecoderKey__c='xxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                                                dealer__Active__c=true
                                             );
       insert instance;  
    }

    global void insertCRMSettings() {

        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        if(crm==new dealer__CRMSettings__c()) {
            crm =  new dealer__CRMSettings__c(
                            setupOwnerId = System.UserInfo.getOrganizationId()
                        );
            crm.dealer__UrbanScience_Active__c = true;
            insert crm;
        }

    }
    
    global void insertCDMSettings() {
        dealer__CDM_Settings__c objCDM = new dealer__CDM_Settings__c();
        objCDM.name = 'DT1';
        objCDM.dealer__Company_Number__c ='DT1';
        objCDM.dealer__DealerID__c = 100001;
        objCDM.dealer__Password__c = 'CDMPass';
        objCDM.dealer__Username__c = 'CDMUser';
        insert objCDM;

    }

    /********** Insert Vehicle Inventory *************/
    global String insertVehicleInventory()
    {
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = 'Civic';
        VI.dealer__Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
        VI.dealer__VIN__c = dealer.TestClassUtil.generateRandomString(17);
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = 'Honda';
        VI.dealer__In_Stock__c = true;
        
        insert VI;
        return VI.id;
    }

    /********** Rentals *************/
    global String insertRentalRate()
    {
        dealer__Rental_Rates__c rate = new dealer__Rental_Rates__c(
            dealer__Active__c = true, 
            dealer__Daily_Rate__c = 1000.0,
            dealer__Rate_Description__c = 'Test Rate'
        );
        insert rate;  
        return rate.Id;
    }
    
    /************ Insert SalesUp ****************/
    
    global String insertSalesup()
    {
        dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
                    
        SU.Name = 'Test SalesUP';
        SU.dealer__Buyer_Contact__c = insertContact();
        //SU.dealer__Co_Buyer_Contact__c = insertContact();
        SU.dealer__Desired_Stock_Num__c = insertVehicleInventory();
        SU.dealer__Make__c = 'Telsa';
        SU.dealer__FirstName__c = 'TestFirstName';
        SU.dealer__LastName__c = 'LastName';
        insert SU;
        return SU.id;
        
    }
    
    global String insertCarDeal()
    {
        dealer__Deal__c Deal = new dealer__Deal__c();
        Deal.dealer__Broker__c = insertAccount();
        Deal.dealer__Buyer_Contact__c = insertContact();
        Deal.dealer__Buyer__c = insertAccount();
        Deal.dealer__Co_Buyer_Contact__c = insertContact();
        Deal.dealer__Co_Buyer__c = insertAccount();
        Deal.dealer__Deal_ID__c = '12345';
        Deal.dealer__Licence__c = '100';
        Deal.dealer__Vehicle__c = insertVehicleInventory();
        Deal.Name = '12342';
        
        insert Deal;
        
        return Deal.id;
    }
    
    global dealer__Deal__c insertCarDealWithLocation()
    {
        dealer__Deal__c deal = new dealer__Deal__c();
        deal.dealer__Broker__c = insertAccount();
        deal.dealer__Buyer_Contact__c = insertContact();
        deal.dealer__Buyer__c = insertAccount();
        deal.dealer__Co_Buyer_Contact__c = insertContact();
        deal.dealer__Co_Buyer__c = insertAccount();
        deal.dealer__Deal_ID__c = '12345';
        deal.dealer__Licence__c = '100';
        deal.dealer__Vehicle__c = insertVehicleInventory();
        deal.dealer__Store_Location__c = createLocation();
        deal.Name = '12342';
        
        insert deal;
        
        return deal;
    }
    

    global static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }    
}