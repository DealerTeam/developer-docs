---
layout: default
---
# DealController
## Fields

### `private vehiclePriceFormula` → `String`


---
## Methods
### `public static saveResult save(Deal__c deal)`

`AURAENABLED`

Saves Deal through DealAPI

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`saveResult`|Void|

### `public static Deal__c createDeal(Deal__c deal)`

`AURAENABLED`
### `public static Void closeDeal(Deal__c deal)`

`AURAENABLED`
### `public static String cloneDeal(Id dealId)`

`AURAENABLED`

Clones Deal through DealAPI

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id|

#### Returns

|Type|Description|
|---|---|
|`String`|Void|

### `public static Void saveDeferredDown(String recordId, Deal__c dealToSave)`

`AURAENABLED`

Saves deferred down payments

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String|
|`dealToSave`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`Void`|Void|

### `public static Decimal getDeferredDownTotal(String recordId)`

`AURAENABLED`

Saves Deal through DealAPI

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Void|

### `public static dealData dealData(String dealId)`

`AURAENABLED`

Returns Deal Header Data, Vehicle Inventory Record and Conversion Record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`dealData`|dealData|

### `public static Deal__c getDeal(String dealId)`

`AURAENABLED`

Retrieves Deal Header Data

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|Deal__c|

### `public static Dealer_Location__c getDealLocation(String dealId)`

`AURAENABLED`

Retrieves Deal Location

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|

### `public static UserInformation getUserRecord()`

`AURAENABLED`
### `public static DealerMetadata autoCollapseFinanceApproval()`

`AURAENABLED`

Retrieves DealerteamConfig setting for collapsing an accordion by default on the DealFinance component.

#### Returns

|Type|Description|
|---|---|
|`DealerMetadata`|DealerMetadata.DMSConfigValue for the CollapseFinanceApprovalSection setting|

### `public static Lines serviceContractLines(String dealId)`

`AURAENABLED`

Retrieves Service Contract Lines on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`Lines`|Lines|

### `public static List<Service_Contract__c> availableServiceContracts(String dealId)`

`AURAENABLED`

Retrieves available Service Contract lines for a deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Contract__c>`|List<Service_Contract__c>|

### `public static List<Service_Contract__c> selectedServiceContracts(String dealId)`

`AURAENABLED`

Retrieves Service Contracts on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Contract__c>`|List<Service_Contract__c>|

### `public static Lines equipmentLines(String dealId, Boolean restrictFit)`

`AURAENABLED`

Retrieves Available Equipment and Selected Equipment on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`Lines`|Lines|

### `public static List<Parts_Kit__c> availablePartsKits(String dealId, Boolean restrictFit)`

`AURAENABLED`

Retrieves available Parts Kits for Deal records

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Kit__c>`|List<Parts_Kit__c>|

### `public static List<Trade_In__c> assignStockToTrade(List<Trade_In__c> trades)`

`AURAENABLED`

assigns the stock number based on VehicleInventoryAPI

#### Parameters

|Param|Description|
|---|---|
|`trades`|trades description|

#### Returns

|Type|Description|
|---|---|
|`List<Trade_In__c>`|return description|


**Method** assignStockToTrade description

### `private static List<Parts_Kit__c> partsKitsByFitGuide(String dealId, List<String> partsKitIds, List<Parts_Kit__c> allKits)`

filters provided parts kits and returns only those matching fit guide criteria

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|
|`partsKitIds`|partsKitIds description|
|`allKits`|allKits description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Kit__c>`|return description|


**Method** partsKitsByFitGuide

### `public static List<After_Market__c> selectedAfterMarkets(String dealId)`

`AURAENABLED`

Retrieves selected After Market records for a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|List<After_Market__c>|

### `public static List<Kit> selectedKits(Id dealId, List<String> kitIds)`

`AURAENABLED`
### `public static List<After_Market__c> kitItems(String kitId, String dealId)`

`AURAENABLED`

Retrieves items in part of a Parts Kit

#### Parameters

|Param|Description|
|---|---|
|`kitId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|List<After_Market__c>|

### `public static Parts_Kit__c getKitRecord(String kitId)`

`AURAENABLED`
### `public static List<Parts_Kit__c> searchPartsKits(String searchJSON, String dealId, Boolean restrictFit)`

`AURAENABLED`

Searches for Parts Kits using the serialized JSON of a partKitFilter Class

#### Parameters

|Param|Description|
|---|---|
|`searchJSON`|JSON version of the partKitFilter class|
|`dealId`|Id of the deal to find associated aftermarket records|
|`restrictFit`|equipment will be restricted to follow fit guide matching if true|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Kit__c>`|List<Parts_Kit__c>|

