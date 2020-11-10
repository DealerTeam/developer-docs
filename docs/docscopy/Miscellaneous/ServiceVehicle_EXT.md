---
layout: default
---
# ServiceVehicle_EXT class
---
## Constructors
### `ServiceVehicle_EXT(ApexPages.standardController controller)`
---
## Properties

### `InstalledEquipment` → `VinDecoderAPI.`

### `ModelKeyList` → `>`

### `OptEquip` → `>`

### `SelectedStyleId` → `String`

### `engineSelect` → `>`

### `selectedEngine` → `String`

### `selectedTransmission` → `String`

### `suId` → `String`

### `sv` → `Service_Vehicle__c`

### `svId` → `String`

### `transmissionSelect` → `>`

### `vd` → `VINDecoder`

---
## Methods
### `Save()` → `PageReference`
### `doDecode(String VIN)` → `void`
### `doDecodePage()` → `PageReference`
### `editPage()` → `PageReference`
### `getDecode()` → `VINDecoderDataObject.DecodeData`
### `getEngineSelect()` → `>`
### `getInstalledEquipment()` → `>`
### `getModelKeyList()` → `>`
### `getOptEquip()` → `>`
### `getSelectedStyleId()` → `String`
### `getTransmissionSelect()` → `>`
### `getsvEquip()` → `>`
### `redirectToBack()` → `pageReference`
### `setSelectedStyleId(String SelectedStyleId)` → `void`
### `updateVehicle()` → `PageReference`
### `vinNotPresent()` → `PageReference`
---
## Inner Classes

### ServiceVehicle_EXT.IE class
---
#### Properties

##### `category` → `String`

##### `description` → `String`

##### `name` → `String`

##### `selected` → `Boolean`

---
### ServiceVehicle_EXT.OE class
---
#### Properties

##### `category` → `string`

##### `description` → `String`

##### `installedBy` → `String`

##### `name` → `String`

##### `optionId` → `String`

##### `orderCode` → `String`

##### `selected` → `Boolean`

---
