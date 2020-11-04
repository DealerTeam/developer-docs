public with sharing class RentalFeeHandler {
    public RentalFeeHandler() {
    }
    public List<Rental_Fee__c> updateRentalAgreements(List<Rental_Fee__c> triggerNew){
        Set<Id> agreementSet = new Set<Id>();
        system.debug(JSON.serializePretty(triggerNew));
        for(Rental_Fee__c rf : triggerNew){
            if(!agreementSet.contains(rf.Rental_Agreement__c)){
                agreementSet.add(rf.Rental_Agreement__c);
            }
        }
        List<Rental_Agreements__c> rentalsToUpdate = new List<Rental_Agreements__c>();
        for(Rental_Agreements__c rental : getRentalAgreements(agreementSet)){
            rentalsToUpdate.add(rental);
        }
        if(rentalsToUpdate.size() > 0){
            RentalAgreementAPI.updateRentalAgreements(rentalsToUpdate);
        }
        return triggerNew;
    }
    public List<Rental_Agreements__c> getRentalAgreements(Set<Id> agreementIds){
        Return [SELECT Total_Tax__c, Total_Charges__c, Days_Free_Discount__c, Contact__r.AccountId,Contact__r.Birthdate,Contact__r.Issue_Date__c,Contact__r.Drivers_License_Expiration_Date__c,Contact__r.Drivers_License_Number__c,Contact__r.Drivers_License_State__c, Rental_Vehicle_Total__c, Vehicle_Licence_Fee__c, Vehicle_Licence_Fee_Extended__c,
            Total_Payments__c, Total_Mileage_Limit__c, Total_Adjustment__c,
            TotalEstimatedCharges__c, Time_OUT_raw_minutes__c, Time_OUT__c,
            Time_DUE_IN_raw_minutes__c, Time_DUE_IN__c, Tax_Exempt__c,
            SubTotal__c, Split_Payment_Notes__c, Service_Repair_Order__c, Service_Repair_Order__r.Name,
            Service_Repair_Order_No__c, Return_Time_raw_minutes__c, Return_Time__c,
            Return_Mileage__c, Return_Date__c, Return_Damage__c, Rental_Vehicle__c, Rental_Vehicle__r.Name,
            Rental_Vehicle_VIN__c, Rental_Vehicle_Unit_No__c, Rental_Vehicle_Description__c,
            Rental_Rates_code__c, Rental_Rates_code__r.Name, Rental_Rate__c, Rental_Accessories__c, Rental_Accessories__r.Name,
            Refueling_Fee__c, Re_Fuel_Fee__c, Purchase_Order__c, Policy_No__c,
            Policy_Expiration_Date__c, Payment_Type__c, Payment_Method__c, Miles_Driven__c,
            Mileage_Overages__c, Mileage_Out__c, Mileage_Limit_Daily__c, Location__c, Location__r.Name,
            Insurer__c, Insurer_Phone__c, Fuel_Level_on_Return__c, Fuel_Level_on_Checkout__c,
            Fuel_Charge_per_Gallon__c, Fuel_Charge_on_Return__c, Existing_Damage__c,
            Excess_Miles_Fee__c, Estimated_Tax__c, Estimated_Charges__c, Drivers_Lic__c,
            Drivers_Lic_State__c, Drivers_Lic_Exp__c, Drivers_Birthdate__c, Discount__c,
            Discount_Percentage__c, Deposit_Method__c, Deposit_Amount__c, Delivery_or_Pickup__c,
            Delivery_Instructions__c, Delivery_Fee__c, Days_Rented__c, Days_Free__c,
            Days_Elapsed__c, Date_Out__c, Date_DUE_In__c, Daily_Miles_Allowed__c,
            Customer_Vehicle__c, Customer_Vehicle_VIN__c, Customer_Vehicle_Licence_State__c,
            Customer_Vehicle_Licence_No__c, Customer_Vehicle_Description__c, Customer_Pay_Amount__c,
            Credit_Card__c, Credit_Card_Track_Data__c, Credit_Card_Expiration_Date__c, Contact__c, Contact__r.Name,
            CC_Phone_Number__c, Balance_Due__c, Authorization_Number__c, Agreement_Status__c, Agent__c,
            Adjustment_Charges__c, Additional_Drivers_Lic__c, Additional_Drivers_Lic_St__c, Additional_Drivers_Lic_Exp__c,
            Additional_Drivers_Birthday__c, Additional_Driver__c, Additional_Charges_Notes__c, Accessories_Description__c,
            Accessories_Cost__c, OwnerId, Owner.Name, Name, Id, DateTime_OUT__c, DateTime_DUE_IN__c, Return_DateTime__c
            FROM Rental_Agreements__c
            WHERE Id IN: agreementIds
        ];
    }
}