# VINDecoderDataObject

`APIVERSION: 45`

`STATUS: ACTIVE`

**Group** Sales

## Methods
### `convertDecodeData(Object obj)`

Used to provide custom mapping and return the expected data points for creating and updating sObjects

#### Parameters

|Param|Description|
|---|---|
|`obj`|obj description|

#### Return

**Type**

Object

**Description**

return description


**Method** convertDecodeData

---
## Classes
### ColorData
#### Constructors
##### `ColorData()`
---
#### Properties

##### `exterior_colors` → `List&lt;ExteriorColors&gt;`

`AURAENABLED` 

##### `interior_colors` → `List&lt;InteriorColors&gt;`

`AURAENABLED` 

##### `roof_colors` → `List&lt;RoofColors&gt;`

`AURAENABLED` 

---

### CommonData
#### Properties

##### `body_subtype` → `String`

`AURAENABLED` 

##### `body_type` → `String`

`AURAENABLED` 

##### `brake_system` → `String`

`AURAENABLED` 

##### `country_of_manufacture` → `String`

`AURAENABLED` 

##### `doors` → `String`

`AURAENABLED` 

##### `drive_type` → `String`

`AURAENABLED` 

##### `make` → `String`

`AURAENABLED` 

##### `market` → `String`

`AURAENABLED` 

##### `model` → `String`

`AURAENABLED` 

##### `model_number` → `String`

`AURAENABLED` 

##### `package_code` → `String`

`AURAENABLED` 

##### `plant` → `String`

`AURAENABLED` 

##### `restraint_type` → `String`

`AURAENABLED` 

##### `trim` → `String`

`AURAENABLED` 

##### `vehicle_type` → `String`

`AURAENABLED` 

##### `year` → `String`

`AURAENABLED` 

---

### DecodeData
#### Constructors
##### `DecodeData()`
---
#### Properties

##### `common_data` → `CommonData`

`AURAENABLED` 

##### `error` → `Error`

`AURAENABLED` 

##### `styles` → `Style[]`

`AURAENABLED` 

##### `transaction_id` → `String`

`AURAENABLED` 

---

### Engine
#### Properties

##### `aspiration` → `String`

`AURAENABLED` 

##### `availability` → `String`

`AURAENABLED` 

##### `block_type` → `String`

`AURAENABLED` 

##### `bore` → `String`

`AURAENABLED` 

##### `brand` → `String`

`AURAENABLED` 

##### `cam_type` → `String`

`AURAENABLED` 

##### `compression` → `String`

`AURAENABLED` 

##### `cylinders` → `String`

`AURAENABLED` 

##### `displacement` → `String`

`AURAENABLED` 

##### `engine_id` → `String`

`AURAENABLED` 

##### `fuel_induction` → `String`

`AURAENABLED` 

##### `fuel_quality` → `String`

`AURAENABLED` 

##### `fuel_type` → `String`

`AURAENABLED` 

##### `invoice_price` → `String`

`AURAENABLED` 

##### `marketing_name` → `String`

`AURAENABLED` 

##### `max_hp` → `String`

`AURAENABLED` 

##### `max_hp_at` → `String`

`AURAENABLED` 

##### `max_payload` → `String`

`AURAENABLED` 

##### `max_torque` → `String`

`AURAENABLED` 

##### `max_torque_at` → `String`

`AURAENABLED` 

##### `msrp` → `String`

`AURAENABLED` 

##### `name` → `String`

`AURAENABLED` 

##### `oil_capacity` → `String`

`AURAENABLED` 

##### `order_code` → `String`

`AURAENABLED` 

##### `redline` → `String`

`AURAENABLED` 

##### `stroke` → `String`

`AURAENABLED` 

##### `valve_timing` → `String`

`AURAENABLED` 

##### `valves` → `String`

`AURAENABLED` 

---

### Error
#### Properties

##### `error_code` → `String`

`AURAENABLED` 

##### `error_message` → `String`

`AURAENABLED` 

---

### ExteriorColors
#### Properties

##### `generic_color_name` → `String`

`AURAENABLED` 

##### `mfr_code` → `String`

`AURAENABLED` 

##### `mfr_color_name` → `String`

`AURAENABLED` 

##### `primary_rgb_code` → `RGB`

