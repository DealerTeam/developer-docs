# ERPSelector_Vehicle

`APIVERSION: 52`

`STATUS: ACTIVE`

Vehicle Selector class for ERP integration


**Implemented types**

[ERPSelector](./ERPSelector.md)


**Group** Accounting

## Methods
### `vehicleInventorySelect(Set<String> recordIds)`
### `serviceVehicleSelect(Set<String> recordIds)`
### `call(String action, Map<String,Object> args)`

Calls specified method

#### Parameters

|Param|Description|
|---|---|
|`action`|action description|
|`args`|args description|

#### Return

**Type**

Object

**Description**

return description

### `mapSchema(String sObjectName, Map<String,Map<String,Object>> objectData)`

mapSchema - ERP Selector interface method. Maps data to DS-compatible schema. Example: Checkboxes should == 'Y' || 'N'

#### Parameters

|Param|Description|
|---|---|
|`Map`|<String, Object>|

#### Return

**Type**

Map&lt;String,Map&lt;String,Object&gt;&gt;

**Description**

Map&lt;String, Map&lt;String,Object&gt;&gt;

---
## Classes
### MalformedERPSelectorCallException

**Inheritance**

MalformedERPSelectorCallException


---
