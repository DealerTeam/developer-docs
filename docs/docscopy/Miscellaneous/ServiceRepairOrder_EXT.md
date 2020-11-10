---
layout: default
---
# ServiceRepairOrder_EXT class
---
## Constructors
### `ServiceRepairOrder_EXT(ApexPages.StandardController controller)`
---
## Properties

### `custSize` → `Integer`

### `customers` → `List<Contact>`

### `dmsSettings` → `dealer__DMS_Settings__c`

### `estimateApprovalMethod` → `String`

### `estimateApprovedBy` → `String`

### `estimateNotes` → `String`

### `fixedOpsSettings` → `dealer__FixedOperationsSettings__c`

### `inventoryStatus` → `String`

### `jobList` → `List<jobLineWrapper>`

### `newEstimate` → `Decimal`

### `printDateTime` → `string`

### `ro` → `dealer__Service_Repair_Order__c`

### `searchCustomerInput` → `String`

### `searchVehicleInput` → `String`

### `selectedLines` → `List<dealer__Service_Job__c>`

### `techId` → `String`

### `userLoc` → `dealer__Dealer_Location__c`

### `userLoc_list` → `list<dealer__Dealer_Location__c>`

### `vehSize` → `Integer`

### `vehicleLastService` → `Date`

### `vehicleMiles` → `Decimal`

### `vehicleVIN` → `String`

### `vehicles` → `List<dealer__Service_Vehicle__c>`

---
## Methods
### `CreateRepairOrder(String jsonString)` → `PageReference`
### `CreateServiceEstimate(String jsonString)` → `PageReference`
### `SearchCustomer()` → `PageReference`
### `SearchVehicle()` → `PageReference`
### `addCustomer()` → `PageReference`
### `addServiceLine(String joblinexml)` → `dealer__Service_Job__c`
### `addVehicle()` → `PageReference`
### `assignTech()` → `PageReference`
### `buildJobList()` → `void`
### `cashierInvoice()` → `PageReference`
### `getDMSDefaults()` → `dealer__DMS_Settings__c`
### `getInventoryStatusOptions()` → `List<SelectOption>`

 Get Inventory Vehicle Status Values

### `getInvoiceLogo()` → `String`
### `getJobList()` → `List<jobLineWrapper>`
### `getNewVehicleResource()` → `String`
### `getOpCode(String opcode)` → `dealer__StandardOpCode__c`
### `getServiceHistoryJSON()` → `String`
### `getServiceJobList()` → `List<dealer__Service_Job__c>`
### `getServicePartsList()` → `List<dealer__Parts_Invoice_Line__c>`
### `getUserId()` → `String`
### `getUserName()` → `String`
### `getestimateApprovalMethod()` → `String`
### `invoiceRO()` → `PageReference`
### `loadServiceJobLines(String masterRecordId)` → `List<dealer__Service_Job__c>`
### `openTechCard()` → `PageReference`
### `redirectInit()` → `PageReference`
### `reopenInvoice()` → `PageReference`
### `save()` → `PageReference`

 Page Reference - Save override

### `setestimateApprovalMethod(String s)` → `void`
### `techJobCard()` → `PageReference`
### `techTimeEntry()` → `PageReference`
### `updateEstaimtePageReference()` → `PageReference`
### `updateEstimate()` → `PageReference`
---
## Inner Classes

### ServiceRepairOrder_EXT.ServiceEstimateException class
---
### ServiceRepairOrder_EXT.ServiceRepairOrderException class
---
### ServiceRepairOrder_EXT.jobLineWrapper class
---
#### Constructors
##### `jobLineWrapper(dealer__Service_Job__c j)`
---
#### Properties

##### `jL` → `dealer__Service_Job__c`

##### `selected` → `boolean`

---
