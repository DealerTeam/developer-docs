---
layout: default
---
# Desking_EXT class

 Desking Controller /** 2016-06-23   |Jarrett Kuljis | Cleanup of the code that was incorrectly introduced via external developers 2016-06-30   |Jarrett Kuljis |W-000373 Stock-in of trade vehicles was transposing Make/Model 2016-08-04   |Sneha Utture   |Case1964 Update Buyer Account with Buyer Contact if its a person account

---
## Constructors
### `Desking_EXT(ApexPages.StandardController stdController)`
---
## Properties

### `aftermarket` → `String`

### `avaialbleContracts` → `List<dealer__Service_Contract__c>`

### `baseURL` → `String`

### `baseURLNonManaged` → `String`

### `buyer` → `Contact`

### `cobuyer` → `Contact`

### `config` → `dealer__SalesDeskLogSettings__c`

### `deal` → `public`

### `dealDefaults` → `list<dealer__DMS_Settings__c>`

### `dealFormObject` → `dealer__Deal__c`

### `dealPayments` → `List<dealer__Deal_Payment__c>`

### `dealStatus` → `dealer__Deal_Status_Map_Setting__c>`

### `dealTitle` → `String`

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

### `lender` → `String`

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

### `vinToTradeMap` → `dealer__Trade_In__c>`

### `weOwe` → `dealer__We_Owe__c`

---
## Methods
### `addAfterMarketItem(String aftermarketjson)` → `dealer__After_Market__c`

passing tab number to return (added by KVP)***********

### `buildDealFromSalesUp()` → `void`
### `createInventory()` → `pageReference`

 KVP Method Name : createInventory Descripion  : Creating vehicle inventory record based on selTradein

### `deleteAftermarketItem(String aId)` → `boolean`
### `deleteProduct()` → `PageReference`
### `fetchInVehFromDeal()` → `dealer__Vehicle_Inventory__c`
### `fetchInventoryVehicle()` → `List<dealer__Vehicle_Inventory__c>`

 KVP Method Name : fetchInventoryVehicle Descripion  : Method to fetch the data from Trade In record

### `fetchSVFromDeal()` → `dealer__Service_Vehicle__c`
### `fetchWeOwe()` → `dealer__We_Owe__c`
### `findTotalRollup()` → `void`

by KVP****** /************************** /************ Added by KVP ***************************

### `getContractTypes()` → `List<SelectOption>`
### `getFinanceCompanies()` → `List<SelectOption>`
### `getInvoiceLogo()` → `String`
### `getLender()` → `String`
### `getTaxZone(String statezone)` → `dealer__Tax_Zones__c`
### `getTaxZoneCountyList()` → `List<String>`
### `getdealTitle()` → `String`
### `insertTradeIn(Integer count)` → `void`
### `loadDefaults()` → `void`
### `lookupAccount(String aid)` → `Account`
### `lookupBuyer(String bid)` → `Contact`
### `lookupContact(String cid)` → `Contact`
### `lookupVehicle(String vid)` → `dealer__Vehicle_Inventory__c`
### `mergeAndPrint()` → `pagereference`
### `newDeal()` → `PageReference`
### `newDealPayment()` → `PageReference`
### `notLostTradeIn(String dealId)` → `dealer__Trade_In__c`

 KVP Method Name : notLostTradeIn Descripion  : Initialize the SelTradin to create Inventory

### `populateBuyerData(Contact contact)` → `void`
### `populateCoBuyerData(Contact contact)` → `void`
### `populateCompany(Account a)` → `void`
### `populateVehicle(dealer__Vehicle_Inventory__c vehicle)` → `void`
### `populateVehicleById(String vid)` → `void`
### `resetResult()` → `PageReference`
### `returnTabId()` → `string`
### `returnToDeal()` → `PageReference`
### `rollupSummaries()` → `void`
### `rollupSummaryEvaluate()` → `void`
### `save()` → `PageReference`
### `saveFee(String feeJSON)` → `dealer__Sales_Fee__c`
### `saveImpactOnOff(String s)` → `boolean`
### `saveImpactPrinterName(String s)` → `boolean`
### `saveServiceContract(String serviceContractJSON)` → `boolean`
### `saveTrades(string tradeJSON)` → `dealer__Trade_In__c`
### `saveTradesData(string tradeJSON)` → `void`
### `saveWeOweLineItem()` → `PageReference`

 Add a new Aftermkarket item

### `searchESC()` → `PageReference`
### `searchEquipment()` → `PageReference`
### `selectProduct()` → `PageReference`
### `selectStockNumber(String stkid)` → `List<dealer__Vehicle_Inventory__c>`
### `setApplicationCache()` → `void`
### `setLender(String lender)` → `void`
### `updateFinanceGross()` → `void`
### `updateServiceContractSale(String scSale, String costType)` → `Boolean`

by KVP****** /**************************

---
## Inner Classes

### Desking_EXT.FormsWrapper class
---
#### Constructors
##### `FormsWrapper(dealer__Form__c form)`
---
#### Properties

##### `objForm` → `dealer__Form__c`

##### `selected` → `boolean`

---
