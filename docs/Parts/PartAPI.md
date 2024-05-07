---
layout: default
---
# PartAPI

PartAPI - Service layer encapsulation for interaction with Parts


**Group** Parts

## Methods
### `global static Map<Id,Parts_Inventory__c> createInventoryFromMaster(List<Parts_Master__c> masterItems, Id location)`

createInventoryFromMaster provides an api interface and single point of entry for creating inventory from parts master records in a specific location.


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `global static List<Parts_Inventory__c> readInventory(Id location)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on the Location ID

#### Parameters

|Param|Description|
|---|---|
|`Id`|Dealer_Location__c.Id|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c>|

### `global static List<Parts_Inventory__c> readInventory(List<Id> locationIds)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

#### Parameters

|Param|Description|
|---|---|
|`List`|<Id> List<Dealer_Location__c>|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c>|

### `global static List<Parts_Inventory__c> readInventory(Parts_Inventory__c part)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

#### Parameters

|Param|Description|
|---|---|
|`sObject`|Parts_Inventory__c|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c>|

### `global static List<Parts_Inventory__c> readInventory(List<Id> locationIds, String manufacturer)`

readInventory performs the SOQL call to query part inventory, returning a list of Parts_Inventory__c based on a list of Location ID's

#### Parameters

|Param|Description|
|---|---|
|`List`|<Id> List<Dealer_Location__c>|
|`String`|manufacturer|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c>|

### `private static Map<String,List<PricingMatrix__c>> getMatricesByCategory(Set<String> categories, String payType)`

queries for all pricing matrices related to a set of Parts Categories

#### Parameters

|Param|Description|
|---|---|
|`locationIds`|locationIds description|

#### Returns

|Type|Description|
|---|---|
|`Map<String,List<PricingMatrix__c>>`|Map key:locationId value:location.pricingMatrixGroup matrices|


**Method** getMatricesByCategory

### `private static Map<String,List<PricingMatrix__c>> getMatricesByLocation(Set<Id> locationIds, String payType)`

queries for all pricing matrices related to a set of location ids

#### Parameters

|Param|Description|
|---|---|
|`locationIds`|locationIds description|

#### Returns

|Type|Description|
|---|---|
|`Map<String,List<PricingMatrix__c>>`|Map key:locationId value:location.pricingMatrixGroup matrices|


**Method** getMatricesByLocation

### `global static Parts_Inventory__c getPriceByMatrix(Parts_Inventory__c part, String payType)`

Finds the matrix for a single part where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters

|Param|Description|
|---|---|
|`part`|part description|

#### Returns

|Type|Description|
|---|---|
|`Parts_Inventory__c`|return description|

### `global static List<Parts_Inventory__c> getPriceByMatrix(List<Parts_Inventory__c> parts, String payType)`

Finds the matrix for a list of parts where cost is between the high and low cost on the matrix record and set list based on the multiplier

#### Parameters

|Param|Description|
|---|---|
|`parts`|parts description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|return description|

### `private static List<Parts_Inventory__c> queryPartInventory(Id location, List<Id> locationIds, Id part, String manufacturer)`

Queries the database for parts filtered by params

#### Parameters

|Param|Description|
|---|---|
|`{`|Id} location - location of parts to filter query|
|`{`|List<Id>} locationIds - multiple locations to filter|
|`{`|Id} part - part id to filter|
|`{`|String} manufacturer - part manufacturer to filter|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|s {List<Parts_Inventory__c>} - list of parts matching returned by filtered query|


**Function** - queryPartInventory


**Test** PartPhysicalInventoryServiceLayer.testPartAPI

### `global static Decimal matrix(String paymentMethod, Parts_Inventory__c part)`

Matrix - Determines the matrix value based on the requested part being sold.

### `global static Decimal matrix(String paymentMethod, Parts_Master__c master)`
### `private static Decimal matrixSearch(String pm, Decimal cost)`

matrixSearch - perform record processing sub function for the primary global method

### `public static Decimal assignStrategyPricing(Parts_Inventory__c part, Id pricingStratId)`

`AURAENABLED`
### `public static List<Decimal> assignStrategyPricing(List<Parts_Inventory__c> parts, Id pricingStratId)`

`AURAENABLED`
### `public static Decimal calculateStrategyPricing(Parts_Inventory__c part, Parts_Service_Pricing_Strategy__c pricingStrat)`
### `global static Void saleMetricHandler(Map<Id,Parts_Inventory__c> partInventoryMap)`

matrixSearch - perform record processing sub function for the primary global method

#### Parameters

|Param|Description|
|---|---|
|`{`|Map<Id, Parts_Inventory__c>} - parts to process|


**Function** - saleMetricHandler


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `public static List<Cashering__c> cashTransactions(String invoiceId)`
### `private static void updatePartLastSaleDate(Set<Id> partIdSet)`

Updates the last_sale_date__c field with the current sale date


