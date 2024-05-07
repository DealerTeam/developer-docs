---
layout: default
---
# SalesUpApi



**Group** Sales

## Fields

### `private INVOCABLE_METHODS` → `List<String>`


---
## Methods
### `global static List<InvocableResponse> invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Returns

|Type|Description|
|---|---|
|`List<InvocableResponse>`|return description|


**Method** invoke

### `private static void validateInputs(List<InvocableParams> params)`

Verify the inputs are valid for the invoked method

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|


**Method** validateInputs

### `public static Sales_Up__c createSalesUp(SalesUp sup)`
### `public static SalesUp getSalesUpRecord(Sales_Up__c sup)`
### `public static Account upsertAccount(Account account, Boolean allowSave)`
### `public static Contact upsertContact(Contact contact, Boolean allowSave)`
### `public static List<sObject> findCustomerDuplicates(Account account)`
---
## Classes
### SalesUp
#### Constructors
##### `public SalesUp(Sales_Up__c sup)`
---
#### Fields

##### `public header` → `Sales_up__c`

`AURAENABLED` 

##### `public location` → `Dealer_Location__c`

`AURAENABLED` 

##### `public buyer` → `Contact`

`AURAENABLED` 

##### `public coBuyer` → `Contact`

`AURAENABLED` 

##### `public vehicle` → `Vehicle_Inventory__c`

`AURAENABLED` 

##### `public tradeIn` → `Service_Vehicle__c`

`AURAENABLED` 

##### `public conversion` → `Parts_Kit__c`

`AURAENABLED` 

---

### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `global methodName` → `String`

`INVOCABLEVARIABLE` 

##### `global salesUp` → `Sales_Up__c`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `global status` → `String`

`INVOCABLEVARIABLE` 

##### `global message` → `String`

`INVOCABLEVARIABLE` 

##### `global deal` → `Deal__c`

`INVOCABLEVARIABLE` 

---

### SalesUpAPIException

**Inheritance**

SalesUpAPIException


---
