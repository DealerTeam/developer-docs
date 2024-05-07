---
layout: default
---
# EnterpriseControllerAPI

The EnterpriseControllerAPI Class performs callouts to designated DealerTeam Secure Remote Resources


**Group** Core


**TestClass** //TODO move test coverage to class that adheres to the naming convention

## Methods
### `public static String callOut(String endpoint, String jsonObject)`

callOut default callout method with base parameters

#### Parameters

|Param|Description|
|---|---|
|`endpoint`|endpoint URL for callout|
|`jsonObject`|jsonObject JSON Object for POST Payload|

#### Returns

|Type|Description|
|---|---|
|`String`|return String|

### `public static String callOut(String endpoint, String jsonObject, Integer timeout)`

callOut Optional timeout parameter

#### Parameters

|Param|Description|
|---|---|
|`endpoint`|endpoint of the service we are calling|
|`jsonObject`|jsonObject Object we are sending|
|`timeout`|timeout if set to null, defaults to 120 seconds|

#### Returns

|Type|Description|
|---|---|
|`String`|return String|


**Test** 

### `public static String callOut(String endpoint, String jsonObject, Integer timeout, String method)`

callOut method performs a platform interaction with Heroku hosted DT DMS

#### Parameters

|Param|Description|
|---|---|
|`endpoint`|endpoint URL of the applicable endpoint|
|`jsonObject`|jsonObject POST payload|
|`timeout`|timeout payload timeout defaults to 120 seconds|
|`method`|method GET/POST/PUT/PATCH HTTP Methods|

#### Returns

|Type|Description|
|---|---|
|`String`|return String of results|

### `private static String getEnterpriseJWT()`

callOut Retrieves defined JWT Secret Key, signs it and returns Middleware Auth Key

#### Returns

|Type|Description|
|---|---|
|`String`|String This string contains the JWT Token for Callouts|


**Test** 

### `private static String base64URLencode(Blob input)`

URL Encodes and ensures the JWT signature output is compatible.

#### Returns

|Type|Description|
|---|---|
|`String`|String Base64 Encoded binary input|

---
## Classes
### ApiException

ApiException Exception Class


**Inheritance**

ApiException


---
