---
layout: default
---
# DealAPI class

 	DealAPI provides service layer logic for processing requests related to the Deal Records

---
## Methods
### `addDealForms(Id dealId, List<String> formIds)` → `void`

 Adds Forms to a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |
|`formIds` |  List<String> |

### `applicableForms(String dealId)` → `List<Form__c>`

 Retrieves forms Applicable to a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  String |

### `applyDiscounts(Deal__c deal)` → `void`

 Applies Discount logic to a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`deal` |  Deal__c |

### `availableForms(String dealId)` → `List<Form__c>`

 Acquires forms available to a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `cashTransactions(String dealId)` → `List<Cashering__c>`

 Retrieves Cash Transaction Items on a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  String |

### `cloneDeal(Id dealId)` → `String`

 Clones a Deal Record

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  dealId |

### `closeDealProcess(List<Deal__c> deals)` → `void`

 Processes the closure of a Deal Record

#### Parameters
|Param|Description|
|-----|-----------|
|`deals` |  List<Deal__c> |

### `closeDeals(List<Deal__c> deals)` → `void`

 This routine will close deals and mark associated records as closed/won

#### Parameters
|Param|Description|
|-----|-----------|
|`deals` |  List<Deal__c> |

### `create(deal dealData)` → `Deal__c`

 Creates a Deal Record

#### Parameters
|Param|Description|
|-----|-----------|
|`dealData` |  DealAPI.deal |

### `createAfterMarketItems(Id pkId, Deal__c deal)` → `void`

 Creates After Market items on the deal from a conversion on the sales up

#### Parameters
|Param|Description|
|-----|-----------|
|`pkId` |  Id |
|`deal` |  Deal__c |

### `createDefaultFees(List<Deal__c> deals)` → `void`

 Creates Fees to be defaulted on a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`deals` |  List<Deal__c> |

### `createFromSalesUp(deal dealData)` → `Deal__c`
### `createPartAfterMarket(Id dealId, PartAddition partData)` → `void`

MOVE TO PARTAPI Creates an Aftermarket record from a part

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |
|`partData` |  DealAPI.partData |

### `dealData(Id dealId)` → `Deal`

 Retrieves Data relavent to a deal. Used mostly for deal forms.

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `dealHeader(Id dealId)` → `Deal__c`

 Acquires all header-level data for a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  dealId |

### `dealLocation(Id dealId)` → `Dealer_Location__c`

Set Deal Totals /** Retrieves Deal's Dealer Location information

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `formRefQuery(Deal__c deal, String printType)` → `String`

 Builds query for Deal-Applicable form references

#### Parameters
|Param|Description|
|-----|-----------|
|`deal` |  Deal__c |
|`printType` |  FDF, Laser |

### `generateFromSalesUp(Deal dealData)` → `Deal`
### `getDealDiscounts(Id dealId)` → `List<Discount_Rebate__c>`

 Get Discounts Records on a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `getDealFees(Id dealId)` → `List<Sales_Fee__c>`

 Acquires Fee Records on a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `getDealRebates(Id dealId)` → `List<Discount_Rebate__c>`

 Get Rebate Records on a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `getDealRecord(Id dealId)` → `>`
#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  dealId |

### `getDiscountTemplates()` → `List<Discount_Rebate__c>`

 Returns discount templates for available for Deals

### `getTradeIns(Id dealId)` → `List<Trade_In__c>`

 Queries all Trades related to a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |

### `populateBuyerData(Deal__c deal, Id acctId)` → `void`
### `populateCoBuyerData(Deal__c deal, Id acctId)` → `void`
### `populateVehicle(Deal__c deal, Id vehId)` → `void`
### `removeDealForm(Id dealId, Id formId)` → `void`

 Removes a Form from a Deal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  Id |
|`formId` |  Id |

### `saveDeal(Deal__c deal)` → `Deal__c`

 Saves and calculates deal Assumes all fields on Deal__c were queried prior to entry.

#### Parameters
|Param|Description|
|-----|-----------|
|`deal` |  Deal__c |

### `saveTradesData(Deal dealData)` → `void`
### `selectedForms(String dealId)` → `List<Form__c>`

Disclude forms that both exist on Deal and Applicable Forms /** this selects sarg

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  String |

### `updateAppraisal(Deal__c deal, List<Trade_In__c> TradeList)` → `void`
---
## Inner Classes

### DealAPI.Deal class

 getServiceContractTotal @param  contracts List<Service_Contracts__c> @return Decimal /** REMOVE THIS Retrieves Logo URL @param  dealId Id @param  locId Id @return String /** Retrieves list of Taxable Fees on a Deal @param  dealId Id @param  fees List<Sales_Fee__c> @return List<Sales_Fee__c /** Returns Total Allowance @param  tradeInList List<Trade_In__c> @return Decimal /** Returns Total Trade Gross @param  tradeInList List<Trade_In__c> @return Decimal /** Returns Trade Tax Credit Amount @param  dealId Id @return Decimal /** MOVE LOGIC TO VEHICLE API Returns Retail Vehicle Price of Vehicle @param  dealId Id @return Decimal /** Returns Account for Payor 1 @param  dealId Id @return Account /** getPayor2 @param  dealId Id @return Account /** getPayor3 @param  dealId Id @return Account /** Wrapper class for deal data and related records.

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
---
### DealAPI.PartAddition class

 	Wrapper class to add a part After Market Item to Deal

---
#### Properties

##### `Cost` → `Decimal`

##### `Description` → `String`

##### `PartsMasterId` → `String`

##### `Printable` → `Boolean`

##### `Quantity` → `Decimal`

##### `RateType` → `String`

##### `SalePrice` → `Decimal`

##### `Taxable` → `Boolean`

---
