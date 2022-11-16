# ServiceContractLinkHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Methods
### `BeforeHandlerMapLookup(List<Service_Contract__c> ListServiceContract)`
### `handleAfterUpdate(Map<Id,Service_Contract__c> oldMap, Map<Id,Service_Contract__c> newMap)`
### `handleAfterDelete(List<Service_Contract__c> triggerOld)`

if a service contract related to a deal is deleted, retotal contract fields on deal after deletion

#### Parameters

|Param|Description|
|---|---|
|`triggerOld`|service contract records before delete|


**Method** handleAfterDelete

### `sumDealTotalValues(List<Service_Contract__c> newList)`
---
## Classes
### ServiceContractException

**Inheritance**

ServiceContractException


---
