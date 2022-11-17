# ExternalMediaController

`APIVERSION: 46`

`STATUS: ACTIVE`
## Methods
### `static getMedia(String recordId)`

`AURAENABLED`
### `static uploadMedia(String base64, Boolean publiclyAccessible)`

`AURAENABLED`
### `static saveMedia(String recordId, String response, String fileName)`

`AURAENABLED`
### `static retrieveMedia(String fileName)`

`AURAENABLED`
### `static deleteMedia(String mediaId)`

`AURAENABLED`
---
## Classes
### s3File
#### Fields

##### `Bucket` → `String`

`AURAENABLED` 

##### `ETag` → `String`

`AURAENABLED` 

##### `Key` → `String`

`AURAENABLED` 

##### `Location` → `String`

`AURAENABLED` 

##### `ServerSideEncryption` → `String`

`AURAENABLED` 

##### `VersionId` → `String`

`AURAENABLED` 

---

### s3Response
#### Fields

##### `file` → `s3File`

`AURAENABLED` 

##### `image` → `s3File`

`AURAENABLED` 

##### `thumb` → `s3File`

`AURAENABLED` 

---

---
