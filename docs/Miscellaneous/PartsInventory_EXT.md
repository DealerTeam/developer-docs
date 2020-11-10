---
layout: default
---
# PartsInventory_EXT class

 Date            |Developer            |Work# Notes -- 2016.07.13      |David Ray            |215 Adding support for Product Tax Code for each line of a part kit to have taxes calculated individually 2016.07.20       |Jarrett Kuljis     |000427 Manual adjustments failed if Cost adjustments are performed first. 2016-08-27       |Jarrett Kuljis     |W-000503 Create a VF interface to the part inventory record.  Add support for rendering button dissabled if they user does not have access to the function. 2016-11-21       |Jarrett Kuljis     |W-000592 Save method was only inserting records, was not updating based on the status of the sObject 2016-11-24       |Sneha Utture     |W-000592 Created a VF pageReference method(returnToPart) to return from part's management to part. 2016-11-25       |Gaurav Agrawal   |W-000321 Made changes into save method to sync Parent Part Master's Manufacturer to Part's MFG

---
## Constructors
### `PartsInventory_EXT(ApexPages.standardController controller)`
---
## Properties

### `inventoryRecord` → `dealer__Parts_Inventory__c`

### `myFixedOperationsSettings` → `FixedOperationsSettings__c`

### `onHandFlag` → `Boolean`

### `partAPI` → `PartInventoryAPI`

### `pm` → `dealer__Parts_Master__c`

### `reasonforchange` → `String`

---
## Methods
### `adjustCost()` → `PageReference`

 adjustCost - Performs cost adjustment on the part record

### `adjustOnHand()` → `PageReference`

 adjustOnHand

### `adjustOrder()` → `PageReference`

 adjustOrder - Performs order adjustment on the part record

### `cancel()` → `PageReference`
### `getPartHistory()` → `List<dealer__Part_Inventory_History__c>`

 getPartHistory

### `getPartLedger()` → `List<dealer__Parts_Ledger__c>`

 getPartLedger

### `getisPartManagementAccessible()` → `Boolean`
### `partManagement()` → `PageReference`

 partManagment - redirects the user to the part management page

### `partPrintLabel()` → `PageReference`
### `partsMasterSearch(String pn)` → `List<dealer__Parts_Master__c>`
### `returnToPart()` → `PageReference`
### `save()` → `PageReference`

 save

### `searchExistingParts(String pn)` → `List<dealer__Parts_Inventory__c>`
### `setPartAPI()` → `void`
### `validateReasonForChange()` → `boolean`

 validateReasonForChange - validate 'Reason for Change' field must have value.

---
