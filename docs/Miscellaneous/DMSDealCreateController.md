# DMSDealCreateController

`APIVERSION: 46`

`STATUS: ACTIVE`



**Class** DMSDealCreateController

## Methods
### `static create(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Return

**Type**

String

**Description**

String


**Method** create

### `static getDetails(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Return

**Type**

string

**Description**

string


**Method** getDetails

---
## Classes
### Details


#### Constructors
##### `Details(String supName, String customerName, String stockNumber, String company)`
---
#### Fields

##### `Company` → `String`


##### `CustomerName` → `String`


##### `StockNumber` → `String`


##### `SupName` → `String`


---

### Request


#### Constructors
##### `Request(Sales_Up__c salesUp, Vehicle_Inventory__c desiredVehicle, Account buyerAccount, Contact buyerContact, Account coBuyerAccount, Contact coBuyerContact, Dealer_Location__c location)`
---
#### Fields

##### `BuyerAccount` → `Account`


##### `BuyerContact` → `Contact`


##### `CoBuyerAccount` → `Account`


##### `CoBuyerContact` → `Contact`


##### `DesiredVehicle` → `Vehicle_Inventory__c`


##### `Location` → `Dealer_Location__c`


##### `SalesUp` → `Sales_Up__c`


---

### Response


#### Constructors
##### `Response(String url, String dealId, String error)`
---
#### Fields

##### `DealId` → `String`

`AURAENABLED` 

##### `Error` → `String`

`AURAENABLED` 

##### `Url` → `String`

`AURAENABLED` 

---

---
