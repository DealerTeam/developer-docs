# VINDecoder_DataOneSoftware class
---
## Properties

### `errorCodes` → `Map<String, String>`

---
## Inner Classes

### VINDecoder_DataOneSoftware.BasicData class
---
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
### VINDecoder_DataOneSoftware.ColorData class
---
#### Constructors
##### `ColorData()`
---
#### Properties

##### `exterior_colors` → `List<ExteriorColors>`

##### `interior_colors` → `List<InteriorColors>`

##### `roof_colors` → `List<RoofColors>`

---
### VINDecoder_DataOneSoftware.CommonData class
---
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
### VINDecoder_DataOneSoftware.CommonPacks class
---
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
### VINDecoder_DataOneSoftware.DecodeRequestStruct class
---
#### Properties

##### `decoder_settings` → `DecoderSettings`

##### `query_requests` → `QueryRequests`

---
### VINDecoder_DataOneSoftware.DecodeResponseStruct class
---
#### Properties

##### `decoder_messages` → `DecoderMessages`

##### `query_responses` → `QueryResponses`

---
### VINDecoder_DataOneSoftware.DecoderMessages class
---
#### Properties

##### `decoder_error_list` → `List<String>`

##### `decoder_errors` → `String`

##### `decoder_version` → `String`

##### `service_provider` → `String`

---
### VINDecoder_DataOneSoftware.DecoderSettings class
---
#### Properties

##### `common_data` → `String`

##### `common_data_packs` → `CommonPacks`

##### `display` → `String`

##### `style_data_packs` → `StylePacks`

##### `styles` → `String`

---
### VINDecoder_DataOneSoftware.EPAFuelEfficiencyList class
---
#### Properties

##### `city` → `String`

##### `combined` → `String`

##### `engine_id` → `String`

##### `fuel_grade` → `String`

##### `fuel_type` → `String`

##### `highway` → `String`

##### `transmission_id` → `String`

---
### VINDecoder_DataOneSoftware.EngineList class
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
### VINDecoder_DataOneSoftware.EngineParameters class
---
#### Properties

##### `block_type` → `String`

##### `cylinders` → `String`

##### `description` → `String`

##### `displacement` → `String`

##### `fuel_type` → `String`

---
### VINDecoder_DataOneSoftware.ExtColor class
---
#### Properties

##### `color_code` → `String`

##### `description` → `String`

---
### VINDecoder_DataOneSoftware.ExteriorColors class
---
#### Properties

##### `generic_color_name` → `String`

##### `mfr_code` → `String`

##### `mfr_color_name` → `String`

##### `primary_rgb_code` → `RGB`

##### `secondary_rgb_code` → `RGB`

##### `two_tone` → `String`

---
### VINDecoder_DataOneSoftware.InstalledEquipmentDetails class
---
#### Properties

##### `name` → `String`

##### `values` → `List<String>`

---
### VINDecoder_DataOneSoftware.InstalledEquipmentList class
---
#### Properties

##### `category` → `String`

##### `equipment` → `List<InstalledEquipmentDetails>`

---
### VINDecoder_DataOneSoftware.IntColor class
---
#### Properties

##### `color_code` → `String`

##### `description` → `String`

---
### VINDecoder_DataOneSoftware.InteriorColors class
---
#### Properties

##### `generic_color_name` → `String`

##### `mfr_code` → `String`

##### `mfr_color_name` → `String`

##### `primary_rgb_code` → `RGB`

##### `secondary_rgb_code` → `RGB`

##### `two_tone` → `String`

---
### VINDecoder_DataOneSoftware.OptionalEquipmentDetails class
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
### VINDecoder_DataOneSoftware.OptionalEquipmentList class
---
#### Properties

##### `category` → `String`

##### `options` → `List<OptionalEquipmentDetails>`

---
### VINDecoder_DataOneSoftware.Pricing class
---
#### Properties

##### `destination_charge` → `String`

##### `gas_guzzler_tax` → `String`

##### `invoice_price` → `String`

##### `msrp` → `String`

---
### VINDecoder_DataOneSoftware.QueryError class
---
#### Properties

##### `error_code` → `String`

##### `error_message` → `String`

---
### VINDecoder_DataOneSoftware.QueryRequests class
---
#### Properties

##### `unique_request` → `RequestData`

---
### VINDecoder_DataOneSoftware.QueryResponses class
---
#### Properties

##### `unique_request` → `ResponseData`

---
### VINDecoder_DataOneSoftware.RGB class
---
#### Properties

##### `b` → `glo`

##### `g` → ``

##### `hex` → `String`

##### `r` → `St`

---
### VINDecoder_DataOneSoftware.RequestData class
---
#### Properties

##### `bedlength` → `String`

##### `body_type` → `String`

##### `doors` → `String`

##### `drive_type` → `String`

##### `engine` → `EngineParameters`

##### `exterior_color` → `ExtColor`

##### `installed_equipment_descriptions` → `String`

##### `interior_color` → `IntColor`

##### `invoice` → `String`

##### `make` → `String`

##### `model` → `String`

##### `model_number` → `String`

##### `msrp` → `String`

##### `optional_equipment_codes` → `String`

##### `package_code` → `String`

##### `transmission` → `TransmissionParameters`

##### `trim` → `String`

##### `vehicle_type` → `String`

##### `vin` → `String`

##### `wheelbase` → `String`

##### `year` → `String`

---
### VINDecoder_DataOneSoftware.ResponseData class
---
#### Constructors
##### `ResponseData()`
---
#### Properties

##### `common_data` → `CommonData`

##### `query_error` → `QueryError`

##### `styles` → `StyleData[]`

##### `transaction_id` → `String`

---
### VINDecoder_DataOneSoftware.RoofColors class
---
### VINDecoder_DataOneSoftware.StyleData class
---
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
### VINDecoder_DataOneSoftware.StylePacks class
---
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
### VINDecoder_DataOneSoftware.TransmissionList class
---
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
### VINDecoder_DataOneSoftware.TransmissionParameters class
---
#### Properties

##### `description` → `String`

##### `trans_speeds` → `String`

##### `trans_type` → `String`

---
### VINDecoder_DataOneSoftware.WarrantyList class
---
#### Properties

##### `item_type` → `String`

##### `miles` → `String`

##### `months` → `String`

##### `name` → `String`

---
