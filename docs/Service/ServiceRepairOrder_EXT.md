---
layout: default
---
# ServiceRepairOrder_EXT



**Group** Service

## Constructors
### `public ServiceRepairOrder_EXT(ApexPages controller)`
---
## Fields

### `public jobList` → `List<jobLineWrapper>`


### `public dmsSettings` → `dealer__DMS_Settings__c`


### `public estimateApprovalMethod` → `String`


### `public ro` → `dealer__Service_Repair_Order__c`


### `public userLoc_list` → `list<dealer__Dealer_Location__c>`


---
## Properties

### `public searchCustomerInput` → `String`


### `public searchVehicleInput` → `String`


### `public vehicleMiles` → `Decimal`


### `public vehicleLastService` → `Date`


### `public vehicleVIN` → `String`


### `public inventoryStatus` → `String`


### `public customers` → `List<Contact>`


### `public vehicles` → `List<dealer__Service_Vehicle__c>`


### `public selectedLines` → `List<dealer__Service_Job__c>`


### `public newEstimate` → `Decimal`


### `public estimateApprovedBy` → `String`


### `public estimateNotes` → `String`


### `public custSize` → `Integer`


### `public vehSize` → `Integer`


### `public techId` → `String`


### `public userLoc` → `dealer__Dealer_Location__c`


### `public fixedOpsSettings` → `dealer__FixedOperationsSettings__c`


### `public printDateTime` → `string`


---
## Methods
### `public String getUserName()`
### `public String getUserId()`
### `public String getestimateApprovalMethod()`
### `public void setestimateApprovalMethod(String s)`
### `public dealer__DMS_Settings__c getDMSDefaults()`
### `public String getInvoiceLogo()`
### `public List<SelectOption> getInventoryStatusOptions()`
### `public List<dealer__Parts_Invoice_Line__c> getServicePartsList()`
### `public List<dealer__Service_Job__c> getServiceJobList()`
### `public List<jobLineWrapper> getJobList()`
### `public void buildJobList()`
### `public PageReference redirectInit()`
### `public PageReference addCustomer()`
### `public PageReference techTimeEntry()`
### `public PageReference save()`
### `public PageReference invoiceRO()`
### `public PageReference reopenInvoice()`
### `public PageReference techJobCard()`
### `public PageReference assignTech()`
### `public PageReference openTechCard()`
### `public PageReference cashierInvoice()`
### `public PageReference SearchCustomer()`
### `public PageReference SearchVehicle()`
### `public PageReference updateEstimate()`
### `public PageReference updateEstaimtePageReference()`
### `public PageReference addVehicle()`
### `public String getNewVehicleResource()`
### `public String getServiceHistoryJSON()`
### `public static dealer__StandardOpCode__c getOpCode(String opcode)`

`REMOTEACTION`
### `public static PageReference CreateServiceEstimate(String jsonString)`

`REMOTEACTION`
### `public static PageReference CreateRepairOrder(String jsonString)`

`REMOTEACTION`
### `public static List<dealer__Service_Job__c> loadServiceJobLines(String masterRecordId)`

`REMOTEACTION`
### `public static dealer__Service_Job__c addServiceLine(String joblinexml)`

`REMOTEACTION`
---
## Classes
### jobLineWrapper
#### Constructors
##### `public jobLineWrapper(dealer__Service_Job__c j)`
---
#### Properties

##### `public jL` → `dealer__Service_Job__c`


##### `public selected` → `boolean`


---

### ServiceEstimateException

**Inheritance**

ServiceEstimateException


### ServiceRepairOrderException

**Inheritance**

ServiceRepairOrderException


---
