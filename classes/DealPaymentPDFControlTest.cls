@isTest
public class DealPaymentPDFControlTest {
    
     @isTest private static void testDealPaymentPDF(){
         
    	//TestClassUtil testutil = new TestClassUtil();
       // testutil.insertDMSSettings();
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
      EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');

     insert u;
      System.runAs(u) {
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
        objLocation.Name = 'DealerTeam';
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
        //objAccount.dealer__Vendor__c = true;
        insert objAccount; 

        dealer__Deal__c deal = new dealer__Deal__c();
        deal.dealer__Vehicle__c = objVehicleInventory.Id;
     	deal.dealer__Store_Location__c = objLocation.Id;
        deal.dealer__Deal_ID__c = 'Test';
        insert deal;
             
        
        dealer__Cashering__c objCashering = new dealer__Cashering__c();
        objCashering.dealer__Amount__c = 100;
        objCashering.dealer__Close_Date__c = System.today();
        objCashering.dealer__Company_Number__c = 'Location 1';
        objCashering.dealer__Credit_Card_Authorization_Code__c = 'abcd';
        objCashering.dealer__Deposit__c = True;
        objCashering.dealer__Payment_Method__c = 'Cash';
        objCashering.dealer__Payment_Receipt_Details__c = 'Test Description';
        objCashering.dealer__Customer__c = objAccount.Id;
        objCashering.dealer__Deal__c = deal.Id;
        insert objCashering;

        Document doc = new Document();
            doc.Name='InvoiceLogo';
            doc.DeveloperName = 'InvoiceLogo';
            doc.FolderId=u.Id;
            insert doc;
        
        ApexPages.currentPage().getParameters().put('Id', objCashering.Id); 
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(objCashering);
        DealPaymentPDFControl controller = new DealPaymentPDFControl(sc); 
        string s = controller.InvoiceLogo;
        controller.getprintDateTime();
     }
     }
}