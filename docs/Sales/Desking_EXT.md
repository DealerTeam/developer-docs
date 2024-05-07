---
layout: default
---
# Desking_EXT



**Class** Desking Controller


**Group** Sales

## Constructors
### `public Desking_EXT(ApexPages stdController)`
---
## Fields

### `public dealDefaults` → `list<dealer__DMS_Settings__c>`


### `public buyer` → `Contact`


### `public cobuyer` → `Contact`


### `public dealTitle` → `String`


### `public lender` → `String`


### `public dealFormObject` → `dealer__Deal__c`


### `private appraisalVehList` → `List<dealer__Appraisal_Vehicle__c>`


### `public vinToTradeMap` → `Map<String,dealer__Trade_In__c>`


### `public dealStatus` → `Map<String,dealer__Deal_Status_Map_Setting__c>`


---
## Properties

### `public deal` → `dealer__Deal__c`


### `public config` → `dealer__SalesDeskLogSettings__c`


### `public tradeInJSON` → `String`


### `public tradeInJSONData` → `String`


### `public vehicle` → `dealer__Vehicle_Inventory__c`


### `public formId` → `String`


### `public kitMFG` → `String`


### `public kitNumber` → `String`


### `public kitDescription` → `String`


### `public kitList` → `List<dealer__Parts_Kit__c>`


### `public kitResultSize` → `String`


### `public listFormWrap` → `List<FormsWrapper>`


### `public jsonDataToInsert` → `String`


### `public dmsDealStatus` → `String`


### `public selectedPartNumber` → `String`


### `public iswarrPrem` → `Boolean`


### `public isMainPrem` → `Boolean`


### `public isGAPPrem` → `Boolean`


### `public isOtherPrem` → `Boolean`


### `public vehicleInventory` → `dealer__Vehicle_Inventory__c`


### `public inventoryVehicleList` → `list<dealer__Vehicle_Inventory__c>`


### `public baseURL` → `String`


### `public baseURLNonManaged` → `String`


### `public weOwe` → `dealer__We_Owe__c`


### `public escDescription` → `String`


### `public escCode` → `String`


### `public escType` → `String`


### `public escResults` → `List<dealer__Service_Contract__c>`


### `public deleteProductId` → `String`


### `public selectedContractType` → `String`


### `public escSelectedId` → `String`


### `public gapRollupValue` → `Double`


### `public td1` → `dealer__Sales_up__c`


### `public td2` → `dealer__Sales_up__c`


### `public td3` → `dealer__Sales_up__c`


### `public seletedTabId` → `String`


### `public soldOnProposal` → `List<dealer__Service_Contract__c>`


### `public forms` → `List<dealer__Form__c>`


### `public avaialbleContracts` → `List<dealer__Service_Contract__c>`


### `public dealPayments` → `List<dealer__Deal_Payment__c>`


### `public trades` → `String`


### `public aftermarket` → `String`


### `public feedata` → `String`


---
## Methods
### `public List<SelectOption> getFinanceCompanies()`
### `public String getLender()`
### `public void setLender(String lender)`
### `public static dealer__Trade_In__c notLostTradeIn(String dealId)`

`REMOTEACTION`
### `public pageReference createInventory()`
### `public dealer__Service_Vehicle__c fetchSVFromDeal()`
### `public dealer__Vehicle_Inventory__c fetchInVehFromDeal()`
### `public List<dealer__Vehicle_Inventory__c> fetchInventoryVehicle()`
### `public pagereference mergeAndPrint()`
### `public String getdealTitle()`
### `public List<String> getTaxZoneCountyList()`
### `public void loadDefaults()`
### `public void buildDealFromSalesUp()`
### `public void insertTradeIn(Integer count)`
### `public static Contact lookupBuyer(String bid)`
### `public dealer__Vehicle_Inventory__c lookupVehicle(String vid)`
### `public void populateBuyerData(Contact contact)`
### `public void populateCoBuyerData(Contact contact)`
### `public void populateCompany(Account a)`
### `public void populateVehicle(dealer__Vehicle_Inventory__c vehicle)`
### `public void populateVehicleById(String vid)`
### `public static void setApplicationCache()`
### `public PageReference save()`
### `public string returnTabId()`
### `public PageReference returnToDeal()`
### `public List<SelectOption> getContractTypes()`
### `public PageReference searchESC()`
### `public PageReference resetResult()`
### `public PageReference selectProduct()`
### `public void findTotalRollup()`
### `public PageReference deleteProduct()`
### `public static Boolean updateServiceContractSale(String scSale, String costType)`

`REMOTEACTION`
### `public PageReference newDeal()`
### `public PageReference newDealPayment()`
### `public dealer__We_Owe__c fetchWeOwe()`
### `public String getInvoiceLogo()`
### `public PageReference searchEquipment()`
### `public static List<dealer__Vehicle_Inventory__c> selectStockNumber(String stkid)`

`REMOTEACTION`
### `public static Contact lookupContact(String cid)`

`REMOTEACTION`
### `public static Account lookupAccount(String aid)`

`REMOTEACTION`
### `public static dealer__Tax_Zones__c getTaxZone(String statezone)`

`REMOTEACTION`
### `public static boolean saveServiceContract(String serviceContractJSON)`

`REMOTEACTION`
### `public void saveTradesData(string tradeJSON)`
### `public static dealer__Trade_In__c saveTrades(string tradeJSON)`

`REMOTEACTION`
### `public PageReference saveWeOweLineItem()`
### `public static dealer__After_Market__c addAfterMarketItem(String aftermarketjson)`

`REMOTEACTION`
### `public static boolean deleteAftermarketItem(String aId)`

`REMOTEACTION`
### `public static dealer__Sales_Fee__c saveFee(String feeJSON)`

`REMOTEACTION`
### `public static boolean saveImpactOnOff(String s)`

`REMOTEACTION`
### `public static boolean saveImpactPrinterName(String s)`

`REMOTEACTION`
### `public void updateFinanceGross()`
### `public void rollupSummaries()`
### `public void rollupSummaryEvaluate()`
---
## Classes
### FormsWrapper
#### Constructors
##### `public FormsWrapper(dealer__Form__c form)`
---
#### Properties

##### `public objForm` → `dealer__Form__c`


##### `public selected` → `boolean`


---

---
