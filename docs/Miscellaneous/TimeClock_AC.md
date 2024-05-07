---
layout: default
---
# TimeClock_AC
## Constructors
### `public TimeClock_AC()`
---
## Fields

### `public masterTimeClock` → `List<Time_Clock__c>`


### `public timeEntries` → `List<cTimeClockLine>`


### `public ExistingTimeClock` → `List<Time_Clock__c>`


---
## Properties

### `public clockin1` → `boolean`


### `public clockout1` → `boolean`


### `public LunchStart1` → `boolean`


### `public LunchEnd1` → `boolean`


### `public currentEntry` → `dealer__Time_Clock_Line__c`


### `public isClockIntime` → `Boolean`


### `public isClockOutTime` → `Boolean`


### `public isLunchStartTime` → `Boolean`


### `public isLunchEndTime` → `Boolean`


### `public ClockIntime` → `String`


### `public ClockOutTime` → `String`


### `public LunchStartTime` → `String`


### `public LunchEndTime` → `String`


---
## Methods
### `public List<cTimeClockLine> gettimeEntries()`
### `public void clockin()`
### `public void clockout()`
### `public void lunchStart()`
### `public void lunchEnd()`
### `public void createNewEntry(String type)`

Create a new time entry

#### Parameters

|Param|Description|
|---|---|
|`String`|- on/off|

### `public void closeCurrentEntry()`

Close the cirrent time clock entry. This method will handle the button display depending on entry type

---
## Classes
### cTimeClockLine
#### Constructors
##### `public cTimeClockLine(Time_Clock_Line__c dl, Decimal ts)`
---
#### Properties

##### `public Id` → `Id`


##### `public inTime` → `String`


##### `public outTime` → `String`


##### `public type` → `String`


##### `public lastModDate` → `DateTime`


##### `public lastModName` → `String`


##### `public timeSince` → `Decimal`


---

---
