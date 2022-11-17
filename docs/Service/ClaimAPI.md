# ClaimAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** ClaimAPI


**Group** Service

## Methods
### `static createEstimateLine(ClaimItem__c line)`

Used within the claim creation process

#### Parameters

|Param|Description|
|---|---|
|`line`||

#### Return

**Type**

ClaimItem__c

**Description**

ClaimItem__c


**Method** createEstimateLine - creation of an estimate line

### `static updateEstimateLine(ClaimItem__c line)`

Update line call

#### Parameters

|Param|Description|
|---|---|
|`line`||

#### Return

**Type**

ClaimItem__c

**Description**

ClaimItem__c


**Method** updateEstimateLine

### `static deleteEstimateLine(Id lineId)`

Delete line call

#### Parameters

|Param|Description|
|---|---|
|`lineId`||

#### Return

**Type**

Boolean

**Description**

Boolean


**Method** deleteEstimateLine

### `static estimateSubLines(Id lineId)`
#### Parameters

|Param|Description|
|---|---|
|`lineId`||

#### Return

**Type**

List&lt;ClaimSubItem__c&gt;

**Description**

List&lt;ClaimSubItem__c&gt;


**Method** estimateSubLines

### `static createSubLine(ClaimSubItem__c subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Return

**Type**

ClaimSubItem__c

**Description**

ClaimSubItem__c


**Method** createSubLine

### `static updateSubLine(ClaimSubItem__c subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Return

**Type**

ClaimSubItem__c

**Description**

ClaimSubItem__c


**Method** updateSubLine

### `static deleteSubLine(Id subLine)`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Return

**Type**

void

**Description**

void


**Method** deleteSubLine

### `static readSubLines(Id serviceEstimateLineId)`
#### Parameters

|Param|Description|
|---|---|
|`serviceEstimateLineId`||

#### Return

**Type**

List&lt;ClaimSubItem__c&gt;

**Description**

List&lt;ClaimSubItem__c&gt;


**Method** readSubLines

### `static readSubLines(set<Id> estimateLines)`
#### Parameters

|Param|Description|
|---|---|
|`estimateLines`||

#### Return

**Type**

List&lt;ClaimSubItem__c&gt;

**Description**

List&lt;ClaimSubItem__c&gt;


**Method** readSubLines

### `static readSubLines(Id serviceEstimateLineId, String sublineType)`
#### Parameters

|Param|Description|
|---|---|
|`serviceEstimateLineId`||
|`sublineType`||

#### Return

**Type**

List&lt;ClaimSubItem__c&gt;

**Description**

List&lt;ClaimSubItem__c&gt;


**Method** readSubLines

### `static estimateLines(Id estimateId)`

Getter for the estimate line items

#### Parameters

|Param|Description|
|---|---|
|`estimateId`||

#### Return

**Type**

List&lt;ClaimItem__c&gt;

**Description**

List&lt;ClaimItem__c&gt;


**Method** estimateLines

### `static miscChargeCodes(Id locationId)`

Getter for the Misc Charge Types by Location

#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Return

**Type**

List&lt;MiscChargeCode__c&gt;

**Description**

List&lt;MiscChargeCode__c&gt;


**Method** miscChargeCodes

### `static claimData(Id claimId)`
#### Parameters

|Param|Description|
|---|---|
|`claimId`||

#### Return

**Type**

claim

**Description**

claim


**Method** claimData

---
## Classes
### claim

Wrapper class for claim data and related records.

#### Constructors
##### `claim()`
---
#### Properties

##### `appraisal` → `Appraisal__c`


##### `cis` → `List&lt;dealer__ClaimItem__c&gt;`


##### `claimEquipment` → `Equipment__c`


##### `claimHeader` → `claim__c`


##### `customer` → `Account`


##### `employee` → `User`


##### `equipment` → `EquipmentInventory__c`


##### `location` → `dealer_Location__c`


##### `serviceVehicle` → `Service_Vehicle__c`


##### `sro` → `Service_Repair_Order__c`


##### `vehicle` → `Vehicle_Inventory__c`


---

### claimAPIException

**Inheritance**

claimAPIException


---
