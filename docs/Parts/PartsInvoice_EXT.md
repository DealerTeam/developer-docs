# PartsInvoice_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartsInvoice_EXT(ApexPages.StandardController controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`|description|


**Method** PartsInvoice_EXT


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

---
## Fields

### `PriceLevels` → `List<dealer__Parts_Service_Pricing_Strategy__c>`


### `defaultPriceLevel` → `dealer__Parts_Service_Pricing_Strategy__c`


### `fixedops_settings` → `dealer__FixedOperationsSettings__c`


### `userID` → `Id`


### `userName` → `String`


---
## Properties

### `CounterMan` → `Id`


### `CounterManName` → `String`


defaults the countermans name to the person who is logged in

### `CurrentOrders` → `List<dealer__Stock_Order__c>`


### `body` → `String`


### `clines` → `List<dealer__Cashering__c>`


### `defaultTaxOn` → `Boolean`


### `email` → `String`


### `inventorySearch` → `String`


### `jobLineId` → `Id`


### `roData` → `dealer__Service_Repair_Order__c`


### `roId` → `Id`


### `roPage` → `boolean`


### `selectedLocation` → `String`


### `serviceHistoryJSON` → `String`


### `subject` → `String`


---
## Methods
### `getdefaultPriceLevel()`
#### Return

**Type**

dealer__Parts_Service_Pricing_Strategy__c

**Description**

dealer__Parts_Service_Pricing_Stratgey


**Method** getdefaultPriceLevel

### `lookupCurrentOrders()`
#### Return

**Type**

void

**Description**

void


**Method** lookupCurrentOrders


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `static PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)`
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

### `ROPartsSalesPrep(ID roNumber)`
#### Parameters

|Param|Description|
|---|---|
|`roNumber`|description|

#### Return

**Type**

dealer__Service_Repair_Order__c

**Description**

dealer__Service_Repair_Order__c object relating the service repair order to the parts invoice


**Method** ROPartsSalesPrep

### `getPriceLevels()`
#### Return

**Type**

List&lt;dealer__Parts_Service_Pricing_Strategy__c&gt;

**Description**

List&lt;dealer__Parts_Service_Pricing_Strategy__c&gt;


**Method** getPriceLevels


**Notes** returns a list of the available price levels


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

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
### `locationChanged()`
### `emailInvoice()`

Send user to email estimate page


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `sendPdf()`

send client invoice as pdf email attachment


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `AttachPDF()`

attach parts invoice pdf to email


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `closeInvoice()`

sets status to invoiced


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `voidInvoice()`
### `reopenInvoice()`

sets status back to open and invoice datetime to null


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `cashierInvoice()`

handles cashiering the invoice


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `createInvoicefromRO()`

Called to create a blank invoice related to the Repair Order it was called from


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

### `directView()`

Direct user to appropriate page, based if the record is tied to a service repair order or not


**Test** PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

---
## Classes
### PartsInvoiceException

**Inheritance**

PartsInvoiceException


---
