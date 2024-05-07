---
layout: default
---
# ServiceRepairOrderAPI

Service Layer Encapsulation of interaction with the Repair Order Object.


**Group** Service

## Fields

### `public totalParts` → `Boolean`


### `public totalLabor` → `Boolean`


### `public totalMisc` → `Boolean`


### `public totalDisc` → `Boolean`


### `public PREVENT_TAX_UPDATE_STATUS` → `List<String>`


### `private INVOCABLE_METHODS` → `List<String>`


### `private defaultPricingStrategyId` → `Id`


### `private chargeMap` → `Map<String,List<MiscChargeCode__c>>`


---
## Methods
### `global static Service_Repair_Order__c createRepairOrderFromDeal(Deal__c dealObject)`

This method serves to create repair orders from deals.  These repair orders are often referred to as delivery repair orders.

#### Parameters

|Param|Description|
|---|---|
|`dealObject`|sObject Deal|

#### Returns

|Type|Description|
|---|---|
|`Service_Repair_Order__c`|Returns the Service Repair Order sobject created.|

### `global static Service_Repair_Order__c createRepairOrderFromEstimate(Service_Estimate__c estimateObject)`

Tbhis method converts a Service Estimate to a Service Repair Order

#### Parameters

|Param|Description|
|---|---|
|`estimateObject`|The estimateObject parameter is a complete or at minimum stored Service Estimate including Record ID|

#### Returns

|Type|Description|
|---|---|
|`Service_Repair_Order__c`|Returns a Service Repair Order|

### `public static List<Cashering__c> cashTransactions(String sroId)`
### `private static ServiceRepairOrder calculateCharges(ServiceRepairOrder roWrapper)`
### `public static List<Service_Job__c> getJobLinesByRO(Id sroId)`
### `public static Boolean deleteJobLines(Set<Id> jobIds)`

Accepts a list of job line Ids and deletes them using standard dml

#### Parameters

|Param|Description|
|---|---|
|`jobIds`|jobIds description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deleteJobLines

### `public static List<Service_Job__c> createLineFromCode(StandardOpCode__c opCode, Id sroId, Service_Job__c j)`

Calls the bulkified method to retain existing functionality

#### Parameters

|Param|Description|
|---|---|
|`opCode`|opCode description|
|`sroId`|sroId description|
|`j`|j description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `public static List<Service_Job__c> createLineFromCode(Id sroId, List<JobLineData> jobDataList)`

Creates a Service Job and subline detail for each code provided

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|
|`jobDataList`|Contains the Op Code Id and optionally a service job with predefined data points|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `public static List<Service_Job__c> saveJobLine(Service_Job__c job)`

Save a job line and force recalculation of header and job lines

#### Parameters

|Param|Description|
|---|---|
|`job`|Service Job to save, Service_Repair_Order__c must be populated on the line|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `public static List<Technician_Job_Time__c> setTechTimeName(List<Technician_Job_Time__c> times, String timeType, Map<Id,Service_Job__c> jobs)`

Populates the tech time name based on type

#### Parameters

|Param|Description|
|---|---|
|`times`|times description|
|`timeType`|timeType description|
|`jobs`|jobs description|

#### Returns

|Type|Description|
|---|---|
|`List<Technician_Job_Time__c>`|return description|

### `public static void saveTechTime(Technician_Job_Time__c tt)`
### `public static Boolean deleteTechTime(Id techTimeId)`
### `public static List<Parts_Invoice_Line__c> savePartLines(List<Parts_Invoice_Line__c> lines, Map<Id,List<Parts_Ledger__c>> ledgersByPart, Boolean skipRelateLedgers)`

Creates or updates a Parts Invoice Line related to a Service Job and recalculates Service Job

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** savePartLines

### `public static Boolean deletePartLine(Id lineId)`
### `private static List<Service_Job__c> addPartsKitItemsToJob(List<JobLineData> lineDataList, Service_Repair_Order__c rodata, Map<Id,Parts_Kit__c> kitDetails)`

