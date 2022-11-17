# PartAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

PartAPI - Service layer encapsulation for interaction with Parts


**Group** Parts

## Methods
### `static createInventoryFromMaster(List<Parts_Master__c> masterItems, Id location)`

createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location.


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

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

#### Parameters

|Param|Description|
|---|---|
|`List`|<Id> List<Dealer_Location__c>|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `static readInventory(Parts_Inventory__c part)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

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

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

#### Parameters

|Param|Description|
|---|---|
|`List`|<Id> List<Dealer_Location__c>|
|`String`|manufacturer|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

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

### `static matrix(String paymentMethod, Parts_Master__c master)`
### `static assignStrategyPricing(Parts_Inventory__c part, Id pricingStratId)`

`AURAENABLED`
### `static assignStrategyPricing(List<Parts_Inventory__c> parts, Id pricingStratId)`

`AURAENABLED`
### `static calculateStrategyPricing(Parts_Inventory__c part, Parts_Service_Pricing_Strategy__c pricingStrat)`
### `static saleMetricHandler(Map<Id,Parts_Inventory__c> partInventoryMap)`

matrixSearch - perform record processing sub function for the primary global method

#### Parameters

|Param|Description|
|---|---|
|`{`|Map<Id, Parts_Inventory__c>} - parts to process|


**Function** - saleMetricHandler


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `static cashTransactions(String invoiceId)`
### `static subLedgerDML(List<Parts_Ledger__c> subLedgerRecords, String DMLoperation)`

Abstraction of the DML operations for subledger data manipulation.        This routine will ensure that all subledger activity is controlled by        a single routine respecting feature enablement.


**Method** subLedgerDML

### `static getPartsKit(Id pkId)`
### `static updateLedger(List<Part_Inventory_History__c> partHistory, List<Parts_Inventory__c> partsToUpdate, Boolean emailLedger)`

updateLedger handles DML when changes to on hand are requested

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List<Part_Inventory_History__c> list of history records with quantity and cost info|
|`partsToUpdate`|List<Parts_Inventory__c> affected parts to change on hand quantities|
|`emailLedger`|Boolean if true this will attempt to send a GL email|

---
## Classes
### PartAPIException

PartAPIException extends the standard exception handler


**Inheritance**

PartAPIException


### PartReceivingLedger
#### Constructors
##### `PartReceivingLedger()`
---
#### Properties

##### `entries` → `List&lt;Parts_Ledger__c&gt;`


##### `itemValue` → `Decimal`


##### `lineValue` → `Decimal`


##### `packOverride` → `Boolean`


##### `packQuantity` → `Integer`


##### `part` → `Parts_Inventory__c`


##### `processed` → `Integer`


##### `purchaseOrderLine` → `Purchase_Order_Line__c`


##### `received` → `Integer`


##### `serialNumbers` → `List&lt;String&gt;`


---

---
