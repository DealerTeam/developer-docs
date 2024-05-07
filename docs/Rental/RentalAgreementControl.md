---
layout: default
---
# RentalAgreementControl

RentalAgreementControl - Controller for Rental Agreement Lightning Component


**Group** Rental


**Notes** Used by the Aura Component for Rentals


**Test** 

## Fields

### `private hasEncryptData` → `boolean`


---
## Methods
### `public static Rental_Agreements__c saveFromScheduler(Rental_Agreements__c rental, String reservationId)`

`AURAENABLED`
### `public static Rental_Agreements__c saveRental(Rental_Agreements__c rental)`

`AURAENABLED`

saveRental process the Rental Agreement and is executed when fields are edited.  (OnBlur)

#### Parameters

|Param|Description|
|---|---|
|`rental`|Rental_Agreements__c sObject|

#### Returns

|Type|Description|
|---|---|
|`Rental_Agreements__c`|Rental_Agreements__c    Updated rental agreement|

### `public static Rental_Agreements__c saveDiscount(Rental_Agreements__c rental)`

`AURAENABLED`
### `public static Rental_Agreements__c saveDiscountPercent(Rental_Agreements__c rental)`

`AURAENABLED`
### `public static Map<String,String> availableFields()`

`AURAENABLED`
### `public static List<LookupSearchResult> getAccountSelectionFromContact(Id ContactId)`

`AURAENABLED`

getAccountFromContact - returns the primary account for a given contact

#### Parameters

|Param|Description|
|---|---|
|`ContactId`|- the Contact to retrieve a related Account from|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return - the AccountId from the contact|

### `public static Id getContactFromAccount(Id AccountId)`

`AURAENABLED`

getContactFromAccount - returns the proper contact for a given account

#### Parameters

|Param|Description|
|---|---|
|`AccountId`|- the account to retrieve a related contact from|

#### Returns

|Type|Description|
|---|---|
|`Id`|return - the Id will be a person contact, a business contact if one and only one exists, or null|

### `public static List<LookupSearchResult> getAccountSelection(Id AccountId)`

`AURAENABLED`

getContactFromAccount - returns the proper contact for a given account

#### Parameters

|Param|Description|
|---|---|
|`AccountId`|- the account to retrieve a related contact from|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return - the Id will be a person contact, a business contact if one and only one exists, or null|

### `public static String getVehicleImage(string vehId)`

`AURAENABLED`
### `public static Map<String,String> editableFields()`

`AURAENABLED`
### `public static List<String> getFieldnames()`

`AURAENABLED`
### `public static List<Account> getAccounts(String accName)`

`AURAENABLED`
### `public static Map<String,String> getFieldLabels()`

`AURAENABLED`
### `public static List<dealer__Cashering__c> getAllCashering(String rentalId)`

`AURAENABLED`
### `public static List<String> getPaymentMethods()`

`AURAENABLED`
### `public static List<Cashering__c> updateCashering(String rentalId, Cashering__c cashToUpdate)`

`AURAENABLED`
### `public static List<Cashering__c> deleteCashering(String rentalId, Cashering__c cash)`

`AURAENABLED`
### `public static void createCashering(dealer__Cashering__c cashToInsert)`

`AURAENABLED`
### `public static List<List<String>> picklistValues()`

`AURAENABLED`
### `public static List<String> fuelLevelPickList()`
### `public static List<String> licenseStatePicklist()`
### `public static List<String> depositMethodPicklist()`
### `public static List<String> paymentTypePicklist()`
### `public static List<String> paymentMethodPicklist()`
### `public static List<String> getFormNames(String rentalId)`

`AURAENABLED`
### `public static dealer__RentalSettings__c getRentalSettings()`

`AURAENABLED`
### `public static void postRental(String rentalId)`

`AURAENABLED`
### `public static dealer__DMS_Settings__c getDMSSettings()`

`AURAENABLED`
### `public static List<Rental_Fee__c> getRentalFees(String rentalId)`

