---
layout: default
---
# MergePartMasterAPI

API class for merging 2 or more Part Master records along with their children and grand children.


**Class** MergePartMasterAPI


**Group** Parts

## Methods
### `public static List<dealer__Parts_Master__c> getPartMaster(List<dealer__Parts_Master__c> ListPM)`

Returns Part Master records with selected fields for processing.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Master__c>`|List<dealer__Parts_Master__c>|


**Method** getPartMaster


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

### `public static map<id,List<dealer__Parts_Inventory__c>> getPartLocOnhand(List<dealer__Parts_Master__c> ListPM)`

Returns Map to store Parts data for each Part Master.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Returns

|Type|Description|
|---|---|
|`map<id,List<dealer__Parts_Inventory__c>>`|map<id,List<dealer__Parts_Inventory__c>>|


**Method** getPartLocOnhand


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

### `public static boolean mergeRecord(List<dealer__Parts_Master__c> ListPM, String MasterRec)`

Method to perform perform merge activity. Returns true if Merge is successful else set a Apex Page error message and returns false.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** getPartLocOnhand


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

---
## Classes
### PartsMasterException



**Inheritance**

PartsMasterException


---
