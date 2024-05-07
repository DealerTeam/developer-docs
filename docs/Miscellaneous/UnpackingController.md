---
layout: default
---
# UnpackingController
## Methods
### `public static Boolean isReviewEnabled()`

`AURAENABLED`

Check to see if review process is required. When turned off, received parts are automatically processed

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public static List<PartsOrderLine__c> getOrderLines(String partId, String orderId, String cageId, String mfgCode)`

`AURAENABLED`

Query open parts order lines where the part upc/raw part no./part id matches the input

#### Parameters

|Param|Description|
|---|---|
|`partId`|Part UPC/Raw Part No./Part Id|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public static PartsOrderLine__c saveOrderLine(PartsOrderLine__c line)`

`AURAENABLED`

Call the PartsOrderAPI to save the provided line

#### Parameters

|Param|Description|
|---|---|
|`line`|Becomes first element of array to save|

#### Returns

|Type|Description|
|---|---|
|`PartsOrderLine__c`|return description|

### `public static Boolean checkExistingOrder(String orderId)`

`AURAENABLED`

Call the PartsOrderAPI to save the provided line

#### Parameters

|Param|Description|
|---|---|
|`orderId`|Parts Order Id or name|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true when order found|

---
