---
layout: default
---
# VINDecoder_EXT_Tech class
---
## Constructors
### `VINDecoder_EXT_Tech(ApexPages.StandardController stdController)`
---
## Properties

### `AllEquip` → `Set<String>`

### `InstalledEquipment` → `List<VinDecoderAPI.`

### `LstObjOE` → `List<dealer__Custom_Equipment__c>`

### `LstTemplateEquip` → `List<VinDecoderAPI.OptionalEquipment>`

### `ModelKeyList` → `>`

### `SelectedStyleId` → `String`

### `SetOptionId` → `Set<String>`

### `VehEquipment` → `List<dealer__Vehicle_Equipment__c>`

### `dms` → `dealer__DMS_Settings__c`

### `engineSelect` → `List<SelectOption>`

### `mapTempByEquip` → `List<VinDecoderAPI.OptionalEquipment>>`

### `selectedEngine` → `String`

### `selectedTransmission` → `String`

### `skipDecodeAction` → `Boolean`

### `transmissionSelect` → `List<SelectOption>`

### `vd` → `VINDecoder`

### `veh` → `dealer__Vehicle_Inventory__c`

---
## Methods
### `Save()` → `PageReference`
### `doDecode(String VIN)` → `void`
### `doDecodePage()` → `PageReference`
### `editPage()` → `PageReference`
### `getDecode()` → `VINDecoderDataObject.DecodeData`
### `getEngineSelect()` → `List<SelectOption>`
### `getEngines()` → `List<VINDecoderDataObject.Engine>`
### `getInstalledEquipment()` → `List<VinDecoderAPI.InstalledEquipment>`
### `getLstTemplateEquip()` → `List<VinDecoderAPI.OptionalEquipment>`
### `getModelKeyList()` → `List<VINDecoderDataObject.Style>`
### `getSelectedStyleId()` → `String`
### `getTransmissionSelect()` → `List<SelectOption>`
### `getTransmissions()` → `List<VINDecoderDataObject.Transmission>`
### `setSelectedStyleId(String SelectedStyleId)` → `void`
### `skipVinDecode()` → `PageReference`
---