`AURAENABLED`
### `public static List<Rental_Fee__c> deleteRentalFeeLine(String rentalId, Rental_Fee__c fee)`

`AURAENABLED`
### `public static dealer__Dealer_Location__c getLocationTaxes(String locId)`

`AURAENABLED`
### `public static dealer__Vehicle_Inventory__c getUnit(Id rentalVehicle)`

`AURAENABLED`
### `public static Vehicle_Inventory__c getMileage(Id raId)`

`AURAENABLED`
### `public static dealer__Rental_Schedule_Event__c getReservationEventData(String reservationId)`

`AURAENABLED`
### `public static String updateVehicle(dealer__Vehicle_Inventory__c vehicle)`

`AURAENABLED`
### `public static Contact getCustomer(Id contactId)`

`AURAENABLED`
### `public static Contact updateContact(Contact contact, Rental_Agreements__c rental)`

`AURAENABLED`
### `public static Vehicle_Inventory__c getInventoryInfo(String vehicleId)`

`AURAENABLED`
### `public static void saveDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `public static Map<String,Boolean> getRequiredFields()`

`AURAENABLED`

getRequiredFields - returns a map of required fields for the Rental Agreement object

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|return Map<String, Boolean> - map of field names and required status|

### `public static Rental_Agreements__c getRentalAgreement(String raId)`

`AURAENABLED`

getRentalAgreement - returns a rental agreement record with all related fields

#### Parameters

|Param|Description|
|---|---|
|`raId`|String Rental Agreement ID|

#### Returns

|Type|Description|
|---|---|
|`Rental_Agreements__c`|Rental_Agreements__c|

### `public static Contact getNewPrimaryDriver(String contactId)`

`AURAENABLED`

getNewPrimaryDriver Returns the Contact Record for the Primary Driver.  There can be additional drivers, however this Contact is associated as the primary at the header of the Rental_Agrement__c record.

#### Parameters

|Param|Description|
|---|---|
|`contactId`|String Contact Id|

#### Returns

|Type|Description|
|---|---|
|`Contact`|return Contact|

### `public static Vehicle_Inventory__c getRentalVehicle(String vehId)`

`AURAENABLED`
### `public static String updateDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `public static List<Driver__c> getDrivers(Id rentalId)`

`AURAENABLED`
### `public static List<Driver__c> deleteDriver(String rentalId, Driver__c driver)`

`AURAENABLED`
### `public static String deleteDrivers(List<dealer__Driver__c> drivers)`

`AURAENABLED`
### `public static String getUserName()`

`AURAENABLED`
### `public static void createTask(boolean isRentalComplete, String rentalId)`

`AURAENABLED`
### `public static boolean userHasEncryptedData(Id userId)`

Return if user has View Encrypted Data permission.

#### Parameters

|Param|Description|
|---|---|
|`userId`|- userId to check if has encrypted data permission|

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|

### `public static String sanitizeEncryptedData(boolean hasEncryptedData, String stringToSanitize)`

Sanitize the string if the user does not have view encrypted data permission.

#### Parameters

|Param|Description|
|---|---|
|`hasEncryptedData`|- if the user has encrypted data permission|
|`stringToSanitize`|- the string to santitize before returning to client|
|`fieldType`|- this is the type of field to sanitize, only perform if encrypted string|

#### Returns

|Type|Description|
|---|---|
|`String`|: boolean|

### `public static List<LookupSearchResult> searchVehicleInventory(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> getRecentVehicles()`

`AURAENABLED`
### `public static List<LookupSearchResult> searchRentalRate(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> getRecentRates()`

`AURAENABLED`
### `public static List<LookupSearchResult> searchLocation(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> getRecentLocations()`

`AURAENABLED`
### `public static dealer__Dealer_Location__c getUserLocation()`

`AURAENABLED`
### `public static List<LookupSearchResult> getUserLocationSearch()`

`AURAENABLED`
---
