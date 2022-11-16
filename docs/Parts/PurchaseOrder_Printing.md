# PurchaseOrder_Printing

`APIVERSION: 45`

`STATUS: ACTIVE`

Add new fields Carrier, VIN/Serial, RO Reference#, Shipping Method, Tracking#


**Group** Parts

## Constructors
### `PurchaseOrder_Printing(ApexPages.standardController controller)`

Queries purchase order from current page id then calls prepareOrderLinesForPrinting

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Test** PartOrderingServiceLayer.testPOPrinting

---
## Properties

### `DMSDefaults` → `dealer__DMS_Settings__c`


### `dlr` → `dealer__Dealer_Location__c`


### `pageBrokenOrderLines` → `List<dealer__Purchase_Order_Line__c[]>`


### `po` → `dealer__Purchase_Order__c`


### `poLines` → `dealer__Purchase_Order_Line__c[]`


### `printDateTime` → `string`


Provides current data & time as a string

---
## Methods
### `getInvoiceLogo()`

Gets the logo url based on location

#### Return

**Type**

String

**Description**

string with logo url


**Test** PartOrderingServiceLayer.testPOPrinting

### `prepareOrderLinesForPrinting()`

Lists PO Lines for printing


**Test** PartOrderingServiceLayer.testPOPrinting

---
