---
layout: default
---
# MergePartMasterAPI class

API class for merging 2 or more Part Master records along with their children and grand children.

---
## Methods
### `getPartLocOnhand(List<dealer__Parts_Master__c> ListPM)` → `map<id,List<dealer__Parts_Inventory__c>>`

Returns Map to store Parts data for each Part Master. @test PartPhysicalInventoryServiceLayer.testMergePartMaster

#### Parameters
|Param|Description|
|-----|-----------|
|`` | > |

### `getPartMaster(List<dealer__Parts_Master__c> ListPM)` → `List<dealer__Parts_Master__c>`

Returns Part Master records with selected fields for processing. @test PartPhysicalInventoryServiceLayer.testMergePartMaster

#### Parameters
|Param|Description|
|-----|-----------|
|`` | > |

### `mergeRecord(List<dealer__Parts_Master__c> ListPM, String MasterRec)` → `boolean`

Method to perform perform merge activity. Returns true if Merge is successful else set a Apex Page error message and returns false. @test PartPhysicalInventoryServiceLayer.testMergePartMaster

#### Parameters
|Param|Description|
|-----|-----------|
|`` | > |

---
## Inner Classes

### MergePartMasterAPI.PartsMasterException class

@description

---
