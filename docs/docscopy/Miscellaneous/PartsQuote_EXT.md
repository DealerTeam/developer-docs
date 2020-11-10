---
layout: default
---
# PartsQuote_EXT class
---
## Constructors
### `PartsQuote_EXT(ApexPages.standardController controller)`

 PartsQuote_EXT Constructor @test PartQuotingUILayer.testPartsQuoteEXT
---
## Properties

### `CurrentOrders` → `List<dealer__Stock_Order__c>`

### `body` → `String`

### `email` → `String`

### `quote` → `dealer__Parts_Quote__c`

### `subject` → `String`

---
## Methods
### `AttachPDF()` → `Messaging.EmailFileAttachment`

 Handles attaching the pdf quote to email @test PartQuotingUILayer.testPartsQuoteEXT

### `ConvertToInvoice()` → `PageReference`

 Converts the parts quote to an invoice @test PartQuotingUILayer.testPartsQuoteEXT

### `PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)` → `void`

 Populate Parts Order Line into parent invoice @test PartQuotingUILayer.testPartsQuoteEXT

### `emailQuote()` → `PageReference`

 PDF Emailer @test PartQuotingUILayer.testPartsQuoteEXT

### `loadPartsQuoteLines(String masterRecordId)` → `List<dealer__Parts_Quote_Line__c>`

 loadPartsLines - Quote @test PartQuotingUILayer.testPartsQuoteEXT

### `save()` → `PageReference`

 Save parts quote @test PartQuotingUILayer.testPartsQuoteEXT

### `sendPdf()` → `PageReference`

 Send client quote as pdf email attachment @test PartQuotingUILayer.testPartsQuoteEXT

---
## Inner Classes

### PartsQuote_EXT.PartsQuoteException class
---
