---
layout: default
---
# virtual DMSDataSource

Virtual class for standard DMSDatasource functionality


**Group** Accounting


**Author** Tyler K. DealerTeam

## Constructors
### `public DMSDataSource()`
---
## Fields

### `public table` → `string`


### `public idFieldName` → `String`


### `public fields` → `DMSDataSourceField`


### `public connectionInfo` → `DataSource`


### `public queryContext` → `DataSource`


### `public searchContext` → `DataSource`


---
## Methods
### `public virtual Object call(String action, Map<String,Object> args)`

call for the Callable interface. Child Classes are called from DMSDataSourceRouter.route() method. you have to override this method or Salesforce returns an internal server error on sync... This code is here simply to copy / paste.

#### Parameters

|Param|Description|
|---|---|
|`action`|action description|
|`args`|args description|

#### Returns

|Type|Description|
|---|---|
|`Object`|return description|

### `public virtual void setTable(string tableName)`

sets the table name for a transaction

#### Parameters

|Param|Description|
|---|---|
|`tableName`|tableName description|

### `public virtual void setidFieldName(string idFieldName)`

sets the id field name for a transaction

#### Parameters

|Param|Description|
|---|---|
|`idFieldName`|idFieldName description|

### `public virtual RowResults getRows()`

Helper method to get record values from the external system

#### Returns

|Type|Description|
|---|---|
|`RowResults`|Datasource.Table|


**Name** getRows

### `public virtual HttpResponse makeGetCallout()`

Performs the GET callout

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makeGetCallout

### `public virtual Map<String,Object> foundRow(Map<String,Object> foundRow)`

Populates a row based on values from the external system

#### Returns

|Type|Description|
|---|---|
|`Map<String,Object>`|HttpResponse|


**Name** foundRow

### `public virtual List<DataSource.UpsertResult> upsertRows(DataSource context)`

Helper method to upsert values to the external system

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.UpsertResult>`|DataSource.UpsertResult|


**Name** upsertRows

### `public virtual List<DataSource.UpsertResult> processResults(HttpResponse response)`

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

Makes a POST callout - Inserts data to external system

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makePostCallout

### `public virtual HttpResponse makePutCallout(List<Map<String,Object>> rows)`

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

Helper method to upsert delete rows from the external system

#### Returns

|Type|Description|
|---|---|
|`List<DataSource.DeleteResult>`|DataSource.DeleteResult|


**Name** deleteRows

### `public virtual HttpResponse makeDeleteCallout(String externalID)`

Makes a DELETE callout - deletes data from external system

#### Returns

|Type|Description|
|---|---|
|`HttpResponse`|HttpResponse|


**Name** makeDeleteCallout

### `public virtual Set<String> booleanFields()`

booleanFields returns boolean fields from the datasource

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|Set<String>|

### `public virtual Set<String> dateFields()`

booleanFields returns boolean fields from the datasource

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|Set<String>|

### `public virtual void mapBooleanFromDatasource(Map<String,Object> row, string field)`

mapBooleanFromDatasource maps boolean from datasource to salesforce checkbox

#### Parameters

|Param|Description|
|---|---|
|`row`|Parses out invalid dates|
|`field`|field description|

### `public virtual void mapDateFromDatasource(Map<String,Object> row, string field)`

mapDateFromDatasource maps date from datasource to salesforce date

#### Parameters

|Param|Description|
|---|---|
|`row`|Parses out invalid dates|
|`field`|field description|

### `public virtual DataSource tableDefinition()`

Populates table

#### Returns

|Type|Description|
|---|---|
|`DataSource`|DataSource.Table|


**Name** tableDefinition

### `public virtual List<DMSDataSourceField> fields()`

gljvlines field definitions

#### Returns

|Type|Description|
|---|---|
|`List<DMSDataSourceField>`|return description|


**Name** fields

---
## Classes
### RowResults
#### Constructors
##### `public RowResults(Integer totalRows, List&lt;Map&lt;String,Object&gt;&gt; rows)`
---
#### Fields

##### `public totalRows` → `Integer`


##### `public rows` → `List&lt;Map&lt;String,Object&gt;&gt;`


---

### DMSDataSourceException

**Inheritance**

DMSDataSourceException


---
