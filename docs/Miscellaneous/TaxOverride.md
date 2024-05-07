---
layout: default
---
# virtual TaxOverride

This class allows the extension of taxation routines


**Class** TaxOverride

## Methods
### `global virtual List<Tax_Zones__c> searchZones(String filter, Integer returnLimit, DealAPI deal)`
#### Parameters

|Param|Description|
|---|---|
|`String`|filter for search criteria|
|`Integer`|search results limit|
|`DealAPI`|.data structure|


**Method** searchZones

### `public virtual List<Tax_Zones__c> searchZones(String filter, Integer returnLimit, SObject record)`

Handles logic to determine tax address and returns matching tax zones

#### Parameters

|Param|Description|
|---|---|
|`filter`|filter description|
|`returnLimit`|returnLimit description|
|`record`|record description|

#### Returns

|Type|Description|
|---|---|
|`List<Tax_Zones__c>`|return description|


**Method** searchZones

### `private static TaxAPI getTaxAddress(Parts_Invoice__c invoice)`

Determines the tax address for Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`invoice`|invoice description|

#### Returns

|Type|Description|
|---|---|
|`TaxAPI`|return description|


**Method** getTaxAddress

### `private static TaxAPI getTaxAddress(Service_Repair_Order__c sro)`

Determines the tax address for a Service Repair Order

#### Parameters

|Param|Description|
|---|---|
|`sro`|sro description|

#### Returns

|Type|Description|
|---|---|
|`TaxAPI`|return description|


**Method** getTaxAddress

### `private List<Tax_Zones__c> queryZones(TaxAPI address, Integer returnLimit, String filter)`
### `private List<Tax_Zones__c> filterResults(List<Tax_Zones__c> applicableZones, TaxAPI taxAddress)`

handles matching logic to return the most accurate tax zones for a given address

#### Parameters

|Param|Description|
|---|---|
|`applicableZones`|applicableZones description|
|`taxAddress`|taxAddress description|

#### Returns

|Type|Description|
|---|---|
|`List<Tax_Zones__c>`|return description|


**Method** filterResults

### `global virtual List<Tax_Zones__c> searchZones(String filter, Integer returnLimit)`
#### Parameters

|Param|Description|
|---|---|
|`String`|filter for search criteria|
|`Integer`|search results limit|


**Method** searchZones

---
