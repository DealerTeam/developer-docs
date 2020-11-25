---
layout: default
---
# PartInventoryControl class
---
## Constructors
### `PartInventoryControl()`
---
## Enums
### Methods

---
## Methods
### `costBasis(Id partId, Decimal qtyRequested)` → `invControl`

 	Process the matched matched list to provide valid cost

#### Parameters
|Param|Description|
|-----|-----------|
|`List` |  	:	List of part inventory history to set cost by |
|`Decimal` |  	:	Number of items requested, this can impact partial lines |

### `inventoryControlMethod()` → `String`

 	Get Cost Method as Defined in the Custom Setting @test PartPhysicalServiceLayer.testPartInventoryControl

### `inventoryCostPremise(String method, Id inventoryId, Decimal qtyRequested)` → `List<dealer__Part_Inventory_History__c>`

 	List of inventory history purchase events that will be 		used to prepare the cost valuations

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  	: 	Method name for inventory cost valuation |
|`Id` |  		:	Part Inventory record Id |
|`Decimal` |  	:	number of items requested.  This can force span |

### `methodValid(String s)` → `boolean`

 True / False to check if the inventory method requested exists

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  	:	The string to check if matched against the |

### `reversePartSale(Id eId)` → `Boolean`
### `setTransactionEventId(invControl i, Id eId)` → `invControl`
---
## Inner Classes

### PartInventoryControl.InventoryControlException class

 	Append the cost values, quantity adjsuted and cost releived of the associated parts list 	@param List

---
### PartInventoryControl.invControl class

 Wrapper Class @test PartPhysicalServiceLayer.testPartInventoryControl

---
#### Constructors
##### `invControl(Decimal invValue, List<dealer__Part_Inventory_History__c> invHistory)`
---
#### Properties

##### `history` → `List<dealer__Part_Inventory_History__c>`

##### `value` → `Decimal`

---
