---
layout: default
---
# SalesDeskLog class
---
## Constructors
### `SalesDeskLog()`
---
## Properties

### `CategoriesList` → `list<SelectOption>`

### `beGross` → `Integer`

### `beMTD` → `Integer`

### `companies` → `String>`

### `config` → `dealer__SalesDeskLogSettings__c`

### `datePickerSup` → `Event`

### `de` → `DateTime`

### `deskEntries` → `List<deskLogEntry>`

### `dms` → `dealer__DMS_Settings__c`

### `ds` → `DateTime`

### `emailCount` → `Integer`

### `emailUps` → `Boolean`

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
### `dropActiveSalesperson()` → `PageReference`
### `generateDeskLog()` → `PageReference`
### `generateLog()` → `void`
### `getCategories()` → `List<selectOption>`
### `getCompanies()` → `String>`
### `getFinance()` → `String>`
### `getManager()` → `String>`
### `getS1List()` → `String>`
### `getS2List()` → `String>`
### `getTrafficType()` → `String`
### `getTrafficTypes()` → `List<SelectOption>`
### `getUpBoard()` → `List<salesRotation>`
### `getdeskEntries()` → `List<deskLogEntry>`
### `logSettings()` → `void`
### `rotationLogGenerate()` → `void`
### `salesUps()` → `List<dealer__Sales_Up__c>`
### `setAppointmentStatus(String sidStat)` → `boolean`
### `setCompanyNumber()` → `void`
### `setSearchDates()` → `void`
### `setTrafficType(String trafficType)` → `void`
### `sumOfSales()` → `void`
### `trafficFilter()` → `void`
### `updateInStore(String sid)` → `boolean`
### `updateSalesStep(String idstep)` → `boolean`
### `updateUserSettings()` → `void`
### `userFilter()` → `void`
---
## Inner Classes

### SalesDeskLog.deskLogEntry class
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
### SalesDeskLog.salesRotation class
---
#### Constructors
##### `salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `salesperson` → `User`

##### `salesup` → `dealer__Sales_Up__c`

---
