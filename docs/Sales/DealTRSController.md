# DealTRSController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealTRSController


**Group** Sales

## Constructors
### `DealTRSController()`

Constructor with no standard controller (not loaded via VF Pgae)


**Method** DealTRSController

### `DealTRSController(ApexPages.StandardController controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** DealTRSController

---
## Fields

### `urlParams` → `Map<String,String>`


---
## Properties

### `action` → `String`


### `casheirRecordId` → `Id`


### `dealRecord` → `dealer__Deal__c`


### `deskingComponentConfiguration` → `Map<String,dealer__DeskingComponentConfiguration__mdt>`


### `deskingConfig` → `DeskingConfiguration__mdt`


Configration and custom setting values

### `deskingSubTabConfig` → `List<DeskingSubtabConfiguration__mdt>`


### `isCobuyerSearch` → `boolean`


### `mySettings` → `DeskingUserSetting__c`


### `pageNumber` → `Integer`


### `pageSize` → `Integer`


### `processInstanceId` → `string`


### `relatedDeals` → `List<dealer__Deal__c>`


### `retJSON` → `String`


### `salesup` → `dealer__Sales_Up__c`


### `searchQuery` → `String`


---
## Methods
### `static config(String apiName)`
#### Parameters

|Param|Description|
|---|---|
|`apiName`||

#### Return

**Type**

DeskingConfiguration__mdt

**Description**

static


**Method** config

### `static subTabConfig(String configApiName)`
#### Parameters

|Param|Description|
|---|---|
|`configApiName`||

#### Return

**Type**

List&lt;DeskingSubtabConfiguration__mdt&gt;

**Description**

List&lt;DeskingSubtabConfiguration__mdt&gt;


**Method** subTabConfig

### `static componentConfiguration(String configApiName)`
#### Parameters

|Param|Description|
|---|---|
|`configApiName`||

#### Return

**Type**

Map&lt;String,DeskingComponentConfiguration__mdt&gt;

**Description**

Map&lt;String, DeskingComponentConfiguration__mdt&gt;


**Method** componentConfiguration

### `static userSettings(Id userId)`
#### Parameters

|Param|Description|
|---|---|
|`userId`||

#### Return

**Type**

DeskingUserSetting__c

**Description**

DeskingUserSetting__c


**Method** userSettings

### `static insertUserSettings(Id userId)`
#### Parameters

|Param|Description|
|---|---|
|`userId`||

#### Return

**Type**

void

**Description**

void


**Method** insertUserSettings

### `loadRelatedDeals()`

used to set a list of related deals when the controller is instantiated.

#### Return

**Type**

List&lt;dealer__Deal__c&gt;

**Description**

List&lt;daeler__Deal__c&gt;


**Method** loadRelatedDeals

### `getDealKeyPrefix()`

gets the deal object key prefix

#### Return

**Type**

String

**Description**

String


**Method** getDealKeyPrefix

### `crudAction()`

router for all action calls

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** crudAction

### `getDealContentDocuments()`

Lookups documents linked to the Deal

#### Return

**Type**

string

**Description**

String


**Method** getDealContentDocuments

### `getUserReadLookup()`

performs the server side searching for the user inputs

#### Return

**Type**

String

**Description**

String


**Method** getUserReadLookup

### `getUserRead()`

Read User by SOSL

#### Return

**Type**

List&lt;User&gt;

**Description**

List &lt; User &gt;


**Method** getUserRead

### `getUserReadById()`

Read User by Id/No Id

#### Return

**Type**

List&lt;User&gt;

**Description**

List &lt; User &gt;


**Method** getUserReadById

### `getPicklistValues()`

Retrieve Picklist Values

#### Return

**Type**

String

**Description**

String


**Method** getPicklistValues

### `getDefaultStatusValue()`
#### Return

**Type**

String

**Description**

String


**Method** getDefaultStatusValue

### `getLocationReadLookup()`

