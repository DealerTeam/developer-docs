---
layout: default
---
# PartsInvoice_EXT



**Group** Parts

## Constructors
### `public PartsInvoice_EXT(ApexPages controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`|description|


**Method** PartsInvoice_EXT


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

---
## Fields

### `public userID` → `Id`


### `public userName` → `String`


### `public fixedops_settings` → `dealer__FixedOperationsSettings__c`


### `public PriceLevels` → `List<dealer__Parts_Service_Pricing_Strategy__c>`


### `public defaultPriceLevel` → `dealer__Parts_Service_Pricing_Strategy__c`


### `private invoiceRecord` → `dealer__Parts_Invoice__c`


### `private defaultAttachment` → `Messaging`


---
## Properties

### `public jobLineId` → `Id`


### `public roId` → `Id`


### `public defaultTaxOn` → `Boolean`


### `public CurrentOrders` → `List<dealer__Stock_Order__c>`


### `public inventorySearch` → `String`


### `public serviceHistoryJSON` → `String`


### `public selectedLocation` → `String`


### `public roData` → `dealer__Service_Repair_Order__c`


### `public roPage` → `boolean`


### `public email` → `String`


### `public subject` → `String`


### `public body` → `String`


### `public CounterManName` → `String`


defaults the countermans name to the person who is logged in

### `public CounterMan` → `Id`


### `public clines` → `List<dealer__Cashering__c>`


---
## Methods
### `public dealer__Parts_Service_Pricing_Strategy__c getdefaultPriceLevel()`
#### Returns

|Type|Description|
|---|---|
|`dealer__Parts_Service_Pricing_Strategy__c`|dealer__Parts_Service_Pricing_Stratgey|


**Method** getdefaultPriceLevel

### `public void lookupCurrentOrders()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** lookupCurrentOrders


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public static void PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)`
#### Parameters

|Param|Description|
|---|---|
|`partId`|description|
|`invoiceId`|description|
|`invoiceLineId`|description|
|`quantityOrdered`|description|
|`requestedBy`|description|
|`orderType`|description|
|`mfg`|description|


**Method** PartsOrderLine - Generates a parts oder line

### `public dealer__Service_Repair_Order__c ROPartsSalesPrep(ID roNumber)`
#### Parameters

|Param|Description|
|---|---|
|`roNumber`|description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Service_Repair_Order__c`|dealer__Service_Repair_Order__c object relating the service repair order to the parts invoice|


**Method** ROPartsSalesPrep

### `public List<dealer__Parts_Service_Pricing_Strategy__c> getPriceLevels()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Service_Pricing_Strategy__c>`|List<dealer__Parts_Service_Pricing_Strategy__c>|


**Method** getPriceLevels


**Notes** returns a list of the available price levels


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<dealer__Parts_Inventory__c> searchInventory(String searchString)`

`REMOTEACTION`
### `global static dealer__Parts_Inventory__c getInventory(String inventorySearch)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`inventorySearch`|[String of the inventory record to search, this is a part#]|

#### Returns

|Type|Description|
|---|---|
|`dealer__Parts_Inventory__c`|dealer__Parts_Inventory__c|


**Method** getInventory


**Notes** matched invnentory record


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<dealer__Parts_Inventory__c> matchedInventory(String partno)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`partno`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Inventory__c>`|List dealer__Parts_Invoice_Line__c : returns a list of matched inventory|


**Method** matchedInventory


**Notes** 3-28-2016  create a specific inventory part if one does not exist

### `global static dealer__Parts_Master__c getMaster(String inventorySearch)`

`REMOTEACTION`

**Method** getMaster: return parts master data


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<dealer__Parts_Kit_Item__c> getPartsKitItems(String kitId)`

`REMOTEACTION`

**Method** getKitItems: return parts kit items for addition to invoices


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<dealer__Parts_Invoice_Line__c> loadPartsInvoiceLines(String masterRecordId)`

`REMOTEACTION`

**Method** loadPartsLines - Invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<dealer__Parts_Quote_Line__c> loadPartsQuoteLines(String masterRecordId)`

`REMOTEACTION`

**Method** loadPartsLines - Quote


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static dealer__Parts_Invoice__c invoicePricing(String RecordId)`

`REMOTEACTION`

**Method** invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static dealer__Parts_Invoice_Line__c invoiceLine(String LineId)`

`REMOTEACTION`

**Method** invoiceLine - get Line specific information via remoting


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static dealer__Parts_Invoice_Line__c InvoiceAddPartLine(String xmlString)`

`REMOTEACTION`

**Method** invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static PageReference CreatePartsQuote(String xmlString)`

`REMOTEACTION`

Creates parts quote from provided string


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static dealer__Parts_Invoice_Line__c updateLineQty(String linedata)`

`REMOTEACTION`

updates parts invoice line with new data


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static boolean setLinePrice(String linedata)`

`REMOTEACTION`

updates parts invoice line with new price


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static dealer__Parts_Service_Pricing_Strategy__c setPL(String plID)`

`REMOTEACTION`
### `global static boolean setPLonInvoice(String ipl)`

`REMOTEACTION`
### `global static PageReference CreateInvoice(String xmlString)`

`REMOTEACTION`

Create Parts Invoice from Quote Screen


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static Boolean DeleteInvoiceLine(String partId)`

`REMOTEACTION`
### `global static Boolean updateShipToAddress(String jsonAddress)`

`REMOTEACTION`

Updates customer shipping address from json string


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `global static List<Contact> businessAccountContacts(String s)`

`REMOTEACTION`
### `public PageReference locationChanged()`
### `public PageReference emailInvoice()`

Send user to email estimate page


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public PageReference sendPdf()`

send client invoice as pdf email attachment


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public Messaging AttachPDF()`

attach parts invoice pdf to email


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public PageReference closeInvoice()`

sets status to invoiced


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public PageReference voidInvoice()`
### `public PageReference reopenInvoice()`

sets status back to open and invoice datetime to null


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public PageReference cashierInvoice()`

handles cashiering the invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `public PageReference createInvoicefromRO()`

Called to create a blank invoice related to the Repair Order it was called from


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

### `public PageReference directView()`

Direct user to appropriate page, based if the record is tied to a service repair order or not


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

---
## Classes
### PartsInvoiceException

**Inheritance**

PartsInvoiceException


---
