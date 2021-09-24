# PurchaseOrderAPI class
---
## Methods
### `accept(Purchase_Order__c po)` → `Purchase_Order__c`

validates and accept a purchase order

#### Parameters
|Param|Description|
|-----|-----------|
|`List&lt;Purchase_Order_Line__c&gt;` |  to be deleted |
|`` | c |
|`` | &gt; |
|`` | c |
|`po` |  Purchase_Order__c PO to accept, must have Id and Status |

#### Return

**Type**

Purchase_Order__c

**Description**

Purchase_Order__c accepted purchase order

### `post(Purchase_Order__c po)` → `Purchase_Order__c`

validates and post a purchase order

#### Parameters
|Param|Description|
|-----|-----------|
|`po` |  Purchase_Order__c PO to post, must have Id and Status |

#### Return

**Type**

Purchase_Order__c

**Description**

Purchase_Order__c posted purchase order

### `purchaseOrderLines(Id purchaseOrderId)` → `List<Purchase_Order_Line__c>`

handles update of vehicle sublet lines

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  of the purchase order to query |
|`purchase_Order__c` |  the PO to be inserted |
|`List&lt;purchase_Order_Line__c&gt;` |  the related PO Lines to be inserted |
|`purchase_Order__c` |  the PO to be updated |
|`List&lt;purchase_Order_Line__c&gt;` |  the related PO Lines to be added |
|`lines` |      lines description |
|`isReceive` |  isReceive description |
|`lines` |      lines description |
|`isReceive` |  isReceive description |
|`List&lt;purchase_Order_Line__c&gt;` |  the related PO Lines to be updated |
|`Id` |  of location to be referenced |
|`Id` |  of PO to be referenced |

#### Return

**Type**

List&lt;Purchase_Order_Line__c&gt;

**Description**

s List&lt;purchase_Order_Line__c&gt; related to given PO Id

### `void(Purchase_Order__c po)` → `Purchase_Order__c`

validates and voids a PO with a related note with the user who voided

#### Parameters
|Param|Description|
|-----|-----------|
|`po` |  Purchase_Order__c to be validated and updated, can provide custom field values to save |

#### Return

**Type**

Purchase_Order__c

**Description**

return description

---
