---
layout: default
---
# DynamicRecordController class
---
## Methods
### `getFieldSet(Id recordId, String fieldName, String fieldSetName)` → `dynamicWrapper`

: Processes inputs to return information about a related record.

#### Parameters
|Param|Description|
|-----|-----------|
|`:` |  recordId - Id of the record referencing the related record |
|`:` |  fieldName - API name of the target field to display related data |
|`:` |  fieldSetName - API name of a field set on target object that controls which fields are displayed |

---
## Inner Classes

### DynamicRecordController.dynamicWrapper class

Wrapper class that holds information needed to display fields on LWC

---
#### Properties

##### `fields` → `List<SalesUpController.fieldSetWrapper>`

##### `objType` → `String`

##### `recordData` → `sObject`

##### `recordId` → `String`

---