Lookup for pick Location. IF we have a CustID execute based on ID, else Based on No ID.

#### Return

**Type**

String

**Description**

String


**Method** getLocationReadLookup

### `getLocationRead()`

Read Location by SOSL

#### Return

**Type**

List&lt;dealer__Dealer_Location__c&gt;

**Description**

List &lt; dealer__Dealer_Location__c &gt;


**Method** getLocationRead

### `getLocationReadById()`

Read Location by Id/No Id

#### Return

**Type**

List&lt;dealer__Dealer_Location__c&gt;

**Description**

List &lt; dealer__Dealer_Location__c &gt;


**Method** getLocationReadById

### `getImageVehicle()`

Image Inventory of current vehicle

#### Return

**Type**

String

**Description**

String


**Method** getImageVehicle description

### `getVehicleReadLookup()`

Get Vehicle for Lookup - IF we have a CustID execute based on ID, else Based on No ID

#### Return

**Type**

String

**Description**

String


**Method** getVehicleReadLookup

### `getVehicleRead()`
#### Return

**Type**

List&lt;dealer__Vehicle_Inventory__c&gt;

**Description**

List &lt; dealer__Vehicle_Inventory__c &gt;


**Method** getVehicleRead

### `getVehicleReadById()`

Read dealer__Vehicle_Inventory__c by Id/No Id

#### Return

**Type**

List&lt;dealer__Vehicle_Inventory__c&gt;

**Description**

List &lt; dealer__Vehicle_Inventory__c &gt;


**Method** getVehicleReadById

### `getSerVehicleReadLookup()`

Get Service Vehicle for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

#### Return

**Type**

String

**Description**

String


**Method** getSerVehicleReadLookup

### `getSerVehicleRead()`

Read dealer__Service_Vehicle__c by SOSL

#### Return

**Type**

List&lt;dealer__Service_Vehicle__c&gt;

**Description**

List &lt; dealer__Service_Vehicle__c &gt;


**Method** getSerVehicleRead

### `getSerVehicleReadById()`

Read dealer__Service_Vehicle__c by Id/No Id

#### Return

**Type**

List&lt;dealer__Service_Vehicle__c&gt;

**Description**

List &lt; dealer__Service_Vehicle__c &gt;


**Method** getSerVehicleReadById

### `getAppraisalsWithVehicle()`
#### Return

**Type**

String

**Description**

String


**Method** getAppraisalsWithVehicle

### `getAppraisalReadLookup()`

Get dealer__Appraisal_Vehicle__c for Lookup. IF we have a CustID execute based on ID, else Based on No ID .

#### Return

**Type**

String

**Description**

String


**Method** getAppraisalReadLookup

### `getAppraisalRead()`

Read dealer__Appraisal_Vehicle__c by SOSL. this implementation was never complete ?

#### Return

**Type**

List&lt;dealer__Appraisal__c&gt;

**Description**

List &lt; dealer__Appraisal__c &gt;


**Method** getAppraisalRead

### `getAppraisalReadById(String customerId)`

Read dealer__Appraisal_Vehicle__c by Id/No Id.

#### Parameters

|Param|Description|
|---|---|
|`customerId`||

#### Return

**Type**

List&lt;dealer__Appraisal__c&gt;

**Description**

List &lt; dealer__Appraisal__c &gt;


**Method** getAppraisalReadById

### `getAccountReadLookup()`

Get Account for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

#### Return

**Type**

String

**Description**

String


**Method** getAccountReadLookup

### `getCashierAccountRead()`
#### Return

**Type**

String

**Description**

String


**Method** getCashierAccountRead

### `getAccountRead()`

Read account by SOSL

#### Return

**Type**

List&lt;Account&gt;

**Description**

List &lt; Account &gt;


**Method** getAccountRead

### `getAccountReadById()`

Read Account by Id/No Id

#### Return

**Type**

List&lt;Account&gt;

**Description**

List &lt; Account &gt;


