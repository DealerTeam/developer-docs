---
layout: default
---
# PurchaseOrder
## Constructors
### `public PurchaseOrder(Id orderId)`
---
## Fields

### `public order` → `Purchase_Order__c`


### `public company` → `Dealer_Location__c`


### `public partsInvoice` → `Parts_Invoice__c`


### `public invoiceLine` → `Parts_Invoice_Line__c`


### `public sro` → `Service_Repair_Order__c`


### `public vehicleInventory` → `Vehicle_Inventory__c`


### `public vendor` → `Account`


### `public lines` → `List<Purchase_Order_Line__c>`


### `public receivingLines` → `List<Purchase_Order_Receiving__c>`


---
## Classes
### LineReceiver
#### Constructors
##### `public LineReceiver(Integer q, Purchase_Order_Line__c p)`
##### `public LineReceiver()`
---
#### Properties

##### `public packQuantity` → `Integer`

`AURAENABLED` 

##### `public updateQuantity` → `Integer`

`AURAENABLED` 

##### `public itemsProcessed` → `Integer`

`AURAENABLED` 

##### `public itemsToReceive` → `Integer`

`AURAENABLED` 

##### `public line` → `Purchase_Order_Line__c`

`AURAENABLED` 

##### `public recLine` → `Purchase_Order_Receiving_Line__c`

`AURAENABLED` 

##### `public part` → `Parts_Inventory__c`

`AURAENABLED` 

##### `public serialNumbers` → `List&lt;String&gt;`

`AURAENABLED` 

---

---
