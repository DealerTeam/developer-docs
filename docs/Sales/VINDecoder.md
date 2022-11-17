# VINDecoder

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `VINDecoder()`
---
## Fields

### `decode` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`

`DEPRECATED` 

### `decodeData` → `VINDecoderDataObject.DecodeData`


### `decodeError` → `String`


### `modelKeys` → `List<VINDecoder_DataOneSoftware.StyleData>`

`DEPRECATED` 

### `payload` → `String`


### `res` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`

`DEPRECATED` 

### `result` → `String`


### `vinObject` → `Map<String,Object>`


### `vinjson` → `String`


---
## Methods
### `DecodeVIN(String VIN)`
### `doVINDecodeCallout(String VIN)`
### `SelectedStyle(String styleId)`
### `getActiveSettings()`
### `StyleDat(String styleID)`

`DEPRECATED`
### `buildRequest()`
### `invokeWebService(Http h, HttpRequest req)`
### `serializeRequest(String VIN)`
### `deserializeResponse(String JSONResponse)`
### `saveVINDecodeResults(VINDecoder_DataOneSoftware.DecodeResponseStruct decodedObject, String VIN, String StockNumber)`
### `sanitizeJSON(String JSONResponse)`
---
## Classes
### EquipmentItem

### VINDecoderException

**Inheritance**

VINDecoderException


---
