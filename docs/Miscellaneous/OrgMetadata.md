---
layout: default
---
# OrgMetadata
## Fields

### `public HEROKU_RESOURCE` → `String`


### `public HEROKU_RESOURCE_CANVAS` → `String`


### `public HEROKU_PREDICTABLE_URL_CANVAS` → `String`


---
## Methods
### `public static void setupLocalDev(String appName, String endpoint)`

Sets up local development.

#### Parameters

|Param|Description|
|---|---|
|`appName`|appName description|
|`endpoint`|endpoint description|

### `public static void setHEMIDevConfigurations()`

Sets HEMI (Sandbox) Custom Metadata record to point to

### `public static void createLocalDevCanvasApp(String appName, String endpoint)`

Creates a Canvas-enabled Connected App to interact with the Accounting Module

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `public static void createLocalDevRemoteSiteSetting(string endpoint)`

createReviewRemoteSiteSetting creates remote site setting for a Github / Circle CI review app by pull request number

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `public static void updateLocalDevDMSConfigURL(String endpoint)`

updateLocalDevDMSConfigURL - Updates ERP Domain Sandbox dmsConfig to review app URL

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `public static void createAccountingQACanvasApp(string prNumber)`

Creates a Canvas-enabled Connected App to interact with the Accounting Module

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `public static void createReviewRemoteSiteSetting(string prNumber)`

createReviewRemoteSiteSetting creates remote site setting for a Github / Circle CI review app by pull request number

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `public static void updateReviewDMSConfigURL(String prNumber)`

updateReviewDMSConfigURL - Updates ERP Domain Sandbox dmsConfig to review app URL

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

### `private static MetadataService canvasConfig(String prNumber)`

set connected app's Canvas Configuration Values

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

#### Returns

|Type|Description|
|---|---|
|`MetadataService`|return MetadataService.ConnectedAppCanvasConfig|

### `private static MetadataService localCanvasConfig(String endpoint)`

set connected app's Canvas Configuration Values

#### Parameters

|Param|Description|
|---|---|
|`prNumber`|Github pull request number|

#### Returns

|Type|Description|
|---|---|
|`MetadataService`|return MetadataService.ConnectedAppCanvasConfig|

### `private static MetadataService canvasOauthPolicy()`

set connected app's Oauth Configuration Values

#### Returns

|Type|Description|
|---|---|
|`MetadataService`|return MetadataService.ConnectedAppOauthPolicy|

### `private static MetadataService canvasOauthConfig()`
### `public static void handleSaveResults(MetadataService saveResult)`

Handles the Metadata save result

#### Parameters

|Param|Description|
|---|---|
|`saveResult`|saveResult|

---
## Classes
### OrgMetadataException

**Inheritance**

OrgMetadataException


---
