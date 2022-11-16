# PartsQuote_Printing

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartsQuote_Printing(ApexPages.StandardController controller)`

**Test** PartQuotingServiceLayer.testPartsQuotePrinting

---
## Properties

### `DMSDefaults` → `dealer__DMS_Settings__c`


### `InvoiceLogo` → `String`


### `account` → `Account`


### `contact` → `Contact`


### `pageBrokenQuoteLines` → `List<dealer__Parts_Quote_Line__c[]>`


### `printDateTime` → `string`


### `quote` → `dealer__Parts_Quote__c`


### `quoteLineItems` → `dealer__Parts_Quote_Line__c[]`


### `userLoc` → `dealer__Dealer_Location__c`


---
## Methods
### `getInvoiceLogo()`

Returns url of invoice logo if one exists

#### Return

**Type**

String

**Description**

String - url of InvoiceLogo from Documents


**Test** PartQuotingServiceLayer.testPartsQuotePrinting

---
