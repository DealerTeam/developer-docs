---
layout: default
---
# PurchaseOrderSelector
## Methods
### `public Purchase_Order__c getPurchaseOrderById(Id poId)`
### `public List<Purchase_Order_Line__c> getPOLinesByPO(Id poId)`

queries lines for a given PO

### `public List<Purchase_Order_Receiving__c> getReceivingLinesByPO(Id poId)`

Returns Receiving Events and their lines

### `public String getJobLineQueryFieldsString()`

builds query string for lines.

---
