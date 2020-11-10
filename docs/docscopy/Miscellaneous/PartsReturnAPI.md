---
layout: default
---
# PartsReturnAPI class
---
## Methods
### `addReturnLine(Parts_Invoice__c pi, Parts_Invoice_Line__c returnLine)` → `void`

 Performs the process of adding a line to the Parts Return

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |          Parts Invoice |
|`returnLine` |  Parts_Invoice_Line__c to return |

### `deleteLine(Parts_Invoice_Line__c line)` → `void`

 Deletes Part Line

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `getInvoiceLines(Parts_Invoice__c pi)` → `List<Parts_Invoice_Line__c>`

 Parts Lines added to the Return Invoice

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |  Parts Invoice |

### `getPoLines(Parts_Inventory__c part)` → `List<SelectOption>`

 SelectOptions of all purchase orders this part was sold against that do not have a sell out line

#### Parameters
|Param|Description|
|-----|-----------|
|`part` |  Part |

### `invoiceRecord(Parts_Invoice__c pi)` → `void`

 invoice the record and prepare for posting to General Ledger

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |  Parts Invoice |

### `savePartsInvoice(Parts_Invoice__c pi)` → `Parts_Invoice__c`

 Creates or updates a Parts Invoice

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |  Parts_Invoice__c |

### `sendAccountingMessage(Parts_Invoice__c pi)` → `void`

 Sends Accounting Email to accounting solution

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |  Parts Invoice |

### `voidPartsInvoice(Parts_Invoice__c pi)` → `void`

 void if no lines are present

#### Parameters
|Param|Description|
|-----|-----------|
|`pi` |  Parts Invoice |

---
## Inner Classes

### PartsReturnAPI.PartsReturnAPIException class
---
