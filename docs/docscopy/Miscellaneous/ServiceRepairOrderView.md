---
layout: default
---
# ServiceRepairOrderView class
---
## Constructors
### `ServiceRepairOrderView(ApexPages.StandardController c)`
---
## Properties

### `TOADDRESS` → `String`

### `body` → `String`

### `ccAddress` → `String`

### `email` → `String`

### `inventoryRecord` → `Vehicle_Inventory__c`

### `listAttachment` → `List<AttachmentClass>`

### `location` → `Dealer_Location__c`

### `objAttachment` → `Attachment`

### `ops` → `dealer__FixedOperationsSettings__c`

### `postingURL` → `String`

### `rId` → `String`

### `relatedLists` → `Component.Apex.OutputPanel`

### `ro` → `Service_Repair_Order__c`

### `subject` → `String`

---
## Methods
### `AttachPDF()` → `Messaging.EmailFileAttachment`
### `detailUpdate()` → `PageReference`
### `emailSRO()` → `PageReference`
### `getAttachments()` → `pagereference`
### `getDealerLocation()` → `String`
### `laborTotal(String lineId)` → `Decimal`
### `loadServiceJobLines(String masterRecordId)` → `List<dealer__Service_Job__c>`

 SImple Remote Action to get the job lines...

#### Parameters
|Param|Description|
|-----|-----------|
|`masterRecordId` |  The ID of the RO to be requested |

### `miscChargeCodes(String locationId)` → `List<MiscChargeCode__c>`
### `returnToRo()` → `PageReference`

 Return to the RO Page

### `save()` → `PageReference`
### `sendPdf()` → `PageReference`
### `updateVehicle()` → `PageReference`
### `upload()` → `PageReference`
### `validateEmail(String email)` → `Boolean`
---
## Inner Classes

### ServiceRepairOrderView.AttachmentClass class
---
#### Properties

##### `objAttachment` → `Attachment`

##### `selected` → `boolean`

---
#### Methods
##### `attachmentClass(Attachment a)` → `public`
##### `attachmentClass(boolean sel,Attachment a)` → `public`
---
