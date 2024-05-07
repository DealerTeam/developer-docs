---
layout: default
---
# VINDecoder_DataOneSoftware



**Group** Sales

## Fields

### `global errorCodes` → `Map<String,String>`


---
## Classes
### DecodeRequestStruct
#### Fields

##### `global decoder_settings` → `DecoderSettings`


##### `global query_requests` → `QueryRequests`


---

### DecodeResponseStruct
#### Fields

##### `global decoder_messages` → `DecoderMessages`


##### `global query_responses` → `QueryResponses`


---

### DecoderMessages
#### Properties

##### `global service_provider` → `String`


##### `global decoder_version` → `String`


##### `global decoder_errors` → `String`


##### `global decoder_error_list` → `List&lt;String&gt;`


---

### QueryResponses
#### Fields

##### `global unique_request` → `ResponseData`


---

### ResponseData
#### Constructors
##### `global ResponseData()`
---
#### Properties

##### `global transaction_id` → `String`


##### `global query_error` → `QueryError`


##### `global styles` → `StyleData`


##### `global common_data` → `CommonData`


---

### QueryError
#### Properties

##### `global error_code` → `String`


##### `global error_message` → `String`


---

### CommonData
#### Properties

##### `global basic_data` → `BasicData`


##### `global pricing` → `Pricing`


##### `global engines` → `EngineList`


##### `global transmissions` → `TransmissionList`


##### `global warranties` → `WarrantyList`


##### `global epa_fuel_efficiency` → `EPAFuelEfficiencyList`


##### `global optional_equipment` → `OptionalEquipmentList`


##### `global installed_equipment` → `InstalledEquipmentList`


---

### StyleData
#### Constructors
##### `global StyleData()`
---
#### Properties

##### `global name` → `String`


##### `global vehicle_id` → `String`


##### `global complete` → `String`


##### `global basic_data` → `BasicData`


##### `global pricing` → `Pricing`


##### `global engines` → `EngineList`


##### `global transmissions` → `TransmissionList`


##### `global warranties` → `WarrantyList`


##### `global epa_fuel_efficiency` → `EPAFuelEfficiencyList`


##### `global optional_equipment` → `OptionalEquipmentList`


##### `global installed_equipment` → `InstalledEquipmentList`


##### `global colors` → `ColorData`


---

### BasicData
#### Properties

##### `global market` → `String`


##### `global year` → `Integer`


##### `global make` → `String`


##### `global model` → `String`


##### `global trim` → `String`


##### `global vehicle_type` → `String`


##### `global body_type` → `String`


##### `global body_subtype` → `String`


##### `global doors` → `Integer`


##### `global model_number` → `String`


##### `global package_code` → `String`


##### `global drive_type` → `String`


##### `global brake_system` → `String`


##### `global restraint_type` → `String`


##### `global country_of_manufacture` → `String`


##### `global plant` → `String`


---

### Pricing
#### Properties

##### `global msrp` → `String`


##### `global invoice_price` → `String`


##### `global destination_charge` → `String`


##### `global gas_guzzler_tax` → `String`


---

### EngineList
#### Properties

##### `global name` → `String`


##### `global brand` → `String`


##### `global engine_id` → `String`


##### `global availability` → `String`


##### `global aspiration` → `String`


##### `global block_type` → `String`


##### `global bore` → `String`


##### `global cam_type` → `String`


##### `global compression` → `String`


##### `global cylinders` → `String`


##### `global displacement` → `String`


##### `global fuel_induction` → `String`


##### `global fuel_quality` → `String`


##### `global fuel_type` → `String`


##### `global msrp` → `String`


##### `global invoice_price` → `String`


##### `global marketing_name` → `String`


##### `global max_hp` → `String`


##### `global max_hp_at` → `String`


##### `global max_payload` → `String`


##### `global max_torque` → `String`


##### `global max_torque_at` → `String`


##### `global oil_capacity` → `String`


##### `global order_code` → `String`


##### `global redline` → `String`


##### `global stroke` → `String`


##### `global valve_timing` → `String`


##### `global valves` → `String`


---

### TransmissionList
#### Properties

##### `global name` → `String`


##### `global brand` → `String`


##### `global msrp` → `String`


##### `global transmission_id` → `String`


##### `global availability` → `String`


##### `global item_type` → `String`


##### `global detail_type` → `String`


##### `global gears` → `String`


##### `global invoice_price` → `String`


##### `global order_code` → `String`


---

### WarrantyList
#### Properties

##### `global name` → `String`


##### `global item_type` → `String`


##### `global months` → `String`


##### `global miles` → `String`


---

### EPAFuelEfficiencyList
#### Properties

