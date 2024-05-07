---
layout: default
---
# PurchaseOrder_Printing

Add new fields Carrier, VIN/Serial, RO Reference#, Shipping Method, Tracking#


**Group** Parts

## Constructors
### `public PurchaseOrder_Printing(ApexPages controller)`

Queries purchase order from current page id then calls prepareOrderLinesForPrinting

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Test** PartOrderingServiceLayer.testPOPrinting

---
## Fields

### `private DESC_SIZE` → `Integer`


### `public purchaseOrderLineWrapper` → `List<PurchaseOrderLineWrapper>`


---
## Properties

### `public poLines` → `dealer__Purchase_Order_Line__c`


### `public po` → `dealer__Purchase_Order__c`


### `public pr` → `List<dealer__Purchase_Order_Receiving__c>`


### `public purchaseLineList` → `List<PurchaseOrderLineWrapper>`


### `public prline` → `List<dealer__Purchase_Order_Receiving_Line__c>`


### `public receivedEventLine` → `List<dealer__Purchase_Order_Receiving_Line__c>`


### `public currencyCode` → `String`


### `public partTotal` → `Decimal`


### `public miscTotal` → `Decimal`


### `public serialNumber` → `String`


### `public printedByName` → `String`


### `public DMSDefaults` → `dealer__DMS_Settings__c`


### `public dlr` → `dealer__Dealer_Location__c`


### `public printDateTime` → `string`


Provides current data & time as a string

---
## Methods
### `public void initializePurchaseOrderLines(List<dealer__Purchase_Order_Line__c> pLines)`
### `public Map<Id,String> getSerialNumber(List<dealer__Purchase_Order_Line__c> poLines)`

This method retrieves the serial numbers associated with dealer purchase order line items. It takes a list of dealer__Purchase_Order_Line__c objects as input and returns a Map with the * dealer__Part__c ID as the key and the corresponding dealer__SerialNumber__c as the value.

#### Parameters

|Param|Description|
|---|---|
|`poList`|a list of dealer__Purchase_Order_Line__c objects for which serial numbers need to be retrieved|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,String>`|a Map<Id, String> containing the serial numbers mapped to the dealer__Part__c ID|

### `public String getInvoiceLogo()`

Gets the logo url based on location

#### Returns

|Type|Description|
|---|---|
|`String`|string with logo url|


**Test** PartOrderingServiceLayer.testPOPrinting

---
## Classes
### PurchaseOrderLineWrapper
#### Properties

##### `public partQuantity` → `Decimal`


##### `public partName` → `String`


##### `public partDescription` → `String`


##### `public partCost` → `Decimal`


##### `public partAmount` → `Decimal`


##### `public serialNumber` → `String`


##### `public firstLine` → `String`


##### `public secondLine` → `String`


##### `public specialInstructions` → `String`


---

---
