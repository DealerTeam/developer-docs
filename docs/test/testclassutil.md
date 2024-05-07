---
layout: default
---
# TestClassUtil



**Group** Test

## Fields

### `private serviceVehicleId` → `String`


---
## Methods
### `global String insertStdOpcode()`
### `global String insertServiceJob()`
### `global String insertForm()`
### `global String insertPartsKit()`
### `global String insertWeOwe()`
### `global String insertWeOweLines()`
### `global String insertAccount()`
### `global String insertContact()`
### `global static Id createLocation()`
### `global static dealer__Dealer_Location__c insertDealerLocation(String companyNumber, String companyName)`
### `public static void createUserSettings(Id locationId, list<User> users)`

creates user ERP Settings for test methods.

### `global String insertPartsInvoice()`
### `global static dealer__Parts_Master__c insertPartsMaster()`
### `global static dealer__Parts_Inventory__c insertPartInventory(Id master, Id location)`
### `global static dealer__Purchase_Order__c insertPartsPO(Id invnetoryId)`
### `global String insertServiceRepairOrder()`
### `global String insertServiceVehicle()`
### `global String insertInspectionReport()`
### `global String insertServiceAppointment()`
### `global void insertDMSSettings()`
### `global void insertVINDecoderSetup()`

`DEPRECATED`
### `global void insertCRMSettings()`
### `global void insertCDMSettings()`
### `global String insertVehicleInventory()`
### `global String insertRentalRate()`
### `global String insertSalesup()`
### `global String insertCarDeal()`
### `global dealer__Deal__c insertCarDealWithLocation()`
### `global static String generateRandomString(Integer len)`

GenerateRandomString used for filling unique fields in test methods

#### Parameters

|Param|Description|
|---|---|
|`len`|- length of the generated string|

#### Returns

|Type|Description|
|---|---|
|`String`|return - randomized string|

---
