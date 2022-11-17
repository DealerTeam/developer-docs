# AppraisalDashboardController

`APIVERSION: 45`

`STATUS: ACTIVE`

Visualforce controller for the Appraisal Dashboard.  This class is very specific to the VF experience.


**Group** Sales

## Constructors
### `AppraisalDashboardController()`

Controller


**Method** AppraisalDashboardController

---
## Properties

### `GetInitialJSON` → `String`


### `appraisalMax` → `Decimal`


### `appraisalMin` → `Decimal`


### `appraisals` → `List<dealer__Appraisal__c>`


appraisals is a list of appraisals in the display port.

### `appraiser` → `List<String>`


### `appraisers` → `List<SelectOption>`


### `conversion` → `List<String>`


### `conversions` → `List<SelectOption>`


### `filter` → `String`


### `location` → `List<String>`


### `locations` → `List<SelectOption>`


### `make` → `List<String>`


### `makes` → `List<SelectOption>`


### `maxRows` → `integer`


maxRows denotes the number of Rows to publish

### `model` → `String`


### `rampLocation` → `List<String>`


### `rampLocations` → `List<SelectOption>`


### `rampOperation` → `List<String>`


### `rampOperations` → `List<SelectOption>`


### `status` → `List<String>`


### `statuses` → `List<SelectOption>`


### `vin` → `String`


### `year` → `List<String>`


### `years` → `List<SelectOption>`


---
## Methods
### `appraisalSearch()`
#### Return

**Type**

void

**Description**

void


**Method** appraisalSearch

### `static GetJSON(String filterBy, String rowlimit, String offset)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`filterBy`||
|`rowlimit`||
|`offset`||

#### Return

**Type**

JsonResponse

**Description**

JsonResponse


**Method** GetJSON

### `clearFilters()`
#### Return

**Type**

void

**Description**

void


**Method** clearFilters

### `getYears()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getYears

### `getMakes()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getMakes

### `getRampOperations()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getRampOperations

### `getRampLocations()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

&lt;SelectOption&gt;


**Method** getRampLocations

### `getConversions()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getConversions

### `getAppraisalStatuses()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getAppraisalStatuses

### `getLocations()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

public List&lt;SelectOption&gt;


**Method** getLocations

### `getAppraisers()`

This method obtains a unique list of appraisal users.

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getAppraisers

---
## Classes
### JsonResponse



**Method** JsonResponse


---
