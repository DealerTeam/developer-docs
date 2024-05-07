---
layout: default
---
# DMSDealCreateController



**Class** DMSDealCreateController

## Methods
### `public static String create(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** create

### `public static string getDetails(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getDetails

### `private static Sales_Up__c querySalesup(String supId)`
---
## Classes
### Response


#### Constructors
##### `public Response(String url, String dealId, String error)`
---
#### Fields

##### `public Url` → `String`

`AURAENABLED` 

##### `public DealId` → `String`

`AURAENABLED` 

##### `public Error` → `String`

`AURAENABLED` 

---

### Details


#### Constructors
##### `public Details(String supName, String customerName, String stockNumber, String company)`
---
#### Fields

##### `public SupName` → `String`


##### `public CustomerName` → `String`


##### `public StockNumber` → `String`


##### `public Company` → `String`


---

### Request


#### Constructors
##### `public Request(Sales_Up__c salesUp, Vehicle_Inventory__c desiredVehicle, Account buyerAccount, Contact buyerContact, Account coBuyerAccount, Contact coBuyerContact, Dealer_Location__c location)`
---
#### Fields

##### `public SalesUp` → `Sales_Up__c`


##### `public DesiredVehicle` → `Vehicle_Inventory__c`


##### `public BuyerAccount` → `Account`


##### `public BuyerContact` → `Contact`


##### `public CoBuyerAccount` → `Account`


##### `public CoBuyerContact` → `Contact`


##### `public Location` → `Dealer_Location__c`


---

---
