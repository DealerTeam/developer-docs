// tested by TestInstallScript 
global class InstallScriptOrgAPI{

    global static void createDmsSetting()
    {

        DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');
        System.debug(dms);

        if(dms != null && dms.Name == 'ActiveSettings') {
            return;
        }

        DMSSettings controller = new DMSSettings();
        controller.barnumber='ADP-12345';
        controller.epanumber='EPA-12345';
        controller.defaultTaxRate=Decimal.valueOf('9.99');
        controller.internalLaborRate=Decimal.valueOf('100.12');
        controller.warrantyLaborRate=Decimal.valueOf('115.99');
        controller.laborRate=Decimal.valueOf('125.05');
        controller.partsInvoiceNumber=Decimal.valueOf('4000');
        controller.partsQuoteNumber=Decimal.valueOf('5000');
        controller.serviceInvoiceNumber=Decimal.valueOf('6000');
        controller.printEstimate=false;
        controller.printTechTimes=false;
        controller.serviceTaxIfPartsSoldOnly=true;
        controller.serviceTaxLabor=true;
        controller.dmsIntegrationMode=false;
        controller.serviceLineTotalTrigger=true;
        controller.cashierAutoClose=true;
        controller.leadsAutoAssignManager=true;
        controller.closedDealStatusCodes='A,U';
        controller.dealNumber=1000;
        controller.assignStockNumber = false;
        controller.assignStockNumberBySequence = false;
        controller.assignStockNumberByDate = false;
        controller.serviceAppointmentNumber = 2000;
        controller.dealControlsSalesUp=false;
        controller.linkedEvent=false;
        controller.save();
    }
    
    global static void createVdcSetting()
    {
        SecureVDCSettings vdcs = new SecureVDCSettings();
        vdcs.decoderName         = 'Data One Software';
        vdcs.decoderKey          = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
        vdcs.apiURL              = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
        vdcs.clientID            = '6310';
        vdcs.active              = true;
        vdcs.useBigObjectStorage = true;
        vdcs.saveVDCSettings();
    }    

    global static void updateVDCActiveFlag() 
    {
        VINDecoderCS__c instance = VINDecoderCS__c.getValues('ActiveSettings');
        if(instance != null) {
            instance.dealer__Active__c = true;
            try {
                update instance;
            } Catch(Exception e) {
                throw new InstallScript.InstallException(e.getMessage());
            }
        }
    }
    
    global static void createCrmSetting()
    {
        //The creation of a new CRMSettings record sets both the dealer__Native_or_Non_Native_Dupe_Catching__c and the Duplicate_Check_Statuses__c fields
        CRMSettings crm = new CRMSettings();
        crm.Save();
    }
    
    global static void setupPaymentMethods() 
    {
        // Insert Payment Method custom settings
        List<dealer__Payment_Methods__c> paymentMethodsForCashiering = [Select Id from dealer__Payment_Methods__c limit 1];

        if(paymentMethodsForCashiering.isEmpty()) {

            paymentMethodsForCashiering.add(new dealer__Payment_Methods__c(
                        dealer__Method__c='On Account',
                        dealer__Type__c='On Account',
                        Name='ActiveOnAccount'   
                    )
            );
            paymentMethodsForCashiering.add(new dealer__Payment_Methods__c(
                        dealer__Method__c='Cash',
                        dealer__Type__c='Cash',
                        Name='ActiveCash'   
                    )
            );
            paymentMethodsForCashiering.add(new dealer__Payment_Methods__c(
                        dealer__Method__c='Check',
                        dealer__Type__c='Check',
                        Name='ActiveCheck'   
                    )
            );
            paymentMethodsForCashiering.add(new dealer__Payment_Methods__c(
                        dealer__Method__c='Credit Card',
                        dealer__Type__c='Credit Card',
                        Name='ActiveCreditCard'   
                    )
            );
            insert paymentMethodsForCashiering;
        }
    } 
    
    global static void onUpgradeSettingUpdate()
    {
        // Check to see if we have CRM Settings
        CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        if(crm==null) {
            crm.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Non-Native';
            crm.dealer__Duplicate_Check_Statuses__c = 'Open, Duplicate';
            insert crm;
        }

        // Check to see if the FixedOperations settings are in place
        InstallScriptOrgAPI.createFixedOperationOrgDefaults();

       setupPaymentMethods();
    }
    
    global static void onUpgradeDataUpdate() 
    {
        // 2016.10.25      |Abhishek Goel         |W-000572
        // Run batch class to update service lookup on Vehicle Inventory 
        Database.executeBatch(new BatchPopulateServiceIdOnVehicleInventory(),2000); 

        // To update Equipped field in Vehicle Equipment |W-000622
        String q1 = 'select id, name, dealer__equiped__c, dealer__equipped__c from dealer__Vehicle_Equipment__c';
        String e1 = 'dealer__Vehicle_Equipment__c';
        String f1 = 'dealer__equiped__c';
        String v1 = 'dealer__equipped__c';
        Id batchInstanceId1 = Database.executeBatch(new BatchUpdateEquippedField(q1,e1,f1,v1), 2000); 

        // To update Equipped field in Service Vehicle Equipment |W-000622
        String q2 = 'select id, name, dealer__equiped__c, dealer__equipped__c from dealer__Service_Vehicle_Equipment__c';
        String e2 = 'dealer__Service_Vehicle_Equipment__c';
        String f2 = 'dealer__equiped__c';
        String v2 = 'dealer__equipped__c';
        Id batchInstanceId2 = Database.executeBatch(new BatchUpdateEquippedField(q2,e2,f2,v2), 2000); 

        // To update Equipped field in Custom Equipment |W-000622
        String q3 = 'select id, name, dealer__equiped__c, dealer__equipped__c from dealer__Custom_Equipment__c';
        String e3 = 'dealer__Custom_Equipment__c';
        String f3 = 'dealer__equiped__c';
        String v3 = 'dealer__equipped__c';
        Id batchInstanceId3 = Database.executeBatch(new BatchUpdateEquippedField(q3,e3,f3,v3), 2000); 
    }

    global static void createDefaultLocation() 
    {
        
        List<dealer__Dealer_Location__c> locations = [SELECT Id FROM dealer__Dealer_Location__c LIMIT 1];
        
        // If there is a location do not proceed. 
        if(locations.size()>0) {
            return;
        }

        // Create the Location Record
        dealer__Dealer_Location__c location = new dealer__Dealer_Location__c(
            Name='Redding Motors',
            dealer__Company_Number__c='RD1',
            dealer__Street__c='300 Twin Turbo Way',
            dealer__City__c='Redding',
            dealer__State__c='CA',
            dealer__County__c='Shasta',
            dealer__Postal_Code__c='96001',
            dealer__Email__c='reddingmotors@example.com',
            dealer__Website__c='ReddingMotors.com'
        );

        try {
            insert location;
        } Catch(DmlException e) {
            throw new InstallScript.InstallException(e.getMessage());
        } Catch(Exception e) {
            throw new InstallScript.InstallException(e.getMessage());
        }

        // Assign users to the location 
        List<User> usersToSet = new List<User>();
        List<dealer__Dealer_Location_User__c> availableLocations = new List<dealer__Dealer_Location_User__c>();  
        for(User u : [SELECT Id FROM User where IsActive = true]) {
            u.Division                 =   location.dealer__Company_Number__c;
            u.Dealership_Location__c   =   location.Name;
            usersToSet.add(u);
            availableLocations.add(new dealer__Dealer_Location_User__c(
                dealer__Dealer_Location__c=location.Id,
                dealer__User__c=u.Id
            ));
        }

        try {
            insert availableLocations;
            update usersToSet;
        } Catch(DmlException e) {
            throw new InstallScript.InstallException(e.getMessage());
        } Catch(Exception e) {
            throw new InstallScript.InstallException(e.getMessage());
        }
    }

    global static void createFixedOperationOrgDefaults()
    {
        FixedOperationsSettings__c fixedOpsSettings = FixedOperationsSettings__c.getOrgDefaults();
        System.debug(fixedOpsSettings);
        if(fixedOpsSettings==new FixedOperationsSettings__c()) {
            FixedOperationsSettings__c fops = new FixedOperationsSettings__c();
            insert fops;                
        }
    }

    global static void createDefaultPriceStrategy()
    {
        
    }
}