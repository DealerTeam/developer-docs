---
layout: default
---
# LookupSearchPartsOrder

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchPartsOrder

## Constructors
### `public LookupSearchPartsOrder()`
---
## Fields

### `public openStatus` → `Set<String>`


### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`
### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
