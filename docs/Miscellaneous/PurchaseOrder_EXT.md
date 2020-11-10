---
layout: default
---
# PurchaseOrder_EXT class
---
## Constructors
### `PurchaseOrder_EXT(ApexPages.standardController controller)`
---
## Properties

### `CHARGE_AMOUNT` → `String`

### `LINEAMT` → `Decimal`

### `LINEDESC` → `String`

### `LINEPO` → `dealer__Purchase_Order_Line__c`

### `LINEQTY` → `Decimal`

### `MISC_AMT` → `String`

### `MISC_DESC` → `String`

### `PartsMaster` → `dealer__Parts_Master__c`

### `SUBLET_AMOUNT` → `String`

### `SUBLET_JOBLINE` → `dealer__Purchase_Order_Line__c`

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

### `transfer` → `dealer__PartTransfer__c`

### `vehicleStatusCode` → `String`

---
## Methods
### `AttachPDF()` → `Messaging.EmailFileAttachment`

 Handles finding and returning PDF for the PO

### `PartsLines()` → `void`

 PartsLines

### `SavePartMaster(string jsonString)` → `string`

 Inserts PartsMaster from passed json string

#### Parameters
|Param|Description|
|-----|-----------|
|`string` |  JSON with part_master details to save |

### `acceptPO()` → `PageReference`

 acceptPO

### `addPOLine()` → `PageReference`
### `addSublet()` → `PageReference`

 addSublet

### `closePurchaseOrder()` → `PageReference`

 closePurchaseOrder

### `decodeVIN()` → `PageReference`

 Find year,make,model from purchase order VIN and set to PO.

### `deletePOLine()` → `PageReference`
### `emailPO()` → `PageReference`

 Returns purchaseOrderEmail.page from PO

### `findExisting()` → `PageReference`

 Find vehicle inventory by stock or VIN and set that to po

### `getAllowSubletReversal()` → `Boolean`

 getAllowSubletReversal Getter method used to determine if the Org allows Purchase Order Reversal

### `getAttachments()` → `pagereference`

 Used to get all attachments related to the purchase order.

### `getLINEPO()` → `dealer__Purchase_Order_Line__c`
### `getSUBLET_JOBLINE()` → `dealer__Purchase_Order_Line__c`
### `getVehicleStatusOptions()` → `List<SelectOption>`

 Get Vehicle Inventory Status Code Values

### `getorderLines()` → `List<dealer__Parts_Order__c>`

 getOrderLines

### `gettransfer()` → `dealer__PartTransfer__c`

 @test PartOrderingUILayer.testVoid

### `newPartLine()` → `PageReference`
### `postPO()` → `PageReference`
### `receiveParts()` → `PageReference`

 receiveParts

### `returnToRepairOrder()` → `PageReference`
### `reversePurchaseOrder()` → `PageReference`

 reversePurchaseOrder Method to redirect to a custom visualforce page allowing the Purchaes Order to be Reversed

### `save()` → `PageReference`

 save Overload the save method

### `savePOLines()` → `Pagereference`
### `selectExistingPartLine()` → `PageReference`

 selectExistingPartLine - Adds a part to a purchase order from the pre-populated Parts Order Lines as a result of selling the part negative @test PartOrderingUILayer.testBlocks

### `sendPdf()` → `PageReference`

 Sends email with PDF attached and generates completed task to log activity.

### `unvoidPO()` → `PageReference`

 unvoicePO

### `upload()` → `PageReference`

 Handles uploading attachments related to the purchase order.

### `voidPO()` → `PageReference`

 voidPO

---
## Inner Classes

### PurchaseOrder_EXT.AttachmentClass class

 Classes used for methods involving the PO attachment @test PartOrderingUILayer.testBlocks

---
#### Properties

##### `objAttachment` → `Attachment`

##### `selected` → `boolean`

---
#### Methods
##### `attachmentClass(Attachment a)` → `public`
##### `attachmentClass(boolean sel,Attachment a)` → `public`
---
### PurchaseOrder_EXT.PurchaseOrderException class
---
