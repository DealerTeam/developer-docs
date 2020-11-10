---
layout: default
---
# AfterMarketControlHandler class

Created 11-22-2016 by Abhishek Goel W-000710. Added updateTaxFields method to update Sales Tax value.

---
## Constructors
### `AfterMarketControlHandler()`
---
## Methods
### `createWeOwe(List<After_Market__c> TriggerNewList)` → `void`
### `deleteKitItems(List<After_Market__c> triggerOld)` → `void`

 deleteKitItems @notes When an After Market 'Header' record is deleted, delete associated lines.

### `deleteTaxTransactionItems(List<After_Market__c> triggerList)` → `void`

Deletes any referenced tax transaction items based on the lit of aftermarkets passed.

### `updateSaleValues(List<After_Market__c> TriggerNewList)` → `void`

Ensure the Sale_Price and Cost values are set

### `updateTaxFields(List<After_Market__c> TriggerNewList)` → `void`

Sales Tax field with total price value including tax based on Misc Tax code for deal location.Tax Rate field with tax percent of the record(PartKit)

---
