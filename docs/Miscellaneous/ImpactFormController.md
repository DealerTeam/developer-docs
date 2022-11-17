# ImpactFormController

`APIVERSION: 51`

`STATUS: ACTIVE`
## Constructors
### `ImpactFormController(ApexPages.StandardController controller)`
---
## Properties

### `deal` → `dealer__Deal__c`


### `dealId` → `Id`


### `disablePrint` → `Boolean`


### `form` → `Form__c`


### `formId` → `Id`


### `lexOrigin` → `string`


### `location` → `dealer__Dealer_Location__c`


### `ports` → `port`


---
## Methods
### `getcompiled_form()`
### `getcompiled_ports()`
### `getRecentPrinter()`

returns saved impact printer or null if none

#### Return

**Type**

String

**Description**

return description


**Method** getRecentPrinter

### `base64Decode(String s)`
### `static setRecentPrinter(String printerName)`

`REMOTEACTION`

saved the provided printer to the user's custom setting

#### Parameters

|Param|Description|
|---|---|
|`printerName`|printerName description|

#### Return

**Type**

string

**Description**

return description


**Method** setRecentPrinter

### `print()`
---
## Classes
### port
#### Constructors
##### `port(String securePorts, String nonsecurePorts)`
---
#### Fields

##### `nonsecure` → `List&lt;Integer&gt;`


##### `secure` → `List&lt;Integer&gt;`


---

---
