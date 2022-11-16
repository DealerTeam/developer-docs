# SalesDeskLogV2

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `SalesDeskLogV2()`
---
## Fields

### `CategoriesList` → `list<SelectOption>`


### `companies` → `Map<String,String>`


### `dealKeys` → `List<Id>`


### `deskEntries` → `List<deskLogEntry>`


### `dlStatus` → `List<String>`


### `dlType` → `List<String>`


### `finance` → `Map<Id,String>`


### `manager` → `Map<Id,String>`


### `runningUser` → `User`


### `s1List` → `Map<Id,String>`


### `s2List` → `Map<Id,String>`


### `salesUpKeys` → `List<Id>`


### `systemLogEntry` → `String`


### `trafficType` → `String`


### `upBoard` → `List<salesRotation>`


---
## Properties

### `beGross` → `Integer`


### `beMTD` → `Integer`


### `config` → `dealer__SalesDeskLogSettings__c`


### `crm` → `dealer__CRMSettings__c`


### `datePickerSup` → `Event`


### `de` → `DateTime`


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
### `loadDealType()`
### `loadDealStatus()`
### `loadUserLists()`
### `deskLogJSON()`
### `getDeskLogJSON()`
### `logSettings()`
### `getTrafficTypes()`
### `getUserSettingsJSON()`
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
### `itemKeys()`
### `carDeals()`
### `salesUps()`
### `setSearchDates()`
### `sumOfSales()`
### `userFilter()`
### `trafficFilter()`
### `rotationLogGenerate()`
### `static updateUserSettingsRemote(String us)`

`REMOTEACTION`
### `static updateInStore(String sid)`

`REMOTEACTION`
### `static updateSalesStep(String idstep)`

`REMOTEACTION`
### `static setAppointmentStatus(String sidStat)`

`REMOTEACTION`
### `static setTeamMemberDeal(String rIDtIDtKey)`

`REMOTEACTION`
### `static setTeamMemberSalesUp(String rIDtIDtKey)`

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
