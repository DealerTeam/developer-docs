---
layout: default
---
# Cashier class

Custom controller used in the cashier payments page

---
## Constructors
### `Cashier()`

 Constructor : instantiates the object, loads settings and performs configuration validation. based on the referenced department in the GET Variables an invoice is loaded from the database.
---
## Properties

### `account` → `String`

@description

### `applyAmount` → `Decimal`

@description

### `authCode` → `String`

@description

### `cashierPaidBy` → `Cashering__c`

@description

### `clines` → `List<Cashering__c>`

@description

### `closeDate` → `String`

@description

### `companyNumber` → `String`

@description

### `customer` → `String`

@description

### `customerId` → `Id`

@description

### `department` → `String`

@description

### `deposit` → `boolean`

@description

### `dms` → `DMS_Settings__c`

@description

### `invoiceAmount` → `Decimal`

@description

### `invoiceId` → `String`

@description

### `invoiceNumber` → `String`

@description

### `paymethods` → `String`

@description

### `posted` → `Boolean`

@description

### `totalDue` → `Decimal`

@description

---
## Methods
### `applyPayment()` → `PageReference`
### `cancel()` → `PageReference`

supports dynamic refering and returns the user to the page that they are cashiering

### `emailAsyncHandler(String payload)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `emailServiceAddress()` → `String`

determines the email handle for processing the integrated financials requests

### `getPaymentMethods()` → `List<SelectOption>`
### `loadPartsInvoice()` → `void`
### `loadServiceInvoice()` → `void`
### `postInvoice()` → `PageReference`
### `reOpenRO()` → `PageReference`
### `returnToInvoice()` → `PageReference`

method to return the user to the Service or Parts invoice that this application was directed from

### `storeFinancialRequestEvent(String payload)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `voidRepairOrder()` → `PageReference`
---
## Inner Classes

### Cashier.CashierException class

@description

---
