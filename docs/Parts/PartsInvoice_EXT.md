# PartsInvoice_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

**Group** Parts

## Methods
### `static searchInventory(String searchString)`

`REMOTEACTION`
### `static getInventory(String inventorySearch)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`inventorySearch`|[String of the inventory record to search, this is a part#]|

#### Return

**Type**

dealer__Parts_Inventory__c

**Description**

dealer__Parts_Inventory__c


**Method** getInventory


**Notes** matched invnentory record


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static matchedInventory(String partno)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`partno`||

#### Return

**Type**

List&lt;dealer__Parts_Inventory__c&gt;

**Description**

List dealer__Parts_Invoice_Line__c : returns a list of matched inventory


**Method** matchedInventory


**Notes** 3-28-2016  create a specific inventory part if one does not exist

### `static getMaster(String inventorySearch)`

`REMOTEACTION`

**Method** getMaster: return parts master data


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static getPartsKitItems(String kitId)`

`REMOTEACTION`

**Method** getKitItems: return parts kit items for addition to invoices


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static loadPartsInvoiceLines(String masterRecordId)`

`REMOTEACTION`

**Method** loadPartsLines - Invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static loadPartsQuoteLines(String masterRecordId)`

`REMOTEACTION`

**Method** loadPartsLines - Quote


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static invoicePricing(String RecordId)`

`REMOTEACTION`

**Method** invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static invoiceLine(String LineId)`

`REMOTEACTION`

**Method** invoiceLine - get Line specific information via remoting


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static InvoiceAddPartLine(String xmlString)`

`REMOTEACTION`

**Method** invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static CreatePartsQuote(String xmlString)`

`REMOTEACTION`

Creates parts quote from provided string


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static updateLineQty(String linedata)`

`REMOTEACTION`

updates parts invoice line with new data


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static setLinePrice(String linedata)`

`REMOTEACTION`

updates parts invoice line with new price


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static setPL(String plID)`

`REMOTEACTION`
### `static setPLonInvoice(String ipl)`

`REMOTEACTION`
### `static CreateInvoice(String xmlString)`

`REMOTEACTION`

Create Parts Invoice from Quote Screen


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static DeleteInvoiceLine(String partId)`

`REMOTEACTION`
### `static updateShipToAddress(String jsonAddress)`

`REMOTEACTION`

Updates customer shipping address from json string


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static businessAccountContacts(String s)`

`REMOTEACTION`
---
