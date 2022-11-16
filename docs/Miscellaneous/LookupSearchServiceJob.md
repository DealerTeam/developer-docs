# LookupSearchServiceJob

`APIVERSION: 52`

`STATUS: ACTIVE`

**Inheritance**

[LookupSearch](/Miscellaneous/LookupSearch.md)
 &gt; 
LookupSearchServiceJob

## Constructors
### `LookupSearchServiceJob()`
### `LookupSearchServiceJob(String serviceRepairOrderId)`
---
## Fields

### `docIconURL` → `String`


---
## Methods
### `search(String searchTerm, List<String> selectedIds)`
### `customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `override getRecent()`
### `getRecent(String serviceRepairOrderId)`
### `getJobsBySRO()`
### `override geSelectionById(Id selectionId)`
---
