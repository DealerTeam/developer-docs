@isTest
private class ADFServiceLayer {
    @TestSetup
    static void makeData() {
        Account a = new Account(Name = 'ABC Solutions');
        insert a;

        Account personAccount = new Account(FirstName = 'Test', LastName = 'Test', PersonEmail = 'tetst@example.com');
        insert personAccount;

        Contact con = (Contact)TestFactory.createSObject(new Contact( AccountId = a.Id, LastName = 'test', FirstName = 'test',
                    Email = 'test@example.com',HomePhone = '8099306664',MobilePhone = '8099306664', External_ID__c = 'newKey'), true);

        dealer__Dealer_Location__c location = new dealer__Dealer_Location__c();
        location.name = 'Test Location';
        location.dealer__Company_Number__c='123';
        location.dealer__City__c='ABSD';
        location.dealer__State__c='NY';
        location.dealer__Postal_Code__c='1234';
        location.dealer__Default_Rate__c = 9.9;
        location.dealer__Warranty_Labor_Rate__c = 85.00;
        location.dealer__Location_Account__c = a.Id;
        upsert location;

        Vehicle_Inventory__c vehInv = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c( Name = 'Test Vehicle Inventory',
                                                                                                                   Model__c = '2014',Stock_Number__c = '2014',VIN__c = '100',Company_Number__c = '123',
                                                                                                                   Year__c = '2014',Make__c = '2014' ), true);

        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Service_Appointment_Sequence_Number__c=2000;
            insert dms;   
        }

        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        crm.dealer__ILM_No_Duplicates__c = true;
        insert crm;
        
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = location.Id, Buyer_Contact__c = con.Id, Desired_Stock_Num__c = vehInv.Id), true);
    }

    @isTest
    static void testADFAPI(){
        Sales_Up__c s = [SELECT Id FROM Sales_Up__c LIMIT 1];

        String testEmail = 'test@example.fake';

        ADFAPI.outputXML(s, testEmail);
    }

    @isTest
    static void testADFAPIwithoutVehicle(){
        Sales_Up__c s = [SELECT Id, Desired_Stock_Num__c FROM Sales_Up__c LIMIT 1];
        s.Desired_Stock_Num__c = null;
        update s;

        String testEmail = 'test@example.fake';

        ADFAPI.outputXML(s, testEmail);
    }

    @isTest
    static void Myunittest(){

    Test.startTest();
    ADFAPI adfInstance = new ADFAPI();
    String customerFirstName = adfInstance.customerFirstName;
    String customerLastName = adfInstance.customerLastName;
    String customerFullName = adfInstance.customerFullName;
    String customerEmail = adfInstance.customerEmail;
    String customerAddressLine1 = adfInstance.customerAddressLine1;
    String customerAddressLine2 = adfInstance.customerAddressLine2;
    String customerCity = adfInstance.customerCity;
    String customerState = adfInstance.customerState;
    String customerZip = adfInstance.customerZip;
    String customerDayPhone = adfInstance.customerDayPhone;
    String customerCellPhone = adfInstance.customerCellPhone;
    String stockNumber = adfInstance.stockNumber;
    String customerEveningPhone = adfInstance.customerEveningPhone;

    //MKS 1-27-16
    String storeLocation = adfInstance.storeLocation;
    User thisUser = [ Select Id from User where Id = :UserInfo.getUserId() ];
    System.runAs( thisUser ){
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
         
        crm.dealer__ILM_No_Duplicates__c = true;
        upsert crm;
        crm = dealer__CRMSettings__c.getInstance();
        adfInstance = new ADFAPI();    

        dealer__IntercompanyLeadRouting__c interRec = new dealer__IntercompanyLeadRouting__c();
        interRec.Name = 'Test Rec';
        interRec.dealer__Company_Number__c = 'ADX';
        interRec.dealer__LocalName__c = 'devadflead';
        interRec.dealer__RoutedEmail__c = 'devadflead@dealerteam.com';

        insert interRec;

        String adfFormat2 = '<adf>'+
        '<prospect>'+
            '<requestdate>2000-03-30T15:30:20-08:0</requestdate>'+
            '<vehicle >'+
                '<year>2009</year>'+
                '<make>Make</make>'+
                '<model>Model</model>'+
                '<stock>6521</stock>'+
                '<finance>'+
                    '<method>Test</method>'+  
                    '<amount type="monthly">100</amount>'+
                    '<amount type="total">1000</amount>'+   
                    '<amount type="downpayment">10</amount>'+                                    
                '</finance>'+
            '</vehicle>'+
            '<customer>'+
                '<contact>'+
                    '<name part="first">First</name>'+
                    '<name part="last">Last</name>'+
                    '<phone>323-223-3322</phone>'+
                    '<email>mahesh.sidhu@diligentitlabs.com</email>'+
                '</contact>'+
            '</customer>'+
            '<vendor>'+
                '<contact>'+
                    '<name part="full">Dealer Name</name>'+
                '</contact>'+
            '</vendor>'+
        '</prospect>'+
        '</adf>';

        adfInstance.parseADF(adfFormat2, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');

       Dom.Document doc = new Dom.Document();
       doc.load(adfFormat2);
       Dom.XMLNode root = doc.getRootElement();
    }  

    Test.stopTest();  
}

@isTest
static void validateParsing(){

    ADFAPI adfInstance = new ADFAPI();
    
    String storeLocation = adfInstance.storeLocation;
    User thisUser = [ Select Id from User where Id = :UserInfo.getUserId() ];
    System.runAs( thisUser ){
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        
        adfInstance = new ADFAPI();
        String adfFormat = '<adf>'+
        '<prospect>'+
            '<requestdate>2000-03-30T15:30:20-08:0</requestdate>'+
            '<vehicle interest="Trade-In">'+
                '<year>2008</year>'+
                '<make>Make</make>'+
                '<model>Model</model>'+
                '<odometer>1234</odometer>'+
                '<comments>test</comments>'+
                '<stock>6521</stock>'+
                '<colorcombination>'+
                    '<exteriorcolor>Test</exteriorcolor>'+
                    '<interiorcolor>Test</interiorcolor>'+                    
                '</colorcombination>'+
                '<finance>'+
                    '<method>Test</method>'+                                    
                '</finance>'+
            '</vehicle>'+
            '<customer>'+
                '<contact>'+    
                    '<name part="full">test</name>'+                
                    '<name part="first">test</name>'+
                    '<name part="last">test</name>'+
                    '<phone>555-223-3322</phone>'+
                    '<email>test@example.com</email>'+
                    '<address>'+
                    '<street>Test Street</street>'+
                    '<city>Newyork</city>'+
                    '<regioncode>22323</regioncode>'+
                    '<postalcode>12332323</postalcode>'+
                    '</address>'+
                '</contact>'+
            '</customer>'+
            '<vendor>'+
                '<contact>'+
                    '<name part="full">Dealer Name</name>'+
                '</contact>'+
            '</vendor>'+
        '</prospect>'+
        '</adf>';

        dealer__IntercompanyLeadRouting__c interRec = new dealer__IntercompanyLeadRouting__c();
        interRec.Name = 'Test Rec';
        interRec.dealer__Company_Number__c = 'ADX';
        interRec.dealer__LocalName__c = 'devadflead';
        interRec.dealer__RoutedEmail__c = 'devadflead@dealerteam.com';

        insert interRec;
    Test.startTest();

        adfInstance.parseADF(adfFormat, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');

        String adfFormat1 = '<adf>'+
        '<prospect>'+
            '<requestdate>2000-03-30T15:30:20-08:0</requestdate>'+
            '<vehicle >'+
                '<year>2012</year>'+
                '<make>Make</make>'+
                '<model>Model</model>'+
                '<odometer>1234</odometer>'+
                '<comments>test</comments>'+
                '<stock>6521</stock>'+
                '<colorcombination>'+
                    '<exteriorcolor>Test</exteriorcolor>'+
                    '<interiorcolor>Test</interiorcolor>'+                    
                '</colorcombination>'+
                '<finance>'+
                    '<method>Test</method>'+                                                         
                '</finance>'+
            '</vehicle>'+
            '<customer>'+
                '<contact>'+                    
                    '<name part="first">First</name>'+
                    '<phone>323-223-3322</phone>'+
                    '<email>abc</email>'+
                    '<address>'+
                    '<street>Test Street</street>'+
                    '<city>Newyork</city>'+
                    '<regioncode>22323</regioncode>'+
                    '<postalcode>12332323</postalcode>'+
                    '</address>'+
                '</contact>'+
            '</customer>'+
            '<vendor>'+
                '<contact>'+
                    '<name part="full">Dealer Name</name>'+
                '</contact>'+
            '</vendor>'+
        '</prospect>'+
        '</adf>';

        adfInstance.parseADF(adfFormat1, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');
        //Run again to catch dupes
        List<Sales_Up__c> sup = [SELECT Id, Name, email__c FROM Sales_Up__c WHERE Email__c = 'test@example.com'];
        system.assert(sup.size() == 1, 'There should be exactly 1 sales up after parsing adf.');

        sup[0].Disposition__c = 'Open';
        update sup;
    Test.stopTest();  

        adfInstance.parseADF(adfFormat1, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');
        adfInstance.assignContact(); //This method cannot be reached within parser if personaccounts are enabled, so we call here for coverage.
                   
    }  

}
    @isTest
    static void validateSalesUpQueueOwnerUtility(){

        Test.startTest();
        ADFAPI adfInstance = new ADFAPI();

        Group g = new Group(Type='Queue', Name='TQueue');
        insert g;

        QueueSObject q = new QueueSObject(SobjectType='dealer__Sales_Up__c', QueueId=g.Id);
        insert q;

        String storeLocation = adfInstance.storeLocation;
        User thisUser = [ Select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs( thisUser ){
            dealer__Dealer_Location__c objLoc = new dealer__Dealer_Location__c(
                                                    name = 'LocT1',
                                                    dealer__SalesUp_Queue__c = 'TQueue',
                                                    dealer__Company_Number__c = 'ADX',
                                                    dealer__City__c = 'Tcity',
                                                    dealer__State__c = 'DT',
                                                    dealer__Postal_Code__c = '110034'
                                                    );
            insert objLoc;
            
            dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
            adfInstance = new ADFAPI();    
            
            String adfFormat = '<adf>'+
            '<prospect>'+
                '<requestdate>2000-03-30T15:30:20-08:0</requestdate>'+
                '<vehicle interest="buy" status="used">'+
                    '<year>2014</year>'+
                    '<make>Acura</make>'+
                    '<model>MDX</model>'+
                    '<trim>SH-AWD w/Tech</trim>'+
                    '<vin>5FRYD4H41EB020156</vin>'+
                    '<transmission>6-Speed Shiftable Automatic</transmission>'+
                    '<stock>EB020156</stock>'+
                    '<colorcombination>'+
                    '<exteriorcolor>Red</exteriorcolor>'+
                    '<interiorcolor>Black</interiorcolor>'+
                    '</colorcombination>'+
                    '<finance>'+
                    '<method>lease</method>'+
                    '<amount type="monthly">300</amount>'+
                    '<amount type="total">33500</amount>'+
                    '<amount type="downpayment">500</amount>'+
                    '</finance>'+
                    '</vehicle>'+
                    '<customer>'+
                    '<contact>'+
                    '<name part="first">ADF6First</name>'+
                    '<name part="last">ADF6Last</name>'+
                    '<email>BuyOnly@adftest6.com</email>'+
                    '<phone type="voice">222-333-6666</phone>'+
                    '<phone type="cellphone">111-222-6666</phone>'+
                    '</contact>'+
                    '<comments>Contact comments test of ADF parser on Buy only sample</comments>'+
                    '</customer>'+
                    '<provider>'+
                    '<name part="full">ElectraMotors.com</name>'+
                    '<service>ElectraMotors</service>'+
                    '</provider>'+
            '</prospect>'+
            '</adf>';

            dealer__IntercompanyLeadRouting__c interRec = new dealer__IntercompanyLeadRouting__c();
            interRec.Name = 'Test Rec';
            interRec.dealer__Company_Number__c = 'ADX';
            interRec.dealer__LocalName__c = 'devadflead';
            interRec.dealer__RoutedEmail__c = 'devadflead@dealerteam.com';

            insert interRec;
            List<contact> c = [select id, name from contact];
            system.assert(c.size() == 2, 'Test expected 2 contacts');
            adfInstance.parseADF(adfFormat, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');

            List<dealer__Sales_Up__c> objSales = [Select id, name, OwnerId from dealer__Sales_Up__c where ownerid=: g.id ];
            system.assert(objSales.size() == 1, 'Failed to create sales up with queue group owner id');

            String adfFormat1 = '<adf>'+
            '<prospect>'+
                '<requestdate>2000-03-30T15:30:20-08:0</requestdate>'+
                '<vehicle >'+
                    '<year>2012</year>'+
                    '<make>Make</make>'+
                    '<model>Model</model>'+
                    '<odometer>1234</odometer>'+
                    '<comments>test</comments>'+
                    '<stock></stock>'+
                    '<colorcombination>'+
                        '<exteriorcolor>Test</exteriorcolor>'+
                        '<interiorcolor>Test</interiorcolor>'+                    
                    '</colorcombination>'+
                    '<finance>'+
                        '<method>Test</method>'+                                                         
                    '</finance>'+
                '</vehicle>'+
                '<customer>'+
                    '<contact>'+                    
                        '<name part="first">First</name>'+
                        '<phone>323-223-3322</phone>'+
                        '<email>abc</email>'+
                        '<address>'+
                        '<street>Test Street</street>'+
                        '<city>Newyork</city>'+
                        '<regioncode>22323</regioncode>'+
                        '<postalcode>12332323</postalcode>'+
                        '</address>'+
                    '</contact>'+
                '</customer>'+
                '<vendor>'+
                    '<contact>'+
                        '<name part="full">Dealer Name</name>'+
                    '</contact>'+
                '</vendor>'+
            '</prospect>'+
            '</adf>';

            adfInstance.parseADF(adfFormat1, 'devadflead@dealerteam.com', 'auctiondirectinternetadx@dealerteam.com');
            adfInstance.assignContact();
            c = [select id, name from contact];
            system.assert(c.size() == 4, 'parsing did not create the expected number of contacts. Dupe catching may have prevented creation.');
                    
        }  

        Test.stopTest();  
    }
}