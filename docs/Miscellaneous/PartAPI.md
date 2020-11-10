---
layout: default
---
# PartAPI class

 PartAPI - Service layer encapsulation for interaction with Parts

---
## Methods
### `cashTransactions(String invoiceId)` → `>`
### `createInventoryFromMaster(List < Parts_Master__c > masterItems, Id location)` → `>`

 createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location. @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `getPartsKit(Id pkId)` → `Parts_Kit__c`
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

### `subLedgerDML(List<Parts_Ledger__c> subLedgerRecords, String DMLoperation)` → `void`

 Updates the last_sale_date__c field with the current sale date @function - updatePartLastSaleDate @test PartPhysicalInventoryServiceLayer.testPartAPIBatchable /** Instantiate all fields on Part_Sale_Metric__c - retaining existing values and Setting null values to 0.

#### Parameters
|Param|Description|
|-----|-----------|
|`{Part_Sale_Metric__c}` |  - metric to be reset to 0 |
|`{ID}` |  - part to be updated in metric |
|`{Map<Id,` |  Map<Integer, Integer>>} - Map of sale data to update metric |
|`{DateTime}` |  - date to be processed |
|`{DateTime}` |  - date to be processed |
|`{DateTime}` |  - date to be processed |
|`{DateTime}` |  - date to be processed |
|`{DateTime}` |  - date to be processed |

### `updateLedger(List<Part_Inventory_History__c> partHistory, List<Parts_Inventory__c> partsToUpdate,Boolean emailLedger)` → `void`

 updateLedger handles DML when changes to on hand are requested

#### Parameters
|Param|Description|
|-----|-----------|
|`partHistory` |    List<Part_Inventory_History__c> list of history records with quantity and cost info |
|`partsToUpdate` |  List<Parts_Inventory__c> affected parts to change on hand quantities |
|`emailLedger` |    Boolean if true this will attempt to send a GL email |

---
## Inner Classes

### PartAPI.PartAPIException class

 sendNotifications handles sending email with updated GL info @param  records Set<Id> the part_inventory__c ids that were updated @param  adjustmentValue Decimal total value of the transaction

---
