---
layout: default
---
# LookupSearchTaxZones

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchTaxZones

## Constructors
### `public LookupSearchTaxZones()`
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
### `public List<LookupSearchResult> searchTaxZonesDeal(String dealId, String searchTerm)`
### `public List<LookupSearchResult> applicableDealTaxZones(String dealId)`

applicableDealTaxZones Retrieves any matching tax zones based on tax address of the deal, if none are found return recent tax zones

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> for displaying in custom lookup component|

### `public List<LookupSearchResult> applicableTaxZones(String searchTerm, String recordId, String objectApiName)`

Retrieves any matching tax zones based on tax address of the supported record, if none are found return recent tax zones

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** applicableTaxZones

### `public List<LookupSearchResult> geSelectionByDealId(Id dealId)`
### `public List<LookupSearchResult> geSelectionById(Id recordId, String objectApiName)`

returns selected tax zone from a given record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`objectApiName`|objectApiName description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** geSelectionById

### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
