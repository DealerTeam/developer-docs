---
layout: default
---
# LocationFeesCreateController



**Class** LocationFeesCreateController


**Group** Sales

## Methods
### `public static List<Dealer_Location__c> getLocations()`

`AURAENABLED`
#### Returns

|Type|Description|
|---|---|
|`List<Dealer_Location__c>`|List<Dealer_Location__c>|


**Method** getLocations

### `public static String doCreateFee(Id locationId, String feeJSON)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||
|`feeJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** doCreateFee

### `public static Dealer_Location__c getLocationFees(Id locationId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|


**Method** getLocationFees

### `public static String getTabUrl(String sobjectName)`

`AURAENABLED`
### `public static string getTabURLSync(String sobjectName)`

`AURAENABLED`
### `public static Dealer_Location__c saveEdit(Id locationId, String feeJSON)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||
|`feeJSON`||

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|


**Method** saveEdit

### `public static LocationAssignment getLocationAssignment(String feeMasterId)`

`AURAENABLED`
### `public static void deleteLocationFeeFromMaster(String feeMasterId, String locationId)`

`AURAENABLED`
### `public static LocationFee__c getLocationFee(String locationId, String feeMasterId)`

`AURAENABLED`
---
## Classes
### LocationFees

Nested wrapper class

#### Constructors
##### `public LocationFees(String locId)`
---
#### Properties

##### `public availableRecords` → `List&lt;FeeMaster__c&gt;`

`AURAENABLED` 

List of form sobjects available for printing

##### `public selectedFees` → `List&lt;LocationFee__c&gt;`

`AURAENABLED` 

List of form reference of selected forms

---

### LocationAssignment
#### Constructors
##### `public LocationAssignment(String feeMasterId)`
---
#### Fields

##### `public feeMaster` → `FeeMaster__c`

`AURAENABLED` 

##### `public availableLocations` → `List&lt;Dealer_Location__c&gt;`

`AURAENABLED` 

##### `public selectedLocations` → `List&lt;Dealer_Location__c&gt;`

`AURAENABLED` 

---

---
