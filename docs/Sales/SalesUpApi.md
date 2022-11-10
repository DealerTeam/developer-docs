# SalesUpApi

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Return

**Type**

List&lt;InvocableResponse&gt;

**Description**

return description


**Method** invoke

---
## Classes
### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `methodName` → `String`

`INVOCABLEVARIABLE` 

##### `salesUp` → `Sales_Up__c`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `deal` → `Deal__c`

`INVOCABLEVARIABLE` 

##### `message` → `String`

`INVOCABLEVARIABLE` 

##### `status` → `String`

`INVOCABLEVARIABLE` 

---

---
