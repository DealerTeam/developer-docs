# ServiceROTransports

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `ServiceROTransports()`
---
## Fields

### `error_string` → `String`


### `partLine` → `String`


### `repairOrderId` → `Id`


### `urlParameters` → `Map<String,String>`


---
## Properties

### `jobLineId` → `String`


### `location` → `dealer__Dealer_Location__c`


### `locationId` → `String`


### `lookupPartResult` → `String`


### `masterId` → `String`


### `miscResult` → `String`


### `roId` → `String`


### `search` → `String`


### `trans` → `String`


### `ttId` → `String`


### `updateResult` → `String`


---
## Methods
### `saveAction()`
### `createPartLine()`
### `updatePartLine()`
### `getPartLine()`
### `updateLine()`
#### Return

**Type**

String

**Description**

String


**Method** updateLine


**Notes** creates or updates a service job line based on if the record has an ID or is new Additionaly this process will add techtime and parts if the standard operation code contains a parts kit

### `createMisc()`
### `updateMisc()`
### `deleteMisc()`
### `lineTotalMisc(String jobId)`
### `lineTotalParts(String jobId)`
### `lineTotalLabor(String jobId)`
### `createTechTime()`

**Method** Update the Labor Total based on BookTime if Booktime is set.

### `createTechMisc(dealer__Technician_Job_Time__c tt_pc, String jobLineID)`
### `updateTechTime()`
### `updateTechTime(String ttimeId, Decimal ttTime, Date ttDate, Decimal bookTime, Decimal laborRateOverride, String technicianId)`
### `calculateLaborCost(String jlId)`

Calculate Labor Cost

### `deletTechTime()`
### `getTechRow()`
### `getOperationCodes()`
### `getRoLines()`

This method retrieves the service job lines and all underlying records related to a repair order

### `getTechTimes()`
### `getMiscItems()`
### `getTechnicians()`
### `getClaimStatusCodes()`
### `getstatusCodes()`
### `getMiscTypes()`
### `getUserList()`
### `getReadParts()`
### `getSearchParts()`
### `getStoreInventory()`
### `lookupPart(Parts_Service_Pricing_Strategy__c ps)`
### `getPicklistValues()`
---
## Classes
### PartRow
#### Constructors
##### `PartRow(dealer__Parts_Invoice_Line__c p)`
---
#### Properties

##### `Cost` → `Decimal`


##### `ExtendedTotal` → `Decimal`


##### `Id` → `Id`


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

### PartRowInventory
#### Constructors
##### `PartRowInventory(dealer__Parts_Inventory__c p)`
---
#### Properties

##### `Cost` → `Decimal`


##### `ExtendedTotal` → `Decimal`


##### `Id` → `Id`


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

### PartSearch
#### Constructors
##### `PartSearch(dealer__Parts_Master__c p)`
---
#### Fields

##### `cost` → `Decimal`


##### `sale` → `Decimal`


---
#### Properties

##### `PartDescription` → `String`


##### `PartMFG` → `String`


##### `PartMasterId` → `Id`


##### `PartName` → `String`


##### `search_display` → `String`


---

### ROException

**Inheritance**

ROException


### StoreInventory
#### Constructors
##### `StoreInventory(String s, Integer q)`
---
#### Properties

##### `qty` → `Integer`


##### `store` → `String`


---

### cUser
#### Constructors
##### `cUser(User sU)`
---
#### Properties

##### `Id` → `String`


##### `name` → `String`


##### `profile` → `String`


##### `role` → `String`


##### `value` → `String`


---

---
