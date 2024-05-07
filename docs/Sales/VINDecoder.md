---
layout: default
---
# VINDecoder



**Group** Sales

## Constructors
### `global VINDecoder()`
---
## Fields

### `public vinjson` → `String`


### `public result` → `String`


### `public payload` → `String`


### `global decodeError` → `String`


### `public vinObject` → `Map<String,Object>`


### `global modelKeys` → `List<VINDecoder_DataOneSoftware.StyleData>`

`DEPRECATED` 

### `global decode` → `VINDecoder_DataOneSoftware`

`DEPRECATED` 

### `global res` → `VINDecoder_DataOneSoftware`

`DEPRECATED` 

### `public decodeData` → `VINDecoderDataObject`


### `private Tres` → `VINDecoder_DataOneSoftware`


### `private Tvinjson` → `String`


### `private Tresult` → `String`


### `private Tpayload` → `String`


---
## Methods
### `global void DecodeVIN(String VIN)`
### `public String doVINDecodeCallout(String VIN)`
### `public VinDecoderDataObject SelectedStyle(String styleId)`
### `public void getActiveSettings()`
### `global VINDecoder_DataOneSoftware StyleDat(String styleID)`

`DEPRECATED`
### `public HttpRequest buildRequest()`
### `public HttpResponse invokeWebService(Http h, HttpRequest req)`
### `public String serializeRequest(String VIN)`
### `public VINDecoder_DataOneSoftware deserializeResponse(String JSONResponse)`
### `public void saveVINDecodeResults(VINDecoder_DataOneSoftware decodedObject, String VIN, String StockNumber)`
### `public String sanitizeJSON(String JSONResponse)`
---
## Classes
### EquipmentItem

### VINDecoderException

**Inheritance**

VINDecoderException


---
