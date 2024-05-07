---
layout: default
---
# LookupSearchLocationFee



**Inheritance**

[LookupSearch](../Miscellaneous/LookupSearch.md)
 &gt; 
LookupSearchLocationFee


**Group** Sales

## Constructors
### `public LookupSearchLocationFee()`
---
## Fields

### `public docIconURL` → `String`


---
## Properties

### `public locationId` → `Id`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
