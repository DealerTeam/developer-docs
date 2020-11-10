---
layout: default
---
# DeskLog_EXT class
---
## Constructors
### `DeskLog_EXT(ApexPages.standardSetController s)`
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

### `deskEntries` → `List<deskEntry>`

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

### `manager` → `String>`

### `s1List` → `String>`

### `s2List` → `String>`

### `salespersonResetId` → `String`

### `totalGross` → `Decimal`

### `trafficCount` → `Integer`

### `upBoard` → `List<salesRotation>`

---
## Methods
### `activateFilter()` → `void`
### `apptItems()` → `void`
### `clearCache()` → `void`
### `dealItems()` → `void`
### `dropActiveSalesperson()` → `PageReference`
### `generateDeskLog()` → `PageReference`
### `getCompanyNumbers()` → `List<SelectOption>`
### `getDeskEntries()` → `List<deskEntry>`
### `getManager()` → `String>`
### `getProxyDate()` → `Event`
### `getS1List()` → `String>`
### `getS2List()` → `String>`
### `getUpBoard()` → `List<salesRotation>`
### `leadItems()` → `void`
### `rotationLogGenerate()` → `void`
### `setProxyDate(Event datePickerSup)` → `void`
### `setSearchDates()` → `void`
### `sortByDate(list<deskEntry> wrapperObject,String sortingOrder)` → `list<deskEntry>`
### `trafficItems()` → `void`
### `userFilter()` → `void`
---
## Inner Classes

### DeskLog_EXT.deskEntry class
---
#### Constructors
##### `deskEntry(String dt, DateTime e, String lt, dealer__Traffic_Log__c t, dealer__Sales_Up__c u, dealer__Sales_Appointment__c a, dealer__Deal__c d)`
---
#### Properties

##### `appt` → `dealer__Sales_Appointment__c`

##### `deal` → `public`

##### `deskEntryType` → `String`

##### `eventDateTime` → `Datetime`

##### `localDateTime` → `String`

##### `traffic` → `dealer__Traffic_Log__c`

##### `up` → `dealer__Sales_Up__c`

---
### DeskLog_EXT.salesRotation class
---
#### Constructors
##### `salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `salesperson` → `User`

##### `salesup` → `dealer__Sales_Up__c`

---
