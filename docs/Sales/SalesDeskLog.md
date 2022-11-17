# SalesDeskLog

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `SalesDeskLog()`
---
## Fields

### `CategoriesList` → `list<SelectOption>`


### `companies` → `Map<String,String>`


### `deskEntries` → `List<deskLogEntry>`


### `finance` → `Map<Id,String>`


### `manager` → `Map<Id,String>`


### `runningUser` → `User`


### `s1List` → `Map<Id,String>`


### `s2List` → `Map<Id,String>`


### `systemLogEntry` → `String`


### `trafficType` → `String`


### `upBoard` → `List<salesRotation>`


---
## Properties

### `beGross` → `Integer`


### `beMTD` → `Integer`


### `config` → `dealer__SalesDeskLogSettings__c`


### `datePickerSup` → `Event`


### `de` → `DateTime`


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


### `listCount` → `Integer`


### `listUps` → `Boolean`


### `loggedInSalesAssociates` → `List<User>`


### `otherCount` → `Integer`


### `otherUps` → `Boolean`


### `phoneCount` → `Integer`


### `phoneUps` → `Boolean`


### `referralCount` → `Integer`


### `referralUps` → `Boolean`


### `rundate` → `Date`


### `salespersonResetId` → `String`


### `selectedDivision` → `String`


### `setToFalse` → `Boolean`


### `setToTrue` → `Boolean`


### `soldCount` → `Integer`


### `soldMTD` → `Integer`


### `tgMTD` → `Integer`


### `totalGross` → `Integer`


### `trafficFilterSOQL` → `String`


### `userDealFilterSOQL` → `String`


### `userFilterSOQL` → `String`


### `userLocation` → `Dealer_Location__c`


### `walkInUps` → `Boolean`


### `walkinCount` → `Integer`


---
## Methods
### `getCategories()`
### `logSettings()`
### `getTrafficTypes()`
### `getTrafficType()`
### `setTrafficType(String trafficType)`
### `setCompanyNumber()`
### `getCompanies()`
### `getS1List()`
### `getS2List()`
### `getManager()`
### `getFinance()`
### `generateDeskLog()`
### `updateUserSettings()`
### `generateLog()`
### `getdeskEntries()`
### `getUpBoard()`
### `dropActiveSalesperson()`
### `carDeals()`
### `salesUps()`
### `setSearchDates()`
### `sumOfSales()`
### `userFilter()`
### `trafficFilter()`
### `rotationLogGenerate()`
### `static updateInStore(String sid)`

`REMOTEACTION`
### `static updateSalesStep(String idstep)`

`REMOTEACTION`
### `static setAppointmentStatus(String sidStat)`

`REMOTEACTION`
---
## Classes
### deskLogEntry
#### Constructors
##### `deskLogEntry(dealer__Sales_Up__c up, dealer__Deal__c deals, String css, String t)`
---
#### Properties

##### `cssClass` → `String`


##### `deal` → `dealer__Deal__c`


##### `entryType` → `String`


##### `salesUp` → `dealer__Sales_Up__c`


---

### salesRotation
#### Constructors
##### `salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `salesperson` → `User`


##### `salesup` → `dealer__Sales_Up__c`


---

---