`AURAENABLED` 

##### `secondary_rgb_code` → `RGB`

`AURAENABLED` 

##### `two_tone` → `String`

`AURAENABLED` 

---

### FuelEfficiency
#### Properties

##### `city` → `Decimal`

`AURAENABLED` 

##### `combined` → `Decimal`

`AURAENABLED` 

##### `engine_id` → `String`

`AURAENABLED` 

##### `fuel_grade` → `String`

`AURAENABLED` 

##### `fuel_type` → `String`

`AURAENABLED` 

##### `highway` → `Decimal`

`AURAENABLED` 

##### `transmission_id` → `String`

`AURAENABLED` 

---

### InstalledEquipment
#### Properties

##### `category` → `String`

`AURAENABLED` 

##### `equipment` → `List&lt;InstalledEquipmentDetails&gt;`

`AURAENABLED` 

---

### InstalledEquipmentDetails
#### Properties

##### `name` → `String`

`AURAENABLED` 

##### `values` → `List&lt;String&gt;`

`AURAENABLED` 

---

### InteriorColors
#### Properties

##### `generic_color_name` → `String`

`AURAENABLED` 

##### `mfr_code` → `String`

`AURAENABLED` 

##### `mfr_color_name` → `String`

`AURAENABLED` 

##### `primary_rgb_code` → `RGB`

`AURAENABLED` 

##### `secondary_rgb_code` → `RGB`

`AURAENABLED` 

##### `two_tone` → `String`

`AURAENABLED` 

---

### OptionalEquipment
#### Properties

##### `category` → `String`

`AURAENABLED` 

##### `options` → `List&lt;OptionalEquipmentDetails&gt;`

`AURAENABLED` 

---

### OptionalEquipmentDetails
#### Properties

##### `description` → `String`

`AURAENABLED` 

##### `install_type` → `String`

`AURAENABLED` 

##### `installed` → `String`

`AURAENABLED` 

##### `invoice_price` → `String`

`AURAENABLED` 

##### `msrp` → `String`

`AURAENABLED` 

##### `name` → `String`

`AURAENABLED` 

##### `option_id` → `String`

`AURAENABLED` 

##### `order_code` → `String`

`AURAENABLED` 

---

### Pricing
#### Properties

##### `destination_charge` → `Decimal`

`AURAENABLED` 

##### `gas_guzzler_tax` → `Decimal`

`AURAENABLED` 

##### `invoice_price` → `Decimal`

`AURAENABLED` 

##### `msrp` → `Decimal`

`AURAENABLED` 

---

### RGB
#### Properties

##### `b` → `String`

`AURAENABLED` 

##### `g` → `String`

`AURAENABLED` 

##### `hex` → `String`

`AURAENABLED` 

##### `r` → `String`

`AURAENABLED` 

---

### RoofColors

### Style
#### Properties

##### `basic_data` → `CommonData`

`AURAENABLED` 

##### `complete` → `String`

`AURAENABLED` 

##### `engines` → `List&lt;Engine&gt;`

`AURAENABLED` 

##### `epa_fuel_efficiency` → `List&lt;FuelEfficiency&gt;`

`AURAENABLED` 

##### `installed_equipment` → `List&lt;InstalledEquipment&gt;`

`AURAENABLED` 

##### `name` → `String`

`AURAENABLED` 

##### `optional_equipment` → `List&lt;OptionalEquipment&gt;`

`AURAENABLED` 

##### `pricing` → `Pricing`

`AURAENABLED` 

##### `transmissions` → `List&lt;Transmission&gt;`

`AURAENABLED` 

##### `vehicle_id` → `String`

`AURAENABLED` 

---

### Transmission
#### Properties

##### `availability` → `String`

`AURAENABLED` 

##### `brand` → `String`

`AURAENABLED` 

##### `detail_type` → `String`

`AURAENABLED` 

##### `gears` → `String`

`AURAENABLED` 

##### `invoice_price` → `String`

`AURAENABLED` 

##### `msrp` → `String`

`AURAENABLED` 

##### `name` → `String`

`AURAENABLED` 

##### `order_code` → `String`

`AURAENABLED` 

##### `transmission_id` → `String`

`AURAENABLED` 

##### `type` → `String`

`AURAENABLED` 

---

---
