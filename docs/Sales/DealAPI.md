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

### `static createFromSalesUp(deal dealData)`
### `static generateFromSalesUp(Deal dealData)`
### `static populateVehicle(Deal__c deal, Id vehId)`
### `static populateEquipmentInventory(Deal__c deal, Id eqInvId)`
### `static populateBuyerData(Deal__c deal, Id acctId)`
### `static populateCoBuyerData(Deal__c deal, Id acctId)`
### `static saveTradesData(Deal dealData)`
### `static updateAppraisal(Deal__c deal, List<Trade_In__c> TradeList)`
### `static cloneDeal(Id dealId)`

Clones a Deal Record

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Return

**Type**

String

**Description**

Deal__c

### `static getDealRecord(Id dealId)`

Returns a list of Deal Records based on DealID

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Return

**Type**

List&lt;dealer__Deal__c&gt;

**Description**

List &lt; dealer__Deal__c &gt;

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

### `static dealData(Set<Id> dealIds)`

Returns list&lt;Deal&gt; for multiple records.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `recordsByDeal(List<Deal__c> deals, String relatedFieldName, Set<String> relatedFields)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Return

**Type**

Map&lt;Id,sObject&gt;

**Description**

Map&lt;Id,sObject&gt;

### `recordsByDeal(List<Deal__c> deals, String relatedFieldName)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Return

**Type**

Map&lt;Id,sObject&gt;

**Description**

Map&lt;Id,sObject&gt;

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

### `static dealLocation(Id dealId)`

Retrieves Deal's Dealer Location information

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

Dealer_Location__c

**Description**

Dealer_Location__c

### `static getDealFees(Id dealId)`

Acquires Fee Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

List&lt;Sales_Fee__c&gt;

**Description**

List&lt;Sales_fee__c&gt;

### `static getDealDiscounts(Id dealId)`

Get Discounts Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

List&lt;Discount_Rebate__c&gt;

**Description**

List&lt;Discount_Rebate__c&gt;

### `static getDealRebates(Id dealId)`

Get Rebate Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

List&lt;Discount_Rebate__c&gt;

**Description**

List&lt;Discount_Rebate__c&gt;

### `static getDiscountTemplates()`

Returns discount templates for available for Deals

#### Return

**Type**

List&lt;Discount_Rebate__c&gt;

**Description**

List&lt;Discount_Rebate__c&gt;

### `static applyDiscounts(Deal__c deal)`

Applies Discount logic to a deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Return

**Type**

void

**Description**

Deal__c

### `static getTradeIns(Id dealId)`

Queries all Trades related to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

List&lt;Trade_In__c&gt;

**Description**

List&lt;Trade_In__c&gt;

### `static dealHeader(Id dealId)`

Acquires all header-level data for a Deal

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Return

**Type**

Deal__c

**Description**

Deal__c

### `static createPartAfterMarket(Id dealId, PartAddition partData)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`partData`|DealAPI.partData|

#### Return

**Type**

void

**Description**

Void


**Descriptoin** Creates an Aftermarket record from a part TODO MOVE TO PARTAPI

### `static addDealForms(Id dealId, List<String> formIds, Boolean justPrinted)`

Adds Forms to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formIds`|List<String>|
|`justPrinted`|Boolean|

#### Return

**Type**

void

**Description**

Void

### `static addDealForms(Id dealId, list<String> formIds)`

Adds Forms to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formIds`|List<String>|

#### Return

**Type**

void

**Description**

Void

### `static removeDealForm(Id dealId, Id formId)`

Removes a Form from a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formId`|Id|

#### Return

**Type**

void

**Description**

Void

### `static availableForms(String dealId)`

Acquires forms available to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

List&lt;Form__c&gt;

### `static locationForms(List<Form__c> allForms, String dealId)`

filters forms according to availableForms with the additional requirement that they be related to the location

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|
|`allForms`|List of all forms acquired from availableForms()|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

return description


**Method** locationForms

### `static selectedForms(String dealId)`

Obtain the selected forms on a deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String Id of deal|

#### Return

**Type**

List&lt;Deal_Form__c&gt;

**Description**

List&lt;Form__c&gt; forms related to the deal


**Method** selectedForms

### `static applicableForms(String dealId)`

Retrieves forms Applicable to a deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

List&lt;Form__c&gt;

### `static cashTransactions(String dealId)`

Retrieves Cash Transaction Items on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Return

**Type**

List&lt;Cashering__c&gt;

**Description**

List&lt;Cashering__c&gt;

### `static formRefQuery(Deal__c deal, String printType)`

Builds query for Deal-Applicable form references

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|
|`printType`|FDF, Laser|

#### Return

**Type**

String

**Description**

String

### `static assignStockToTrade(List<Trade_In__c> trades)`
### `static assignDealAddressFromBuyer(Deal__c deal, Account buyerAccount)`

assignDealAddressFromBuyer assigns deal buyer data from an account record

#### Parameters

|Param|Description|
|---|---|
|`deal`|- deal record to map buyer data to|
|`buyerAccount`|- buyer record to retrieve data from|

#### Return

**Type**

Deal__c

**Description**

return - updated deal record

### `static assignDealCoBuyerAddress(Deal__c deal, Account coBuyerAccount)`

assignDealCoBuyerAddress assigns deal co buyer data from an account record

#### Parameters

|Param|Description|
|---|---|
|`deal`|- deal record to map co buyer data to|
|`coBuyerAccount`|- co buyer record to retrieve data from|

#### Return

**Type**

Deal__c

**Description**

return - updated deal record

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


### PartAddition

Wrapper class to add a part After Market Item to Deal

#### Properties

##### `Cost` → `Decimal`

`AURAENABLED` 

##### `Description` → `String`

`AURAENABLED` 

##### `Discount` → `Decimal`

`AURAENABLED` 

##### `PartsMasterId` → `String`

`AURAENABLED` 

##### `Printable` → `Boolean`

`AURAENABLED` 

##### `Quantity` → `Decimal`

`AURAENABLED` 

##### `RateType` → `String`

`AURAENABLED` 

##### `SalePrice` → `Decimal`

`AURAENABLED` 

##### `Taxable` → `Boolean`

`AURAENABLED` 

---

---
