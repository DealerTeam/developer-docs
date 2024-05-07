---
layout: default
---
# PartsInvoiceControlHandler
## Fields

### `private ROIdSet` → `set<Id>`


---
## Methods
### `public void ERPInsert(Id invoiceId)`

Sends call to create the invoice in ERP

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|


**Method** ERPInsert

### `public void ERPUpdate(Id invoiceId)`

Sends call to update the existing invoice in ERP

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|


**Method** ERPUpdate

### `public void handleNumbering(List<Parts_Invoice__c> piList)`
### `private void numberingFromRO(List<Parts_Invoice__c> piList)`
### `public void checkSubLedgerEnabled(List<Parts_Invoice__c> triggerNew)`

Checks that PartSubLedger DMS Config is enabled before allowing creating invoice of Vendor_Return record type

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<Parts_Invoice__c> trigger new|


**Method** checkSubLedgerEnabled

### `public void enforceFields(List<Parts_Invoice__c> triggerNew)`

Performs domain layer validation that fields are not blank

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<Parts_Invoice__c> trigger new|


**Method** enforceFields

### `public void checkSubLedgerEnabled(Map<Id,Parts_Invoice__c> triggerNewMap, Map<Id,Parts_Invoice__c> triggerOldMap)`

Checks that PartSubLedger DMS Config is enabled before allowing update of record to Vendor_Return record type

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|Map<Id, Parts_Invoice__c> trigger new map|
|`triggerOldMap`|Map<Id, Parts_Invoice__c> trigger old map|


**Method** checkSubLedgerEnabled

### `public void enforcePricingStrategy(List<Parts_Invoice__c> triggerNew)`

Ensures a pricing strategy is selected, otherwise will set to the default

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** enforcePricingStrategy

### `public void handleUpdate(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

handleUpdate checks if parts invoice records have had their account or location updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** handleUpdate

### `private static void getPricingStrategy(List<Parts_Invoice__c> needsStrategy)`

Look to invoice related objects for valide pricing strategy. Account&gt;location&gt;org default

#### Parameters

|Param|Description|
|---|---|
|`triggerOldMap`|triggerOldMap description|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** getPricingStrategy

### `public void updatePartLinePricing(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

Updates pricing on all child part lines if the pricing strategy is changed

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updatePartLinePricing

### `public void setCurrencyRounding(List<Parts_Invoice__c> triggerNew)`

enforce 2 digit precision and round up currency values on incoming PI records

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming trigger records|


**Method** setCurrencyRounding

### `public void setTaxZone(List<Parts_Invoice__c> triggerNew)`

sets the tax zone when none is present and one is matched via TaxAPI

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTaxZone

### `public void updateTaxZone(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

removes existing Tax Transaction Items and applies new ones based on new zone

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateTaxZone

### `public void setStatus(List<Parts_Invoice__c> triggerNew)`

updates the status to be default value if none is selected

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|


**Method** setStatus

### `public void setIsClosed(List<Parts_Invoice__c> triggerNew)`

updates the isClosed boolean to be true if status matches dmsConfig

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|


**Method** setIsClosed

### `public void preventInvoicedUpdate(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

checks dmsConfig and if enabled only allow updates to fields in the config while status is invoiced and is not changed (prevents issues moving to invoiced status)

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventInvoicedUpdate

### `public void preventPostedUpdate(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

prevents updates to fields if status is posted and is not changed (prevents issues moving to posted status)

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventPostedUpdate

### `public void updateLineTaxable(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`

updates invoice line taxable boolean when invoice tax exempt is changed

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateLineTaxable

### `public void setShippingAddress(List<Parts_Invoice__c> triggerNew, Map<Id,Parts_Invoice__c> triggerOldMap)`
### `public void setVersionNumber(List<Parts_Invoice__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
