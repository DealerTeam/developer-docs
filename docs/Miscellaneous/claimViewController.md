---
layout: default
---
# claimViewController class

@description

---
## Constructors
### `claimViewController(ApexPages.standardController sc)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | c |

---
## Properties

### `claim` → `Claim__c`

@description

### `location` → `Dealer_Location__c`

@description

### `locations` → `List<Dealer_Location__c>`

@description

---
## Methods
### `applyOpCodeToLine(String lineId, String opCodeId, String topLevelCodeGroupId, String clickPath)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | d |
|`` | d |
|`` | h |

### `createEstimateLine(String jLine)` → `ClaimItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `createSubLine(String subLine)` → `ClaimSubItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `deleteEstimateLine(String lineId)` → `Boolean`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `deleteSubLine(String subLineId)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `estimateLines(String estimateId)` → `List<ClaimItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getDealerLocation()` → `String`
### `getOpCodeHeaders()` → `list<OperationCodeGroup__c>`
### `matrix(String pl)` → `Decimal`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |

### `miscChargeCodes(String locationId)` → `List<MiscChargeCode__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `operationCodes(String selectedId)` → `List<StandardOpCode__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `readSubLines(String lineRequest)` → `List<ClaimSubItem__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `reloadDetail()` → `Claim__c`
### `selectCodeGroup(String recordId)` → `OpGroup`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `updateEstimateLine(String line)` → `ClaimItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `updateSubLine(String lineRequest)` → `ClaimSubItem__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

---
## Inner Classes

### claimViewController.ClaimAPIException class

@description

---
### claimViewController.OpGroup class

@description

---
#### Constructors
##### `OpGroup( OperationCodeGroup__c parent, List<OperationCodeGroup__c> children, List<StandardOpCode__c> opCodes)`
---
#### Properties

##### `Children` → `List<OperationCodeGroup__c>`

##### `OpCodes` → `List<StandardOpCode__c>`

##### `Parent` → `OperationCodeGroup__c`

---
