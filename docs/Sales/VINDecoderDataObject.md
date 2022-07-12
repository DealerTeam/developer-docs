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


##### `interior_colors` → `List&lt;InteriorColors&gt;`


##### `roof_colors` → `List&lt;RoofColors&gt;`


---

### CommonData
#### Properties

##### `body_subtype` → `String`


##### `body_type` → `String`


##### `brake_system` → `String`


##### `country_of_manufacture` → `String`


##### `doors` → `String`


##### `drive_type` → `String`


##### `make` → `String`


##### `market` → `String`


##### `model` → `String`


##### `model_number` → `String`


##### `package_code` → `String`


##### `plant` → `String`


##### `restraint_type` → `String`


##### `trim` → `String`


##### `vehicle_type` → `String`


##### `year` → `String`


---

### DecodeData
#### Constructors
##### `DecodeData()`
---
#### Properties

##### `common_data` → `CommonData`


##### `error` → `Error`


##### `styles` → `Style[]`


##### `transaction_id` → `String`


---

### Engine
#### Properties

##### `aspiration` → `String`


##### `availability` → `String`


##### `block_type` → `String`


##### `bore` → `String`


##### `brand` → `String`


##### `cam_type` → `String`


##### `compression` → `String`


##### `cylinders` → `String`


##### `displacement` → `String`


##### `engine_id` → `String`


##### `fuel_induction` → `String`


##### `fuel_quality` → `String`


##### `fuel_type` → `String`


##### `invoice_price` → `String`


##### `marketing_name` → `String`


##### `max_hp` → `String`


##### `max_hp_at` → `String`


##### `max_payload` → `String`


##### `max_torque` → `String`


##### `max_torque_at` → `String`


##### `msrp` → `String`


##### `name` → `String`


##### `oil_capacity` → `String`


##### `order_code` → `String`


##### `redline` → `String`


##### `stroke` → `String`


##### `valve_timing` → `String`


##### `valves` → `String`


---

### Error
#### Properties

##### `error_code` → `String`


##### `error_message` → `String`


---

### ExteriorColors
#### Properties

##### `generic_color_name` → `String`


##### `mfr_code` → `String`


##### `mfr_color_name` → `String`


##### `primary_rgb_code` → `RGB`


##### `secondary_rgb_code` → `RGB`


##### `two_tone` → `String`


---

### FuelEfficiency
#### Properties

##### `city` → `Decimal`


##### `combined` → `Decimal`


##### `engine_id` → `String`


##### `fuel_grade` → `String`


##### `fuel_type` → `String`


##### `highway` → `Decimal`


##### `transmission_id` → `String`


---

### InstalledEquipment
#### Properties

##### `category` → `String`


##### `equipment` → `List&lt;InstalledEquipmentDetails&gt;`


---

### InstalledEquipmentDetails
#### Properties

##### `name` → `String`


##### `values` → `List&lt;String&gt;`


---

### InteriorColors
#### Properties

##### `generic_color_name` → `String`


##### `mfr_code` → `String`


##### `mfr_color_name` → `String`


##### `primary_rgb_code` → `RGB`


##### `secondary_rgb_code` → `RGB`


##### `two_tone` → `String`


---

### OptionalEquipment
#### Properties

##### `category` → `String`


##### `options` → `List&lt;OptionalEquipmentDetails&gt;`


---

### OptionalEquipmentDetails
#### Properties

##### `description` → `String`


##### `install_type` → `String`


##### `installed` → `String`


##### `invoice_price` → `String`


##### `msrp` → `String`


##### `name` → `String`


##### `option_id` → `String`


##### `order_code` → `String`


---

### Pricing
#### Properties

##### `destination_charge` → `Decimal`


##### `gas_guzzler_tax` → `Decimal`


##### `invoice_price` → `Decimal`


##### `msrp` → `Decimal`


---

### RGB
#### Properties

##### `b` → `String`


##### `g` → `String`


##### `hex` → `String`


##### `r` → `String`


---

### RoofColors

### Style
#### Properties

##### `basic_data` → `CommonData`


##### `complete` → `String`


##### `engines` → `List&lt;Engine&gt;`


##### `epa_fuel_efficiency` → `List&lt;FuelEfficiency&gt;`


##### `installed_equipment` → `List&lt;InstalledEquipment&gt;`


##### `name` → `String`


##### `optional_equipment` → `List&lt;OptionalEquipment&gt;`


##### `pricing` → `Pricing`


##### `transmissions` → `List&lt;Transmission&gt;`


##### `vehicle_id` → `String`


---

### Transmission
#### Properties

##### `availability` → `String`


##### `brand` → `String`


##### `detail_type` → `String`


##### `gears` → `String`


##### `invoice_price` → `String`


##### `msrp` → `String`


##### `name` → `String`


##### `order_code` → `String`


##### `transmission_id` → `String`


##### `type` → `String`


---

---
