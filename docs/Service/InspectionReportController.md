# InspectionReportController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Methods
### `static getInspectionTemplateGroups()`

`AURAENABLED`
### `static createAndApplyTemplate(String templateName, String serviceVehicleId, String locationId, String vehicleId, String acctId)`

`AURAENABLED`
### `static applyTemplate(String recordId, String TemplateName)`

`AURAENABLED`
### `static updateLine(String lineId, String notes, String estCost, String field)`

`AURAENABLED`
### `static updateMetricGroup(String recordId, String lineId, List<String> checkedMetrics)`

`AURAENABLED`
### `static updateMetric(String recordId, String metricId, String lineId, String value)`

`AURAENABLED`
### `static updateRadioMetric(String recordId, String metricId, String lineId, String value)`

`AURAENABLED`
### `static dealerLocation(String userId)`

`AURAENABLED`
### `static relatedSV(String vehId)`

`AURAENABLED`
### `static getSelectedTemplate(String recordId)`

`AURAENABLED`
### `static getSingleLine(String lineId)`

`AURAENABLED`
### `static getLineItems(String recordId)`

`AURAENABLED`
---
## Classes
### Line
#### Constructors
##### `Line(Inspection_Report_Lines__c header, List&lt;InspectionReportLineMetric__c&gt; metrics, Boolean complete)`
---

### LineGroup

**Implemented types**

[Comparable](Comparable)

#### Constructors
##### `LineGroup(String groupName, Integer remaining, Integer sequence, List&lt;Line&gt; lines)`
##### `LineGroup(String groupName, Integer remaining, List&lt;Line&gt; lines)`
---
#### Methods
##### `compareTo(Object obj)`
---

### Result
#### Constructors
##### `Result(String l, string v)`
---
#### Fields

##### `label` → `String`

`AURAENABLED` 

##### `value` → `String`

`AURAENABLED` 

---

---
