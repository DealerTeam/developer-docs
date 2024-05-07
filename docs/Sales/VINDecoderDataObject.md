---
layout: default
---
# virtual VINDecoderDataObject



**Group** Sales

## Methods
### `global virtual Object convertDecodeData(Object obj)`

Used to provide custom mapping and return the expected data points for creating and updating sObjects

#### Parameters

|Param|Description|
|---|---|
|`obj`|obj description|

#### Returns

|Type|Description|
|---|---|
|`Object`|return description|


**Method** convertDecodeData

---
## Classes
### DecodeData
#### Constructors
##### `global DecodeData()`
---
#### Properties

##### `global transaction_id` → `String`

`AURAENABLED` 

##### `global error` → `Error`

`AURAENABLED` 

##### `global common_data` → `CommonData`

`AURAENABLED` 

##### `global styles` → `Style`

`AURAENABLED` 

---

### Error
#### Properties

##### `global error_code` → `String`

`AURAENABLED` 

##### `global error_message` → `String`

`AURAENABLED` 

---

### CommonData
#### Properties

##### `global market` → `String`

`AURAENABLED` 

##### `global year` → `String`

`AURAENABLED` 

##### `global make` → `String`

`AURAENABLED` 

##### `global model` → `String`

`AURAENABLED` 

##### `global trim` → `String`

`AURAENABLED` 

##### `global vehicle_type` → `String`

`AURAENABLED` 

##### `global body_type` → `String`

`AURAENABLED` 

##### `global body_subtype` → `String`

`AURAENABLED` 

##### `global doors` → `String`

`AURAENABLED` 

##### `global model_number` → `String`

`AURAENABLED` 

##### `global package_code` → `String`

`AURAENABLED` 

##### `global drive_type` → `String`

`AURAENABLED` 

##### `global brake_system` → `String`

`AURAENABLED` 

##### `global restraint_type` → `String`

`AURAENABLED` 

##### `global country_of_manufacture` → `String`

`AURAENABLED` 

##### `global plant` → `String`

`AURAENABLED` 

##### `global trailer_type` → `String`

`AURAENABLED` 

##### `global trailer_subtype` → `String`

`AURAENABLED` 

---

### Style
#### Properties

##### `global name` → `String`

`AURAENABLED` 

##### `global vehicle_id` → `String`

`AURAENABLED` 

##### `global complete` → `String`

`AURAENABLED` 

##### `global basic_data` → `CommonData`

`AURAENABLED` 

##### `global pricing` → `Pricing`

`AURAENABLED` 

##### `global engines` → `List&lt;Engine&gt;`

`AURAENABLED` 

##### `global transmissions` → `List&lt;Transmission&gt;`

`AURAENABLED` 

##### `global installed_equipment` → `List&lt;InstalledEquipment&gt;`

`AURAENABLED` 

##### `global optional_equipment` → `List&lt;OptionalEquipment&gt;`

`AURAENABLED` 

##### `global epa_fuel_efficiency` → `List&lt;FuelEfficiency&gt;`

`AURAENABLED` 

---

### Pricing
#### Properties

##### `global msrp` → `Decimal`

`AURAENABLED` 

##### `global invoice_price` → `Decimal`

`AURAENABLED` 

##### `global destination_charge` → `Decimal`

`AURAENABLED` 

##### `global gas_guzzler_tax` → `Decimal`

`AURAENABLED` 

---

### Engine
#### Properties

##### `global name` → `String`

`AURAENABLED` 

##### `global brand` → `String`

`AURAENABLED` 

##### `global engine_id` → `String`

`AURAENABLED` 

##### `global availability` → `String`

`AURAENABLED` 

##### `global aspiration` → `String`

`AURAENABLED` 

##### `global block_type` → `String`

`AURAENABLED` 

##### `global bore` → `String`

`AURAENABLED` 

##### `global cam_type` → `String`

`AURAENABLED` 

##### `global compression` → `String`

`AURAENABLED` 

##### `global cylinders` → `String`

`AURAENABLED` 

##### `global displacement` → `String`

`AURAENABLED` 

##### `global fuel_induction` → `String`

`AURAENABLED` 

##### `global fuel_quality` → `String`

`AURAENABLED` 

##### `global fuel_type` → `String`

`AURAENABLED` 

##### `global msrp` → `String`

`AURAENABLED` 

##### `global invoice_price` → `String`

`AURAENABLED` 

##### `global marketing_name` → `String`

`AURAENABLED` 

##### `global max_hp` → `String`

`AURAENABLED` 

