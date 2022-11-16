# MergePartMasterAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

API class for merging 2 or more Part Master records along with their children and grand children.


**Class** MergePartMasterAPI


**Group** Parts

## Methods
### `static getPartMaster(List<dealer__Parts_Master__c> ListPM)`

Returns Part Master records with selected fields for processing.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Return

**Type**

List&lt;dealer__Parts_Master__c&gt;

**Description**

List&lt;dealer__Parts_Master__c&gt;


**Method** getPartMaster


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

### `static getPartLocOnhand(List<dealer__Parts_Master__c> ListPM)`

Returns Map to store Parts data for each Part Master.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Return

**Type**

map&lt;id,List&lt;dealer__Parts_Inventory__c&gt;&gt;

**Description**

map&lt;id,List&lt;dealer__Parts_Inventory__c&gt;&gt;


**Method** getPartLocOnhand


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

### `static mergeRecord(List<dealer__Parts_Master__c> ListPM, String MasterRec)`

Method to perform perform merge activity. Returns true if Merge is successful else set a Apex Page error message and returns false.

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Parts_Master__c>|

#### Return

**Type**

boolean

**Description**

boolean


**Method** getPartLocOnhand


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster

---
## Classes
### PartsMasterException



**Inheritance**

PartsMasterException


---
