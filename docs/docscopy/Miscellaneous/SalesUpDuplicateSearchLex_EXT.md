---
layout: default
---
# SalesUpDuplicateSearchLex_EXT class

 SalesUpDuplicateSearchLex_EXT - Controls interaction with the salesup object Date            |Developer            |Work# Notes -- 2016.12.30       |Sneha                |Case#1819 Created controller to redirect to the same page on click of Search Again button of SalesUpDuplicateSearchLex page. 2017.01.04       |Sneha                | Modified controller to redirect to SalesUpDuplicateSearchLex from SalesUpNewLex page.

---
## Constructors
### `SalesUpDuplicateSearchLex_EXT(ApexPages.StandardController c)`
---
## Properties

### `ActiveRecordsCount` → `Integer`

### `ModelKeyList` → `>`

### `SelectedStyleId` → `String`

### `acctLabel` → `String`

### `activeSalesup` → `List<AvaliableSalesUp>`

### `crm` → `dealer__CRMSettings__c`

### `dms` → `dealer__DMS_Settings__c`

### `fromCreatePage` → `Boolean`

### `fromFDPage` → `Boolean`

### `hasDuplicateResult` → `Boolean`

### `isMerge` → `Boolean`

### `isPersonsAccountsEnabled` → `Boolean`

### `matchEscape` → `Boolean`

### `nomatchstring` → `String`

### `preventSearch` → `Boolean`

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

### `attachAccountToSalesUp()` → `PageReference`
### `attachLead()` → `PageReference`
### `cancel()` → `PageReference`

: return the user to the cancel page

### `createInventory()` → `PageReference`
### `createSalesUp()` → `PageReference`
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
### `getDecode()` → `VINDEcoderDataObject.DecodeData`
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
### `performSearch()` → `PageReference`
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
### `singleQuotes(String str)` → `String`
---
## Inner Classes

### SalesUpDuplicateSearchLex_EXT.AvaliableSalesUp class
---
#### Constructors
##### `AvaliableSalesUp()`
---
#### Properties

##### `counter` → `Integer`

##### `isChecked` → `Boolean`

##### `junctionRecord` → `Sales_up__c`

---
### SalesUpDuplicateSearchLex_EXT.SalesUpException class
---
### SalesUpDuplicateSearchLex_EXT.UpException class
---
### SalesUpDuplicateSearchLex_EXT.searchUps class
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