Creates Parts Invoice and Lines based on Job Line and Parts Kits

#### Parameters

|Param|Description|
|---|---|
|`lineDataList`|lineDataList description|
|`rodata`|rodata description|
|`kitDetails`|kitDetails description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `private static Service_Repair_Order__c createROHeaderFromEstimate(Service_Estimate__c se)`
### `private static List<Service_Job__c> createROJobLinesFromEstimate(Service_Repair_Order__c ro, List<Service_Estimate_Line__c> estLines)`
### `private static void createROSubLinesFromEstimate(Service_Estimate__c est, Id roId, Map<Id,Service_Job__c> jobsByEstimateId, List<Service_Estimate_SubLine__c> subLines)`
### `private static List<Technician_Job_Time__c> createLaborLinesFromEstimate(Id jobId, Service_Estimate_SubLine__c subLine, List<Technician_Job_Time__c> addList)`
### `private static List<Parts_Invoice_Line__c> createPartsLinesFromEstimate(Service_Repair_Order__c ro, Map<Id,Parts_Inventory__c> partMap, Service_Job__c job, Service_Estimate_SubLine__c subLine, List<Parts_Invoice_Line__c> addList)`
### `private static List<Service_Misc_Charge__c> createMiscLinesFromEstimate(Id jobId, Service_Estimate_SubLine__c subLine, List<Service_Misc_Charge__c> mLines)`
### `global static List<Service_Job__c> createJobLinesFromDeal(Deal__c dealObject)`
### `public static ServiceRepairOrder calculateAndSave(ServiceRepairOrder roWrapper)`
#### Parameters

|Param|Description|
|---|---|
|`roWrapper`|roWrapper description|

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|return description|


**Method** calculateAndSave

### `private static void linkPartRecords(List<After_Market__c> amlines, List<Service_Job__c> jobs)`

linkPartRecords description

#### Parameters

|Param|Description|
|---|---|
|`amlines`|amlines description|
|`jobs`|jobs description|

### `private static Parts_Invoice__c createDeliveryROPartInvoice(Service_Repair_Order__c ro)`

createDeliveryROPartInvoice performs the creation of the parts invoice header.

#### Parameters

|Param|Description|
|---|---|
|`Service_Repair_Order__c`||

#### Returns

|Type|Description|
|---|---|
|`Parts_Invoice__c`|Parts_Invoice__c|

### `private static void linkTechTime(List<After_Market__c> amlines, List<Service_Job__c> jobs)`
### `private static void linkServiceMisc(List<After_Market__c> amlines, List<Service_Job__c> jobs)`

Create Service Misc Charges from Aftermarket lines with a related Misc Charge Code

#### Parameters

|Param|Description|
|---|---|
|`amlines`|Aftermarket to check for Misc Codes|
|`jobs`|Jobs that may be assigned sublines|

### `private static List<Service_Job__c> jobLinesByLabor(List<After_Market__c> amlines)`
### `private static List<Service_Job__c> jobLinesBySublet(List<After_Market__c> amlines)`
### `private static List<Service_Job__c> jobLinesByPart(List<After_Market__c> amlines)`
### `private static List<Service_Job__c> jobLinesByMisc(List<After_Market__c> amlines)`

Create a service job from an Aftermarket charge of Misc, used during DRO creation

#### Parameters

|Param|Description|
|---|---|
|`amlines`|amlines description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `private static List<Service_Job__c> jobLinesByKit(List<After_Market__c> amlines)`
### `private static void createMiscChargeLines(List<JobLineData> lineData, Service_Repair_Order__c ro)`

`TESTVISIBLE`

Create misc charges based on SRO Location and Labor Type (W, I, C) for Tech time and parts

#### Parameters

|Param|Description|
|---|---|
|`lineData`|lineData description|
|`ro`|ro description|

