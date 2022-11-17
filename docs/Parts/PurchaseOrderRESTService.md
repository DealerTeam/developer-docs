# PurchaseOrderRESTService

`RESTRESOURCE`

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PurchaseOrderRESTService()`
---
## Methods
### `static createPurchaseOrder()`

`HTTPPOST`
#### Return

**Type**

Id

**Description**

s Id of purchase order created


**Method** createPurchaseOrder


**Test** PartOrderingServiceLayer.testPORESTService

### `static updatePurchaseOrder()`

`HTTPPUT`

Can update Purchase Order OR create new lines for a purchase order Can use HTTP Put to do the

#### Return

**Type**

String

**Description**

String of JSON serialized PO


**Test** PartOrderingServiceLayer.testPORESTService

### `static processPurchaseOrder()`

`HTTPPATCH`
### `static deletePOLines()`

`HTTPDELETE`

Handle httpdelete for PO Lines


**Test** PartOrderingServiceLayer.testPORESTService

---
## Classes
### PurchaseOrderRestServiceException

**Inheritance**

PurchaseOrderRestServiceException


---
