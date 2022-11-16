# PartsOrderReceiving

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartsOrderReceiving()`
---
## Properties

### `orderLines` → `list<dealer__Parts_Order__c>`


### `pqUpdate` → `list<dealer__Parts_Inventory__c>`


### `so` → `dealer__Stock_Order__c`


---
## Methods
### `saveOrderReceipt()`

Requires stock order to have a date of arrival and packing slip or error is thrown


**Function** saveOrderReceipt


**Test** PartOrderingServiceLayer.testPartsOrderReceiving

---
