---
layout: default
---
# DealCalculations
## Methods
### `public static Deal__c setDealTotals(Deal__c deal)`

Calculates Totals and updates a Deal record, Assumes all managed fields on the Deal object are available in this call.

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `public static void setVehicleTotals(Deal__c deal, Deal__c existingDeal, RebateWrapper rebates)`

Sets Totals for Vehicle and Conversion on the Deal, Taxable and Non Taxable

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|
|`existingDeal`|Deal from Database|

### `public static void setEquipmentTotals(Deal__c deal, Deal__c existingDeal)`

setEquipmentTotals Updates equipment inventory cost on a deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|deal to update|

### `public static void setDiscountTotal(Deal__c deal, Map<String,Discount_Rebate__c> typemap)`

setDiscountTotal Totals discount rebates where type does not contain rebate

### `public static void setAfterMarketTotals(Deal__c deal, List<After_Market__c> subRecords)`

Calculates After Market totals on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setFeeTotal(Deal__c deal, List<Sales_Fee__c> subRecords)`

Calculates Fee totals on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setServiceContractTotal(Deal__c deal, Deal__c existingDeal, List<Service_Contract__c> subRecords)`

Calculates Service Contract totals on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|
|`existingDeal`|Deal from database|

### `public static void setMFGRebateTotal(Deal__c deal, RebateWrapper rebates)`

Calculates Rebate totals on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setTaxTotal(Deal__c deal)`

Calculates Deal Tax

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setTradeTotals(Deal__c deal, List<Trade_In__c> subRecords)`

Calculates Trade In totals on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setDeferredDown(Deal__c deal)`

Calculates Total Deferred Down Payment on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `public static void setCashDown(Deal__c deal, Deal__c existingDeal)`

Calculates Total Deferred Down Payment on a Deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

### `private static void cleanDealFields(Deal__c deal)`

Sets Null fields to 0 for final calculation

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

---
## Classes
### RebateWrapper
#### Constructors
##### `public RebateWrapper(Deal__c deal)`
---
#### Fields

##### `public vehicleRebates` → `List&lt;Rebate&gt;`


##### `public conversionRebates` → `List&lt;Rebate&gt;`


##### `public equipmentRebates` → `List&lt;Rebate&gt;`


##### `public total` → `Decimal`


---

### Rebate
#### Constructors
##### `public Rebate(String type, Decimal amount, Boolean taxable)`
---
#### Fields

##### `public type` → `String`


##### `public amount` → `Decimal`


##### `public taxable` → `Boolean`


---

---
