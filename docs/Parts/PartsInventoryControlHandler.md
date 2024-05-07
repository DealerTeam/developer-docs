---
layout: default
---
# PartsInventoryControlHandler



**Class** PartsInventoryControlHandler - Domain Layer Logic


**Group** Parts


**Test** PartPhysicalDomainLayer.testPartsInventoryControlHandler

## Methods
### `public static void PartsToPartMasterLocationValidation(List<dealer__Parts_Inventory__c> PartsList, Boolean isInsert)`
### `public static void PartsInventoryControlMethod(List<dealer__Parts_Inventory__c> TriggerNewParts, Map<Id,dealer__Parts_Inventory__c> TriggerOldParts, Boolean isInsert)`
### `public static void updatePartCollection(Map<Id,Parts_Inventory__c> triggerNewMap)`

Checks if PO Line trigger is executing and updates the Part map if it contains any records from this Part trigger collection

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|triggerNewMap description|

---
## Classes
### MyException

**Inheritance**

MyException


---