### `private static List<Service_Misc_Charge__c> buildChargesFromTechTime(JobLineData lineData)`

Process a collection of tech times and misc codes for a location to build the applicable Service Misc Charges

#### Returns

|Type|Description|
|---|---|
|`List<Service_Misc_Charge__c>`|return description|

### `private static List<Service_Misc_Charge__c> buildChargesFromPartLine(JobLineData lineData)`

Creates a list of new or updated Service Misc charges for Job Lines with parts charges

#### Parameters

|Param|Description|
|---|---|
|`lineData`|lineData description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Misc_Charge__c>`|return description|

### `private static Decimal calculateChargeAmount(Decimal charges, MiscChargeCode__c code)`

Accepts a misc charge and various inputs to calculate the value of charge

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|

### `private static List<JobLineData> buildMiscDataWrapper(String lineType, List<Service_Job__c> jobs)`

`TESTVISIBLE`

Creates job line wrappers from a list of service jobs and a line type (labor or parts)

#### Parameters

|Param|Description|
|---|---|
|`lineType`|techTime or partLine|
|`jobs`|Service Jobs to create wrappers|

#### Returns

|Type|Description|
|---|---|
|`List<JobLineData>`|return description|

### `public static ServiceRepairOrder lineTotalParts(ServiceRepairOrder sroWrapper)`
### `private static ServiceRepairOrder lineTotalMisc(ServiceRepairOrder sroWrapper)`

Aggregates Service Misc Charges to calculate Service Job misc totals

#### Parameters

|Param|Description|
|---|---|
|`sroWrapper`|sroWrapper description|

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|return description|


**Method** lineTotalMisc

### `private static ServiceRepairOrder lineTotalDisc(ServiceRepairOrder sroWrapper)`

Aggregates Service Job Lines to calculate SRO discount totals

#### Parameters

|Param|Description|
|---|---|
|`sroWrapper`|sroWrapper description|

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|return description|


**Method** lineTotalDisc

### `public static ServiceRepairOrder lineTotalLabor(ServiceRepairOrder sroWrapper)`

Aggregates tech time pricing to calculate Service Job labor totals

#### Parameters

|Param|Description|
|---|---|
|`sroWrapper`|sroWrapper description|

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|return description|


**Method** lineTotalLabor

### `public static void saveMisc(Service_Misc_Charge__c charge, Id roId)`
### `public static Service_Job__c saveDiscount(Service_Job__c job)`

method called from UI components for saving service job discounts

#### Parameters

|Param|Description|
|---|---|
|`job`|- job to discoun|

#### Returns

|Type|Description|
|---|---|
|`Service_Job__c`|return - discounted job or LWC ingestable exception|


**Method** saveDiscount

### `public static void deleteMisc(Id chargeId, Id serviceJobId)`
### `private static void updateLaborMiscCharges(dealer__Technician_Job_Time__c tt, Decimal total, Boolean isDelete)`

recalculate misc charge pricing related to parts

#### Parameters

|Param|Description|
|---|---|
|`tt`|tt description|
|`total`|total description|
|`isDelete`|isDelete description|


**Method** updateLaborMiscCharges

### `private static Decimal calculatePartsTotal(List<Parts_Invoice_Line__c> newInvLines, Map<Id,Parts_Invoice_Line__c> existingLineMap, Service_Job__c existingJobLine)`

`TESTVISIBLE`

calulates job line part total for misc charge creation. Currently does not support bulk deletion

#### Parameters

|Param|Description|
|---|---|
|`newInvLines`|newInvLines description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Method** calculatePartsTotal

### `private static void updatePartsMiscCharges(Service_Job__c job, Decimal partTotal)`

recalculate misc charge pricing related to parts

#### Parameters

|Param|Description|
|---|---|
|`job`|job exisitng service job to calculate misc charges for|
|`partTotal`|total part total for the job line|


**Method** updatePartsMiscCharges

### `private static String assignPricingStrategy(Service_Job__c jobLine, Service_Repair_Order__c sro)`

returns pricing strategy Id based on Job Line pay type

#### Parameters

|Param|Description|
|---|---|
|`jobLine`|jobLine description|
|`sro`|sro description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** assignPricingStrategy

### `public static void invoiceRepairOrder(Id sroId)`

Method for checking if SRO meets proper invoice conditions before updating status

#### Parameters

|Param|Description|
|---|---|
|`sroId`|Id of SRO to set to invoiced status|


**Method** invoiceRepairOrder

### `private static Service_Repair_Order__c validateAndInvoiceLines(Service_Repair_Order__c sro)`

validates SRO Lines and sets Status and Invoice Date / Time.

#### Parameters

|Param|Description|
|---|---|
|`sro`||

#### Returns

|Type|Description|
|---|---|
|`Service_Repair_Order__c`|Service_Repair_Order__c|

### `public static void postRepairOrder(Service_Repair_Order__c sro)`

Method for checking if SRO meets proper posting conditions before updating status

#### Parameters

|Param|Description|
|---|---|
|`sro`|SRO to set to posted status|


**Method** postRepairOrder

### `private static Integer getTechTimeCount(List<Technician_Job_Time__c> times)`
### `private static void buildChargeMap(String locId)`
### `global static List<InvocableResponse> invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Returns

