---
layout: default
---
# PartsOrderAPI
## Fields

### `public openStatus` → `Set<String>`


Line statuses regarded as open, used for querying open lines

---
## Methods
### `public static List<PartsOrderLine__c> getLines(String partId, String orderId, String cageId, String mfgCode)`

Returns all open Parts Order Lines matching the part input

#### Parameters

|Param|Description|
|---|---|
|`partId`|Part UPC/Raw Part No./Id|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public static List<PartsOrderLine__c> saveLines(List<PartsOrderLine__c> lines)`

Populate bins from Part if blank or from bin UPC if field is not an Id, then saves

#### Parameters

|Param|Description|
|---|---|
|`lines`|Order lines where Bin could be blank or populated with a string UPC from LWC|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public static PartsOrder__c getOrder(String orderId)`
---
