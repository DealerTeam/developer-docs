---
layout: default
---
# PurchaseOrderAPI class
---
## Properties

### `purchaseorder` → `Purchase_Order__c`

### `purchaseorderReceiverLines` → `List<PurchaseOrder.lineReceiver>`

### `purchaseorderlines` → `List<Purchase_Order_Line__c>`

### `receipt` → `Purchase_Order_Receiving__c`

### `receiveAccept` → `Boolean`

---
## Methods
### `create(Purchase_Order__c po, List < Purchase_Order_Line__c > poLines)` → `Purchase_Order__c`

 Inserts provided PO and PO Lines

#### Parameters
|Param|Description|
|-----|-----------|
|`purchase_Order__c` |  the PO to be inserted |
|`List<purchase_Order_Line__c>` |  the related PO Lines to be inserted |

### `deletePurchaseOrderLines(List<Purchase_Order_Line__c> poLines)` → `void`

 Handles deletion of PO Lines

#### Parameters
|Param|Description|
|-----|-----------|
|`List<Purchase_Order_Line__c>` |  to be deleted |

### `isOpen(Id poId)` → `boolean`

 Method forcefully selects from the database the status of the purchase order in the event the PO is open in more than one screen.

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  of the purchase order to query |

### `managePartLines(List<Purchase_Order_Line__c> poLines, Id locationId)` → `List<Purchase_Order_Line__c>`

 Updates part field on PO Lines, calling method to create local parts inventory if needed

#### Parameters
|Param|Description|
|-----|-----------|
|`List<purchase_Order_Line__c>` |  the related PO Lines to be updated |
|`Id` |  of location to be referenced |

### `purchaseOrderLines(Id purchaseOrderId)` → `List<Purchase_Order_Line__c>`

 Queries for PO Lines given a PO Id

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  of PO to be referenced |

### `receive(Purchase_Order__c po, List<PurchaseOrder.lineReceiver> linestoReceive, Purchase_Order_Receiving__c receiveHeader)` → `Purchase_Order__c`

 Purchase Order Accept Event

#### Parameters
|Param|Description|
|-----|-----------|
|`` | c |
|`` | > |
|`` | c |

### `updatePO(Purchase_Order__c purchaseOrder, List<Purchase_Order_Line__c> poLines)` → `Purchase_Order__c`

 Adds provided po lines to the provided po

#### Parameters
|Param|Description|
|-----|-----------|
|`purchase_Order__c` |  the PO to be updated |
|`List<purchase_Order_Line__c>` |  the related PO Lines to be added |

---
## Inner Classes

### PurchaseOrderAPI.PurchaseOrderAPIException class

 Private method for receiving parts purchase orders @test PartOrderingUILayer.testVoid /** private method to record the receive events to the receiving table @Param Purchase_Order_Receiving__c /** recordReceiveEvent @notes This method records a non-parts purchase order receive event.

---
