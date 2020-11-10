---
layout: default
---
# AppraisalNewController class
---
## Methods
### `createEstimate(String appId)` → `Service_Estimate__c`
### `createServiceVehicle(dealer__Service_Vehicle__c sv)` → `string`

 createServiceVehicle Checks if a service vehicle exists for a given vin & creates a record if one does not exist

#### Parameters
|Param|Description|
|-----|-----------|
|`sv` |  dealer__Service_Vehicle__c service vehicle to create |

### `getAppraisal(String appId)` → `Appraisal__c`
### `getExistingTrades(String VIN)` → `List<Trade_In__c>`

 getExistingTrades Get all trade ins related to a VIN

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  VIN The VIN to find related trades |

### `getObjectName(String objId)` → `string`

 getObjectName Calls utility class to return the object type for a given record id

#### Parameters
|Param|Description|
|-----|-----------|
|`objId` |  objId record id to retrieve the object type |

### `getReconCodes()` → `List<StandardOpCode__c>`
### `getRelatedVehicle(Id supId)` → `Service_Vehicle__c`

 getRelatedVehicle Get all service vehicles related to a sales up

#### Parameters
|Param|Description|
|-----|-----------|
|`supId` |  supId Id of sales up to find related service vehicles |

### `getServiceEstimateLines(String appId)` → `Service_Estimate__c`
### `getUserLocation(Id userId)` → `dealer__Dealer_Location__c`

 getUserLocation wired method that returns the location for the given user

#### Parameters
|Param|Description|
|-----|-----------|
|`userId` |  userId the user used to get a location |

### `handleDecode(String VIN)` → `Service_Vehicle__c`

 handleDecode Returns year, make and model for a given VIN

#### Parameters
|Param|Description|
|-----|-----------|
|`VIN` |  VIN The VIN to decode |

### `refreshEstimateLines(String appId)` → `Service_Estimate__c`
### `saveNewEstimateLine(Service_Estimate_Line__c line)` → `void`
### `updateTrades(List<Trade_In__c> trades, String app)` → `Boolean`

 updateTrades Updates the trades with a new appraisal id

#### Parameters
|Param|Description|
|-----|-----------|
|`trades` |  trades list of trades to update |
|`app` |     app id of the appraisal to relate to the trades |

---
## Inner Classes

### AppraisalNewController.AppraisalNewControllerException class
---
