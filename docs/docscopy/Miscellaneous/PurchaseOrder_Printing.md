---
layout: default
---
# PurchaseOrder_Printing class

 2016.08.31       |Gaurav               |Case# 2019 Add new fields Carrier, VIN/Serial, RO Reference#, Shipping Method, Tracking#

---
## Constructors
### `PurchaseOrder_Printing(ApexPages.standardController controller)`

 Queries purchase order from current page id then calls prepareOrderLinesForPrinting
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `DMSDefaults` → `dealer__DMS_Settings__c`

### `dlr` → `dealer__Dealer_Location__c`

### `pageBrokenOrderLines` → `List<dealer__Purchase_Order_Line__c[]>`

### `po` → `dealer__Purchase_Order__c`

### `poLines` → `dealer__Purchase_Order_Line__c[]`

### `printDateTime` → `string`

 Provides current data & time as a string @returns string with current date & time @test PartOrderingServiceLayer.testPOPrinting

---
## Methods
### `getInvoiceLogo()` → `String`

 Gets the logo url based on location

### `prepareOrderLinesForPrinting()` → `void`

 Lists PO Lines for printing @test PartOrderingServiceLayer.testPOPrinting

---
