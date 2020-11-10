---
layout: default
---
# RentalAgreementControl class
---
## Methods
### `availableFields()` → `>`
### `createCashering(dealer__Cashering__c cashToInsert)` → `void`
### `createTask(boolean isRentalComplete, String rentalId)` → `void`
### `deleteCashering(String rentalId, Cashering__c cash)` → `List<Cashering__c>`
### `deleteDriver(String rentalId, Driver__c driver)` → `List<Driver__c>`
### `deleteDrivers(List < dealer__Driver__c > drivers)` → `String`
### `deleteRentalFeeLine(String rentalId, Rental_Fee__c fee)` → `List<Rental_Fee__c>`
### `depositMethodPicklist()` → `>`
### `editableFields()` → `>`
### `fuelLevelPickList()` → `>`
### `getAccounts(String accName)` → `>`
### `getAllCashering(String rentalId)` → `>`
### `getCustomer(Id contactId)` → `Contact`
### `getDMSSettings()` → `dealer__DMS_Settings__c`
### `getDrivers(Id rentalId)` → `>`
### `getFieldLabels()` → `>`
### `getFieldnames()` → `>`
### `getFormNames(String rentalId)` → `>`
### `getInventoryInfo(String vehicleId)` → `Vehicle_Inventory__c`
### `getLocationTaxes(String locId)` → `dealer__Dealer_Location__c`
### `getMileage(Id raId)` → `dealer__Vehicle_Inventory__c`
### `getNewPrimaryDriver(String contactId)` → `Contact`
### `getPaymentMethods()` → `List<String>`
### `getRecentLocations()` → `List<LookupSearchResult>`
### `getRecentRates()` → `List<LookupSearchResult>`
### `getRecentVehicles()` → `List<LookupSearchResult>`
### `getRentalAgreement(String raId)` → `dealer__Rental_Agreements__c`
### `getRentalFees(String rentalId)` → `List<Rental_Fee__c>`
### `getRentalSettings()` → `dealer__RentalSettings__c`
### `getRentalVehicle(String vehId)` → `Vehicle_Inventory__c`
### `getRequiredFields()` → `>`
### `getReservationEventData(String reservationId)` → `dealer__Rental_Schedule_Event__c`
### `getUnit(Id rentalVehicle)` → `dealer__Vehicle_Inventory__c`
### `getUserLocation()` → `dealer__Dealer_Location__c`
### `getUserLocationSearch()` → `List<LookupSearchResult>`
### `getUserName()` → `String`
### `getVehicleImage(string vehId)` → `String`
### `licenseStatePicklist()` → `>`
### `paymentMethodPicklist()` → `>`
### `paymentTypePicklist()` → `>`
### `picklistValues()` → `>>`
### `sanitizeEncryptedData(boolean hasEncryptedData, String stringToSanitize)` → `String`

 Description: Sanitize the string if the user does not have view encrypted data permission.

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  hasEncryptedData - if the user has encrypted data permission |
|`:` |  stringToSanitize - the string to santitize before returning to client |
|`:` |  fieldType - this is the type of field to sanitize, only perform if encrypted string |

### `saveDiscount(Rental_Agreements__c rental)` → `Rental_Agreements__c`
### `saveDiscountPercent(Rental_Agreements__c rental)` → `Rental_Agreements__c`
### `saveDrivers(List < dealer__Driver__c > drivers)` → `void`
### `saveFromScheduler(Rental_Agreements__c rental, String reservationId)` → `Rental_Agreements__c`
### `saveRental(Rental_Agreements__c rental)` → `Rental_Agreements__c`
### `searchLocation(String searchTerm)` → `List<LookupSearchResult>`
### `searchRentalRate(String searchTerm)` → `List<LookupSearchResult>`
### `searchVehicleInventory(String searchTerm)` → `List<LookupSearchResult>`

 RentalAgreementNew Methods

### `updateCashering(String rentalId, Cashering__c cashToUpdate)` → `List<Cashering__c>`
### `updateContact(Contact contact, Rental_Agreements__c rental )` → `Contact`
### `updateDrivers(List < dealer__Driver__c > drivers)` → `String`
### `updateVehicle(dealer__Vehicle_Inventory__c vehicle)` → `String`
### `userHasEncryptedData(Id userId)` → `boolean`

 Description: Return if user has View Encrypted Data permission.

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  userId - userId to check if has encrypted data permission |

---
