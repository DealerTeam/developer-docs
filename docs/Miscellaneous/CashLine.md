---
layout: default
---
# CashLine
## Constructors
### `public CashLine(Cashering__c line)`
### `public CashLine(Id cashId)`
---
## Fields

### `public controlType` → `String`


### `public location` → `Dealer_Location__c`


### `public legalOrganization` → `LegalOrganization__c`


### `public line` → `Cashering__c`


---
## Methods
### `private static Cashering__c getCashLine(Id cashId)`
### `public static List<Cashering__c> getCashLines(Set<Id> cashIds)`

returns list of Cashier Lines

#### Parameters

|Param|Description|
|---|---|
|`cashIds`|Set<Id>|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|List<Cashering__c>|

---
