---
layout: default
---
# LookupSearchPartsInventory

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchPartsInventory

## Constructors
### `public LookupSearchPartsInventory()`
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

### `public List<LookupSearchResult> searchByLocation(String searchTerm, Id locationId)`
### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
