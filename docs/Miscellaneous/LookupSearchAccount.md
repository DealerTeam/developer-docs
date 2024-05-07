---
layout: default
---
# LookupSearchAccount

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchAccount

## Constructors
### `public LookupSearchAccount()`
---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds, Boolean isVendor)`

searchs accounts with ability to respect Vendor boolean

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|phrase to match|
|`selectedIds`|Ids to exclude from search results|
|`isVendor`|Should only acounts where Vendor is true be returned|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> accounts for display in lookup component|


**Method** search

### `public override List<LookupSearchResult> getRecent()`
### `public List<LookupSearchResult> getRecent(Boolean isVendor)`

get recent accounts with ability to respect vendor boolean

#### Parameters

|Param|Description|
|---|---|
|`isVendor`|Should only acounts where Vendor is true be returned|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> accounts for display in lookup component|


**Method** getRecent

### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
