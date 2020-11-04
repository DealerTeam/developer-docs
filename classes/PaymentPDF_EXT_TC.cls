/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.09.22      |Gaurav               |Case 00002069
* Code Coverage for PaymentPDF_Ext
*
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/
@isTest
public class PaymentPDF_EXT_TC {
    static testmethod void testPaymentPDF(){
        
        TestClassUtil testutil = new TestClassUtil();
        testutil.insertDMSSettings();
        
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
        objLocation.Name = 'DealerReam';
        objLocation.dealer__Company_Number__c = 'DT1';
        objLocation.dealer__City__c = 'Redding';
        objLocation.dealer__State__c= 'CA';
        objLocation.dealer__Postal_Code__c='96001';
        insert objLocation;         
        
        dealer__Vehicle_Inventory__c objVehicleInventory = new dealer__Vehicle_Inventory__c();
        objVehicleInventory.dealer__Stock_Number__c='5624';
        objVehicleInventory.dealer__Year__c='2001';
        objVehicleInventory.dealer__Make__c='make';
        objVehicleInventory.dealer__Model__c='2003';      
        objVehicleInventory.dealer__VIN__c='125';
        insert objVehicleInventory;
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account';
        objAccount.Type = 'Customer - Direct';
        objAccount.dealer__Vendor__c = true;
        insert objAccount; 
        
        Contact objContact = new Contact();
        objContact.AccountId = objAccount.Id;
        objContact.LastName = 'TestContact';
        objContact.FirstName = 'testFirstName';
        objContact.Email = 'nicki.allen@me.com';
        objContact.HomePhone = '8099306664';
        objContact.MobilePhone = '8099306664';        
        insert objContact;        
        
        dealer__Service_Repair_Order__c objSRO = new dealer__Service_Repair_Order__c();        
        objSRO.dealer__Customer__c = objAccount.Id;
        objSRO.dealer__Deposit__c = 100;
        objSRO.dealer__Customer_Contact__c = objContact.Id;
        objSRO.Name = 'Test Service Repair Order';
        objSRO.dealer__Customer_Charges__c = 50;
        objSRO.dealer__Company_Number__c = 'Location 1';
        objSRO.dealer__Tax__c = 30;
        objSRO.dealer__Shop_Supplies__c = 20;
        objSRO.dealer__RO_Number__c = 'RO100';
        objSRO.dealer__Mileage_In__c = 10;
        objSRO.dealer__Mileage_Out__c = 5;
        //objSRO.dealer__Company__c = objLocation.Id;     //#W-000811
        objSRO.dealer__Vehicle_Inventory__c = objVehicleInventory.Id;
        insert objSRO;        
        
        dealer__Cashering__c objCashering = new dealer__Cashering__c();
        objCashering.dealer__Amount__c = 100;
        objCashering.dealer__Close_Date__c = System.today();
        objCashering.dealer__Company_Number__c = 'Location 1';
        objCashering.dealer__Credit_Card_Authorization_Code__c = 'abcd';
        objCashering.dealer__Deposit__c = True;
        objCashering.dealer__Payment_Method__c = 'Cash';
        objCashering.dealer__Payment_Receipt_Details__c = 'Test Description';
        objCashering.dealer__Customer__c = objAccount.Id;
        objCashering.dealer__Service_Repair_Order__c = objSRO.Id;
        insert objCashering;
        
        ApexPages.currentPage().getParameters().put('Id', objCashering.Id); 
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(objCashering);
        PaymentPDF_EXT objPayementPDFExt = new PaymentPDF_EXT(sc); 
        objPayementPDFExt.getInvoiceLogo();
        objPayementPDFExt.getprintDateTime();
    }
}