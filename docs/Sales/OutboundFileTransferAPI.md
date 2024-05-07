---
layout: default
---
# OutboundFileTransferAPI



**Group** Sales

## Methods
### `public static void futureCallout(Id oftId)`

`FUTURE`
### `public static void runOFT(Id oftId)`

`AURAENABLED`

runOFT Used to enable running from a quick action

#### Parameters

|Param|Description|
|---|---|
|`oftId`|record id of the OFTJob__c calling the quick action|

### `public static string getDynamicFileName(OFTJob__c oft)`

evaluates a formula in visualforce formula syntax to allow for dynamic file naming

#### Parameters

|Param|Description|
|---|---|
|`oft`|Outbound File Transfer record with name to evaluate|

#### Returns

|Type|Description|
|---|---|
|`string`|String dynamic file name or the original ExportFileName if null, with .extensions for a complete file name|


**Method** getDynamicFileName

### `public static string getEncapsulationType(String encapsulation)`

Converts encapsulation type name to it's literal representation

#### Parameters

|Param|Description|
|---|---|
|`String`|encapsulation The name to convert|

#### Returns

|Type|Description|
|---|---|
|`string`|String converted encapsulation type able to be ingested by middleware|


**Method** getEncapsulationType

### `public static OFTJob__c getOFT(String recordId)`

`AURAENABLED`
### `public static List<Dealer_Location__c> getAllLocations()`

`AURAENABLED`

Queries for all Dealer Location records and returns them

#### Returns

|Type|Description|
|---|---|
|`List<Dealer_Location__c>`|List<Dealer_Location__c>|


**Method** getAllLocations

### `public static void saveStores(OFTJob__c job)`

`AURAENABLED`
---
## Classes
### OFTRequest
#### Properties

##### `public host` → `string`


##### `public port` → `Integer`


##### `public user` → `string`


##### `public password` → `string`


##### `public remote` → `string`


##### `public filename` → `string`


##### `public delimiter` → `string`


##### `public encapsulation` → `Boolean`


##### `public encapsulationChar` → `string`


##### `public headerFields` → `string`


##### `public headerLabels` → `string`


##### `public customFields` → `string`


##### `public organizationId` → `string`


##### `public url` → `string`


##### `public sessionId` → `string`


##### `public query` → `string`


##### `public recordId` → `string`


##### `public timeout` → `integer`


##### `public transport` → `string`


##### `public isPrivate` → `Boolean`


##### `public isBulk` → `Boolean`


##### `public predefinedFunction` → `String`


##### `public locations` → `String`


##### `public restEndpoint` → `String`


##### `public restPayload` → `String`


##### `public restMethod` → `String`


##### `public oftName` → `String`


##### `public storePayloadAsFile` → `Boolean`


##### `public privacyPolicy` → `String`


---

---
