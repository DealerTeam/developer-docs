---
layout: default
---
# PartsInvoice_EXT class
---
## Methods
### `CreateInvoice(String xmlString)` → `PageReference`

 Create Parts Invoice from Quote Screen @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `CreatePartsQuote(String xmlString)` → `PageReference`

 Creates parts quote from provided string @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `DeleteInvoiceLine(String partId)` → `Boolean`
### `InvoiceAddPartLine(String xmlString)` → `dealer__Parts_Invoice_Line__c`

 invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `businessAccountContacts(String s)` → `List<Contact>`
### `getInventory(String inventorySearch)` → `dealer__Parts_Inventory__c`

 getInventory

#### Parameters
|Param|Description|
|-----|-----------|
|`inventorySearch` |  [String of the inventory record to search, this is a part#] |

### `getMaster(String inventorySearch)` → `dealer__Parts_Master__c`

 getMaster: return parts master data @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `getPartsKitItems(String kitId)` → `List<dealer__Parts_Kit_Item__c>`

 getKitItems: return parts kit items for addition to invoices @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `invoiceLine(String LineId)` → `dealer__Parts_Invoice_Line__c`

 invoiceLine - get Line specific information via remoting @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `invoicePricing(String RecordId)` → `dealer__Parts_Invoice__c`

 invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `loadPartsInvoiceLines(String masterRecordId)` → `List<dealer__Parts_Invoice_Line__c>`

 loadPartsLines - Invoice @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `loadPartsQuoteLines(String masterRecordId)` → `List<dealer__Parts_Quote_Line__c>`

 loadPartsLines - Quote @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `matchedInventory(String partno)` → `List<dealer__Parts_Inventory__c>`

 matchedInventory

#### Parameters
|Param|Description|
|-----|-----------|
|`partno` |  : |

### `searchInventory(String searchString)` → `List<dealer__Parts_Inventory__c>`

 PartsInvoice_EXT

#### Parameters
|Param|Description|
|-----|-----------|
|`controller` |  [description] |
|`partId` |           [description] |
|`invoiceId` |        [description] |
|`invoiceLineId` |    [description] |
|`quantityOrdered` |  [description] |
|`requestedBy` |      [description] |
|`orderType` |        [description] |
|`mfg` |              [description] |
|`roNumber` |  [description] |

### `setLinePrice(String linedata)` → `boolean`

 updates parts invoice line with new price @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `setPL(String plID)` → `dealer__Parts_Service_Pricing_Strategy__c`
### `setPLonInvoice(String ipl)` → `boolean`
### `updateLineQty(String linedata)` → `dealer__Parts_Invoice_Line__c`

 updates parts invoice line with new data @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `updateShipToAddress(String jsonAddress)` → `Boolean`

 Updates customer shipping address from json string @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

---
