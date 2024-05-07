---
layout: default
---
# LookupSearchDealerLocationUser

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchDealerLocationUser

## Constructors
### `public LookupSearchDealerLocationUser()`
---
## Fields

### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, String LocationId)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public override List<LookupSearchResult> getRecent()`
### `public List<LookupSearchResult> getRecent(String LocationId)`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
