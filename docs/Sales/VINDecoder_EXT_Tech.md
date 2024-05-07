---
layout: default
---
# VINDecoder_EXT_Tech



**Group** Sales

## Constructors
### `public VINDecoder_EXT_Tech(ApexPages stdController)`
---
## Fields

### `public veh` → `dealer__Vehicle_Inventory__c`


### `private ddat` → `VINDecoderDataObject`

`TESTVISIBLE` 

### `private sdat` → `VINDEcoderDataObject`

`TESTVISIBLE` 

### `public ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `public engineSelect` → `List<SelectOption>`


### `public transmissionSelect` → `List<SelectOption>`


### `public SelectedStyleId` → `String`


### `public LstTemplateEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `public InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `public vd` → `VINDecoder`


### `public skipDecodeAction` → `Boolean`


### `public VehEquipment` → `List<dealer__Vehicle_Equipment__c>`


### `public LstObjOE` → `List<dealer__Custom_Equipment__c>`


### `public SetOptionId` → `Set<String>`


---
## Properties

### `public dms` → `dealer__DMS_Settings__c`


### `public selectedEngine` → `String`


### `public selectedTransmission` → `String`


### `public AllEquip` → `Set<String>`


### `public mapTempByEquip` → `map<String,List<VinDecoderAPI.OptionalEquipment>>`


---
## Methods
### `public void doDecode(String VIN)`
### `public PageReference doDecodePage()`
### `public PageReference skipVinDecode()`
### `public PageReference editPage()`
### `public List<VinDecoderAPI.OptionalEquipment> getLstTemplateEquip()`
### `public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment()`
### `public List<VINDecoderDataObject.Style> getModelKeyList()`
### `public VINDecoderDataObject getDecode()`
### `public List<VINDecoderDataObject.Engine> getEngines()`
### `public List<SelectOption> getEngineSelect()`
### `public List<VINDecoderDataObject.Transmission> getTransmissions()`
### `public List<SelectOption> getTransmissionSelect()`
### `public String getSelectedStyleId()`
### `public void setSelectedStyleId(String SelectedStyleId)`
### `public PageReference Save()`
---
