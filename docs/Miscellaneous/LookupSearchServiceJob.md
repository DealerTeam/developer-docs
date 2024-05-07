---
layout: default
---
# LookupSearchServiceJob

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchServiceJob

## Constructors
### `public LookupSearchServiceJob()`
### `public LookupSearchServiceJob(String serviceRepairOrderId)`
---
## Fields

### `private sroId` → `String`


### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public override List<LookupSearchResult> getRecent()`
### `public List<LookupSearchResult> getRecent(String serviceRepairOrderId)`
### `public List<LookupSearchResult> getJobsBySRO()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
