---
layout: default
---
# SROPrint

SROPrint - controls the printing of Service Repair Orders.
              This file is used both by managed and non-managed code.


**Group** Service

## Constructors
### `global SROPrint(ApexPages controller)`

Controller

---
## Fields

### `global userLoc` → `Dealer_Location__c`


### `global locInfo` → `Dealer_Location__c`


### `global jLineIds` → `List<Id>`

`DEPRECATED` 

---
## Properties

### `global ro` → `Service_Repair_Order__c`


### `global Vehicle` → `Vehicle_Inventory__c`


### `global loc` → `Id`


### `global currencyCode` → `String`


### `global total_hazmat` → `Decimal`


### `global total_shop` → `Decimal`


### `global total_freight` → `Decimal`


### `global total_sublet` → `Decimal`


### `global total_sublet_w` → `Decimal`


### `global total_sublet_cust` → `Decimal`


### `global total_hazmat_w` → `Decimal`


### `global total_shop_w` → `Decimal`


### `global total_freight_w` → `Decimal`


### `global total_payments` → `Decimal`


### `global payment_details` → `List<Cashering__c>`


### `global printDateTime` → `string`


---
## Methods
### `global Dealer_Location__c getuserLoc()`
### `global Dealer__Dealer_Location__c getlocInfo()`
### `global String getInvoiceLogo()`
### `global List<Service_Job__c> getServiceJobList()`
### `global List<Parts_Invoice_Line__c> getServicePartsList()`
### `global List<Service_Misc_Charge__c> getMiscList()`

Get Misc Lines

### `global List<Service_Job__c> getLinesList()`

Get Lines "Loaded" List

---
