# PartsInvoice_Printing class
---
## Constructors
### `PartsInvoice_Printing(ApexPages.StandardController controller)`

 Constructor @test PartInvoicingServiceLayer.testPIP
---
## Properties

### `DMSDefaults` → `dealer__DMS_Settings__c`

### `account` → `Account`

### `contact` → `Contact`

### `invoice` → `dealer__Parts_Invoice__c`

### `invoiceLineItems` → `dealer__Parts_Invoice_Line__c[]`

### `pageBrokenInvoiceLines` → `List<dealer__Parts_Invoice_Line__c[]>`

### `printDateTime` → `string`

### `userLoc` → `dealer__Dealer_Location__c`

---
## Methods
### `getInvoiceLogo()` → `String`

 Handles finding logo from documents and returning the url as a string

#### Return

**Type**

String

**Description**

s {String} - the url of the logo image

---