**Method** getAccountReadById

### `getCategoryRead(string type)`

Get the Conversion Kit Lookups

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Return

**Type**

List&lt;dealer__Kit_Category__c&gt;

**Description**

List &lt; dealer__Kit_Category__c &gt;


**Method** getCategoryRead

### `getCategoryReadLookup()`

Get Category for lookup

#### Return

**Type**

String

**Description**

String


**Method** getCategoryReadLookup

### `getCategoryReadById(string type)`

Read dealer__Kit_Category__c by Id/No Id

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Return

**Type**

List&lt;dealer__Kit_Category__c&gt;

**Description**

List &lt; dealer__Kit_Category__c &gt;


**Method** getCategoryReadById

### `getBuyerAccount()`
#### Return

**Type**

string

**Description**

string


**Method** getBuyerAccount

### `getUserJson(List<User> u)`
#### Return

**Type**

string

**Description**

string


**Method** getUserJson

### `static selectedAccount(String accId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`accId`||

#### Return

**Type**

Account

**Description**

Account


**Method** selectedAccount

### `static checkRoQueue(String dealId, String jobId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`jobId`||

#### Return

**Type**

dealer__Service_Repair_Order__c

**Description**

dealer__Service_Repair_Order__c


**Method** checkRoQueue

### `static createDeliveryRepairOrder(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Return

**Type**

Id

**Description**

Id


**Method** createDeliveryRepairOrder

### `static closeDeal(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** closeDeal

### `static removeSuggestedForm(Id dealId, Id formId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`formId`||

#### Return

**Type**

string

**Description**

string


**Method** removeSuggestedForm

### `static printFormBundle(Id dealId, List<String> formIds)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||
|`formIds`||

#### Return

**Type**

String

**Description**

String


**Method** printFormBundle

### `static createNewDealForms(String dealForms)`

`FUTURE`
#### Parameters

|Param|Description|
|---|---|
|`dealForms`||

#### Return

**Type**

void

**Description**

void


**Method** createNewDealForms

### `static newDeliveryRO(String dealId)`

`FUTURE`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||


**Method** newDeliveryRO

### `getPdfBody(List<dealer__Form__c> lstOfForms)`

Get Merge PDF body

#### Return

**Type**

string

**Description**

string


**Method** getPdfBody

### `doHttpRequest(string body, boolean isSave)`
#### Parameters

|Param|Description|
|---|---|
|`body`||
|`isSave`||

#### Return

**Type**

string

**Description**

string


**Method** doHttpRequest

### `deleteLaserDealForm()`
#### Return

**Type**

String

**Description**

String


**Method** deleteLaserDealForm

### `deleteImpactDealForm()`
#### Return

**Type**

String

**Description**

String


**Method** deleteImpactDealForm

### `getSelectedForm()`
#### Return

**Type**

String

**Description**

String


**Method** getSelectedForm

### `getDeal()`

Get the deal record

#### Return

**Type**

String

**Description**

String


**Method** getDeal

### `getDealRecord()`
#### Return

**Type**

List&lt;dealer__Deal__c&gt;

**Description**

List &lt; dealer__Deal__c &gt;


**Method** getDealRecord

### `getDealTypeValues()`
#### Return

**Type**

String

**Description**

String


**Method** getDealTypeValues

### `getDealStatusValues()`
#### Return

**Type**

String

**Description**

String


**Method** getDealStatusValues

### `getTradeIns()`
#### Return

**Type**

string

**Description**

string


**Method** getTradeIns

### `updateTradeIn()`

Update Trade In

#### Return

**Type**

String

**Description**

String


**Method** updateTradeIn

### `updateDeal()`
#### Return

**Type**

String

**Description**

String


**Method** updateDeal

### `updateBuyerAccount()`
#### Return

**Type**

Boolean

**Description**

Boolean


**Method** updateBuyerAccount

### `updateCoBuyerAccount()`
#### Return

**Type**

Boolean

