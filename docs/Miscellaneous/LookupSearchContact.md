---
layout: default
---
# LookupSearchContact

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchContact

## Constructors
### `public LookupSearchContact()`
---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, String AccountId)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public list<LookupSearchResult> relatedContacts(String AccountId)`
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
