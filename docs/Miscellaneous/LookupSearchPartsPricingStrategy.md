---
layout: default
---
# LookupSearchPartsPricingStrategy

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchPartsPricingStrategy

## Constructors
### `public LookupSearchPartsPricingStrategy()`
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
### `public List<LookupSearchResult> geSelectionByDealId(Id dealId)`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `public LookupSearchResult mapSearchResult(SObject o)`
---
