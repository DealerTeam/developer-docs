---
layout: default
---
# PurchaseOrder_EXT



**Group** Parts

## Constructors
### `public PurchaseOrder_EXT(ApexPages controller)`
---
## Fields

### `private po` → `dealer__Purchase_Order__c`


### `private defaultAttachment` → `Messaging`


### `public SUBLET_JOBLINE` → `dealer__Purchase_Order_Line__c`


### `public LINEPO` → `dealer__Purchase_Order_Line__c`


### `public transfer` → `dealer__PartTransfer__c`


---
## Properties

### `public email` → `String`


### `public subject` → `String`


### `public body` → `String`


### `public TOADDRESS` → `String`


### `public ccAddress` → `String`


### `public listAttachment` → `List<AttachmentClass>`


### `public objAttachment` → `Attachment`


### `public ro` → `dealer__Service_Repair_Order__c`


### `public PartsMaster` → `dealer__Parts_Master__c`


### `public ops` → `dealer__FixedOperationsSettings__c`


### `public postingURL` → `String`


### `public receiverLines` → `List<PurchaseOrder.lineReceiver>`


### `public por` → `Purchase_Order_Receiving__c`


### `public mapRecordType` → `map<id,string>`


### `public receiveAccept` → `Boolean`


### `public allowLeaveOpen` → `Boolean`


### `public recordTypeName` → `String`


### `public LINEQTY` → `Decimal`


### `public LINEAMT` → `Decimal`


### `public LINEDESC` → `String`


### `public SUBLET_LINEDESC` → `String`


### `public SUBLET_AMOUNT` → `String`


### `public CHARGE_AMOUNT` → `String`


### `public SUBLET_NOTES` → `String`


### `public repair_order_id` → `String`


### `public select_part_order_id` → `String`


### `public job_line_id` → `String`


### `public vehicleStatusCode` → `String`


### `public MISC_DESC` → `String`


### `public MISC_AMT` → `String`


### `public roLines` → `List<SelectOption>`


### `public purchaseOrderLines` → `List<Purchase_Order_Line__c>`


### `public purchaseOrderLineMarkedForDeletion` → `String`


---
## Methods
### `public Boolean getAllowSubletReversal()`

getAllowSubletReversal Getter method used to determine if the Org allows Purchase Order Reversal

#### Returns

|Type|Description|
|---|---|
|`Boolean`|boolean Is the DMS Feature "PurchaseOrderReversal" enabled|

### `public PageReference reversePurchaseOrder()`

reversePurchaseOrder Method to redirect to a custom visualforce page allowing the Purchaes Order to be Reversed

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReferece /apex/c__PurchaseOrderReverse?Id=|

### `public pagereference getAttachments()`

Used to get all attachments related to the purchase order.

#### Returns

|Type|Description|
|---|---|
|`pagereference`|null pagereference|


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `public PageReference upload()`

Handles uploading attachments related to the purchase order.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|null pagereference|


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `public dealer__PartTransfer__c gettransfer()`

**Method** gettransfer


**Test** PartOrderingUILayer.testVoid

### `public List<SelectOption> getVehicleStatusOptions()`

Get Vehicle Inventory Status Code Values

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption> of available vehicle status options from vehicle inventory status codes.|


**Test** PartOrderingUILayer.testVoid

### `public void partsLines()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** PartsLines


**Notes** retrieves the parts lines and runs them through the pwrap class


**Test** PartOrderingUILayer.testVoid

### `public List<dealer__Parts_Order__c> getorderLines()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Order__c>`|List<dealer__Parts_Order__c>|


**Method** getOrderLines


**Notes** Retrieves a list of parts order lines associated with this Purchase Order


**Test** PartOrderingUILayer.testSubletPO

### `public PageReference save()`

save Overload the save method

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Notes** Custom save method specifically used to validate the Purchase Order at the time of Save.


**Test** PartOrderingUILayer.testSubletPO

### `public PageReference voidPO()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** voidPO


**Notes** Void the purchase order to prevent adding content


**Test** PartOrderingUILayer.testVoidPO

### `public PageReference unvoidPO()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** unvoicePO


**Notes** added to support the changing of the status of the purchase order


**Test** PartOrderingUILayer.testUnvoidPO

### `public PageReference addSublet()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** addSublet


**Notes** adds sublet line to the purchase order


**Test** PartOrderingUILayer.testBlocks

### `public PageReference closePurchaseOrder()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** closePurchaseOrder


**Notes** returns the Purchase Order Receive Page


**Test** PartOrderingUILayer.testSubletPO

### `public PageReference acceptPO()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|pageReference|


**Method** acceptPO


**Notes** method performs the users in store accept function.  This records who accepted the purchase order.  Only the Misc, Sublet and Vehicle PO Types are processed via this method.  Parts Purchase Orders are handled in a separete method.


**Test** PartOrderingUILayer.testSubletPO

### `public PageReference postPO()`
### `public PageReference returnToRepairOrder()`
### `public PageReference receiveParts()`

Method to receive parts on an open purchaes order Update the Inventory History Increase the QOH - Physical Update FIFO/LIFO Table Hook to external Accounting Systems

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** receiveParts


**Test** PartOrderingUILayer.testSubletPO

### `public PageReference findExisting()`

Find vehicle inventory by stock or VIN and set that to po

#### Returns

|Type|Description|
|---|---|
|`PageReference`|null PageReference|


**Test** PartOrderingUILayer.testBlocks

### `public PageReference decodeVIN()`

Find year,make,model from purchase order VIN and set to PO.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|null PageReference|


**Test** PartOrderingUILayer.testVehiclePurchase

### `public PageReference addPOLine()`
### `public Pagereference savePOLines()`
### `public PageReference deletePOLine()`
### `public PageReference emailPO()`

Returns purchaseOrderEmail.page from PO

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference page.PurchaseOrderEmail|


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `public PageReference sendPdf()`

Sends email with PDF attached and generates completed task to log activity.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|null PageReference if there are errors, otherwise returns purchase order page.|


**Test** PartOrderingUILayer.testPurchaseOrderEXT

### `public dealer__Purchase_Order_Line__c getLINEPO()`
### `public dealer__Purchase_Order_Line__c getSUBLET_JOBLINE()`
### `public PageReference newPartLine()`
### `public PageReference selectExistingPartLine()`

selectExistingPartLine - Adds a part to a purchase order from the pre-populated Parts Order Lines as a result of selling the part negative


**Test** PartOrderingUILayer.testBlocks

### `public Messaging AttachPDF()`

Handles finding and returning PDF for the PO

#### Returns

|Type|Description|
|---|---|
|`Messaging`|Messaging.EmailFileAttachment purchase order pdf|


**Test** PartOrderingUILayer.testBlocks

### `public static string SavePartMaster(string jsonString)`

`REMOTEACTION`

Inserts PartsMaster from passed json string

#### Parameters

|Param|Description|
|---|---|
|`string`|JSON with part_master details to save|

#### Returns

|Type|Description|
|---|---|
|`string`|string with the name of parts master record inserted|


**Test** PartOrderingUILayer.savePartMaster

---
## Classes
### PurchaseOrderException

**Inheritance**

PurchaseOrderException


### AttachmentClass

Classes used for methods involving the PO attachment


**Test** PartOrderingUILayer.testBlocks

#### Constructors
##### `public AttachmentClass(Attachment a)`
##### `public AttachmentClass(boolean sel, Attachment a)`
---
#### Properties

##### `public selected` → `boolean`


##### `public objAttachment` → `Attachment`


---

---
