---
layout: default
---
# DealTRSController



**Class** DealTRSController


**Group** Sales

## Constructors
### `public DealTRSController()`

Constructor with no standard controller (not loaded via VF Pgae)


**Method** DealTRSController

### `public DealTRSController(ApexPages controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** DealTRSController

---
## Fields

### `private currentId` → `String`


### `public urlParams` → `Map<String,String>`


### `private dealId` → `String`


### `private formId` → `String`


---
## Properties

### `public action` → `String`


### `public retJSON` → `String`


### `private field_map` → `Map<String,Schema.SObjectField>`


### `public searchQuery` → `String`


### `public pageNumber` → `Integer`


### `public pageSize` → `Integer`


### `public processInstanceId` → `string`


### `public isCobuyerSearch` → `boolean`


### `public casheirRecordId` → `Id`


### `public dealRecord` → `dealer__Deal__c`


### `public salesup` → `dealer__Sales_Up__c`


### `public relatedDeals` → `List<dealer__Deal__c>`


### `public deskingConfig` → `DeskingConfiguration__mdt`


Configration and custom setting values

### `public deskingSubTabConfig` → `List<DeskingSubtabConfiguration__mdt>`


### `public deskingComponentConfiguration` → `Map<String,dealer__DeskingComponentConfiguration__mdt>`


### `public mySettings` → `DeskingUserSetting__c`


---
## Methods
### `public static DeskingConfiguration__mdt config(String apiName)`
#### Parameters

|Param|Description|
|---|---|
|`apiName`||

#### Returns

|Type|Description|
|---|---|
|`DeskingConfiguration__mdt`|static|


**Method** config

### `public static List<DeskingSubtabConfiguration__mdt> subTabConfig(String configApiName)`
#### Parameters

|Param|Description|
|---|---|
|`configApiName`||

#### Returns

|Type|Description|
|---|---|
|`List<DeskingSubtabConfiguration__mdt>`|List<DeskingSubtabConfiguration__mdt>|


**Method** subTabConfig

### `public static Map<String,DeskingComponentConfiguration__mdt> componentConfiguration(String configApiName)`
#### Parameters

|Param|Description|
|---|---|
|`configApiName`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,DeskingComponentConfiguration__mdt>`|Map<String, DeskingComponentConfiguration__mdt>|


**Method** componentConfiguration

### `public static DeskingUserSetting__c userSettings(Id userId)`
#### Parameters

|Param|Description|
|---|---|
|`userId`||

#### Returns

|Type|Description|
|---|---|
|`DeskingUserSetting__c`|DeskingUserSetting__c|


**Method** userSettings

### `public static void insertUserSettings(Id userId)`
#### Parameters

|Param|Description|
|---|---|
|`userId`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** insertUserSettings

### `public List<dealer__Deal__c> loadRelatedDeals()`

used to set a list of related deals when the controller is instantiated.

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Deal__c>`|List<daeler__Deal__c>|


**Method** loadRelatedDeals

### `public String getDealKeyPrefix()`

gets the deal object key prefix

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDealKeyPrefix

### `public PageReference crudAction()`

router for all action calls

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** crudAction

### `public string getDealContentDocuments()`

Lookups documents linked to the Deal

#### Returns

|Type|Description|
|---|---|
|`string`|String|


**Method** getDealContentDocuments

### `public String getUserReadLookup()`

performs the server side searching for the user inputs

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getUserReadLookup

### `public List<User> getUserRead()`

Read User by SOSL

#### Returns

|Type|Description|
|---|---|
|`List<User>`|List < User >|


**Method** getUserRead

### `public List<User> getUserReadById()`

Read User by Id/No Id

#### Returns

|Type|Description|
|---|---|
|`List<User>`|List < User >|


**Method** getUserReadById

### `public String getPicklistValues()`

Retrieve Picklist Values

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPicklistValues

### `public String getDefaultStatusValue()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDefaultStatusValue

### `public String getLocationReadLookup()`

Lookup for pick Location. IF we have a CustID execute based on ID, else Based on No ID.

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getLocationReadLookup

### `public List<dealer__Dealer_Location__c> getLocationRead()`

Read Location by SOSL

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Dealer_Location__c>`|List < dealer__Dealer_Location__c >|


**Method** getLocationRead

### `public List<dealer__Dealer_Location__c> getLocationReadById()`

Read Location by Id/No Id

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Dealer_Location__c>`|List < dealer__Dealer_Location__c >|


**Method** getLocationReadById

### `public String getImageVehicle()`

Image Inventory of current vehicle

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getImageVehicle description

### `public String getVehicleReadLookup()`

Get Vehicle for Lookup - IF we have a CustID execute based on ID, else Based on No ID

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getVehicleReadLookup

