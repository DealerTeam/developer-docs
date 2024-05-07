---
layout: default
---
# TaxAPI

System level Taxation API Class

## Fields

### `private dealEquipmentInventory` → `EquipmentInventory__c`


### `private taxationDate` → `Date`


### `private dealFromDataSource` → `Deal__c`


### `private fieldMap` → `Map<String,Schema.SObjectField>`


---
## Methods
### `public static List<Tax_Region__c> regionsByZone(Tax_Zones__c zone, String rateType)`

returns all regions by zone


**Method** regionsByZone

### `public static List<Tax_Region__c> regionsByZone(Tax_Zones__c zone)`

returns all regions by zone


**Method** regionsByZone

### `public static List<TaxTransactionItem__c> calculateTaxes(Deal__c deal)`
### `public static List<TaxTransactionItem__c> calculateTaxes(Parts_Invoice__c invoice)`

updates all lines of a parts invoice to have accurate transaction items

#### Parameters

|Param|Description|
|---|---|
|`invoice`|invoice description|

#### Returns

|Type|Description|
|---|---|
|`List<TaxTransactionItem__c>`|return description|


**Method** calculateTaxes

### `public static taxWrapper calculateTaxes(ServiceRepairOrder sroWrapper)`

updates all lines of a Service Repair Order to have accurate transaction items

#### Parameters

|Param|Description|
|---|---|
|`sro`|sro description|

#### Returns

|Type|Description|
|---|---|
|`taxWrapper`|return description|


**Method** calculateTaxes

### `private static Boolean isValidTaxableDate(deal__c deal, Tax_Region__c tr)`
### `public static Date dealTaxationDate(Deal__c deal)`
### `private static List<Service_Job__c> setLineTaxable(List<Service_Job__c> lines, Dealer_Location__c loc, Boolean isTaxExempt, Boolean TaxPreDiscountAmount)`

evaluations subtotals of job lines to determine what is taxable

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|


**Method** setLineTaxable

### `private static List<Service_Job__c> setLineNonTaxable(List<Service_Job__c> lines)`

setLineNonTaxable sets the job's Non-Taxable Total

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `private static Decimal setSRONonTaxable(List<Service_Job__c> lines)`

setSRONonTaxable Sets the SRO non Taxable Total

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|

### `private static void populateDealRelationalData(Deal__c deal)`

Populates relational data required for the Min/Max calculations, we must also respect the possibility of custom un-managed fields.

#### Parameters

|Param|Description|
|---|---|
|`deal`|deal description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `private static List<TaxTransactionItem__c> applyManualTax(Deal__c deal, List<TaxTransactionItem__c> existingItems, List<After_Market__c> am)`
### `private static List<TaxTransactionItem__c> calcManualGeneralTax(Deal__c deal, manualTaxItems ttis, List<After_Market__c> am)`
### `private static List<TaxTransactionItem__c> calcManualContractTax(Deal__c deal, List<TaxTransactionItem__c> items)`
### `private static List<TaxTransactionItem__c> calcManualVehicleTax(Deal__c deal, List<TaxTransactionItem__c> items)`
### `private static List<TaxTransactionItem__c> calcManualConversionTax(Deal__c deal, List<TaxTransactionItem__c> items)`
### `private static List<TaxTransactionItem__c> calcManualFeeTax(Deal__c deal, List<TaxTransactionItem__c> items)`
### `private static List<TaxTransactionItem__c> calcManualAfterMarketTax(Deal__c deal, Map<String,List<TaxTransactionItem__c>> items, List<After_Market__c> am)`
### `private static List<TaxTransactionItem__c> applyTaxZone(Deal__c deal, Tax_Zones__c tz, List<TaxTransactionItem__c> existingItems, List<After_Market__c> am)`

This routine stores taxes applied to the Deal Record based on the provided Tax Zone. The tax regions are read, calculated and stored on the Tax Transaction Items table. Once transaction items are stored the Deal is updated with the specified Tax Zone.


**Method** applyTaxZone

