# ServiceAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

ServiceAPI - General interface to the Service related solutions


**Group** Service

## Methods
### `static standardOperationCodes()`
### `static miscChargeCodes(Id locationId)`
### `static getDispatchEvents(Dealer_Location__c location)`
### `static getJobLinesForDispatch(Dealer_Location__c location)`
### `static storeDispatchEvent(DispatchEvent__c evt)`
### `static deleteDispatchEvent(DispatchEvent__c evt)`
### `static getWarrantyLaborRate(Id Loc)`
---
## Classes
### DispachedWork
#### Constructors
##### `DispachedWork(DispatchEvent__c e)`
---
#### Properties

##### `dispatchEvent` → `DispatchEvent__c`


##### `endDate` → `String`


##### `startDate` → `String`


---

### ServiceException

**Inheritance**

ServiceException


### Technician
#### Properties

##### `FullName` → `String`


##### `UserId` → `Id`


---

---
