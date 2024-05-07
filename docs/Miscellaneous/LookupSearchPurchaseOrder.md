---
layout: default
---
# LookupSearchPurchaseOrder

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchPurchaseOrder

## Constructors
### `public LookupSearchPurchaseOrder()`
### `public LookupSearchPurchaseOrder(String accountId)`

LookupSearchPurchaseOrder constructor used to specify an account to restrict results

#### Parameters

|Param|Description|
|---|---|
|`accountId`|accountId description|

### `public LookupSearchPurchaseOrder(String accountId, String sroId)`
---
## Fields

### `private whereClause` → `String`


### `private acctId` → `Id`


### `private sroId` → `Id`


### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`
### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getRelated()`
### `public override List<LookupSearchResult> getRecent()`
### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
