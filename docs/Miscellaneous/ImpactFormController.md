---
layout: default
---
# ImpactFormController
## Constructors
### `public ImpactFormController(ApexPages controller)`
---
## Properties

### `public form` → `Form__c`


### `public location` → `dealer__Dealer_Location__c`


### `public formId` → `Id`


### `public dealId` → `Id`


### `public disablePrint` → `Boolean`


### `public deal` → `dealer__Deal__c`


### `public ports` → `port`


### `public lexOrigin` → `string`


---
## Methods
### `public Component getcompiled_form()`
### `public String getcompiled_ports()`
### `public String getRecentPrinter()`

returns saved impact printer or null if none

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** getRecentPrinter

### `public String base64Decode(String s)`
### `global static string setRecentPrinter(String printerName)`

`REMOTEACTION`

saved the provided printer to the user's custom setting

#### Parameters

|Param|Description|
|---|---|
|`printerName`|printerName description|

#### Returns

|Type|Description|
|---|---|
|`string`|return description|


**Method** setRecentPrinter

### `public void print()`
---
## Classes
### port
#### Constructors
##### `public port(String securePorts, String nonsecurePorts)`
---
#### Fields

##### `public secure` → `List&lt;Integer&gt;`


##### `public nonsecure` → `List&lt;Integer&gt;`


---
#### Methods
##### `private List&lt;Integer&gt; parsePorts(String ports)`

converts a string of comma separated ports intos a list of integers for use in JS

###### Parameters

|Param|Description|
|---|---|
|`ports`|ports description|

###### Returns

|Type|Description|
|---|---|
|`List&lt;Integer&gt;`|return description|


**Method** parsePorts

---

---
