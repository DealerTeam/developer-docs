---
layout: default
---
# PartsInvoiceSelector
## Methods
### `public Tax_Zones__c getTaxZoneById(Id zoneId)`

returns tax zone by tax zone Id

#### Parameters

|Param|Description|
|---|---|
|`zoneId`|zoneId description|

#### Returns

|Type|Description|
|---|---|
|`Tax_Zones__c`|return Tax_Zones__c|

### `public List<Parts_Invoice_Line__c> getInvoiceLineByInvoiceId(Id invoiceId)`

getInvoiceLineByInvoiceId returns list Parts Invoice Line by an Invoice Id

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return List<parts_Invoice_line__c>|

### `public List<Parts_Invoice_Line__c> getInvoiceLineByInvoiceId(Set<Id> invoiceIds)`

getInvoiceLineByInvoiceId returns lines for a set of Invoice Ids

#### Parameters

|Param|Description|
|---|---|
|`invoiceIds`|invoiceIds description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return List<Parts_Invoice_Line__c>|

### `public Parts_Service_Pricing_Strategy__c getPricingStrategyById(Id stratId)`

retrieves Parts_Service_Pricing_Strategy__c by pricing strategyShare your names Id

#### Parameters

|Param|Description|
|---|---|
|`stratId`|stratId description|

#### Returns

|Type|Description|
|---|---|
|`Parts_Service_Pricing_Strategy__c`|return description|

### `public List<Cashering__c> getPayLinesById(Id invoiceId)`

getPayLinesById returns Cashering__c lines for the supplied invoiceId

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|return description|

### `public List<Cashering__c> getPayLinesById(Set<Id> invoiceIds)`

getPayLinesById returns Cashering__c lines for the supplied invoiceIds

#### Parameters

|Param|Description|
|---|---|
|`invoiceIds`|invoiceIds description|

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`|return description|

### `public static List<PartsInvoice> partsInvoiceData(Set<Id> piIds)`

Returns list&lt;PartsInvoice&gt; for multiple records.

#### Parameters

|Param|Description|
|---|---|
|`piIds`||

### `public Map<Id,sObject> recordsByPartsInvoice(List<Parts_Invoice__c> pis, String relatedFieldName)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,sObject>`|Map<Id,sObject>|

### `public Map<Id,sObject> recordsByPartsInvoice(List<Parts_Invoice__c> pis, String relatedFieldName, Set<String> additionalFields)`

returns a map of Sales_Up__c from a list of Deal__c

#### Parameters

|Param|Description|
|---|---|
|`deals`|List of Deal__c|
|`relatedFieldName`|related field name on the deal object. Example: dealer__Sales_Lead__c|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,sObject>`|Map<Id,sObject>|

### `private static Map<Id,List<Parts_Invoice_Line__c>> buildInvoiceLineMap(Set<Id> piIds)`

helper method builds map of Service Job lines per Parts Invoice Id.

#### Parameters

|Param|Description|
|---|---|
|`piIds`||

### `private static Map<Id,List<Cashering__c>> buildPayLineMap(Set<Id> piIds)`

helper method builds map of Service Job lines per Parts Invoice Id.

#### Parameters

|Param|Description|
|---|---|
|`piIds`||

### `private static Set<String> sroVehicleFields()`

sroVehicleFields returns additional fields to query for the SRO object

#### Returns

|Type|Description|
|---|---|
|`Set<String>`|return Set<String>|

---
