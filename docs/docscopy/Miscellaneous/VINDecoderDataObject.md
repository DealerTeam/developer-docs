---
layout: default
---
# VINDecoderDataObject class
---
## Inner Classes

### VINDecoderDataObject.ColorData class
---
#### Constructors
##### `ColorData()`
---
#### Properties

##### `exterior_colors` → `List<ExteriorColors>`

##### `interior_colors` → `List<InteriorColors>`

##### `roof_colors` → `List<RoofColors>`

---
### VINDecoderDataObject.CommonData class
---
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
### VINDecoderDataObject.DecodeData class
---
#### Constructors
##### `DecodeData()`
---
#### Properties

##### `common_data` → `CommonData`

##### `error` → `Error`

##### `styles` → `Style[]`

##### `transaction_id` → `String`

---
### VINDecoderDataObject.Engine class
---
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
### VINDecoderDataObject.Error class
---
#### Properties

##### `error_code` → `String`

##### `error_message` → `String`

---
### VINDecoderDataObject.ExteriorColors class
---
#### Properties

##### `generic_color_name` → `String`

##### `mfr_code` → `String`

##### `mfr_color_name` → `String`

##### `primary_rgb_code` → `RGB`

##### `secondary_rgb_code` → `RGB`

##### `two_tone` → `String`

---
### VINDecoderDataObject.FuelEfficiency class
---
#### Properties

##### `city` → `Decimal`

##### `combined` → `Decimal`

##### `engine_id` → `String`

##### `fuel_grade` → `String`

##### `fuel_type` → `String`

##### `highway` → `Decimal`

##### `transmission_id` → `String`

---
### VINDecoderDataObject.InstalledEquipment class
---
#### Properties

##### `category` → `String`

##### `equipment` → `List<InstalledEquipmentDetails>`

---
### VINDecoderDataObject.InstalledEquipmentDetails class
---
#### Properties

##### `name` → `String`

##### `values` → `List<String>`

---
### VINDecoderDataObject.InteriorColors class
---
#### Properties

##### `generic_color_name` → `String`

##### `mfr_code` → `String`

##### `mfr_color_name` → `String`

##### `primary_rgb_code` → `RGB`

##### `secondary_rgb_code` → `RGB`

##### `two_tone` → `String`

---
### VINDecoderDataObject.OptionalEquipment class
---
#### Properties

##### `category` → `String`

##### `options` → `List<OptionalEquipmentDetails>`

---
### VINDecoderDataObject.OptionalEquipmentDetails class
---
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
### VINDecoderDataObject.Pricing class
---
#### Properties

##### `destination_charge` → `Decimal`

##### `gas_guzzler_tax` → `Decimal`

##### `invoice_price` → `Decimal`

##### `msrp` → `Decimal`

---
### VINDecoderDataObject.RGB class
---
#### Properties

##### `b` → `pu`

##### `g` → `Strin`

##### `hex` → `String`

##### `r` → `St`

---
### VINDecoderDataObject.RoofColors class
---
### VINDecoderDataObject.Style class
---
#### Properties

##### `basic_data` → `CommonData`

##### `complete` → `String`

##### `engines` → `List<Engine>`

##### `epa_fuel_efficiency` → `List<FuelEfficiency>`

##### `installed_equipment` → `List<InstalledEquipment>`

##### `name` → `String`

##### `optional_equipment` → `List<OptionalEquipment>`

##### `pricing` → `Pricing`

##### `transmissions` → `List<Transmission>`

##### `vehicle_id` → `String`

---
### VINDecoderDataObject.Transmission class
---
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
