---
layout: default
---
# ExternalMediaController class
---
## Methods
### `deleteMedia(String mediaId)` → `string`
### `getMedia(String recordId)` → `string`
### `retrieveMedia(String fileName)` → `string`
### `saveMedia(String recordId, String response, String fileName)` → `string`
### `uploadMedia(String base64, Boolean publiclyAccessible)` → `string`
---
## Inner Classes

### ExternalMediaController.s3File class
---
#### Properties

##### `Bucket` → `String`

##### `ETag` → `String`

##### `Key` → `String`

##### `Location` → `String`

##### `ServerSideEncryption` → `String`

##### `VersionId` → `String`

---
### ExternalMediaController.s3Response class
---
#### Properties

##### `file` → `s3File`

##### `image` → `s3File`

##### `thumb` → `s3File`

---
