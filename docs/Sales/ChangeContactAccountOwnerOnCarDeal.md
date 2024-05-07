---
layout: default
---
# ChangeContactAccountOwnerOnCarDeal



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)
, 
[Database.Stateful](Database.Stateful)


**Class** ChangeContactAccountOwnerOnCarDeal


**Group** Sales

## Constructors
### `global ChangeContactAccountOwnerOnCarDeal(String query)`
#### Parameters

|Param|Description|
|---|---|
|`query`||


**Method** ChangeContactAccountOwnerOnCarDeal

---
## Fields

### `private initialState` → `String`


### `private query` → `String`


### `private batchsize` → `Integer`


### `public ContactsOwners` → `Map<String,String>`


### `public AccountOwners` → `Map<String,String>`


### `public consList` → `List<String>`


### `public AccsList` → `List<String>`


---
## Methods
### `global Database start(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Returns

|Type|Description|
|---|---|
|`Database`||

### `global void execute(Database BC, List<sObject> batch)`
#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global void updateOwners(Map<String,String> con, Map<String,String> Acc)`
#### Parameters

|Param|Description|
|---|---|
|`con`||
|`Acc`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateOwners

### `global void finish(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
