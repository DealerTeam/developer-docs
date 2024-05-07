---
layout: default
---
# AfterMarketControlHandler

Created 11-22-2016 by Abhishek Goel W-000710. Added updateTaxFields method to update Sales Tax value.


**Group** Sales

## Constructors
### `public AfterMarketControlHandler()`
---
## Methods
### `public static void updateTaxFields(List<After_Market__c> TriggerNewList)`
### `public static void updateSaleValues(List<After_Market__c> TriggerNewList)`

Ensure the Sale_Price and Cost values are set

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateSaleValues

### `public static void setPartsSource(List<After_Market__c> triggerNew)`

Set the part source based on the location default source related to the Part on the Aftermarket record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public static void deleteKitItems(List<After_Market__c> triggerOld)`

When an After Market 'Header' record is deleted, delete associated lines.


**Method** deleteKitItems

### `public static void updateKitHeader(List<After_Market__c> triggerNew, Map<Id,After_Market__c> triggerOldMap)`

Update List Price of Aftermarket records serving as the Parts Kit header record when a 'child' ext price is changed

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

### `public static void createWeOwe(List<After_Market__c> TriggerNewList)`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createWeOwe

### `public static void deleteTaxTransactionItems(List<After_Market__c> triggerList)`

Deletes any referenced tax transaction items based on the lit of aftermarkets passed.

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** deleteTaxTransactionItems

---
