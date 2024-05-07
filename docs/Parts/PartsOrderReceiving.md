---
layout: default
---
# PartsOrderReceiving



**Group** Parts

## Constructors
### `public PartsOrderReceiving()`
---
## Properties

### `public so` → `dealer__Stock_Order__c`


### `public orderLines` → `list<dealer__Parts_Order__c>`


### `public pqUpdate` → `list<dealer__Parts_Inventory__c>`


---
## Methods
### `public PageReference saveOrderReceipt()`

Requires stock order to have a date of arrival and packing slip or error is thrown


**Function** saveOrderReceipt


**Test** PartOrderingServiceLayer.testPartsOrderReceiving

---
