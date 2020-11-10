---
layout: default
---
# LocationFeesCreateController class

@description

---
## Methods
### `deleteLocationFeeFromMaster(String feeMasterId, String locationId)` → `void`
### `doCreateFee(Id locationId, String feeJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

### `getFeeData(String locId)` → `LocationFees`
### `getLocationAssignment(String feeMasterId)` → `LocationAssignment`
### `getLocationFees(Id locationId)` → `Dealer_Location__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getLocations()` → `List<Dealer_Location__c>`
### `getTabURLSync(String sobjectName)` → `string`
### `getTabUrl(String sobjectName)` → `String`
### `saveEdit(Id locationId, String feeJSON)` → `Dealer_Location__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |
|`` | N |

---
## Inner Classes

### LocationFeesCreateController.LocationAssignment class
---
#### Constructors
##### `LocationAssignment(String feeMasterId)`
---
#### Properties

##### `availableLocations` → `List<Dealer_Location__c>`

##### `feeMaster` → `FeeMaster__c`

##### `selectedLocations` → `List<Dealer_Location__c>`

---
### LocationFeesCreateController.LocationFees class

Nested wrapper class

---
#### Constructors
##### `LocationFees(String locId)`
---
#### Properties

##### `availableFees` → `List<FeeMaster__c>`

List of form sobjects available for printing

##### `selectedFees` → `List<LocationFee__c>`

List of form reference of selected forms

---
