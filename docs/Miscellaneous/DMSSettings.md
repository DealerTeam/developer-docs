---
layout: default
---
# DMSSettings

DMSSettings - controller to apply custom protected settings that determin how the product works.


**Notes** The properties in this class are referenced at package install time with the package install script.


**Test** Test_HelperClasses.cls

## Constructors
### `public DMSSettings()`

**Method** DMSSettings

---
## Fields

### `public dms` → `dealer__DMS_Settings__c`


---
## Properties

### `public barnumber` → `String`


### `public epanumber` → `String`


### `public corporate_website` → `String`


### `public corporate_facebook` → `String`


### `public defaultTaxRate` → `Decimal`


### `public partsInvoiceNumber` → `Decimal`


### `public partsQuoteNumber` → `Decimal`


### `public serviceInvoiceNumber` → `Decimal`


### `public laborRate` → `Decimal`


### `public warrantyLaborRate` → `Decimal`


### `public internalLaborRate` → `Decimal`


### `public printEstimate` → `boolean`


### `public printTechTimes` → `boolean`


### `public serviceTaxIfPartsSoldOnly` → `boolean`


### `public serviceTaxLabor` → `boolean`


### `public dmsIntegrationMode` → `boolean`


### `public serviceLineTotalTrigger` → `boolean`


### `public cashierAutoClose` → `boolean`


### `public leadsAutoAssignManager` → `boolean`


### `public closedDealStatusCodes` → `String`


### `public dmsName` → `String`


### `public dealNumber` → `Decimal`


### `public assignStockNumber` → `Boolean`


### `public assignStockNumberBySequence` → `Boolean`


### `public assignStockNumberBook` → `Boolean`


### `public assignStockNumberByDate` → `Boolean`


### `public assignStockNumberByCustomField` → `String`


### `public stocknumberindex` → `Decimal`


### `public stockLength` → `Decimal`


### `public serviceAppointmentNumber` → `Decimal`


### `public rentalMiles` → `Decimal`


### `public rentalFuelRate` → `Decimal`


### `public rentalMilesFee` → `Decimal`


### `public rentalReFuelFee` → `Decimal`


### `public deal_days` → `Double`


### `public deal_payments` → `Double`


### `public deal_rate` → `Double`


### `public deal_term` → `Double`


### `public deal_docfee` → `Double`


### `public status` → `String`


Status value to create RO - KVP

### `public askingPrice` → `decimal`


### `public auctionFee` → `decimal`


### `public certification` → `decimal`


### `public profitObjective` → `decimal`


### `public transportation` → `decimal`


### `public dealStatusForInv` → `String`


### `public salesupStatusForInv` → `String`


### `public roStatus` → `String`


### `public vehSearchDefaultStatus` → `String`


### `public dealCreatedDefaultStatus` → `String`


### `public inStockDefaultStatus` → `String`


### `public invStatusForSoldVehicle` → `String`


### `public inegratedFinancials` → `String`


### `public dealControlsSalesUp` → `boolean`


### `public fdfRenderer` → `String`


### `public linkedEvent` → `boolean`


### `public isDMSPopulate` → `boolean`


### `public isVDCPopulate` → `boolean`


### `public isCRMPopulate` → `boolean`


### `public isPaymentPopulate` → `boolean`


### `public isUpdateEquipment` → `boolean`


---
## Methods
### `public void installData()`
### `public PageReference save()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** save

---
