---
layout: default
---
# AppraisalDashboardController class

@description

---
## Constructors
### `AppraisalDashboardController()`

Controller
---
## Properties

### `GetInitialJSON` → `String`

@description

### `appraisalMax` → `Decimal`

@description

### `appraisalMin` → `Decimal`

@description

### `appraisals` → `List<dealer__Appraisal__c>`

@description

### `appraiser` → `List<String>`

@description

### `appraisers` → `List<SelectOption>`

@description

### `conversion` → `List<String>`

@description

### `conversions` → `List<SelectOption>`

@description

### `filter` → `String`

@description

### `location` → `List<String>`

@description

### `locations` → `List<SelectOption>`

@description

### `make` → `List<String>`

@description

### `makes` → `List<SelectOption>`

@description

### `maxRows` → `integer`

@description

### `model` → `String`

@description

### `rampLocation` → `List<String>`

@description

### `rampLocations` → `List<SelectOption>`

@description

### `rampOperation` → `List<String>`

@description

### `rampOperations` → `List<SelectOption>`

@description

### `status` → `List<String>`

@description

### `statuses` → `List<SelectOption>`

@description

### `vin` → `String`

@description

### `year` → `List<String>`

@description

### `years` → `List<SelectOption>`

@description

---
## Methods
### `GetJSON(String filterBy, String rowlimit, String offset)` → `JsonResponse`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | y |
|`` | t |
|`` | t |

### `appraisalSearch()` → `void`
### `clearFilters()` → `void`
### `getAppraisalStatuses()` → `List<SelectOption>`
### `getAppraisers()` → `List<SelectOption>`
### `getConversions()` → `List<SelectOption>`
### `getLocations()` → `List<SelectOption>`
### `getMakes()` → `List<SelectOption>`
### `getRampLocations()` → `List<SelectOption>`
### `getRampOperations()` → `List<SelectOption>`
### `getYears()` → `List<SelectOption>`
---
## Inner Classes

### AppraisalDashboardController.JsonResponse class

@description

---
