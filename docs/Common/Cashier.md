# Cashier

`APIVERSION: 45`

`STATUS: ACTIVE`

This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.


**Group** Common


**Author** DealerTeam.com, LLC

## Methods
### `getPaymentMethods()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getPaymentMethods

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

---
