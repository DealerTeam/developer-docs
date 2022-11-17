# LocationControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Handler for LocationControl trigger


**Class** LocationControlHandler


**Group** Sales

## Methods
### `handleAccounts(List<Dealer_Location__c> locationList)`

Stores dealer__Dealer_Location__c related IDs

#### Parameters

|Param|Description|
|---|---|
|`locationList`||

#### Return

**Type**

void

**Description**

void


**Method** handleAccounts

### `handleLogo(List<Dealer_Location__c> locationList)`
#### Parameters

|Param|Description|
|---|---|
|`locationList`||

#### Return

**Type**

void

**Description**

void


**Method** handleLogo

### `ERPInsert(Dealer_Location__c loc)`

Inserts an Dealer Location using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`accountId`||

### `ERPUpdate(Dealer_Location__c loc)`

Updates an Dealer Location using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`accountId`||

### `setDefaultPaymentMethod(List<Dealer_Location__c> locationList)`

setDefaultPaymentMethod associates the default Payment Group in this org with this Location.

#### Parameters

|Param|Description|
|---|---|
|`locationList`|List<Dealer_Location__c> List of trigger modified records.|

---
