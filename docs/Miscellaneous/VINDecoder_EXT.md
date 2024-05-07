---
layout: default
---
# VINDecoder_EXT
## Constructors
### `public VINDecoder_EXT(ApexPages stdController)`
---
## Fields

### `private ddat` → `VINDecoderDataObject`

`TESTVISIBLE` 

### `private sdat` → `VINDEcoderDataObject`

`TESTVISIBLE` 

### `public ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `public engineSelect` → `List<SelectOption>`


### `public transmissionSelect` → `List<SelectOption>`


### `public vinDecodeData` → `Map<String,Object>`


### `public OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `public InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `private vd` → `VINDecoder`

`TESTVISIBLE` 

### `public skipDecodeAction` → `Boolean`


---
## Properties

### `public veh` → `dealer__Vehicle_Inventory__c`


### `public IsStockBook` → `boolean`


### `public dms` → `dealer__DMS_Settings__c`


### `public selectedEngine` → `String`


### `public selectedTransmission` → `String`


### `public SelectedStyleId` → `String`


### `public objStockWrapperList` → `List<VehicleInventoryAPI.StockNumberBookEntry>`


### `public renderModalSection` → `Boolean`


### `public renderModalSectionOne` → `Boolean`


### `public isEdit` → `Boolean`


---
## Methods
### `public void deriveStockNumber()`
### `public void doInit()`
### `public void doDecode(String VIN)`
### `public PageReference doDecodePage()`
### `public PageReference skipVinDecode()`
### `public PageReference editPage()`
### `public List<VinDecoderAPI.OptionalEquipment> getOptEquip()`
### `public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment()`
### `public List<VINDEcoderDataObject.Style> getModelKeyList()`
### `public VINDecoderDataObject getDecode()`
### `public List<VINDecoderDataObject.Engine> getEngines()`
### `public List<SelectOption> getEngineSelect()`
### `public List<VINDecoderDataObject.Transmission> getTransmissions()`
### `public List<SelectOption> getTransmissionSelect()`
### `public String getSelectedStyleId()`
### `public void setSelectedStyleId(String SelectedStyleId)`
### `public PageReference Save()`
---
