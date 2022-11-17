# TimeClock_AC

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `TimeClock_AC()`
---
## Fields

### `ExistingTimeClock` → `List<Time_Clock__c>`


### `masterTimeClock` → `List<Time_Clock__c>`


### `timeEntries` → `List<cTimeClockLine>`


---
## Properties

### `ClockIntime` → `String`


### `ClockOutTime` → `String`


### `LunchEnd1` → `boolean`


### `LunchEndTime` → `String`


### `LunchStart1` → `boolean`


### `LunchStartTime` → `String`


### `clockin1` → `boolean`


### `clockout1` → `boolean`


### `currentEntry` → `dealer__Time_Clock_Line__c`


### `isClockIntime` → `Boolean`


### `isClockOutTime` → `Boolean`


### `isLunchEndTime` → `Boolean`


### `isLunchStartTime` → `Boolean`


---
## Methods
### `gettimeEntries()`
### `clockin()`
### `clockout()`
### `lunchStart()`
### `lunchEnd()`
### `createNewEntry(String type)`

Create a new time entry

#### Parameters

|Param|Description|
|---|---|
|`String`|- on/off|

### `closeCurrentEntry()`

Close the cirrent time clock entry. This method will handle the button display depending on entry type

---
## Classes
### cTimeClockLine
#### Constructors
##### `cTimeClockLine(Time_Clock_Line__c dl, Decimal ts)`
---
#### Properties

##### `Id` → `Id`


##### `inTime` → `String`


##### `lastModDate` → `DateTime`


##### `lastModName` → `String`


##### `outTime` → `String`


##### `timeSince` → `Decimal`


##### `type` → `String`


---

---
