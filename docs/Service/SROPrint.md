# SROPrint

`APIVERSION: 45`

`STATUS: ACTIVE`

SROPrint - controls the printing of Service Repair Orders.               This file is used both by managed and non-managed code.


**Group** Service

## Constructors
### `SROPrint(ApexPages.StandardController controller)`

Controller

---
## Fields

### `jLineIds` → `List<Id>`

`DEPRECATED` 

### `locInfo` → `Dealer_Location__c`


### `userLoc` → `Dealer_Location__c`


---
## Properties

### `Vehicle` → `Vehicle_Inventory__c`


### `loc` → `Id`


### `payment_details` → `List<Cashering__c>`


### `printDateTime` → `string`


### `ro` → `Service_Repair_Order__c`


### `total_freight` → `Decimal`


### `total_freight_w` → `Decimal`


### `total_hazmat` → `Decimal`


### `total_hazmat_w` → `Decimal`


### `total_payments` → `Decimal`


### `total_shop` → `Decimal`


### `total_shop_w` → `Decimal`


### `total_sublet` → `Decimal`


### `total_sublet_cust` → `Decimal`


### `total_sublet_w` → `Decimal`


---
## Methods
### `getuserLoc()`
### `getlocInfo()`
### `getInvoiceLogo()`
### `getServiceJobList()`
### `getServicePartsList()`
### `getMiscList()`

Get Misc Lines

### `getLinesList()`

Get Lines "Loaded" List

---
