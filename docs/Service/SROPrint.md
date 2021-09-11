# SROPrint class

 SROPrint - controls the printing of Service Repair Orders. This file is used both by managed and non-managed code.

---
## Constructors
### `SROPrint(ApexPages.StandardController controller)`

 Controller
---
## Properties

### `Vehicle` → `global`

### `jLineIds` → `List<Id>`

### `loc` → `Id`

### `locInfo` → `Dealer_Location__c`

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

### `userLoc` → `Dealer_Location__c`

---
## Methods
### `getInvoiceLogo()` → `String`
### `getLinesList()` → `List<Service_Job__c>`

 Get Lines &quot;Loaded&quot; List Params: ro.Id

### `getMiscList()` → `List<Service_Misc_Charge__c>`

 Get Misc Lines Params: ro.Id

### `getServiceJobList()` → `List<Service_Job__c>`
### `getServicePartsList()` → `List<Parts_Invoice_Line__c>`
### `getlocInfo()` → `Dealer__Dealer_Location__c`
### `getuserLoc()` → `Dealer_Location__c`
---
