---
layout: default
---
# LookupSearchFinanceCompany



**Inheritance**

[LookupSearch](../Miscellaneous/LookupSearch.md)
 &gt; 
LookupSearchFinanceCompany


**Group** Sales

## Constructors
### `public LookupSearchFinanceCompany()`
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
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
