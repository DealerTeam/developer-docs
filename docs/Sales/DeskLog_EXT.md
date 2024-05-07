---
layout: default
---
# DeskLog_EXT



**Group** Sales

## Constructors
### `public DeskLog_EXT(ApexPages s)`
---
## Fields

### `private trafficLog` → `List<dealer__Traffic_Log__c>`


### `public deskEntries` → `List<deskEntry>`


### `public s1List` → `Map<Id,String>`


### `public s2List` → `Map<Id,String>`


### `public manager` → `Map<Id,String>`


### `public upBoard` → `List<salesRotation>`


### `private datePickerSup` → `Event`


---
## Properties

### `public ds` → `DateTime`


### `public de` → `DateTime`


### `public d` → `Date`


### `public filterLeads` → `boolean`


### `public filterTraffic` → `boolean`


### `public filterAppointments` → `boolean`


### `public filterDeals` → `boolean`


### `public filterInStore` → `boolean`


### `public frontEndGross` → `Decimal`


### `public backEndGross` → `Decimal`


### `public totalGross` → `Decimal`


### `public trafficCount` → `Integer`


### `public leadcount` → `Integer`


### `public apptCount` → `Integer`


### `public dealCount` → `Integer`


### `public filterUserID` → `String`


### `public filterUserType` → `String`


### `public loggedInSalesAssociates` → `List<User>`


### `public CompanyNumber` → `String`


### `public CompanyNumber1` → `String`


### `public activeDivision` → `String`


### `public salespersonResetId` → `String`


---
## Methods
### `public List<SelectOption> getCompanyNumbers()`
### `public Event getProxyDate()`
### `public void setProxyDate(Event datePickerSup)`
### `public void setSearchDates()`
### `public void rotationLogGenerate()`
### `public PageReference dropActiveSalesperson()`
### `public Map<Id,String> getS1List()`
### `public Map<Id,String> getS2List()`
### `public Map<Id,String> getManager()`
### `public List<salesRotation> getUpBoard()`
### `public void clearCache()`
### `public PageReference generateDeskLog()`
### `public List<deskEntry> getDeskEntries()`
### `public void trafficItems()`
### `public void leadItems()`
### `public void dealItems()`
### `public void apptItems()`
### `public static list<deskEntry> sortByDate(list<deskEntry> wrapperObject, String sortingOrder)`
### `public void activateFilter()`
### `public void userFilter()`
---
## Classes
### deskEntry
#### Constructors
##### `public deskEntry(String dt, DateTime e, String lt, dealer__Traffic_Log__c t, dealer__Sales_Up__c u, dealer__Sales_Appointment__c a, dealer__Deal__c d)`
---
#### Properties

##### `public deskEntryType` → `String`


##### `public eventDateTime` → `Datetime`


##### `public localDateTime` → `String`


##### `public traffic` → `dealer__Traffic_Log__c`


##### `public up` → `dealer__Sales_Up__c`


##### `public appt` → `dealer__Sales_Appointment__c`


##### `public deal` → `dealer__Deal__c`


---

### salesRotation
#### Constructors
##### `public salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `public salesperson` → `User`


##### `public salesup` → `dealer__Sales_Up__c`


---

---