### `public static void addPartsKit(String dealId, String pkId)`

`AURAENABLED`

Adds a Parts Kit to a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|
|`pkId`|String|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static String addPart(String dealId, String PartBodyJSON)`

`AURAENABLED`

Adds a Part Aftermarket to a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|
|`partBodyJSON`|JSON DealAPI.PartAddition String|

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static Vehicle_Inventory__c getVehicle(String vehicleId)`

`AURAENABLED`

Retrieves Vehicle record associated to a Deal

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|String|

#### Returns

|Type|Description|
|---|---|
|`Vehicle_Inventory__c`|Vehicle_Inventory__c|

### `public static Decimal evaluateVehiclePriceFormula(Id vehicleToEvaluate)`

`AURAENABLED`

getVehiclePriceFormula returns the evaluted decimal value of the VehiclePriceFormula MDT Config

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return evaluated decimal|

### `public static DealVehicle getDealVehicle(String dealId, String vehicleId)`

`AURAENABLED`

Retrieves Vehicle record associated to a Deal

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|String|

#### Returns

|Type|Description|
|---|---|
|`DealVehicle`|Vehicle_Inventory__c|

### `public static dealer__VehicleModel__c getVehicleMaster(String masterId)`

`AURAENABLED`

Retrieves Vehicle record associated to a Deal

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|String|

#### Returns

|Type|Description|
|---|---|
|`dealer__VehicleModel__c`|dealer__VehicleModel__c|

### `public static List<Deal__c> vehicleData(String dealId)`

`AURAENABLED`

Returns Deal Vehicle and Deal Conversion data

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Deal__c>`|List<Deal__c>|

### `public static List<Sales_Fee__c> addedFees(String dealId)`

`AURAENABLED`

Retrieves Sales Fees added to a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Sales_Fee__c>`|List<Sales_Fee__c>|

### `public static List<DealershipLocationAPI.AuraFee> feeTemplates(String dealId)`

`AURAENABLED`

Retrieves Available Fee Templates from the Location record on a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`List<DealershipLocationAPI.AuraFee>`|List<DealershipLocationAPI.AuraFee>|

### `public static void refreshDefaultFees(String dealId)`

`AURAENABLED`

Wipes out Fees and creates default Fees for a Deal.

#### Parameters

|Param|Description|
|---|---|
|`dealId`||

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static void saveDealAdds(String dealId, List<SObject> dealAdds)`

`AURAENABLED`

Saves deal discounts and updates deal add on objects (fees, contracts, etc.)

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to discount|
|`dealAdds`|- list of discount sObjects related to deal|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static List<Discount_Rebate__c> getDiscounts(String dealId)`

`AURAENABLED`

Acquires Discounts applied to a Deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public static List<LookupSearchResult> discountTypePicklist()`

`AURAENABLED`

Retrieves Picklist Values for Discount Types

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `private static void applyDiscounts(String dealId)`

Applies any discount logic to a Deal.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`void`|Void|

### `public static List<Discount_Rebate__c> getRebates(String dealId)`

`AURAENABLED`

Retrieves Rebates for a Deal record.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public static List<Discount_Rebate__c> getDiscountTemplates()`

`AURAENABLED`

Retrieves Discount Templates available for Deal records

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c> templates|

### `public static List<TaxTransactionItem__c> getTaxes(String dealId)`

`AURAENABLED`

