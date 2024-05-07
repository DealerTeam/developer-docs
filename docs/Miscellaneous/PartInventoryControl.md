---
layout: default
---
# PartInventoryControl
## Constructors
### `global PartInventoryControl()`
---
## Methods
### `global static boolean methodValid(String s)`

True / False to check if the inventory method requested exists

#### Parameters

|Param|Description|
|---|---|
|`String`|:	The string to check if matched against the global enumeration of available methods|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean 	:	True if method exists, false if it does not|


**Test** PartPhysicalServiceLayer.testPartInventoryControl

### `global static List<dealer__Part_Inventory_History__c> inventoryCostPremise(String method, Id inventoryId, Decimal qtyRequested)`

List of inventory history purchase events that will be used to prepare the cost valuations

#### Parameters

|Param|Description|
|---|---|
|`String`|: 	Method name for inventory cost valuation|
|`Id`|:	Part Inventory record Id|
|`Decimal`|:	number of items requested.  This can force span across multiple purchase events|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Part_Inventory_History__c>`|List 	:	List of inventory history events that corrospond to the purchase events.|


**Test** PartPhysicalServiceLayer.testPartInventoryControl

### `global static String inventoryControlMethod()`

Get Cost Method as Defined in the Custom Setting


**Test** PartPhysicalServiceLayer.testPartInventoryControl

### `global static invControl costBasis(Id partId, Decimal qtyRequested)`

Process the matched matched list to provide valid cost

#### Parameters

|Param|Description|
|---|---|
|`List`|:	List of part inventory history to set cost by|
|`Decimal`|:	Number of items requested, this can impact partial lines|


**Returm** Decimal :	Value of the list of parts by their costs


**Test** PartPhysicalServiceLayer.testPartInventoryControl

### `global static invControl setTransactionEventId(invControl i, Id eId)`
### `global static Boolean reversePartSale(Id eId)`
---
## Enums
### Methods

---
## Classes
### invControl
#### Constructors
##### `global invControl(Decimal invValue, List&lt;dealer__Part_Inventory_History__c&gt; invHistory)`
---
#### Properties

##### `global value` → `Decimal`


##### `global history` → `List&lt;dealer__Part_Inventory_History__c&gt;`


---

### InventoryControlException

**Inheritance**

InventoryControlException


---
