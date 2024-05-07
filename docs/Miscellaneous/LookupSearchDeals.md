---
layout: default
---
# LookupSearchDeals

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchDeals

## Constructors
### `public LookupSearchDeals()`
---
## Fields

### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public override List<LookupSearchResult> getRecent()`
### `public List<LookupSearchResult> appRelatedDeals(String appId)`

supRelatedDeals returns deals related to a sales up

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> for displaying in custom lookup component|

### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
