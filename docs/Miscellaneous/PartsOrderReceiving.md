---
layout: default
---
# PartsOrderReceiving class
---
## Constructors
### `PartsOrderReceiving()`
---
## Properties

### `orderLines` → `list<dealer__Parts_Order__c>`

### `pqUpdate` → `list<dealer__Parts_Inventory__c>`

### `so` → `dealer__Stock_Order__c`

---
## Methods
### `saveOrderReceipt()` → `PageReference`

 Requires stock order to have a date of arrival and packing slip or error is thrown @function saveOrderReceipt @test PartOrderingServiceLayer.testPartsOrderReceiving

---
