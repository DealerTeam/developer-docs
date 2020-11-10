---
layout: default
---
# PartsInvoice_EXT class
---
## Constructors
### `PartsInvoice_EXT(ApexPages.StandardController controller)`

 PartsInvoice_EXT
#### Parameters
|Param|Description|
|-----|-----------|
|`controller` |  [description] |

---
## Properties

### `CounterMan` → `Id`

 Counterman @return  Id @notes   The ID of the user who is currently accessing the page

### `CounterManName` → `String`

 CounterManName @return String @notets defaults the countermans name to the person who is logged in

### `CurrentOrders` → `List<dealer__Stock_Order__c>`

### `PriceLevels` → `List<dealer__Parts_Service_Pricing_Strategy__c>`

### `body` → `String`

### `clines` → `List<dealer__Cashering__c>`

 clines @return  List<dealer__Cashering__c> @notes   returns a list of the cashiering lines associated with this invoice

### `defaultPriceLevel` → `dealer__Parts_Service_Pricing_Strategy__c`

### `defaultTaxOn` → `Boolean`

### `email` → `String`

### `fixedops_settings` → `dealer__FixedOperationsSettings__c`

### `inventorySearch` → `String`

### `jobLineId` → `Id`

### `roData` → `dealer__Service_Repair_Order__c`

### `roId` → `Id`

### `roPage` → `boolean`

### `selectedLocation` → `String`

### `serviceHistoryJSON` → `String`

### `subject` → `String`

### `userID` → `Id`

### `userName` → `String`

---
## Methods
### `AttachPDF()` → `Messaging.EmailFileAttachment`

 attach parts invoice pdf to email @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `CreateInvoice(String xmlString)` → `PageReference`

 Create Parts Invoice from Quote Screen @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `CreatePartsQuote(String xmlString)` → `PageReference`

 Creates parts quote from provided string @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `DeleteInvoiceLine(String partId)` → `Boolean`
### `InvoiceAddPartLine(String xmlString)` → `dealer__Parts_Invoice_Line__c`

 invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)` → `void`

 PartsOrderLine - Generates a parts oder line

#### Parameters
|Param|Description|
|-----|-----------|
|`partId` |           [description] |
|`invoiceId` |        [description] |
|`invoiceLineId` |    [description] |
|`quantityOrdered` |  [description] |
|`requestedBy` |      [description] |
|`orderType` |        [description] |
|`mfg` |              [description] |

### `ROPartsSalesPrep(ID roNumber)` → `dealer__Service_Repair_Order__c`

 ROPartsSalesPrep

#### Parameters
|Param|Description|
|-----|-----------|
|`roNumber` |  [description] |

### `businessAccountContacts(String s)` → `List<Contact>`
### `cashierInvoice()` → `PageReference`

 handles cashiering the invoice @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `closeInvoice()` → `PageReference`

 sets status to invoiced @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `createInvoicefromRO()` → `PageReference`

 Called to create a blank invoice related to the Repair Order it was called from @test PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

### `directView()` → `PageReference`

 Direct user to appropriate page, based if the record is tied to a service repair order or not @test PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO

### `emailInvoice()` → `PageReference`

 Send user to email estimate page @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

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

### `getPriceLevels()` → `List<dealer__Parts_Service_Pricing_Strategy__c>`

 getPriceLevels

### `getdefaultPriceLevel()` → `dealer__Parts_Service_Pricing_Strategy__c`

 getdefaultPriceLevel

### `invoiceLine(String LineId)` → `dealer__Parts_Invoice_Line__c`

 invoiceLine - get Line specific information via remoting @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `invoicePricing(String RecordId)` → `dealer__Parts_Invoice__c`

 invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `loadPartsInvoiceLines(String masterRecordId)` → `List<dealer__Parts_Invoice_Line__c>`

 loadPartsLines - Invoice @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `loadPartsQuoteLines(String masterRecordId)` → `List<dealer__Parts_Quote_Line__c>`

 loadPartsLines - Quote @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `locationChanged()` → `PageReference`
### `lookupCurrentOrders()` → `void`

 lookupCurrentOrders

### `matchedInventory(String partno)` → `List<dealer__Parts_Inventory__c>`

 matchedInventory

#### Parameters
|Param|Description|
|-----|-----------|
|`partno` |  : |

### `reopenInvoice()` → `PageReference`

 sets status back to open and invoice datetime to null @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `searchInventory(String searchString)` → `List<dealer__Parts_Inventory__c>`
### `sendPdf()` → `PageReference`

 send client invoice as pdf email attachment @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `setLinePrice(String linedata)` → `boolean`

 updates parts invoice line with new price @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `setPL(String plID)` → `dealer__Parts_Service_Pricing_Strategy__c`
### `setPLonInvoice(String ipl)` → `boolean`
### `updateLineQty(String linedata)` → `dealer__Parts_Invoice_Line__c`

 updates parts invoice line with new data @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `updateShipToAddress(String jsonAddress)` → `Boolean`

 Updates customer shipping address from json string @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT

### `voidInvoice()` → `PageReference`
---
## Inner Classes

### PartsInvoice_EXT.PartsInvoiceException class
---
