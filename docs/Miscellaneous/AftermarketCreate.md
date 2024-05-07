---
layout: default
---
# AftermarketCreate

Helper class to hold logic around Aftermarket record processing

## Fields

### `private pricingStrat` → `Parts_Service_Pricing_Strategy__c`


### `private locObj` → `Dealer_Location__c`


### `private dealId` → `Id`


### `private chargeCodesByMaster` → `Map<Id,MiscChargeCode__c>`


---
## Methods
### `public List<After_Market__c> createAftermarketFromKit(Id pkId, Deal__c deal)`

Creates all aftermarket records for a single Parts Kit related to a deal

#### Parameters

|Param|Description|
|---|---|
|`pkId`|Parts Kit Id to create records|
|`deal`|Deal to associate the new records|

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|Newly created Aftermarket records|

### `private Map<Id,Parts_Inventory__c> getRelatedInventory(List<Parts_Kit_Item__c> pkis, Id locationId)`

Gets Parts Inventory related to a list of Kit Items and location, creates new Parts records if none exist

#### Parameters

|Param|Description|
|---|---|
|`pkis`|Parts Kit Items with Part Master references|
|`locationId`|Location where Parts Inventory records exist or will be created|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Parts_Inventory__c>`|Map of Parts Inventory for the location with key of Parts Master Id|

### `private Parts_Kit__c getPartsKitData(Id pkId)`

Query Parts Kits and all related data needed to build the Aftermarket Items and validate the data

#### Parameters

|Param|Description|
|---|---|
|`pkId`|Parts Kit Id used to query data|

#### Returns

|Type|Description|
|---|---|
|`Parts_Kit__c`|Parts Kit record with all related data included|

### `private Map<Id,Parts_Inventory__c> getMatrixPricing(List<Parts_Kit_Item__c> kitItems, Id locId)`

Iterates a list of kit items and returns a map of the Parts with matrix based pricing from PartAPI

#### Parameters

|Param|Description|
|---|---|
|`kitItems`|Parts Kit Items with Parts to generate pricing for|
|`locId`|Location used to find Parts Inventory|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Parts_Inventory__c>`|Map of Parts Inventory records with Matrix based pricing applied|

### `private After_Market__c createAftermarketFromHeader(Parts_Kit__c kit, String defaultRateType)`

Create an aftermarket record from a header level parts kit

#### Parameters

|Param|Description|
|---|---|
|`kit`|Non-Labor Parts Kit to create Aftermarket|
|`defaultRateType`|Rate Type to apply to the Aftermarket if none exist on the Kit|

#### Returns

|Type|Description|
|---|---|
|`After_Market__c`|Aftermarket record generated from the Parts Kit|

### `private After_Market__c createAftermarketLaborFromHeader(Parts_Kit__c kit, String type)`

Create an Aftermarket record from a Parts Kit of type Labor

#### Parameters

|Param|Description|
|---|---|
|`kit`|Labor type Parts Kit to create Aftermarket|

#### Returns

|Type|Description|
|---|---|
|`After_Market__c`|Aftermarket record generated from the Parts Kit|

### `private List<After_Market__c> createAftermarketFromKitItem(Parts_Kit_Item__c item, Decimal matrixPrice, Id partId)`

Generate a list of Aftermarket records from the Parts Kit Item

#### Parameters

|Param|Description|
|---|---|
|`item`|Kit Item used to create records|
|`matrixPrice`|Sale price based on matrix pricing can be supplied here to override value|
|`partId`|Id of the Parts Inventory derived from Parts Master on the Kit Item|

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|Aftermarket records generated from the Parts and Charge Masters|

### `private After_Market__c createAftermarketFromPartsMaster(Parts_Kit_Item__c item, Decimal matrixPrice, String rateType, Id partId)`

Returns an aftermarket record built from the Parts Master on a Parts Kit Item

#### Parameters

|Param|Description|
|---|---|
|`item`|Parts Kit Item with the Parts Master|
|`matrixPrice`|Sale price based on matrix pricing can be supplied here to override value|
|`rateType`|Rate Type to apply to the Aftermarket|
|`partId`|Id of the Parts Inventory derived from Parts Master on the Kit Item|

#### Returns

|Type|Description|
|---|---|
|`After_Market__c`|Aftermarket record generated from the Parts Master|

### `private After_Market__c createAftermarketFromMisc(Parts_Kit_Item__c item, String rateType)`

Returns an aftermarket record built from the Misc Charge Master on a Parts Kit Item

#### Parameters

|Param|Description|
|---|---|
|`item`|Parts Kit Item with the charge|
|`rateType`|Rate Type to apply to the Aftermarket|

#### Returns

|Type|Description|
|---|---|
|`After_Market__c`|Aftermarket record generated from the code|

### `private Map<Id,Parts_Inventory__c> populateMatrixData(Id pricingStrategyId, List<Parts_Kit_Item__c> pkis, Id locId)`

Query pricing strategy and get pricing data for parts if strategy uses matrix prcing

#### Parameters

|Param|Description|
|---|---|
|`pricingStrategyId`|Strategy to query from the deal|
|`pkis`|Parts Kit Items to apply matrix pricing|
|`locId`|Location to query local parts from|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Parts_Inventory__c>`|Map of Parts Inventory with matrix based pricing|

### `private void insertAftermarket(List<After_Market__c> records)`

Perform DML and Exception handling for Aftermarket creation

#### Parameters

|Param|Description|
|---|---|
|`records`|Aftermarket to be created|

### `private void getChargeCodes(List<Parts_Kit_Item__c> pkis)`

Populate the Misc Charge Code map, creating new codes from the related masters if needed

#### Parameters

|Param|Description|
|---|---|
|`pkis`|Parts Kit Items used to check for Misc Charge Masters|

### `private Decimal checkSaleValue(Decimal sale, Decimal base)`

Check for a non-zero value sale price, else return the base price

#### Parameters

|Param|Description|
|---|---|
|`sale`|Value to be check for non-null, non-zero|
|`base`|Value to return if sale is zero or null|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Sale price if a non-zero value exists otherwise base price|

---
