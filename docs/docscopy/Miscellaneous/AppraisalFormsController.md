---
layout: default
---
# AppraisalFormsController class

Tested by AppraisalControllerTest

---
## Constructors
### `AppraisalFormsController(ApexPages.StandardController controller)`

Constructor
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `appraisal` → `dealer__Appraisal__c`

### `form` → `dealer__Form__c`

To print Impact form

### `formList` → `List<dealer__Form__c>`

Returns list of forms

### `form_id` → `String`

### `urlParams` → `String>`

---
## Methods
### `compileFDF(String fd)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getcompiledFDF(String urlParams)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `returnToAppraisal()` → `PageReference`

Return to appraisal detail page

### `selectImpactForm()` → `PageReference`
---