### `private static transItems calcContractTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems)`
### `private static transItems calcAfterMarketTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems)`
### `private static transItems calcGeneralTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems, List<After_Market__c> am)`

**Method** calcGeneralTax

### `private static transItems calcVehicleTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems)`
### `private static transItems calcConversionTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems)`
### `private static transItems calcFeeTax(Deal__c deal, Map<Id,Tax_Region__c> regionMap, Map<String,Boolean> regionTypes, transItems tItems)`
### `private static Decimal dealVehicleTaxableAmount(Deal__c deal)`

Looks at location for Trade Tax Credit rules


**Method** dealVehicleTaxableAmount

### `public static void updateDealTotalTax(Id dealId)`

Update deal based on the total taxatino


**Method** updateDealTotalTax

### `public static void removeTaxTransactionItems(Deal__c deal)`

delete the transaction items based on Deal. This will not remove manually created entries, only entries part of a zone.


**Method** removeTaxTransactionItems

### `public static MinMax applyMinMaxRates(Decimal taxable, Tax_Region__c r, SObject obj, String objType)`

calculates the appropriate amount based on the min / max settings of the region.

#### Returns

|Type|Description|
|---|---|
|`MinMax`|taxable amount else.|


**Method** applyMinMaxRates

### `public static void populateFieldMap(String type)`

Checks for field schema map and populates if empty, ensures a single describe call

#### Parameters

|Param|Description|
|---|---|
|`type`|type description|

### `public static List<TaxTransactionItem__c> transactionItems(Id sObjectId)`
### `public static Tax_Zones__c getAccountTaxZone(Id AccountId)`
### `public List<afterMarketTaxRegions> calculateAfterMarketItemsTax(List<After_Market__c> records, Tax_Zones__c zone)`

This method calculates taxes on the aftermarket items included in the list based on the Tax Zone provided.

#### Parameters

|Param|Description|
|---|---|
|`List`|<After_Market__c>|
|`Tax_Zones__c`||


**Method** calculateAfterMarketItemsTax

### `public List<TaxTransactionItem__c> calculatePartsInvoiceLineTax(List<Parts_Invoice_Line__c> records, Tax_Zones__c zone)`

updates part line tax values and upserts related tax transaction items

#### Parameters

|Param|Description|
|---|---|
|`records`|records description|
|`zone`|zone description|

#### Returns

|Type|Description|
|---|---|
|`List<TaxTransactionItem__c>`|return parts lines with updated tax values|


**Method** calculatePartsInvoiceLineTax

### `private static TaxWrapper calculateSROTax(Service_Repair_Order__c sro, Tax_Zones__c zone)`

updates service repair order tax values

#### Parameters

|Param|Description|
|---|---|
|`records`|records description|
|`zone`|zone description|

#### Returns

|Type|Description|
|---|---|
|`TaxWrapper`|return description|


**Method** calculateSROTax

### `public static List<TaxTransactionItem__c> createCoreReturnTax(Id saleLine, Parts_Invoice_Line__c returnLine)`

generates TTIs for core return invoices based off of the originating invoice tax region

#### Parameters

|Param|Description|
|---|---|
|`saleLine`|original invoice line to reference region of|

#### Returns

|Type|Description|
|---|---|
|`List<TaxTransactionItem__c>`|taxLines TTIS relating to core return invoice|


**Method** createCoreReturnTax

### `private Boolean checkGeneralOnly(List<Tax_Region__c> regions)`

checks if a list of tax regions contains only general rate types

#### Parameters

|Param|Description|
|---|---|
|`regions`|regions description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** checkGeneralOnly

### `public List<TaxTransactionItem__c> applyAfterMarketTaxes(List<afterMarketTaxRegions> lineData)`
### `private static afterMarketTaxRegions applicableRegionData(After_Market__c aftermarket, String regionType, List<Tax_Region__c> regions)`

This method iterates junction data for applciation type and returns the viable region data


**Method** applicableRegionData

### `public static List<Tax_Zones__c> getAvailableZones(String dealId)`

getAvailableZones contains logic needed to return expected zones based on tax address on deal

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Used to find tax zones|

#### Returns

