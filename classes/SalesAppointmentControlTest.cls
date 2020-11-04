@isTest
private class SalesAppointmentControlTest {
    
    
    @testSetup static void setupMethod(){
        
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        dms.dealer__SalesAppointmentLinkedEvent__c = true;
        update dms;
        
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User u = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');

        insert u;

        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
            OwnerId = u.Id,
            dealer__Buyer_Contact__c = util.insertContact(),
            dealer__Make__c = 'Tesla',
            dealer__FirstName__c = 'TestFirstName',
            dealer__LastName__c = 'LastName',
            dealer__Latest_Appointment_Date_Time__c = null
        );
        insert sup;

        dealer__Sales_Appointment__c sa = new dealer__Sales_Appointment__c(
            dealer__Assigned_To__c = sup.OwnerId,
            dealer__Customer__c = sup.dealer__Buyer_Contact__c,
            dealer__Sales_Up__c = sup.Id,
            dealer__DateTime__c = DateTime.now(),
            dealer__Notes__c = 'testingtesting123',
            dealer__Appointment_Result__c = 'Show'
            );

        insert sa;
    }

    //Date and Time fields get populated, new Event created, sales up updated
    @isTest static void testInsert(){
        
        dealer__Sales_Up__c supX = [SELECT Id, dealer__In_Store__c, dealer__Latest_Appointment_Date_Time__c,
            dealer__Buyer_Contact__c 
            FROM dealer__Sales_Up__c 
            WHERE dealer__FirstName__c = 'TestFirstName' 
            LIMIT 1];

        dealer__Sales_Appointment__c saX = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];

        //Make sure that the Date and Time fields got populated
        System.assertEquals(saX.dealer__DateTime__c.date(), saX.dealer__Date__c);
        System.assertEquals(saX.dealer__DateTime__c.format('h:mm a'), saX.dealer__Time__c);

        //Make sure an Event got created
        List<Event> e = [SELECT Id, description
            FROM Event
            WHERE WhoId =:supX.dealer__Buyer_Contact__c AND WhatId =:supX.Id];

        System.assertEquals(1, e.size());

        //Make sure that the Sales Up got updated
        System.assertEquals(true, supX.dealer__In_Store__c);
        System.assertEquals(saX.dealer__DateTime__c, supX.dealer__Latest_Appointment_Date_Time__c);
        System.assertEquals('testingtesting123', e[0].description, 'SalesAppointmentControlHandler failed to set event description to sales appt dealer__Notes__c field.');

    }

    //When appt datetime updates -> sales up updates, event updates, appt updates 
    @isTest static void testUpdate(){
        
        dealer__Sales_Appointment__c saX = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c, dealer__Sales_Up__c, dealer__Subject__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];

        dealer__Sales_Up__c oldSup = [SELECT Id, dealer__Latest_Appointment_Date_Time__c
            FROM dealer__Sales_Up__c 
            WHERE dealer__FirstName__c = 'TestFirstName' 
            LIMIT 1];

        Event oldEvent = [SELECT Id, ActivityDateTime, ActivityDate 
            FROM Event 
            WHERE WhatId =:saX.dealer__Sales_Up__c AND Type = 'Sales Appointment' 
            LIMIT 1];
        

        saX.dealer__DateTime__c = Datetime.now().addDays(2);
        saX.dealer__Subject__c = 'Test Subject';
        update saX;

        dealer__Sales_Up__c newSup = [SELECT Id, dealer__Latest_Appointment_Date_Time__c
            FROM dealer__Sales_Up__c 
            WHERE dealer__FirstName__c = 'TestFirstName' 
            LIMIT 1];

        Event newEvent = [SELECT Id, ActivityDateTime, ActivityDate, Subject 
            FROM Event 
            WHERE WhatId =:saX.dealer__Sales_Up__c AND Type = 'Sales Appointment' 
            LIMIT 1];

        //Make sure the Sales Up got updated
        System.assertNotEquals(oldSup.dealer__Latest_Appointment_Date_Time__c, newSup.dealer__Latest_Appointment_Date_Time__c);
        System.assertEquals(saX.dealer__DateTime__c, newSup.dealer__Latest_Appointment_Date_Time__c);

        //Make sure the Event got updated
        System.assertNotEquals(oldEvent.ActivityDateTime, newEvent.ActivityDateTime);
        System.assertNotEquals(oldEvent.ActivityDate, newEvent.ActivityDate);
        System.assertEquals(saX.dealer__DateTime__c, newEvent.ActivityDateTime);
        System.assertEquals(saX.dealer__DateTime__c.date(), newEvent.ActivityDate);
        System.assertEquals(saX.dealer__Subject__c, newEvent.Subject, 'SalesAppointmentControlHandler failed to update the event subject.');
    }

    //When appt is deleted, Event is deleted too.
    @isTest static void testDelete(){
        
        dealer__Sales_Appointment__c saX = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c, dealer__Sales_Up__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];

        delete saX;

        List<Event> e = [SELECT Id, ActivityDateTime, ActivityDate 
            FROM Event 
            WHERE WhatId =:saX.dealer__Sales_Up__c AND Type = 'Sales Appointment'];

        System.assertEquals(0, e.size());
    }

    //Updating an existing Sales Appointment using controller
    @isTest static void testControllerUpdate() {
        
        dealer__Sales_Appointment__c sa = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c, dealer__Sales_Up__c, dealer__Assigned_To__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sa);
        SalesAppointment_EXT sap = new SalesAppointment_EXT(sc);
        sap.Save();

    }

    //Inserting new Sales Appointment using controller
    @isTest static void testControllerInsert(){
        dealer__Sales_Up__c supX = [SELECT Id, dealer__In_Store__c, dealer__Latest_Appointment_Date_Time__c,
            dealer__Buyer_Contact__c, OwnerId 
            FROM dealer__Sales_Up__c 
            WHERE dealer__FirstName__c = 'TestFirstName' 
            LIMIT 1];

        User u = [SELECT Id FROM User WHERE Id =:supX.OwnerId LIMIT 1];

        dealer__Sales_Appointment__c appt = new dealer__Sales_Appointment__c(
            dealer__Date__c = Datetime.now().date(),
            dealer__Time__c = '8:15 PM',
            dealer__Notes__c = 'testingtesting345',
            dealer__Appointment_Result__c = 'Show'
        );

        Test.setCurrentPageReference(new PageReference('Page.SalesAppointment')); 
        System.currentPageReference().getParameters().put('uid', supX.Id);
        System.currentPageReference().getParameters().put('cid', supX.dealer__Buyer_Contact__c);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(appt);

        System.runAs(u){
            SalesAppointment_EXT sap = new SalesAppointment_EXT(sc);
            sap.getUserTimeZone();
            sap.Save();
        } 
        
        dealer__Sales_Appointment__c app = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c, dealer__Sales_Up__c, dealer__Assigned_To__c, dealer__Set_By__c,
            dealer__Customer__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting345'
            LIMIT 1];

        System.assertEquals(u.Id, app.dealer__Assigned_To__c);
        System.assertEquals(u.Id, app.dealer__Set_By__c);
        System.assertEquals(supX.Id, app.dealer__Sales_Up__c);
        System.assertEquals(supX.dealer__Buyer_Contact__c, app.dealer__Customer__c);

    }
    
    /** SalesAppointmentController Tests **/
    @isTest static void testCreateTask(){
        
        dealer__Sales_Appointment__c sa = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];
        
        User u = [Select id From User Where email = 'us.name@vmail.com' Limit 1];
        
        Test.startTest();
        SalesAppointmentController.createTask(u.Id, sa.Id);
        Test.stopTest();
        
        Task t = [Select id, Subject From Task Where OwnerId =: u.id and WhatId =: sa.Id Limit 1];
        
        system.assertEquals('Reschedule Sales Appointment', t.Subject);
        
    }
    
    @isTest static void testGetVehicle(){
        
        dealer__Sales_Appointment__c sa = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];
        
        Test.startTest();
        dealer__Vehicle_Inventory__c vi = SalesAppointmentController.getVehicle(sa.Id);
        Test.stopTest();
        
        system.assert(vi != null);
    }
    
    @isTest static void testGetImages(){
        
        dealer__Sales_Appointment__c sa = [SELECT Id, dealer__Date__c, dealer__Time__c, dealer__Vehicle__c,
            dealer__DateTime__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];
        
        List<dealer__Inventory_Images__c> images = new List<dealer__Inventory_Images__c>();
        Test.startTest();
        images = SalesAppointmentController.getImages(sa.dealer__Vehicle__c);
        Test.stopTest();
        
        system.assertEquals(0, images.size());
    }
    
    @isTest static void testGetEquipment(){
        
       dealer__Sales_Appointment__c sa = [SELECT Id, dealer__Date__c, dealer__Time__c, 
            dealer__DateTime__c
            FROM dealer__Sales_Appointment__c 
            WHERE dealer__Notes__c = 'testingtesting123'
            LIMIT 1];
        
        dealer__Vehicle_Inventory__c vi = SalesAppointmentController.getVehicle(sa.Id);
        
        List<dealer__Equipment__c> equipment = new List<dealer__Equipment__c>();
        
        Test.startTest();
        equipment = SalesAppointmentController.getEquipment(vi.dealer__Service_Vehicle__c);
        Test.stopTest();
        
        system.assertEquals(0, equipment.size());
    }
   /** End SalesAppointmentController Tests **/

}