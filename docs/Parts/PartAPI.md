# PartAPI class

PartAPI - Service layer encapsulation for interaction with Parts

---
## Methods
### `createInventoryFromMaster(List < Parts_Master__c > masterItems, Id location)` → `<Id, Parts_Inventory__c>`

createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location. @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `getPriceByMatrix(Parts_Inventory__c part, String payType)` → `Parts_Inventory__c`

Finds the matrix for a single part where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters

| Param | Description |
| ----- | ----------- |
|`locationIds` |  locationIds description |
|`part` |  part description |

#### Return

**Type**

Parts_Inventory__c

**Description**

return description

### `getPriceByMatrix(List<Parts_Inventory__c> parts, String payType)` → `List<Parts_Inventory__c>`

Finds the matrix for a list of parts where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters

| Param | Description |
| ----- | ----------- |
|`parts` |  parts description |

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

return description

### `matrix(String paymentMethod, Parts_Inventory__c part)` → `Decimal`

Queries the database for parts filtered by params @function - queryPartInventory

#### Parameters

| Param | Description |
| ----- | ----------- |
|`{Id}` |  location - location of parts to filter query |
|`{List&lt;Id&gt;}` |  locationIds - multiple locations to filter |
|`{Id}` |  part - part id to filter |
|`{String}` |  manufacturer - part manufacturer to filter |

#### Return

**Type**

Decimal

**Description**

s {List&lt;Parts_Inventory__c&gt;} - list of parts matching returned by filtered query

### `matrix(String paymentMethod, Parts_Master__c master)` → `Decimal`
### `readInventory(Id location)` → `<Parts_Inventory__c>`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on the Location ID

#### Parameters

| Param | Description |
| ----- | ----------- |
|`Id` |  Dealer_Location__c.Id |

#### Return

**Type**

&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `readInventory(List <Id> locationIds)` → `<Parts_Inventory__c>`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID&apos;s

#### Parameters

| Param | Description |
| ----- | ----------- |
|`List&lt;Id&gt;` |  List&lt;Dealer_Location__c&gt; |

#### Return

**Type**

&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `readInventory(Parts_Inventory__c part)` → `<Parts_Inventory__c>`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID&apos;s

#### Parameters

| Param | Description |
| ----- | ----------- |
|`sObject` |  Parts_Inventory__c |

#### Return

**Type**

&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `readInventory(List < Id > locationIds, String manufacturer)` → `< Parts_Inventory__c >`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID&apos;s

#### Parameters

| Param | Description |
| ----- | ----------- |
|`List&lt;Id&gt;` |  List&lt;Dealer_Location__c&gt; |
|`String` |  manufacturer |

#### Return

**Type**

&lt; Parts_Inventory__c &gt;

**Description**

List&lt;Parts_Inventory__c&gt;

### `saleMetricHandler(Map < Id, Parts_Inventory__c > partInventoryMap)` → `Void`

matrixSearch - perform record processing sub function for the primary global method @function - saleMetricHandler

#### Parameters

| Param | Description |
| ----- | ----------- |
|`{Map&lt;Id,` |  Parts_Inventory__c&gt;} - parts to process |

---
## Inner Classes

### PartAPI.PartAPIException class

PartAPIException extends the standard exception handler

---
