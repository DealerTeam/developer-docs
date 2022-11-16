# claimViewController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** claimViewController


**Group** Service

## Constructors
### `claimViewController(ApexPages.standardController sc)`
#### Parameters

|Param|Description|
|---|---|
|`sc`||


**Method** claimViewController

---
## Properties

### `claim` → `Claim__c`


### `location` → `Dealer_Location__c`


### `locations` → `List<Dealer_Location__c>`


---
## Methods
### `getDealerLocation()`
### `reloadDetail()`
#### Return

**Type**

Claim__c

**Description**

Claim__c


**Method** reloadDetail

### `getOpCodeHeaders()`
#### Return

**Type**

list&lt;OperationCodeGroup__c&gt;

**Description**

list&lt;OperationCodeGroup__c&gt;


**Method** getOpCodeHeaders

### `static selectCodeGroup(String recordId)`

`REMOTEACTION`

selectCodeGroup

#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Return

**Type**

OpGroup

**Description**

OpGroup

### `static applyOpCodeToLine(String lineId, String opCodeId, String topLevelCodeGroupId, String clickPath)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineId`||
|`opCodeId`||
|`topLevelCodeGroupId`||
|`clickPath`||

#### Return

**Type**

String

**Description**

String


**Method** applyOpCodeToLine

### `static operationCodes(String selectedId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`selectedId`||

#### Return

**Type**

List&lt;StandardOpCode__c&gt;

**Description**

List&lt;StandardOpCode__c&gt;


**Method** operationCodes

### `static createEstimateLine(String jLine)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`jLine`||

#### Return

**Type**

ClaimItem__c

**Description**

ClaimItem__c


**Method** createEstimateLine

### `static updateEstimateLine(String line)`

`REMOTEACTION`
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

### `static deleteEstimateLine(String lineId)`

`REMOTEACTION`
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

### `static createSubLine(String subLine)`

`REMOTEACTION`
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

### `static readSubLines(String lineRequest)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineRequest`||

#### Return

**Type**

List&lt;ClaimSubItem__c&gt;

**Description**

List&lt;ClaimSubItem__c&gt;


**Method** readSubLines

### `static updateSubLine(String lineRequest)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`lineRequest`||

#### Return

**Type**

ClaimSubItem__c

**Description**

ClaimSubItem__c


**Method** updateSubLine

### `static deleteSubLine(String subLineId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`subLineId`||

#### Return

**Type**

void

**Description**

void


**Method** deleteSubLine

### `static estimateLines(String estimateId)`

`REMOTEACTION`
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

### `static matrix(String pl)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`pl`||

#### Return

**Type**

Decimal

**Description**

Decimal


**Method** matrix description

### `static miscChargeCodes(String locationId)`

`REMOTEACTION`
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

---
## Classes
### ClaimAPIException

**Inheritance**

ClaimAPIException


### OpGroup
#### Constructors
##### `OpGroup(OperationCodeGroup__c parent, List&lt;OperationCodeGroup__c&gt; children, List&lt;StandardOpCode__c&gt; opCodes)`
---
#### Properties

##### `Children` → `List&lt;OperationCodeGroup__c&gt;`


##### `OpCodes` → `List&lt;StandardOpCode__c&gt;`


##### `Parent` → `OperationCodeGroup__c`


---

---
