@isTest
public class SalesUpControlTest {
    
    public static List<dealer__Sales_Up__c> salesUpList;
    public static User u;
    
    static void init(){

        salesUpList = new List<dealer__Sales_Up__c >();            
        salesUpList.add(new dealer__Sales_Up__c (dealer__FirstName__c  = 'FirstName', dealer__LastName__c  = 'LastName',
                                                 dealer__Lead_Date__c = System.today(), dealer__Lead_Type__c = 'Phone', 
                                                 dealer__Lead_Status__c = 'Untouched'));      
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        u = new User(Alias = 'standt', Email='standardusertest@testorguy.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, Division='DT1',
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorguy.com');
        
    }
    
    @isTest static void testCreateSVWithAcctContact() {
		
        //Create Person Account
        RecordType rt = [SELECT id, Name from RecordType where Name = 'Person Account' LIMIT 1];      
        Account a = new Account(RecordType = rt, FirstName = 'FirstName', LastName = 'LastName');
        insert a;          
        Account acc = [SELECT id FROM Account WHERE FirstName = 'FirstName' AND LastName = 'LastName' LIMIT 1];
        
        //Create Contact
        Contact c = new Contact(FirstName = 'CFirstName', LastName = 'CLastName', Phone = '55555555', MobilePhone = '628777000', 
                                MailingStreet = 'Kosciuszko  Street', MailingCity = 'New York', 
                                MailingState = 'NY', MailingPostalCode = '11221');
        insert c;  
        
        Contact contact = [SELECT id, FirstName, LastName, Phone, MobilePhone, Email, 
                           MailingStreet, MailingCity, MailingState, MailingPostalCode
                           FROM Contact WHERE FirstName = 'CFirstName' AND LastName = 'CLastName' LIMIT 1];

        init();
        
        salesUpList[0].dealer__Buyer_Contact__c = contact.Id;
        salesUpList[0].dealer__Customer_Account__c = acc.Id;
        salesUpList[0].dealer__Trade_VIN__c = '19UYA42401A009561';
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
        List<dealer__Service_Vehicle__c> sv = [SELECT id, dealer__Veh_Owner__c, dealer__Veh_Owner__r.FirstName, dealer__Veh_Owner__r.LastName,  
                                               dealer__Veh_Owner_Contact__c, dealer__Veh_Owner_Contact__r.FirstName, dealer__Veh_Owner_Contact__r.LastName  
                                               FROM dealer__Service_Vehicle__c 
                                               WHERE dealer__VIN__c =: salesUpList[0].dealer__Trade_VIN__c LIMIT 1];
        
        system.assert(true, sv.size() > 0);
        system.assertEquals('FirstName LastName', sv[0].dealer__Veh_Owner__r.FirstName + ' '+ sv[0].dealer__Veh_Owner__r.LastName);
        system.assertEquals('CFirstName CLastName', sv[0].dealer__Veh_Owner_Contact__r.FirstName + ' '+ sv[0].dealer__Veh_Owner_Contact__r.LastName);

    }
 
	@isTest static void testUpdateSVAcctContact() {
		
        //Create Service Vehicle
        dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c (dealer__VIN__c  = '1FMCU9J98FUB31953', 
                                                                       dealer__Year__c = '2017', dealer__Make__c = 'Nissan',
                                                                       dealer__Carline__c = 'Pathfinder');
        
        insert sv;
        
        //Create Person Account
        RecordType rt = [SELECT id, Name from RecordType where Name = 'Person Account' LIMIT 1];      
        Account a = new Account(RecordType = rt, FirstName = 'FirstName', LastName = 'LastName');
        insert a;          
        Account acc = [SELECT id FROM Account WHERE FirstName = 'FirstName' AND LastName = 'LastName' LIMIT 1];
        
        //Create Contact
        Contact c = new Contact(FirstName = 'CFirstName', LastName = 'CLastName', Phone = '55555555', MobilePhone = '628777000', 
                                MailingStreet = 'Kosciuszko  Street', MailingCity = 'New York', 
                                MailingState = 'NY', MailingPostalCode = '11221');
        insert c;  
        
        Contact contact = [SELECT id, FirstName, LastName, Phone, MobilePhone, Email, 
                           MailingStreet, MailingCity, MailingState, MailingPostalCode
                           FROM Contact WHERE FirstName = 'CFirstName' AND LastName = 'CLastName' LIMIT 1];

        init();
        
        salesUpList[0].dealer__Buyer_Contact__c = contact.Id;
        salesUpList[0].dealer__Customer_Account__c = acc.Id;
        salesUpList[0].dealer__Trade_VIN__c = '1FMCU9J98FUB31953';
        salesUpList[0].dealer__VIN__c = '1FMCU9J98FUB31953';
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
        List<dealer__Service_Vehicle__c> svs = [SELECT id, dealer__Veh_Owner__c, dealer__Veh_Owner__r.FirstName, dealer__Veh_Owner__r.LastName,  
                                               dealer__Veh_Owner_Contact__c, dealer__Veh_Owner_Contact__r.FirstName, dealer__Veh_Owner_Contact__r.LastName  
                                               FROM dealer__Service_Vehicle__c 
                                               WHERE dealer__VIN__c =: salesUpList[0].dealer__Trade_VIN__c LIMIT 1];
        
        system.assert(true, svs.size() > 0);
        system.assertEquals('FirstName LastName', svs[0].dealer__Veh_Owner__r.FirstName + ' '+ svs[0].dealer__Veh_Owner__r.LastName);
        system.assertEquals('CFirstName CLastName', svs[0].dealer__Veh_Owner_Contact__r.FirstName + ' '+ svs[0].dealer__Veh_Owner_Contact__r.LastName);

    }
    
    @isTest static void testCreateSUPWithContact() {
		
        //Create Contact
        Contact c = new Contact(FirstName = 'CFirstName', LastName = 'CLastName', Phone = '55555555', MobilePhone = '628777000', 
                                MailingStreet = 'Kosciuszko  Street', MailingCity = 'New York', 
                                MailingState = 'NY', MailingPostalCode = '11221');
        insert c;  
        
        Contact contact = [SELECT id, FirstName, LastName, Phone, MobilePhone, Email, 
                           MailingStreet, MailingCity, MailingState, MailingPostalCode
                           FROM Contact WHERE FirstName = 'CFirstName' AND LastName = 'CLastName' LIMIT 1];

        init();
        
        salesUpList[0].dealer__Buyer_Contact__c = contact.Id;
        salesUpList[0].dealer__Trade_VIN__c = '19UYA42401A009561';
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
  
        List<dealer__Sales_Up__c> nup = [SELECT id, dealer__FirstName__c, dealer__LastName__c, dealer__Phone__c,
                                         dealer__Mobile__c, dealer__Email__c, dealer__Mailing_Street__c,
                                         dealer__Mailing_City__c, dealer__Mailing_State__c, dealer__Mailing_Zip__c 
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Buyer_Contact__c =: contact.Id LIMIT 1];
        
        system.assert(true, nup.size() > 0);
        system.assertEquals(nup[0].dealer__FirstName__c, contact.FirstName);
        system.assertEquals(nup[0].dealer__LastName__c, contact.LastName);
		system.assertEquals(nup[0].dealer__Phone__c, contact.Phone);
		system.assertEquals(nup[0].dealer__Mobile__c, contact.MobilePhone);
		system.assertEquals(nup[0].dealer__Email__c, contact.Email);
		system.assertEquals(nup[0].dealer__Mailing_Street__c, contact.MailingStreet);
		system.assertEquals(nup[0].dealer__Mailing_City__c, contact.MailingCity);
		system.assertEquals(nup[0].dealer__Mailing_State__c, contact.MailingState);
		system.assertEquals(nup[0].dealer__Mailing_Zip__c, contact.MailingPostalCode);
       
    }
   
    @isTest static void testUpdateSUPWithContact() {
        //Create Contacts
        List<Contact> contacts = new List<Contact>();
        for(Integer i= 0; i<2; i++){
            
            Contact c = new Contact(FirstName = 'CFirstName'+i, LastName = 'CLastName'+i, Phone = '55555555'+i, MobilePhone = '628777000'+i, 
                                    MailingStreet = 'Kosciuszko  Street', MailingCity = 'New York', 
                                    MailingState = 'NY', MailingPostalCode = '11221');
            contacts.add(c);
        }
        insert contacts;  
        
        List<Contact> cts = [SELECT id, FirstName, LastName, Phone, MobilePhone, Email, 
                           MailingStreet, MailingCity, MailingState, MailingPostalCode
                           FROM Contact WHERE FirstName LIKE : 'CFirstName%' AND LastName LIKE : 'CLastName%' LIMIT 2];
		
        init();
        
        if(cts[0].FirstName == 'CFirstName0'){
            salesUpList[0].dealer__Buyer_Contact__c = cts[0].Id;
        }else{
           salesUpList[0].dealer__Buyer_Contact__c = cts[1].Id;
        }
        
        insert salesUpList;
        
        dealer__Sales_Up__c nup = [SELECT id, dealer__FirstName__c, dealer__LastName__c, dealer__Phone__c,
                                         dealer__Mobile__c, dealer__Email__c, dealer__Mailing_Street__c,
                                         dealer__Mailing_City__c, dealer__Mailing_State__c, dealer__Mailing_Zip__c,
                                         dealer__Buyer_Contact__c
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Buyer_Contact__c =:salesUpList[0].dealer__Buyer_Contact__c LIMIT 1];
        
        if(cts[0].FirstName == 'CFirstName1'){
            nup.dealer__Buyer_Contact__c = cts[0].Id;
        }else{
           nup.dealer__Buyer_Contact__c = cts[1].Id;
        }
        
        Test.startTest();
        update nup;
        Test.stopTest();
  		
        Contact ac = [SELECT id, FirstName, LastName, Phone, MobilePhone, Email, 
                           MailingStreet, MailingCity, MailingState, MailingPostalCode
                           FROM Contact WHERE FirstName = 'CFirstName1' AND LastName ='CLastName1' LIMIT 1];
        
        List<dealer__Sales_Up__c> nups = [SELECT id, dealer__FirstName__c, dealer__LastName__c, dealer__Phone__c,
                                         dealer__Mobile__c, dealer__Email__c, dealer__Mailing_Street__c,
                                         dealer__Mailing_City__c, dealer__Mailing_State__c, dealer__Mailing_Zip__c,
                                          dealer__Buyer_Contact__c
                                         FROM dealer__Sales_Up__c 
                                         WHERE id =: nup.Id LIMIT 1];
        
        system.assert(true, nups.size() > 0);
        system.assertEquals(nups[0].dealer__FirstName__c, ac.FirstName);
        system.assertEquals(nups[0].dealer__LastName__c, ac.LastName);
		system.assertEquals(nups[0].dealer__Phone__c, ac.Phone);
		system.assertEquals(nups[0].dealer__Email__c, ac.Email);
		system.assertEquals(nups[0].dealer__Mailing_Street__c, ac.MailingStreet);
		system.assertEquals(nups[0].dealer__Mailing_City__c, ac.MailingCity);
		system.assertEquals(nups[0].dealer__Mailing_State__c, ac.MailingState);
		system.assertEquals(nups[0].dealer__Mailing_Zip__c, ac.MailingPostalCode);
        
    }
    
    @isTest static void testUpdateSUPWithAccount() {
        //Create Account
        List<Account> accounts = new List<Account>();
        for(Integer i= 0; i<2; i++){
            
            Account a = new Account(FirstName = 'AFirstName'+i, LastName = 'ALastName'+i, 
                                    PersonMobilePhone = '628777000'+i, 
                                    PersonMailingStreet = 'Kosciuszko  Street', PersonMailingCity = 'New York', 
                                    PersonMailingState = 'NY', PersonMailingPostalCode = '11221');
            accounts.add(a);
        }
        insert accounts;  
        
        List<Account> accts = [SELECT id, FirstName, LastName, Phone, PersonMobilePhone,  
                           PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode
                           FROM Account WHERE FirstName LIKE : 'AFirstName%' AND LastName LIKE : 'ALastName%' LIMIT 2];
		
        init();
        
        if(accts[0].FirstName == 'AFirstName0'){
            salesUpList[0].dealer__Customer_Account__c = accts[0].Id;
        }else{
           salesUpList[0].dealer__Customer_Account__c = accts[1].Id;
        }
        
        insert salesUpList;
        
        dealer__Sales_Up__c nup = [SELECT id, dealer__FirstName__c, dealer__LastName__c, dealer__Phone__c,
                                         dealer__Mobile__c, dealer__Email__c, dealer__Mailing_Street__c,
                                         dealer__Mailing_City__c, dealer__Mailing_State__c, dealer__Mailing_Zip__c,
                                         dealer__Buyer_Contact__c
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Buyer_Contact__c =:salesUpList[0].dealer__Buyer_Contact__c LIMIT 1];
        
        if(accts[0].FirstName == 'CFirstName1'){
            nup.dealer__Customer_Account__c = accts[0].Id;
        }else{
           nup.dealer__Customer_Account__c = accts[1].Id;
        }
        
        Test.startTest();
        update nup;
        Test.stopTest();
  		
        Account ac = [SELECT id, FirstName, LastName, PersonMobilePhone, 
                           PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode
                           FROM Account WHERE FirstName = 'AFirstName1' AND LastName ='ALastName1' LIMIT 1];
        
        List<dealer__Sales_Up__c> nups = [SELECT id, dealer__FirstName__c, dealer__LastName__c, dealer__Phone__c,
                                         dealer__Mobile__c, dealer__Email__c, dealer__Mailing_Street__c,
                                         dealer__Mailing_City__c, dealer__Mailing_State__c, dealer__Mailing_Zip__c,
                                          dealer__Buyer_Contact__c
                                         FROM dealer__Sales_Up__c 
                                         WHERE id =: nup.Id LIMIT 1];
        
        system.assert(true, nups.size() > 0);
        system.assertEquals(nups[0].dealer__FirstName__c, ac.FirstName);
        system.assertEquals(nups[0].dealer__LastName__c, ac.LastName);
		system.assertEquals(nups[0].dealer__Mobile__c, ac.PersonMobilePhone);
		system.assertEquals(nups[0].dealer__Mailing_Street__c, ac.PersonMailingStreet);
		system.assertEquals(nups[0].dealer__Mailing_City__c, ac.PersonMailingCity);
		system.assertEquals(nups[0].dealer__Mailing_State__c, ac.PersonMailingState);
		system.assertEquals(nups[0].dealer__Mailing_Zip__c, ac.PersonMailingPostalCode);
        
    }
    
    @isTest static void testCreateSUPWithSalesperson(){
        
        init();
		insert u;
        User usr = [SELECT Id, Division FROM USER where email = 'standardusertest@testorguy.com' LIMIT 1];
        salesUpList[0].dealer__Salesperson_1__c = usr.Id;
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
		List<dealer__Sales_Up__c> nups = [SELECT id, dealer__Company_Number__c, dealer__Lead_Status__c 
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Salesperson_1__c =: usr.Id LIMIT 1];
	        
        system.assert(true, nups.size() > 0);
        system.assertEquals(u.Division, nups[0].dealer__Company_Number__c);
        system.assertEquals('Open', nups[0].dealer__Lead_Status__c);        
    }
    
    @isTest static void testCreateSUPWithSalesperson2(){
        
        init();
        u.Alias = 'standt2';
        u.Email='standardusertest2@testorguy.com'; 
        u.LastName='Testing2';
        u.UserName='standarduser2@testorguy.com';
		insert u;
        User usr = [SELECT Id, Division FROM USER where email = 'standardusertest2@testorguy.com' LIMIT 1];
        salesUpList[0].dealer__Salesperson_2__c = usr.Id;
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
		List<dealer__Sales_Up__c> nups = [SELECT id, dealer__Company_Number__c, dealer__Lead_Status__c 
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Salesperson_2__c =: usr.Id LIMIT 1];
	        
        system.assertEquals('Open', nups[0].dealer__Lead_Status__c);        
    }
    
    @isTest static void testCreateSUPWithCarDeal(){
        
        init();
        //Set SalesPerson
        insert u;
        User usr = [SELECT Id, Division FROM USER where email = 'standardusertest@testorguy.com' LIMIT 1];
        salesUpList[0].dealer__Salesperson_1__c = usr.Id;
        
        //Create Deal
        dealer__Deal__c deal = new dealer__Deal__c(Name = 'Test Deal', dealer__Deal_ID__c = '1234', dealer__Status__c = 'Open');
        try{ 
            insert deal;
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
        dealer__Deal__c d = [SELECT Id, Name, dealer__Status__c, dealer__Sales_Lead__c FROM dealer__Deal__c where dealer__Deal_ID__c = '1234' LIMIT 1];   
        
        salesUpList[0].dealer__Car_Deal__c = d.Id;
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
        List<dealer__Sales_Up__c> nups = [SELECT id, dealer__Lead_Status__c, dealer__Car_Deal__c 
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Car_Deal__c =: d.Id LIMIT 1];
        
        dealer__Deal__c dl = [SELECT Id, Name, dealer__Status__c, dealer__Sales_Lead__c FROM dealer__Deal__c where id =: d.Id LIMIT 1];

        //System.assertEquals(nups[0].Id, dl.dealer__Sales_Lead__c);
        System.assertEquals('Open', nups[0].dealer__Lead_Status__c);
        
    } 
 
    @isTest static void testGetVehicleInventoryByStock() {

        //Create Vehicle Inventory
        dealer__Vehicle_Inventory__c vi = new dealer__Vehicle_Inventory__c(
        							dealer__Year__c = '2017', 
                                    dealer__VIN__c = '4V1VDBPE3SN729902',
            					    dealer__Make__c = 'Honda',
            						dealer__Model__c = 'Civic',
                                    dealer__In_Stock__c = true,
            						dealer__Stock_Number__c = '27',
									dealer__Purchase_Date__c = System.today());
        
        insert vi;
        
        dealer__Vehicle_Inventory__c vin = [SELECT d.Id, d.dealer__Year__c, 
                                    d.dealer__VIN__c, d.dealer__Trim_Level__c, 
                                    d.dealer__Model__c, d.dealer__Make__c, d.dealer__In_Stock__c  
                                    FROM dealer__Vehicle_Inventory__c d 
                                    WHERE d.dealer__VIN__c = '4V1VDBPE3SN729902' LIMIT 1];
        
        init(); 
        salesUpList[0].dealer__Desired_Stock_Num__c = vin.Id;
        
        Test.startTest();
        insert salesUpList;

        List<dealer__Sales_Up__c> nup = [SELECT id, dealer__Year_High__c, dealer__Make__c, dealer__Model__c
                                               FROM dealer__Sales_Up__c 
                                               WHERE dealer__Desired_Stock_Num__c =: vin.Id LIMIT 1];
        
                         
        Test.stopTest();
        system.assert(true, nup.size() > 0);        
        system.assertEquals(nup[0].dealer__Year_High__c, vin.dealer__Year__c);
 		system.assertEquals(nup[0].dealer__Make__c, vin.dealer__Make__c);
		system.assertEquals(nup[0].dealer__Model__c, vin.dealer__Model__c);
        
    }
    
     @isTest static void testDesiredVehicle() {

        //Create Vehicle Inventory
        dealer__Vehicle_Inventory__c vi = new dealer__Vehicle_Inventory__c(
        							dealer__Year__c = '2017', 
                                    dealer__VIN__c = '4V1VDBPE3SN729902',
            					    dealer__Make__c = 'Honda',
            						dealer__Model__c = 'Civic',
                                    dealer__In_Stock__c = true,
            						dealer__Stock_Number__c = '27',
									dealer__Purchase_Date__c = System.today());
        
        insert vi;
        
        dealer__Vehicle_Inventory__c vin = [SELECT d.Id, d.dealer__Year__c, 
                                    d.dealer__VIN__c, d.dealer__Trim_Level__c, 
                                    d.dealer__Model__c, d.dealer__Make__c, d.dealer__In_Stock__c  
                                    FROM dealer__Vehicle_Inventory__c d 
                                    WHERE d.dealer__VIN__c = '4V1VDBPE3SN729902' LIMIT 1];
        
        init(); 
        salesUpList[0].dealer__Desired_Stock_Num__c = vin.Id;
        salesUpList[0].dealer__Year_High__c = '2017';                                     
        salesUpList[0].dealer__Make__c = 'Honda';
        salesUpList[0].dealer__Model__c = 'Civic';
        
      
        insert salesUpList;

        List<dealer__Sales_Up__c> nup = [SELECT id, dealer__Year_High__c, dealer__Make__c, dealer__Model__c
                                               FROM dealer__Sales_Up__c 
                                               WHERE dealer__Desired_Stock_Num__c =: vin.Id LIMIT 1];
        
                         
        //Create Desired Vehicle
        dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c(
        							dealer__Sales_Up__c = nup[0].Id, dealer__Year__c = nup[0].dealer__Year_High__c,
        							dealer__Make__c = nup[0].dealer__Make__c, dealer__Model__c = nup[0].dealer__Model__c,
        							dealer__Vehicle_Inventory__c = vin.Id);
        
        insert dv;
        salesUpList[0].dealer__Lead_Type__c = 'Walk-in';
        Test.startTest();
        update salesUpList;
        Test.stopTest();
        system.assert(true, nup.size() > 0);
        
    }
    
    @isTest static void testSetPostSaleBeBack(){
        
        init();
        salesUpList[0].dealer__First_Store_Visit_Date__c = System.today();
        salesUpList[0].dealer__Last_Store_Visit_Date__c = System.today().addDays(1);
        salesUpList[0].dealer__Lead_Status__c = 'Sold';
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
        List<dealer__Sales_Up__c> nups = [SELECT id, dealer__Lead_Status__c, dealer__Post_Sale__c, dealer__Be_Back__c 
                                         FROM dealer__Sales_Up__c 
                                         WHERE dealer__Lead_Status__c = 'Sold' LIMIT 1];
        
        System.assert(nups[0].dealer__Post_Sale__c);
		System.assert(nups[0].dealer__Be_Back__c);
    }
    
    @isTest static void testLocations(){
        
        dealer__Dealer_Location__c l = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__Company_Number__c = 'DT1',
                                                                     dealer__Street__c	= 'Street', dealer__City__c = 'New York',
                                                                     dealer__State__c	= 'NY', dealer__Postal_Code__c = '11216',
                                                                     dealer__Tax_Misc__c = 'All');
        insert l;
        init();
        insert u;
        User usr = [SELECT Id, Division FROM USER where email = 'standardusertest@testorguy.com' LIMIT 1];
        salesUpList[0].OwnerId = usr.Id;
        
        Test.startTest();
        insert salesUpList;
        Test.stopTest();
        
        dealer__Dealer_Location__c loc = [Select id FROM dealer__Dealer_Location__c 
                                          WHERE Name = 'Test Location'
                                          LIMIT 1];
        
        dealer__Sales_Up__c nup = [SELECT id, dealer__Store_Location__c
                                         FROM dealer__Sales_Up__c 
                                         WHERE OwnerId =: usr.Id LIMIT 1];
        
        System.assertEquals(loc.Id, nup.dealer__Store_Location__c);
        
        
    }
}