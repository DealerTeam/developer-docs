# PurchaseOrderLineControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Handler for PurchaseOrderLineControl trigger Test class: PurchaseOrderLineControlTest


**Group** Parts

## Methods
### `handleBeforeInsertUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList)`

This method runs on before insert / update context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|list|

### `handleBeforeDelete(List<dealer__Purchase_Order_Line__c> purchaseOrderLineOldList)`

This method runs on before delete context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|Old list|

### `handleBeforeUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap)`

This method runs on before update context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|list|
|`Id`|, dealer__Purchase_Order_Line__c Old Map|

### `handleBeforeInsert(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList)`

This method runs on before insert context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|list|

### `handleAfterUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap)`

This method runs on after update context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|list|
|`Id`|, dealer__Purchase_Order_Line__c Old Map|

### `handleAfterDelete(List<dealer__Purchase_Order_Line__c> purchaseOrderLineOldList)`

This method runs on after delete context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Purchase_Order_Line__c`|Old list|

### `handleAfterInsertUpdate(List<dealer__Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,dealer__Purchase_Order_Line__c> purchaseOrderLineOldMap)`
### `setLineType(List<Purchase_Order_Line__c> triggerNew, Map<Id,Purchase_Order_Line__c> triggerOldMap)`

Validates line type exclusivity and sets the line type field

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** setLineType

### `setCoreCharge(List<Purchase_Order_Line__c> triggerNew)`

updates the total core charge as product of Part Qty and Core

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setCoreCharge

### `preventDuplicateLines(List<Purchase_Order_Line__c> triggerNew)`

Executed when config is set to verify only one line exists on a PO for each master record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

---
