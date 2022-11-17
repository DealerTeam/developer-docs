# PartsPhysicalInventoryAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

Parts physical inventory service layer application programming interface.


**Author** DealerTeam.com, LLC


**Group** Parts


**Test** PartPhysicalInventoryServiceLayer


**Test** PartPhysicalInventoryDomainLayer

## Methods
### `static loadDetailRecords(Id partPhysicalDetailsId)`

Load detail records from a specific parts physical into a list.

#### Parameters

|Param|Description|
|---|---|
|`partPhysicalDetailsId`|Id representing the parts physical record|

#### Return

**Type**

List&lt;PartsPhysicalDetail__c&gt;

**Description**

List&lt;dealer__PartsPhysicalDetail__c&gt;


**Method** loadDetailRecords

### `static physcialTypeOptions()`

List of Types available when performing a parts physical inventory

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** PhyscialTypeOptions

### `static computeGeneralLedgerVariance(Id partPhysicalDetailsId)`

computeGeneralLedgerVariance calculates the general ledger variance value of included parts with a discrepancy.

#### Parameters

|Param|Description|
|---|---|
|`PartPhysicalDetailsId`|PartPhysicalDetailsId description|

### `static saveCountApiMethod(List<dealer__PartsPhysicalDetail__c> detail_records, dealer__PartPhysicalInventory__c ppi)`
#### Parameters

|Param|Description|
|---|---|
|`detail_records`|List<dealer__PartsPhysicalDetail__c> record IDs|
|`ppi`|dealer__PartPhysicalInventory__c Physical Inventory Workfile|

#### Return

**Type**

PageReference

**Description**

PageReference standardAction for the PartsPhysical


**Method** saveCountApiMethod

### `static completePhysicalAPIMethod(dealer__PartPhysicalInventory__c ppi)`
#### Parameters

|Param|Description|
|---|---|
|`PartPhysicalInventory__c`||

#### Return

**Type**

PageReference

**Description**

PageReference PartsPhysicalInventory standard view action


**Method** completePhysicalAPIMethod

---
## Classes
### PartsPhysicalInventoryAPIException

**Inheritance**

PartsPhysicalInventoryAPIException


---
