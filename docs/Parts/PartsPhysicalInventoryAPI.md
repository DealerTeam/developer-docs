---
layout: default
---
# PartsPhysicalInventoryAPI

Parts physical inventory service layer application programming interface.


**Group** Parts


**Test Tag** PartPhysicalInventoryServiceLayer, PartPhysicalInventoryDomainLayer

## Methods
### `public static List<PartsPhysicalDetail__c> loadDetailRecords(Id partPhysicalDetailsId)`

Load detail records from a specific parts physical into a list.

#### Parameters

|Param|Description|
|---|---|
|`partPhysicalDetailsId`|Id representing the parts physical record|

#### Returns

|Type|Description|
|---|---|
|`List<PartsPhysicalDetail__c>`|List<dealer__PartsPhysicalDetail__c>|


**Method** loadDetailRecords

### `public static List<SelectOption> physcialTypeOptions()`

List of Types available when performing a parts physical inventory

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** PhyscialTypeOptions

### `public static void computeGeneralLedgerVariance(Id partPhysicalDetailsId)`

computeGeneralLedgerVariance calculates the general ledger variance value of included parts with a discrepancy.

#### Parameters

|Param|Description|
|---|---|
|`PartPhysicalDetailsId`|PartPhysicalDetailsId description|

### `public static String saveCountApiMethod(List<dealer__PartsPhysicalDetail__c> detail_records, dealer__PartPhysicalInventory__c ppi)`
#### Parameters

|Param|Description|
|---|---|
|`detail_records`|List<dealer__PartsPhysicalDetail__c> record IDs|
|`ppi`|dealer__PartPhysicalInventory__c Physical Inventory Workfile|

#### Returns

|Type|Description|
|---|---|
|`String`|PageReference standardAction for the PartsPhysical|


**Method** saveCountApiMethod

### `public static String completePhysicalAPIMethod(PartPhysicalInventory__c partsPhysical)`
#### Parameters

|Param|Description|
|---|---|
|`PartPhysicalInventory__c`||

#### Returns

|Type|Description|
|---|---|
|`String`|PageReference PartsPhysicalInventory standard view action|


**Method** completePhysicalAPIMethod

### `private static Map<Id,Integer> obtainCountMap(Map<Id,List<Parts_Ledger__c>> ledgerMap)`

Returns count of positive ledgers related to each part from a map of ledgers on the part

#### Parameters

|Param|Description|
|---|---|
|`ledgerMap`|ledgerMap description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Integer>`|return description|

### `public static Map<Id,List<Parts_Ledger__c>> obtainLedgers(Set<Id> partIds)`

obtainLedgers perorms the query to obtain and prepare a map of all ledgers we will be processing during this physical

#### Parameters

|Param|Description|
|---|---|
|`physicalID`|physicalID description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Parts_Ledger__c>>`|return description|


**Author** DealerTeam

### `public static Decimal processPhysicalComplete(PartPhysicalInventory__c ppi, List<PartsPhysicalDetail__c> physicalDetail)`

processPhysicalComplete completes the physical inventory process and generates the ledger entries

#### Parameters

|Param|Description|
|---|---|
|`ppi`|Physical Inventory worlfile|
|`physicalDetail`|Physical detail workfile|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal of the variance value|

### `public static void processPhysicalStoreAttachments(PartPhysicalInventory__c ppi)`

processPhysicalStoreAttachments records the variance report and the details of the parts physical to attachments

#### Parameters

|Param|Description|
|---|---|
|`ppi`|PartsPhysicalInventory__c|

### `public static void processPhysicalSaveToAccounting(PartPhysicalInventory__c ppi, Decimal varianceValue)`

processPhysicalSaveToAccounting records the variance to a Journal in the accounting engine

#### Parameters

|Param|Description|
|---|---|
|`ppi`|parts physical inventory|
|`varianceValue`|sum of the variance|

---
## Classes
### PartsPhysicalInventoryAPIException

**Inheritance**

PartsPhysicalInventoryAPIException


---
