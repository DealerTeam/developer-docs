@isTest
public  class VINDecoder_EXT_Tech_TC{

static testmethod void MyunitTest() {

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

        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }
        dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Assign_Stock_Number__c = true;
            dms.dealer__Assign_Stock_Number_by_Sequence__c = false;
            insert dms; 
        }
        dealer__Custom_Equipment__c dtm = new dealer__Custom_Equipment__c();
        dtm.dealer__Category__c='Test';
        dtm.dealer__Description__c='Test';
        insert dtm;
        
         List<dealer__Custom_Equipment__c> dtml = new List<dealer__Custom_Equipment__c>();
        dtml.add(dtm);
        
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT101',
                                                dealer__Year__c='2012'
                                            );
                                            
        insert inv;
        
        dealer__Vehicle_Equipment__c vehicleEquipment = new dealer__Vehicle_Equipment__c();
        vehicleEquipment.dealer__Vehicle_Inventory__c = inv.Id;
        insert vehicleEquipment;
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
        VINDecoder_EXT_Tech controller = new VINDecoder_EXT_Tech(sc);
        
        controller.vd.DecodeVIN(inv.VIN__c);
        VINDecoderDataObject.DecodeData r = controller.vd.decodeData;

        controller.setSelectedStyleId('18163');
        controller.doDecodePage();
        controller.editPage();
        
        controller.getDecode();
        dms.dealer__Assign_Stock_Number_by_Sequence__c = true;
        dms.dealer__Stock_Number_Current_Index__c = 1;
        update dms;
         controller.doDecodePage();
        dms.dealer__Assign_Stock_Number_by_Sequence__c= True;
        dms.dealer__Assign_Stock_Number__c= True;
        update dms;
         controller.doDecodePage();
        controller.getDecode();
        controller.getModelKeyList();
        String styleIDreturned = controller.getSelectedStyleId();
        System.assertEquals(controller.SelectedStyleId, styleIDreturned);
        controller.vd.StyleDat(controller.SelectedStyleId);
        
        controller.setSelectedStyleId('18163');
        controller.vd.SelectedStyle('18163');
        controller.getEngines();
        controller.getEngineSelect();
        controller.getTransmissions();
        controller.getTransmissionSelect();
        controller.Save();
        controller.veh.Id =null;
        controller.Save();
        controller.getInstalledEquipment();
        controller.skipVinDecode();
        }
    }
}