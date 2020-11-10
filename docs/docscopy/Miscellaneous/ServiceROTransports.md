---
layout: default
---
# ServiceROTransports class
---
## Constructors
### `ServiceROTransports()`
---
## Properties

### `error_string` → `String`

### `jobLineId` → `String`

### `location` → `dealer__Dealer_Location__c`

### `locationId` → `String`

### `lookupPartResult` → `String`

### `masterId` → `String`

### `miscResult` → `String`

### `partLine` → `String`

### `repairOrderId` → `Id`

### `roId` → `String`

### `search` → `String`

### `trans` → `String`

### `ttId` → `String`

### `updateResult` → `String`

### `urlParameters` → `String>`

---
## Methods
### `calculateLaborCost(String jlId)` → `Decimal`

 Calculate Labor Cost

### `createMisc()` → `String`

Re-Calculate Child Rows **

### `createPartLine()` → `String`
### `createTechMisc(dealer__Technician_Job_Time__c tt_pc, String jobLineID)` → `void`
### `createTechTime()` → `String`

 Update the Labor Total based on BookTime if Booktime is set.

### `deletTechTime()` → `String`
### `deleteMisc()` → `String`
### `getClaimStatusCodes()` → `String`
### `getMiscItems()` → `String`
### `getMiscTypes()` → `string`

Conversion Fields

### `getOperationCodes()` → `String`
### `getPartLine()` → `String`
### `getPicklistValues()` → `String`
### `getReadParts()` → `String`
### `getRoLines()` → `String`

 This method retrieves the service job lines and all underlying records related to a repair order

### `getSearchParts()` → `String`
### `getStoreInventory()` → `String`
### `getTechRow()` → `String`
### `getTechTimes()` → `String`
### `getTechnicians()` → `String`
### `getUserList()` → `String`
### `getstatusCodes()` → `String`
### `lineTotalLabor(String jobId)` → `void`
### `lineTotalMisc(String jobId)` → `void`
### `lineTotalParts(String jobId)` → `void`
### `lookupPart(Parts_Service_Pricing_Strategy__c ps)` → `String`
### `saveAction()` → `PageReference`

Retreive A User List

### `updateLine()` → `String`

 updateLine

### `updateMisc()` → `String`
### `updatePartLine()` → `String`
### `updateTechTime()` → `String`
### `updateTechTime(String ttimeId, Decimal ttTime, Date ttDate, Decimal bookTime, Decimal laborRateOverride, String technicianId )` → `String`
---
## Inner Classes

### ServiceROTransports.PartRow class
---
#### Constructors
##### `PartRow(dealer__Parts_Invoice_Line__c p)`
---
#### Properties

##### `Cost` → `Decimal`

##### `ExtendedTotal` → `Decimal`

##### `Id` → `public`

##### `ListPrice` → `Decimal`

##### `Negative` → `Integer`

##### `OnHand` → `Integer`

##### `OnOrder` → `Integer`

##### `Order` → `Integer`

##### `PartDescription` → `String`

##### `PartInventoryId` → `Id`

##### `PartMasterId` → `Id`

##### `PartName` → `String`

##### `QTY` → `Integer`

##### `SalePrice` → `Decimal`

##### `ServiceJobId` → `Id`

---
### ServiceROTransports.PartRowInventory class
---
#### Constructors
##### `PartRowInventory(dealer__Parts_Inventory__c p)`
---
#### Properties

##### `Cost` → `Decimal`

##### `ExtendedTotal` → `Decimal`

##### `Id` → `public`

##### `ListPrice` → `Decimal`

##### `Negative` → `Integer`

##### `OnHand` → `Integer`

##### `OnOrder` → `Integer`

##### `Order` → `Integer`

##### `PartDescription` → `String`

##### `PartInventoryId` → `Id`

##### `PartMasterId` → `Id`

##### `PartName` → `String`

##### `QTY` → `Integer`

##### `SalePrice` → `Decimal`

##### `ServiceJobId` → `Id`

---
### ServiceROTransports.PartSearch class
---
#### Constructors
##### `PartSearch(dealer__Parts_Master__c p)`
---
#### Properties

##### `PartDescription` → `String`

##### `PartMFG` → `String`

##### `PartMasterId` → `Id`

##### `PartName` → `String`

##### `cost` → `Decimal`

##### `sale` → `Decimal`

##### `search_display` → `String`

---
### ServiceROTransports.ROException class
---
### ServiceROTransports.StoreInventory class
---
#### Constructors
##### `StoreInventory(String s, Integer q)`
---
#### Properties

##### `qty` → `Integer`

##### `store` → `String`

---
### ServiceROTransports.cUser class
---
#### Properties

##### `Id` → `String`

##### `name` → `String`

##### `profile` → `String`

##### `role` → `String`

##### `value` → `String`

---
#### Methods
##### `cuser(User sU)` → `public`
---
