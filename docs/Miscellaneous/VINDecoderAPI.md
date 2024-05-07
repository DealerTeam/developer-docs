---
layout: default
---
# VINDecoderAPI
## Methods
### `public static String DoCallout(String VIN)`
### `public static Map<Id,List<Decode_Values__b>> decodedEquipment(Set<Id> serviceVehicleIds)`

Retrieves a map of the decoded equipment from a set of Service Vehicles


**Method** decodedEquipment

### `public static void storeDecodeData(Id serviceVehicleId, Id vehicleInventoryId, String installedEquipment, String optionalEquipment)`

`FUTURE`
### `public static void sendErrorEmail(Id serviceVehicleId, List<String> errors)`
---
## Classes
### InstalledEquipment
#### Constructors
##### `public InstalledEquipment(Boolean selected, String category, String name, String description)`
---
#### Properties

##### `public selected` → `Boolean`


##### `public category` → `String`


##### `public name` → `String`


##### `public description` → `String`


---

### OptionalEquipment
#### Constructors
##### `public OptionalEquipment(Boolean selected, String category, String name, String description, String installedBy, String orderCode, String optionId)`
---
#### Properties

##### `public selected` → `Boolean`


##### `public category` → `String`


##### `public name` → `String`


##### `public description` → `String`


##### `public installedBy` → `String`


##### `public orderCode` → `String`


##### `public optionId` → `String`


---

### VINDecoderAPIException

**Inheritance**

VINDecoderAPIException


---
