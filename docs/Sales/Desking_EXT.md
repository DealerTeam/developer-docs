# Desking_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** Desking Controller


**Group** Sales

## Constructors
### `Desking_EXT(ApexPages.StandardController stdController)`
---
## Fields

### `buyer` → `Contact`


### `cobuyer` → `Contact`


### `dealDefaults` → `list<dealer__DMS_Settings__c>`


### `dealFormObject` → `dealer__Deal__c`


### `dealStatus` → `Map<String,dealer__Deal_Status_Map_Setting__c>`


### `dealTitle` → `String`


### `lender` → `String`


### `vinToTradeMap` → `Map<String,dealer__Trade_In__c>`


---
## Properties

### `aftermarket` → `String`


### `avaialbleContracts` → `List<dealer__Service_Contract__c>`


### `baseURL` → `String`


### `baseURLNonManaged` → `String`


### `config` → `dealer__SalesDeskLogSettings__c`


### `deal` → `dealer__Deal__c`


### `dealPayments` → `List<dealer__Deal_Payment__c>`


### `deleteProductId` → `String`


### `dmsDealStatus` → `String`


### `escCode` → `String`


### `escDescription` → `String`


### `escResults` → `List<dealer__Service_Contract__c>`


### `escSelectedId` → `String`


### `escType` → `String`


### `feedata` → `String`


### `formId` → `String`


### `forms` → `List<dealer__Form__c>`


### `gapRollupValue` → `Double`


### `inventoryVehicleList` → `list<dealer__Vehicle_Inventory__c>`


### `isGAPPrem` → `Boolean`


### `isMainPrem` → `Boolean`


### `isOtherPrem` → `Boolean`


### `iswarrPrem` → `Boolean`


### `jsonDataToInsert` → `String`


### `kitDescription` → `String`


### `kitList` → `List<dealer__Parts_Kit__c>`


### `kitMFG` → `String`


### `kitNumber` → `String`


### `kitResultSize` → `String`


### `listFormWrap` → `List<FormsWrapper>`


### `selectedContractType` → `String`


### `selectedPartNumber` → `String`


### `seletedTabId` → `String`


### `soldOnProposal` → `List<dealer__Service_Contract__c>`


### `td1` → `dealer__Sales_up__c`


### `td2` → `dealer__Sales_up__c`


### `td3` → `dealer__Sales_up__c`


### `tradeInJSON` → `String`


### `tradeInJSONData` → `String`


### `trades` → `String`


### `vehicle` → `dealer__Vehicle_Inventory__c`


### `vehicleInventory` → `dealer__Vehicle_Inventory__c`


### `weOwe` → `dealer__We_Owe__c`


---
## Methods
### `getFinanceCompanies()`
### `getLender()`
### `setLender(String lender)`
### `static notLostTradeIn(String dealId)`

`REMOTEACTION`
### `createInventory()`
### `fetchSVFromDeal()`
### `fetchInVehFromDeal()`
### `fetchInventoryVehicle()`
### `mergeAndPrint()`
### `getdealTitle()`
### `getTaxZoneCountyList()`
### `loadDefaults()`
### `buildDealFromSalesUp()`
### `insertTradeIn(Integer count)`
### `static lookupBuyer(String bid)`
### `lookupVehicle(String vid)`
### `populateBuyerData(Contact contact)`
### `populateCoBuyerData(Contact contact)`
### `populateCompany(Account a)`
### `populateVehicle(dealer__Vehicle_Inventory__c vehicle)`
### `populateVehicleById(String vid)`
### `static setApplicationCache()`
### `save()`
### `returnTabId()`
### `returnToDeal()`
### `getContractTypes()`
### `searchESC()`
### `resetResult()`
### `selectProduct()`
### `findTotalRollup()`
### `deleteProduct()`
### `static updateServiceContractSale(String scSale, String costType)`

`REMOTEACTION`
### `newDeal()`
### `newDealPayment()`
### `fetchWeOwe()`
### `getInvoiceLogo()`
### `searchEquipment()`
### `static selectStockNumber(String stkid)`

`REMOTEACTION`
### `static lookupContact(String cid)`

`REMOTEACTION`
### `static lookupAccount(String aid)`

`REMOTEACTION`
### `static getTaxZone(String statezone)`

`REMOTEACTION`
### `static saveServiceContract(String serviceContractJSON)`

`REMOTEACTION`
### `saveTradesData(string tradeJSON)`
### `static saveTrades(string tradeJSON)`

`REMOTEACTION`
### `saveWeOweLineItem()`
### `static addAfterMarketItem(String aftermarketjson)`

`REMOTEACTION`
### `static deleteAftermarketItem(String aId)`

`REMOTEACTION`
### `static saveFee(String feeJSON)`

`REMOTEACTION`
### `static saveImpactOnOff(String s)`

`REMOTEACTION`
### `static saveImpactPrinterName(String s)`

`REMOTEACTION`
### `updateFinanceGross()`
### `rollupSummaries()`
### `rollupSummaryEvaluate()`
---
## Classes
### FormsWrapper
#### Constructors
##### `FormsWrapper(dealer__Form__c form)`
---
#### Properties

##### `objForm` → `dealer__Form__c`


##### `selected` → `boolean`


---

---
