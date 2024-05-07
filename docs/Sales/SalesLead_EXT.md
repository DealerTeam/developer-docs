---
layout: default
---
# SalesLead_EXT

SalesLead_EXT - Cotnrols interaction wiht the salesup object


**Group** Sales

## Constructors
### `public SalesLead_EXT(ApexPages c)`
---
## Fields

### `public up` → `dealer__Sales_Up__c`


### `public upList` → `List<dealer__Sales_Up__c>`


### `private ddat` → `VINDecoderDataObject`

`TESTVISIBLE` 

### `private sdat` → `VINDEcoderDataObject`

`TESTVISIBLE` 

### `public ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `public OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `public InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `public SelectedStyleId` → `String`


### `public matchEscape` → `Boolean`


### `private duplicateRecords` → `List<sObject>`


### `private isDupFound` → `Boolean`


### `public vd` → `VINDecoder`


---
## Properties

### `public fromCreatePage` → `Boolean`


### `public fromFDPage` → `Boolean`


### `public acctLabel` → `String`


### `public supLabel` → `String`


### `public nomatchstring` → `String`


### `public searchOptions` → `searchUps`


### `public searchContactResults` → `List<Contact>`


### `public searchUpsResults` → `List<dealer__Sales_Up__c>`


### `public searchAccountResults` → `List<Account>`


### `public dms` → `dealer__DMS_Settings__c`


### `public crm` → `dealer__CRMSettings__c`


### `public activeSalesup` → `List<AvaliableSalesUp>`


### `public isMerge` → `Boolean`


### `public vehicleInventory` → `dealer__Vehicle_Inventory__c`


### `public skipSearch` → `Boolean`


### `public fromB2BAccount` → `Boolean`


### `public businessAccountId` → `Id`


### `public hasDuplicateResult` → `Boolean`


### `public serVehicleList` → `List<dealer__Service_Vehicle__c>`


### `public isPersonsAccountsEnabled` → `Boolean`


### `public searchUpCount` → `integer`


### `public searchContactCount` → `integer`


### `public selectedCustomerId` → `Id`


### `public selectedAccountId` → `Id`


### `public searchCustomerSize` → `Integer`


### `public searchAccountSize` → `Integer`


### `public searchUpsSize` → `Integer`


### `public ActiveRecordsCount` → `Integer`


---
## Methods
### `public List<sObject> getDuplicateRecords()`
### `public List<Schema.FieldSetMember> getNewPageFields()`
### `public Boolean getLexPreference()`
### `public List<SelectOption> getBusinessContacts()`
### `public void setSupFieldsFromContact()`
### `public PageReference redirectLex()`

redirectLex - Determines the experience the user is expecting and directs them to the right new page

#### Returns

|Type|Description|
|---|---|
|`PageReference`|pageRefence|


**Notes** based on the users preferences this method is called on page load to direct the user to the right location.

### `public String singleQuotes(String str)`
### `public pageReference salesUpview()`
### `public pageReference customSave()`
### `public PageReference cancel()`

**Method** : Cancel


**Description** : return the user to the cancel page

### `public void searchTradeVIN()`
### `public String getUserName()`
### `public String getUserId()`
### `public dealer__Sales_Up__c getup()`
### `public List<dealer__Sales_Up__c> getUpList()`
### `public PageReference Create()`
### `public PageReference saveDuplicateOverride()`

**Method** SaveOverride

### `public dealer__Sales_Up__c lookUp(String upID)`
### `public PageReference noMatch()`
### `public PageReference attachLead()`
### `public Boolean isBlank(String s)`
### `public PageReference customDoDecode()`

Returns reference to the Service Vehicle version of VIN Decode

#### Returns

|Type|Description|
|---|---|
|`PageReference`|A reference to VINDecodeServiceVehicleStyleSelect.page|


**Author** Mimi Sakarett


**Date** 2016.03.14

### `public void doDecode()`
### `public PageReference decodeTradePage()`
### `public PageReference editTradeVINPage()`
### `public List<VINDecoderDataObject.Style> getModelKeyList()`
### `public VINDecoderDataObject getDecode()`
### `public String getSelectedStyleId()`
### `public void setSelectedStyleId(String SelectedStyleId)`
### `public pageReference mergeRecords()`
### `public string getKeyPrefix()`
### `public String getRecordTypeName()`
### `public dealer__Vehicle_Inventory__c getInventoryVehicle()`
### `public PageReference createInventory()`
### `public PageReference FindFromCreatePage()`
### `public PageReference FindDupesFromFD()`
### `public PageReference FindDupes()`

Checks custom setting to determine whether to use native or non native duplicate catching

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference to SalesUpDuplicateSearch.page|


**Author** Mimi Sakarett


**Date** 2016.02.08

### `public PageReference NonNativeFindDupes()`

Searches existing Accounts and Sales Ups for a match to the current Sales Up.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference to SalesUpDuplicateSearch.page|


**Author** Mimi Sakarett


**Date** 2016.02.08

### `public PageReference NativeFindDupes()`
### `public PageReference CreateSU()`
### `public PageReference NonNativeCreateSU()`
### `public pageReference NativeCreateSU()`
### `public void searchExistingDataSOSL(searchUps searchOptions)`
### `public static List<IdentityApi.caller> lookupCallerId(String sParam)`

`REMOTEACTION`
---
## Classes
### searchUps
#### Constructors
##### `public searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, string firstn, string lastn, string uemail, string uphone, string umobile)`
---
#### Properties

##### `public inFirstName` → `boolean`


##### `public inLastName` → `boolean`


##### `public inEmail` → `boolean`


##### `public inPhone` → `boolean`


##### `public inMobile` → `boolean`


##### `public firstName` → `String`


##### `public lastName` → `String`


##### `public upEmail` → `String`


##### `public upPhone` → `String`


##### `public upMobile` → `String`


---

### SalesUpException

**Inheritance**

SalesUpException


### AvaliableSalesUp
#### Constructors
##### `public AvaliableSalesUp()`
---
#### Properties

##### `public isChecked` → `Boolean`


##### `public counter` → `Integer`


##### `public junctionRecord` → `Sales_up__c`


---

### UpException

**Inheritance**

UpException


---
