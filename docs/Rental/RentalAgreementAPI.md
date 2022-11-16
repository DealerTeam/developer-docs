# RentalAgreementAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Rental

## Constructors
### `RentalAgreementAPI()`
---
## Fields

### `taxableFeeMap` → `Map<Id,Decimal>`


### `taxableSubtotal` → `Decimal`


---
## Methods
### `static updateRentalAgreements(List<Rental_Agreements__c> rentalList)`
### `static getGrossTotal(Rental_Agreements__c ra, Rental_Rates__c rentalRate, Decimal accessoryRate, Decimal feeTotal)`
### `static getGrossTotal(Rental_Agreements__c ra)`
### `static setEstimatedTax(Rental_Agreements__c ra, Map<Id,Decimal> locationRateMap)`
### `static getDaysRented(Rental_Agreements__c ra, Decimal gracePeriodMinutes)`
### `static getDailyRateMap(Set<Id> rateIds)`
### `static getLocationRateMap(Set<Id> locIds)`
### `static getAccessoryDailyRateMap(Set<Id> accesoryIds)`
### `static getFeeMap(Set<Id> raIds)`
### `static getTaxableFeeMap(Set<Id> raIds)`
### `static getTimeOutMinutes(Rental_Agreements__c ra)`
### `static getTimeInMinutes(Rental_Agreements__c ra)`
### `static cashTransactions(String rentalId)`
---
