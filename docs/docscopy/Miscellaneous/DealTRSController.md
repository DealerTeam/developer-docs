---
layout: default
---
# DealTRSController class

@description

---
## Constructors
### `DealTRSController()`

Constructor with no standard controller (not loaded via VF Pgae)
### `DealTRSController(ApexPages.StandardController controller)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `action` → `String`

@description

### `casheirRecordId` → `Id`

@description

### `dealRecord` → `dealer__Deal__c`

@description

### `deskingComponentConfiguration` → `dealer__DeskingComponentConfiguration__mdt>`

@description

### `deskingConfig` → `DeskingConfiguration__mdt`

Configration and custom setting values

### `deskingSubTabConfig` → `List<DeskingSubtabConfiguration__mdt>`

@description

### `isCobuyerSearch` → `boolean`

@description

### `mySettings` → `DeskingUserSetting__c`

@description

### `pageNumber` → `Integer`

@description

### `pageSize` → `Integer`

@description

### `processInstanceId` → `string`

@description

### `relatedDeals` → `>`

@description

### `retJSON` → `String`

@description

### `salesup` → `dealer__Sales_Up__c`

@description

### `searchQuery` → `String`

@description

### `urlParams` → `>`

@description

---
## Methods
### `buildFormRefQuery(Deal__c thisDeal, String printType)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |
|`` | e |

### `checkRoQueue(String dealId, String jobId)` → `dealer__Service_Repair_Order__c`

 checkRoQueue

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | d |

### `cloneDeal()` → `string`

For creating deep clone of current deal.

### `closeDeal(String dealId)` → `boolean`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `componentConfiguration(String configApiName)` → `DeskingComponentConfiguration__mdt>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `config(String apiName)` → `DeskingConfiguration__mdt`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `createAppraisalFromTrade(dealer__Trade_In__c trade)` → `dealer__Appraisal__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `createAppraisalVehicle(Id appraisalId, dealer__Trade_In__c trade)` → `dealer__Appraisal_Vehicle__c`

 createAppraisalVehicle

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | e |

### `createCashierEntry()` → `String`
### `createDeliveryRepairOrder(String dealId)` → `Id`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `createNewDealForms(String dealForms)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `createTradeIn()` → `String`

Create Trade In record

### `crudAction()` → `PageReference`

router for all action calls

### `dealTaxes()` → `>`
### `deleteAfterMarket()` → `String`

Delete After Market

### `deleteCashierEntry()` → `String`
### `deleteContract()` → `String`
### `deleteDeal()` → `String`

Delete the deal record

### `deleteImpactDealForm()` → `String`
### `deleteLaserDealForm()` → `String`
### `deleteTaxTansactionItem()` → `String`
### `deleteTradeIn()` → `String`

Delete Trade In

### `destroyDiscount()` → `string`
### `destroyTaxLine()` → `string`
### `doHttpRequest(string body, boolean isSave)` → `string`

 doHttpRequest

#### Parameters
|Param|Description|
|-----|-----------|
|`` | y |
|`` | e |

### `getAccountRead()` → `>`

Read account by SOSL

### `getAccountReadById()` → `>`

Read Account by Id/No Id

### `getAccountReadLookup()` → `String`

Get Account for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

### `getAfterMarkets()` → `String`
### `getApplicableForms(Deal__c thisDeal)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | l |

### `getApplicableForms()` → `String`
### `getAppraisalRead()` → `>`

Read dealer__Appraisal_Vehicle__c by SOSL. this implementation was never complete ?

### `getAppraisalReadById(String customerId)` → `>`

