---
layout: default
---
# TimeClock_AC class
---
## Constructors
### `TimeClock_AC()`
---
## Properties

### `ClockIntime` → `String`

### `ClockOutTime` → `String`

### `ExistingTimeClock` → `List<Time_Clock__c>`

### `LunchEnd1` → `boolean`

### `LunchEndTime` → `String`

### `LunchStart1` → `boolean`

### `LunchStartTime` → `String`

### `clockin1` → `boolean`

### `clockout1` → `boolean`

### `currentEntry` → `dealer__Time_Clock_Line__c`

### `isClockIntime` → `Boolean`

METHOD GRAVEYARD *

### `isClockOutTime` → `Boolean`

### `isLunchEndTime` → `Boolean`

### `isLunchStartTime` → `Boolean`

### `masterTimeClock` → `List<Time_Clock__c>`

### `timeEntries` → `List<cTimeClockLine>`

---
## Methods
### `clockin()` → `void`
### `clockout()` → `void`
### `closeCurrentEntry()` → `void`

 Close the cirrent time clock entry. This method will handle the button display depending on entry type

### `createNewEntry(String type)` → `void`

 Create a new time entry

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  - on/off |

### `gettimeEntries()` → `List<cTimeClockLine>`

With Child *

### `lunchEnd()` → `void`
### `lunchStart()` → `void`
---
## Inner Classes

### TimeClock_AC.cTimeClockLine class
---
#### Constructors
##### `cTimeClockLine(Time_Clock_Line__c dl, Decimal ts)`
---
#### Properties

##### `Id` → `public`

##### `inTime` → `String`

##### `lastModDate` → `DateTime`

##### `lastModName` → `String`

##### `outTime` → `String`

##### `timeSince` → `Decimal`

##### `type` → `String`

---
