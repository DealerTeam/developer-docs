# PartsInvoice_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

**Group** Parts

## Methods
### `static searchInventory(String searchString)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

### `static getInventory(String inventorySearch)`

`REMOTEACTION`

getInventory

#### Parameters
|Param|Description|
|---|---|
|`inventorySearch`|[String of the inventory record to search, this is a part#]|

#### Return

**Type**

dealer__Parts_Inventory__c

**Description**

dealer__Parts_Inventory__c


**Notes** matched invnentory record


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static matchedInventory(String partno)`

`REMOTEACTION`

matchedInventory

#### Parameters
|Param|Description|
|---|---|
|`partno`|:|

#### Return

**Type**

List&lt;dealer__Parts_Inventory__c&gt;

**Description**

List&lt;dealer__Parts_Invoice_Line__c&gt; : returns a list of matched inventory


**Notes** 3/28/2016 | J.Kuljis | create a specific inventory part if one does not exist

### `static getMaster(String inventorySearch)`

`REMOTEACTION`

getMaster: return parts master data   
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

#### Parameters
|Param|Description|
|---|---|

### `static getPartsKitItems(String kitId)`

`REMOTEACTION`

getKitItems: return parts kit items for addition to invoices

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static loadPartsInvoiceLines(String masterRecordId)`

`REMOTEACTION`

loadPartsLines - Invoice

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static loadPartsQuoteLines(String masterRecordId)`

`REMOTEACTION`

loadPartsLines - Quote

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static invoicePricing(String RecordId)`

`REMOTEACTION`

invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static invoiceLine(String LineId)`

`REMOTEACTION`

invoiceLine - get Line specific information via remoting

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static InvoiceAddPartLine(String xmlString)`

`REMOTEACTION`

invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static CreatePartsQuote(String xmlString)`

`REMOTEACTION`

Creates parts quote from provided string

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static updateLineQty(String linedata)`

`REMOTEACTION`

updates parts invoice line with new data

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static setLinePrice(String linedata)`

`REMOTEACTION`

updates parts invoice line with new price

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static setPL(String plID)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

### `static setPLonInvoice(String ipl)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

### `static CreateInvoice(String xmlString)`

`REMOTEACTION`

Create Parts Invoice from Quote Screen

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static DeleteInvoiceLine(String partId)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

### `static updateShipToAddress(String jsonAddress)`

`REMOTEACTION`

Updates customer shipping address from json string

#### Parameters
|Param|Description|
|---|---|


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static businessAccountContacts(String s)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

---
