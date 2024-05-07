---
layout: default
---
# ServiceRepairOrderView



**Group** Service

## Constructors
### `public ServiceRepairOrderView(ApexPages c)`
---
## Properties

### `public rId` → `String`


### `public ro` → `Service_Repair_Order__c`


### `public inventoryRecord` → `Vehicle_Inventory__c`


### `public location` → `Dealer_Location__c`


### `public email` → `String`


### `public subject` → `String`


### `public body` → `String`


### `public TOADDRESS` → `String`


### `public ccAddress` → `String`


### `public listAttachment` → `List<AttachmentClass>`


### `public ops` → `dealer__FixedOperationsSettings__c`


### `public postingURL` → `String`


### `public objAttachment` → `Attachment`


### `public relatedLists` → `Component`


---
## Methods
### `public String getDealerLocation()`
### `public String getSubletRecordType()`

returns the sublet po record type for creation of new sublet PO from the SRO

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** getSubletRecordType

### `public String getPartsPurchaseRecordType()`

returns the sublet po record type for creation of new sublet PO from the SRO

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** getPartsPurchaseRecordType

### `public PageReference save()`
### `public PageReference updateVehicle()`
### `public PageReference detailUpdate()`
### `public PageReference emailSRO()`
### `public pagereference getAttachments()`
### `public PageReference sendPdf()`
### `public Messaging AttachPDF()`
### `public static Boolean validateEmail(String email)`
### `public PageReference upload()`
### `public PageReference returnToRo()`
### `public static List<dealer__Service_Job__c> loadServiceJobLines(String masterRecordId)`

`REMOTEACTION`

Simple Remote Action to get the job lines...

#### Parameters

|Param|Description|
|---|---|
|`masterRecordId`|The ID of the RO to be requested|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Job__c>`|Service Job List.|

### `public static Decimal laborTotal(String lineId)`

`REMOTEACTION`
### `public static List<MiscChargeCode__c> miscChargeCodes(String locationId)`

`REMOTEACTION`
---
## Classes
### AttachmentClass
#### Constructors
##### `public AttachmentClass(Attachment a)`
##### `public AttachmentClass(boolean sel, Attachment a)`
---
#### Properties

##### `public selected` → `boolean`


##### `public objAttachment` → `Attachment`


---

---
