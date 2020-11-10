---
layout: default
---
# VINDecoder class
---
## Constructors
### `VINDecoder()`
---
## Properties

### `decode` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`

### `decodeData` → `VINDecoderDataObject.DecodeData`

### `decodeError` → `String`

### `modelKeys` → `>`

### `payload` → `String`

### `res` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`

### `result` → `String`

### `vinObject` → `>`

### `vinjson` → `String`

---
## Methods
### `DecodeVIN(String VIN)` → `void`
### `SelectedStyle(String styleId)` → `VinDecoderDataObject.Style`
### `StyleDat(String styleID)` → `VINDecoder_DataOneSoftware.`
### `buildRequest()` → `HttpRequest`
### `deserializeResponse(String JSONResponse)` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`
### `doVINDecodeCallout(String VIN)` → `String`
### `getActiveSettings()` → `void`
### `invokeWebService(Http h, HttpRequest req)` → `HttpResponse`
### `sanitizeJSON(String JSONResponse)` → `String`
### `saveVINDecodeResults(VINDecoder_DataOneSoftware.DecodeResponseStruct decodedObject, String VIN, String StockNumber)` → `void`
### `serializeRequest(String VIN)` → `String`
---
## Inner Classes

### VINDecoder.EquipmentItem class
---
### VINDecoder.VINDecoderException class
---
