---
layout: default
---
# PartsInvoice_Printing



**Group** Parts

## Constructors
### `global PartsInvoice_Printing(ApexPages controller)`

**Test** PartInvoicingServiceLayer.testPIP

---
## Fields

### `private FIRST_BREAK` → `Integer`


### `private SUBSEQ_BREAKS` → `Integer`


---
## Properties

### `global pageBrokenInvoiceLines` → `List<dealer__Parts_Invoice_Line__c>`


### `global invoice` → `dealer__Parts_Invoice__c`


### `global invoiceLineItems` → `dealer__Parts_Invoice_Line__c`


### `global account` → `Account`


### `global contact` → `Contact`


### `global currencyCode` → `String`


### `global printDateTime` → `string`


### `global DMSDefaults` → `dealer__DMS_Settings__c`


### `global userLoc` → `dealer__Dealer_Location__c`


---
## Methods
### `global String getInvoiceLogo()`

Handles finding logo from documents and returning the url as a string

#### Returns

|Type|Description|
|---|---|
|`String`|s String - the url of the logo image|


**Test** PartInvoicingServiceLayer.testPIP

### `private void prepareInvoiceLinesForPrinting()`

Arrange lines with page breaks for printing


**Test** PartInvoicingServiceLayer.testPIP

---
