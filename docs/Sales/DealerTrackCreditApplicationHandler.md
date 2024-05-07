---
layout: default
---
# DealerTrackCreditApplicationHandler



**Class** DealerTrackCreditApplicationHandler


**Group** Sales

## Methods
### `public static DealerTrack_Lead_API CreateLeadFromApp(Id appId, Id dealId, String providerId)`

creates a DealerTrack lead from a credit app object.

#### Parameters

|Param|Description|
|---|---|
|`app`||

#### Returns

|Type|Description|
|---|---|
|`DealerTrack_Lead_API`|LeadResponse|

### `public static CreditAppDto populateDto(Id appId, Id dealId, String providerId)`
### `public static DealerTrackEnumProperties createEnumPropertiesFromApp(Credit_Application__c app)`
### `public static DealerTrack_Lead CreateDealerTrackLead(CreditAppDto dto)`
### `public static void CreateDealerTrackLead(List<CreditAppDto> Dtos)`

Takes a list of Data Transfer Objects. future(callout=true).

#### Parameters

|Param|Description|
|---|---|
|`Dtos`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** CreateDealerTrackLead

### `public static void UpdateDealerTrackLead(List<CreditAppDto> Dtos)`

Takes a list of Data Transfer Objects.

#### Parameters

|Param|Description|
|---|---|
|`Dtos`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** UpdateDealerTrackLead


**Future** (callout=true).

### `private static void PopulateApplicant(DealerTrack_Applicant applicant, CreditAppDto dto)`
#### Parameters

|Param|Description|
|---|---|
|`applicant`||
|`dto`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** PopulateApplicant

### `private static void PopulateCoApplicant(DealerTrack_Applicant applicant, CreditAppDto dto)`
#### Parameters

|Param|Description|
|---|---|
|`applicant`||
|`dto`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** PopulateCoApplicant

### `private static void PopulateBusinessApplicant(DealerTrack_Applicant applicant, CreditAppDto dto)`
#### Parameters

|Param|Description|
|---|---|
|`applicant`||
|`dto`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** PopulateBusinessApplicant

### `private static void PopulateVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto)`
### `private static void PopulateTradeVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto)`
### `private static void PopulateFinancedVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto)`
### `private static void PopulateTradeInVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto)`
### `private static void PopulateLoan(DealerTrack_Loan loan, CreditAppDto dto)`
### `private static string CalculateMonths(decimal years, decimal months)`
#### Parameters

|Param|Description|
|---|---|
|`years`||
|`months`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** CalculateMonths

### `private static string ToString(object input)`
#### Parameters

|Param|Description|
|---|---|
|`input`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** ToString

---
## Classes
### CreditAppDto


#### Properties

##### `public providerId` → `String`


##### `public app` → `Credit_Application__c`


##### `public sup` → `Sales_Up__c`


##### `public deal` → `Deal__c`


##### `public vehicle` → `Vehicle_Inventory__c`


##### `public trade` → `Trade_In__c`


##### `public EnumProperties` → `DealerTrackEnumProperties`


---

---
