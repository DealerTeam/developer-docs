# PartAPI class

 PartAPI - Service layer encapsulation for interaction with Parts

---
## Methods
### `createInventoryFromMaster(List < Parts_Master__c > masterItems, Id location)` → `>`

 createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location. @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `getPriceByMatrix(Parts_Inventory__c part, String payType)` → `Parts_Inventory__c`

Finds the matrix for a single part where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters
|Param|Description|
|-----|-----------|
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
|Param|Description|
|-----|-----------|
|`parts` |  parts description |

#### Return

**Type**

List<Parts_Inventory__c>

**Description**

return description

### `matrix(String paymentMethod, Parts_Inventory__c part)` → `Decimal`

 Matrix - Determines the matrix value based on the requested part being sold.

### `matrix(String paymentMethod, Parts_Master__c master)` → `Decimal`
### `readInventory(Id location)` → `>`
### `readInventory(List < Id > locationIds)` → `>`
### `readInventory(Parts_Inventory__c part)` → `>`
### `readInventory(List < Id > locationIds, String manufacturer)` → `>`
### `saleMetricHandler(Map < Id, Parts_Inventory__c > partInventoryMap)` → `Void`

 matrixSearch - perform record processing sub function for the primary global method /** matrixSearch - perform record processing sub function for the primary global method @function - saleMetricHandler

#### Parameters
|Param|Description|
|-----|-----------|
|`{Map<Id,` |  Parts_Inventory__c>} - parts to process |

---
## Inner Classes

### PartAPI.PartAPIException class

 Updates the last_sale_date__c field with the current sale date @function - updatePartLastSaleDate @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Instantiate all fields on Part_Sale_Metric__c - retaining existing values and Setting null values to 0. @param {Part_Sale_Metric__c} - metric to be reset to 0 @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Sets all changed fields to new values @param {ID} - part to be updated in metric @param {Map<Id, Map<Integer, Integer>>} - Map of sale data to update metric @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Handles finding the month of the part sale @param {DateTime} - date to be processed @returns {Integer} - Numeric value of month @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Checks if part was sold in last 30 days @param {DateTime} - date to be processed @returns {Boolean} - True if sale was made in last 30 days @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Checks if part was sold in last 60 days @param {DateTime} - date to be processed @returns {Boolean} - True if sale was made in last 60 days @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Checks if part was sold in last 90 days @param {DateTime} - date to be processed @returns {Boolean} - True if sale was made in last 90 days @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Checks if part was sold in last 120 days @param {DateTime} - date to be processed @returns {Boolean} - True if sale was made in last 120 days @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** subLedgerDML @note Abstraction of the DML operations for subledger data manipulation. This routine will ensure that all subledger activity is controlled by a single routine respecting feature enablement. /** updateLedger handles DML when changes to on hand are requested @param  partHistory   List<Part_Inventory_History__c> list of history records with quantity and cost info @param  partsToUpdate List<Parts_Inventory__c> affected parts to change on hand quantities @param  emailLedger   Boolean if true this will attempt to send a GL email /** sendNotifications handles sending email with updated GL info @param  records Set<Id> the part_inventory__c ids that were updated @param  adjustmentValue Decimal total value of the transaction

---
