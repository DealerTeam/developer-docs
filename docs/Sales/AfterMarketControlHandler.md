# AfterMarketControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Created 11-22-2016 by Abhishek Goel W-000710. Added updateTaxFields method to update Sales Tax value.


**Group** Sales

## Constructors
### `AfterMarketControlHandler()`
---
## Methods
### `static updateTaxFields(List<After_Market__c> TriggerNewList)`
### `static updateSaleValues(List<After_Market__c> TriggerNewList)`

Ensure the Sale_Price and Cost values are set

#### Return

**Type**

void

**Description**

void


**Method** updateSaleValues

### `static setPartsSource(List<After_Market__c> triggerNew)`

Set the part source based on the location default source related to the Part on the Aftermarket record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `static deleteKitItems(List<After_Market__c> triggerOld)`

When an After Market 'Header' record is deleted, delete associated lines.


**Method** deleteKitItems

### `static createWeOwe(List<After_Market__c> TriggerNewList)`
#### Return

**Type**

void

**Description**

void


**Method** createWeOwe

### `static deleteTaxTransactionItems(List<After_Market__c> triggerList)`

Deletes any referenced tax transaction items based on the lit of aftermarkets passed.

#### Return

**Type**

void

**Description**

void


**Method** deleteTaxTransactionItems

---
