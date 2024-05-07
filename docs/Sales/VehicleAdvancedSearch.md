---
layout: default
---
# VehicleAdvancedSearch

Used in VehicleSearchAdvanced.page


**Test** VehicleAdvancedSearch_TC


**Group** Sales

## Constructors
### `public VehicleAdvancedSearch()`
---
## Fields

### `public vehResult` → `List<Vehicle_Inventory__c>`


---
## Properties

### `public debugmode` → `Boolean`


### `public showLink` → `Boolean`


### `public proposalId` → `String`


### `public stockNum` → `String`


### `public vehType` → `String`


### `public year` → `String`


### `public make` → `String`


### `public model` → `String`


### `public trim` → `String`


### `public recordType` → `String`


### `public minPrice` → `String`


### `public maxPrice` → `String`


### `public minOdometer` → `String`


### `public maxOdometer` → `String`


### `public convMfg` → `String`


### `public convModel` → `String`


### `public minConv` → `String`


### `public maxConv` → `String`


### `public minChassis` → `String`


### `public maxChassis` → `String`


### `public storeLocation` → `String`


### `public rampType` → `String`


### `public rampOperation` → `String`


### `public extColor` → `String`


### `public intColor` → `String`


### `public interior` → `String`


### `public rampLoc` → `String`


### `public kneel` → `String`


### `public status` → `String`


### `public newUsedOther` → `String`


### `private query` → `String`


### `private user` → `List<User>`


### `private userLocKey` → `String`


### `private userLoc` → `Dealer_Location__c`


### `private userLocLat` → `Double`


### `private userLocLng` → `Double`


---
## Methods
### `public void openTab()`
### `public PageReference reset()`
### `public String getQueryString()`
### `public String buildQuery()`
### `public PageReference doSearch()`
### `public PageReference returnToDeal()`
### `public List<Vehicle_Inventory__c> getVehResult()`
### `public List<SelectOption> getYears()`
### `public List<SelectOption> getMakes()`
### `public List<SelectOption> getModels()`
### `public List<SelectOption> getTrims()`
### `public List<SelectOption> getRecordTypes()`
### `public List<SelectOption> getnewUsedOthers()`
### `public List<SelectOption> getInteriors()`
### `public List<SelectOption> getVehTypes()`
### `public List<SelectOption> getBranchLocations()`
### `public List<SelectOption> getStatusCodes()`
### `public List<SelectOption> getRampTypes()`
### `public List<SelectOption> getRampOperationItems()`
### `public List<SelectOption> getConversions()`
### `public List<SelectOption> getConversionModels()`
### `public List<SelectOption> getRampLocations()`
### `public string getFormTag()`
### `public string getTextBox()`
---
## Classes
### AdvancedSearchErrorException

**Inheritance**

AdvancedSearchErrorException


---
