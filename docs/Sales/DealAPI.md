---
layout: default
---
# DealAPI

DealAPI provides service layer logic for processing requests related to the Deal Records


**Group** Sales


**Author** DealerTeam

## Methods
### `global static Deal__c create(deal dealData)`

Creates a Deal using the Deal Data Structure.  This method will connect all sub-records such as Trade(s), Taxes, Service Contracts and After Market items.

#### Parameters

|Param|Description|
|---|---|
|`dealData`|DealAPI.deal|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `public static Deal__c createFromSalesUp(deal dealData)`
### `public static Deal generateFromSalesUp(Deal dealData)`
### `public static void populateVehicle(Deal__c deal, Id vehId)`
### `public static void unwindDealVehicles(String dealNumber)`

Unwinds a deal by setting the deal's vehicle inventory record to in stock and deleting any trade-in vehicles

#### Parameters

|Param|Description|
|---|---|
|`dealNumber`|String|

### `public static void populateEquipmentInventory(Deal__c deal, Id eqInvId)`
### `public static void populateBuyerData(Deal__c deal, Id acctId)`
### `public static void populateCoBuyerData(Deal__c deal, Id acctId)`
### `public static void saveTradesData(Deal dealData)`
### `public static void updateAppraisal(Deal__c deal, List<Trade_In__c> TradeList)`
### `public static String cloneDeal(Id dealId)`

Clones a Deal Record

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Returns

|Type|Description|
|---|---|
|`String`|Deal__c|

### `public static List<dealer__Deal__c> getDealRecord(Id dealId)`

Returns a list of Deal Records based on DealID

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Deal__c>`|List < dealer__Deal__c >|

### `global static void closeDeals(List<Deal__c> deals)`

This routine will close deals and mark associated records as closed/won

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `global static void closeDealProcess(List<Deal__c> deals)`

`INVOCABLEMETHOD`

Processes the closure of a Deal Record.  This method is invocable and can optionally be included in custom process builder flows.

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `global static void createAfterMarketItems(Id pkId, Deal__c deal)`

Creates After Market items on the deal from a parts kit Id

#### Parameters

|Param|Description|
|---|---|
|`pkId`|Id|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `global static Deal dealData(Id dealId)`

Retrieves Data relavent to a deal. Used mostly for deal forms.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Deal`|DealAPI.Deal|

### `public static List<Deal> dealData(Set<Id> dealIds)`

Returns list&lt;Deal&gt; for multiple records.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `public Map<Id,sObject> recordsByDeal(List<Deal__c> deals, String relatedFieldName, Set<String> relatedFields)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,sObject>`|Map<Id,sObject>|

### `public Map<Id,sObject> recordsByDeal(List<Deal__c> deals, String relatedFieldName)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,sObject>`|Map<Id,sObject>|

### `private Map<Id,List<After_Market__c>> buildAfterMarketMap(Set<Id> dealIds)`

helper method builds map of aftermerkets per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Service_Contract__c>> buildServiceContractMap(Set<Id> dealIds)`

helper method builds map of service contracts per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<CostAdjustment__c>> buildCostAdjustmentMap(Set<Id> dealIds)`

helper method builds map of Cost Adjustments per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<TaxTransactionItem__c>> buildTaxTransactionItemMap(Set<Id> dealIds)`

helper method builds map of Tax Transaction Items per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Deal_Form__c>> buildFormMap(Set<Id> dealIds)`

helper method builds map of deal forms  per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Trade_In__c>> buildTradeInMap(Set<Id> dealIds)`

helper method builds map of trade ins per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Sales_Fee__c>> buildFeeMap(Set<Id> dealIds)`

helper method builds map of Fees per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Discount_Rebate__c>> buildRebateMap(Set<Id> dealIds)`

helper method builds map of rebates per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private Map<Id,List<Cashering__c>> buildCashierMap(Set<Id> dealIds)`

helper method builds map of cashier itmes per deal Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `private List<After_Market__c> taxableAfterMarkets(List<After_Market__c> afterMarkets, boolean taxable)`

returns aftermarkets where taxable__c == taxable parameter

#### Parameters

|Param|Description|
|---|---|
|`afterMarkets`|List<After_Market__c>|
|`taxable`|Boolean|

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|List<After_Market__c>|

