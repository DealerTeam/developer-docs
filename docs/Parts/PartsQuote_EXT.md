---
layout: default
---
# PartsQuote_EXT



**Group** Parts

## Constructors
### `public PartsQuote_EXT(ApexPages controller)`

**Method** PartsQuote_EXT


**Test** PartQuotingUILayer.testPartsQuoteEXT

---
## Fields

### `private defaultAttachment` → `Messaging`


---
## Properties

### `public quote` → `dealer__Parts_Quote__c`


### `public CurrentOrders` → `List<dealer__Stock_Order__c>`


### `public email` → `String`


### `public subject` → `String`


### `public body` → `String`


---
## Methods
### `public PageReference save()`

Save parts quote


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public PageReference ConvertToInvoice()`

Converts the parts quote to an invoice


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public static void PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg)`

Populate Parts Order Line into parent invoice


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public static List<dealer__Parts_Quote_Line__c> loadPartsQuoteLines(String masterRecordId)`

`REMOTEACTION`

loadPartsLines - Quote


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public PageReference emailQuote()`

PDF Emailer


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public PageReference sendPdf()`

Send client quote as pdf email attachment


**Test** PartQuotingUILayer.testPartsQuoteEXT

### `public Messaging AttachPDF()`

Handles attaching the pdf quote to email


**Test** PartQuotingUILayer.testPartsQuoteEXT

---
## Classes
### PartsQuoteException

**Inheritance**

PartsQuoteException


---
