---
layout: default
---
# PartsInvoicePrint



**Group** Parts


**Test** PartInvoicingServiceLayer.testPartsInvoicePrint

## Constructors
### `global PartsInvoicePrint(ApexPages sc)`
---
## Fields

### `private FIRST_BREAK` → `Integer`


### `private SUBSEQ_BREAKS` → `Integer`


---
## Properties

### `global pi` → `Parts_Invoice__c`


---
## Methods
### `global PartsInvoice getPartsInvoice()`
### `private static Parts_Invoice__c queryHeader(Id piId)`
### `private static List<dealer__Cashering__c> queryCashering(Id piId)`
### `private static List<dealer__Parts_Invoice_Line__c> queryLines(Id piId)`
### `private static Account queryAccount(Id acctId)`
### `private static User queryUser(Id userId)`
### `private static Dealer_Location__c queryLocation(Id locId)`
### `private static List<Parts_Invoice_Line__c> queryParts(Id piId)`
### `private static String logo_url()`
### `private static String formattedDateTime()`
### `private static List<dealer__Parts_Invoice_Line__c> prepareInvoiceLinesForPrinting(Id piId)`
---
## Classes
### PartsInvoice
#### Constructors
##### `private PartsInvoice(Id piId)`
---
#### Properties

##### `global logoUrl` → `String`


##### `global location` → `Dealer_Location__c`


##### `global customer` → `Account`


##### `global printDateTime` → `String`


##### `global header` → `Parts_Invoice__c`


##### `global userLoc` → `Dealer_Location__c`


##### `global pageBrokenInvoiceLines` → `List&lt;Parts_Invoice_Line__c&gt;`


##### `global casheringList` → `List&lt;Cashering__c&gt;`


##### `global DMSDefaults` → `DMS_Settings__c`


##### `global counterman` → `User`


---

---