**Description**

Boolean


**Method** updateCoBuyerAccount

### `createTradeIn()`

Create Trade In record

#### Return

**Type**

String

**Description**

String


**Method** createTradeIn

### `createAppraisalFromTrade(dealer__Trade_In__c trade)`
#### Parameters

|Param|Description|
|---|---|
|`trade`||

#### Return

**Type**

dealer__Appraisal__c

**Description**

dealer__Appraisal__c


**Method** createAppraisalFromTrade

### `createAppraisalVehicle(Id appraisalId, dealer__Trade_In__c trade)`
#### Parameters

|Param|Description|
|---|---|
|`appraisalId`||
|`trade`||

#### Return

**Type**

dealer__Appraisal_Vehicle__c

**Description**

dealer__Appraisal_Vehicle__c


**Method** createAppraisalVehicle

### `getPartKitSoql()`
#### Return

**Type**

String

**Description**

String


**Method** getPartKitSoql

### `getPartKits()`
#### Return

**Type**

String

**Description**

String


**Method** getPartKits

### `getPartKitCount()`
#### Return

**Type**

String

**Description**

String


**Method** getPartKitCount

### `getcashierOptions()`
#### Return

**Type**

String

**Description**

String


**Method** getcashierOptions

### `createCashierEntry()`
#### Return

**Type**

String

**Description**

String


**Method** createCashierEntry

### `deleteCashierEntry()`
#### Return

**Type**

String

**Description**

String


**Method** deleteCashierEntry

### `updateCashierEntry()`
#### Return

**Type**

String

**Description**

String


**Method** updateCashierEntry

### `getreadCashier()`
#### Return

**Type**

String

**Description**

String


**Method** getreadCashier

### `getreadCashierRow()`
#### Return

**Type**

String

**Description**

String


**Method** getreadCashierRow

### `upsertAfterMarket()`

Create After Market record

#### Return

**Type**

String

**Description**

String


**Method** upsertAfterMarket

### `getAfterMarkets()`
#### Return

**Type**

String

**Description**

String


**Method** getAfterMarkets

### `deleteAfterMarket()`

Delete After Market

#### Return

**Type**

String

**Description**

String


**Method** deleteAfterMarket

### `deleteTradeIn()`

Delete Trade In

#### Return

**Type**

String

**Description**

String


**Method** deleteTradeIn

### `deleteDeal()`

Delete the deal record

#### Return

**Type**

String

**Description**

String


**Method** deleteDeal

### `getParts()`
### `getPicklistFieldDescribe()`
#### Return

**Type**

void

**Description**

void


**Method** getPicklistFieldDescribe

### `getServiceContractPicklistValues()`
#### Return

**Type**

string

**Description**

string


**Method** getServiceContractPicklistValues

### `getconversionMFGPicklistValues()`
#### Return

**Type**

string

**Description**

string


**Method** getconversionMFGPicklistValues

### `getAvailableContractSoql()`
#### Return

**Type**

string

**Description**

string


**Method** getAvailableContractSoql

### `getmyDeskingSettings()`
#### Return

**Type**

String

**Description**

String


**Method** getmyDeskingSettings

### `static setDisplayAsGross(String onoff)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`onoff`||


**Method** setDisplayAsGross

### `static setCustomDisplay()`

`REMOTEACTION`

**Method** setCustomDisplay description

### `getAvailableContracts()`

Return list of available Service contracts for warranty tab

#### Return

**Type**

string

**Description**

string


**Method** getAvailableContracts

### `getAvailableContractCount()`
#### Return

**Type**

string

**Description**

string


**Method** getAvailableContractCount

### `getDiscountTemplates()`

Discount objects read from Database

#### Return

**Type**

string

**Description**

string


**Method** getDiscountTemplates

### `getRebates()`
#### Return

**Type**

string

**Description**

string


**Method** getRebates

### `getDiscounts()`

Discount objects read from Database

#### Return

