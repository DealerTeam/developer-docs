---
layout: default
---
# InspectionReportController class
---
## Methods
### `applyTemplate(String recordId, String TemplateName)` → `String`
### `createAndApplyTemplate(String templateName, String serviceVehicleId, String locationId, String vehicleId, String acctId)` → `string`
### `dealerLocation(String userId)` → `string`
### `getInspectionTemplateGroups()` → `List<Result>`
### `getLineItems(String recordId)` → `String`
### `getSelectedTemplate(String recordId)` → `Result`

Inspection Template Results *

### `getSingleLine(String lineId)` → `string`

Line Items *

### `relatedSV(String vehId)` → `string`
### `updateLine(String lineId, String notes, String estCost, String field)` → `string`
### `updateMetric(String recordId, String metricId, String lineId, String value )` → `string`
### `updateMetricGroup(String recordId, String lineId, List<String> checkedMetrics)` → `string`
### `updateRadioMetric(String recordId, String metricId, String lineId, String value )` → `string`
---
## Inner Classes

### InspectionReportController.Line class
---
#### Constructors
##### `Line(Inspection_Report_Lines__c header, List<InspectionReportLineMetric__c> metrics, Boolean complete)`
---
### InspectionReportController.LineGroup class
---
#### Constructors
##### `LineGroup(String groupName, Integer remaining, Integer sequence, List<Line> lines)`
##### `LineGroup(String groupName, Integer remaining, List<Line> lines)`
---
#### Methods
##### `compareTo(Object obj)` → `Integer`
---
### InspectionReportController.Result class
---
#### Constructors
##### `Result(String l, string v)`
---
#### Properties

##### `label` → `String`

##### `value` → `String`

---