|Type|Description|
|---|---|
|`List<Tax_Zones__c>`|List<Tax_Zones__c> that match based on address|


**Test** DealServiceLayer.testRecentTaxZone

### `private static List<Tax_Zones__c> selectMatchingZone(TaxAddress address, List<Tax_Zones__c> zones, Integer sequence)`

selectMatchingZone returns tax zones that match an address according to the provided sequence

#### Parameters

|Param|Description|
|---|---|
|`address`|city, state, county and postal code to compare with existing tax zones|
|`zones`|tax zones to compare with the provided address|
|`sequence`|indicates with custom defined matching rules to use|

#### Returns

|Type|Description|
|---|---|
|`List<Tax_Zones__c>`|List<Tax_Zones__c> that match|

### `public static List<Tax_Zones__c> getAvailableTaxZonesDeal(String searchFilter, DealApi deal)`
### `public static List<Tax_Zones__c> getAvailableTaxZones(String searchFilter, SObject record)`
### `public static void setTaxZoneDates(List<Tax_Region__c> taxRegions)`
### `public static TaxTransactionItem__c transactionItem(Id itemId)`
---
## Classes
### manualTaxItems
#### Constructors
##### `public manualTaxItems()`
---
#### Fields

##### `public generalTax` → `List&lt;TaxTransactionItem__c&gt;`


##### `public vehicleTax` → `List&lt;TaxTransactionItem__c&gt;`


##### `public conversionTax` → `List&lt;TaxTransactionItem__c&gt;`


##### `public contractTax` → `List&lt;TaxTransactionItem__c&gt;`


##### `public feeTax` → `List&lt;TaxTransactionItem__c&gt;`


##### `public amTax` → `Map&lt;String,List&lt;TaxTransactionItem__c&gt;&gt;`


---

### transItems
#### Constructors
##### `private transItems()`
---
#### Properties

##### `private nItems` → `List&lt;TaxTransactionItem__c&gt;`


##### `private uItems` → `Map&lt;Id,TaxTransactionItem__c&gt;`


##### `private dItems` → `List&lt;TaxTransactionItem__c&gt;`


---

### MinMax
#### Constructors
##### `public MinMax(Decimal tax, decimal taxableAmount)`
---
#### Fields

##### `public tax` → `Decimal`


##### `public taxableAmount` → `Decimal`


---

### TaxFormula
#### Fields

##### `public deal` → `String`


##### `public sro` → `String`


##### `public partsInvoice` → `String`


##### `public rental` → `String`


---
#### Methods
##### `public String getProperty(String propName)`
---

### AccountTaxZone
#### Constructors
##### `public AccountTaxZone(String TaxIdT, String TaxZonet)`
---
#### Properties

##### `public TaxId` → `String`


##### `public TaxZone` → `String`


---

### TaxAddress

Used to store the address fields used for tax zone matching

#### Constructors
##### `public TaxAddress(String city, String state, String county, String postal)`
##### `public TaxAddress(Deal__c deal)`
---
#### Properties

##### `public taxableCity` → `String`


##### `public taxableState` → `String`


##### `public taxableCounty` → `String`


##### `public taxablePostalCode` → `String`


---

### afterMarketTaxRegions
#### Properties

##### `public aftermarketItem` → `After_Market__c`


##### `public taxRegions` → `List&lt;Tax_Region__c&gt;`


##### `public combinedRate` → `Decimal`


##### `public tax` → `Decimal`


---

### taxWrapper

class to hold various records related to tax calculation to pass back for limited dml. Only TTIs will be saved to database within TaxAPI

#### Constructors
##### `public taxWrapper(Service_Repair_Order__c sro, List&lt;Service_Job__c&gt; lines, List&lt;TaxTransactionItem__c&gt; items)`
##### `public taxWrapper()`
---
#### Fields

##### `public sro` → `Service_Repair_Order__c`


##### `public lines` → `List&lt;Service_Job__c&gt;`


##### `public items` → `List&lt;TaxTransactionItem__c&gt;`


---

### TaxAPIException

**Inheritance**

TaxAPIException


---
