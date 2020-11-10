---
layout: default
---
# ServiceAPI class

 	ServiceAPI - General interface to the Service related solutions

---
## Methods
### `deleteDispatchEvent(DispatchEvent__c evt)` → `void`
### `getDispatchEvents(Dealer_Location__c location)` → `List<DispatchEvent__c>`
### `getJobLinesForDispatch(Dealer_Location__c location)` → `List<Service_Job__c>`
### `getWarrantyLaborRate(Id Loc)` → `Decimal`
### `miscChargeCodes(Id locationId)` → `List<MiscChargeCode__c>`
### `standardOperationCodes()` → `List<StandardOpCode__c>`
### `storeDispatchEvent(DispatchEvent__c evt)` → `void`
---
## Inner Classes

### ServiceAPI.DispachedWork class
---
#### Constructors
##### `DispachedWork(DispatchEvent__c e)`
---
#### Properties

##### `dispatchEvent` → `DispatchEvent__c`

##### `endDate` → `String`

##### `startDate` → `String`

---
### ServiceAPI.ServiceException class
---
### ServiceAPI.Technician class
---
#### Properties

##### `FullName` → `String`

##### `UserId` → `Id`

---
