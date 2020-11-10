---
layout: default
---
# PartInvoiceLineManagerController class
---
## Constructors
### `PartInvoiceLineManagerController()`
---
## Methods
### `addInvoicePartLine(Id invoiceId, Id partId, Decimal quantity, Decimal salePrice)` → `List<Parts_Invoice_Line__c>`
### `deletePartLine(Id lineId)` → `Boolean`
### `editPartLine(Parts_Invoice_Line__c line)` → `Parts_Invoice_Line__c`
### `getPartByMasterLocation(string masterId, Id locationId)` → `Parts_Inventory__c`
### `getPartDetails(Id partId)` → `dealer__Parts_Inventory__c`
### `getPartLinesByInvoice(Id invoiceId)` → `List<Parts_Invoice_Line__c>`
### `partSearchByLocation(string searchTerm, Id locationId)` → `List<LookupSearchResult>`
### `partsMasterSearchByMfg(string searchTerm, String mfg)` → `List<LookupSearchResult>`
### `updatePartLine(Id lineId, Decimal quantity, Decimal salePrice)` → `Parts_Invoice_Line__c`
---
## Inner Classes

### PartInvoiceLineManagerController.PartLine class
---
#### Properties

##### `partDescription` → `String`

##### `partId` → `String`

##### `partName` → `String`

---