Retrives Tax Transaction Items on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<TaxTransactionItem__c>`|List<TaxTransactionItem__c>|

### `public static void updateTaxItem(TaxTransactionItem__c taxItem)`

`AURAENABLED`

updateTaxItem updates the provided tax transaction item and saves the deal to get updated values

#### Parameters

|Param|Description|
|---|---|
|`taxItem`|item to be updated must include populated DealTax__c field|

### `public static void refreshTaxItems(String dealId)`

`AURAENABLED`

refreshTaxItems used to perform lighter deal refresh when only tax updates are needed

#### Parameters

|Param|Description|
|---|---|
|`dealId`||

### `public static List<Trade_In__c> getTrades(String dealId)`

`AURAENABLED`

Returns list of trade in records related to the passed deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId|

#### Returns

|Type|Description|
|---|---|
|`List<Trade_In__c>`|List<Trade_In__c>|

### `public static Trade_In__c getTrade(String tradeId)`

`AURAENABLED`

Returns a trade in record by the passed trade Id

#### Parameters

|Param|Description|
|---|---|
|`tradeId`|tradeId|

#### Returns

|Type|Description|
|---|---|
|`Trade_In__c`|Trade_In__c|

### `public static String saveTrade(Trade_In__c trade)`

`AURAENABLED`
### `public static Service_Vehicle__c handleDecode(String VIN)`

`AURAENABLED`

Retrieves basic information from a provided VIN

#### Parameters

|Param|Description|
|---|---|
|`VIN`|String|

#### Returns

|Type|Description|
|---|---|
|`Service_Vehicle__c`|Service_Vehicle__c|

### `public static Appraisal__c getServiceVehicleInfo(String appId)`

`AURAENABLED`

Retrieves vehicle information from the service vehicle of a provided appraisal

#### Parameters

|Param|Description|
|---|---|
|`appId`|appId Appraisal__c Id to query for service vehicle info|

#### Returns

|Type|Description|
|---|---|
|`Appraisal__c`|return Appraisal with Service_Vehicle__c fields if one exists, else null|

### `public static evaluatedFee getAndEvaluateFee(String dealId, String feeId)`

`AURAENABLED`
### `public static List<LookupSearchResult> locationFeeRecent(String dealId)`

`AURAENABLED`
### `public static List<LookupSearchResult> searchVehicleInventory(String searchTerm)`

`AURAENABLED`

Searches for VehicleInventory

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<LookupSearchResult> recentVehicles()`

`AURAENABLED`

