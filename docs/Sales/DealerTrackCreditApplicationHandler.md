# DealerTrackCreditApplicationHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealerTrackCreditApplicationHandler


**Group** Sales

## Methods
### `static CreateLeadFromApp(Id appId, Id dealId, String providerId)`

creates a DealerTrack lead from a credit app object.

#### Parameters

|Param|Description|
|---|---|
|`app`||

#### Return

**Type**

DealerTrack_Lead_API.LeadResponse

**Description**

LeadResponse

### `static populateDto(Id appId, Id dealId, String providerId)`
### `static createEnumPropertiesFromApp(Credit_Application__c app)`
### `static CreateDealerTrackLead(CreditAppDto dto)`
### `static CreateDealerTrackLead(List<CreditAppDto> Dtos)`

Takes a list of Data Transfer Objects. future(callout=true).

#### Parameters

|Param|Description|
|---|---|
|`Dtos`||

#### Return

**Type**

void

**Description**

void


**Method** CreateDealerTrackLead

### `static UpdateDealerTrackLead(List<CreditAppDto> Dtos)`

Takes a list of Data Transfer Objects.

#### Parameters

|Param|Description|
|---|---|
|`Dtos`||

#### Return

**Type**

void

**Description**

void


**Method** UpdateDealerTrackLead


**Future** (callout=true).

---
## Classes
### CreditAppDto


#### Properties

##### `EnumProperties` → `DealerTrackEnumProperties`


##### `app` → `Credit_Application__c`


##### `deal` → `Deal__c`


##### `providerId` → `String`


##### `sup` → `Sales_Up__c`


##### `trade` → `Trade_In__c`


##### `vehicle` → `Vehicle_Inventory__c`


---

---
