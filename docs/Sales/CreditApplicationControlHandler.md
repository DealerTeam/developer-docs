---
layout: default
---
# CreditApplicationControlHandler

Control Handler logic applied to the Credit Application via Domain Layer Logic


**Group** Sales

## Methods
### `public static void validate(List<Credit_Application__c> triggerNew)`

validate This method applies hard validation logic to this record.

#### Parameters

|Param|Description|
|---|---|
|`List`|<Credit_Application__c> List of Records from Trigger New Context.|

### `public static void setDefaults(List<Credit_Application__c> triggerNew)`

setDefaults performs data defaults required at the domain layer for the proper processing of Credit Applications

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<Credit_Application__c>|

### `public static void recordName(List<Credit_Application__c> triggerNew)`

setName Performs a configuration based setting of the name property of the Credit App Record.

#### Parameters

|Param|Description|
|---|---|
|`List`|<Credit_Application__c> Trigger new records passed to the method.|

### `private static Credit_Application__c applyNameByConfiguration(Credit_Application__c creditApp)`

applyNameByConfiguration If the system is expected to set the name of the Credit Application follow this logic.

#### Parameters

|Param|Description|
|---|---|
|`Credit_Application__c`|The sObject record representing the Credit Applicaiton.|

#### Returns

|Type|Description|
|---|---|
|`Credit_Application__c`|Credit_Application__c|

---
