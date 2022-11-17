# PurchaseOrder_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PurchaseOrder_EXT(ApexPages.standardController controller)`
---
## Fields

### `LINEPO` → `dealer__Purchase_Order_Line__c`


### `SUBLET_JOBLINE` → `dealer__Purchase_Order_Line__c`


### `transfer` → `dealer__PartTransfer__c`


---
## Properties

### `CHARGE_AMOUNT` → `String`


### `LINEAMT` → `Decimal`


### `LINEDESC` → `String`


### `LINEQTY` → `Decimal`


### `MISC_AMT` → `String`


### `MISC_DESC` → `String`


### `PartsMaster` → `dealer__Parts_Master__c`


### `SUBLET_AMOUNT` → `String`


### `SUBLET_LINEDESC` → `String`


### `SUBLET_NOTES` → `String`


### `TOADDRESS` → `String`


### `allowLeaveOpen` → `Boolean`


### `body` → `String`


### `ccAddress` → `String`


### `email` → `String`


### `job_line_id` → `String`


### `listAttachment` → `List<AttachmentClass>`


### `mapRecordType` → `map<id,string>`


### `objAttachment` → `Attachment`


### `ops` → `dealer__FixedOperationsSettings__c`


### `por` → `Purchase_Order_Receiving__c`


### `postingURL` → `String`


### `purchaseOrderLineMarkedForDeletion` → `String`


### `purchaseOrderLines` → `List<Purchase_Order_Line__c>`


### `receiveAccept` → `Boolean`


### `receiverLines` → `List<PurchaseOrder.lineReceiver>`


### `recordTypeName` → `String`


### `repair_order_id` → `String`


### `ro` → `dealer__Service_Repair_Order__c`


### `roLines` → `List<SelectOption>`


### `select_part_order_id` → `String`


### `subject` → `String`


### `vehicleStatusCode` → `String`


---
## Methods
### `getAllowSubletReversal()`

getAllowSubletReversal Getter method used to determine if the Org allows Purchase Order Reversal

#### Return

**Type**

Boolean

**Description**

boolean Is the DMS Feature "PurchaseOrderReversal" enabled

### `reversePurchaseOrder()`

reversePurchaseOrder Method to redirect to a custom visualforce page allowing the Purchaes Order to be Reversed

#### Return

**Type**

PageReference

**Description**

PageReferece /apex/c__PurchaseOrderReverse?Id=

### `getAttachments()`

Used to get all attachments related to the purchase order.

#### Return

**Type**

pagereference

**Description**

null pagereference


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `upload()`

Handles uploading attachments related to the purchase order.

#### Return

**Type**

PageReference

**Description**

null pagereference


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `gettransfer()`

**Method** gettransfer


**Test** PartOrderingUILayer.testVoid

### `getVehicleStatusOptions()`

Get Vehicle Inventory Status Code Values

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt; of available vehicle status options from vehicle inventory status codes.


**Test** PartOrderingUILayer.testVoid

### `partsLines()`
#### Return

**Type**

void

**Description**

void


**Method** PartsLines


**Notes** retrieves the parts lines and runs them through the pwrap class


**Test** PartOrderingUILayer.testVoid

### `getorderLines()`
#### Return

**Type**

List&lt;dealer__Parts_Order__c&gt;

**Description**

List&lt;dealer__Parts_Order__c&gt;


**Method** getOrderLines


**Notes** Retrieves a list of parts order lines associated with this Purchase Order


**Test** PartOrderingUILayer.testSubletPO

### `save()`

save Overload the save method

#### Return

**Type**

PageReference

**Description**

PageReference


**Notes** Custom save method specifically used to validate the Purchase Order at the time of Save.


**Test** PartOrderingUILayer.testSubletPO

### `voidPO()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** voidPO


**Notes** Void the purchase order to prevent adding content


**Test** PartOrderingUILayer.testVoidPO

### `unvoidPO()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** unvoicePO


**Notes** added to support the changing of the status of the purchase order


**Test** PartOrderingUILayer.testUnvoidPO

### `addSublet()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** addSublet


**Notes** adds sublet line to the purchase order


**Test** PartOrderingUILayer.testBlocks

### `closePurchaseOrder()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** closePurchaseOrder


**Notes** returns the Purchase Order Receive Page


**Test** PartOrderingUILayer.testSubletPO

### `acceptPO()`
#### Return

**Type**

PageReference

**Description**

pageReference


**Method** acceptPO


**Notes** method performs the users in store accept function.  This records who accepted the purchase order.  Only the Misc, Sublet and Vehicle PO Types are processed via this method.  Parts Purchase Orders are handled in a separete method.


**Test** PartOrderingUILayer.testSubletPO

### `postPO()`
### `returnToRepairOrder()`
### `receiveParts()`

Method to receive parts on an open purchaes order Update the Inventory History Increase the QOH - Physical Update FIFO/LIFO Table Hook to external Accounting Systems

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** receiveParts


**Test** PartOrderingUILayer.testSubletPO

### `findExisting()`

Find vehicle inventory by stock or VIN and set that to po

#### Return

**Type**

PageReference

**Description**

null PageReference


**Test** PartOrderingUILayer.testBlocks

### `decodeVIN()`

Find year,make,model from purchase order VIN and set to PO.

#### Return

**Type**

PageReference

**Description**

null PageReference


**Test** PartOrderingUILayer.testVehiclePurchase

### `addPOLine()`
### `savePOLines()`
### `deletePOLine()`
### `emailPO()`

Returns purchaseOrderEmail.page from PO

#### Return

**Type**

PageReference

**Description**

PageReference page.PurchaseOrderEmail


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `sendPdf()`

Sends email with PDF attached and generates completed task to log activity.

#### Return

**Type**

PageReference

**Description**

null PageReference if there are errors, otherwise returns purchase order page.


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `getLINEPO()`
### `getSUBLET_JOBLINE()`
### `newPartLine()`
### `selectExistingPartLine()`

selectExistingPartLine - Adds a part to a purchase order from the pre-populated Parts Order Lines as a result of selling the part negative


**Test** PartOrderingUILayer.testBlocks

### `AttachPDF()`

Handles finding and returning PDF for the PO

#### Return

**Type**

Messaging.EmailFileAttachment

**Description**

Messaging.EmailFileAttachment purchase order pdf


**Test** PartOrderingUILayer.testBlocks

### `static SavePartMaster(string jsonString)`

`REMOTEACTION`

Inserts PartsMaster from passed json string

#### Parameters

|Param|Description|
|---|---|
|`string`|JSON with part_master details to save|

#### Return

**Type**

string

**Description**

string with the name of parts master record inserted


**Test** PartOrderingUILayer.savePartMaster

---
## Classes
### AttachmentClass

Classes used for methods involving the PO attachment


**Test** PartOrderingUILayer.testBlocks

#### Constructors
##### `AttachmentClass(Attachment a)`
##### `AttachmentClass(boolean sel, Attachment a)`
---
#### Properties

##### `objAttachment` → `Attachment`


##### `selected` → `boolean`


---

### PurchaseOrderException

**Inheritance**

PurchaseOrderException


---
