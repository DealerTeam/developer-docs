---
layout: default
---
# ServiceRepairOrderControlHandler class
---
## Methods
### `AssignRONumber(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `CalculateChargeAndCustomSettings(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `ChangeRONumber(List<Service_Repair_Order__c> SROList, Map<Id, Service_Repair_Order__c> SROOldMap)` → `void`
### `CompanyNumberFromUser(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `DispatchRepairOrders(List<Service_Repair_Order__c> SROList)` → `void`

 DispatchRepairOrders @notes Only called after insert

### `PreventWarrantyInvoicingSRO(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `ResrictToEditPostedSRO(List<Service_Repair_Order__c> SROList, Map<Id, Service_Repair_Order__c> SROOldMap)` → `void`
### `RestrictCompanyUpdate(List<dealer__Service_Repair_Order__c> SROList, Map<Id, dealer__Service_Repair_Order__c> SROOldMap)` → `void`
### `RewardCalculationsOnSRO(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `RollUpInternalChargesOnVehicle(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `SROCalculations(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `SROCloseUpdateVehicleService(List<dealer__Service_Repair_Order__c> SROList)` → `void`

If Contact is populated and account is not, set account based on Contact

### `UpdateVehicleInventoryWithVIN(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `VehicleInventoryWorkUpdate(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `checkForCustomSettings(List<dealer__Service_Repair_Order__c> SROList)` → `void`
### `restrictDeletion(List<dealer__Service_Repair_Order__c> OldSROList)` → `void`
---
## Inner Classes

### ServiceRepairOrderControlHandler.ServiceRepairOrderControlHandlerException class
---
