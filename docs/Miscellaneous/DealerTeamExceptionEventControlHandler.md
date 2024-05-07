---
layout: default
---
# DealerTeamExceptionEventControlHandler



**Group** Miscellaneous

## Constructors
### `public DealerTeamExceptionEventControlHandler(List<DealerTeamExceptionEvent__e> triggerNew)`

validates only a single event is processed and set event variable

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** DealerTeamExceptionEventControlHandler

---
## Fields

### `public eventBusTransaction` → `DealerTeamExceptionEvent__e`


---
## Methods
### `public void fire()`

calls logException with deserialized event


**Method** fire

### `public static void logException(String eventJSON)`

Creates a custom exception record based on the input exception

#### Parameters

|Param|Description|
|---|---|
|`relatedToId`|SObject id which caused the exception|


**Method** LogException

---
