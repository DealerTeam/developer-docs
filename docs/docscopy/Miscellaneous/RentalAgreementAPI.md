---
layout: default
---
# RentalAgreementAPI class
---
## Constructors
### `RentalAgreementAPI()`
---
## Properties

### `taxableFeeMap` → `Map<Id,Decimal>`

### `taxableSubtotal` → `Decimal`

---
## Methods
### `cashTransactions(String rentalId)` → `>`
### `getAccessoryDailyRateMap(Set<Id> accesoryIds)` → `Map<Id,Decimal>`
### `getDailyRateMap(Set<Id> rateIds)` → `Map<Id,Rental_Rates__c>`
### `getDaysRented(Rental_Agreements__c ra, Decimal gracePeriodMinutes)` → `Integer`
### `getFeeMap(Set<Id> raIds)` → `Decimal>`
### `getGrossTotal(Rental_Agreements__c ra, Rental_Rates__c rentalRate, Decimal accessoryRate, Decimal feeTotal)` → `Decimal`
### `getGrossTotal(Rental_Agreements__c ra)` → `Decimal`
### `getLocationRateMap(Set<Id> locIds)` → `Map<Id,Decimal>`
### `getTaxableFeeMap(Set<Id> raIds)` → `Decimal>`
### `getTimeInMinutes(Rental_Agreements__c ra)` → `Integer`
### `getTimeOutMinutes(Rental_Agreements__c ra)` → `Integer`
### `setEstimatedTax(Rental_Agreements__c ra, Map<Id,Decimal>locationRateMap)` → `void`
### `updateRentalAgreements(List<Rental_Agreements__c> rentalList)` → `List<Rental_Agreements__c>`
---
