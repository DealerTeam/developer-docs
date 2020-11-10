---
layout: default
---
# PartsReturnController class
---
## Methods
### `deleteLine(String lineId)` → `Boolean`

removes a return line unchecks the order line as returned to vendor and reverses ledger

#### Parameters
|Param|Description|
|-----|-----------|
|`lineId` |  Parts_Invoice_Line__c to delete |

### `getAvailableOrders(String partId)` → `List<Purchase_Order_Line__c>`

Gets all Purchase_Order_Line__c records for a given part that have not been marked returned

#### Parameters
|Param|Description|
|-----|-----------|
|`partId` |  Id Parts_Inventory__c record |

### `getAvailableParts(String piId)` → `List<Parts_Inventory__c>`

Gets all Parts_Inventory__c records matching location from the Parts_Invoice__c Id provided

#### Parameters
|Param|Description|
|-----|-----------|
|`piId` |  Id Parts_Invoice__c record Id to retrieve location |

### `getPartLines(String piId)` → `List<Parts_Invoice_Line__c>`

Gets all Parts_Invoice_Line__c records for the Parts_Invoice__c Id provided

#### Parameters
|Param|Description|
|-----|-----------|
|`piId` |  Id Parts_Invoice__c record Id to retrieve lines |

### `getRecordTypeName(String rtId)` → `string`

Returns records type name from recordType Id

#### Parameters
|Param|Description|
|-----|-----------|
|`rtId` |  Id of the recordType to get name |

### `getReturn(String recordId)` → `Parts_Invoice__c`

Returns all fields from the Parts_Invoice__c record Id provided

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  Id of the Parts_Invoice__c to query |

### `invoiceReturn(String piId)` → `void`

marks Parts_Invoice__c record as invoiced

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  Id of the Parts_Invoice__c to invoice |

### `saveReturn(Parts_Invoice__c pi)` → `Parts_Invoice__c`

updates or creates new Parts_Invoice__c record with certain fields populated

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  Id of the Parts_Invoice__c to upsert |

### `saveReturnLine(String piId, Parts_Invoice_Line__c line)` → `void`

Process new return line, checks the order line as returned to vendor and updates ledger

#### Parameters
|Param|Description|
|-----|-----------|
|`piId` |  Id of the Parts_Invoice__c to create a line under |
|`line` |  Parts_Invoice_Line__c to create |

### `voidReturn(String piId)` → `void`

marks Parts_Invoice__c record as void

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  Id of the Parts_Invoice__c to void |

---