**Type**

string

**Description**

string


**Method** getDiscounts

### `updateDiscount()`
#### Return

**Type**

string

**Description**

string


**Method** updateDiscount

### `destroyDiscount()`
#### Return

**Type**

string

**Description**

string


**Method** destroyDiscount

### `getGrossItems()`
#### Return

**Type**

String

**Description**

String


**Method** getGrossItems

### `getTaxTemplates()`

Discount objects read from Database

#### Return

**Type**

string

**Description**

string


**Method** getTaxTemplates

### `dealTaxes()`
#### Return

**Type**

List&lt;dealer__Deal_Tax__c&gt;

**Description**

List &lt; dealer__Deal_Tax__c &gt;


**Method** dealTaxes

### `getDealTaxes()`

Deal Tax objects read from Database

#### Return

**Type**

string

**Description**

string


**Method** getDealTaxes

### `getDealMiscTaxes()`
#### Return

**Type**

string

**Description**

string


**Method** getDealMiscTaxes

### `getReadTaxItems()`
#### Return

**Type**

String

**Description**

String


**Method** getReadTaxItems

### `deleteTaxTansactionItem()`
#### Return

**Type**

String

**Description**

String


**Method** deleteTaxTansactionItem

### `upsertTaxTransactionItem()`

String

#### Return

**Type**

String

**Description**

String


**Method** upsertTaxTransactionItem

### `upsertTaxLine()`
#### Return

**Type**

string

**Description**

string


**Method** upsertTaxLine

### `destroyTaxLine()`
#### Return

**Type**

string

**Description**

string


**Method** destroyTaxLine

### `getTaxZoneSearch()`
#### Return

**Type**

String

**Description**

String


**Method** getTaxZoneSearch

### `taxZonesByZip()`
#### Return

**Type**

List&lt;dealer__Tax_Zones__c&gt;

**Description**

List &lt; dealer__Tax_Zones__c &gt;


**Method** taxZonesByZip

### `getTaxZones()`
#### Return

**Type**

string

**Description**




**Method** getTaxZones

### `getTaxZones(Id taxZoneId)`
#### Parameters

|Param|Description|
|---|---|
|`taxZoneId`||

#### Return

**Type**

dealer__Tax_Zones__c

**Description**

dealer__Tax_Zones__c


**Method** getTaxZones

### `renewTaxLines()`

Called when the tax lines need to be calulated/re-calculated              Updated to use new Tax Methods

#### Return

**Type**

string

**Description**

string


**Method** renewTaxLines

### `getMiscTaxCode()`
### `getmiscChargeCodes()`
### `getPostingTemplates()`

Posting Template Selector

#### Return

**Type**

String

**Description**

String


**Method** getPostingTemplates

### `getSelectedContracts()`

return list of selected contract based on "Contract Template" check box

#### Return

**Type**

string

**Description**

string


**Method** getSelectedContracts

### `deleteContract()`
#### Return

**Type**

String

**Description**

String


**Method** deleteContract

### `insertContract()`
#### Return

**Type**

string

**Description**

string


**Method** insertContract

### `insertAccount()`

method to insert account data

#### Return

**Type**

String

**Description**

String


**Method** insertAccount

### `updateAccounts()`

Inserts or updates and account object passed into the method by URL Parameters.

#### Return

**Type**

String

**Description**

String


**Method** updateAccounts

### `updateContract()`
#### Return

**Type**

String

**Description**

String


**Method** updateContract

### `getFinanceCompany()`
#### Return

**Type**

String

**Description**

String


**Method** getFinanceCompany

### `cloneDeal()`

For creating deep clone of current deal.

#### Return

**Type**

string

**Description**

string


**Method** cloneDeal

### `getLaserForm()`

Get from detail

#### Return

**Type**

String

**Description**

String


**Method** getLaserForm

### `static buildFormRefQuery(Deal__c thisDeal, String printType)`
#### Parameters

