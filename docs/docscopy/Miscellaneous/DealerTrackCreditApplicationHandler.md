---
layout: default
---
# DealerTrackCreditApplicationHandler class

@description

---
## Methods
### `CreateDealerTrackLead(CreditAppDto dto)` → `DealerTrack_Lead.Lead`
### `CreateDealerTrackLead(List<CreditAppDto> Dtos)` → `void`

Takes a list of Data Transfer Objects. future(callout=true).

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `CreateLeadFromApp(Id appId, Id dealId, String providerId)` → `DealerTrack_Lead_API.LeadResponse`

creates a DealerTrack lead from a credit app object.

#### Parameters
|Param|Description|
|-----|-----------|
|`` | p |

### `UpdateDealerTrackLead(List<CreditAppDto> Dtos)` → `void`

Takes a list of Data Transfer Objects. @future(callout=true).

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `createEnumPropertiesFromApp(Credit_Application__c app)` → `DealerTrackEnumProperties`
### `populateDto(Id appId, Id dealId, String providerId)` → `CreditAppDto`
---
## Inner Classes

### DealerTrackCreditApplicationHandler.CreditAppDto class

@description

---
#### Properties

##### `EnumProperties` → `DealerTrack`

##### `app` → `Credit_Application__c`

##### `deal` → `Deal__c`

##### `providerId` → `String`

##### `sup` → `Sales_Up__c`

##### `trade` → `Trade_In__c`

##### `vehicle` → `Vehicle_Inventory__c`

---
