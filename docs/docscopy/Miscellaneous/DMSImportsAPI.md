---
layout: default
---
# DMSImportsAPI class

@description

---
## Methods
### `cleanAccounts(List<Account> sfAccts, List<Account> dmsAccts )` → `void`

compares data from DMS to CRM and removes invalid External Ids from Accounts

### `cleanRecords(String type, String objJSON)` → `String`
### `deleteVehicleInventory(String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `routeObject(String type, String objJSON, String jobId)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | N |
|`` | d |

### `syncAccount(String AccountJSON)` → `void`
### `upsertAccounts(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertDeals(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertLocations(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertPartsInventory(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertPartsMasters(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertSalesFees(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertServiceJobLines(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertServiceRepairOrders(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertServiceVehicle(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertStandardOpCodes(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertTradeIns(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `upsertVehicleInventory(String jobId, String objJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

---
## Inner Classes

### DMSImportsAPI.result class

@description

---
#### Constructors
##### `result(List<STring> successes, List<String> errors)`
---
#### Properties

##### `Errors` → `List<String>`

##### `Successes` → `List<String>`

---
### DMSImportsAPI.vehicleResult class
---
#### Constructors
##### `vehicleResult(Map<Id, Vehicle_Inventory__c> Successes, List<String> Errors)`
---
#### Properties

##### `Errors` → `List<String>`

##### `Successes` → `Vehicle_Inventory__c>`

---
