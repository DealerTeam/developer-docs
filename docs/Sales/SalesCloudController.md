---
layout: default
---
# SalesCloudController



**Group** Sales

## Methods
### `public static string getIconUrl(String objectName)`

`AURAENABLED`
### `public static DMSConfig__mdt getConnectorStatus()`

`AURAENABLED`
### `public static void updateSettings(string dmsId, boolean status)`

`AURAENABLED`
### `public static List<fieldWrapper> getFields(String selectedObject)`

`AURAENABLED`
### `public static void saveMappings(String selectedObject, List<fieldWrapper> mappedFields)`

`AURAENABLED`
### `public static List<fieldWrapper> getRoles(String selectedObject)`

`AURAENABLED`
### `private static List<picklistWrapper> getRolePickList(String obj)`

Private method to handle getting the picklist values available to Partner Roles & Opp Contact Roles

---
## Classes
### fieldWrapper
#### Constructors
##### `public fieldWrapper()`
##### `public fieldWrapper(String label, String Id)`
---
#### Properties

##### `public fieldLabel` → `String`

`AURAENABLED` 

##### `public sourceId` → `String`

`AURAENABLED` 

##### `public targetField` → `String`

`AURAENABLED` 

##### `public targetId` → `String`

`AURAENABLED` 

##### `public role` → `String`

`AURAENABLED` 

##### `public options` → `List&lt;picklistWrapper&gt;`

`AURAENABLED` 

---

### picklistWrapper
#### Constructors
##### `public picklistWrapper(String fLabel, String Name)`
---
#### Properties

##### `public label` → `String`

`AURAENABLED` 

##### `public value` → `String`

`AURAENABLED` 

---

---
