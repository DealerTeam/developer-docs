---
layout: default
---
# partsMasterSearchController

Controller for the parts master search component


**Notes** 


**Test** //TODO


**Group** Parts

## Methods
### `public static List<Parts_Master__c> search(String term, Integer offSet, Boolean restrict, String dealId)`

`AURAENABLED`

search Performs a context aware search of the parts masters

#### Parameters

|Param|Description|
|---|---|
|`term`|term base search term|
|`offSet`|offSet used for filtering results|
|`restrict`|restrict restricts the values returned to only those that have fit guides matching the deal id|
|`dealId`|dealId Id of the Deal Record|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Master__c>`|List<Parts_Master__c> based on the search term and offset|

### `private static List<Parts_Master__c> handleSearch(String term, Integer offSet)`

returns a list of parts masters matching the search term and offset provided

#### Parameters

|Param|Description|
|---|---|
|`term`|search term that will be have * appended to it|
|`offSet`|offSet used for the query|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Master__c>`||

### `private static List<Parts_Master__c> handleRestrictedSearch(List<Parts_Master__c> masters, String dealId)`

filters a list of parts masters to only those with fit guides matching the deal id

#### Parameters

|Param|Description|
|---|---|
|`masters`|masters description|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Master__c>`|return description|


**Method** handleRestrictedSearch

---
