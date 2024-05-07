---
layout: default
---
# DMSDataEventControlHandler

Control handler for the DMSRecord Event Bus Apex subscriber.


**Group** Accounting


**Test** ERPServiceLayer

## Constructors
### `public DMSDataEventControlHandler(List<DMSRecord__e> triggerNew)`

DMSDataEventControlHandler defines a static event to be processed.

#### Parameters

|Param|Description|
|---|---|
|`List`|<DMSRecord__e> List of DMS Records to process|


**Test** //TODO Identify and document test method, one may not exist

---
## Fields

### `public eventBusTransaction` → `List<DMSREcord__e>`


---
## Methods
### `public void fire()`

Process all events in the static variable for eventBusTransaction //TODO Bulkfiy

---
