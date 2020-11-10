---
layout: default
---
# SalesUpApi class
---
## Methods
### `createSalesUp(SalesUp.SalesUpWrapper sup)` → `Sales_Up__c`
### `findCustomerDuplicates(Account account)` → `>`
### `getSalesUpRecord(Sales_Up__c sup)` → `SalesUp`
### `upsertAccount(Account account, Boolean allowSave)` → `Account`
### `upsertContact(Contact contact, Boolean allowSave)` → `Contact`
---
## Inner Classes

### SalesUpApi.SalesUp class
---
#### Constructors
##### `SalesUp(Sales_Up__c sup)`
---
#### Properties

##### `buyer` → `Contact`

##### `coBuyer` → `Contact`

##### `conversion` → `Parts_Kit__c`

##### `header` → `Sales_up__c`

##### `location` → `Dealer_Location__c`

##### `tradeIn` → `Service_Vehicle__c`

##### `vehicle` → `Vehicle_Inventory__c`

---
