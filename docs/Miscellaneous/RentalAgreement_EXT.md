---
layout: default
---
# RentalAgreement_EXT class
---
## Constructors
### `RentalAgreement_EXT(ApexPages.StandardController stdController)`
---
## Properties

### `SubTotal` → `Decimal`

### `agreement` → `dealer__Rental_Agreements__c`

### `amountDue` → `Decimal`

### `baseURL` → `String`

### `contractFormName` → `String`

### `custAccount` → `Contact`

### `dEmail` → `String`

### `dHomePhone` → `String`

### `dMobilePhone` → `String`

### `dealDefaults` → `list<dealer__DMS_Settings__c>`

### `defaultTaxRate` → `Decimal`

### `discountPercentage` → `Decimal`

### `discountValue` → `Decimal`

### `loc` → `Dealer_Location__c`

### `objContact` → `Contact`

### `objDriverList` → `List<dealer__Driver__c>`

### `objRADriverWrapperList` → `List<RADriverWrapperClass>`

### `rates` → `dealer__Rental_Rates__c`

### `receiptFormName` → `String`

### `renderAddDriver` → `Boolean`

### `renderSave` → `Boolean`

### `zeroString` → `String`

---
## Methods
### `ModifyClosedRental()` → `PageReference`
### `PrintContract()` → `PageReference`
### `SaveOnEdit()` → `void`
### `addRow()` → `void`
### `addRowOnEdit()` → `void`
### `cancelDriver()` → `void`
### `changeStatusToVoid()` → `PageReference`
### `completeRental()` → `PageReference`
### `deleteDriver()` → `PageReference`
### `edit()` → `PageReference`
### `getCashiering()` → `List<dealer__Cashering__c>`
### `getCustomer()` → `Contact`
### `getDrivers()` → `dealer__Driver__c`
### `getRentalFees()` → `List<Rental_Fee__c>`
### `getUnit()` → `dealer__Vehicle_Inventory__c`
### `inventoryMileage(String vehicleId)` → `Double`
### `populateDriverInfo()` → `void`
### `processReturn()` → `PageReference`
### `save()` → `PageReference`
### `voidReasonSave()` → `PageReference`
---
## Inner Classes

### RentalAgreement_EXT.RADriverWrapperClass class
---
#### Constructors
##### `RADriverWrapperClass(dealer__Driver__c objWrapperDriver)`
---
#### Properties

##### `objWrapperDriver` → `dealer__Driver__c`

---
