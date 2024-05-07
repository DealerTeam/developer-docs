---
layout: default
---
# RepairOrder
## Fields

### `private weoweObj` → `dealer__We_Owe__c`


### `private deal` → `dealer__Deal__c`


### `private sro` → `dealer__Service_Repair_Order__c`


### `private location` → `dealer__Dealer_Location__c`


### `private sop` → `dealer__StandardOpCode__c`


### `private weOweLineItemList` → `List<dealer__We_Owe_Line__c>`


### `private serviceJobUpdateList` → `List<dealer__Service_Job__c>`


---
## Properties

### `public we_oweId` → `Id`


---
## Methods
### `public pageReference createRepairOrder()`
### `public dealer__Service_Repair_Order__c repairOrder()`
### `public dealer__Service_Repair_Order__c fetchRepairOrder(Id sroId)`
### `public List<dealer__Service_Job__c> syncWeOweLines()`
---
