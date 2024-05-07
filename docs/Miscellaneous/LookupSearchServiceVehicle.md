---
layout: default
---
# LookupSearchServiceVehicle

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchServiceVehicle

## Constructors
### `public LookupSearchServiceVehicle()`
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
### `public list<LookupSearchResult> relatedServiceVehicles(String AccountId)`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
