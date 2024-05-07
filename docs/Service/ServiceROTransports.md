---
layout: default
---
# ServiceROTransports



**Group** Service

## Constructors
### `public ServiceROTransports()`
---
## Fields

### `public partLine` → `String`


### `public repairOrderId` → `Id`


### `public error_string` → `String`


### `public urlParameters` → `Map<String,String>`


---
## Properties

### `public trans` → `String`


### `public roId` → `String`


### `public jobLineId` → `String`


### `public ttId` → `String`


### `public updateResult` → `String`


### `public miscResult` → `String`


### `public lookupPartResult` → `String`


### `public masterId` → `String`


### `public locationId` → `String`


### `public search` → `String`


### `public location` → `dealer__Dealer_Location__c`


---
## Methods
### `public PageReference saveAction()`
### `public String createPartLine()`
### `public String updatePartLine()`
### `public String getPartLine()`
### `public String updateLine()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateLine


**Notes** creates or updates a service job line based on if the record has an ID or is new Additionaly this process will add techtime and parts if the standard operation code contains a parts kit

### `public String createMisc()`
### `public String updateMisc()`
### `public String deleteMisc()`
### `public void lineTotalMisc(String jobId)`
### `public void lineTotalParts(String jobId)`
### `public void lineTotalLabor(String jobId)`
### `public String createTechTime()`

**Method** Update the Labor Total based on BookTime if Booktime is set.

### `public void createTechMisc(dealer__Technician_Job_Time__c tt_pc, String jobLineID)`
### `public String updateTechTime()`
### `public String updateTechTime(String ttimeId, Decimal ttTime, Date ttDate, Decimal bookTime, Decimal laborRateOverride, String technicianId)`
### `private void createMiscChargeLines(dealer__Technician_Job_Time__c tt, Parts_Invoice_Line__c line, String lineType)`
### `private void updateLaborMiscCharges(dealer__Technician_Job_Time__c tt, Decimal total, Boolean isDelete)`
### `private void updatePartsMiscCharges(Parts_Invoice_Line__c line, Decimal total, Decimal oldPartLine, Boolean isDelete)`
### `public Decimal calculateLaborCost(String jlId)`

Calculate Labor Cost

### `public String deletTechTime()`
### `public String getTechRow()`
### `public String getOperationCodes()`
### `public String getRoLines()`

This method retrieves the service job lines and all underlying records related to a repair order

### `public String getTechTimes()`
### `public String getMiscItems()`
### `public String getTechnicians()`
### `public String getClaimStatusCodes()`
### `public String getstatusCodes()`
### `public string getMiscTypes()`
### `public String getUserList()`
### `public String getReadParts()`
### `public String getSearchParts()`
### `public String getStoreInventory()`
### `public String lookupPart(Parts_Service_Pricing_Strategy__c ps)`
### `private Decimal calculatePricing(Parts_Inventory__c pi, Parts_Service_Pricing_Strategy__c ps)`
### `public String getPicklistValues()`
---
## Classes
### cUser
#### Constructors
##### `public cUser(User sU)`
---
#### Properties

##### `public Id` → `String`


##### `public name` → `String`


##### `public value` → `String`


##### `public role` → `String`


##### `public profile` → `String`


---

### PartSearch
#### Constructors
##### `public PartSearch(dealer__Parts_Master__c p)`
---
#### Fields

##### `public cost` → `Decimal`


##### `public sale` → `Decimal`


---
#### Properties

##### `public PartName` → `String`


##### `public PartDescription` → `String`


##### `public PartMasterId` → `Id`


##### `public PartMFG` → `String`


##### `public search_display` → `String`


---

### StoreInventory
#### Constructors
##### `public StoreInventory(String s, Integer q)`
---
#### Properties

##### `public store` → `String`


##### `public qty` → `Integer`


---

### PartRow
#### Constructors
##### `public PartRow(dealer__Parts_Invoice_Line__c p)`
---
#### Properties

##### `public ServiceJobId` → `Id`


##### `public Id` → `Id`


##### `public PartMasterId` → `Id`


##### `public PartInventoryId` → `Id`


##### `public PartName` → `String`


##### `public PartDescription` → `String`


##### `public OnHand` → `Integer`


##### `public OnOrder` → `Integer`


##### `public ListPrice` → `Decimal`


##### `public SalePrice` → `Decimal`


##### `public Cost` → `Decimal`


##### `public QTY` → `Integer`


##### `public Order` → `Integer`


##### `public Negative` → `Integer`


##### `public ExtendedTotal` → `Decimal`


---

### PartRowInventory
#### Constructors
##### `public PartRowInventory(dealer__Parts_Inventory__c p)`
---
#### Properties

##### `public ServiceJobId` → `Id`


##### `public Id` → `Id`


##### `public PartMasterId` → `Id`


##### `public PartInventoryId` → `Id`


##### `public PartName` → `String`


##### `public PartDescription` → `String`


##### `public OnHand` → `Integer`


##### `public OnOrder` → `Integer`


##### `public ListPrice` → `Decimal`


##### `public SalePrice` → `Decimal`


##### `public Cost` → `Decimal`


##### `public QTY` → `Integer`


##### `public Order` → `Integer`


##### `public Negative` → `Integer`


##### `public ExtendedTotal` → `Decimal`


---

### ROException

**Inheritance**

ROException


---
