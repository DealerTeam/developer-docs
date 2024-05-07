---
layout: default
---
# claimViewController



**Class** claimViewController


**Group** Service

## Constructors
### `public claimViewController(ApexPages sc)`
#### Parameters

|Param|Description|
|---|---|
|`sc`||


**Method** claimViewController

---
## Properties

### `public claim` → `Claim__c`


### `public location` → `Dealer_Location__c`


### `public locations` → `List<Dealer_Location__c>`


---
## Methods
### `public String getDealerLocation()`
### `public Claim__c reloadDetail()`
#### Returns

|Type|Description|
|---|---|
|`Claim__c`|Claim__c|


**Method** reloadDetail

### `public list<OperationCodeGroup__c> getOpCodeHeaders()`
#### Returns

|Type|Description|
|---|---|
|`list<OperationCodeGroup__c>`|list<OperationCodeGroup__c>|


**Method** getOpCodeHeaders

### `public static OpGroup selectCodeGroup(String recordId)`

`REMOTEACTION`

selectCodeGroup

#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`OpGroup`|OpGroup|

### `public static String applyOpCodeToLine(String lineId, String opCodeId, String topLevelCodeGroupId, String clickPath)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineId`||
|`opCodeId`||
|`topLevelCodeGroupId`||
|`clickPath`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** applyOpCodeToLine

### `public static List<StandardOpCode__c> operationCodes(String selectedId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`selectedId`||

#### Returns

|Type|Description|
|---|---|
|`List<StandardOpCode__c>`|List<StandardOpCode__c>|


**Method** operationCodes

### `public static ClaimItem__c createEstimateLine(String jLine)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`jLine`||

#### Returns

|Type|Description|
|---|---|
|`ClaimItem__c`|ClaimItem__c|


**Method** createEstimateLine

### `public static ClaimItem__c updateEstimateLine(String line)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`line`||

#### Returns

|Type|Description|
|---|---|
|`ClaimItem__c`|ClaimItem__c|


**Method** updateEstimateLine

### `public static Boolean deleteEstimateLine(String lineId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineId`||

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** deleteEstimateLine

### `public static ClaimSubItem__c createSubLine(String subLine)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`subLine`||

#### Returns

|Type|Description|
|---|---|
|`ClaimSubItem__c`|ClaimSubItem__c|


**Method** createSubLine

### `public static List<ClaimSubItem__c> readSubLines(String lineRequest)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineRequest`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimSubItem__c>`|List<ClaimSubItem__c>|


**Method** readSubLines

### `public static ClaimSubItem__c updateSubLine(String lineRequest)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineRequest`||

#### Returns

|Type|Description|
|---|---|
|`ClaimSubItem__c`|ClaimSubItem__c|


**Method** updateSubLine

### `public static void deleteSubLine(String subLineId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`subLineId`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** deleteSubLine

### `public static List<ClaimItem__c> estimateLines(String estimateId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`estimateId`||

#### Returns

|Type|Description|
|---|---|
|`List<ClaimItem__c>`|List<ClaimItem__c>|


**Method** estimateLines

### `public static Decimal matrix(String pl)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`pl`||

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** matrix description

### `public static List<MiscChargeCode__c> miscChargeCodes(String locationId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Returns

|Type|Description|
|---|---|
|`List<MiscChargeCode__c>`|List<MiscChargeCode__c>|


**Method** miscChargeCodes

---
## Classes
### OpGroup
#### Constructors
##### `public OpGroup(OperationCodeGroup__c parent, List&lt;OperationCodeGroup__c&gt; children, List&lt;StandardOpCode__c&gt; opCodes)`
---
#### Properties

##### `public Parent` → `OperationCodeGroup__c`


##### `public Children` → `List&lt;OperationCodeGroup__c&gt;`


##### `public OpCodes` → `List&lt;StandardOpCode__c&gt;`


---

### ClaimAPIException

**Inheritance**

ClaimAPIException


---
