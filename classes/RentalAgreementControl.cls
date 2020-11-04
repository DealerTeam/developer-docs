public with sharing class RentalAgreementControl {

    private static boolean hasEncryptData = userHasEncryptedData(UserInfo.getUserId());
 
    @AuraEnabled
    public static Rental_Agreements__c saveFromScheduler(Rental_Agreements__c rental, String reservationId) {
        
        Savepoint sp = Database.setSavepoint();
        Rental_Schedule_Event__c rentalEvent = new Rental_Schedule_Event__c();
        try{   
            rentalEvent = [SELECT Id, Reservation__c, Agreements__c, Deposit_Amount__c, dealer__Customer__c, dealer__Customer_Contact__c, dealer__Customer_Contact__r.AccountId  FROM Rental_Schedule_Event__c WHERE Reservation__c =: reservationId];
            if(rentalEvent.Agreements__c != null) throw new AuraHandledException('A Rental Agreement already exists for this event.');
        } catch (QueryException e){
            system.debug(e.getMessage());
            throw new AuraHandledException('A valid reservation Id is needed to create a rental agreement from a rental event.');
        }
        rental.Discount__c = rental.Discount__c == null ? 0 : rental.Discount__c;
        rental.Discount_Percentage__c = rental.Discount_Percentage__c == null ? 0 : rental.Discount_Percentage__c;
        if (rental.dealer__DateTime_DUE_IN__c != null && rental.dealer__DateTime_Out__c != null) {
            Date dueIn = Date.newInstance(rental.dealer__DateTime_DUE_IN__c.year(), rental.dealer__DateTime_DUE_IN__c.month(), rental.dealer__DateTime_DUE_IN__c.day());
            Date dateOut = Date.newInstance(rental.dealer__DateTime_Out__c.year(), rental.dealer__DateTime_Out__c.month(), rental.dealer__DateTime_Out__c.day());
            
            rental.dealer__Date_DUE_In__c = dueIn;
            rental.dealer__Date_Out__c = dateOut;

            rental.dealer__Time_DUE_IN__c = rental.dealer__DateTime_Due_IN__c.format('hh:mm:ss a');
            rental.dealer__Time_OUT__c = rental.dealer__DateTime_Out__c.format('hh:mm:ss a');
        }
        if(rental.dealer__Return_DateTime__c != null){
            Date returnDate = Date.newInstance(rental.dealer__Return_DateTime__c.year(), rental.dealer__Return_DateTime__c.month(), rental.dealer__Return_DateTime__c.day());
            rental.Return_Date__c = returnDate;
        }

        try{
   
            if(rental.Discount_Percentage__c != 0 && rental.Discount__c == 0){
                rental = saveDiscountPercent(rental);
            } else {
                rental =  saveDiscount(rental);
            }
            if(rentalEvent.Deposit_Amount__c != null && rentalEvent.Deposit_Amount__c > 0){
                dealer__Cashering__c cashier = new dealer__Cashering__c();
                cashier.dealer__Rental_Agreement__c = rental.Id;
                cashier.dealer__Amount__c = rentalEvent.Deposit_Amount__c;
                cashier.dealer__Payment_Method__c = 'Deposit';
                cashier.dealer__Deposit__c = true;
                if(rentalEvent.dealer__Customer__c != null){
                    cashier.dealer__Customer__c = rentalEvent.dealer__Customer__c;
                }else if(rentalEvent.dealer__Customer_Contact__c != null && rentalEvent.dealer__Customer_Contact__r.AccountId != null){
                    cashier.dealer__Customer__c = rentalEvent.dealer__Customer_Contact__r.AccountId;
                }  
                insert cashier;
            }
            
            rentalEvent.Agreements__c = rental.Id;
            update rentalEvent;
        } catch (DMLException e){
            Database.rollback(sp);
            throw new AuraHandledException(e.getMessage());
        }
        return rental;
    }
    @AuraEnabled
    public static Rental_Agreements__c saveRental(Rental_Agreements__c rental) {
       
        List<String> missingFields = new List<String>();
        if(rental.Contact__c == null ){
            missingFields.add('Contact');
        }
        if(rental.rental_vehicle__c == null){
            missingFields.add('Rental Vehicle');
        }
        if(rental.rental_rates_code__c == null){
            missingFields.add('Rental Rate Code');
        }
        if(rental.Location__c == null) {
            missingFields.add('Store Location');
        }

       if(!missingFields.isEmpty()){
           String errorMsg = string.join(missingFields, ', ');
           throw new AuraHandledException('The following fields are required: ' + errorMsg);
       }

        if (rental.dealer__DateTime_DUE_IN__c != null && rental.dealer__DateTime_Out__c != null) {
            Date dueIn = Date.newInstance(rental.dealer__DateTime_DUE_IN__c.year(), rental.dealer__DateTime_DUE_IN__c.month(), rental.dealer__DateTime_DUE_IN__c.day());
            Date dateOut = Date.newInstance(rental.dealer__DateTime_Out__c.year(), rental.dealer__DateTime_Out__c.month(), rental.dealer__DateTime_Out__c.day());
            
            rental.dealer__Date_DUE_In__c = dueIn;
            rental.dealer__Date_Out__c = dateOut;

            rental.dealer__Time_DUE_IN__c = rental.dealer__DateTime_Due_IN__c.format('hh:mm:ss a');
            rental.dealer__Time_OUT__c = rental.dealer__DateTime_Out__c.format('hh:mm:ss a');
        }
        if(rental.dealer__Return_DateTime__c != null){
            Date returnDate = Date.newInstance(rental.dealer__Return_DateTime__c.year(), rental.dealer__Return_DateTime__c.month(), rental.dealer__Return_DateTime__c.day());
            rental.Return_Date__c = returnDate;
        }
        if(rental.dealer__Contact__c != null){
            Contact c = [SELECT Id, Birthdate,Issue_Date__c, Drivers_License_Expiration_Date__c,Drivers_License_Number__c,Drivers_License_State__c FROM Contact where Id =: rental.Contact__c];
            rental.Drivers_Birthdate__c = c.BirthDate;
            rental.Drivers_Lic_Exp__c = c.Drivers_License_Expiration_Date__c;
            rental.Drivers_Lic_State__c = c.Drivers_License_State__c;
            rental.Drivers_Lic__c = c.Drivers_License_Number__c;
        }
        if(rental.dealer__Return_Mileage__c != null && rental.dealer__Rental_Vehicle__c != null){
        
            dealer__Vehicle_Inventory__c rentalVeh = [SELECT dealer__Mileage__c
                FROM dealer__Vehicle_Inventory__c
                WHERE Id =: rental.dealer__Rental_Vehicle__c  limit 1
            ];
            if(rental.dealer__Return_Mileage__c > rentalVeh.dealer__Mileage__c && rental.dealer__Agreement_Status__c == 'Returned'){
                rentalVeh.dealer__Mileage__c = rental.dealer__Return_Mileage__c;
                update rentalVeh;
            }
            
        }
        

        List<Rental_Agreements__c> rentals = new List<Rental_Agreements__c>();
        rentals.add(rental);

        return getRentalAgreement(RentalAgreementAPI.updateRentalAgreements(rentals)[0].Id);
    }

    @AuraEnabled
    public static Rental_Agreements__c saveDiscount(Rental_Agreements__c rental) {
        if(rental.Discount_Percentage__c == null && rental.Discount__c == null){
            rental.Discount_Percentage__c = 0;
            rental.Discount__c = 0;
        }
        Decimal subtotal = RentalAgreementAPI.getGrossTotal(rental);

        rental.Discount__c = rental.Discount__c > 0 ? rental.Discount__c * -1 : rental.Discount__c;
        return saveRental(rental);
    }

    @AuraEnabled
    public static Rental_Agreements__c saveDiscountPercent(Rental_Agreements__c rental) {
        rental.Discount_Percentage__c = rental.Discount_Percentage__c == null ? 0 : rental.Discount_Percentage__c ;
        rental.Discount__c = rental.Discount__c == null ? 0 : rental.Discount__c;
        Decimal subtotal = RentalAgreementAPI.getGrossTotal(rental);
        rental.Discount__c = (rental.Discount_Percentage__c * (0.01*subtotal)) * -1;//convert to negative number?
        return saveRental(rental);
    }

    @AuraEnabled
    public static Map < String, String > availableFields() {

        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.Rental_Agreements__c.fields.getMap();

        for (String field: m.keySet()) {
            if (m.get(field).getDescribe().isAccessible()) {

                fieldNames.put(field, field);
            }
        }
        return fieldNames;
    }
    @AuraEnabled
    public static String getVehicleImage(string vehId){
        try{
            return [SELECT CDNURL__c FROM Inventory_Images__c WHERE Sequence_Number__c = 0 AND Vehicle_Inventory__c =: vehId ].CDNURL__c;
        } catch(QueryException e){
            return 'nourl';
        }
    }
    @AuraEnabled
    public static Map < String, String > editableFields() {

        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.Rental_Agreements__c.fields.getMap();

        for (String field: m.keySet()) {
            if (m.get(field).getDescribe().isUpdateable()) {

                fieldNames.put(field, field);
            }
        }
        return fieldNames;
    }

    @AuraEnabled
    public static List < String > getFieldnames() {
        List < STring > returnList = new List < string > ();
        List < Schema.SObjectType > objects = new List < Schema.SObjectType > {
            Rental_Agreements__c.SObjectType
        };
        for (Schema.SObjectType objType: objects) {
            for (Schema.SObjectField field: objType.getDescribe().fields.getMap().values()) {
                returnList.add(field.getDescribe().getName());
            }
        }
        return returnList;
    }

    @AuraEnabled
    public static List < Account > getAccounts(String accName) {

        String accNameVar = '%' + accName + '%';
        List < Account > allAccs = [SELECT Name, Id FROM Account WHERE Name LIKE: accNameVar];

        return allAccs;
    }

    @AuraEnabled
    public static Map < String, String > getFieldLabels() {
        Map < String, String > fieldLabels = new Map < String, String > ();

        //Get Object Global Describe
        Schema.SObjectType invObjDescribe = Schema.getGlobalDescribe().get('dealer__Vehicle_Inventory__c');
        Schema.SObjectType rentalAgreementObjDescribe = Schema.getGlobalDescribe().get('dealer__Rental_Agreements__c');
        Schema.SObjectType rentalRateObjDescribe = Schema.getGlobalDescribe().get('dealer__Rental_Rates__c');
    
        //Get Object Labels:
        fieldLabels.put('dealer__Vehicle_Inventory__c', invObjDescribe.getDescribe().getLabel());
        fieldLabels.put('dealer__Rental_Agreements__c', rentalAgreementObjDescribe.getDescribe().getLabel());
        fieldLabels.put('dealer__Rental_Rates__c', rentalRateObjDescribe.getDescribe().getLabel());


        //Get Field Labels
        Map < string, Schema.SObjectField > vehicleInventoryMap = invObjDescribe.getDescribe().fields.getMap();
        for (String FieldApiName: vehicleInventoryMap.keySet()) {
            if (fieldLabels.get(FieldApiName) == null)
                fieldLabels.put(FieldApiName, vehicleInventoryMap.get(FieldApiName).getDescribe().getLabel());
        }
        Map < string, Schema.SObjectField > rentalAgreementMap = rentalAgreementObjDescribe.getDescribe().fields.getMap();
        for (String FieldApiName: rentalAgreementMap.keySet()) {
            if (fieldLabels.get(FieldApiName) == null)
                fieldLabels.put(FieldApiName, rentalAgreementMap.get(FieldApiName).getDescribe().getLabel());
        }
        Map < string, Schema.SObjectField > rentalRatesMap = rentalRateObjDescribe.getDescribe().fields.getMap();
        for (String FieldApiName: rentalRatesMap.keySet()) {
            if (fieldLabels.get(FieldApiName) == null)
                fieldLabels.put(FieldApiName, rentalRatesMap.get(FieldApiName).getDescribe().getLabel());
        }

        return fieldLabels;
    }

    @AuraEnabled
    public static List < dealer__Cashering__c > getAllCashering(String rentalId) {
        return [SELECT Id, dealer__Customer__c, dealer__Credit_Card_Authorization_Code__c, dealer__Customer__r.Name, dealer__Payment_Method__c, dealer__Deposit__c, dealer__Amount__c,
            dealer__Rental_Agreement__r.dealer__Balance_Due__c, dealer__Rental_Agreement__r.dealer__TotalEstimatedCharges__c
            FROM dealer__Cashering__c WHERE dealer__Rental_Agreement__c =: rentalId ORDER BY CreatedDate DESC
        ];
    }
    @AuraEnabled
    public static List<String> getPaymentMethods(){
        List<String> methods = new List<String>();
        for(Payment_Methods__c method : Payment_Methods__c.getAll().values() ){
            methods.add(method.Method__c);
        }
    
        return methods;
    }

    @AuraEnabled
    public static List<Cashering__c> updateCashering(String rentalId, Cashering__c cashToUpdate) {
        update cashToUpdate;
        return getAllCashering(rentalId);
    }

    @AuraEnabled
    public static List<Cashering__c> deleteCashering(String rentalId, Cashering__c cash) {
        delete cash;
        return getAllCashering(rentalId);
    }
    @AuraEnabled
    public static void createCashering(dealer__Cashering__c cashToInsert) {
        insert cashToInsert;
    }
    @AuraEnabled
    public static List < List < String >> picklistValues() {
        List < List < String >> returnList = new List < List < String >> ();
        returnList.add(new List < String > ());
        returnList.add(new List < String > ());
        returnList.add(new List < String > ());
        returnList.add(new List < String > ());
        returnList.add(new List < String > ());

        returnList[0] = fuelLevelPickList();
        returnList[1] = licenseStatePicklist();
        returnList[2] = depositMethodPicklist();
        returnList[3] = paymentTypePicklist();
        returnList[4] = paymentMethodPicklist();

        return returnList;
    }

    public static List < String > fuelLevelPickList() {

        List < String > picklistValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Rental_Agreements__c.Fuel_Level_On_Checkout__c.getDescribe();

        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues.size() > 0 ? picklistValues : new List < String > ();
    }

    public static List < String > licenseStatePicklist() {

        List < String > picklistValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Rental_Agreements__c.Drivers_Lic_State__c.getDescribe();

        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues.size() > 0 ? picklistValues : new List < String > ();
    }

    public static List < String > depositMethodPicklist() {
        List < String > picklistValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Rental_Agreements__c.Deposit_Method__c.getDescribe();

        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues.size() > 0 ? picklistValues : new List < String > ();
    }

    public static List < String > paymentTypePicklist() {
        List < String > picklistValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Rental_Agreements__c.Payment_Type__c.getDescribe();

        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues.size() > 0 ? picklistValues : new List < String > ();
    }

    public static List < String > paymentMethodPicklist() {

        List < String > picklistValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Rental_Agreements__c.Payment_Method__c.getDescribe();

        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues.size() > 0 ? picklistValues : new List < String > ();
    }
    @AuraEnabled
    public static List < String > getFormNames(String rentalId) {
        List < String > formNames = new List < String > ();
        String contract;
        String receipt;
        formNames.add(contract);
        formNames.add(receipt);
        try {
            // RentalSettings__c rentalSettings = getRentalSettings();
            Rental_Agreements__c currentRental = [SELECT Location__c FROM Rental_Agreements__c WHERE Id =: rentalId];
            Dealer_Location__c currentLocation = [SELECT Rental_Agreement_Contract__c, Rental_Agreement_Receipt__c FROM Dealer_Location__c WHERE Id =: currentRental.Location__c];

            //get contract page 
            if (currentLocation.Rental_Agreement_Contract__c != null) {
                formNames[0] = currentLocation.Rental_Agreement_Contract__c;
            } else {
                formNames[0] = DealerMetadata.getConfigValue('RentalContractFormName');

            }

            //get receipt page
            if (currentLocation.Rental_Agreement_Receipt__c != null) {
                formNames[1] = currentLocation.Rental_Agreement_Receipt__c;
            } else {
                formNames[1] = DealerMetadata.getConfigValue('RentalReceiptFormName');

            }
        } catch (DMLException e) {
            throw new DMLException(e.getMessage());
        }

        return formNames;
    }
    @AuraEnabled
    public static dealer__RentalSettings__c getRentalSettings() {

        return [SELECT dealer__DailyMileageLimit__c, dealer__ExcessMileageFee__c, dealer__RefuelingFee__c, dealer__FuelChargePerGallon__c,
            dealer__ContractFormName__c, dealer__ReceiptFormName__c
            FROM dealer__RentalSettings__c
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static dealer__DMS_Settings__c getDMSSettings() {

        return [SELECT dealer__Default_Tax_Rate__c
            FROM dealer__DMS_Settings__c
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static List<Rental_Fee__c> getRentalFees(String rentalId){
        try{
            return [SELECT Id, Name, Fee_Name__c, Amount__c, Tax__c, dealer__Taxable__c  FROM Rental_Fee__c WHERE Rental_Agreement__c =: rentalId];
        } catch (QueryException e){
            return new List<Rental_Fee__c>();
        }
    }

    @AuraEnabled 
    public static List<Rental_Fee__c> deleteRentalFeeLine(String rentalId, Rental_Fee__c fee){
        try{
            Rental_Fee__c feeToDel = [SELECT Id FROM Rental_Fee__c WHERE Id =: fee.Id];
            delete feeToDel;
        } catch (DMLException e){
            throw new AuraHandledException(e.getMessage());
        } catch (QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
        return getRentalFees(rentalId);
    }

    @AuraEnabled
    public static dealer__Dealer_Location__c getLocationTaxes(String locId) {

        dealer__Dealer_Location__c locationTaxes;

        if (locId != null) {

            try {
                locationTaxes = [SELECT Id, dealer__Tax_Local_Rate__c, dealer__Tax_Local_Rental_Addition__c
                    FROM dealer__Dealer_Location__c
                    WHERE Id =: locId LIMIT 1
                ];
            } catch (Exception e) {
                e.getMessage();
            }
        }

        return locationTaxes;
    }

    @AuraEnabled
    public static dealer__Vehicle_Inventory__c getUnit(Id rentalVehicle) {
        System.debug('rental vehicle ' + rentalVehicle);
        if (rentalVehicle != null) {
            return [SELECT Id, dealer__Rental_Status__c, dealer__Mileage__c
                FROM dealer__Vehicle_Inventory__c
                WHERE Id =: rentalVehicle limit 1
            ];
        } else {
            return null;
        }
    }
     @AuraEnabled
    public static dealer__Vehicle_Inventory__c getMileage(Id raId) {
        System.debug('raId is ' + raId);

        dealer__Rental_Agreements__c vehicle = [SELECT Name, dealer__Rental_Vehicle__c, dealer__Customer_Vehicle__c FROM dealer__Rental_Agreements__c WHERE Id=: raId];

        System.debug('rental vehicle ' + vehicle);
        if (vehicle != null) {
            return [SELECT dealer__Mileage__c
                FROM dealer__Vehicle_Inventory__c
                WHERE Id =: vehicle.dealer__Rental_Vehicle__c limit 1
            ];
        } else {
            return null;
        }
    }

    @AuraEnabled
    public static dealer__Rental_Schedule_Event__c getReservationEventData(String reservationId) {
        system.debug('RESERVATION '+reservationId);
        if (reservationId != null) {

            return [SELECT Id, Name, dealer__Agreements__c, dealer__Description__c, dealer__Event_End__c, dealer__Event_Start__c,
                dealer__Location__c, dealer__Location__r.Name, dealer__Reservation__c, dealer__Type__c, dealer__Customer__c, dealer__Customer__r.Name,
                dealer__Customer__r.dealer__Drivers_License_Number__pc,
                dealer__Discount_Percentage__c, dealer__Delivery_Fee__c, dealer__Days_Free__c, dealer__Customer_Contact__c, dealer__Customer_Contact__r.Name,
                dealer__Customer_Contact__r.Drivers_License_Number__c, dealer__Customer_Contact__r.Drivers_License_Expiration_Date__c, dealer__Customer_Contact__r.Drivers_License_State__c,
                dealer__Customer_Contact__r.Birthdate,
                dealer__Deposit_Amount__c, dealer__Discount__c, dealer__Rental_Rate__c, dealer__Rental_Rate__r.Name, dealer__Tax_Exempt__c, dealer__Vehicle_License_Fee__c,
                dealer__Vehicle_Inventory__c, dealer__Vehicle_Inventory__r.Name, dealer__Vehicle_Inventory__r.dealer__Mileage__c
                FROM dealer__Rental_Schedule_Event__c
                WHERE dealer__Reservation__c =: reservationId
                LIMIT 1
            ];
        } else {
            return new dealer__Rental_Schedule_Event__c();
        }
    }

    @AuraEnabled
    public static String updateVehicle(dealer__Vehicle_Inventory__c vehicle) {

        String msg = '';
        if (vehicle != null) {

            try {
                update vehicle;

            } catch (Exception e) {
                msg = e.getMessage();
            }
        }
        return msg;
    }

    @AuraEnabled
    public static Contact getCustomer(Id contactId) {

        if (contactId != null) {
            return [Select Id, Name, FirstName, LastName, HomePhone, MailingStreet, MailingCity, MailingState,
                MailingPostalCode, Email, MobilePhone, Birthdate, RecordTypeId,
                Drivers_License_Number__c, Drivers_License_Expiration_Date__c, Drivers_License_State__c
                from Contact
                where Id =: contactId Limit 1
            ];

        } else {
            return null;
        }
    }

    @AuraEnabled
    public static Contact updateContact(Contact contact, Rental_Agreements__c rental ) {
       rental.Drivers_Birthdate__c = contact.BirthDate;
       rental.Drivers_Lic_Exp__c = contact.Drivers_License_Expiration_Date__c;
       rental.Drivers_Lic__c = contact.Drivers_License_Number__c;
       rental.Drivers_Lic_State__c = contact.Drivers_License_State__c;
        try {
            if(rental.Id != null){
                update rental;
            }
            update contact;
        } catch (DMLException e) {
            throw new AuraHandledException(e.getMessage());
        }
        return contact;
    }

    @AuraEnabled
    public static Vehicle_Inventory__c getInventoryInfo(String vehicleId) {

        if (vehicleId != null) {
            return [SELECT Id, Name, dealer__Mileage__c
                FROM dealer__Vehicle_Inventory__c
                WHERE Id =: vehicleId limit 1
            ];
        }

        return null;
    }

   
    @AuraEnabled
    public static void saveDrivers(List < dealer__Driver__c > drivers) {

        if (drivers != null && !drivers.isEmpty()) {
            try {
                insert drivers;
            } catch (Exception e) {
                e.getMessage();
            }
        }
    }

    @AuraEnabled
    //public static String getRequiredFields(){
    public static Map < String, Boolean > getRequiredFields() {
        //not compatible with Lightning yet so we will use managed layout name.
        // String layoutName = DealerMetadata.getAssignedPageLayoutAPIName('Rental_Agreements') != null? DealerMetadata.getAssignedPageLayoutAPIName('Rental_Agreements') : 'dealer__Rental_Agreements__c-dealer__Rental Agreements Layout';
        String layoutName = 'dealer__Rental_Agreements__c-dealer__Rental Agreements Layout';
        return DealerMetadata.getAllRequiredFields(Schema.SObjectType.Rental_Agreements__c, layoutName);
    }
    @AuraEnabled
    public static dealer__Rental_Agreements__c getRentalAgreement(String raId) {
        Rental_Agreements__c ra = new Rental_Agreements__c();
        if(raId != null){
            ra = [SELECT d.dealer__Total_Tax__c, d.dealer__Total_Charges__c, d.dealer__Days_Free_Discount__c, d.Contact__r.AccountId,d.Contact__r.Birthdate,d.Contact__r.Issue_Date__c,d.Contact__r.Drivers_License_Expiration_Date__c,d.Contact__r.dealer__Drivers_License_Number__c,d.Contact__r.dealer__Drivers_License_State__c, d.dealer__Rental_Vehicle_Total__c, d.dealer__Vehicle_Licence_Fee__c, d.dealer__Vehicle_Licence_Fee_Extended__c,
                d.dealer__Total_Payments__c, d.dealer__Total_Mileage_Limit__c, d.dealer__Total_Adjustment__c,
                d.dealer__TotalEstimatedCharges__c, d.dealer__Time_OUT_raw_minutes__c, d.dealer__Time_OUT__c,
                d.dealer__Time_DUE_IN_raw_minutes__c, d.dealer__Time_DUE_IN__c, d.dealer__Tax_Exempt__c,
                d.dealer__SubTotal__c, d.dealer__Split_Payment_Notes__c, d.dealer__Service_Repair_Order__c, d.dealer__Service_Repair_Order__r.Name,
                d.dealer__Service_Repair_Order_No__c, d.dealer__Return_Time_raw_minutes__c, d.dealer__Return_Time__c,
                d.dealer__Return_Mileage__c, d.dealer__Return_Date__c, d.dealer__Return_Damage__c, d.dealer__Rental_Vehicle__c, d.dealer__Rental_Vehicle__r.Name,
                d.dealer__Rental_Vehicle_VIN__c, d.dealer__Rental_Vehicle_Unit_No__c, d.dealer__Rental_Vehicle_Description__c,
                d.dealer__Rental_Rates_code__c, d.dealer__Rental_Rates_code__r.Name, d.dealer__Rental_Rates_code__r.dealer__Daily_Miles_Allowed__c, d.dealer__Rental_Rates_code__r.dealer__Excess_Miles_Fee__c, d.dealer__Rental_Rates_code__r.dealer__RefuelingFee__c,
                d.dealer__Rental_Rates_code__r.dealer__Rate_Description__c, d.dealer__Rental_Rates_code__r.dealer__Weekly_Rate__c, d.dealer__Rental_Rates_code__r.dealer__Daily_Rate__c, d.dealer__Rental_Rates_code__r.FuelChargePerUnit__c, d.dealer__Rental_Rate__c, 
                d.dealer__Rental_Accessories__c, d.dealer__Rental_Accessories__r.Name, d.dealer__RefuelQuantity__c,
                d.dealer__Refueling_Fee__c, d.dealer__Re_Fuel_Fee__c, d.dealer__Purchase_Order__c, d.dealer__Policy_No__c,
                d.dealer__Policy_Expiration_Date__c, d.dealer__Payment_Type__c, d.dealer__Payment_Method__c, d.dealer__Miles_Driven__c,
                d.dealer__Mileage_Overages__c, d.dealer__Mileage_Out__c, d.dealer__Mileage_Limit_Daily__c, d.dealer__Location__c, d.dealer__Location__r.Name,
                d.dealer__Insurer__c, d.dealer__Insurer_Phone__c, d.dealer__Fuel_Level_on_Return__c, d.dealer__Fuel_Level_on_Checkout__c,
                d.dealer__Fuel_Charge_per_Gallon__c, d.dealer__Fuel_Charge_on_Return__c, d.dealer__Existing_Damage__c,
                d.dealer__Excess_Miles_Fee__c, d.dealer__Estimated_Tax__c, d.dealer__Estimated_Charges__c, d.dealer__Drivers_Lic__c,
                d.dealer__Drivers_Lic_State__c, d.dealer__Drivers_Lic_Exp__c, d.dealer__Drivers_Birthdate__c, d.dealer__Discount__c,
                d.dealer__Discount_Percentage__c, d.dealer__Deposit_Method__c, d.dealer__Deposit_Amount__c, d.dealer__Delivery_or_Pickup__c,
                d.dealer__Delivery_Instructions__c, d.dealer__Delivery_Fee__c, d.dealer__Days_Rented__c, d.dealer__Days_Free__c,
                d.dealer__Days_Elapsed__c, d.dealer__Date_Out__c, d.dealer__Date_DUE_In__c, d.dealer__Daily_Miles_Allowed__c,
                d.dealer__Customer_Vehicle__c, d.dealer__Customer_Vehicle_VIN__c, d.dealer__Customer_Vehicle_Licence_State__c,
                d.dealer__Customer_Vehicle_Licence_No__c, d.dealer__Customer_Vehicle_Description__c, d.dealer__Customer_Pay_Amount__c,
                d.dealer__Credit_Card__c, d.dealer__Credit_Card_Track_Data__c, d.dealer__Credit_Card_Expiration_Date__c, d.dealer__Contact__c, d.dealer__Contact__r.Name,
                d.dealer__CC_Phone_Number__c, d.dealer__Balance_Due__c, d.dealer__Authorization_Number__c, d.dealer__Agreement_Status__c, d.dealer__Agent__c,
                d.dealer__Adjustment_Charges__c, d.dealer__Additional_Drivers_Lic__c, d.dealer__Additional_Drivers_Lic_St__c, d.dealer__Additional_Drivers_Lic_Exp__c,
                d.dealer__Additional_Drivers_Birthday__c, d.dealer__Additional_Driver__c, d.dealer__Additional_Charges_Notes__c, d.dealer__Accessories_Description__c,
                d.dealer__Accessories_Cost__c, d.OwnerId, d.Owner.Name, d.Name, d.Id, d.dealer__DateTime_OUT__c, d.dealer__DateTime_DUE_IN__c, d.dealer__Return_DateTime__c
                FROM dealer__Rental_Agreements__c d
                WHERE d.Id =: raId
                LIMIT 1
            ];

            //Sanitize Credit Card encrypted field
            Map < String, Schema.SObjectField > m = Schema.SObjectType.dealer__Rental_Agreements__c.fields.getMap();
            String creditcard = 'dealer__Credit_Card__c';

            // Check that it is in fields that are cared about
            if (m.get(creditcard).getDescribe().isAccessible()) {

                // Check if it is an encrypted string and if so, sanitize
                // else return the original value
                if (m.get(creditcard).getDescribe().getType().name() == 'ENCRYPTEDSTRING') {
                    ra.put(creditcard, sanitizeEncryptedData(hasEncryptData, (String) ra.get(creditcard)));
                } else {
                    ra.put(creditcard, (String) ra.get(creditcard));
                }

            }
        }
        return ra;
    }
    @AuraEnabled
    public static Contact getNewPrimaryDriver(String contactId) {
        return [SELECT Id, Name, Phone, MobilePhone,
            Email, MailingStreet, MailingCity, MailingState,
            MailingPostalCode, MailingCountry, Birthdate, RecordTypeId,
            Drivers_License_Number__c, Drivers_License_Expiration_Date__c,
            Drivers_License_State__c
            FROM Contact WHERE Id =: contactId
        ];
    }
    @AuraEnabled
    public static Vehicle_Inventory__c getRentalVehicle(String vehId) {
        return [SELECT Id, Name FROM Vehicle_Inventory__c Where Id =: vehId];
    }
    // @AuraEnabled
    // public static dealer__Rental_Agreements__c updateRental(dealer__Rental_Agreements__c rental) {

    //     if (rental.dealer__DateTime_DUE_IN__c != null && rental.dealer__DateTime_Out__c != null) {
    //         Date dueIn = Date.newInstance(rental.dealer__DateTime_DUE_IN__c.year(), rental.dealer__DateTime_DUE_IN__c.month(), rental.dealer__DateTime_DUE_IN__c.day());
    //         Date dueOut = Date.newInstance(rental.dealer__DateTime_Out__c.year(), rental.dealer__DateTime_Out__c.month(), rental.dealer__DateTime_Out__c.day());
    //         rental.dealer__Date_DUE_In__c = dueIn;
    //         rental.dealer__Date_Out__c = dueOut;
    //         rental.dealer__Time_DUE_IN__c = rental.dealer__DateTime_Due_IN__c.format('hh:mm:ss a');
    //         rental.dealer__Time_OUT__c = rental.dealer__DateTime_Out__c.format('hh:mm:ss a');
    //     }
    //     if (rental.dealer__Return_DateTime__c != null) {
    //         Date dateIn = Date.newInstance(rental.dealer__Return_DateTime__c.year(), rental.dealer__Return_DateTime__c.month(), rental.dealer__Return_DateTime__c.day());
    //         rental.dealer__Return_Date__c = dateIn;
    //         rental.dealer__Return_Time__c = rental.dealer__Return_DateTime__c.format('hh:mm:ss a');
    //     }


    //     if (rental.dealer__Days_Rented__c != null && rental.dealer__Rental_Rate__c != null)
    //         rental.dealer__Rental_Vehicle_Total__c = rental.dealer__Days_Rented__c * rental.dealer__Rental_Rate__c;

    //     if (rental.dealer__Days_Free__c != null && rental.dealer__Rental_Rate__c != null)
    //         rental.dealer__Days_Free_Discount__c = rental.dealer__Days_Free__c * rental.dealer__Rental_Rate__c;

    //     if (rental != null) {

    //         try {
    //             update rental;

    //         } catch (Exception e) {
    //             e.getMessage();
    //         }
    //     }

    //     return rental;
    // }
    @AuraEnabled
    public static String updateDrivers(List < dealer__Driver__c > drivers) {

        String msg = '';

        if (drivers != null && !drivers.isEmpty()) {
            List < dealer__Driver__c > driversToInsert = new List < dealer__Driver__c > ();
            Integer i = 0;
            while (i < drivers.size()) {

                if (drivers[i].Id == null) {

                    driversToInsert.add(drivers[i]);
                    drivers.remove(i);

                } else {
                    i++;
                }
            }

            try {
                insert driversToInsert;
                update drivers;
            } catch (Exception e) {
                msg = e.getMessage();
            }
        }

        return msg;
    }

    @AuraEnabled
    public static List < Driver__c > getDrivers(Id rentalId) {
        try{
            return [Select Id, Name, Birth_Date__c, Home_Phone__c, Licence_Expiration_Date__c,
                Licence_State__c, License_Number__c, Mobile_Phone__c, Rental_Agreements__c
                from Driver__c
                where Rental_Agreements__c =: rentalId
            ];
        } catch(QueryException e){
            return new List<Driver__c>();
        }
    }
    @AuraEnabled
    public static List<Driver__c> deleteDriver(String rentalId, Driver__c driver) {
        try {
            delete driver;
        } catch (DMLException e) {
            throw new AuraHandledException(e.getMessage());
        }
        return getDrivers(rentalId);
    }
    @AuraEnabled
    public static String deleteDrivers(List < dealer__Driver__c > drivers) {

        String msg = '';
        if (drivers != null && !drivers.isEmpty()) {
            try {
                delete drivers;
            } catch (Exception e) {
                msg = e.getMessage();
            }
        }

        return msg;
    }

    @AuraEnabled
    public static String getUserName() {
        Id userId = UserInfo.getUserId();
        return [SELECT Name FROM User WHERE Id =: userId].Name;
    }

    @AuraEnabled
    public static void createTask(boolean isRentalComplete, String rentalId) {

        Task stact;
        if (isRentalComplete) {
            stact = new Task(
                whatID = rentalId, // Rental Contract ID 
                OwnerId = UserInfo.getUserId(),
                subject = 'Rental Return',
                description = 'Processed Rental Return',
                Status = 'Completed',
                priority = 'Normal',
                ActivityDate = date.today()
            );
        } else {
            stact = new Task(
                whatID = rentalId, // Rental Contract ID 
                OwnerId = UserInfo.getUserId(),
                subject = 'Re-Opened Rental Contract',
                description = 'Re-Opened Rental Contract',
                Status = 'Completed',
                priority = 'Normal',
                ActivityDate = date.today()
            );
        }

        try {
            insert stact;
        } catch (Exception e) {
            e.getMessage();
        }
    }


    /***********************************************************
     * Description: Return if user has View Encrypted Data permission.
     * 
     * @param: userId - userId to check if has encrypted data permission
     * 
     * @return: boolean
     * ********************************************************/
    public static boolean userHasEncryptedData(Id userId) {
        List < PermissionSetAssignment > psaEncrypt = [SELECT Id
            FROM PermissionSetAssignment
            WHERE PermissionSet.PermissionsViewEncryptedData = true
            AND AssigneeId =: userId
        ];

        if (psaEncrypt.isEmpty()) {
            return false;
        } else {
            return true;
        }
    }

    /***********************************************************
     * Description: Sanitize the string if the user does not have view encrypted data permission.
     * 
     * @param: hasEncryptedData - if the user has encrypted data permission
     * @param: stringToSanitize - the string to santitize before returning to client
     * @param: fieldType - this is the type of field to sanitize, only perform if encrypted string
     * 
     * @return: boolean
     * ********************************************************/
    public static String sanitizeEncryptedData(boolean hasEncryptedData, String stringToSanitize) {

        if (!hasEncryptedData && stringToSanitize != null) {

            return stringToSanitize = 'XXXX-XXXX-XXXX-' + stringToSanitize.right(4);
        } else {

            return stringToSanitize;
        }

    }

    /***
     * RentalAgreementNew Methods 
     ***/

    // Vehicle Inventory
    @AuraEnabled
    public static List<LookupSearchResult> searchVehicleInventory(String searchTerm) {
        try {
            String sObjectName = Vehicle_Inventory__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> getRecentVehicles() {
        try {
            String sObjectName = Vehicle_Inventory__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Rental Rates
    @AuraEnabled
    public static List<LookupSearchResult> searchRentalRate(String searchTerm) {
        try {
            String sObjectName = Rental_Rates__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> getRecentRates() {
        try {
            String sObjectName = Rental_Rates__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Locations
    @AuraEnabled
    public static List<LookupSearchResult> searchLocation(String searchTerm) {
        try {
            String sObjectName = Dealer_Location__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> getRecentLocations() {
        try {
            String sObjectName = Dealer_Location__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static dealer__Dealer_Location__c getUserLocation() {

        User u = [Select Id, Division from User Where Id =: UserInfo.getUserId() limit 1];
        if (u.Division == null) return null;

        dealer__Dealer_Location__c loc = [Select Id, Name, dealer__Company_Number__c
            FROM dealer__Dealer_Location__c
            WHERE dealer__Company_Number__c =: u.Division
            Limit 1
        ];
        if (loc != null) {
            return loc;
        }

        return null;
    }
    
    @AuraEnabled
    public static List<LookupSearchResult> getUserLocationSearch() {
        List<LookupSearchResult> returnList;

        String sObjectName = Dealer_Location__c.SObjectType.getDescribe().getName();
        LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
        User u = [SELECT Id, Division from User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        List<Dealer_Location__c> locs = [SELECT Id FROM Dealer_Location__c WHERE Company_Number__c =: u.Division LIMIT 1];

        if(locs.size() > 0) {
            Id locId = locs.get(0).Id;
            returnList = s.geSelectionById(locId);
        }

        return returnList;
    }

}