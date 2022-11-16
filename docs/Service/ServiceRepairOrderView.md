# ServiceRepairOrderView

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

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
### `getDealerLocation()`
### `getSubletRecordType()`

returns the sublet po record type for creation of new sublet PO from the SRO

#### Return

**Type**

String

**Description**

return description


**Method** getSubletRecordType

### `getPartsPurchaseRecordType()`

returns the sublet po record type for creation of new sublet PO from the SRO

#### Return

**Type**

String

**Description**

return description


**Method** getPartsPurchaseRecordType

### `save()`
### `updateVehicle()`
### `detailUpdate()`
### `emailSRO()`
### `getAttachments()`
### `sendPdf()`
### `AttachPDF()`
### `static validateEmail(String email)`
### `upload()`
### `returnToRo()`
### `static loadServiceJobLines(String masterRecordId)`

`REMOTEACTION`

Simple Remote Action to get the job lines...

#### Parameters

|Param|Description|
|---|---|
|`masterRecordId`|The ID of the RO to be requested|

#### Return

**Type**

List&lt;dealer__Service_Job__c&gt;

**Description**

Service Job List.

### `static laborTotal(String lineId)`

`REMOTEACTION`
### `static miscChargeCodes(String locationId)`

`REMOTEACTION`
---
## Classes
### AttachmentClass
#### Constructors
##### `AttachmentClass(Attachment a)`
##### `AttachmentClass(boolean sel, Attachment a)`
---
#### Properties

##### `objAttachment` → `Attachment`


##### `selected` → `boolean`


---

---
