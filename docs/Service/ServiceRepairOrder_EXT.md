# ServiceRepairOrder_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `ServiceRepairOrder_EXT(ApexPages.StandardController controller)`
---
## Fields

### `dmsSettings` → `dealer__DMS_Settings__c`


### `estimateApprovalMethod` → `String`


### `jobList` → `List<jobLineWrapper>`


### `ro` → `dealer__Service_Repair_Order__c`


### `userLoc_list` → `list<dealer__Dealer_Location__c>`


---
## Properties

### `custSize` → `Integer`


### `customers` → `List<Contact>`


### `estimateApprovedBy` → `String`


### `estimateNotes` → `String`


### `fixedOpsSettings` → `dealer__FixedOperationsSettings__c`


### `inventoryStatus` → `String`


### `newEstimate` → `Decimal`


### `printDateTime` → `string`


### `searchCustomerInput` → `String`


### `searchVehicleInput` → `String`


### `selectedLines` → `List<dealer__Service_Job__c>`


### `techId` → `String`


### `userLoc` → `dealer__Dealer_Location__c`


### `vehSize` → `Integer`


### `vehicleLastService` → `Date`


### `vehicleMiles` → `Decimal`


### `vehicleVIN` → `String`


### `vehicles` → `List<dealer__Service_Vehicle__c>`


---
## Methods
### `getUserName()`
### `getUserId()`
### `getestimateApprovalMethod()`
### `setestimateApprovalMethod(String s)`
### `getDMSDefaults()`
### `getInvoiceLogo()`
### `getInventoryStatusOptions()`
### `getServicePartsList()`
### `getServiceJobList()`
### `getJobList()`
### `buildJobList()`
### `redirectInit()`
### `addCustomer()`
### `techTimeEntry()`
### `save()`
### `invoiceRO()`
### `reopenInvoice()`
### `techJobCard()`
### `assignTech()`
### `openTechCard()`
### `cashierInvoice()`
### `SearchCustomer()`
### `SearchVehicle()`
### `updateEstimate()`
### `updateEstaimtePageReference()`
### `addVehicle()`
### `getNewVehicleResource()`
### `getServiceHistoryJSON()`
### `static getOpCode(String opcode)`

`REMOTEACTION`
### `static CreateServiceEstimate(String jsonString)`

`REMOTEACTION`
### `static CreateRepairOrder(String jsonString)`

`REMOTEACTION`
### `static loadServiceJobLines(String masterRecordId)`

`REMOTEACTION`
### `static addServiceLine(String joblinexml)`

`REMOTEACTION`
---
## Classes
### ServiceEstimateException

**Inheritance**

ServiceEstimateException


### ServiceRepairOrderException

**Inheritance**

ServiceRepairOrderException


### jobLineWrapper
#### Constructors
##### `jobLineWrapper(dealer__Service_Job__c j)`
---
#### Properties

##### `jL` → `dealer__Service_Job__c`


##### `selected` → `boolean`


---

---
