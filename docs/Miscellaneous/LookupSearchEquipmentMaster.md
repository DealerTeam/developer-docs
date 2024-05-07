---
layout: default
---
# LookupSearchEquipmentMaster

**Inheritance**

[LookupSearch](./LookupSearch.md)
 &gt; 
LookupSearchEquipmentMaster

## Constructors
### `public LookupSearchEquipmentMaster()`
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
### `public List<LookupSearchResult> getSelectionByEquipmentId(Id equipmentId)`

getSelectionByEquipmentId obtains the equipment__c record by ID

#### Parameters

|Param|Description|
|---|---|
|`equipmentId`|RecordId|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|Equipment__c|

### `public override List<LookupSearchResult> geSelectionById(Id selectionId)`
### `private LookupSearchResult mapSearchResult(SObject o)`
---
