---
layout: default
---
# BatchUpdateEquippedField



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)
, 
[Database.Stateful](Database.Stateful)


**Class** BatchUpdateEquippedField

## Constructors
### `global BatchUpdateEquippedField(String q, String e, String f, String v)`
#### Parameters

|Param|Description|
|---|---|
|`e`||
|`f`||
|`v`||


**Method** BatchUpdateEquippedField

---
## Fields

### `global Query` → `String`


### `global Entity` → `String`


### `global OldField` → `String`


### `global NewField` → `String`


### `global ListRecForEmailId` → `List<id>`


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
|`Database`|Database.QueryLocator|

### `global void execute(Database BC, List<sObject> scope)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`scope`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

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
