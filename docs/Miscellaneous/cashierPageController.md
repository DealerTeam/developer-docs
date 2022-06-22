# cashierPageController

`APIVERSION: 45`

`STATUS: ACTIVE`

**Class** cashierPageController

## Constructors
### `cashierPageController(ApexPages.standardController sc)`
#### Parameters

|Param|Description|
|---|---|
|`sc`||


**Method** cashierPageController

---
## Properties

### `cashierRecord` → `dealer__Cashering__c`


### `customer` → `Account`


### `location` → `Dealer_Location__c`


### `logoUrl` → `String`


---
## Methods
### `getLogo()`
#### Return

**Type**

String

**Description**

String


**Method** getLogo

### `queryLocation(Id locId)`
#### Parameters

|Param|Description|
|---|---|
|`locId`||

#### Return

**Type**

List&lt;Dealer_Location__c&gt;

**Description**

List&lt;Dealer_Location__c&gt;


**Method** queryLocation

### `queryAccount(Id acctId)`
#### Parameters

|Param|Description|
|---|---|
|`acctId`||

#### Return

**Type**

List&lt;Account&gt;

**Description**

List&lt;Account&gt;


**Method** queryAccount

---
