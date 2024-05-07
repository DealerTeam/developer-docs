---
layout: default
---
# DMSRestServiceAPI

DMSREstServiceAPI provides service layer logic for processing inbound DMS related REST requests


**Group** Sales


**Author** DealerTeam

## Constructors
### `public DMSRestServiceAPI()`
---
## Fields

### `public statusCode` → `Integer`


### `public response` → `Map<String,Object>`


---
## Methods
### `public void getCustomerCode(String custId)`
#### Parameters

|Param|Description|
|---|---|
|`custId`|custId description|


**Name** getCustomerCode


**GET** customer code by CustID

### `public void postCustomerCode(String custID, CustomerCode__x code)`
#### Parameters

|Param|Description|
|---|---|
|`custId`|custId description|


**Name** postCustomerCode


**POST** customer code by CustID

### `public void patchCustomerCode(CustomerCode__x code)`
#### Parameters

|Param|Description|
|---|---|
|`custId`|custId description|


**Name** patchCustomerCode


**PATCH** customer code by CustID

### `public void getJournal(Integer voucherId)`
#### Parameters

|Param|Description|
|---|---|
|`voucherId`|voucherId description|


**Name** getJournal


**GET** Journal and lines by Voucher ID

### `public void postGLJournal(Integer voucherId, Journal__x journal, List<JournalLine__x> lines)`

Creates Journal and / or Lines for the specified journal

#### Parameters

|Param|Description|
|---|---|
|`journal`|Journal__x object|
|`lines`|List JournalLine__x|

### `public void patchGLJournal(Integer voucherID, Journal__x journal, List<JournalLine__x> lines)`

Updates a Journal and / or its applicable Lines

#### Parameters

|Param|Description|
|---|---|
|`journal`|journal description|
|`lines`|lines description|

### `public void sendError(Integer statusCode, String message)`

sendError Creates error response

#### Parameters

|Param|Description|
|---|---|
|`statusCode`|statusCode description|
|`message`|message description|

---
## Classes
### DMSRestServiceAPIException

**Inheritance**

DMSRestServiceAPIException


---
