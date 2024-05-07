---
layout: default
---
# AccountChangeEventProcessor

This class processes Account sobject sync with Integrated Accountin


**Group** Common


**Test** //TODO Find test class

## Constructors
### `public AccountChangeEventProcessor()`

Constructor


**Notes** Currently not used

---
## Methods
### `public static void accountCreate(String eventData)`

`FUTURE`

Send account data to HEMI for Sync with DMS

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Test** //TODO Find Test Method

### `public static void accountUpdate(String eventData, String extId)`

`FUTURE`

Send account data to HEMI for Sync with DMS


**Notes** This method is used in the update process of account data

---
## Classes
### EventResponse

Event response wrapper class.  This class is used specifically for Account Sync.


**Group** Common

#### Properties

##### `private recordid` → `String`


##### `private customerid` → `String`


---

---
