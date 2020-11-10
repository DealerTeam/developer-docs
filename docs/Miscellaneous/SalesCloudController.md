---
layout: default
---
# SalesCloudController class
---
## Methods
### `getConnectorStatus()` → `dealer__DMS_Settings__c`
### `getFields(String selectedObject)` → `List<fieldWrapper>`
### `getIconUrl(String objectName)` → `string`
### `getRoles(String selectedObject)` → `List<fieldWrapper>`
### `saveMappings(String selectedObject, List<fieldWrapper> mappedFields)` → `void`
### `updateSettings(string dmsId, boolean status)` → `void`
---
## Inner Classes

### SalesCloudController.fieldWrapper class
---
#### Constructors
##### `fieldWrapper()`
##### `fieldWrapper(String label, String Id)`
---
#### Properties

##### `fieldLabel` → `String`

##### `options` → `List<picklistWrapper>`

##### `role` → `String`

##### `sourceId` → `String`

##### `targetField` → `String`

##### `targetId` → `String`

---
### SalesCloudController.picklistWrapper class
---
#### Constructors
##### `picklistWrapper(String fLabel, String Name)`
---
#### Properties

##### `label` → `String`

##### `value` → `String`

---
