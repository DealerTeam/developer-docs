---
layout: default
---
# ReceiptLineDataSource

ReceiptDataSource implements the DMSDataSourceInterface class to extend CRUD functionality to the glrecieptlines External Object.


**Inheritance**

[DMSDataSource](./DMSDataSource.md)
 &gt; 
ReceiptLineDataSource


**Implemented types**

[DMSDataSourceInterface](./DMSDataSourceInterface.md)


**Group** Accounting


**Author** DealerTeam

## Constructors
### `public ReceiptLineDataSource()`
---
## Fields

### `public table` → `string`

*Inherited*

### `public idFieldName` → `String`

*Inherited*

### `public fields` → `DMSDataSourceField`

*Inherited*

### `public connectionInfo` → `DataSource`

*Inherited*

### `public queryContext` → `DataSource`

*Inherited*

### `public searchContext` → `DataSource`

*Inherited*

---
## Methods
### `public override Object call(String action, Map<String,Object> args)`

call for the Callable interface. Child Classes are called from DMSDataSourceRouter.route() method. See DMSDataSource Virtual Class definition

#### Parameters

|Param|Description|
|---|---|
|`action`|action description|
|`args`|args description|

#### Returns

|Type|Description|
|---|---|
|`Object`|return description|

### `public override List<DataSource.UpsertResult> upsertRows(DataSource context)`

Helper method to upsert values to the external system

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.UpsertResult>`|DataSource.UpsertResult|


**Name** upsertRows

### `private String extractAccountNumber(String inputString)`

Using Regex, returns the value after the last colon. This is necessary since we add Store Id in front of the account number for indirect lookup matching.

#### Parameters

|Param|Description|
|---|---|
|`inputString`|inputString description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `public override List<DMSDataSourceField> fields()`

field definitions

#### Returns

|Type|Description|
|---|---|
|`List<DMSDataSourceField>`|return description|


**Name** fields

### `public virtual void setTable(string tableName)`

*Inherited*


sets the table name for a transaction

#### Parameters

|Param|Description|
|---|---|
|`tableName`|tableName description|

### `public virtual void setidFieldName(string idFieldName)`

*Inherited*


sets the id field name for a transaction

#### Parameters

|Param|Description|
|---|---|
|`idFieldName`|idFieldName description|

### `public virtual RowResults getRows()`

*Inherited*


Helper method to get record values from the external system

#### Returns

|Type|Description|
|---|---|
|`RowResults`|Datasource.Table|


**Name** getRows

### `public virtual HttpResponse makeGetCallout()`

*Inherited*


Performs the GET callout

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makeGetCallout

### `public virtual Map<String,Object> foundRow(Map<String,Object> foundRow)`

*Inherited*


Populates a row based on values from the external system

#### Returns

|Type|Description|
|---|---|
|`Map<String,Object>`|HttpResponse|


**Name** foundRow

### `public virtual List<DataSource.UpsertResult> processResults(HttpResponse response)`

*Inherited*


processResults description

#### Parameters

|Param|Description|
|---|---|
|`response`|response description|

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.UpsertResult>`|return description|

### `public virtual HttpResponse makePostCallout(String jsonBody)`

*Inherited*


Makes a POST callout - Inserts data to external system

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makePostCallout

### `public virtual HttpResponse makePutCallout(List<Map<String,Object>> rows)`

*Inherited*


makePutCallout description

#### Parameters

|Param|Description|
|---|---|
|`rows`|rows description|
|`table`|table description|
|`pkField`|pkField description|

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|return description|

### `public virtual List<DataSource.DeleteResult> deleteRows(DataSource context)`

*Inherited*


Helper method to upsert delete rows from the external system

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.DeleteResult>`|DataSource.DeleteResult|


**Name** deleteRows

### `public virtual HttpResponse makeDeleteCallout(String externalID)`

*Inherited*


Makes a DELETE callout - deletes data from external system

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makeDeleteCallout

### `public virtual Set<String> booleanFields()`

*Inherited*


booleanFields returns boolean fields from the datasource

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|Set<String>|

### `public virtual Set<String> dateFields()`

*Inherited*


booleanFields returns boolean fields from the datasource

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|Set<String>|

### `public virtual void mapBooleanFromDatasource(Map<String,Object> row, string field)`

*Inherited*


mapBooleanFromDatasource maps boolean from datasource to salesforce checkbox

#### Parameters

|Param|Description|
|---|---|
|`row`|Parses out invalid dates|
|`field`|field description|

### `public virtual void mapDateFromDatasource(Map<String,Object> row, string field)`

*Inherited*


mapDateFromDatasource maps date from datasource to salesforce date

#### Parameters

|Param|Description|
|---|---|
|`row`|Parses out invalid dates|
|`field`|field description|

### `public virtual DataSource tableDefinition()`

*Inherited*


Populates table

#### Returns

|Type|Description|
|---|---|
|`DataSource`|DataSource.Table|


**Name** tableDefinition

---
