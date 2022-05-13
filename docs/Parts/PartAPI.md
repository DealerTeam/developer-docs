# PartAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

PartAPI - Service layer encapsulation for interaction with Parts


**Group** Parts

## Methods
### `static createInventoryFromMaster(List<Parts_Master__c> masterItems, Id location)`

createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location.

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `static readInventory(Id location)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on the Location ID

#### Parameters
|Param|Description|
|---|---|
|`Id`|Dealer_Location__c.Id|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `static readInventory(List<Id> locationIds)`
#### Parameters
|Param|Description|
|---|---|

### `static readInventory(Parts_Inventory__c part)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID&apos;s

#### Parameters
|Param|Description|
|---|---|
|`sObject`|Parts_Inventory__c|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `static readInventory(List<Id> locationIds, String manufacturer)`
#### Parameters
|Param|Description|
|---|---|

### `static getPriceByMatrix(Parts_Inventory__c part, String payType)`

Finds the matrix for a single part where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters
|Param|Description|
|---|---|
|`part`|part description|

#### Return

**Type**

Parts_Inventory__c

**Description**

return description


**Method** getPriceByMatrix

### `static getPriceByMatrix(List<Parts_Inventory__c> parts, String payType)`

Finds the matrix for a list of parts where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters
|Param|Description|
|---|---|
|`parts`|parts description|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

return description


**Method** getPriceByMatrix

### `static matrix(String paymentMethod, Parts_Inventory__c part)`

Matrix - Determines the matrix value based on the requested part being sold.

#### Parameters
|Param|Description|
|---|---|

### `static matrix(String paymentMethod, Parts_Master__c master)`
#### Parameters
|Param|Description|
|---|---|

### `static saleMetricHandler(Map<Id,Parts_Inventory__c> partInventoryMap)`
#### Parameters
|Param|Description|
|---|---|

---
## Classes
### PartAPIException

PartAPIException extends the standard exception handler


---
