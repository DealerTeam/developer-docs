# VINDecoder_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `VINDecoder_EXT(ApexPages.StandardController stdController)`
---
## Fields

### `InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `engineSelect` → `List<SelectOption>`


### `skipDecodeAction` → `Boolean`


### `transmissionSelect` → `List<SelectOption>`


### `vinDecodeData` → `Map<String,Object>`


---
## Properties

### `IsStockBook` → `boolean`


### `SelectedStyleId` → `String`


### `dms` → `dealer__DMS_Settings__c`


### `isEdit` → `Boolean`


### `objStockWrapperList` → `List<VehicleInventoryAPI.StockNumberBookEntry>`


### `renderModalSection` → `Boolean`


### `renderModalSectionOne` → `Boolean`


### `selectedEngine` → `String`


### `selectedTransmission` → `String`


### `veh` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `deriveStockNumber()`
### `doInit()`
### `doDecode(String VIN)`
### `doDecodePage()`
### `skipVinDecode()`
### `editPage()`
### `getOptEquip()`
### `getInstalledEquipment()`
### `getModelKeyList()`
### `getDecode()`
### `getEngines()`
### `getEngineSelect()`
### `getTransmissions()`
### `getTransmissionSelect()`
### `getSelectedStyleId()`
### `setSelectedStyleId(String SelectedStyleId)`
### `Save()`
---
