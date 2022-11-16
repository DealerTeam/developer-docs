# CreditApplicationControlHandler

`APIVERSION: 48`

`STATUS: ACTIVE`

Control Handler logic applied to the Credit Application via Domain Layer Logic


**Group** Sales

## Methods
### `static validate(List<Credit_Application__c> triggerNew)`

validate This method applies hard validation logic to this record.

#### Parameters

|Param|Description|
|---|---|
|`List`|<Credit_Application__c> List of Records from Trigger New Context.|

### `static setDefaults(List<Credit_Application__c> triggerNew)`

setDefaults performs data defaults required at the domain layer for the proper processing of Credit Applications

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<Credit_Application__c>|

### `static recordName(List<Credit_Application__c> triggerNew)`

setName Performs a configuration based setting of the name property of the Credit App Record.

#### Parameters

|Param|Description|
|---|---|
|`List`|<Credit_Application__c> Trigger new records passed to the method.|

---