### `public List<dealer__Vehicle_Inventory__c> getVehicleRead()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Vehicle_Inventory__c>`|List < dealer__Vehicle_Inventory__c >|


**Method** getVehicleRead

### `public List<dealer__Vehicle_Inventory__c> getVehicleReadById()`

Read dealer__Vehicle_Inventory__c by Id/No Id

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Vehicle_Inventory__c>`|List < dealer__Vehicle_Inventory__c >|


**Method** getVehicleReadById

### `public String getSerVehicleReadLookup()`

Get Service Vehicle for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSerVehicleReadLookup

### `public List<dealer__Service_Vehicle__c> getSerVehicleRead()`

Read dealer__Service_Vehicle__c by SOSL

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Vehicle__c>`|List < dealer__Service_Vehicle__c >|


**Method** getSerVehicleRead

### `public List<dealer__Service_Vehicle__c> getSerVehicleReadById()`

Read dealer__Service_Vehicle__c by Id/No Id

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Vehicle__c>`|List < dealer__Service_Vehicle__c >|


**Method** getSerVehicleReadById

### `public String getAppraisalsWithVehicle()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getAppraisalsWithVehicle

### `public String getAppraisalReadLookup()`

Get dealer__Appraisal_Vehicle__c for Lookup. IF we have a CustID execute based on ID, else Based on No ID .

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getAppraisalReadLookup

### `public List<dealer__Appraisal__c> getAppraisalRead()`

Read dealer__Appraisal_Vehicle__c by SOSL. this implementation was never complete ?

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Appraisal__c>`|List < dealer__Appraisal__c >|


**Method** getAppraisalRead

### `public List<dealer__Appraisal__c> getAppraisalReadById(String customerId)`

Read dealer__Appraisal_Vehicle__c by Id/No Id.

#### Parameters

|Param|Description|
|---|---|
|`customerId`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Appraisal__c>`|List < dealer__Appraisal__c >|


**Method** getAppraisalReadById

### `public String getAccountReadLookup()`

Get Account for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getAccountReadLookup

### `public String getCashierAccountRead()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getCashierAccountRead

### `public List<Account> getAccountRead()`

Read account by SOSL

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List < Account >|


**Method** getAccountRead

### `public List<Account> getAccountReadById()`

Read Account by Id/No Id

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List < Account >|


**Method** getAccountReadById

### `public List<dealer__Kit_Category__c> getCategoryRead(string type)`

Get the Conversion Kit Lookups

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Kit_Category__c>`|List < dealer__Kit_Category__c >|


**Method** getCategoryRead

### `public String getCategoryReadLookup()`

Get Category for lookup

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getCategoryReadLookup

### `public List<dealer__Kit_Category__c> getCategoryReadById(string type)`

Read dealer__Kit_Category__c by Id/No Id

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Kit_Category__c>`|List < dealer__Kit_Category__c >|


**Method** getCategoryReadById

### `public string getBuyerAccount()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getBuyerAccount

### `public string getUserJson(List<User> u)`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getUserJson

### `public static Account selectedAccount(String accId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`accId`||

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|


**Method** selectedAccount

### `public static dealer__Service_Repair_Order__c checkRoQueue(String dealId, String jobId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`jobId`||

#### Returns

|Type|Description|
|---|---|
|`dealer__Service_Repair_Order__c`|dealer__Service_Repair_Order__c|


**Method** checkRoQueue

### `public static Id createDeliveryRepairOrder(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`Id`|Id|


**Method** createDeliveryRepairOrder

### `public static boolean closeDeal(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** closeDeal

### `public static string removeSuggestedForm(Id dealId, Id formId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`formId`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** removeSuggestedForm

### `public static String printFormBundle(Id dealId, List<String> formIds)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`formIds`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** printFormBundle

### `public static void createNewDealForms(String dealForms)`

`FUTURE`
#### Parameters

|Param|Description|
|---|---|
|`dealForms`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createNewDealForms

### `private static List<String> createRemoteVFResource(Id dealId, List<dealer__Form__c> forms)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`List<String>`|List < String >|


**Method** createRemoteVFResource

### `private static Map<String,String> generateFDF(Id dealId, List<dealer__Form__c> forms)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,String>`|Map < String, String >|


**Method** generateFDF

### `private static String generateBodyJSON(Map<String,String> fdfMap, List<String> forms)`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** generateBodyJSON

### `public static void newDeliveryRO(String dealId)`

`FUTURE`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||


**Method** newDeliveryRO

### `public string getPdfBody(List<dealer__Form__c> lstOfForms)`

Get Merge PDF body

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getPdfBody

### `public string doHttpRequest(string body, boolean isSave)`
#### Parameters

