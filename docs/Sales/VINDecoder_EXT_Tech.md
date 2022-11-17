# VINDecoder_EXT_Tech

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `VINDecoder_EXT_Tech(ApexPages.StandardController stdController)`
---
## Fields

### `InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `LstObjOE` → `List<dealer__Custom_Equipment__c>`


### `LstTemplateEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `SelectedStyleId` → `String`


### `SetOptionId` → `Set<String>`


### `VehEquipment` → `List<dealer__Vehicle_Equipment__c>`


### `engineSelect` → `List<SelectOption>`


### `skipDecodeAction` → `Boolean`


### `transmissionSelect` → `List<SelectOption>`


### `vd` → `VINDecoder`


### `veh` → `dealer__Vehicle_Inventory__c`


---
## Properties

### `AllEquip` → `Set<String>`


### `dms` → `dealer__DMS_Settings__c`


### `mapTempByEquip` → `map<String,List<VinDecoderAPI.OptionalEquipment>>`


### `selectedEngine` → `String`


### `selectedTransmission` → `String`


---
## Methods
### `doDecode(String VIN)`
### `doDecodePage()`
### `skipVinDecode()`
### `editPage()`
### `getLstTemplateEquip()`
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
