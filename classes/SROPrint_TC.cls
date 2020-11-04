/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class SROPrint_TC{

    @TestSetup static void testInitData() {
        // Insert DMS Settings
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        // Create the location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
        // Create the user
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert usr;

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
            ps.Method__c = 'Jobber';
            ps.Active__c = true;
            ps.Description__c = 'test';
            ps.Default__c = true;
            ps.dealer__Parts_Variable_Amount__c = 10;
            ps.dealer__Formula_Operand__c = '+';
            insert ps;

    }

    static testmethod void testSROPrint(){
        /* W-000811 Begin */
        User u = [Select Id from User where username = 'testuser128@testorgx.com' limit 1];
        
        dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = ddl.Id;
        objUserLocation.dealer__User__c = u.Id;
        insert objUserLocation;   
        
        /* W-000811 End */              
        
        System.runAs(u) {

            contact con = new contact();
            con.Phone = '8888888';
            con.LastName = 'Test';
            insert con;

            Account a = new Account();
            a.LastName ='Test';
            a.AccountSource ='Dealer';
            insert a;

            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c =a.id;
            dsr.dealer__Mileage_In__c =12;
            dsr.dealer__RO_Number__c ='111982';
            insert dsr;

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c ='Test';
            dsj.dealer__Labor_Charges__c =12;
            dsj.dealer__Service_Repair_Order__c =dsr.id;
            dsj.dealer__Labor_Type__c='c';
            dsj.dealer__Labor_Rate__c='Test';
            dsj.dealer__Misc_Charges__c=11;
            dsj.dealer__Concern__c='test';
            dsj.dealer__CustomerConcern__c='test';
            dsj.dealer__Correction__c='test';
            dsj.dealer__Op_Code__c='71232';
            //dsj.dealer__Line_Total__c=12;
            dsj.dealer__Parts_Total__c=7;
            dsj.dealer__Service_Type__c='MR';
            dsj.dealer__Line_Number__c=1;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj.dealer__Stat__c='Te';
            dsj.dealer__Technician__c=userinfo.getuserid();
            dsj.dealer__Book_Time__c=11;
            dsj.dealer__Line_Number__c=1;                    
            insert dsj;

            dealer__Parts_Invoice__c dpi = new dealer__Parts_Invoice__c();
            dpi.dealer__Customer_Contact__c =con.id;
            dpi.dealer__Counterman__c=userinfo.getuserid();
            dpi.dealer__Invoice_Number__c ='1';
            dpi.Location__c = ddl.Id;
            insert dpi;

            dealer__Parts_Invoice_Line__c dpl = new dealer__Parts_Invoice_Line__c();
            dpl.dealer__Parts_Invoice__c= dpi.id;
            dpl.Name ='test';
            dpl.dealer__Core__c  =12;
            dpl.dealer__Cost__c=12;
            dpl.dealer__Price__c=12;
            dpl.dealer__Part_Number__c='12';
            dpl.dealer__Quantity_Sold__c=12;
            dpl.dealer__Quantity_Ordered__c =12;
            dpl.dealer__Job_Line__c= dsj.id;
            //dpl.dealer__Service_Job_Line_Number__c=12;
            //dpl.dealer__Extended_Price__c=12;
            dpl.dealer__Part_Description__c='test';
            dpl.dealer__Total_Price__c=12;
            //dpl.dealer__Service_Line_Payment_Method__c='test';
            dpl.dealer__Pay_Type__c='c';
            //dpl.dealer__Service_Job_Line_Number__c=12; 
            dpl.dealer__Service_Repair_Order__c=dsr.id;                  
            insert dpl;

            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'Freight';
            smc.Service_Job_Lines__c  =dsj.id;
            smc.Amount__c =11;
            insert smc;

            ApexPages.StandardController sc = new ApexPages.StandardController(dsr);
            ApexPages.currentPage().getParameters().put('id', dsr.id);

            SROPrint sp = new SROPrint(new ApexPages.StandardController(dsr));
            sp.total_hazmat =12;
            sp.total_shop =12;
            sp.total_freight =13;
            sp.total_hazmat_w=11;
            sp.total_freight_w =1;
            sp.total_payments =1;
            sp.getInvoiceLogo();
            sp.getServiceJobList();
            sp.getServicePartsList(); 
            sp.getMiscList(); 
            sp.getLinesList(); 
            sp.total_hazmat = 10;
            sp.getuserLoc();

            Decimal total_hazmat=sp.total_hazmat;
            Decimal total_shop=sp.total_shop;
            Decimal total_freight=sp.total_freight;
            Decimal total_hazmat_w=sp.total_hazmat_w;
            Decimal total_shop_w=sp.total_shop_w;
            Decimal total_freight_w=sp.total_freight_w;
            Decimal total_sublet_cust=sp.total_sublet_cust;
            Decimal total_sublet_w=sp.total_sublet_w;
            Decimal total_sublet=sp.total_sublet;

            string printDateTime = sp.printDateTime;

        }
    }
}