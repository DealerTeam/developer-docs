---
layout: default
---
# Cashier

This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.


**Group** Common


**Author** DealerTeam.com, LLC

## Constructors
### `public Cashier()`
---
## Fields

### `private servicero` → `Service_Repair_Order__c`


### `private partsinvoice` → `Parts_Invoice__c`


---
## Properties

### `public erpLine` → `Cashering__c`


### `public clines` → `List<Cashering__c>`


### `public cashierPaidBy` → `Cashering__c`


### `public dms` → `DMS_Settings__c`


### `public totalDue` → `Decimal`


### `public invoiceAmount` → `Decimal`


### `public applyAmount` → `Decimal`


### `public authCode` → `String`


### `public closeDate` → `String`


### `public deposit` → `boolean`


### `public invoiceNumber` → `String`


### `public companyNumber` → `String`


### `public customer` → `String`


### `public account` → `String`


### `public customerId` → `Id`


### `public department` → `String`


### `public invoiceId` → `String`


### `public posted` → `Boolean`


### `public paymethods` → `String`


---
## Methods
### `global List<SelectOption> getPaymentMethods()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getPaymentMethods

### `public PageReference applyPayment()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** applyPayment

### `public PageReference PostERP()`

- Posts a Cashier Line to the ERP Integration

#### Returns

|Type|Description|
|---|---|
|`PageReference`|pagereference|


**Method** PostERP

### `public PageReference postInvoice()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** postInvoice

### `public static List<PaymentMethod__c> paymentMethods(Id parentRecordId)`

paymentMethods returns a list of applicable payment method types for the specified location

#### Parameters

|Param|Description|
|---|---|
|`parentRecordId`|Record ID of the Transaction recording cashiering events|

#### Returns

|Type|Description|
|---|---|
|`List<PaymentMethod__c>`|return description|

### `public static Dealer_Location__c location(Id parentRecordId)`

location This method returns the Location data for a given transaction Id (Deal, Repair Order, etc.)

#### Parameters

|Param|Description|
|---|---|
|`Id`|parentRecordId description|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c returns the sObject of dealer location|

### `public PageReference returnToInvoice()`

method to return the user to the Service or Parts invoice that this application was directed from

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** returnToInvoice

### `public PageReference cancel()`

supports dynamic refering and returns the user to the page that they are cashiering

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** cancel -  to return to the record that the cashiering is taking place from

### `public void loadServiceInvoice()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** loadServiceInvoice description

### `public void loadPartsInvoice()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** loadPartsInvoice description

### `public PageReference voidRepairOrder()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** voidRepairOrder

### `public PageReference reOpenRO()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** reOpenRO

### `global static void emailAsyncHandler(String payload)`

Performs an outbound single email to an external handler.

#### Parameters

|Param|Description|
|---|---|
|`payload`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

#### Throws

|Exception|Description|
|---|---|
|`CashierException`||

### `public static String emailServiceAddress()`

determines the email handle for processing the integrated financials requests

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** emailServiceAddress

---
## Classes
### CashierException

**Inheritance**

CashierException


---
