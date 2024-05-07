---
layout: default
---
# PaymentPDF_EXT

Date            |Developer            |Work#
Notes
--
2016.09.22       |Gaurav               |Case2069
Payment PDF for Cashier receipt
2016.11.30       |Sneha               |Case2069
Added fields of cashier's account for printing name, address of account
3/13/2019        |Josh                |W-002202
Added Ability to Get Location Information from cashering event even if it isn't attached to an SRO

## Constructors
### `public PaymentPDF_EXT(ApexPages controller)`
---
## Properties

### `public userLoc` → `dealer__Dealer_Location__c`


### `public objCashering` → `dealer__Cashering__c`


### `public invoiceTime` → `DateTime`


### `public objSRO` → `dealer__Service_Repair_Order__c`


### `public objPI` → `dealer__Parts_Invoice__c`


### `public objVehicleInventory` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `private void setUserLoc()`
### `public String getInvoiceLogo()`
### `public string getprintDateTime()`
---
## Classes
### PaymentPDFException

**Inheritance**

PaymentPDFException


---
