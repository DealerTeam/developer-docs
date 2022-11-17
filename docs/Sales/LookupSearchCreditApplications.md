# LookupSearchCreditApplications

`APIVERSION: 48`

`STATUS: ACTIVE`



**Inheritance**

[LookupSearch](../Miscellaneous/LookupSearch.md)
 &gt; 
LookupSearchCreditApplications


**Group** Sales

## Constructors
### `LookupSearchCreditApplications()`
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
### `dealRelatedApps(String dealId)`

supRelatedDeals returns deals related to a sales up

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; for displaying in custom lookup component

### `override geSelectionById(Id selectionId)`
---
