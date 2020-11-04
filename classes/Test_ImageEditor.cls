@isTest
private class Test_ImageEditor {
    private static testmethod void TestImageUploader() {
 
       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
       Profile prof = [select id from profile where name='system Administrator'];
       User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert usr;
                  
        System.runAs(usr){ 

        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = '27272727';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        insert VI;
        
        ImageEditor ie = new ImageEditor();
        ie.retrieveMediaList();
        ie.NewGuid();
        
        
        dealer__Inventory_Images__c dealerImages = new dealer__Inventory_Images__c();
        dealerImages.dealer__UUID__c = '2e11e96e-c61e-4927-92f5-3874e27272727';
        dealerImages.dealer__Vehicle_Inventory__c = VI.Id;
        insert dealerImages;
        dealer__Inventory_Images__c dealerImagesTwo = new dealer__Inventory_Images__c();
        dealerImagesTwo.dealer__UUID__c = '2e11e96e-c61e-4927-92f5-3874e272727';
        dealerImagesTwo.dealer__Vehicle_Inventory__c = VI.Id;
        insert dealerImagesTwo;
        /*dealer__Inventory_Images__c[] images = [Select Id, dealer__UUID__c, dealer__Vehicle_Inventory__c from dealer__Inventory_Images__c where dealer__UUID__c != null limit 10];
        System.debug(images);*/
        ie.recordId = dealerImages.dealer__Vehicle_Inventory__c;
        ie.getVehicle();
        String jsonImageList = ie.getvehicleImages();
        System.debug(jsonImageList);
        // Test Remote Actions
        String singleMediaItem =    '{"id":"a01E000000PZEIBIA5","uuid":"2e11e96e-c61e-4927-92f5-3874e888ae08","name":"2e11e96e-c61e-4927-92f5-3874e888ae08.png","height":131,"width":200,"mimetype":"image/png","order":8,"thumbnailUrl":"2e11e96e-c61e-4927-92f5-3874e888ae08_thumb.png","pubstat":true}';
        String multItem        =    '[{"id":"a01E000000DsNDmIAN","uuid":"2e11e96e-c61e-4927-92f5-3874e27272727","name":"2e11e96e-c61e-4927-92f5-3874e27272727.png","height":150,"width":171,"mimetype":"image/png","order":0,"thumbnailUrl":"5797269b-ef5c-42bb-949b-487f9ba465fc_thumb.png","pubstat":true},{"id":"a01E000000DsNDmIAN","uuid":"2e11e96e-c61e-4927-92f5-3874e272727","name":"2e11e96e-c61e-4927-92f5-3874e272727.png","height":99,"width":200,"mimetype":"image/png","order":1,"thumbnailUrl":"eb2685e1-92c6-4fe6-94f6-6ea1f99420f6_thumb.png","pubstat":true}]';
        ImageEditor.addInventoryMedia(singleMediaItem);
        ImageEditor.setOrder(multItem);
        ImageEditor.setPublished(dealerImages.dealer__UUID__c); 
        ImageEditor.publishAll(ie.recordId); 
        ImageEditor.deleteInventoryMedia(dealerImages.dealer__UUID__c);

        }   
    }
}