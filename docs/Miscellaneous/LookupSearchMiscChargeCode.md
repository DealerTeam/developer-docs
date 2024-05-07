---
layout: default
---
# LookupSearchMiscChargeCode

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchMiscChargeCode

## Constructors
### `public LookupSearchMiscChargeCode()`
### `public LookupSearchMiscChargeCode(String locId, String refObject)`
---
## Fields

### `private locationId` → `String`


### `private refObj` → `String`


### `private dynamicWhere` → `String`


### `private dynamicFields` → `String`


### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public override List<LookupSearchResult> getRecent()`
### `public List<LookupSearchResult> getRecent(String locId)`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
