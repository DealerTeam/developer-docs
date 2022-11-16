# DealerTeamExceptionEventControlHandler

`APIVERSION: 52`

`STATUS: ACTIVE`



**Group** Miscellaneous

## Constructors
### `DealerTeamExceptionEventControlHandler(List<DealerTeamExceptionEvent__e> triggerNew)`

validates only a single event is processed and set event variable

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** DealerTeamExceptionEventControlHandler

---
## Fields

### `eventBusTransaction` → `DealerTeamExceptionEvent__e`


---
## Methods
### `fire()`

calls logException with deserialized event


**Method** fire

### `static logException(String eventJSON)`

Creates a custom exception record based on the input exception

#### Parameters

|Param|Description|
|---|---|
|`relatedToId`|SObject id which caused the exception|


**Method** LogException

---
