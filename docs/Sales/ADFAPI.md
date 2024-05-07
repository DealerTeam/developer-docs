---
layout: default
---
# ADFAPI



**Group** Sales

## Fields

### `public crm` → `dealer__CRMSettings__c`


getInstance DOM.Document adfDoc = new DOM.Document();

### `public companyNumber` → `String`


### `public providerName` → `String`


### `public providerService` → `String`


### `public objStoreLocation` → `dealer__Dealer_Location__c`


To store associated company to take related SalesUp queue

### `public lead_routing` → `dealer__IntercompanyLeadRouting__c`


Intercompany Routing Table for this Request

### `public finance` → `String`


### `private customerVehicle` → `Service_Vehicle__c`


customer owned vehicle

### `public curbPurchaseId` → `Id`


### `public standardSalesUp` → `Id`


### `public rentalId` → `Id`


### `public serviceId` → `Id`


### `public isBuyInterest` → `Boolean`


### `public isSaleTradeInterest` → `Boolean`


### `public av` → `Appraisal_Vehicle__c`


### `public up` → `Sales_Up__c`


### `public dv` → `Desired_Vehicle__c`


### `public buyerContact` → `Contact`


### `public buyerAccount` → `Account`


### `public buyerContactId` → `Id`


### `public trafficLog` → `Traffic_Log__c`


### `public beforeTime` → `Date`


### `public supCheck` → `List<dealer__Sales_Up__c>`


### `public toEmailAddress` → `String`


### `public fromEmailAddress` → `String`


### `private instance` → `ADFAPI`


### `public dvList` → `List<Desired_Vehicle__c>`


### `public taskList` → `List<Task>`


### `private trafficLogList` → `List<Traffic_Log__c>`


### `private fieldMap` → `Map<String,Schema.SObjectField>`


### `private fieldTypeMap` → `Map<String,String>`


### `private pickListFieldMap` → `Map<String,List<String>>`


---
## Properties

### `public payload` → `String`


ADF XML payload used to send or read

### `public toEmail` → `String`


### `public fromEmail` → `String`


### `public readableXML` → `String`


### `public customerEmail` → `String`


### `public customerFirstName` → `String`


### `public customerLastName` → `String`


### `public customerFullName` → `String`


### `public customerDayPhone` → `String`


### `public customerEveningPhone` → `String`


### `public customerCellPhone` → `String`


### `public customerAddressLine1` → `String`


### `public customerAddressLine2` → `String`


### `public customerCity` → `String`


### `public customerState` → `String`


### `public customerZip` → `String`


### `public storeLocation` → `String`


Added MKS 1-26-16

### `public stockNumber` → `String`


---
## Methods
### `public static ADFAPI getInstance()`
### `public void readXML()`
### `public static void outputXML(Sales_Up__c s, String email)`
### `public static void sendXML(String payload, String toEmail)`

sendXML sends an ADF xml payload to the provided email

### `public dealer__Sales_Up__c parseADF(String XML, String toAddress, String fromAddress)`

parseADF Converts XML into Sales Up and related records

#### Parameters

|Param|Description|
|---|---|
|`XML`|String of ADF payload|
|`toAddress`|toAddress description|
|`fromAddress`|fromAddress description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Sales_Up__c`|return description|

### `public void setLocationRouting(String toEmail)`

Assigns the public property of location_routing

#### Parameters

|Param|Description|
|---|---|
|`toEmail`|email to locate routing table from|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setLocationRouting

### `public void setCompanyNumber(String toEmail)`

MKS 1-26-16: Added Store Location information.

#### Parameters

|Param|Description|
|---|---|
|`toEmail`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setCompanyNumber

### `public void setFromAddress(String fromEmail)`

Sets e-mail as that found within the XML

#### Parameters

|Param|Description|
|---|---|
|`fromEmail`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setFromAddress

### `public dealer__Sales_Up__c exposeADF(DOM adfDom)`
#### Parameters

|Param|Description|
|---|---|
|`adfDom`||

#### Returns

|Type|Description|
|---|---|
|`dealer__Sales_Up__c`|dealer__Sales_Up__c|


**Method** exposeADF

### `private void parseVehicle(DOM subX)`

parseVehicle extract vehicle data from xml

#### Parameters

|Param|Description|
|---|---|
|`subX`|xml node with vehicle data|

### `private void parseCustomer(DOM customer)`

parseCustomer extract lead customer data from xml

#### Parameters

|Param|Description|
|---|---|
|`customer`|xml node with customer data|

### `private void parseProvider(Dom provider)`

parseProvider extract lead provider data from xml

#### Parameters

|Param|Description|
|---|---|
|`provider`|xml node with provider data|

### `private void parseCustomFields(Dom customFields)`

- extract custom field data from xml

#### Parameters

|Param|Description|
|---|---|
|`-`|customFields xml node with custom field data|


**Method** - parseCustomFields

### `private List<String> getActivePickListValues(String fieldName)`

getActivePickListValues populates the pickList value map for validating picklist type fields in the customFields node

#### Parameters

|Param|Description|
|---|---|
|`fieldName`|field to retrieve picklist values for|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|return - list of active picklist values|

### `private void validateCustomfieldAtRuntime(DOM customField, String fieldName, String fieldType)`

validateCustomfieldAtRuntime cast incoming values to objects to catch possible exceptions at runtime and clean incoming picklist values

#### Parameters

|Param|Description|
|---|---|
|`customField`|inbound xml node|
|`fieldName`|fieldName of the incoming node|
|`fieldType`|fieldType of the incoming node|

### `private void queryExistingSalesUps()`

queryExistingSalesUps sets supCheck to the result of a query that depends upon interest params

### `private void handleDuplicates()`

handleDuplicates associates the lead with existing records if a match exists

### `private void handleNew()`

handleNew creates new records if the lead does not exist

### `public dealer__Vehicle_Inventory__c assignInventoryRecord()`

Assigns Inventory record to Sales Up

#### Returns

|Type|Description|
|---|---|
|`dealer__Vehicle_Inventory__c`|dealer__Vehicle_Inventory__c|


**Method** assignInventoryRecord

### `public Contact assignContact()`

Looks for Contact to assign and if found, updates it. If no contact is found, a new contact is created.

#### Returns

|Type|Description|
|---|---|
|`Contact`|Contact|


**Method** assignContact

### `public Account assignAccount()`

Looks for an Account to assign and if found, updates it. If no account is found, a new account is created.

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|


**Method** assignAccount

### `public void logException(ADFException e, String methodName)`

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
