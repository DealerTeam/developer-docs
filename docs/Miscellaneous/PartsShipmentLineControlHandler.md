---
layout: default
---
# PartsShipmentLineControlHandler

Domain logic for the Part Shippment object.


**Test** PartsShipmentDomainLayer

## Methods
### `public static void setInvoiceReference(List<PartsShipmentLine__c> triggerNew)`

setInvoiceReference ensures that all order lines have a reference from the shipment invoice

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|is a list of the shipment lines for processing|


**TestMethod** PartsShipmentDomainLayer.testShipment

### `public static void setPartReference(List<PartsShipmentLine__c> triggerNew)`

setPartReference ensures the Part Master is Referenced

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of TriggerNew records|


**TestMethod** PartsShipmentDomainLayer.testShipment

### `public static void setLineValues(List<PartsShipmentLine__c> triggerNew)`

setLineValues ensures the linenumber, amount and quantity on the line are set by reference

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of TriggerNew records|


**Test** PartsShipmentDomainLayer.testShipment

### `public static void updateShipHeader(List<PartsShipmentLine__c> triggerNew, Map<Id,PartsShipmentLine__c> triggerOldMap)`

Update part qty and value on shipment header

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Test** PartsShipmentDomainLayer.testShipment

---
