# DealAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

DealAPI provides service layer logic for processing requests related to the Deal Records


**Group** Sales


**Author** DealerTeam

## Methods
### `static create(deal dealData)`

Creates a Deal using the Deal Data Structure.  This method will connect all sub-records such as Trade(s), Taxes, Service Contracts and After Market items.

#### Parameters

|Param|Description|
|---|---|
|`dealData`|DealAPI.deal|

#### Return

**Type**

Deal__c

**Description**

Deal__c

### `static closeDeals(List<Deal__c> deals)`

This routine will close deals and mark associated records as closed/won

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Return

**Type**

void

**Description**

Void

### `static closeDealProcess(List<Deal__c> deals)`

`INVOCABLEMETHOD`

Processes the closure of a Deal Record.  This method is invocable and can optionally be included in custom process builder flows.

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Return

**Type**

void

**Description**

Void

### `static createAfterMarketItems(Id pkId, Deal__c deal)`

Creates After Market items on the deal from a conversion on the sales up

#### Parameters

|Param|Description|
|---|---|
|`pkId`|Id|
|`deal`|Deal__c|

#### Return

**Type**

void

**Description**

Void

### `static dealData(Id dealId)`

Retrieves Data relavent to a deal. Used mostly for deal forms.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

Deal

**Description**

DealAPI.Deal

### `static createDefaultFees(List<Deal__c> deals)`

Creates Fees to be defaulted on a deal

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Return

**Type**

void

**Description**

Void

### `static saveDeal(String dealId)`

Saves and calculates deal

#### Parameters

|Param|Description|
|---|---|
|`String`|dealId|

#### Return

**Type**

Deal__c

**Description**

Deal__c

### `static saveDeal(Deal__c deal)`

Saves and calculates deal Assumes all fields on Deal__c were queried prior to entry.

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Return

**Type**

Deal__c

**Description**

Deal__c

---
## Classes
### Deal

Wrapper class for deal data and related records.

#### Constructors
##### `Deal()`
---
#### Properties

##### `Payor1` → `Account`


##### `Payor2` → `Account`


##### `Payor3` → `Account`


##### `TotalAllowance` → `Decimal`


##### `TotalTradeGross` → `Decimal`


##### `TradeTaxCredit` → `Decimal`


##### `VehRetail` → `Decimal`


##### `afterMarketItems` → `List&lt;After_Market__c&gt;`


##### `buyer` → `Account`


##### `cashierItems` → `List&lt;Cashering__c&gt;`


##### `cobuyer` → `Account`


##### `dealFees` → `List&lt;Sales_Fee__c&gt;`


##### `dealForms` → `List&lt;Deal_Form__c&gt;`


##### `dealHeader` → `Deal__c`


##### `equipmentNonTaxable` → `List&lt;After_Market__c&gt;`


##### `equipmentTaxable` → `List&lt;After_Market__c&gt;`


##### `location` → `Dealer_Location__c`


##### `logoURL` → `String`


##### `nonTaxableFees` → `List&lt;Sales_Fee__c&gt;`


##### `rebates` → `List&lt;Discount_Rebate__c&gt;`


##### `salesup` → `Sales_Up__c`


##### `serviceContractItems` → `List&lt;Service_Contract__c&gt;`


##### `serviceContractTotal` → `Decimal`


##### `serviceVehicle` → `Service_Vehicle__C`


##### `taxableFees` → `List&lt;Sales_Fee__c&gt;`


##### `tradeIns` → `List&lt;Trade_In__c&gt;`


##### `vehicle` → `Vehicle_Inventory__c`


---

### DealAPIException

Exception interface for DealAPI


**Inheritance**

DealAPIException


---