Read dealer__Appraisal_Vehicle__c by Id/No Id.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getAppraisalReadLookup()` → `String`

Get dealer__Appraisal_Vehicle__c for Lookup. IF we have a CustID execute based on ID, else Based on No ID .

### `getAppraisalsWithVehicle()` → `String`
### `getAvailableContractCount()` → `string`
### `getAvailableContractSoql()` → `string`
### `getAvailableContracts()` → `string`

Return list of available Service contracts for warranty tab

### `getBuyerAccount()` → `string`
### `getCashierAccountRead()` → `String`
### `getCategoryRead(string type)` → `>`

Get the Conversion Kit Lookups

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `getCategoryReadById(string type)` → `>`

Read dealer__Kit_Category__c by Id/No Id

#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `getCategoryReadLookup()` → `String`

Get Category for lookup

### `getDeal()` → `String`

Get the deal record

### `getDealContentDocuments()` → `string`

Lookups documents linked to the Deal

### `getDealKeyPrefix()` → `String`

gets the deal object key prefix

### `getDealMiscTaxes()` → `string`
### `getDealRecord()` → `>`
### `getDealStatusValues()` → `String`
### `getDealTaxes()` → `string`

Deal Tax objects read from Database

### `getDealTypeValues()` → `String`
### `getDefaultStatusValue()` → `String`
### `getDiscountTemplates()` → `string`

Discount objects read from Database

### `getDiscounts()` → `string`

Discount objects read from Database

### `getFinanceCompany()` → `String`
### `getGrossItems()` → `String`
### `getImageVehicle()` → `String`

Image Inventory of current vehicle

### `getLaserForm()` → `String`

Get from detail

### `getLocationRead()` → `>`

Read Location by SOSL

### `getLocationReadById()` → `>`

Read Location by Id/No Id

### `getLocationReadLookup()` → `String`

Lookup for pick Location. IF we have a CustID execute based on ID, else Based on No ID.

### `getMiscTaxCode()` → `string`
### `getPartKitCount()` → `String`
### `getPartKitSoql()` → `String`
### `getPartKits()` → `String`
### `getParts()` → `string`

 @debug This method is incorrectly calling the dealer__Parts_Inventory__c object. It should instead be calling the Parts_Master__c object and returning the appropriate values.

### `getPdfBody(List < dealer__Form__c > lstOfForms)` → `string`

Get Merge PDF body

### `getPicklistFieldDescribe()` → `void`
### `getPicklistValues()` → `String`

Retrieve Picklist Values

### `getPostingTemplates()` → `String`

Posting Template Selector

### `getReadTaxItems()` → `String`
### `getRebates()` → `string`
### `getSelectedContracts()` → `string`

return list of selected contract based on "Contract Template" check box

### `getSelectedForm()` → `String`
### `getSerVehicleRead()` → `>`

Read dealer__Service_Vehicle__c by SOSL

### `getSerVehicleReadById()` → `>`

Read dealer__Service_Vehicle__c by Id/No Id

### `getSerVehicleReadLookup()` → `String`

Get Service Vehicle for Lookup. IF we have a CustID execute based on ID, else Based on No ID.

### `getServiceContractPicklistValues()` → `string`
### `getTaxTemplates()` → `string`

Discount objects read from Database

### `getTaxZoneSearch()` → `String`
### `getTaxZones()` → `string`
### `getTaxZones(Id taxZoneId)` → `dealer__Tax_Zones__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getTradeIns()` → `string`
### `getUserJson(List < User > u)` → `string`
### `getUserRead()` → `>`

Read User by SOSL

### `getUserReadById()` → `>`

Read User by Id/No Id

### `getUserReadLookup()` → `String`

performs the server side searching for the user inputs

### `getVehicleRead()` → `>`
### `getVehicleReadById()` → `>`

Read dealer__Vehicle_Inventory__c by Id/No Id

### `getVehicleReadLookup()` → `String`

Get Vehicle for Lookup - IF we have a CustID execute based on ID, else Based on No ID

### `getcashierOptions()` → `String`
### `getconversionMFGPicklistValues()` → `string`
### `getmiscChargeCodes()` → `string`
### `getmyDeskingSettings()` → `String`
### `getreadCashier()` → `String`
### `getreadCashierRow()` → `String`
### `insertAccount()` → `String`

method to insert account data

### `insertContract()` → `string`
### `insertUserSettings(Id userId)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `loadRelatedDeals()` → `>`

used to set a list of related deals when the controller is instantiated.

### `newDeliveryRO(String dealId)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `printFormBundle(Id dealId, List<String> formIds)` → `String`

 printFormBundle

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | s |

### `removeSuggestedForm(Id dealId, Id formId)` → `string`

 removeSuggestedForm

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | d |

### `renewTaxLines()` → `string`

Called when the tax lines need to be calulated/re-calculated Updated to use new Tax Methods

### `selectedAccount(String accId)` → `Account`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `setCustomDisplay()` → `void`
### `setDisplayAsGross(String onoff)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | f |

### `subTabConfig(String configApiName)` → `List<DeskingSubtabConfiguration__mdt>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `taxZonesByZip()` → `>`
### `updateAccounts()` → `String`

Inserts or updates and account object passed into the method by URL Parameters.

### `updateBuyerAccount()` → `Boolean`
### `updateCashierEntry()` → `String`
### `updateCoBuyerAccount()` → `Boolean`
### `updateContract()` → `String`
### `updateDeal()` → `String`
### `updateDiscount()` → `string`
### `updateTradeIn()` → `String`

Update Trade In

### `upsertAfterMarket()` → `String`

Create After Market record

### `upsertTaxLine()` → `string`
### `upsertTaxTransactionItem()` → `String`

String

### `userSettings(Id userId)` → `DeskingUserSetting__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

---
## Inner Classes

### DealTRSController.DealFormWrapper class

@description

---
#### Methods
##### `createFee()` → `String`
##### `createSalesUp()` → `String`
##### `destroyFee()` → `String`
##### `getAccountsForNewDeal()` → `string`

To read accounts for creating new deal

##### `getActiveApproval()` → `boolean`

Get Active Approval Process

##### `getApprovalHistory()` → `String`
##### `getApprovalIsLocked()` → `string`

Check if Approval process is in Progress

##### `getDealFees()` → `String`
##### `getFeeTemplates()` → `String`
##### `getFilterMap()` → `>`
##### `getFilters()` → `string`
##### `getImpactForm()` → `String`

Get from detail

##### `getPricingStrategy()` → `String`
##### `getRecentSalesUps()` → `string`

Discount objects read from Database

##### `getSchedulePricing()` → `Boolean`
##### `getSelectedImpactForm()` → `String`

Get selected Impact from list

##### `getSelectedLaserForm()` → `String`

Get selected Impact from list

##### `getSubmitApproval()` → `String`
##### `getValue(string value, string type)` → `string`

Get/POST variable cleaning

###### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | e |

##### `getcompiledFDF()` → `String`

Retreive FDF Blob

##### `recallApprovalProcess()` → `pagereference`
##### `refreshButtonPanels()` → `pagereference`
##### `refreshDefaultFees(Id dealId)` → `void`
###### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

##### `setasPrimaryDeal(String dealId)` → `boolean`
###### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

##### `updateDealFeeTotal(Id dealId)` → `void`
###### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

##### `updateFee()` → `String`
---
### DealTRSController.DealTRSControllerException class

 @descripton

---
### DealTRSController.formWrapper class

@description

---
#### Constructors
##### `formWrapper(String documentId, String docType, String content, string mergeData)`
---