##### `global engine_id` → `String`


##### `global transmission_id` → `String`


##### `global fuel_type` → `String`


##### `global fuel_grade` → `String`


##### `global city` → `String`


##### `global highway` → `String`


##### `global combined` → `String`


---

### OptionalEquipmentList
#### Properties

##### `global category` → `String`


##### `global options` → `List&lt;OptionalEquipmentDetails&gt;`


---

### OptionalEquipmentDetails
#### Properties

##### `global name` → `String`


##### `global option_id` → `String`


##### `global order_code` → `String`


##### `global installed` → `String`


##### `global install_type` → `String`


##### `global invoice_price` → `String`


##### `global msrp` → `String`


##### `global description` → `String`


---

### InstalledEquipmentList
#### Properties

##### `global category` → `String`


##### `global equipment` → `List&lt;InstalledEquipmentDetails&gt;`


---

### InstalledEquipmentDetails
#### Properties

##### `global name` → `String`


##### `global values` → `List&lt;String&gt;`


---

### ColorData
#### Constructors
##### `global ColorData()`
---
#### Properties

##### `global exterior_colors` → `List&lt;ExteriorColors&gt;`


##### `global interior_colors` → `List&lt;InteriorColors&gt;`


##### `global roof_colors` → `List&lt;RoofColors&gt;`


---

### ExteriorColors
#### Properties

##### `global mfr_code` → `String`


##### `global two_tone` → `String`


##### `global generic_color_name` → `String`


##### `global mfr_color_name` → `String`


##### `global primary_rgb_code` → `RGB`


##### `global secondary_rgb_code` → `RGB`


---

### InteriorColors
#### Properties

##### `global mfr_code` → `String`


##### `global two_tone` → `String`


##### `global generic_color_name` → `String`


##### `global mfr_color_name` → `String`


##### `global primary_rgb_code` → `RGB`


##### `global secondary_rgb_code` → `RGB`


---

### RoofColors

### RGB
#### Properties

##### `global r` → `String`


##### `global g` → `String`


##### `global b` → `String`


##### `global hex` → `String`


---

### QueryRequests
#### Fields

##### `global unique_request` → `RequestData`


---

### RequestData
#### Fields

##### `global engine` → `EngineParameters`


##### `global transmission` → `TransmissionParameters`


##### `global interior_color` → `IntColor`


##### `global exterior_color` → `ExtColor`


---
#### Properties

##### `global vin` → `String`


##### `global year` → `String`


##### `global make` → `String`


##### `global model` → `String`


##### `global trim` → `String`


##### `global model_number` → `String`


##### `global package_code` → `String`


##### `global drive_type` → `String`


##### `global vehicle_type` → `String`


##### `global body_type` → `String`


##### `global doors` → `String`


##### `global bedlength` → `String`


##### `global wheelbase` → `String`


##### `global msrp` → `String`


##### `global invoice` → `String`


##### `global optional_equipment_codes` → `String`


##### `global installed_equipment_descriptions` → `String`


---

### EngineParameters
#### Properties

##### `global description` → `String`


##### `global block_type` → `String`


##### `global cylinders` → `String`


##### `global displacement` → `String`


##### `global fuel_type` → `String`


---

### TransmissionParameters
#### Properties

##### `global description` → `String`


##### `global trans_type` → `String`


##### `global trans_speeds` → `String`


---

### IntColor
#### Properties

##### `global description` → `String`


##### `global color_code` → `String`


---

### ExtColor
#### Properties

##### `global description` → `String`


##### `global color_code` → `String`


---

### DecoderSettings
#### Fields

##### `global style_data_packs` → `StylePacks`


##### `global common_data_packs` → `CommonPacks`


---
#### Properties

##### `global display` → `String`


##### `global styles` → `String`


##### `global common_data` → `String`


---

### StylePacks
#### Properties

##### `global basic_data` → `String`


##### `global pricing` → `String`


##### `global engines` → `String`


##### `global transmissions` → `String`


##### `global specifications` → `String`


##### `global installed_equipment` → `String`


##### `global optional_equipment` → `String`


##### `global colors` → `String`


##### `global safety_equipment` → `String`


##### `global warranties` → `String`


##### `global fuel_efficiency` → `String`


---

### CommonPacks
#### Properties

##### `global basic_data` → `String`


##### `global pricing` → `String`


##### `global engines` → `String`


##### `global transmissions` → `String`


##### `global specifications` → `String`


##### `global installed_equipment` → `String`


##### `global optional_equipment` → `String`


##### `global colors` → `String`


##### `global safety_equipment` → `String`


##### `global warranties` → `String`


##### `global fuel_efficiency` → `String`


---

---
