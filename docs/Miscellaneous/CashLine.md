# CashLine

`APIVERSION: 52`

`STATUS: ACTIVE`
## Constructors
### `CashLine(Cashering__c line)`
### `CashLine(Id cashId)`
---
## Fields

### `controlType` → `String`


### `legalOrganization` → `LegalOrganization__c`


### `line` → `Cashering__c`


### `location` → `Dealer_Location__c`


---
## Methods
### `static getCashLines(Set<Id> cashIds)`

returns list of Cashier Lines

#### Parameters

|Param|Description|
|---|---|
|`cashIds`|Set<Id>|

#### Return

**Type**

List&lt;Cashering__c&gt;

**Description**

List&lt;Cashering__c&gt;

---
