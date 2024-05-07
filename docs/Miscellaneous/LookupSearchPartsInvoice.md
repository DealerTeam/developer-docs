---
layout: default
---
# LookupSearchPartsInvoice

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchPartsInvoice

## Constructors
### `public LookupSearchPartsInvoice()`
### `public LookupSearchPartsInvoice(String accountId)`

LookupSearchPartsInvoice constructor used to specify an account to restrict results

#### Parameters

|Param|Description|
|---|---|
|`accountId`|accountId description|

### `public LookupSearchPartsInvoice(String accountId, Boolean hasCore)`

LookupSearchPartsInvoice overloaded constructor used to specify an account and restrict results

#### Parameters

|Param|Description|
|---|---|
|`accountId`|Customer account to return related invoices from|
|`hasCore`|Boolean value restricting results to invoices with core charges|

---
## Fields

### `private acctClause` → `String`


### `private acctId` → `Id`


### `private hasCoreCharge` → `Boolean`


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
### `private String getSubtitle(Parts_Invoice__c invoice)`
---