### `global static void createDefaultFees(List<Deal__c> deals)`

Creates Fees to be defaulted on a deal

#### Parameters

|Param|Description|
|---|---|
|`deals`|List<Deal__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `global static Deal__c saveDeal(String dealId)`

Saves and calculates deal

#### Parameters

|Param|Description|
|---|---|
|`String`|dealId|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `global static Deal__c saveDeal(Deal__c deal)`

Saves and calculates deal Assumes all fields on Deal__c were queried prior to entry.

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `public static Dealer_Location__c dealLocation(Id dealId)`

Retrieves Deal's Dealer Location information

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|

### `public static List<Sales_Fee__c> getDealFees(Id dealId)`

Acquires Fee Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`List<Sales_Fee__c>`|List<Sales_fee__c>|

### `public static List<Discount_Rebate__c> getDealDiscounts(Id dealId)`

Get Discounts Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public static List<Discount_Rebate__c> getDealRebates(Id dealId)`

Get Rebate Records on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public static List<Discount_Rebate__c> getDiscountTemplates()`

Returns discount templates for available for Deals

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public static void applyDiscounts(Deal__c deal)`

Applies Discount logic to a deal

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`void`|Deal__c|

### `public static List<Trade_In__c> getTradeIns(Id dealId)`

Queries all Trades related to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`List<Trade_In__c>`|List<Trade_In__c>|

### `public static Deal__c dealHeader(Id dealId)`

Acquires all header-level data for a Deal

#### Parameters

|Param|Description|
|---|---|
|`Id`|dealId|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `public static void createPartAfterMarket(Id dealId, PartAddition partData)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`partData`|DealAPI.partData|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|


**Descriptoin** Creates an Aftermarket record from a part TODO MOVE TO PARTAPI

### `public static void addDealForms(Id dealId, List<String> formIds, Boolean justPrinted)`

Adds Forms to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formIds`|List<String>|
|`justPrinted`|Boolean|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static void addDealForms(Id dealId, list<String> formIds)`

Adds Forms to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formIds`|List<String>|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static void removeDealForm(Id dealId, Id formId)`

Removes a Form from a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`formId`|Id|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static List<Form__c> availableForms(String dealId)`

Acquires forms available to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|List<Form__c>|

### `public static List<Form__c> locationForms(List<Form__c> allForms, String dealId)`

filters forms according to availableForms with the additional requirement that they be related to the location

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|
|`allForms`|List of all forms acquired from availableForms()|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|return description|


**Method** locationForms

### `public static List<Deal_Form__c> selectedForms(String dealId)`

Obtain the selected forms on a deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String Id of deal|

#### Returns

|Type|Description|
|---|---|
|`List<Deal_Form__c>`|List<Form__c> forms related to the deal|


**Method** selectedForms

### `public static List<Form__c> applicableForms(String dealId)`

Retrieves forms Applicable to a deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|List<Form__c>|

### `public static List<Cashering__c> cashTransactions(String dealId)`

Retrieves Cash Transaction Items on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|List<Cashering__c>|

### `public static String formRefQuery(Deal__c deal, String printType)`

Builds query for Deal-Applicable form references

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|
|`printType`|FDF, Laser|

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static List<Trade_In__c> assignStockToTrade(List<Trade_In__c> trades)`
### `private static Decimal getServiceContractTotal(List<Service_Contract__c> contracts)`

getServiceContractTotal

#### Parameters

|Param|Description|
|---|---|
|`contracts`|List<Service_Contracts__c>|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|

### `private static String getLogo(Id dealId, Id locId)`

Retrieves Logo URL TODO Deprecate

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`locId`|Id|

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `private List<Sales_Fee__c> getTaxableFees(List<Sales_Fee__c> fees, Boolean taxable)`

Retrieves list of Taxable Fees on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|
|`fees`|List<Sales_Fee__c>|

#### Returns

|Type|Description|
|---|---|
|`List<Sales_Fee__c>`|List<Sales_Fee__c|

### `private static Decimal getTotalAllowance(List<Trade_In__c> tradeInList)`

Returns Total Allowance

#### Parameters

|Param|Description|
|---|---|
|`tradeInList`|List<Trade_In__c>|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|