**Function** - updatePartLastSaleDate


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Part_Sale_Metric__c cleanMetric(Part_Sale_Metric__c partMetric)`

Instantiate all fields on Part_Sale_Metric__c - retaining existing values and Setting null values to 0.

#### Parameters

|Param|Description|
|---|---|
|`Part_Sale_Metric__c`|- metric to be reset to 0|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Part_Sale_Metric__c cleanMetric(Id partId, Map<Id,Map<Integer,Integer>> unitSaleTotalMap)`

Sets all changed fields to new values

#### Parameters

|Param|Description|
|---|---|
|`ID`|- part to be updated in metric|
|`Map`|Id, Map Integer, Integer - Map of sale data to update metric|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Integer getSaleMonth(DateTime partSaleDate)`

Handles finding the month of the part sale

#### Parameters

|Param|Description|
|---|---|
|`DateTime`|- date to be processed|

#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer - Numeric value of month|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Boolean isLast30(DateTime partSaleDate)`

Checks if part was sold in last 30 days

#### Parameters

|Param|Description|
|---|---|
|`DateTime`|- date to be processed|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean - True if sale was made in last 30 days|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Boolean isLast60(DateTime partSaleDate)`

Checks if part was sold in last 60 days

#### Parameters

|Param|Description|
|---|---|
|`DateTime`|- date to be processed|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean - True if sale was made in last 60 days|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Boolean isLast90(DateTime partSaleDate)`

Checks if part was sold in last 90 days

#### Parameters

|Param|Description|
|---|---|
|`DateTime`|- date to be processed|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|s Boolean - True if sale was made in last 90 days|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `private static Boolean isLast120(DateTime partSaleDate)`

Checks if part was sold in last 120 days

#### Parameters

|Param|Description|
|---|---|
|`DateTime`|- date to be processed|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|s Boolean - True if sale was made in last 120 days|


**Test** PartPhysicalInventoryServiceLayer.testPartAPIBatchable

### `public static void subLedgerDML(List<Parts_Ledger__c> subLedgerRecords, String DMLoperation)`

Abstraction of the DML operations for subledger data manipulation.        This routine will ensure that all subledger activity is controlled by        a single routine respecting feature enablement.


**Method** subLedgerDML

### `public static Parts_Kit__c getPartsKit(Id pkId)`
### `public static void updateLedger(List<Part_Inventory_History__c> partHistory, List<Parts_Inventory__c> partsToUpdate, Boolean emailLedger)`

updateLedger handles DML when changes to on hand are requested

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List<Part_Inventory_History__c> list of history records with quantity and cost info|
|`partsToUpdate`|List<Parts_Inventory__c> affected parts to change on hand quantities|
|`emailLedger`|Boolean if true this will attempt to send a GL email|

### `public static List<Parts_Ledger__c> moveLedgerBin(String fromBinId, String toBinId, String partId, Integer qty, String mfgCode)`

Move a specified number of non-serialized ledgers from one bin to another

#### Parameters

|Param|Description|
|---|---|
|`fromBin`|Bin Id or UPC where ledgers are currently present|
|`toBin`|Bin Id or UPC where ledgers are to be moved|
|`partId`|Parts Inventory Id, UPC or Raw Part # to transfer|
|`qty`|Number of ledgers to transfer|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|Returns true if transaction succeeds|

### `public static List<Parts_Ledger__c> completeLedgers(Id refObjectId)`

Move ledgers related to the reference Id to a complete status

#### Parameters

|Param|Description|
|---|---|
|`refObjectId`|refObjectId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

### `private static void sendNotifications(Set<Id> records, Decimal adjustmentValue, String reasonForChange)`

`TESTVISIBLE`

sendNotifications handles sending email with updated GL info

#### Parameters

|Param|Description|
|---|---|
|`records`|Set<Id> the part_inventory__c ids that were updated|
|`adjustmentValue`|Decimal total value of the transaction|

### `public static Map<Id,List<Parts_Ledger__c>> getLedgersToReceive(Map<Id,Integer> partCount, Set<Id> lineIds)`

Get a specified number of ledgers related to a part where the order line is null or related to a list of Ids

#### Parameters

|Param|Description|
|---|---|
|`partCount`|Map of part Ids with the number of ledgers to return|
|`lineIds`|Ids of either purchase or parts order lines|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Parts_Ledger__c>>`|Map of ledgers by part Id, up to the size of input provided|

---
## Classes
### PartReceivingLedger
#### Constructors
##### `public PartReceivingLedger()`
---
#### Properties

##### `public entries` → `List&lt;Parts_Ledger__c&gt;`


##### `public part` → `Parts_Inventory__c`


##### `public purchaseOrderLine` → `Purchase_Order_Line__c`


##### `public packQuantity` → `Integer`


##### `public packOverride` → `Boolean`


##### `public received` → `Integer`


##### `public processed` → `Integer`


##### `public itemValue` → `Decimal`


##### `public lineValue` → `Decimal`


##### `public serialNumbers` → `List&lt;String&gt;`


---

### PartAPIException

PartAPIException extends the standard exception handler


**Inheritance**

PartAPIException


---
