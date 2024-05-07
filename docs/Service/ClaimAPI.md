---
layout: default
---
# ClaimAPI



**Class** ClaimAPI


**Group** Service

## Methods
### `public static ClaimItem__c createEstimateLine(ClaimItem__c line)`

Used within the claim creation process

#### Parameters

|Param|Description|
|---|---|
|`line`||

#### Returns

|Type|Description|
|---|---|
|`ClaimItem__c`|ClaimItem__c|


**Method** createEstimateLine - creation of an estimate line

### `public static ClaimItem__c updateEstimateLine(ClaimItem__c line)`

Update line call

#### Parameters

|Param|Description|
|---|---|
|`line`||

#### Returns

|Type|Description|
|---|---|
|`ClaimItem__c`|ClaimItem__c|


**Method** updateEstimateLine

### `public static Boolean deleteEstimateLine(Id lineId)`

Delete line call

#### Parameters

|Param|Description|
|---|---|
|`lineId`||

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** deleteEstimateLine

### `public static List<ClaimSubItem__c> estimateSubLines(Id lineId)`
#### Parameters

|Param|Description|
|---|---|
|`lineId`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimSubItem__c>`|List<ClaimSubItem__c>|


**Method** estimateSubLines

### `public static ClaimSubItem__c createSubLine(ClaimSubItem__c subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Returns

|Type|Description|
|---|---|
|`ClaimSubItem__c`|ClaimSubItem__c|


**Method** createSubLine

### `public static ClaimSubItem__c updateSubLine(ClaimSubItem__c subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Returns

|Type|Description|
|---|---|
|`ClaimSubItem__c`|ClaimSubItem__c|


**Method** updateSubLine

### `public static void deleteSubLine(Id subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** deleteSubLine

### `private static ClaimSubItem__c returnSubLine(Id subLineId)`
#### Parameters

|Param|Description|
|---|---|
|`subLineId`||

#### Returns

|Type|Description|
|---|---|
|`ClaimSubItem__c`|ClaimSubItem__c|


**Method** returnSubLine

### `private static void createMiscCharges(ClaimSubItem__c subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createMiscCharges

### `public static List<ClaimSubItem__c> readSubLines(Id serviceEstimateLineId)`
#### Parameters

|Param|Description|
|---|---|
|`serviceEstimateLineId`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimSubItem__c>`|List<ClaimSubItem__c>|


**Method** readSubLines

### `public static List<ClaimSubItem__c> readSubLines(set<Id> estimateLines)`
#### Parameters

|Param|Description|
|---|---|
|`estimateLines`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimSubItem__c>`|List<ClaimSubItem__c>|


**Method** readSubLines

### `public static List<ClaimSubItem__c> readSubLines(Id serviceEstimateLineId, String sublineType)`
#### Parameters

|Param|Description|
|---|---|
|`serviceEstimateLineId`||
|`sublineType`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimSubItem__c>`|List<ClaimSubItem__c>|


**Method** readSubLines

### `public static List<ClaimItem__c> estimateLines(Id estimateId)`

Getter for the estimate line items

#### Parameters

|Param|Description|
|---|---|
|`estimateId`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimItem__c>`|List<ClaimItem__c>|


**Method** estimateLines

### `public static List<MiscChargeCode__c> miscChargeCodes(Id locationId)`

Getter for the Misc Charge Types by Location

#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Returns

|Type|Description|
|---|---|
|`List<MiscChargeCode__c>`|List<MiscChargeCode__c>|


**Method** miscChargeCodes

### `global static claim claimData(Id claimId)`
#### Parameters

|Param|Description|
|---|---|
|`claimId`||

#### Returns

|Type|Description|
|---|---|
|`claim`|claim|


**Method** claimData

---
## Classes
### claim

Wrapper class for claim data and related records.

#### Constructors
##### `global claim()`
---
#### Properties

##### `global claimHeader` → `claim__c`


##### `global customer` → `Account`


##### `global employee` → `User`


##### `global claimEquipment` → `Equipment__c`


##### `global equipment` → `EquipmentInventory__c`


##### `global location` → `dealer_Location__c`


##### `global serviceVehicle` → `Service_Vehicle__c`


##### `global sro` → `Service_Repair_Order__c`


##### `global vehicle` → `Vehicle_Inventory__c`


##### `global appraisal` → `Appraisal__c`


##### `global cis` → `List&lt;dealer__ClaimItem__c&gt;`


---

### claimAPIException

**Inheritance**

claimAPIException


---
