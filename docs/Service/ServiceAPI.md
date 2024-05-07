---
layout: default
---
# ServiceAPI

ServiceAPI - General interface to the Service related solutions


**Group** Service

## Methods
### `public static List<StandardOpCode__c> standardOperationCodes()`
### `public static List<MiscChargeCode__c> miscChargeCodes(Id locationId)`
### `public static List<DispatchEvent__c> getDispatchEvents(Dealer_Location__c location)`
### `public static List<Service_Job__c> getJobLinesForDispatch(Dealer_Location__c location)`
### `public static void storeDispatchEvent(DispatchEvent__c evt)`
### `public static void deleteDispatchEvent(DispatchEvent__c evt)`
### `public static Decimal getWarrantyLaborRate(Id Loc)`
---
## Classes
### Technician
#### Properties

##### `public FullName` → `String`


##### `public UserId` → `Id`


---

### DispachedWork
#### Constructors
##### `public DispachedWork(DispatchEvent__c e)`
---
#### Properties

##### `public dispatchEvent` → `DispatchEvent__c`


##### `public startDate` → `String`


##### `public endDate` → `String`


---

### ServiceException

**Inheritance**

ServiceException


---
