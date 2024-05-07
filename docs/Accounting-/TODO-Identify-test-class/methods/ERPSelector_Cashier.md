---
layout: default
---
# ERPSelector_Cashier

Cashier Selector class for ERP integration


**Implemented types**

[ERPSelector](../Accounting/ERPSelector.md)


**Group** Accounting //TODO Identify test class/methods

## Methods
### `public Map<Id,CashLine> cashierSelect(Set<String> recordIds)`

CashierSelect

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the cashier Record to obtain|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,CashLine>`|CashLine|

### `public Map<Id,Cashline> cashierDelete(Set<String> recordIds)`

cashierDelete DMS only needs the record Id to delete the transaction since the record could already be deleted from DMS we will send over a CashLine constructed with only the recordIds.

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|recordIds description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Cashline>`|return description|

### `public Object call(String action, Map<String,Object> args)`

Calls specified method on the Cashier Process Enum

#### Parameters

|Param|Description|
|---|---|
|`String`||
|`Map`|<String, Object>|

#### Returns

|Type|Description|
|---|---|
|`Object`|Object|

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
