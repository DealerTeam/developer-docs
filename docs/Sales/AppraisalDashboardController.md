---
layout: default
---
# AppraisalDashboardController

Visualforce controller for the Appraisal Dashboard.  This class is very specific to the VF experience.


**Group** Sales

## Constructors
### `public AppraisalDashboardController()`

Controller


**Method** AppraisalDashboardController

---
## Fields

### `private staticQuery` → `String`


### `private staticMaxRows` → `Integer`


### `private appraisalFields` → `String`


### `private vehicleFields` → `String`


### `private query` → `String`


---
## Properties

### `public maxRows` → `integer`


maxRows denotes the number of Rows to publish

### `public appraisals` → `List<dealer__Appraisal__c>`


appraisals is a list of appraisals in the display port.

### `public years` → `List<SelectOption>`


### `public makes` → `List<SelectOption>`


### `public rampOperations` → `List<SelectOption>`


### `public rampLocations` → `List<SelectOption>`


### `public conversions` → `List<SelectOption>`


### `public statuses` → `List<SelectOption>`


### `public appraisers` → `List<SelectOption>`


### `public locations` → `List<SelectOption>`


### `public year` → `List<String>`


### `public make` → `List<String>`


### `public status` → `List<String>`


### `public rampOperation` → `List<String>`


### `public rampLocation` → `List<String>`


### `public conversion` → `List<String>`


### `public appraiser` → `List<String>`


### `public location` → `List<String>`


### `public model` → `String`


### `public vin` → `String`


### `public appraisalMin` → `Decimal`


### `public appraisalMax` → `Decimal`


### `public filter` → `String`


### `public GetInitialJSON` → `String`


---
## Methods
### `public void appraisalSearch()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** appraisalSearch

### `public static JsonResponse GetJSON(String filterBy, String rowlimit, String offset)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`filterBy`||
|`rowlimit`||
|`offset`||

#### Returns

|Type|Description|
|---|---|
|`JsonResponse`|JsonResponse|


**Method** GetJSON

### `public void clearFilters()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** clearFilters

### `public List<SelectOption> getYears()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getYears

### `public List<SelectOption> getMakes()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getMakes

### `public List<SelectOption> getRampOperations()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getRampOperations

### `public List<SelectOption> getRampLocations()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|<SelectOption>|


**Method** getRampLocations

### `public List<SelectOption> getConversions()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getConversions

### `public List<SelectOption> getAppraisalStatuses()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getAppraisalStatuses

### `public List<SelectOption> getLocations()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|public List<SelectOption>|


**Method** getLocations

### `public List<SelectOption> getAppraisers()`

This method obtains a unique list of appraisal users.

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getAppraisers

---
## Classes
### JsonResponse



**Method** JsonResponse

#### Fields

##### `private total` → `Integer`


##### `private appraisals` → `List&lt;dealer__Appraisal__c&gt;`


---

---
