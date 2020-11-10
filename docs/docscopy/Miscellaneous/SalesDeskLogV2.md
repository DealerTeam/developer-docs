---
layout: default
---
# SalesDeskLogV2 class

 Date            |Developer            |Work# Notes ----------------------------------------------------------------------- 09-27-2016      |Gaurav               |Case - 00002084 To disable create new deal button if current user is not having access to 'DMSDealCreate_EXT' controller class 09-29-2016      |Sneha                |Case - 00002084 Use Utility Class for class access check

---
## Constructors
### `SalesDeskLogV2()`
---
## Properties

### `CategoriesList` → `list<SelectOption>`

### `beGross` → `Integer`

### `beMTD` → `Integer`

### `companies` → `String>`

### `config` → `dealer__SalesDeskLogSettings__c`

### `crm` → `dealer__CRMSettings__c`

### `datePickerSup` → `Event`

### `de` → `DateTime`

### `dealKeys` → `List<Id>`

### `deskEntries` → `List<deskLogEntry>`

### `dlStatus` → `List<String>`

### `dlType` → `List<String>`

### `dms` → `dealer__DMS_Settings__c`

### `ds` → `DateTime`

### `emailCount` → `Integer`

### `emailUps` → `Boolean`

### `enableCreateDeal` → `boolean`

### `faxCount` → `Integer`

### `faxUps` → `Boolean`

### `feGross` → `Integer`

### `feMTD` → `Integer`

### `filterInStore` → `String`

### `filterUserID` → `String`

### `filterUserType` → `String`

### `finance` → `String>`

### `listCount` → `Integer`

### `listUps` → `Boolean`

### `loggedInSalesAssociates` → `List<User>`

### `manager` → `String>`

### `otherCount` → `Integer`

### `otherUps` → `Boolean`

### `phoneCount` → `Integer`

### `phoneUps` → `Boolean`

### `referralCount` → `Integer`

### `referralUps` → `Boolean`

### `rundate` → `Date`

### `runningUser` → `User`

### `s1List` → `String>`

### `s2List` → `String>`

### `salesUpKeys` → `List<Id>`

### `salespersonResetId` → `String`

### `selectedDivision` → `String`

### `setToFalse` → `Boolean`

### `setToTrue` → `Boolean`

### `soldCount` → `Integer`

### `soldMTD` → `Integer`

### `systemLogEntry` → `String`

### `tgMTD` → `Integer`

### `totalGross` → `Integer`

### `trafficFilterSOQL` → `String`

### `trafficType` → `String`

### `upBoard` → `List<salesRotation>`

### `userDealFilterSOQL` → `String`

### `userFilterSOQL` → `String`

### `walkInUps` → `Boolean`

### `walkinCount` → `Integer`

---
## Methods
### `carDeals()` → `dealer__Deal__c>`
### `deskLogJSON()` → `string`
### `dropActiveSalesperson()` → `PageReference`
### `generateDeskLog()` → `PageReference`
### `generateLog()` → `void`
### `getCategories()` → `List<selectOption>`
### `getCompanies()` → `String>`
### `getDeskLogJSON()` → `string`
### `getFinance()` → `String>`
### `getManager()` → `String>`
### `getS1List()` → `String>`
### `getS2List()` → `String>`
### `getTrafficType()` → `String`
### `getTrafficTypes()` → `List<SelectOption>`
### `getUpBoard()` → `List<salesRotation>`
### `getUserSettingsJSON()` → `String`
### `getdeskEntries()` → `List<deskLogEntry>`
### `itemKeys()` → `void`
### `loadDealStatus()` → `void`
### `loadDealType()` → `void`
### `loadUserLists()` → `void`
### `logSettings()` → `void`
### `rotationLogGenerate()` → `void`
### `salesUps()` → `List<dealer__Sales_Up__c>`
### `setAppointmentStatus(String sidStat)` → `boolean`
### `setCompanyNumber()` → `void`
### `setSearchDates()` → `void`
### `setTeamMemberDeal(String rIDtIDtKey)` → `boolean`
### `setTeamMemberSalesUp(String rIDtIDtKey)` → `boolean`
### `setTrafficType(String trafficType)` → `void`
### `sumOfSales()` → `void`
### `trafficFilter()` → `void`
### `updateInStore(String sid)` → `boolean`
### `updateSalesStep(String idstep)` → `boolean`
### `updateUserSettings()` → `void`
### `updateUserSettingsRemote(String us)` → `boolean`
### `userFilter()` → `void`
---
## Inner Classes

### SalesDeskLogV2.deskLogEntry class
---
#### Constructors
##### `deskLogEntry(dealer__Sales_Up__c up, dealer__Deal__c deals, String css, String t)`
---
#### Properties

##### `cssClass` → `String`

##### `deal` → `public`

##### `entryType` → `String`

##### `salesUp` → `dealer__Sales_Up__c`

---
### SalesDeskLogV2.salesRotation class
---
#### Constructors
##### `salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `salesperson` → `User`

##### `salesup` → `dealer__Sales_Up__c`

---
