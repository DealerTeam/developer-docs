---
layout: default
---
# PartsPhysical_EXT class

 PartsPhysical_EXT - Controller Extension to create and perform the physical inventory process @test PartPhysicalInventoryServiceLayer.testPartsMasterTriggerHandler dealer__PartsPhysicalInvenotry__c - Light object, no sharing or bulk API Access dealer__PartsPhysicalDetail - records of each part that is part of the physical (this can be the entire location inventory, specific Bin locations or a periodical / random selection of parts) General Steps to a Physical are as follows. 1) General the physical file based on type - location, bin, dollar or random. Or part# Sequence.  (Zero quantity suppressed) 2) Prepare the Count Sheets for Print / Or Scan 3) Perform the Physical (non software) 4) Process the count sheets - hand enter the values or process the scanner files 5) Enter any hand writes - parts found that do not have a record in the system 6) Variance Report on the values that the hand count differs from the inventory count. 7) Variance Report on the Cost differential betwen the current master and FIFO Value - Optional Step 8) Post the Variance, update the General Ledger and Post the updated Quantity to the Inventory 9) Prepare the physical audit report and attach to the Physical. 2016.08.30       |Gaurav               |Case# 00002013 Added code coverage for part master description change 2016.09.23       |Gaurav               |Case# 00002007 Added Notes field in query of Parts Physical Detail object's records 2017.01.13       |Gaurav               |W-000892 Added code to add Parts using Batch class and moved the logic into PartsPhysicalInventoryAPI class

---
## Constructors
### `PartsPhysical_EXT(ApexPages.StandardController c)`
---
## Properties

### `batchId` → `Id`

### `binLocations` → `String`

### `detail_records` → `List<dealer__PartsPhysicalDetail__c>`

### `dollarValue` → `Decimal`

### `isBatchRunning` → `boolean`

### `jobs` → `List<AsyncApexJob>`

### `loc` → `dealer__Dealer_Location__c`

### `physicalType` → `String`

### `ppi` → `dealer__PartPhysicalInventory__c`

### `progress` → `string`

---
## Methods
### `completePhysical()` → `PageReference`
### `getBatchStatus()` → `Pagereference`

 Create the physical file and lock the remaining inventory for that store.  When the physical inventory is created it essentially makes a copy of the active inventory for that location.  All physical assesment of that inventory is applied to the records in this copy.

### `getPhyscialTypeOptions()` → `List<SelectOption>`
### `newPhysicalInventory()` → `PageReference`
### `redirectPage()` → `PageReference`
### `saveCounts()` → `PageReference`
---
