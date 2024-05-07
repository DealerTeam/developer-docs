---
layout: default
---
# cashierPageController



**Class** cashierPageController

## Constructors
### `global cashierPageController(ApexPages sc)`
#### Parameters

|Param|Description|
|---|---|
|`sc`||


**Method** cashierPageController

---
## Properties

### `global cashierRecord` → `dealer__Cashering__c`


### `global logoUrl` → `String`


### `global location` → `Dealer_Location__c`


### `global customer` → `Account`


---
## Methods
### `global String getLogo()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getLogo

### `global List<Dealer_Location__c> queryLocation(Id locId)`
#### Parameters

|Param|Description|
|---|---|
|`locId`||

#### Returns

|Type|Description|
|---|---|
|`List<Dealer_Location__c>`|List<Dealer_Location__c>|


**Method** queryLocation

### `global List<Account> queryAccount(Id acctId)`
#### Parameters

|Param|Description|
|---|---|
|`acctId`||

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List<Account>|


**Method** queryAccount

---
