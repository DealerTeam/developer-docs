---
layout: default
---
# LookupSearchAppraisal

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchAppraisal

## Constructors
### `public LookupSearchAppraisal()`
---
## Fields

### `public docIconURL` → `String`


---
## Methods
### `public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds)`

search Searchs appraisals for the provided string (searchAppraisals)

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm string to match in appraisal fields|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return List of LookupSearchResults from appraisals|

### `public List<LookupSearchResult> customSearch(String searchTerm, Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> getCustomRecent(Map<Object,Object> options)`

Search override to allow custom settings

### `public List<LookupSearchResult> recentAppraisals(String dealId)`

recentAppraisals Returns appraisals related to the sales up on the deal, if none it will return recently viewed appraisals

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId deal to find related appraisals|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return List LookupSearchResults|

### `public override List<LookupSearchResult> getRecent()`

getRecent Returns recently viewed appraisals

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return List LookupSearchResults|

### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`

selectionId Fetches vehicle fields from a provided appraisal Id

#### Parameters

|Param|Description|
|---|---|
|`selectionId`|Appraisal to query|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return List<LookupSearchResult>|

### `private LookupSearchResult mapSearchResult(SObject o)`

mapSearchResult Handles converting the appraisal to present the title and subtitles for custom lookup component

#### Parameters

|Param|Description|
|---|---|
|`o`|Appraisal to map|

#### Returns

|Type|Description|
|---|---|
|`LookupSearchResult`|return lookupSearchResult to display in custom lookup LWC|

---
