---
layout: default
---
# ServiceContractLinkHandler



**Group** Service

## Methods
### `public void BeforeHandlerMapLookup(List<Service_Contract__c> ListServiceContract)`
### `public void handleAfterUpdate(Map<Id,Service_Contract__c> oldMap, Map<Id,Service_Contract__c> newMap)`
### `public void handleAfterDelete(List<Service_Contract__c> triggerOld)`

if a service contract related to a deal is deleted, retotal contract fields on deal after deletion

#### Parameters

|Param|Description|
|---|---|
|`triggerOld`|service contract records before delete|


**Method** handleAfterDelete

### `public void sumDealTotalValues(List<Service_Contract__c> newList)`
---
## Classes
### ServiceContractException

**Inheritance**

ServiceContractException


---
