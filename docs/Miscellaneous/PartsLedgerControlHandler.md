---
layout: default
---
# PartsLedgerControlHandler
## Methods
### `public static void setLedgerValue(List<Parts_Ledger__c> triggerNew)`

Check item value for null and set scaling, trim transaction note

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public static void setLedgerStatus(List<Parts_Ledger__c> triggerNew, Map<Id,Parts_Ledger__c> triggerOldMap)`

Set base statuses based on quantity. Ledgers are moved to Complete by Posting process

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

### `public static void updateRelatedParts(List<Parts_Ledger__c> triggerNew, Map<Id,Parts_Ledger__c> triggerOldMap)`

Update On Hand according to ledger updates

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

### `public static void updateRelatedPartsAfterDelete(Map<Id,Parts_Ledger__c> triggerOldMap)`
---
