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

### `static createSalesUp(SalesUp.SalesUpWrapper sup)`
### `static getSalesUpRecord(Sales_Up__c sup)`
### `static upsertAccount(Account account, Boolean allowSave)`
### `static upsertContact(Contact contact, Boolean allowSave)`
### `static findCustomerDuplicates(Account account)`
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

### SalesUp
#### Constructors
##### `SalesUp(Sales_Up__c sup)`
---
#### Fields

##### `buyer` → `Contact`

`AURAENABLED` 

##### `coBuyer` → `Contact`

`AURAENABLED` 

##### `conversion` → `Parts_Kit__c`

`AURAENABLED` 

##### `header` → `Sales_up__c`

`AURAENABLED` 

##### `location` → `Dealer_Location__c`

`AURAENABLED` 

##### `tradeIn` → `Service_Vehicle__c`

`AURAENABLED` 

##### `vehicle` → `Vehicle_Inventory__c`

`AURAENABLED` 

---

### SalesUpAPIException

**Inheritance**

SalesUpAPIException


---
