---
layout: default
---
# ServiceRepairOrderSelector
## Constructors
### `public ServiceRepairOrderSelector(Boolean enforce)`

Constructor to allow setting security boolean

#### Parameters

|Param|Description|
|---|---|
|`enforce`|enforce description|


**Method** ServiceRepairOrderSelector

### `public ServiceRepairOrderSelector()`

emtpy constructor if security is not required


**Method** ServiceRepairOrderSelector

---
## Fields

### `public enforceSecurity` → `Boolean`


---
## Methods
### `public Service_Repair_Order__c getSROdById(Id sroId)`

returns the SRO with all fields specified

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|


**Method** getSROdById

### `public static List<ServiceRepairOrder> sroData(Set<Id> sroIds)`

Returns list&lt;ServiceRepairOrder&gt; for multiple records.

#### Parameters

|Param|Description|
|---|---|
|`sroIds`||

### `public Map<Id,sObject> recordsByRo(List<Service_Repair_Order__c> ros, String relatedFieldName)`

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

### `private static Map<Id,List<Service_Job__c>> buildServiceJobMap(Set<Id> sroIds)`

helper method builds map of Service Job lines per SRO Id.

#### Parameters

|Param|Description|
|---|---|
|`dealIds`||

### `public List<PartsOrderLine__c> getRelatedOrderLines(List<Service_Job__c> jobs)`

Used to query related parts order lines that cannot be aggregated in initial part line query, used for popover

#### Parameters

|Param|Description|
|---|---|
|`jobs`|jobs description|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public List<Purchase_Order_Line__c> getRelatedPurchaseOrderLines(List<Service_Job__c> jobs)`

Used to query related purchase order lines that cannot be aggregated in initial part line query, used for popover

#### Parameters

|Param|Description|
|---|---|
|`jobs`|jobs description|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|return description|

### `private static Map<Id,List<Cashering__c>> buildCashierMap(Set<Id> sroIds)`

helper method builds map of cashier per SRO Id.

#### Parameters

|Param|Description|
|---|---|
|`sroIds`||

### `public Claim__c getClaimById(Id claimId)`

returns the claim with all fields specified

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|


**Method** getClaimById

### `public Dealer_Location__c getLocationById(Id locationId)`

returns dealer location based on location id

#### Parameters

|Param|Description|
|---|---|
|`locationId`|locationId description|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|return description|


**Method** getLocationById

### `public Account getAccountById(Id acctId)`

return Account record with all fields from Id

#### Parameters

|Param|Description|
|---|---|
|`acctId`|acctId description|

#### Returns

|Type|Description|
|---|---|
|`Account`|return description|


**Method** getAccountById

### `public Contact getContactById(Id conId)`

return Contact record with all fields from Id

#### Parameters

|Param|Description|
|---|---|
|`conId`|conId description|

#### Returns

|Type|Description|
|---|---|
|`Contact`|return description|


**Method** getContactById

### `public Deal__c getDealById(Id dealId)`

return Deal record with all fields by Id

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`Deal__c`|return description|


**Method** getDealById

### `public Parts_Invoice__c getPartsInvoiceById(Id piId)`

returns parts invoice record with all fields by Id

#### Parameters

|Param|Description|
|---|---|
|`piId`|piId description|

#### Returns

|Type|Description|
|---|---|
|`Parts_Invoice__c`|return description|


**Method** getPartsInvoiceById

### `public Service_Vehicle__c getServiceVehicleById(Id svId)`

returns Service Vehicle record with all fields by Id

#### Parameters

|Param|Description|
|---|---|
|`svId`|svId description|

#### Returns

|Type|Description|
|---|---|
|`Service_Vehicle__c`|return description|


**Method** getServiceVehicleById

### `public Vehicle_Inventory__c getVehicleInventoryById(Id viId)`

returns Vehicle Inventory record with all fields by Id

#### Parameters

|Param|Description|
|---|---|
|`viId`|viId description|

#### Returns

|Type|Description|
|---|---|
|`Vehicle_Inventory__c`|return description|


**Method** getVehicleInventoryById

### `public List<Cashering__c> getPayLines(Id sroId)`

returns paylines

#### Parameters

|Param|Description|
|---|---|
|`sroId`||

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`||


**Method** getpaylines

### `public List<Cashering__c> getPayLines(Set<Id> sroIds)`

returns paylines

#### Parameters

|Param|Description|
|---|---|
|`sroId`||

#### Returns

|Type|Description|
|---|---|
|`List<Cashering__c>`||


**Method** getpaylines

### `public List<Service_Job__c> getJobLinesBySRO(Id sroId)`

returns Job Lines and all subline detail related to the SRO Id

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|


**Method** getJobLinesBySRO

### `public List<Service_Job__c> getJobLinesBySRO(Set<Id> sroIds)`
### `public List<Service_Job__c> getJobLineDataOnlyBySRO(Id sroId)`

returns Job Line Managed Firlds and NO subline detail related to the SRO Id

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|List<Service_Job__c>|


**Method** getJobLineDataOnlyBySRO

### `public List<Service_Job__c> getJobLinesById(Set<Id> jobIds)`

getJobLinesById Returns Job lines for by ID

#### Parameters

|Param|Description|
|---|---|
|`jobIds`|jobIds|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|List<Service_Job__c>|

### `public String getJobLineQueryFieldsString()`

Returns job line fields as well as fields to all relevant related records

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Methods** getJobLineQueryFieldsString

---
