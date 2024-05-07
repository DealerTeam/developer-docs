---
layout: default
---
# RentalAgreementAPI



**Group** Rental

## Constructors
### `public RentalAgreementAPI()`
---
## Fields

### `public taxableSubtotal` → `Decimal`


### `public taxableFeeMap` → `Map<Id,Decimal>`


---
## Methods
### `public static List<Rental_Agreements__c> updateRentalAgreements(List<Rental_Agreements__c> rentalList)`
### `public static Decimal getGrossTotal(Rental_Agreements__c ra, Rental_Rates__c rentalRate, Decimal accessoryRate, Decimal feeTotal)`
### `public static Decimal getGrossTotal(Rental_Agreements__c ra)`
### `public static void setEstimatedTax(Rental_Agreements__c ra, Map<Id,Decimal> locationRateMap)`
### `public static Integer getDaysRented(Rental_Agreements__c ra, Decimal gracePeriodMinutes)`
### `public static Map<Id,Rental_Rates__c> getDailyRateMap(Set<Id> rateIds)`
### `public static Map<Id,Decimal> getLocationRateMap(Set<Id> locIds)`
### `public static Map<Id,Decimal> getAccessoryDailyRateMap(Set<Id> accesoryIds)`
### `public static Map<Id,Decimal> getFeeMap(Set<Id> raIds)`
### `public static Map<Id,Decimal> getTaxableFeeMap(Set<Id> raIds)`
### `public static Integer getTimeOutMinutes(Rental_Agreements__c ra)`
### `public static Integer getTimeInMinutes(Rental_Agreements__c ra)`
### `public static List<Cashering__c> cashTransactions(String rentalId)`
### `public static void postRental(String rentalId)`

postRental description

#### Parameters

|Param|Description|
|---|---|
|`rentalId`|rentalId description|

---
## Classes
### RentalAgreementAPIException

**Inheritance**

RentalAgreementAPIException


---
