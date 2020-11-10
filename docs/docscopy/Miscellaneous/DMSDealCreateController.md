---
layout: default
---
# DMSDealCreateController class

@description

---
## Methods
### `create(String recordId)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getDetails(String recordId)` → `string`

 getDetails

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

---
## Inner Classes

### DMSDealCreateController.Details class

@description

---
#### Constructors
##### `Details(String supName, String customerName, String stockNumber, String company)`
---
#### Properties

##### `Company` → `String`

##### `CustomerName` → `String`

##### `StockNumber` → `String`

##### `SupName` → `String`

---
### DMSDealCreateController.Request class

@description

---
#### Constructors
##### `Request(Sales_Up__c salesUp, Vehicle_Inventory__c desiredVehicle, Account buyerAccount, Contact buyerContact, Account coBuyerAccount, Contact coBuyerContact, Dealer_Location__c location)`
---
#### Properties

##### `BuyerAccount` → `Account`

##### `BuyerContact` → `Contact`

##### `CoBuyerAccount` → `Account`

##### `CoBuyerContact` → `Contact`

##### `DesiredVehicle` → `Vehicle_Inventory__c`

##### `Location` → `Dealer_`

##### `SalesUp` → `Sales_Up__c`

---
### DMSDealCreateController.Response class

@description

---
#### Constructors
##### `Response(String url, String dealId, String error)`
---
#### Properties

##### `DealId` → `String`

##### `Error` → `String`

##### `Url` → `String`

---
