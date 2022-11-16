# DealerTrack_Lead

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealerTrack_Lead


**Group** Sales

## Properties

### `PartnerDealerId` → `String`


### `PartnerId` → `String`


ParnterId, PartnerDealerId required for all calls. Do not add any more properties here.

---
## Classes
### CustomFields


#### Properties

##### `Name` → `String`


##### `Value` → `String`


---

### CustomerNotes


#### Properties

##### `Content` → `String`


##### `Title` → `String`


---

### ExistingLead

Gets an existing lead


**Inheritance**

[DealerTrack_Lead](/Sales/DealerTrack_Lead.md)
 &gt; 
ExistingLead

#### Properties

##### `LastName` → `String`


##### `LeadReferenceNumber` → `String`


---

### Lead

This is the class that gets json serialized for create and update calls, including base classes


**Inheritance**

Lead


**Implemented types**

[ILead](ILead)

#### Fields

##### `Business_Applicant` → `DealerTrack_Applicant.BusinessApplicant`


##### `Co_Applicant` → `DealerTrack_Applicant.CoApplicant`


##### `Comments` → `String`


##### `Custom_Fields` → `DealerTrack_Lead.CustomFields`


##### `Customer_Notes` → `DealerTrack_Lead.CustomerNotes`


##### `FinancedVehicle` → `DealerTrack_Vehicle.FinancedVehicle`


##### `Loan` → `DealerTrack_Loan`


##### `Primary_Applicant` → `DealerTrack_Applicant.PrimaryApplicant`


##### `SendAdfEmail` → `boolean`


##### `TradeInVehicle` → `DealerTrack_Vehicle.TradeInVehicle`


---
#### Properties

##### `FinanceMethod` → `String`


---
#### Methods
##### `Initialize()`
---

### UpdateLead

Updates an existing lead


**Inheritance**

UpdateLead

#### Properties

##### `LeadReferenceNumber` → `String`


---

---
## Interfaces
### ILead


#### Methods
##### `Initialize()`
---

