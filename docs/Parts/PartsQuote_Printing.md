---
layout: default
---
# PartsQuote_Printing



**Group** Parts

## Constructors
### `public PartsQuote_Printing(ApexPages controller)`

**Test** PartQuotingServiceLayer.testPartsQuotePrinting

---
## Fields

### `private FIRST_BREAK` → `Integer`


### `private SUBSEQ_BREAKS` → `Integer`


---
## Properties

### `public pageBrokenQuoteLines` → `List<dealer__Parts_Quote_Line__c>`


### `public quote` → `dealer__Parts_Quote__c`


### `public quoteLineItems` → `dealer__Parts_Quote_Line__c`


### `public account` → `Account`


### `public contact` → `Contact`


### `public InvoiceLogo` → `String`


### `public printDateTime` → `string`


### `public DMSDefaults` → `dealer__DMS_Settings__c`


### `public userLoc` → `dealer__Dealer_Location__c`


---
## Methods
### `public String getInvoiceLogo()`

Returns url of invoice logo if one exists

#### Returns

|Type|Description|
|---|---|
|`String`|String - url of InvoiceLogo from Documents|


**Test** PartQuotingServiceLayer.testPartsQuotePrinting

### `private void prepareQuoteLinesForPrinting()`

Arranges quote lines with page breaks for printing


**Test** PartQuotingServiceLayer.testPartsQuotePrinting

### `private static String logo_url(Id locationId)`
---
