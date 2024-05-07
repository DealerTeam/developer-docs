---
layout: default
---
# ERPInquiry
## Constructors
### `public ERPInquiry(DMSERPEvent__mdt event, Map<String,Object> erpData, String apiToken)`

Constructor to initialize data from an ERP Event

#### Parameters

|Param|Description|
|---|---|
|`event`|event description|
|`erpData`|erpData description|

### `public ERPInquiry(DMSERPEvent__mdt event, String requestBody, String apiToken)`

Constructor to initialize data from Pre Defined ERP Process

#### Parameters

|Param|Description|
|---|---|
|`event`|event description|
|`erpData`|erpData description|

### `public ERPInquiry(DMSDataSourceRequest dmsRequest)`

External Datasource callout Constructor - Automatically performs callout.

#### Parameters

|Param|Description|
|---|---|
|`dmsRequest`|dmsRequest description|

---
## Fields

### `public calloutUrl` → `string`


### `public params` → `string`


### `public token` → `string`


### `public event` → `DMSERPEvent__mdt`


### `public httpResponse` → `HttpResponse`


### `public response` → `ERPResponse`


---
## Methods
### `public void createRequest()`

Once initialized, createRequest will perform the callout and save the response to a public variable.

### `public void createRequest(Boolean throwExceptions)`
### `private Boolean isERPEventResponse(String response)`
### `public void urlEncodeParams(Map<String,Object> vals)`

Creates url-encoded body

#### Parameters

|Param|Description|
|---|---|
|`vals`|vals description|

---
## Classes
### DMSDataSourceRequest
#### Constructors
##### `public DMSDataSourceRequest(String restResource, String method, Map&lt;String,String&gt; customHeaders, String jsonBody)`
---
#### Fields

##### `public restResource` → `String`


##### `public method` → `String`


##### `public customHeaders` → `Map&lt;String,String&gt;`


##### `public jsonBody` → `String`


---

### ERPResponse
#### Constructors
##### `public ERPResponse()`
---
#### Fields

##### `public success` → `Boolean`


##### `public results` → `List&lt;ERPResult&gt;`


##### `public records` → `List&lt;Map&lt;String,Object&gt;&gt;`


---

### ERPResult
#### Fields

##### `public success` → `Boolean`


##### `public message` → `String`


##### `public messageDetail` → `String`


##### `public error` → `Error`


##### `public request` → `String`


---

### Error
#### Fields

##### `public message` → `String`


---

### ERPInquiryException

**Inheritance**

ERPInquiryException


---
