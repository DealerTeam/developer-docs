---
layout: default
---
# virtual ExternalDataQuery

Allows us to query external data objects and allows us to mock that data in test classes

## Fields

### `private instance` → `ExternalDataQuery`


---
## Methods
### `public static List<SObject> records(List<SObject> records)`

returns a singular record. Accepts SOQL query eg: ExternalDataQuery.records([Select Id FROM CustomerCode__x])

#### Parameters

|Param|Description|
|---|---|
|`record`|record description|

#### Returns

|Type|Description|
|---|---|
|`List<SObject>`|return description|

### `public static SObject record(sObject record)`

returns a singular record. Accepts SOQL query eg: ExternalDataQuery.records([Select Id FROM CustomerCode__x LIMIT 1])

#### Parameters

|Param|Description|
|---|---|
|`record`|record description|

#### Returns

|Type|Description|
|---|---|
|`SObject`|return description|

### `private static void setMock(ExternalDataQuery mock)`

`TESTVISIBLE`

sets mock data for test classes

#### Parameters

|Param|Description|
|---|---|
|`records`|records description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

---
