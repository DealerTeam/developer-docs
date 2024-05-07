---
layout: default
---
# ERPSelector_RentalAgreement

**Implemented types**

[ERPSelector](../Accounting/ERPSelector.md)

## Methods
### `private Map<Id,RentalAgreement> rentalSelect(Set<String> recordIds)`

rentalSelect

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,RentalAgreement>`|return description|

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
### MalformedERPDefinedEventCallException

**Inheritance**

MalformedERPDefinedEventCallException


---
