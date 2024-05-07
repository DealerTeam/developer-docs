---
layout: default
---
# DMSDataEventAPI

DMSDataEventAPI is the service layer processing event handler.  This class may be used in Trigger or Service Layer Context


**Group** Accounting


**Test** ERPServiceLayer

## Constructors
### `public DMSDataEventAPI()`

Constructor.  This class is currently not using a constructor logic.

---
## Methods
### `global static void createEventSync(Id recordId, String processString)`

INTERNAL Subscriber org enabled via anonymous apex

#### Parameters

|Param|Description|
|---|---|
|`recordIdSet`|recordIdSet description|
|`processString`|processString description|

### `global static void createEventSync(Set<Id> recordIdSet, String processString)`

INTERNAL Subscriber org enabled via anonymous apex

#### Parameters

|Param|Description|
|---|---|
|`recordIdSet`|recordIdSet description|
|`processString`|processString description|

### `global static void createEvent(Id recordId, String processString)`

INTERNAL Subscriber org enabled via anonymous apex

#### Parameters

|Param|Description|
|---|---|
|`recordIdSet`|recordIdSet description|
|`processString`|processString description|

### `global static void createEvent(Set<Id> recordIdSet, String processString)`

INTERNAL Subscriber org enabled via anonymous apex

#### Parameters

|Param|Description|
|---|---|
|`recordIdSet`|recordIdSet description|
|`processString`|processString description|

### `public static Void createEvent(String recordID, ERPProcess process)`

createEvent validates and prepares the event data to be delivered to the Heroku ERP asnychronously

#### Parameters

|Param|Description|
|---|---|
|`recordID`|recordID description|
|`process`|process description|


**Test** ERPServiceLayer

### `public static void createEvent(Set<Id> recordIdSet, ERPProcess process)`

createEvent validates and prepares the event data to be delivered to the Heroku ERP asnychronously

#### Parameters

|Param|Description|
|---|---|
|`recordID`|recordID description|
|`process`|process description|


**Test** ERPServiceLayer

### `public static Void createEventSync(String recordID, ERPProcess process)`

createEvent validates and prepares the event data to be delivered to the Heroku ERP synchronously

#### Parameters

|Param|Description|
|---|---|
|`recordID`|recordID description|
|`process`|process description|


**Test** ERPServiceLayer

### `public static void createEventSync(Set<Id> recordIdSet, ERPProcess process)`
### `public static void log(List<ERPTransactionLog__c> logs)`

Creates a ERPTransactionResult event for further processing.  This platform event bus is immidiate allowing no transaction rollback.

#### Parameters

|Param|Description|
|---|---|
|`List`|<ERPTransactionLog__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Notes** See ERPTransactionResultControl.trigger for more details.

### `private static Void validate(ERPProcess process)`

This method validates the process being requested exists in the definition of events.

#### Parameters

|Param|Description|
|---|---|
|`ERPProcess`|Single ERPProcess wrapper|

#### Returns

|Type|Description|
|---|---|
|`Void`|void|


**Test** //TODO This method does not appear to have test coverage. //TODO This method can be optimized now with Platform Cache.

---
## Classes
### BulkData
#### Constructors
##### `public BulkData(Set&lt;String&gt; recordIds)`
---
#### Fields

##### `public isBulk` → `Boolean`


##### `public events` → `Map&lt;String,EventData&gt;`


---

### EventData

EventData wrapper performs serialization of data shared between Accounting and Core


**Notes** This class is to remain an inner wrapper of the DMSDataEventAPI Class

#### Constructors
##### `public EventData(Map&lt;String,String&gt; dMap)`
---
#### Fields

##### `public RecordId` → `String`


##### `public ClientId` → `String`


##### `public StoreId` → `String`


##### `public OrgId` → `String`


##### `public CompanyId` → `String`


##### `public CustId` → `String`


##### `public RequestingUserId` → `String`


##### `public LastChangedDate` → `String`


##### `public LastChangedTerminal` → `String`


##### `public LastChangedTime` → `String`


##### `public LastChangedBy` → `String`


##### `public CreatedDate` → `String`


##### `public CreatedBy` → `String`


---

### DMSDataEventAPIException

This inner class extends the Exception class for unhandled event error handling.


**Inheritance**

DMSDataEventAPIException


---
