---
layout: default
---
# OutboundFileTransferAPI class
---
## Methods
### `futureCallout(Id oftId)` → `void`
### `getAllLocations()` → `List<Dealer_Location__c>`

Queries for all Dealer Location records and returns them

### `getDynamicFileName(OFTJob__c oft)` → `string`

evaluates a formula in visualforce formula syntax to allow for dynamic file naming

#### Parameters
|Param|Description|
|-----|-----------|
|`oft` |  Outbound File Transfer record with name to evaluate |

### `getEncapsulationType(String encapsulation)` → `string`

Converts encapsulation type name to it's literal representation

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  encapsulation The name to convert |

### `getOFT(String recordId)` → `OFTJob__c`
### `runOFT(Id oftId)` → `void`

 runOFT Used to enable running from a quick action

#### Parameters
|Param|Description|
|-----|-----------|
|`oftId` |  record id of the OFTJob__c calling the quick action |

### `saveStores(OFTJob__c job)` → `void`
---
## Inner Classes

### OutboundFileTransferAPI.OFTRequest class
---
#### Properties

##### `delimiter` → `string`

##### `encapsulation` → `Boolean`

##### `encapsulationChar` → `string`

##### `filename` → `string`

##### `host` → `string`

##### `isBulk` → `Boolean`

##### `isPrivate` → `Boolean`

##### `locations` → `String`

##### `organizationId` → `string`

##### `password` → `string`

##### `port` → `Integer`

##### `predefinedFunction` → `String`

##### `query` → `string`

##### `recordId` → `string`

##### `sessionId` → `string`

##### `timeout` → `integer`

##### `transport` → `string`

##### `url` → `string`

##### `user` → `string`

---
