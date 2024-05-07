---
layout: default
---
# ERPSelector_Customer

Account(customer) Selector class for ERP integration


**Implemented types**

[ERPSelector](./ERPSelector.md)


**Group** Accounting

## Methods
### `public Map<Id,Account> customerSelect_Person(Set<String> recordIds)`

CustomerSelect

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Account>`|Map<String, Object> The return map includes a string object key value pair of the Account sobject data|

### `public Map<Id,Account> customerSelect_Business(Set<String> recordIds)`

CustomerSelect

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Account>`|Map<String, Object> The return map includes a string object key value pair of the Account sobject data|

### `public Object call(String action, Map<String,Object> args)`

Calls specified method

#### Parameters

|Param|Description|
|---|---|
|`action`|action description|
|`args`|args description|

#### Returns

|Type|Description|
|---|---|
|`Object`|return description|

### `public Map<String,Map<String,Object>> mapSchema(String sObjectName, Map<String,Map<String,Object>> objectData)`

mapSchema - ERP Selector interface method. Maps data to DS-compatible schema. Example: Checkboxes should == 'Y' || 'N'

#### Parameters

|Param|Description|
|---|---|
|`Map`|<String, Object>|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Map<String,Object>>`|Map<String, Map<String,Object>>|

---
## Classes
### MalformedERPSelectorCallException

**Inheritance**

MalformedERPSelectorCallException


---
