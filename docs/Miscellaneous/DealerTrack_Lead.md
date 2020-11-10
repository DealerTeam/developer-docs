---
layout: default
---
# DealerTrack_Lead class

@description

---
## Properties

### `PartnerDealerId` → `String`

@description

### `PartnerId` → `String`

ParnterId, PartnerDealerId required for all calls. Do not add any more properties here.

---
## Inner Classes

### DealerTrack_Lead.CustomFields class

@description

---
#### Properties

##### `Name` → `String`

##### `Value` → `String`

---
### DealerTrack_Lead.CustomerNotes class

@description

---
#### Properties

##### `Content` → `String`

##### `Title` → `String`

---
### DealerTrack_Lead.ExistingLead class

Gets an existing lead

---
#### Properties

##### `LastName` → `String`

##### `LeadReferenceNumber` → `String`

---
### DealerTrack_Lead.ILead interface

@description

---
#### Methods
##### `Initialize()` → `void`
---
### DealerTrack_Lead.Lead class

This is the class that gets json serialized for create and update calls, including base classes

---
#### Properties

##### `Business_Applicant` → `DealerTrack_Applicant.BusinessApplicant`

##### `Co_Applicant` → `DealerTrack_Applicant.CoApplicant`

##### `Comments` → `String`

##### `Custom_Fields` → `DealerTrack_Lead.CustomFields`

##### `Customer_Notes` → `DealerTrack_Lead.CustomerNotes`

##### `FinanceMethod` → `String`

##### `FinancedVehicle` → `DealerTrack_Vehicle.`

##### `Loan` → `DealerTrack_`

##### `Primary_Applicant` → `DealerTrack_Applicant.PrimaryApplicant`

##### `SendAdfEmail` → `boolean`

##### `TradeInVehicle` → `DealerTrack_Vehicle.`

---
#### Methods
##### `Initialize()` → `void`
---
### DealerTrack_Lead.UpdateLead class

Updates an existing lead

---
#### Properties

##### `LeadReferenceNumber` → `String`

---