|Type|Description|
|---|---|
|`List<InvocableResponse>`|return description|


**Method** invoke

### `private static void validateInputs(List<InvocableParams> params)`

Verify the inputs are valid for the invoked method

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|


**Method** validateInputs

### `public static Service_Repair_Order__c convertAppointment(String serviceAppointmentId)`

Create a Service Repair Order from a Service Appointment Id with lines and sublines

#### Parameters

|Param|Description|
|---|---|
|`serviceAppointmentId`|serviceAppointmentId description|

#### Returns

|Type|Description|
|---|---|
|`Service_Repair_Order__c`|return description|

### `private static Decimal insertChildRecords(Service_Repair_Order__c sro, String apptId)`

Inserts the Service Job Records from  Service Appointment Line records

#### Returns

|Type|Description|
|---|---|
|`Decimal`|void|


**Method** insertChildRecords

### `private static void createTask(Service_Repair_Order__c sro)`

It created task for the newly created Service Repair Order

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createTask description

### `public static List<Service_Repair_Order__c> findRecent()`

`AURAENABLED`
### `public static List<Service_Repair_Order__c> findRoByName(String searchContext)`

`AURAENABLED`
### `public static Service_Repair_Order__c findById(Id roId)`

`AURAENABLED`
---
## Classes
### ServiceRepairOrderAPIException

**Inheritance**

ServiceRepairOrderAPIException


### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `global methodName` → `String`

`INVOCABLEVARIABLE` 

##### `global repairOrder` → `Service_Repair_Order__c`

`INVOCABLEVARIABLE` 

##### `global jobLines` → `List&lt;Service_Job__c&gt;`

`INVOCABLEVARIABLE` 

##### `global partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `global jobLines` → `List&lt;Service_Job__c&gt;`

`INVOCABLEVARIABLE` 

##### `global partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `global status` → `String`

`INVOCABLEVARIABLE` 

##### `global message` → `String`

`INVOCABLEVARIABLE` 

---

### JobLineData

Wrapper used for creating lines to get around unique id requirement of a charge code based map

#### Constructors
##### `public JobLineData(StandardOpCode__c opCode, Service_Job__c job)`
##### `public JobLineData(Service_Job__c job, String lineType, Decimal baseTotal)`
---
#### Fields

##### `public codeId` → `Id`


##### `public techTime` → `Technician_Job_Time__c`


##### `public opCode` → `StandardOpCode__c`


##### `public jobLine` → `Service_Job__c`


##### `public lineType` → `String`


##### `public baseTotal` → `Decimal`


##### `public miscCode` → `MiscChargeCode__c`


---

---
