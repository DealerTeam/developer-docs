---
layout: default
---
# PurchaseOrderRESTService

`RESTRESOURCE`



**Group** Parts

## Constructors
### `public PurchaseOrderRESTService()`
---
## Methods
### `global static Id createPurchaseOrder()`

`HTTPPOST`
#### Returns

|Type|Description|
|---|---|
|`Id`|s Id of purchase order created|


**Method** createPurchaseOrder


**Test** PartOrderingServiceLayer.testPORESTService

### `global static String updatePurchaseOrder()`

`HTTPPUT`

Can update Purchase Order OR create new lines for a purchase order Can use HTTP Put to do the

#### Returns

|Type|Description|
|---|---|
|`String`|String of JSON serialized PO|


**Test** PartOrderingServiceLayer.testPORESTService

### `global static String processPurchaseOrder()`

`HTTPPATCH`
### `global static Void deletePOLines()`

`HTTPDELETE`

Handle httpdelete for PO Lines


**Test** PartOrderingServiceLayer.testPORESTService

---
## Classes
### PurchaseOrderRestServiceException

**Inheritance**

PurchaseOrderRestServiceException


---