|Param|Description|
|---|---|
|`body`||
|`isSave`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** doHttpRequest

### `public String deleteLaserDealForm()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteLaserDealForm

### `public String deleteImpactDealForm()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteImpactDealForm

### `public String getSelectedForm()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSelectedForm

### `public String getDeal()`

Get the deal record

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDeal

### `public List<dealer__Deal__c> getDealRecord()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Deal__c>`|List < dealer__Deal__c >|


**Method** getDealRecord

### `public String getDealTypeValues()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDealTypeValues

### `public String getDealStatusValues()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDealStatusValues

### `public string getTradeIns()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getTradeIns

### `public String updateTradeIn()`

Update Trade In

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateTradeIn

### `public String updateDeal()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateDeal

### `public Boolean updateBuyerAccount()`
#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** updateBuyerAccount

### `public Boolean updateCoBuyerAccount()`
#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** updateCoBuyerAccount

### `public String createTradeIn()`

Create Trade In record

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** createTradeIn

### `public dealer__Appraisal__c createAppraisalFromTrade(dealer__Trade_In__c trade)`
#### Parameters

|Param|Description|
|---|---|
|`trade`||

#### Returns

|Type|Description|
|---|---|
|`dealer__Appraisal__c`|dealer__Appraisal__c|


**Method** createAppraisalFromTrade

### `public dealer__Appraisal_Vehicle__c createAppraisalVehicle(Id appraisalId, dealer__Trade_In__c trade)`
#### Parameters

|Param|Description|
|---|---|
|`appraisalId`||
|`trade`||

#### Returns

|Type|Description|
|---|---|
|`dealer__Appraisal_Vehicle__c`|dealer__Appraisal_Vehicle__c|


**Method** createAppraisalVehicle

### `public String getPartKitSoql()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPartKitSoql

### `public String getPartKits()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPartKits

### `public String getPartKitCount()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPartKitCount

### `public String getcashierOptions()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getcashierOptions

### `public String createCashierEntry()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** createCashierEntry

### `public String deleteCashierEntry()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteCashierEntry

### `public String updateCashierEntry()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateCashierEntry

### `public String getreadCashier()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getreadCashier

### `public String getreadCashierRow()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getreadCashierRow

### `public String upsertAfterMarket()`

Create After Market record

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertAfterMarket

### `public String getAfterMarkets()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getAfterMarkets

### `public String deleteAfterMarket()`

Delete After Market

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteAfterMarket

### `public String deleteTradeIn()`

Delete Trade In

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteTradeIn

### `public String deleteDeal()`

Delete the deal record

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteDeal

### `public string getParts()`
### `public void getPicklistFieldDescribe()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** getPicklistFieldDescribe

### `public string getServiceContractPicklistValues()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getServiceContractPicklistValues

### `public string getconversionMFGPicklistValues()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getconversionMFGPicklistValues

### `public string getAvailableContractSoql()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getAvailableContractSoql

### `public String getmyDeskingSettings()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getmyDeskingSettings

### `public static void setDisplayAsGross(String onoff)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`onoff`||


**Method** setDisplayAsGross

### `public static void setCustomDisplay()`

`REMOTEACTION`

**Method** setCustomDisplay description

### `public string getAvailableContracts()`

Return list of available Service contracts for warranty tab

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getAvailableContracts

### `public string getAvailableContractCount()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getAvailableContractCount

### `public string getDiscountTemplates()`

Discount objects read from Database

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getDiscountTemplates

### `public string getRebates()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getRebates

### `public string getDiscounts()`

Discount objects read from Database

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getDiscounts

### `public string updateDiscount()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** updateDiscount

### `public string destroyDiscount()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** destroyDiscount

### `public String getGrossItems()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getGrossItems

### `public string getTaxTemplates()`

Discount objects read from Database

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getTaxTemplates

### `public List<dealer__Deal_Tax__c> dealTaxes()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Deal_Tax__c>`|List < dealer__Deal_Tax__c >|


**Method** dealTaxes

### `public string getDealTaxes()`

Deal Tax objects read from Database

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getDealTaxes

### `public string getDealMiscTaxes()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getDealMiscTaxes

### `public String getReadTaxItems()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getReadTaxItems

### `public String deleteTaxTansactionItem()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteTaxTansactionItem

### `public String upsertTaxTransactionItem()`

String

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertTaxTransactionItem

### `public string upsertTaxLine()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** upsertTaxLine

### `public string destroyTaxLine()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** destroyTaxLine

### `public String getTaxZoneSearch()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getTaxZoneSearch

### `public List<dealer__Tax_Zones__c> taxZonesByZip()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Tax_Zones__c>`|List < dealer__Tax_Zones__c >|


**Method** taxZonesByZip

### `public string getTaxZones()`
#### Returns

