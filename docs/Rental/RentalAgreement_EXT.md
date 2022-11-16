# RentalAgreement_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Rental

## Constructors
### `RentalAgreement_EXT(ApexPages.StandardController stdController)`
---
## Fields

### `agreement` → `dealer__Rental_Agreements__c`


### `dealDefaults` → `list<dealer__DMS_Settings__c>`


---
## Properties

### `SubTotal` → `Decimal`


### `amountDue` → `Decimal`


### `baseURL` → `String`


### `contractFormName` → `String`


### `custAccount` → `Contact`


### `dEmail` → `String`


### `dHomePhone` → `String`


### `dMobilePhone` → `String`


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
### `getCashiering()`
### `getRentalFees()`
### `save()`
### `addRow()`
### `voidReasonSave()`
### `getDrivers()`
### `completeRental()`
### `changeStatusToVoid()`
### `ModifyClosedRental()`
### `PrintContract()`
### `processReturn()`
### `getCustomer()`
### `getUnit()`
### `edit()`
### `static inventoryMileage(String vehicleId)`

`REMOTEACTION`
### `addRowOnEdit()`
### `SaveOnEdit()`
### `populateDriverInfo()`
### `cancelDriver()`
### `deleteDriver()`
---
## Classes
### RADriverWrapperClass
#### Constructors
##### `RADriverWrapperClass(dealer__Driver__c objWrapperDriver)`
---
#### Properties

##### `objWrapperDriver` → `dealer__Driver__c`


---

---
