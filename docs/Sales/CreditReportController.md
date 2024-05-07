---
layout: default
---
# CreditReportController



**Class** CreditReportController


**Group** Sales

## Methods
### `public static SevenHundredCreditApplicationHandler RunSevenHundredCreditReport(string appId, String reportType, List<string> bureaus)`

`AURAENABLED`

In this class we can put a method specific to each reporting provider

#### Parameters

|Param|Description|
|---|---|
|`appId`||
|`reportType`||
|`bureaus`||

#### Returns

|Type|Description|
|---|---|
|`SevenHundredCreditApplicationHandler`|Credit_Application__c|


**Method** RunSevenHundredCreditReport

### `public static Credit_Application__c getCreditApplication(String appId)`

`AURAENABLED`

Returns the Credit App for a given Id

#### Parameters

|Param|Description|
|---|---|
|`appId`|appId description|

#### Returns

|Type|Description|
|---|---|
|`Credit_Application__c`|Returns the Credit App for a given Id|

### `public static ReportTypes creditReportTypes()`

`AURAENABLED`

creditReportTypes Returns a list of credit report types configured in the custom metadata record 'CreditApplicationReportTypes.md-meta.xml'

#### Returns

|Type|Description|
|---|---|
|`ReportTypes`|return new ReportTypes|

### `public static String creditBureaus()`

`AURAENABLED`

creditReportTypes Returns a list of credit report types configured in the custom metadata record 'CreditApplicationReportTypes.md-meta.xml'

#### Returns

|Type|Description|
|---|---|
|`String`|return new ReportTypes|

---
## Classes
### ReportTypes

Wrapper for Picklist values from the values on the CreditApplicationReportTypes Custom Config / Custom Metadata record.

#### Constructors
##### `public ReportTypes()`
---
#### Fields

##### `public types` → `List&lt;ReportTypePicklistValue&gt;`

`AURAENABLED` 

---

### ReportTypePicklistValue
#### Constructors
##### `public ReportTypePicklistValue(String value)`
---
#### Fields

##### `public label` → `string`

`AURAENABLED` 

##### `public value` → `string`

`AURAENABLED` 

---

---
