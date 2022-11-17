# RentalAgreementControl

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Rental

## Methods
### `static saveFromScheduler(Rental_Agreements__c rental, String reservationId)`

`AURAENABLED`
### `static saveRental(Rental_Agreements__c rental)`

`AURAENABLED`
### `static saveDiscount(Rental_Agreements__c rental)`

`AURAENABLED`
### `static saveDiscountPercent(Rental_Agreements__c rental)`

`AURAENABLED`
### `static availableFields()`

`AURAENABLED`
### `static getVehicleImage(string vehId)`

`AURAENABLED`
### `static editableFields()`

`AURAENABLED`
### `static getFieldnames()`

`AURAENABLED`
### `static getAccounts(String accName)`

`AURAENABLED`
### `static getFieldLabels()`

`AURAENABLED`
### `static getAllCashering(String rentalId)`

`AURAENABLED`
### `static getPaymentMethods()`

`AURAENABLED`
### `static updateCashering(String rentalId, Cashering__c cashToUpdate)`

`AURAENABLED`
### `static deleteCashering(String rentalId, Cashering__c cash)`

`AURAENABLED`
### `static createCashering(dealer__Cashering__c cashToInsert)`

`AURAENABLED`
### `static picklistValues()`

`AURAENABLED`
### `static fuelLevelPickList()`
### `static licenseStatePicklist()`
### `static depositMethodPicklist()`
### `static paymentTypePicklist()`
### `static paymentMethodPicklist()`
### `static getFormNames(String rentalId)`

`AURAENABLED`
### `static getRentalSettings()`

`AURAENABLED`
### `static getDMSSettings()`

`AURAENABLED`
### `static getRentalFees(String rentalId)`

`AURAENABLED`
### `static deleteRentalFeeLine(String rentalId, Rental_Fee__c fee)`

`AURAENABLED`
### `static getLocationTaxes(String locId)`

`AURAENABLED`
### `static getUnit(Id rentalVehicle)`

`AURAENABLED`
### `static getMileage(Id raId)`

`AURAENABLED`
### `static getReservationEventData(String reservationId)`

`AURAENABLED`
### `static updateVehicle(dealer__Vehicle_Inventory__c vehicle)`

`AURAENABLED`
### `static getCustomer(Id contactId)`

`AURAENABLED`
### `static updateContact(Contact contact, Rental_Agreements__c rental)`

`AURAENABLED`
### `static getInventoryInfo(String vehicleId)`

`AURAENABLED`
### `static saveDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `static getRequiredFields()`

`AURAENABLED`
### `static getRentalAgreement(String raId)`

`AURAENABLED`
### `static getNewPrimaryDriver(String contactId)`

`AURAENABLED`
### `static getRentalVehicle(String vehId)`

`AURAENABLED`
### `static updateDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `static getDrivers(Id rentalId)`

`AURAENABLED`
### `static deleteDriver(String rentalId, Driver__c driver)`

`AURAENABLED`
### `static deleteDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `static getUserName()`

`AURAENABLED`
### `static createTask(boolean isRentalComplete, String rentalId)`

`AURAENABLED`
### `static userHasEncryptedData(Id userId)`

Return if user has View Encrypted Data permission.

#### Parameters

|Param|Description|
|---|---|
|`userId`|- userId to check if has encrypted data permission|

#### Return

**Type**

boolean

**Description**

boolean

### `static sanitizeEncryptedData(boolean hasEncryptedData, String stringToSanitize)`

Sanitize the string if the user does not have view encrypted data permission.

#### Parameters

|Param|Description|
|---|---|
|`hasEncryptedData`|- if the user has encrypted data permission|
|`stringToSanitize`|- the string to santitize before returning to client|
|`fieldType`|- this is the type of field to sanitize, only perform if encrypted string|

#### Return

**Type**

String

**Description**

: boolean

### `static searchVehicleInventory(String searchTerm)`

`AURAENABLED`
### `static getRecentVehicles()`

`AURAENABLED`
### `static searchRentalRate(String searchTerm)`

`AURAENABLED`
### `static getRecentRates()`

`AURAENABLED`
### `static searchLocation(String searchTerm)`

`AURAENABLED`
### `static getRecentLocations()`

`AURAENABLED`
### `static getUserLocation()`

`AURAENABLED`
### `static getUserLocationSearch()`

`AURAENABLED`
---
