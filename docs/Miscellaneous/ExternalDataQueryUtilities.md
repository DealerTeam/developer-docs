---
layout: default
---
# ExternalDataQueryUtilities

DMS External Datasource Query Utilties

## Fields

### `public PAGE_SIZE` → `Integer`


### `private TOP_LEVEL_FILTERS` → `Set<DataSource.FilterType>`


Set of Available Datasource.FilterTypes

### `private FILTER_PARAMETERS` → `Map<DataSource.FilterType,String>`


Maps DataSource.FilterType ENUM to comparison operators defined in the Common CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

---
## Methods
### `public static String buildRESTResource(DataSource queryContext, String baseUrl, String externalIdFieldName)`

buildRESTResource Builds REST Resource using SOQL query context to be compatible with the CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

#### Parameters

|Param|Description|
|---|---|
|`queryContext`|queryContext description|
|`baseUrl`|baseUrl description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `public static String buildRESTResource(DataSource searchContext, String baseUrl, String externalIdFieldName)`

buildRESTResource Builds REST Resource using SOSL query context to be compatible with the CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

#### Parameters

|Param|Description|
|---|---|
|`queryContext`|queryContext description|
|`baseUrl`|baseUrl description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `public static String convertDate(String dateString)`

convertDate Converts datetime string to date string

#### Parameters

|Param|Description|
|---|---|
|`dateString`|dateString description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `private static String buildOrderString(DataSource.Order orders)`

buildOrderString Extracts filters and converts them to be compatible with the Common CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

#### Returns

|Type|Description|
|---|---|
|`String`|return String|

### `private static String buildFilterString(DataSource topLevelType, DataSource filter, List<Filter> filterArray, String externalIdFieldName)`

Recursive function. Will go as many levels deee as there are sub-filters in the DataSource.Filter object Converts SOQL filter (DataSource.Filter) to query params compatible with the Common CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

#### Parameters

|Param|Description|
|---|---|
|`filter`|filter description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `private static List<String> processFilters(List<Filter> filters)`

processFilters Formats filter string for url encoding to be compatible with the CRUD API CRUD API Documentation: https://github.com/mevdschee/php-crud-api

#### Parameters

|Param|Description|
|---|---|
|`filters`|filters description|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|return description|

---
## Classes
### Filter
#### Constructors
##### `public Filter(DataSource topLevelType, DataSource type, String filterValue)`
---
#### Fields

##### `public filterValue` → `String`


##### `public type` → `DataSource`


##### `public topLevelType` → `DataSource`


---

### ExternalDataQueryException

**Inheritance**

ExternalDataQueryException


---
