---
layout: default
---
# RentalAgreementSelector
## Constructors
### `public RentalAgreementSelector(Boolean enforce)`

Constructor to allow setting security boolean

#### Parameters

|Param|Description|
|---|---|
|`enforce`|enforce description|


**Method** ServiceRepairOrderSelector

### `public RentalAgreementSelector()`

Default Constructor


**Method** ServiceRepairOrderSelector

---
## Fields

### `public enforceSecurity` → `Boolean`


---
## Methods
### `public static List<RentalAgreement> data(Set<Id> rentalIds)`

Returns list&lt;ServiceRepairOrder&gt; for multiple records.

#### Parameters

|Param|Description|
|---|---|
|`rentalIds`||

### `public Map<Id,sObject> recordsByRental(List<Rental_Agreements__c> rentals, String relatedFieldName)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,sObject>`|Map<Id,sObject>|

### `private static Map<Id,List<Cashering__c>> buildCashierMap(Set<Id> rentalIds)`

helper method builds map of cashier per SRO Id.

#### Parameters

|Param|Description|
|---|---|
|`rentalIds`||

### `public List<Cashering__c> getPayLines(Set<Id> rentalIds)`

returns paylines

#### Parameters

|Param|Description|
|---|---|
|`sroId`||

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`||


**Method** getpaylines

---