Returns recently viewed Vehicle records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> recentFinanceCompanies()`

`AURAENABLED`
### `public static List<LookupSearchResult> selectedFinancieCompany(String dealId)`

`AURAENABLED`
### `public static List<LookupSearchResult> searchFinanceCompanies(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> recentEquipmentMaster()`

`AURAENABLED`
### `public static List<LookupSearchResult> searchEquipmentMaster(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> selectedEquipmentMaster(String equipmentId)`

`AURAENABLED`
### `public static SalesUpAPI getSalesUp(Id supId)`

`AURAENABLED`
### `public static List<LookupSearchResult> recentSups()`

`AURAENABLED`
### `public static List<LookupSearchResult> searchSalesUps(String searchTerm)`

`AURAENABLED`

Searches for Sales Ups

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<LookupSearchResult> selectedVehicle(String dealId)`

`AURAENABLED`

Retrieves selected Vehicle on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> lookupVehicleResult(String vehId)`

`AURAENABLED`

Retrieves vehicle lookupsearchresult for given vehicle id

#### Parameters

|Param|Description|
|---|---|
|`vehId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> recentAppraisals(String dealId)`

`AURAENABLED`

Returns recently viewed Appraisal records

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchAppraisals(String searchTerm)`

`AURAENABLED`

Searches for Appraisals

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<LookupSearchResult> selectedAppraisal(String appId)`

`AURAENABLED`

Retrieves selected Appraisal on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`appId`|String appraisal Id|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> recentPricingStrategy()`

`AURAENABLED`

Retrieves recently viewed Pricing Strategies

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchPricingStrategy(String searchTerm)`

`AURAENABLED`

Searches for Pricing Strategies

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> selectedPricingStrategy(String dealId)`

`AURAENABLED`

Retrieves the selected Pricing Strategy on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> selectedLocation(String locId)`

`AURAENABLED`

Retrieves the selected Location by given location Id

#### Parameters

|Param|Description|
|---|---|
|`locId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|


**Method** selectedLocation

### `public static List<LookupSearchResult> recentTaxZoneResult(String dealId)`

`AURAENABLED`

Retrieves recent Tax Zones

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchTaxZone(String dealId, String searchTerm)`

`AURAENABLED`

Searches Tax Zones

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> selectedDealTaxZone(String dealId)`

`AURAENABLED`

Retrieves selected Tax Zone on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static String afterMarketQuery()`

Builds After Market Query

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static MiscChargeCode__c getMiscChargeCode(String recordId)`

`AURAENABLED`
### `public static String kitQuery()`

Builds Part Kit Query

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static String kitItemQuery(String kitId)`

Builds Part Kit Item Query

#### Parameters

|Param|Description|
|---|---|
|`kitId`|String|

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static dealOutline dealOutline(String dealId)`

`AURAENABLED`

Retrieves Deal Outline Data

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String|

#### Returns

|Type|Description|
|---|---|
|`dealOutline`|DealOutline|

### `public static List<dealer__Deal__c> getRelatedDeals(Id dealId)`

`AURAENABLED`

Returns a list of deals with the same sales up as the provided deal id

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of deal used to find a sales up with related deals|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Deal__c>`|list of deals related to the sales up, excluding the provided deal id|

### `public static Boolean getPrimary(Id dealId)`

`AURAENABLED`

getPrimary returns a boolean based on whether or not the dealId matches the deal in the associated sales up Car_Deal__c field.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the deal to find a sales up and match to car_deal__c field|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true if deal matches car_deal__c field on the sales up of the deal, otherwise false|

### `public static Boolean makePrimary(Id dealId)`

`AURAENABLED`
### `public static Boolean getConversion(Id dealId)`

`AURAENABLED`

getConversion returns a boolean based on  the deal dealer__ConversionDeal__c field is true or false

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the deal to|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|boolean on dealer__ConversionDeal__c if it exists otherwise return false|

### `public static Boolean setConversion(Id dealId)`

`AURAENABLED`

setConversion acts as a swtich on the deal dealer__ConversionDeal__c field

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the deal to|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|boolean on dealer__ConversionDeal__c if it exists otherwise return false|

### `public static List<picklistWrapper> getDealTypes(String dealId)`

`AURAENABLED`

getDealTypes returns Deal_Type__c options for the given deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|used to determine current deal type which is removed from return|

#### Returns

|Type|Description|
|---|---|
|`List<picklistWrapper>`|picklistWrapper class which has label and value properties required to display in lightning-combobox in lwc|

### `public static Boolean buyerB2BAccount(String dealId)`

`AURAENABLED`

buyerB2BAccount returns true if the buyer account on the provided deal is not person type

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to evaluate|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true if buyer is not person type, false if person, null if blank|

### `public static Boolean coBuyerB2BAccount(String dealId)`

`AURAENABLED`

coBuyerB2BAccount returns true if the co buyer account on the provided deal is not person type

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to evaluate|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true if co buyer is not person type, false if person, null if blank|

### `public static Boolean buyersUpdatable(String dealId)`

`AURAENABLED`

buyersUpdatable checks deal to determine if the current user is able to update buyer and co buyer fields

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to evaluate|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true if user can update both buyer__c and co_buyer__c fields else false|

### `public static void swapBuyers(String dealId)`

`AURAENABLED`

swapBuyers switches values on co-buyer and buyer fields as well as saveToAccount preference for each

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to swap co buyer and buyers|

### `public static void removeCoBuyer(String dealId)`

`AURAENABLED`

removeCoBuyer sets all co-buyer fields to null for the given deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|deal to remove co buyer from|

### `public static dealer__Deal__c getDealInfo(Id dealId)`

`AURAENABLED`

getDealInfo returns a list of deals with the same sales up as the provided deal id

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of deal used to find all fields|

#### Returns

|Type|Description|
|---|---|
|`dealer__Deal__c`|deal with all fields queried|

### `public static Deal__c updateOrder(dealer__Deal__c updateObj)`

`AURAENABLED`

updateOrder performs DML update on passed deal

#### Parameters

|Param|Description|
|---|---|
|`updateObj`|updateObj deal to update|

### `public static string getPrimaryImage(Id vehId)`

`AURAENABLED`

getPrimaryImage returns the first inventory image related to a vehicle inventory record

#### Parameters

|Param|Description|
|---|---|
|`vehId`|vehId vehicle inventory id used to retrieve images|

#### Returns

|Type|Description|
|---|---|
|`string`|return URL to the image|

### `public static Equipment_Master__c getEquipmentMasterData(Id emId)`

`AURAENABLED`

getEquipmentMasterData returns equipment master fields to use as default values when creating a new equipment inventory record

#### Parameters

|Param|Description|
|---|---|
|`emId`|emId Equipment Master record Id|

#### Returns

|Type|Description|
|---|---|
|`Equipment_Master__c`|return Equipment_Master__c with field data to use for defaults|

### `public static string getRecordTypeId()`

`AURAENABLED`

getRecordTypeId Returns the recordTypeId of the Order Record Type for Equipment Inventory

#### Returns

|Type|Description|
|---|---|
|`string`|return Order recordTypeId|

### `public static String saveOrder(EquipmentInventory__c ei, String dealId)`

`AURAENABLED`

saveOrder Creates new Equipment Inventory and removes old one from deal if it is record type order

#### Parameters

|Param|Description|
|---|---|
|`ei`|ei New Equipment Inventory order|
|`dealId`|dealId Associated deal|

#### Returns

|Type|Description|
|---|---|
|`String`|return true if no exceptions|

### `public static Boolean checkOrderType(String eiId)`

`AURAENABLED`

checkOrderType returns true if the passed EquipmentInventory__c record is of record type Order

#### Parameters

|Param|Description|
|---|---|
|`eiId`|eiId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public static void deleteOrder(String eiId)`

`AURAENABLED`

deleteOrder Deletes the EquipmentInventory__c record if it is of record type Order

#### Parameters

|Param|Description|
|---|---|
|`eiId`|eiId description|

### `public static List<EquipmentInventory__c> getEquipmentInventory(String eiId)`

`AURAENABLED`

getEquipmentInventory Gets all inventory type equipmentInventory__c records if parameter is null, else gets fields from the provided record id

#### Parameters

|Param|Description|
|---|---|
|`eiId`|eiId The equipmentInventory__c record id to query, or null by design for all records|

#### Returns

|Type|Description|
|---|---|
|`List<EquipmentInventory__c>`|return List<EquipmentInventory__c>|

### `public static String saveEquipmentToDeal(String dealId, String eqId)`

`AURAENABLED`

saveEquipmentToDeal Accepts a deal Id and equipment inventory id. Updates the deal with equipmentInventory__c lookup field set to the provided id

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId Deal to update|
|`eqId`|eqId Equipment Inventory to add to deal|

#### Returns

|Type|Description|
|---|---|
|`String`|return equipmentInventory__c Id if update is successful|

### `public static List<Equipment_Master__c> getEquipmentMasters(String emId)`

`AURAENABLED`

getEquipmentMasters Gets all equipment masters if parameter is null, else returns a specific equipment master from provided Id

#### Parameters

|Param|Description|
|---|---|
|`emId`|emId Equipment_Master__c Id to query or null by design|

#### Returns

|Type|Description|
|---|---|
|`List<Equipment_Master__c>`|return List<Equipment_Master__c>|

### `public static Deal__c getDealDRO(String dealId)`

`AURAENABLED`
### `public static Id createDeliveryRepairOrder(String dealId)`

`AURAENABLED`
### `public static FinanceAPI financeTable(String dealId, Decimal down, Decimal rate, Decimal increment)`

`AURAENABLED`

Returns Finance Table

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the Deal, used to retrieve data needed for calculations|
|`down`|Down Payment|
|`rate`|Interest Rate|
|`increment`|Increment of the down payment|

#### Returns

|Type|Description|
|---|---|
|`FinanceAPI`|FinanceAPI.financeTable|

### `public static List<Finance_Company__c> getFinanceCompany(Id fId)`

`AURAENABLED`
### `public static List<LookupSearchResult> recentKitCategoryResult(String categoryType)`

`AURAENABLED`

Retrieves recent Kit Category

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchKitCategories(String searchTerm, String categoryType)`

`AURAENABLED`

Parts Kit Categories

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|
|`categoryType`|String category to match against type picklist on the category records|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> selectedKitCategory(String catId)`

`AURAENABLED`

Retrieves selected Parts Kit Category record

#### Parameters

|Param|Description|
|---|---|
|`catId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static Decimal getAROutstanding(Id dealId)`

`AURAENABLED`

Get AR balance from Accounting and return the value of it

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|

---
## Classes
### saveResult
#### Constructors
##### `public saveResult(Deal__c deal, downPaymentResult dpr)`
---
#### Fields

##### `public deal` → `Deal__c`

`AURAENABLED` 

##### `public downPaymentResult` → `downPaymentResult`

`AURAENABLED` 

---

### downPaymentResult
#### Constructors
##### `public downPaymentResult()`
##### `public downPaymentResult(Boolean dpf, String fieldName)`
---
#### Fields

##### `public downPaymentFlag` → `boolean`

`AURAENABLED` 

##### `public fieldName` → `String`

`AURAENABLED` 

---

### UserInformation
#### Constructors
##### `public UserInformation()`
---
#### Fields

##### `public user` → `User`

`AURAENABLED` 

##### `public assignedLocation` → `Dealer_Location__c`

`AURAENABLED` 

---

### Kit
#### Constructors
##### `public Kit(After_Market__c header, List&lt;After_Market__c&gt; kitItems)`
---
#### Fields

##### `public itemCount` → `Integer`

`AURAENABLED` 

##### `public kitPrice` → `Decimal`

`AURAENABLED` 

##### `public kitCost` → `Decimal`

`AURAENABLED` 

##### `public description` → `String`

`AURAENABLED` 

##### `public header` → `After_Market__c`

`AURAENABLED` 

##### `public items` → `List&lt;After_Market__c&gt;`

`AURAENABLED` 

---

### DealVehicle
#### Constructors
##### `public DealVehicle(String dealId, String vehicleId)`
---
#### Fields

##### `public taxVehicle` → `Boolean`

`AURAENABLED` 

##### `public taxConversion` → `Boolean`

`AURAENABLED` 

##### `public vehicle` → `Vehicle_Inventory__c`

`AURAENABLED` 

---

### evaluatedFee
#### Constructors
##### `public evaluatedFee(LocationFee__c fee, Decimal defaultPrice, Decimal defaultCost)`
---
#### Fields

##### `public fee` → `LocationFee__c`

`AURAENABLED` 

##### `public defaultPrice` → `Decimal`

`AURAENABLED` 

##### `public defaultCost` → `Decimal`

`AURAENABLED` 

---

### picklistWrapper
#### Constructors
##### `public picklistWrapper(String lab, String val)`
---
#### Properties

##### `public label` → `string`

`AURAENABLED` 

##### `public value` → `string`

`AURAENABLED` 

---

### dealData

DealData Wrapper Class

#### Constructors
##### `public dealData(Deal__c deal, Vehicle_Inventory__c vehicle, Parts_Kit__c conversion)`
---
#### Fields

##### `public deal` → `Deal__c`

`AURAENABLED` 

##### `public vehicle` → `Vehicle_Inventory__c`

`AURAENABLED` 

##### `public conversion` → `Parts_Kit__c`

`AURAENABLED` 

---

### dealOutline

Deal Outline Wrapper Class

#### Constructors
##### `public dealOutline()`
---
#### Fields

##### `public deal` → `Deal__c`

`AURAENABLED` 

##### `public location` → `Dealer_Location__c`

`AURAENABLED` 

##### `public vehicle` → `Vehicle_Inventory__c`

`AURAENABLED` 

##### `public conversion` → `Parts_Kit__c`

`AURAENABLED` 

##### `public equipment` → `List&lt;After_Market__c&gt;`

`AURAENABLED` 

##### `public contracts` → `List&lt;Service_Contract__c&gt;`

`AURAENABLED` 

##### `public fees` → `List&lt;Sales_Fee__c&gt;`

`AURAENABLED` 

##### `public discounts` → `List&lt;Discount_Rebate__c&gt;`

`AURAENABLED` 

##### `public taxes` → `List&lt;TaxTransactionItem__c&gt;`

`AURAENABLED` 

##### `public rebates` → `List&lt;Discount_Rebate__c&gt;`

`AURAENABLED` 

##### `public imageUrl` → `String`

`AURAENABLED` 

##### `public kits` → `List&lt;Kit&gt;`

`AURAENABLED` 

##### `public trades` → `List&lt;Trade_In__c&gt;`

`AURAENABLED` 

---

### partKitFilter

Part Kit Advanced Search Wrapper Class

#### Fields

##### `public term` → `string`


##### `public MFG` → `string`


##### `public category` → `string`


##### `public subCategory` → `string`


---

### Lines

Lines for the Selector component Wrapper Class

#### Constructors
##### `public Lines(List&lt;sObject&gt; availableLines, List&lt;sObject&gt; selectedLines)`
---
#### Fields

##### `public availableLines` → `List&lt;Sobject&gt;`

`AURAENABLED` 

##### `public selectedLines` → `List&lt;Sobject&gt;`

`AURAENABLED` 

---

---
