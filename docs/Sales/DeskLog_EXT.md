# DeskLog_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `DeskLog_EXT(ApexPages.standardSetController s)`
---
## Fields

### `deskEntries` → `List<deskEntry>`


### `manager` → `Map<Id,String>`


### `s1List` → `Map<Id,String>`


### `s2List` → `Map<Id,String>`


### `upBoard` → `List<salesRotation>`


---
## Properties

### `CompanyNumber` → `String`


### `CompanyNumber1` → `String`


### `activeDivision` → `String`


### `apptCount` → `Integer`


### `backEndGross` → `Decimal`


### `d` → `Date`


### `de` → `DateTime`


### `dealCount` → `Integer`


### `ds` → `DateTime`


### `filterAppointments` → `boolean`


### `filterDeals` → `boolean`


### `filterInStore` → `boolean`


### `filterLeads` → `boolean`


### `filterTraffic` → `boolean`


### `filterUserID` → `String`


### `filterUserType` → `String`


### `frontEndGross` → `Decimal`


### `leadcount` → `Integer`


### `loggedInSalesAssociates` → `List<User>`


### `salespersonResetId` → `String`


### `totalGross` → `Decimal`


### `trafficCount` → `Integer`


---
## Methods
### `getCompanyNumbers()`
### `getProxyDate()`
### `setProxyDate(Event datePickerSup)`
### `setSearchDates()`
### `rotationLogGenerate()`
### `dropActiveSalesperson()`
### `getS1List()`
### `getS2List()`
### `getManager()`
### `getUpBoard()`
### `clearCache()`
### `generateDeskLog()`
### `getDeskEntries()`
### `trafficItems()`
### `leadItems()`
### `dealItems()`
### `apptItems()`
### `static sortByDate(list<deskEntry> wrapperObject, String sortingOrder)`
### `activateFilter()`
### `userFilter()`
---
## Classes
### deskEntry
#### Constructors
##### `deskEntry(String dt, DateTime e, String lt, dealer__Traffic_Log__c t, dealer__Sales_Up__c u, dealer__Sales_Appointment__c a, dealer__Deal__c d)`
---
#### Properties

##### `appt` → `dealer__Sales_Appointment__c`


##### `deal` → `dealer__Deal__c`


##### `deskEntryType` → `String`


##### `eventDateTime` → `Datetime`


##### `localDateTime` → `String`


##### `traffic` → `dealer__Traffic_Log__c`


##### `up` → `dealer__Sales_Up__c`


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
