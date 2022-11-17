# CreditReportController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CreditReportController


**Group** Sales

## Methods
### `static RunSevenHundredCreditReport(string appId, String reportType, List<string> bureaus)`

`AURAENABLED`

In this class we can put a method specific to each reporting provider

#### Parameters

|Param|Description|
|---|---|
|`appId`||
|`reportType`||
|`bureaus`||

#### Return

**Type**

SevenHundredCreditApplicationHandler.InquiryResult

**Description**

Credit_Application__c


**Method** RunSevenHundredCreditReport

### `static getCreditApplication(String appId)`

`AURAENABLED`

Returns the Credit App for a given Id

#### Parameters

|Param|Description|
|---|---|
|`appId`|appId description|

#### Return

**Type**

Credit_Application__c

**Description**

Returns the Credit App for a given Id

### `static creditReportTypes()`

`AURAENABLED`

creditReportTypes Returns a list of credit report types configured in the custom metadata record 'CreditApplicationReportTypes.md-meta.xml'

#### Return

**Type**

ReportTypes

**Description**

return new ReportTypes

### `static creditBureaus()`

`AURAENABLED`

creditReportTypes Returns a list of credit report types configured in the custom metadata record 'CreditApplicationReportTypes.md-meta.xml'

#### Return

**Type**

String

**Description**

return new ReportTypes

---
## Classes
### ReportTypePicklistValue
#### Constructors
##### `ReportTypePicklistValue(String value)`
---
#### Fields

##### `label` → `string`

`AURAENABLED` 

##### `value` → `string`

`AURAENABLED` 

---

### ReportTypes

Wrapper for Picklist values from the values on the CreditApplicationReportTypes Custom Config / Custom Metadata record.

#### Constructors
##### `ReportTypes()`
---
#### Fields

##### `types` → `List&lt;ReportTypePicklistValue&gt;`

`AURAENABLED` 

---

---
