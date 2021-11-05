# DealAPI class

DealAPI provides service layer logic for processing requests related to the Deal Records

---
## Methods
### `closeDealProcess(List<Deal__c> deals)` → `void`

Processes the closure of a Deal Record.  This method is invocable and can optionally be included in custom process builder flows.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`deals` |  List&lt;Deal__c&gt; |

#### Return

**Type**

void

**Description**

Void

### `closeDeals(List<Deal__c> deals)` → `void`

This routine will close deals and mark associated records as closed/won

#### Parameters

| Param | Description |
| ----- | ----------- |
|`Id` |  dealId |
|`Id` |  dealId |
|`deals` |  List&lt;Deal__c&gt; |

#### Return

**Type**

void

**Description**

Void

### `create(deal dealData)` → `Deal__c`

Creates a Deal using the Deal Data Structure.  This method will connect all sub-records such as Trade(s), Taxes, Service Contracts and After Market items.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dealData` |  DealAPI.deal |

#### Return

**Type**

Deal__c

**Description**

Deal__c

### `createAfterMarketItems(Id pkId, Deal__c deal)` → `void`

Creates After Market items on the deal from a conversion on the sales up

#### Parameters

| Param | Description |
| ----- | ----------- |
|`pkId` |  Id |
|`deal` |  Deal__c |

#### Return

**Type**

void

**Description**

Void

### `createDefaultFees(List<Deal__c> deals)` → `void`

Creates Fees to be defaulted on a deal

#### Parameters

| Param | Description |
| ----- | ----------- |
|`deals` |  List&lt;Deal__c&gt; |

#### Return

**Type**

void

**Description**

Void

### `dealData(Id dealId)` → `Deal`

Retrieves Data relavent to a deal. Used mostly for deal forms.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`dealId` |  Id |

#### Return

**Type**

Deal

**Description**

DealAPI.Deal

### `saveDeal(String dealId)` → `Deal__c`

Saves and calculates deal

#### Parameters

| Param | Description |
| ----- | ----------- |
|`String` |  dealId |

#### Return

**Type**

Deal__c

**Description**

Deal__c

### `saveDeal(Deal__c deal)` → `Deal__c`

Saves and calculates deal Assumes all fields on Deal__c were queried prior to entry.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`deal` |  Deal__c |

#### Return

**Type**

Deal__c

**Description**

Deal__c

---
## Inner Classes

### DealAPI.Deal class

Wrapper class for deal data and related records.

---
#### Properties

##### `Payor1` → `Account`

##### `Payor2` → `Account`

##### `Payor3` → `Account`

##### `TotalAllowance` → `Decimal`

##### `TotalTradeGross` → `Decimal`

##### `TradeTaxCredit` → `Decimal`

##### `VehRetail` → `Decimal`

##### `afterMarketItems` → `List<After_Market__c>`

##### `buyer` → `Account`

##### `cashierItems` → `List<Cashering__c>`

##### `cobuyer` → `Account`

##### `dealFees` → `List<Sales_Fee__c>`

##### `dealForms` → `List<Deal_Form__c>`

##### `dealHeader` → `Deal__c`

##### `equipmentNonTaxable` → `List<After_Market__c>`

##### `equipmentTaxable` → `List<After_Market__c>`

##### `location` → `Dealer_Location__c`

##### `logoURL` → `String`

##### `nonTaxableFees` → `List<Sales_Fee__c>`

##### `rebates` → `List<Discount_Rebate__c>`

##### `salesup` → `Sales_Up__c`

##### `serviceContractItems` → `List<Service_Contract__c>`

##### `serviceContractTotal` → `Decimal`

##### `serviceVehicle` → `Service_Vehicle__C`

##### `taxableFees` → `List<Sales_Fee__c>`

##### `tradeIns` → `List<Trade_In__c>`

##### `vehicle` → `Vehicle_Inventory__c`

---
#### Methods
##### `deal()` → `global`
---
### DealAPI.DealAPIException class

Exception interface for DealAPI

---
