# cashierPageController

`APIVERSION: 45`

`STATUS: ACTIVE`

**Class** cashierPageController

## Constructors

### `cashierPageController(ApexPages.standardController sc)`

#### Parameters

| Param | Description |
| ----- | ----------- |
| `sc`  |             |

**Method** cashierPageController

***

## Properties

### `cashierRecord` → `dealer__Cashering__c`

### `customer` → `Account`

### `location` → `Dealer_Location__c`

### `logoUrl` → `String`

***

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

| Param   | Description |
| ------- | ----------- |
| `locId` |             |

#### Return

**Type**

List\<Dealer\_Location\_\_c>

**Description**

List\<Dealer\_Location\_\_c>

**Method** queryLocation

### `queryAccount(Id acctId)`

#### Parameters

| Param    | Description |
| -------- | ----------- |
| `acctId` |             |

#### Return

**Type**

List\<Account>

**Description**

List\<Account>

**Method** queryAccount

***
