@isTest
public class InventoryMediaAPITest {
    @isTest static void testInventoryMediaServiceAPI(){
        Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.Model__c = 'Civic';
        VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
        VI.VIN__c = '5TDYK3DCXBS075856';
        VI.Company_Number__c = 'RD1';
        VI.Year__c = '2014';
        VI.Make__c = 'Honda';
        VI.In_Stock__c = true;
        insert VI;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InventoryMediaServiceMockCallout());
        RestRequest request = new RestRequest();
        RestContext.request = request;
        RestContext.response = new System.RestResponse();
        request.requestUri = '/VehicleInventory/Media/'+VI.Stock_Number__c;
        request.httpMethod = 'POST';
        
        List<InventoryMediaService.Image> images = new List<InventoryMediaService.Image>();
        InventoryMediaService.Image i = new InventoryMediaService.Image();
        i.imageUrl = 'https://sandbox-vehicle-images.s3.amazonaws.com/88c9d490-4d37-11ea-86d2-ed75d1141405_thumb.jpeg';
        InventoryMediaService.storeMedia(images);
        InventoryMediaService.getImages();
        Test.stopTest();
    }

    @isTest
    static void testGetImages()
    {
        Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.Model__c = 'Civic';
        VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
        VI.VIN__c = '5TDYK3DCXBS075856';
        VI.Company_Number__c = 'RD1';
        VI.Year__c = '2014';
        VI.Make__c = 'Honda';
        VI.In_Stock__c = true;
        insert VI;

        Account a = new Account(FirstName = 'TestFirst', LastName = 'TestLast');
        insert a;

        Sales_Up__c s = new Sales_Up__c(Customer_Account__c = a.Id, Desired_Stock_Num__c = vi.Id);
        insert s;

        List<Inventory_Images__c> images = InventoryMediaController.getImages(vi.Id);

        Sales_Up__c relatedSup = (Sales_Up__c)InventoryMediaController.getRelatedVehicleId(s.Id, 'Desired_Stock_Num__c');

        
    }
}