---
layout: default
---
# ServiceVehicle_EXT



**Group** Service

## Constructors
### `public ServiceVehicle_EXT(ApexPages controller)`
---
## Fields

### `public sv` → `Service_Vehicle__c`


### `private ddat` → `VINDecoderDataObject`

`TESTVISIBLE` 

### `private sdat` → `VINDEcoderDataObject`

`TESTVISIBLE` 

### `public ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `public OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `public InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `public SelectedStyleId` → `String`


### `public engineSelect` → `List<SelectOption>`


### `public transmissionSelect` → `List<SelectOption>`


### `public svId` → `String`


### `public suId` → `String`


### `public vd` → `VINDecoder`


---
## Properties

### `public selectedEngine` → `String`


### `public selectedTransmission` → `String`


---
## Methods
### `public void doDecode(String VIN)`
### `public PageReference doDecodePage()`
### `public PageReference vinNotPresent()`
### `public PageReference editPage()`
### `public PageReference Save()`
### `public pageReference redirectToBack()`
### `public List<Service_Vehicle_Equipment__c> getsvEquip()`
### `public PageReference updateVehicle()`
### `public List<VINDEcoderDataObject.Style> getModelKeyList()`
### `public VINDecoderDataObject getDecode()`
### `public String getSelectedStyleId()`
### `public void setSelectedStyleId(String SelectedStyleId)`
### `public List<SelectOption> getEngineSelect()`
### `public List<SelectOption> getTransmissionSelect()`
### `public List<VinDecoderAPI.OptionalEquipment> getOptEquip()`
### `public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment()`
---
## Classes
### OE
#### Properties

##### `public selected` → `Boolean`


##### `public category` → `string`


##### `public name` → `String`


##### `public description` → `String`


##### `public installedBy` → `String`


##### `public orderCode` → `String`


##### `public optionId` → `String`


---

### IE
#### Properties

##### `public selected` → `Boolean`


##### `public category` → `String`


##### `public name` → `String`


##### `public description` → `String`


---

---
