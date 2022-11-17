# ServiceVehicle_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `ServiceVehicle_EXT(ApexPages.standardController controller)`
---
## Fields

### `InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `SelectedStyleId` → `String`


### `engineSelect` → `List<SelectOption>`


### `suId` → `String`


### `sv` → `Service_Vehicle__c`


### `svId` → `String`


### `transmissionSelect` → `List<SelectOption>`


### `vd` → `VINDecoder`


---
## Properties

### `selectedEngine` → `String`


### `selectedTransmission` → `String`


---
## Methods
### `doDecode(String VIN)`
### `doDecodePage()`
### `vinNotPresent()`
### `editPage()`
### `Save()`
### `redirectToBack()`
### `getsvEquip()`
### `updateVehicle()`
### `getModelKeyList()`
### `getDecode()`
### `getSelectedStyleId()`
### `setSelectedStyleId(String SelectedStyleId)`
### `getEngineSelect()`
### `getTransmissionSelect()`
### `getOptEquip()`
### `getInstalledEquipment()`
---
## Classes
### IE
#### Properties

##### `category` → `String`


##### `description` → `String`


##### `name` → `String`


##### `selected` → `Boolean`


---

### OE
#### Properties

##### `category` → `string`


##### `description` → `String`


##### `installedBy` → `String`


##### `name` → `String`


##### `optionId` → `String`


##### `orderCode` → `String`


##### `selected` → `Boolean`


---

---