|Param|Description|
|---|---|
|`thisDeal`||
|`printType`||

#### Return

**Type**

String

**Description**

String


**Method** buildFormRefQuery

### `getApplicableForms(Deal__c thisDeal)`
#### Parameters

|Param|Description|
|---|---|
|`thisDeal`||

#### Return

**Type**

String

**Description**

String


**Method** getApplicableForms

### `getApplicableForms()`
#### Return

**Type**

String

**Description**

String


**Method** getApplicableForms

### `getImpactForm()`

Get from detail

#### Return

**Type**

String

**Description**

String


**Method** getImpactForm

### `getSelectedImpactForm()`

Get selected Impact from list

#### Return

**Type**

String

**Description**

String


**Method** getSelectedImpactForm

### `getSelectedLaserForm()`

Get selected Impact from list

#### Return

**Type**

String

**Description**

String


**Method** getSelectedLaserForm

### `getcompiledFDF()`

Retreive FDF Blob

#### Return

**Type**

String

**Description**

String


**Method** getcompiledFDF

### `getRecentSalesUps()`

Discount objects read from Database

#### Return

**Type**

string

**Description**

string


**Method** getRecentSalesUps

### `getActiveApproval()`

Get Active Approval Process

#### Return

**Type**

boolean

**Description**

boolean


**Method** getActiveApproval

### `getApprovalIsLocked()`

Check if Approval process is in Progress

#### Return

**Type**

string

**Description**

string


**Method** getApprovalIsLocked

### `refreshButtonPanels()`
#### Return

**Type**

pagereference

**Description**

pagereference


**Method** refreshButtonPanels

### `getApprovalHistory()`
#### Return

**Type**

String

**Description**

String


**Method** getApprovalHistory

### `getSubmitApproval()`
#### Return

**Type**

String

**Description**

String


**Method** getSubmitApproval

### `recallApprovalProcess()`
#### Return

**Type**

pagereference

**Description**

pagereference


**Method** recallApprovalProcess

### `getFilters()`
#### Return

**Type**

string

**Description**

string


**Method** getFilters

### `getFilterMap()`
#### Return

**Type**

Map&lt;string,string&gt;

**Description**

Map &lt; string, string &gt;


**Method** getFilterMap

### `getValue(string value, string type)`

Get/POST variable cleaning

#### Parameters

|Param|Description|
|---|---|
|`value`||
|`type`||

#### Return

**Type**

string

**Description**

string


**Method** getValue

### `getAccountsForNewDeal()`

To read accounts for creating new deal

#### Return

**Type**

string

**Description**

string


**Method** getAccountsForNewDeal

### `createFee()`
#### Return

**Type**

String

**Description**

String


**Method** createFee

### `getDealFees()`
#### Return

**Type**

String

**Description**

String


**Method** getDealFees

### `getFeeTemplates()`
#### Return

**Type**

String

**Description**

String


**Method** getFeeTemplates

### `updateFee()`
#### Return

**Type**

String

**Description**

Sting


**Method** updateFee

### `static refreshDefaultFees(Id dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Return

**Type**

void

**Description**

void


**Method** refreshDefaultFees

### `updateDealFeeTotal(Id dealId)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Return

**Type**

void

**Description**

void


**Method** updateDealFeeTotal

### `destroyFee()`
#### Return

**Type**

String

**Description**

String


**Method** destroyFee

### `static setasPrimaryDeal(String dealId)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** setasPrimaryDeal

### `getPricingStrategy()`
#### Return

**Type**

String

**Description**

String


**Method** getPricingStrategy

### `getSchedulePricing()`
#### Return

**Type**

Boolean

**Description**

Boolean


**Method** getSchedulePricing

---
## Classes
### DealFormWrapper



### DealTRSControllerException



**Inheritance**

DealTRSControllerException


**Descripton** 


### formWrapper
#### Constructors
##### `formWrapper(String documentId, String docType, String content, string mergeData)`
---

---
