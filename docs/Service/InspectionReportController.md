---
layout: default
---
# InspectionReportController



**Group** Service

## Methods
### `public static List<Result> getInspectionTemplateGroups()`

`AURAENABLED`
### `public static string createAndApplyTemplate(String templateName, String serviceVehicleId, String locationId, String vehicleId, String acctId)`

`AURAENABLED`
### `public static String applyTemplate(String recordId, String TemplateName)`

`AURAENABLED`
### `public static string updateLine(String lineId, String notes, String estCost, String field)`

`AURAENABLED`
### `public static string updateMetricGroup(String recordId, String lineId, List<String> checkedMetrics)`

`AURAENABLED`
### `public static string updateMetric(String recordId, String metricId, String lineId, String value)`

`AURAENABLED`
### `public static string updateRadioMetric(String recordId, String metricId, String lineId, String value)`

`AURAENABLED`
### `public static string dealerLocation(String userId)`

`AURAENABLED`
### `public static string relatedSV(String vehId)`

`AURAENABLED`
### `public static Result getSelectedTemplate(String recordId)`

`AURAENABLED`
### `public static string getSingleLine(String lineId)`

`AURAENABLED`
### `public static String getLineItems(String recordId)`

`AURAENABLED`
---
## Classes
### Result
#### Constructors
##### `public Result(String l, string v)`
---
#### Fields

##### `public label` → `String`

`AURAENABLED` 

##### `public value` → `String`

`AURAENABLED` 

---

### LineGroup

**Implemented types**

[Comparable](Comparable)

#### Constructors
##### `public LineGroup(String groupName, Integer remaining, Integer sequence, List&lt;Line&gt; lines)`
##### `public LineGroup(String groupName, Integer remaining, List&lt;Line&gt; lines)`
---
#### Fields

##### `private GroupName` → `String`


##### `private Remaining` → `Integer`


##### `private Sequence` → `Integer`


##### `private Lines` → `List&lt;Line&gt;`


---
#### Methods
##### `public Integer compareTo(Object obj)`
---

### Line
#### Constructors
##### `public Line(Inspection_Report_Lines__c header, List&lt;InspectionReportLineMetric__c&gt; metrics, Boolean complete)`
---
#### Fields

##### `private Header` → `Inspection_Report_Lines__c`


##### `private complete` → `Boolean`


##### `private Metrics` → `List&lt;InspectionReportLineMetric__c&gt;`


---

---
