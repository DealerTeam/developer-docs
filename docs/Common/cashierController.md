---
layout: default
---
# cashierController

CashierController is dedicated to Aura/LWC enabled components.  This class performs cashiering related functions.


**Group** Common


**Notes** The without sharing annotation was added to allow Approval Processes to run without record blocking


**Secuity** This class is set to without sharing.  Specific use cases are to allow non-priveladged users to bypass Aproval record locks. Example: A Deal record is locked for manager approval, however the customer wants to take payment.  The Deal record header is updated to reflect this payment

## Methods
### `public static List<Cashering__c> getCashTransactions(String recordId)`

`AURAENABLED`

getCashTransactions returns all transactions

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String Record ID for the transactions requested.|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|List<Cashering__c> List of cashiering transactions.|

### `public static String getDefaultCustomer(String recordId)`

`AURAENABLED`

getDefaultCustomer description

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String Record ID of the parent transaction.|

#### Returns

|Type|Description|
|---|---|
|`String`|String Returns a string representing the customer ID associated with teh transaction.|

### `public static string getSobjectType(String recordId)`

`AURAENABLED`

getSobjectType returns the sObject type of the Record being requested.

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String Record Id for the record in question.|

#### Returns

|Type|Description|
|---|---|
|`string`|String sObject Schema Name.|

### `public static List<PaymentMethod__c> getPaymentMethods(String recordId)`

`AURAENABLED`

getPaymentMethods resolves a list of payment methods returned as a key-value-pair string in JSON Format.

#### Returns

|Type|Description|
|---|---|
|`List<PaymentMethod__c>`|List<PaymentMethod__c>|

### `public static Dealer_Location__c getLocation(String recordId)`

`AURAENABLED`

getLocation returns the location sobject related to the transaction this cashiering record pertains to.

#### Parameters

|Param|Description|
|---|---|
|`String`|recordId The ID of the Parent Record|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|

### `public static Cashering__c addLine(Cashering__c line)`

`AURAENABLED`

addLine creates a new Cashier entry

#### Parameters

|Param|Description|
|---|---|
|`Cashering__c`|sobject record to insert|

#### Returns

|Type|Description|
|---|---|
|`Cashering__c`|Cashering__c DML Complete sObject record|

### `public static Cashering__c updateLine(Cashering__c line)`

`AURAENABLED`

updateLine performs a DML update on the cashier line

#### Parameters

|Param|Description|
|---|---|
|`Cashering__c`||

#### Returns

|Type|Description|
|---|---|
|`Cashering__c`|Cashering__c|

### `public static CashierDeleteResponse deleteLine(Cashering__c line)`

`AURAENABLED`

deleteLine removes the line from the database

#### Parameters

|Param|Description|
|---|---|
|`Cashering__c`|sObject line in memory|

#### Returns

|Type|Description|
|---|---|
|`CashierDeleteResponse`|Cashering__c DML Complete sObject|

### `public static void ERPInsert(Cashering__c line)`

`AURAENABLED`
### `public static void ERPUpdate(Cashering__c line)`

`AURAENABLED`
### `public static void ERPDelete(Cashering__c line)`

`AURAENABLED`
### `public static List<Cashering__c> getRefundableTransactions(String recordId)`

`AURAENABLED`

return cashiering lines for a given record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|- record to return cashiering lines for|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|cashiering lines related to given record id|

---
## Classes
### CashierDeleteResponse
#### Fields

##### `public error` → `CashierDeleteErrorMessage`

`AURAENABLED` 

##### `public cashier` → `Cashering__c`

`AURAENABLED` 

---

### CashierDeleteErrorMessage
#### Constructors
##### `public CashierDeleteErrorMessage(String message)`
---
#### Fields

##### `public message` → `String`

`AURAENABLED` 

---

---