##### `global max_hp_at` → `String`

`AURAENABLED` 

##### `global max_payload` → `String`

`AURAENABLED` 

##### `global max_torque` → `String`

`AURAENABLED` 

##### `global max_torque_at` → `String`

`AURAENABLED` 

##### `global oil_capacity` → `String`

`AURAENABLED` 

##### `global order_code` → `String`

`AURAENABLED` 

##### `global redline` → `String`

`AURAENABLED` 

##### `global stroke` → `String`

`AURAENABLED` 

##### `global valve_timing` → `String`

`AURAENABLED` 

##### `global valves` → `String`

`AURAENABLED` 

---

### Transmission
#### Properties

##### `global brand` → `String`

`AURAENABLED` 

##### `global name` → `String`

`AURAENABLED` 

##### `global msrp` → `String`

`AURAENABLED` 

##### `global transmission_id` → `String`

`AURAENABLED` 

##### `global availability` → `String`

`AURAENABLED` 

##### `global type` → `String`

`AURAENABLED` 

##### `global detail_type` → `String`

`AURAENABLED` 

##### `global gears` → `String`

`AURAENABLED` 

##### `global invoice_price` → `String`

`AURAENABLED` 

##### `global order_code` → `String`

`AURAENABLED` 

---

### InstalledEquipment
#### Properties

##### `global category` → `String`

`AURAENABLED` 

##### `global equipment` → `List&lt;InstalledEquipmentDetails&gt;`

`AURAENABLED` 

---

### InstalledEquipmentDetails
#### Properties

##### `global name` → `String`

`AURAENABLED` 

##### `global values` → `List&lt;String&gt;`

`AURAENABLED` 

---

### OptionalEquipment
#### Properties

##### `global category` → `String`

`AURAENABLED` 

##### `global options` → `List&lt;OptionalEquipmentDetails&gt;`

`AURAENABLED` 

---

### OptionalEquipmentDetails
#### Properties

##### `global name` → `String`

`AURAENABLED` 

##### `global option_id` → `String`

`AURAENABLED` 

##### `global order_code` → `String`

`AURAENABLED` 

##### `global installed` → `String`

`AURAENABLED` 

##### `global install_type` → `String`

`AURAENABLED` 

##### `global invoice_price` → `String`

`AURAENABLED` 

##### `global msrp` → `String`

`AURAENABLED` 

##### `global description` → `String`

`AURAENABLED` 

---

### ColorData
#### Constructors
##### `global ColorData()`
---
#### Properties

##### `global exterior_colors` → `List&lt;ExteriorColors&gt;`

`AURAENABLED` 

##### `global interior_colors` → `List&lt;InteriorColors&gt;`

`AURAENABLED` 

##### `global roof_colors` → `List&lt;RoofColors&gt;`

`AURAENABLED` 

---

### ExteriorColors
#### Properties

##### `global mfr_code` → `String`

`AURAENABLED` 

##### `global two_tone` → `String`

`AURAENABLED` 

##### `global generic_color_name` → `String`

`AURAENABLED` 

##### `global mfr_color_name` → `String`

`AURAENABLED` 

##### `global primary_rgb_code` → `RGB`

`AURAENABLED` 

##### `global secondary_rgb_code` → `RGB`

`AURAENABLED` 

---

### InteriorColors
#### Properties

##### `global mfr_code` → `String`

`AURAENABLED` 

##### `global two_tone` → `String`

`AURAENABLED` 

##### `global generic_color_name` → `String`

`AURAENABLED` 

##### `global mfr_color_name` → `String`

`AURAENABLED` 

##### `global primary_rgb_code` → `RGB`

`AURAENABLED` 

##### `global secondary_rgb_code` → `RGB`

`AURAENABLED` 

---

### RoofColors

### FuelEfficiency
#### Properties

##### `global engine_id` → `String`

`AURAENABLED` 

##### `global transmission_id` → `String`

`AURAENABLED` 

##### `global fuel_type` → `String`

`AURAENABLED` 

##### `global fuel_grade` → `String`

`AURAENABLED` 

##### `global city` → `Decimal`

`AURAENABLED` 

##### `global highway` → `Decimal`

`AURAENABLED` 

##### `global combined` → `Decimal`

`AURAENABLED` 

---

### RGB
#### Properties

##### `global r` → `String`

`AURAENABLED` 

##### `global g` → `String`

`AURAENABLED` 

##### `global b` → `String`

`AURAENABLED` 

##### `global hex` → `String`

`AURAENABLED` 

---

---
