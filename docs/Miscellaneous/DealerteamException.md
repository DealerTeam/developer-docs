---
layout: default
---
# DealerteamException



**Inheritance**

DealerteamException


**Group** Miscellaneous

## Constructors
### `public DealerteamException(QueryException qe)`

Constructor to pass exception data back to client

#### Parameters

|Param|Description|
|---|---|
|`message`|Error message|
|`inaccessibleFields`|Any fields the user is missing access to|

---
## Fields

### `public message` → `String`


### `public inaccessibleFields` → `Map<String,Set<String>>`


---
## Methods
### `public static void fireExceptionEvent(Exception e)`

Creates a platform event unrelated to a specific Id

#### Parameters

|Param|Description|
|---|---|
|`e`|e description|


**Method** fireExceptionEvent

### `public static void fireExceptionEvent(Exception e, String relatedToId)`

Creates a platform event with exception data

#### Parameters

|Param|Description|
|---|---|
|`e`|e description|
|`relatedToId`|relatedToId description|


**Method** fireExceptionEvent

---
