---
layout: default
---
# ClaimAPI class

@description

---
## Methods
### `claimData(Id claimId)` → `claim`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `createEstimateLine(ClaimItem__c line)` → `ClaimItem__c`

Used within the claim creation process

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `createSubLine(ClaimSubItem__c subLine)` → `ClaimSubItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `deleteEstimateLine(Id lineId)` → `Boolean`

Delete line call

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `deleteSubLine(Id subLine)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `estimateLines(Id estimateId)` → `List<ClaimItem__c>`

Getter for the estimate line items

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `estimateSubLines(Id lineId)` → `List<ClaimSubItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `miscChargeCodes(Id locationId)` → `List<MiscChargeCode__c>`

Getter for the Misc Charge Types by Location

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `readSubLines(Id serviceEstimateLineId)` → `List<ClaimSubItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | e |
|`` | d |

### `readSubLines(set<Id> estimateLines)` → `List<ClaimSubItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `readSubLines(Id serviceEstimateLineId, String sublineType)` → `List<ClaimSubItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | e |

### `updateEstimateLine(ClaimItem__c line)` → `ClaimItem__c`

Update line call

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `updateSubLine(ClaimSubItem__c subLine)` → `ClaimSubItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

---
## Inner Classes

### ClaimAPI.claim class

Wrapper class for claim data and related records.

---
#### Constructors
##### `claim()`
---
#### Properties

##### `appraisal` → `Appraisal__c`

##### `cis` → `List<dealer__ClaimItem__c>`

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
### ClaimAPI.claimAPIException class

@description

---
