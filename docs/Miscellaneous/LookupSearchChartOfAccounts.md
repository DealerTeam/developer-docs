---
layout: default
---
# LookupSearchChartOfAccounts

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchChartOfAccounts

## Constructors
### `public LookupSearchChartOfAccounts()`
---
## Fields

### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`

Search override to allow custom settings

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`selectedIds`|selectedIds description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|

### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`
### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `public static List<LookupSearchResult> getSelectionByAccountName(String accountNumber)`

Search override to allow custom settings

#### Parameters

|Param|Description|
|---|---|
|`accountNumber`|accountNumber description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|

### `private LookupSearchResult mapSearchResult(SObject o)`
---
