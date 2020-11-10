---
layout: default
---
# VINDecoder_EXT class

 VINDecoder_EXT - This standard controller extension of dealer__Vehicle_Inventory__c performs the decode actions applicable when saving a vehicle record 2016-04-30   |Jarrett Kuljis     |W-000178 Added check to Engine Max HP and related Decimal properties of the vehicle object to ensure the strings returned contain numberic values (engine.displacement.isNumeric()) NULL checked for sdat.engines and sdat.transmissions before looping over results Added try/catch blocks on insertion or update of data --

---
## Constructors
### `VINDecoder_EXT(ApexPages.StandardController stdController)`
---
## Properties

### `InstalledEquipment` → `List<VinDecoderAPI.`

### `IsStockBook` → `boolean`

### `ModelKeyList` → `List<VINDecoderDataObject.Style>`

### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`

### `SelectedStyleId` → `String`

### `dms` → `dealer__DMS_Settings__c`

### `engineSelect` → `List<SelectOption>`

### `isEdit` → `Boolean`

### `objStockWrapperList` → `List<VehicleInventoryAPI.StockNumberBookEntry>`

### `renderModalSection` → `Boolean`

### `renderModalSectionOne` → `Boolean`

### `selectedEngine` → `String`

### `selectedTransmission` → `String`

### `skipDecodeAction` → `Boolean`

### `transmissionSelect` → `List<SelectOption>`

### `veh` → `dealer__Vehicle_Inventory__c`

### `vinDecodeData` → `Object>`

---
## Methods
### `Save()` → `PageReference`
### `deriveStockNumber()` → `void`
### `doDecode(String VIN)` → `void`
### `doDecodePage()` → `PageReference`
### `doInit()` → `void`
### `editPage()` → `PageReference`
### `getDecode()` → `VINDecoderDataObject.DecodeData`
### `getEngineSelect()` → `List<SelectOption>`
### `getEngines()` → `List<VINDecoderDataObject.Engine>`
### `getInstalledEquipment()` → `List<VinDecoderAPI.InstalledEquipment>`
### `getModelKeyList()` → `List<VINDEcoderDataObject.Style>`
### `getOptEquip()` → `List<VinDecoderAPI.OptionalEquipment>`
### `getSelectedStyleId()` → `String`
### `getTransmissionSelect()` → `List<SelectOption>`
### `getTransmissions()` → `List<VINDecoderDataObject.Transmission>`
### `setSelectedStyleId(String SelectedStyleId)` → `void`
### `skipVinDecode()` → `PageReference`
---
