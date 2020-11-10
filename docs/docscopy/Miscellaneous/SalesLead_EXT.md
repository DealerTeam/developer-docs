---
layout: default
---
# SalesLead_EXT class

 SalesLead_EXT - Cotnrols interaction wiht the salesup object

---
## Constructors
### `SalesLead_EXT(ApexPages.StandardController c)`
---
## Properties

### `ActiveRecordsCount` → `Integer`

### `InstalledEquipment` → `List<VinDecoderAPI.`

### `ModelKeyList` → `List<VINDecoderDataObject.Style>`

### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`

### `SelectedStyleId` → `String`

### `acctLabel` → `String`

### `activeSalesup` → `List<AvaliableSalesUp>`

### `businessAccountId` → `Id`

### `crm` → `dealer__CRMSettings__c`

### `dms` → `dealer__DMS_Settings__c`

### `fromB2BAccount` → `Boolean`

### `fromCreatePage` → `Boolean`

### `fromFDPage` → `Boolean`

### `hasDuplicateResult` → `Boolean`

### `isMerge` → `Boolean`

### `isPersonsAccountsEnabled` → `Boolean`

### `matchEscape` → `Boolean`

### `nomatchstring` → `String`

### `searchAccountResults` → `List<Account>`

### `searchAccountSize` → `Integer`

### `searchContactCount` → `integer`

### `searchContactResults` → `List<Contact>`

### `searchCustomerSize` → `Integer`

### `searchOptions` → `searchUps`

### `searchUpCount` → `integer`

### `searchUpsResults` → `List<dealer__Sales_Up__c>`

### `searchUpsSize` → `Integer`

### `selectedAccountId` → `Id`

### `selectedCustomerId` → `Id`

### `serVehicleList` → `List<dealer__Service_Vehicle__c>`

### `skipSearch` → `Boolean`

### `supLabel` → `String`

### `up` → `dealer__Sales_Up__c`

### `upList` → `List<dealer__Sales_Up__c>`

### `vd` → `VINDecoder`

### `vehicleInventory` → `dealer__Vehicle_Inventory__c`

---
## Methods
### `Create()` → `PageReference`
### `CreateSU()` → `PageReference`
### `FindDupes()` → `PageReference`

Checks custom setting to determine whether to use native or non native duplicate catching

### `FindDupesFromFD()` → `PageReference`
### `FindFromCreatePage()` → `PageReference`
### `NativeCreateSU()` → `pageReference`
### `NativeFindDupes()` → `PageReference`
### `NonNativeCreateSU()` → `PageReference`
### `NonNativeFindDupes()` → `PageReference`

Searches existing Accounts and Sales Ups for a match to the current Sales Up.

### `attachLead()` → `PageReference`
### `cancel()` → `PageReference`

: return the user to the cancel page

### `createInventory()` → `PageReference`
### `customDoDecode()` → `PageReference`

Returns reference to the Service Vehicle version of VIN Decode

### `customSave()` → `pageReference`

: Method to update the salesUp record for SalesupSave page.

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `decodeTradePage()` → `PageReference`
### `doDecode()` → `void`
### `editTradeVINPage()` → `PageReference`
### `getBusinessContacts()` → `List<SelectOption>`
### `getDecode()` → `VINDecoderDataObject.DecodeData`
### `getDuplicateRecords()` → `List<sObject>`
### `getInventoryVehicle()` → `dealer__Vehicle_Inventory__c`
### `getKeyPrefix()` → `string`
### `getLexPreference()` → `Boolean`
### `getModelKeyList()` → `List<VINDecoderDataObject.Style>`
### `getNewPageFields()` → `List<Schema.FieldSetMember>`
### `getRecordTypeName()` → `String`
### `getSelectedStyleId()` → `String`
### `getUpList()` → `List<dealer__Sales_Up__c>`
### `getUserId()` → `String`
### `getUserName()` → `String`
### `getup()` → `dealer__Sales_Up__c`
### `isBlank(String s)` → `Boolean`
### `lookUp(String upID)` → `dealer__Sales_Up__c`
### `lookupCallerId(String sParam)` → `List<IdentityApi.caller>`
### `mergeRecords()` → `pageReference`
### `noMatch()` → `PageReference`
### `redirectLex()` → `PageReference`

 redirectLex - Determines the experience the user is expecting and directs them to the right new page

### `salesUpview()` → `pageReference`

: Redirecting the page to VINDeoderTradeIn page if any trade fields are empty (to pre-populate trade fields), or else standard view page

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `saveDuplicateOverride()` → `PageReference`

 SaveOverride

### `searchExistingDataSOSL(searchUps searchOptions)` → `void`
### `searchTradeVIN()` → `void`

: Method to search Trade VIN of Sales up in service vehicle object in order to link salesup record with service vehicle

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `setSelectedStyleId(String SelectedStyleId)` → `void`
### `setSupFieldsFromContact()` → `void`
### `singleQuotes(String str)` → `String`
---
## Inner Classes

### SalesLead_EXT.AvaliableSalesUp class
---
#### Constructors
##### `AvaliableSalesUp()`
---
#### Properties

##### `counter` → `Integer`

##### `isChecked` → `Boolean`

##### `junctionRecord` → `Sales_up__c`

---
### SalesLead_EXT.SalesUpException class
---
### SalesLead_EXT.UpException class
---
### SalesLead_EXT.searchUps class
---
#### Constructors
##### `searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum,string firstn, string lastn, string uemail, string uphone, string umobile)`
---
#### Properties

##### `firstName` → `String`

##### `inEmail` → `boolean`

##### `inFirstName` → `boolean`

##### `inLastName` → `boolean`

##### `inMobile` → `boolean`

##### `inPhone` → `boolean`

##### `lastName` → `String`

##### `upEmail` → `String`

##### `upMobile` → `String`

##### `upPhone` → `String`

---
