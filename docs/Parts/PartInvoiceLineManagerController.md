---
layout: default
---
# PartInvoiceLineManagerController



**Group** Parts

## Constructors
### `public PartInvoiceLineManagerController()`
---
## Methods
### `public static dealer__Parts_Inventory__c getPartDetails(Id partId)`

`AURAENABLED`

returns part inventory record given a part inventory id

#### Parameters

|Param|Description|
|---|---|
|`partId`|partId description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Parts_Inventory__c`|return description|


**Method** getPartDetails

### `public static List<LookupSearchResult> partSearchByLocation(string searchTerm, Id locationId)`

`AURAENABLED`

returns parts matching a location and searchTerm formatted for custom input component

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locationId`|locationId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** partSearchByLocation

### `public static List<LookupSearchResult> partsMasterSearchByMfg(string searchTerm, String mfg)`

`AURAENABLED`

returns parts matching a manufacturer and searchTerm formatted fro custom input component

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`mfg`|mfg description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** partsMasterSearchByMfg

### `public static Parts_Inventory__c getPartByMasterLocation(string masterId, Id locationId, String mfgCode)`

`AURAENABLED`

returns the location part given the parts master and location IDs

#### Parameters

|Param|Description|
|---|---|
|`masterId`|Parts Master Id or UPC used for matching|
|`locationId`|locationId description|
|`mfgCode`|The code assigned to the related mfg record|

#### Returns

|Type|Description|
|---|---|
|`Parts_Inventory__c`|return description|


**Method** getPartByMasterLocation

### `public static List<LookupSearchResult> searchMiscCodes(String searchTerm, String recordId)`

`AURAENABLED`

returns MiscChargeCodes related to an invoice's location and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchMiscCodes

### `public static List<Parts_Invoice_Line__c> addInvoicePartLine(List<Parts_Invoice_Line__c> partLines, Map<Id,List<Parts_Ledger__c>> ledgersByPart, Boolean skipRelateLedgers)`

`AURAENABLED`

creates a list of Parts Invoice Lines

#### Parameters

|Param|Description|
|---|---|
|`partLines`|partLines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** addInvoicePartLine

### `public static List<Parts_Invoice_Line__c> updatePartLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)`

`AURAENABLED`

lhandles single part line update from LWC

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|
|`quantity`|quantity description|
|`salePrice`|salePrice description|
|`comment`|comment description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** updatePartLine

### `public static List<Parts_Invoice_Line__c> updatePartLine(List<Parts_Invoice_Line__c> updateLines, Map<Id,List<Parts_Ledger__c>> ledgerMap, Boolean skipRelateLedgers)`

`AURAENABLED`

updates a list of Parts Invoice Lines via the PartInvoiceAPI

#### Parameters

|Param|Description|
|---|---|
|`updateLines`|updateLines description|
|`ledgerMap`|Map of ledgers organized by line Id that contain serialized ledgers to relate to an invoice line|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** updatePartLine

### `public static void updateInvoiceLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

updates

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|


**Method** updateInvoiceLines

### `public static Boolean isQuotingEnabled()`

`AURAENABLED`

Checks if Parts Quoting is enabled in the org

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public static List<Parts_Invoice_Line__c> addMiscPartLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

accepts a list of part lines related to a single invoice to create as miscellaneous, which do not have any part-related logic involved. Returns all lines related to the invoice.

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** addMiscPartLines

### `public static List<Parts_Invoice_Line__c> updateMiscPartLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

accepts a list of part lines related to a single invoice to update as miscellaneous, which do not have any part-related logic involved. Returns all lines related to the invoice.

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** updateMiscPartLines

### `public static List<Parts_Invoice_Line__c> getPartLinesByInvoice(Id invoiceId)`

`AURAENABLED`

returns all Parts Invoice Lines belonging to a Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** getPartLinesByInvoice

### `public static Boolean deletePartLine(Id lineId)`

`AURAENABLED`

delete a Parts Invoice line by the provided Id

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deletePartLine

### `public static Decimal calculateStrategyPricing(Parts_Inventory__c part, Id pricingStratId)`

`AURAENABLED`

applies a price to a Parts Inventory record according to provided Pricing Strategy ID

#### Parameters

|Param|Description|
|---|---|
|`part`|part description|
|`pricingStratId`|pricingStratId description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Method** calculateStrategyPricing

### `public static List<CoreCharge__c> getCoreCharges(Id invoiceId)`

`AURAENABLED`

returns core charge records sold on the parts invoice Id provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Parts Invoice the cores were sold on|

#### Returns

|Type|Description|
|---|---|
|`List<CoreCharge__c>`|List<CoreCharge__c> related core charges|


**Method** getCoreCharges

### `private static dealer__Parts_Inventory__c getInventoryById(Id invId)`

returns a Parts Inventory record from an ID

#### Parameters

|Param|Description|
|---|---|
|`invId`|invId description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Parts_Inventory__c`|return description|


**Method** getInventoryById

### `public static MiscChargeCode__c getMiscCodeById(String codeId)`

`AURAENABLED`

getMiscCodeById

#### Parameters

|Param|Description|
|---|---|
|`codeId`|codeId description|

#### Returns

|Type|Description|
|---|---|
|`MiscChargeCode__c`|return description|

### `public static Boolean declineLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

Set line status and update quantity of related parts

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public static List<Parts_Ledger__c> getSerializedLedgers(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

Get ledgers with a serial number related to  the parts line or the part

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

---
## Classes
### PartLine
#### Fields

##### `public partId` → `String`

`AURAENABLED` 

##### `public partName` → `String`

`AURAENABLED` 

##### `public partDescription` → `String`

`AURAENABLED` 

---

---
