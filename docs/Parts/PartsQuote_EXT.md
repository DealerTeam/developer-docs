# PartsQuote_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartsQuote_EXT(ApexPages.standardController controller)`

**Method** PartsQuote_EXT


**Test** PartQuotingUILayer.testPartsQuoteEXT

---
## Properties

### `CurrentOrders` → `List<dealer__Stock_Order__c>`


### `body` → `String`


### `email` → `String`


### `quote` → `dealer__Parts_Quote__c`


### `subject` → `String`


---
## Methods
### `save()`

Save parts quote


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `ConvertToInvoice()`

Converts the parts quote to an invoice


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `static PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)`

Populate Parts Order Line into parent invoice


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `static loadPartsQuoteLines(String masterRecordId)`

`REMOTEACTION`

loadPartsLines - Quote


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `emailQuote()`

PDF Emailer


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `sendPdf()`

Send client quote as pdf email attachment


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `AttachPDF()`

Handles attaching the pdf quote to email


**Test** PartQuotingUILayer.testPartsQuoteEXT

---
## Classes
### PartsQuoteException

**Inheritance**

PartsQuoteException


---