|Type|Description|
|---|---|
|`string`||


**Method** getTaxZones

### `public dealer__Tax_Zones__c getTaxZones(Id taxZoneId)`
#### Parameters

|Param|Description|
|---|---|
|`taxZoneId`||

#### Returns

|Type|Description|
|---|---|
|`dealer__Tax_Zones__c`|dealer__Tax_Zones__c|


**Method** getTaxZones

### `public string renewTaxLines()`

Called when the tax lines need to be calulated/re-calculated              Updated to use new Tax Methods

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** renewTaxLines

### `public string getMiscTaxCode()`
### `public string getmiscChargeCodes()`
### `public String getPostingTemplates()`

Posting Template Selector

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPostingTemplates

### `public string getSelectedContracts()`

return list of selected contract based on "Contract Template" check box

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getSelectedContracts

### `public String deleteContract()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** deleteContract

### `public string insertContract()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** insertContract

### `public String insertAccount()`

method to insert account data

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** insertAccount

### `public String updateAccounts()`

Inserts or updates and account object passed into the method by URL Parameters.

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateAccounts

### `public String updateContract()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** updateContract

### `public String getFinanceCompany()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getFinanceCompany

### `public string cloneDeal()`

For creating deep clone of current deal.

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** cloneDeal

### `public String getLaserForm()`

Get from detail

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getLaserForm

### `public static String buildFormRefQuery(Deal__c thisDeal, String printType)`
#### Parameters

|Param|Description|
|---|---|
|`thisDeal`||
|`printType`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** buildFormRefQuery

### `public String getApplicableForms(Deal__c thisDeal)`
#### Parameters

|Param|Description|
|---|---|
|`thisDeal`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getApplicableForms

### `public String getApplicableForms()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getApplicableForms

### `public String getImpactForm()`

Get from detail

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getImpactForm

### `public String getSelectedImpactForm()`

Get selected Impact from list

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSelectedImpactForm

### `public String getSelectedLaserForm()`

Get selected Impact from list

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSelectedLaserForm

### `public String getcompiledFDF()`

Retreive FDF Blob

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getcompiledFDF

### `public string getRecentSalesUps()`

Discount objects read from Database

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getRecentSalesUps

### `public boolean getActiveApproval()`

Get Active Approval Process

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** getActiveApproval

### `public string getApprovalIsLocked()`

Check if Approval process is in Progress

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getApprovalIsLocked

### `public pagereference refreshButtonPanels()`
#### Returns

|Type|Description|
|---|---|
|`pagereference`|pagereference|


**Method** refreshButtonPanels

### `public String getApprovalHistory()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getApprovalHistory

### `public String getSubmitApproval()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSubmitApproval

### `public pagereference recallApprovalProcess()`
#### Returns

|Type|Description|
|---|---|
|`pagereference`|pagereference|


**Method** recallApprovalProcess

### `private string getRecordIds(List<SObject> sObjectList)`

`TESTVISIBLE`

method to concatenate ids of search results

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getRecordIds

### `public string getFilters()`
#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getFilters

### `public Map<string,string> getFilterMap()`
#### Returns

|Type|Description|
|---|---|
|`Map<string,string>`|Map < string, string >|


**Method** getFilterMap

### `public string getValue(string value, string type)`

Get/POST variable cleaning

#### Parameters

|Param|Description|
|---|---|
|`value`||
|`type`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getValue

### `public string getAccountsForNewDeal()`

To read accounts for creating new deal

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getAccountsForNewDeal

### `public String createFee()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** createFee

### `public String getDealFees()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getDealFees

### `public String getFeeTemplates()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getFeeTemplates

### `public String updateFee()`
#### Returns

|Type|Description|
|---|---|
|`String`|Sting|


**Method** updateFee

### `public static void refreshDefaultFees(Id dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** refreshDefaultFees

### `public void updateDealFeeTotal(Id dealId)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateDealFeeTotal

### `public String destroyFee()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** destroyFee

### `public static boolean setasPrimaryDeal(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** setasPrimaryDeal

### `public String getPricingStrategy()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getPricingStrategy

### `public Boolean getSchedulePricing()`
#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** getSchedulePricing

---
## Classes
### formWrapper
#### Constructors
##### `public formWrapper(String documentId, String docType, String content, string mergeData)`
---
#### Fields

##### `private documentId` → `String`


##### `private docType` → `String`


##### `private content` → `String`


##### `private mergeData` → `String`


---

### DealFormWrapper


#### Fields

##### `private suggestedForms` → `List&lt;Form__c&gt;`


##### `private allForms` → `List&lt;Form__c&gt;`


---

### DealTRSControllerException



**Inheritance**

DealTRSControllerException


**Descripton** 


---
