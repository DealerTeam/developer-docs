---
layout: default
---
# PartsMovementController
## Methods
### `public static Boolean movePartsBin(String fromBin, String toBin, String partId, Integer qty, String mfgCode)`

`AURAENABLED`

Move a specified number of non-serialized ledgers from one bin to another

#### Parameters

|Param|Description|
|---|---|
|`fromBin`|Bin where ledgers are currently present|
|`toBin`|Bin where ledgers are to be moved|
|`partId`|Parts Inventory UPC/Raw Part No./Id to transfer|
|`qty`|Number of ledgers to transfer|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Returns true if transaction succeeds|

### `public static Parts_Inventory__c getPartByMaster(String masterUPC, String mfgCode)`

`AURAENABLED`

Queries for a Parts Inventory matching the Parts Master and User Location

#### Parameters

|Param|Description|
|---|---|
|`masterUPC`|Parts Master UPC/Part No./Id to query|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`Parts_Inventory__c`|return description|

### `public static List<Parts_Invoice_Line__c> getPartLines(Id invoiceId)`

`AURAENABLED`

Queries Parts Invoice Lines in an Allocated or Partial status

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Invoice Id used to query lines|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|

### `public static List<Parts_Ledger__c> getLedgersByBin(String cartUPC, String partUPC, String mfgCode)`

`AURAENABLED`

Queries positive ledgers matching a bin and part in a bin of type cart

#### Parameters

|Param|Description|
|---|---|
|`cartUPC`|Bin UPC or Id|
|`partUPC`|Part UPC/Raw Part No./Id|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

---
