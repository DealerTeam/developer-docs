---
layout: default
---
# RentalAgreement_EXT



**Group** Rental

## Constructors
### `public RentalAgreement_EXT(ApexPages stdController)`
---
## Fields

### `public agreement` → `dealer__Rental_Agreements__c`


### `public dealDefaults` → `list<dealer__DMS_Settings__c>`


### `private stact` → `Task`


---
## Properties

### `public custAccount` → `Contact`


### `public rates` → `dealer__Rental_Rates__c`


### `public objDriverList` → `List<dealer__Driver__c>`


### `public objRADriverWrapperList` → `List<RADriverWrapperClass>`


### `public renderAddDriver` → `Boolean`


### `public renderSave` → `Boolean`


### `public discountValue` → `Decimal`


### `public discountPercentage` → `Decimal`


### `public SubTotal` → `Decimal`


### `public zeroString` → `String`


### `public objContact` → `Contact`


### `public loc` → `Dealer_Location__c`


### `public amountDue` → `Decimal`


### `public contractFormName` → `String`


### `public receiptFormName` → `String`


### `public symbol` → `String`


### `public defaultTaxRate` → `Decimal`


### `public dHomePhone` → `String`


### `public dMobilePhone` → `String`


### `public dEmail` → `String`


### `public baseURL` → `String`


---
## Methods
### `public List<dealer__Cashering__c> getCashiering()`
### `public List<Rental_Fee__c> getRentalFees()`
### `public PageReference save()`
### `public void addRow()`
### `public PageReference voidReasonSave()`
### `public dealer__Driver__c getDrivers()`
### `public PageReference completeRental()`
### `public PageReference changeStatusToVoid()`
### `public PageReference ModifyClosedRental()`
### `public PageReference PrintContract()`
### `public PageReference processReturn()`
### `public Contact getCustomer()`
### `public dealer__Vehicle_Inventory__c getUnit()`
### `public PageReference edit()`
### `public static Double inventoryMileage(String vehicleId)`

`REMOTEACTION`
### `public void addRowOnEdit()`
### `public void SaveOnEdit()`
### `public void populateDriverInfo()`
### `public void cancelDriver()`
### `public PageReference deleteDriver()`
---
## Classes
### RADriverWrapperClass
#### Constructors
##### `public RADriverWrapperClass(dealer__Driver__c objWrapperDriver)`
---
#### Properties

##### `public objWrapperDriver` → `dealer__Driver__c`


---

---
