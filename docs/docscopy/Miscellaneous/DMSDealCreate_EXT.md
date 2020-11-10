---
layout: default
---
# DMSDealCreate_EXT class

Interacts with middleware and DealerTrack to create a Deal from SalesUp

---
## Constructors
### `DMSDealCreate_EXT(ApexPages.StandardController stdController)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `acc1` → `Account`

@description

### `acc2` → `Account`

@description

### `aprVehCount` → `Integer`

@description

### `aprveh` → `dealer__Appraisal_Vehicle__c`

@description

### `bdc` → `User`

@description

### `calloutError` → `String`

@description

### `createNewValue` → `String`

@description

### `custFields` → `Object>>`

@description

### `custId` → `String`

@description

### `custName` → `String`

@description

### `customerList` → `List<Object>`

@description

### `customerNumber` → `String`

@description

### `customers` → `Object>`

@description

### `dealNumber` → `String`

@description

### `dm` → `User`

@description

### `dmsRes` → `String`

@description

### `errorMessage` → `String`

@description

### `fi` → `User`

@description

### `insDeal` → `updSup,`

@description

### `inv` → `dealer__Vehicle_Inventory__c`

@description

### `jsonString` → `String`

@description

### `loc` → `dealer__Dealer_Location__c`

@description

### `newConId` → `errConID,`

@description

### `newDeal` → `dealer__Deal__c`

@description

### `result` → `String`

@description

### `sercon` → `dealer__Service_Contract__c`

@description

### `sp1` → `User`

@description

### `sp2` → `User`

@description

### `success` → `Boolean`

@description

### `sup` → `dealer__Sales_Up__c`

@description

### `trade` → `dealer__Service_Vehicle__c`

@description

### `tradeInsSup` → `List<dealer__Appraisal_Vehicle__c>`

@description

### `valid` → `Boolean`

@description

### `vinToAprVeh` → `dealer__Appraisal_Vehicle__c>`

@description

---
## Methods
### `addCustInfo()` → `PageReference`

: user has selected a customer in VF, insert the info in the payload

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `buildRequest(String payload)` → `HttpRequest`

: constructs the HttpRequest object, setting endpoint, method, body, etc

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  String the JSON payload |

### `callOut(HttpRequest hreq)` → `String`

: performs callout to the middleware, handles exceptions, and returns the response

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  HttpRequest An HttpReuest with endpoint, method, body set |

### `cancel()` → `PageReference`

: user has decided to return to sales up page

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `create()` → `PageReference`

: user has validated fields and wants to go ahead with deal creation

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `createNewCust()` → `PageReference`

: user has selected to create a new customer in DealerTrack

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `createPayloadSerialize()` → `String`

: constructs a payload from the queried information to pass to middleware using JSON.Serialize

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `gatherInfo()` → `void`
### `updateSF()` → `String`

: creates a Deal in DealerTeam

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `validateFields()` → `Boolean`

: performs validation checks on DealerTeam field requirements and sets the error message with details

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

### `viewDeal()` → `PageReference`

: simple redirection to deal page

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  none |

---
## Inner Classes

### DMSDealCreate_EXT.DealFields class
---
#### Constructors
##### `DealFields(dealer__Dealer_Location__c location)`
---
#### Properties

##### `String` → `public`

---
#### Methods
##### `addSalesPerson(SalesPersonWrapper sp)` → `void`
##### `addSerCon(ServiceContractWrapper scw)` → `void`
##### `addTradeIn(TradeInWrapper ti)` → `void`
---
### DMSDealCreate_EXT.DealWrapper class
---
#### Constructors
##### `DealWrapper(DealFields df)`
---
#### Properties

##### `Deal` → `public`

---
### DMSDealCreate_EXT.JSONWrapper class
---
#### Properties

##### `account` → `Account`

##### `cobuyer` → `Account`

##### `createNew` → `String`

##### `dealwrapper` → `DealWrapper`

---
### DMSDealCreate_EXT.SalesPersonFields class
---
#### Constructors
##### `SalesPersonFields(User u, String spType, String spSubType)`
---
#### Properties

##### `CountUnit,` → `SaleDate,`

---
### DMSDealCreate_EXT.SalesPersonWrapper class
---
#### Constructors
##### `SalesPersonWrapper(SalesPersonFields spf)`
---
### DMSDealCreate_EXT.SalesPersonsClass class
---
#### Properties

##### `SalesPerson` → `List<`

---
### DMSDealCreate_EXT.ServiceContractFields class
---
#### Constructors
##### `ServiceContractFields(dealer__Service_Contract__c sc)`
---
#### Properties

##### `BORecordKey,` → `ContractName,`

---
### DMSDealCreate_EXT.ServiceContractWrapper class
---
#### Constructors
##### `ServiceContractWrapper(ServiceContractFields scf)`
---
#### Properties

##### `ServiceContract` → `public`

---
### DMSDealCreate_EXT.ServiceContractsClass class
---
#### Properties

##### `ServiceContract` → `List<`

---
### DMSDealCreate_EXT.TradeInFields class
---
#### Constructors
##### `TradeInFields(dealer__Appraisal_Vehicle__c av, dealer__Appraisal__c ap, dealer__Service_Vehicle__c sv)`
---
#### Properties

##### `TradeModel,` → `TradeMake,`

---
### DMSDealCreate_EXT.TradeInWrapper class
---
#### Constructors
##### `TradeInWrapper(TradeInFields tif)`
---
#### Properties

##### `TradeIn` → `public`

---
### DMSDealCreate_EXT.TradeInsClass class
---
#### Properties

##### `TradeIn` → `List<`

---
### DMSDealCreate_EXT.dmsException class

@description

---
