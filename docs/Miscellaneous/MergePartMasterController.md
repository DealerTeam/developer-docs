---
layout: default
---
# MergePartMasterController class

Controller for MergePartMaster.page to retrieve Part Master information and to merge duplicate Part Master records.

---
## Constructors
### `MergePartMasterController(ApexPages.StandardSetController controller)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `MasterRec` → `string`

@description

---
## Methods
### `getPartLocOnhand()` → `map<id,List<dealer__Parts_Inventory__c>>`
### `getPartMaster()` → `List<dealer__Parts_Master__c>`
### `goBack()` → `pageReference`
### `mergeRecord()` → `pageReference`
---
