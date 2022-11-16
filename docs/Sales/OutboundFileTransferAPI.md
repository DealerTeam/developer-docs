# OutboundFileTransferAPI

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static futureCallout(Id oftId)`

`FUTURE`
### `static runOFT(Id oftId)`

`AURAENABLED`

runOFT Used to enable running from a quick action

#### Parameters

|Param|Description|
|---|---|
|`oftId`|record id of the OFTJob__c calling the quick action|

### `static getDynamicFileName(OFTJob__c oft)`

evaluates a formula in visualforce formula syntax to allow for dynamic file naming

#### Parameters

|Param|Description|
|---|---|
|`oft`|Outbound File Transfer record with name to evaluate|

#### Return

**Type**

string

**Description**

String dynamic file name or the original ExportFileName if null, with .extensions for a complete file name


**Method** getDynamicFileName

### `static getEncapsulationType(String encapsulation)`

Converts encapsulation type name to it's literal representation

#### Parameters

|Param|Description|
|---|---|
|`String`|encapsulation The name to convert|

#### Return

**Type**

string

**Description**

String converted encapsulation type able to be ingested by middleware


**Method** getEncapsulationType

### `static getOFT(String recordId)`

`AURAENABLED`
### `static getAllLocations()`

`AURAENABLED`

Queries for all Dealer Location records and returns them

#### Return

**Type**

List&lt;Dealer_Location__c&gt;

**Description**

List&lt;Dealer_Location__c&gt;


**Method** getAllLocations

### `static saveStores(OFTJob__c job)`

`AURAENABLED`
---
## Classes
### OFTRequest
#### Properties

##### `customFields` → `string`


##### `delimiter` → `string`


##### `encapsulation` → `Boolean`


##### `encapsulationChar` → `string`


##### `filename` → `string`


##### `headerFields` → `string`


##### `headerLabels` → `string`


##### `host` → `string`


##### `isBulk` → `Boolean`


##### `isPrivate` → `Boolean`


##### `locations` → `String`


##### `oftName` → `String`


##### `organizationId` → `string`


##### `password` → `string`


##### `port` → `Integer`


##### `predefinedFunction` → `String`


##### `privacyPolicy` → `String`


##### `query` → `string`


##### `recordId` → `string`


##### `restEndpoint` → `String`


##### `restMethod` → `String`


##### `restPayload` → `String`


##### `sessionId` → `string`


##### `storePayloadAsFile` → `Boolean`


##### `timeout` → `integer`


##### `transport` → `string`


##### `url` → `string`


##### `user` → `string`


---

---