### `private static Decimal getTotalTradeGross(List<Trade_In__c> tradeInList)`

Returns Total Trade Gross

#### Parameters

|Param|Description|
|---|---|
|`tradeInList`|List<Trade_In__c>|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|

### `private Decimal calcTradeTaxCredit(Deal__c d)`

Returns Trade Tax Credit Amount

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|

### `private Decimal getVehRetail(Deal__c deal)`

Returns Retail Vehicle Price of Vehicle TODO MOVE LOGIC TO VEHICLE API

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|

### `private static Account getPayor1(Id dealId)`

Returns Account for Payor 1

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `private static Account getPayor2(Id dealId)`

getPayor2

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `private static Account getPayor3(Id dealId)`

getPayor3

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `public static Deal__c assignDealAddressFromBuyer(Deal__c deal, Account buyerAccount)`

assignDealAddressFromBuyer assigns deal buyer data from an account record

#### Parameters

|Param|Description|
|---|---|
|`deal`|- deal record to map buyer data to|
|`buyerAccount`|- buyer record to retrieve data from|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|return - updated deal record|

### `public static Deal__c assignDealCoBuyerAddress(Deal__c deal, Account coBuyerAccount)`

assignDealCoBuyerAddress assigns deal co buyer data from an account record

#### Parameters

|Param|Description|
|---|---|
|`deal`|- deal record to map co buyer data to|
|`coBuyerAccount`|- co buyer record to retrieve data from|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|return - updated deal record|

---
## Classes
### Deal

Wrapper class for deal data and related records.

#### Constructors
##### `global Deal()`
---
#### Properties

##### `global dealHeader` → `Deal__c`


##### `global salesup` → `Sales_Up__c`


##### `global buyer` → `Account`


##### `global cobuyer` → `Account`


##### `global Payor1` → `Account`


##### `global Payor2` → `Account`


##### `global Payor3` → `Account`


##### `global location` → `Dealer_Location__c`


##### `global serviceVehicle` → `Service_Vehicle__C`


##### `global vehicle` → `Vehicle_Inventory__c`


##### `global afterMarketItems` → `List&lt;After_Market__c&gt;`


##### `global serviceContractItems` → `List&lt;Service_Contract__c&gt;`


##### `global dealForms` → `List&lt;Deal_Form__c&gt;`


##### `global tradeIns` → `List&lt;Trade_In__c&gt;`


##### `global dealFees` → `List&lt;Sales_Fee__c&gt;`


##### `global rebates` → `List&lt;Discount_Rebate__c&gt;`


##### `global cashierItems` → `List&lt;Cashering__c&gt;`


##### `global taxableFees` → `List&lt;Sales_Fee__c&gt;`


##### `global nonTaxableFees` → `List&lt;Sales_Fee__c&gt;`


##### `global equipmentTaxable` → `List&lt;After_Market__c&gt;`


##### `global equipmentNonTaxable` → `List&lt;After_Market__c&gt;`


##### `global costAdjustmentLines` → `List&lt;CostAdjustment__c&gt;`


##### `global taxTransactionItems` → `List&lt;TaxTransactionItem__c&gt;`


##### `global serviceContractTotal` → `Decimal`


##### `global TotalAllowance` → `Decimal`


##### `global TotalTradeGross` → `Decimal`


##### `global TradeTaxCredit` → `Decimal`


##### `global VehRetail` → `Decimal`


##### `global logoURL` → `String`


---

### PartAddition

Wrapper class to add a part After Market Item to Deal

#### Properties

##### `public PartsMasterId` → `String`

`AURAENABLED` 

##### `public Quantity` → `Decimal`

`AURAENABLED` 

##### `public Description` → `String`

`AURAENABLED` 

##### `public SalePrice` → `Decimal`

`AURAENABLED` 

##### `public Cost` → `Decimal`

`AURAENABLED` 

##### `public RateType` → `String`

`AURAENABLED` 

##### `public Printable` → `Boolean`

`AURAENABLED` 

##### `public Taxable` → `Boolean`

`AURAENABLED` 

##### `public Discount` → `Decimal`

`AURAENABLED` 

---

### DealAPIException

Exception interface for DealAPI


**Inheritance**

DealAPIException


---
