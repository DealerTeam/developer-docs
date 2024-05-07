---
layout: default
---
# NumericPrecision

: This class is used to define the precision of the numeric fields.


**Test** FormServiceLayer

## Methods
### `public static List<sObject> castNumericFields(String customObjectApiName, List<sObject> records)`

: This method is used to cast the numeric fields to the specified precision and scale.

#### Parameters

|Param|Description|
|---|---|
|`customObjectApiName`|: The API name of the custom object.|
|`recordObject`|: The record object to be processed.|

#### Returns

|Type|Description|
|---|---|
|`List<sObject>`|: A map containing the adjusted values.|


**Test** FormServiceLayer.testCastNumericFieldsValidInput, FormServiceLayer.testCastNumericFieldsNullInput, FormServiceLayer.testCastNumericFieldsInvalidObjectApiName

---
