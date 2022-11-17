# ADFAPI

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Sales

## Fields

### `av` → `Appraisal_Vehicle__c`


### `beforeTime` → `Date`


### `buyerAccount` → `Account`


### `buyerContact` → `Contact`


### `buyerContactId` → `Id`


### `companyNumber` → `String`


### `crm` → `dealer__CRMSettings__c`


getInstance DOM.Document adfDoc = new DOM.Document();

### `curbPurchaseId` → `Id`


### `dv` → `Desired_Vehicle__c`


### `dvList` → `List<Desired_Vehicle__c>`


### `finance` → `String`


### `fromEmailAddress` → `String`


### `isBuyInterest` → `Boolean`


### `isSaleTradeInterest` → `Boolean`


### `lead_routing` → `dealer__IntercompanyLeadRouting__c`


Intercompany Routing Table for this Request

### `objStoreLocation` → `dealer__Dealer_Location__c`


To store associated company to take related SalesUp queue

### `providerName` → `String`


### `providerService` → `String`


### `rentalId` → `Id`


### `serviceId` → `Id`


### `standardSalesUp` → `Id`


### `supCheck` → `List<dealer__Sales_Up__c>`


### `taskList` → `List<Task>`


### `toEmailAddress` → `String`


### `trafficLog` → `Traffic_Log__c`


### `up` → `Sales_Up__c`


---
## Properties

### `customerAddressLine1` → `String`


### `customerAddressLine2` → `String`


### `customerCellPhone` → `String`


### `customerCity` → `String`


### `customerDayPhone` → `String`


### `customerEmail` → `String`


### `customerEveningPhone` → `String`


### `customerFirstName` → `String`


### `customerFullName` → `String`


### `customerLastName` → `String`


### `customerState` → `String`


### `customerZip` → `String`


### `fromEmail` → `String`


### `payload` → `String`


ADF XML payload used to send or read

### `readableXML` → `String`


### `stockNumber` → `String`


### `storeLocation` → `String`


Added MKS 1-26-16

### `toEmail` → `String`


---
## Methods
### `static getInstance()`
### `readXML()`
### `static outputXML(Sales_Up__c s, String email)`
### `static sendXML(String payload, String toEmail)`

sendXML sends an ADF xml payload to the provided email

### `parseADF(String XML, String toAddress, String fromAddress)`

parseADF Converts XML into Sales Up and related records

#### Parameters

|Param|Description|
|---|---|
|`XML`|String of ADF payload|
|`toAddress`|toAddress description|
|`fromAddress`|fromAddress description|

#### Return

**Type**

dealer__Sales_Up__c

**Description**

return description

### `setLocationRouting(String toEmail)`

Assigns the public property of location_routing

#### Parameters

|Param|Description|
|---|---|
|`toEmail`|email to locate routing table from|

#### Return

**Type**

void

**Description**

void


**Method** setLocationRouting

### `setCompanyNumber(String toEmail)`

MKS 1-26-16: Added Store Location information.

#### Parameters

|Param|Description|
|---|---|
|`toEmail`||

#### Return

**Type**

void

**Description**

void


**Method** setCompanyNumber

### `setFromAddress(String fromEmail)`

Sets e-mail as that found within the XML

#### Parameters

|Param|Description|
|---|---|
|`fromEmail`||

#### Return

**Type**

void

**Description**

void


**Method** setFromAddress

### `exposeADF(DOM.Xmlnode adfDom)`
#### Parameters

|Param|Description|
|---|---|
|`adfDom`||

#### Return

**Type**

dealer__Sales_Up__c

**Description**

dealer__Sales_Up__c


**Method** exposeADF

### `assignInventoryRecord()`

Assigns Inventory record to Sales Up

#### Return

**Type**

dealer__Vehicle_Inventory__c

**Description**

dealer__Vehicle_Inventory__c


**Method** assignInventoryRecord

### `assignContact()`

Looks for Contact to assign and if found, updates it. If no contact is found, a new contact is created.

#### Return

**Type**

Contact

**Description**

Contact


**Method** assignContact

### `assignAccount()`

Looks for an Account to assign and if found, updates it. If no account is found, a new account is created.

#### Return

**Type**

Account

**Description**

Account


**Method** assignAccount

### `logException(ADFException e, String methodName)`

logException sends exceptions to external logging system

#### Parameters

|Param|Description|
|---|---|
|`e`|ADFException with message|
|`methodName`|the method where the exception was caught|

---
## Classes
### ADFException

**Inheritance**

ADFException


---
