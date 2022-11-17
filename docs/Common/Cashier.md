# Cashier

`APIVERSION: 45`

`STATUS: ACTIVE`

This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.


**Group** Common


**Author** DealerTeam.com, LLC

## Constructors
### `Cashier()`
---
## Properties

### `account` → `String`


### `applyAmount` → `Decimal`


### `authCode` → `String`


### `cashierPaidBy` → `Cashering__c`


### `clines` → `List<Cashering__c>`


### `closeDate` → `String`


### `companyNumber` → `String`


### `customer` → `String`


### `customerId` → `Id`


### `department` → `String`


### `deposit` → `boolean`


### `dms` → `DMS_Settings__c`


### `erpLine` → `Cashering__c`


### `invoiceAmount` → `Decimal`


### `invoiceId` → `String`


### `invoiceNumber` → `String`


### `paymethods` → `String`


### `posted` → `Boolean`


### `totalDue` → `Decimal`


---
## Methods
### `getPaymentMethods()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getPaymentMethods

### `applyPayment()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** applyPayment

### `PostERP()`

- Posts a Cashier Line to the ERP Integration

#### Return

**Type**

PageReference

**Description**

pagereference


**Method** PostERP

### `postInvoice()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** postInvoice

### `static paymentMethods(Id parentRecordId)`

paymentMethods returns a list of applicable payment method types for the specified location

#### Parameters

|Param|Description|
|---|---|
|`parentRecordId`|Record ID of the Transaction recording cashiering events|

#### Return

**Type**

List&lt;PaymentMethod__c&gt;

**Description**

return description

### `static location(Id parentRecordId)`

location This method returns the Location data for a given transaction Id (Deal, Repair Order, etc.)

#### Parameters

|Param|Description|
|---|---|
|`Id`|parentRecordId description|

#### Return

**Type**

Dealer_Location__c

**Description**

Dealer_Location__c returns the sObject of dealer location

### `returnToInvoice()`

method to return the user to the Service or Parts invoice that this application was directed from

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** returnToInvoice

### `cancel()`

supports dynamic refering and returns the user to the page that they are cashiering

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** cancel -  to return to the record that the cashiering is taking place from

### `loadServiceInvoice()`
#### Return

**Type**

void

**Description**

void


**Method** loadServiceInvoice description

### `loadPartsInvoice()`
#### Return

**Type**

void

**Description**

void


**Method** loadPartsInvoice description

### `voidRepairOrder()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** voidRepairOrder

### `reOpenRO()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** reOpenRO

### `static emailAsyncHandler(String payload)`

Performs an outbound single email to an external handler.

#### Parameters

|Param|Description|
|---|---|
|`payload`||

#### Return

**Type**

void

**Description**

void

#### Throws

|Exception|Description|
|---|---|
|`CashierException`||

### `static emailServiceAddress()`

determines the email handle for processing the integrated financials requests

#### Return

**Type**

String

**Description**

String


**Method** emailServiceAddress

---
## Classes
### CashierException

**Inheritance**

CashierException


---
