---
layout: default
---
# CustomInvoice class

@description

---
## Methods
### `createLines(dealer__Service_Repair_Order__c ro, dealer__Deal__c dealObject)` → `Boolean`

JVK1 - Moved to seperate method so we can re-create lines if necessary

#### Parameters
|Param|Description|
|-----|-----------|
|`` | o |
|`` | t |

### `createROFromDeal(dealer__Deal__c dealObject)` → `dealer__Service_Repair_Order__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |

### `createServEst(List<dealer__Inspection_Report__c> inspReports, dealer__Deal__c dealObject)` → `List<dealer__Service_Estimate__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |
|`` | t |

---
