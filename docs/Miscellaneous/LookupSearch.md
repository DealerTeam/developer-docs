---
layout: default
---
# abstract LookupSearch
## Methods
### `public List<LookupSearchResult> search(String searchTerm)`
### `public List<LookupSearchResult> search(String searchTerm, Map<Object,Object> options)`
### `public List<LookupSearchResult> getRecent(Map<Object,Object> options)`
### `private List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `private List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`
### `public List<LookupSearchResult> getRecent()`
### `private List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`
### `public List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
### `private String buildWhereClauseStringFields(Map<String,List<String>> whereMap)`

Formats the where clause from the map of fields and values

#### Parameters

|Param|Description|
|---|---|
|`whereMap`|Map of field api names with the values to filter them by|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `private String buildWhereClausePicklistMultiFields(Map<String,String> whereMap)`
### `private String buildWhereClauseBooleanFields(Map<String,Boolean> whereMap)`

Formats the where clause from the map of fields and boolean values

#### Parameters

|Param|Description|
|---|---|
|`whereMap`|whereMap description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

---
## Classes
### whereClause
#### Constructors
##### `public whereClause()`
##### `public whereClause(Map&lt;Object,Object&gt; paramMap)`

Constructor used by the extension classes to convert the vague objects from the lookup LWC to usable maps

###### Parameters

|Param|Description|
|---|---|
|`paramMap`|paramMap description|

---
#### Fields

##### `public stringFields` → `Map&lt;String,List&lt;String&gt;&gt;`


##### `public booleanFields` → `Map&lt;String,Boolean&gt;`


##### `public pickMultiFields` → `Map&lt;String,String&gt;`


---

---
