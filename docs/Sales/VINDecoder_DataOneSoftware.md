# VINDecoder_DataOneSoftware

`APIVERSION: 45`

`STATUS: ACTIVE`

**Group** Sales

## Fields

### `errorCodes` → `Map<String,String>`


---
## Classes
### BasicData
#### Properties

##### `body_subtype` → `String`


##### `body_type` → `String`


##### `brake_system` → `String`


##### `country_of_manufacture` → `String`


##### `doors` → `Integer`


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


##### `year` → `Integer`


---

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

##### `basic_data` → `BasicData`


##### `engines` → `EngineList[]`


##### `epa_fuel_efficiency` → `EPAFuelEfficiencyList[]`


##### `installed_equipment` → `InstalledEquipmentList[]`


##### `optional_equipment` → `OptionalEquipmentList[]`


##### `pricing` → `Pricing`


##### `transmissions` → `TransmissionList[]`


##### `warranties` → `WarrantyList[]`


---

### CommonPacks
#### Properties

##### `basic_data` → `String`


##### `colors` → `String`


##### `engines` → `String`


##### `fuel_efficiency` → `String`


##### `installed_equipment` → `String`


##### `optional_equipment` → `String`


##### `pricing` → `String`


##### `safety_equipment` → `String`


##### `specifications` → `String`


##### `transmissions` → `String`


##### `warranties` → `String`


---

### DecodeRequestStruct
#### Fields

##### `decoder_settings` → `DecoderSettings`


##### `query_requests` → `QueryRequests`


---

### DecodeResponseStruct
#### Fields

##### `decoder_messages` → `DecoderMessages`


##### `query_responses` → `QueryResponses`


---

### DecoderMessages
#### Properties

##### `decoder_error_list` → `List&lt;String&gt;`


##### `decoder_errors` → `String`


##### `decoder_version` → `String`


##### `service_provider` → `String`


---

### DecoderSettings
#### Fields

##### `common_data_packs` → `CommonPacks`


##### `style_data_packs` → `StylePacks`


---
#### Properties

##### `common_data` → `String`


##### `display` → `String`


##### `styles` → `String`


---

### EPAFuelEfficiencyList
#### Properties

##### `city` → `String`


##### `combined` → `String`


##### `engine_id` → `String`


##### `fuel_grade` → `String`


##### `fuel_type` → `String`


##### `highway` → `String`


##### `transmission_id` → `String`


---

### EngineList
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

### EngineParameters
#### Properties

##### `block_type` → `String`


##### `cylinders` → `String`


##### `description` → `String`


##### `displacement` → `String`


##### `fuel_type` → `String`


---

### ExtColor
#### Properties

##### `color_code` → `String`


##### `description` → `String`


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

### InstalledEquipmentDetails
#### Properties

##### `name` → `String`


##### `values` → `List&lt;String&gt;`


---

### InstalledEquipmentList
#### Properties

##### `category` → `String`


##### `equipment` → `List&lt;InstalledEquipmentDetails&gt;`


---

### IntColor
#### Properties

##### `color_code` → `String`


##### `description` → `String`


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

### OptionalEquipmentList
#### Properties

##### `category` → `String`


##### `options` → `List&lt;OptionalEquipmentDetails&gt;`


---

### Pricing
#### Properties

##### `destination_charge` → `String`


##### `gas_guzzler_tax` → `String`


##### `invoice_price` → `String`


##### `msrp` → `String`


---

### QueryError
#### Properties

##### `error_code` → `String`


##### `error_message` → `String`


---

### QueryRequests
#### Fields

##### `unique_request` → `RequestData`


---

### QueryResponses
#### Fields

##### `unique_request` → `ResponseData`


---

### RGB
#### Properties

##### `b` → `String`


##### `g` → `String`


##### `hex` → `String`


##### `r` → `String`


---

### RequestData
#### Fields

##### `engine` → `EngineParameters`


##### `exterior_color` → `ExtColor`


##### `interior_color` → `IntColor`


##### `transmission` → `TransmissionParameters`


---
#### Properties

##### `bedlength` → `String`


##### `body_type` → `String`


##### `doors` → `String`


##### `drive_type` → `String`


##### `installed_equipment_descriptions` → `String`


##### `invoice` → `String`


##### `make` → `String`


##### `model` → `String`


##### `model_number` → `String`


##### `msrp` → `String`


##### `optional_equipment_codes` → `String`


##### `package_code` → `String`


##### `trim` → `String`


##### `vehicle_type` → `String`


##### `vin` → `String`


##### `wheelbase` → `String`


##### `year` → `String`


---

### ResponseData
#### Constructors
##### `ResponseData()`
---
#### Properties

##### `common_data` → `CommonData`


##### `query_error` → `QueryError`


##### `styles` → `StyleData[]`


##### `transaction_id` → `String`


---

### RoofColors

### StyleData
#### Constructors
##### `StyleData()`
---
#### Properties

##### `basic_data` → `BasicData`


##### `colors` → `ColorData`


##### `complete` → `String`


##### `engines` → `EngineList[]`


##### `epa_fuel_efficiency` → `EPAFuelEfficiencyList[]`


##### `installed_equipment` → `InstalledEquipmentList[]`


##### `name` → `String`


##### `optional_equipment` → `OptionalEquipmentList[]`


##### `pricing` → `Pricing`


##### `transmissions` → `TransmissionList[]`


##### `vehicle_id` → `String`


##### `warranties` → `WarrantyList[]`


---

### StylePacks
#### Properties

##### `basic_data` → `String`


##### `colors` → `String`


##### `engines` → `String`


##### `fuel_efficiency` → `String`


##### `installed_equipment` → `String`


##### `optional_equipment` → `String`


##### `pricing` → `String`


##### `safety_equipment` → `String`


##### `specifications` → `String`


##### `transmissions` → `String`


##### `warranties` → `String`


---

### TransmissionList
#### Properties

##### `availability` → `String`


##### `brand` → `String`


##### `detail_type` → `String`


##### `gears` → `String`


##### `invoice_price` → `String`


##### `item_type` → `String`


##### `msrp` → `String`


##### `name` → `String`


##### `order_code` → `String`


##### `transmission_id` → `String`


---

### TransmissionParameters
#### Properties

##### `description` → `String`


##### `trans_speeds` → `String`


##### `trans_type` → `String`


---

### WarrantyList
#### Properties

##### `item_type` → `String`


##### `miles` → `String`


##### `months` → `String`


##### `name` → `String`


---

---
