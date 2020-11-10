---
layout: default
---
# PartsPhysicalInventoryAPI class

Parts physical inventory service layer application programming interface. @test PartPhysicalInventoryServiceLayer @test PartPhysicalInventoryDomainLayer

---
## Methods
### `completePhysicalAPIMethod(dealer__PartPhysicalInventory__c ppi)` → `PageReference`

 completePhysicalAPIMethod

#### Parameters
|Param|Description|
|-----|-----------|
|`` | c |

### `computeGeneralLedgerVariance(Id partPhysicalDetailsId)` → `void`

computeGeneralLedgerVariance calculates the general ledger variance value of included parts with a discrepancy.

#### Parameters
|Param|Description|
|-----|-----------|
|`PartPhysicalDetailsId` |  PartPhysicalDetailsId description |

### `loadDetailRecords(Id partPhysicalDetailsId)` → `List<PartsPhysicalDetail__c>`

Load detail records from a specific parts physical into a list.

#### Parameters
|Param|Description|
|-----|-----------|
|`partPhysicalDetailsId` |  Id representing the parts physical record |

### `physcialTypeOptions()` → `List<SelectOption>`

List of Types available when performing a parts physical inventory

### `saveCountApiMethod(List<dealer__PartsPhysicalDetail__c> detail_records, dealer__PartPhysicalInventory__c ppi)` → `PageReference`

 saveCountApiMethod

#### Parameters
|Param|Description|
|-----|-----------|
|`detail_records` |  List<dealer__PartsPhysicalDetail__c> record IDs |
|`ppi` |             dealer__PartPhysicalInventory__c Physical Inventory Workfile |

---
## Inner Classes

### PartsPhysicalInventoryAPI.PartsPhysicalInventoryAPIException class
---
