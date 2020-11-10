---
layout: default
---
# Sup2Deal class
---
## Constructors
### `Sup2Deal( ApexPages.StandardController stdController )`
---
## Properties

### `Conversion` → `Id`

### `SalesUpId` → `Id`

### `deal` → `Deal__c`

### `location` → `Dealer_Location__c`

### `vehicle` → `Vehicle_Inventory__c`

---
## Methods
### `buildDealFromSalesUp()` → `void`
### `dealPage()` → `pagereference`
### `populateB2BContactData(Sales_Up__c supRecord)` → `void`

Applies contact data to buyer fields for b2b deals

#### Parameters
|Param|Description|
|-----|-----------|
|`supRecord` |  supRecord description |

### `populateBuyerData(Id acctId)` → `void`
### `populateCoBuyerData(Id acctId)` → `void`
### `populateDealTaxLines()` → `void`

 This method provides the tax settings for the deal when the deal is created

### `populateTotals()` → `void`

calculates total and payment related fields upon initial deal creation from sales up

### `populateVehicle(String vehId)` → `void`
### `saveTradesData()` → `void`
### `updateAppraisal(List<Trade_In__c> TradeList)` → `void`
---
## Inner Classes

### Sup2Deal.mobException class
---
