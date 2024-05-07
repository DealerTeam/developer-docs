---
layout: default
---
# abstract DealerTrack_Lead



**Class** DealerTrack_Lead


**Group** Sales

## Properties

### `public PartnerId` → `String`


ParnterId, PartnerDealerId required for all calls. Do not add any more properties here.

### `public PartnerDealerId` → `String`


---
## Methods
### `private void PopulateNode(object properties, Map<String,Object> nodeMap)`

Helper method to populate nodes

#### Parameters

|Param|Description|
|---|---|
|`properties`||
|`nodeMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** PopulateNode

### `private void AddNullNameSpace(Map<String,Object> nodeMap)`
#### Parameters

|Param|Description|
|---|---|
|`nodeMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** AddNullNameSpace

---
## Classes
### DealerTrack_Lead_Proxy



**Inheritance**

[DealerTrack_Lead](./DealerTrack_Lead.md)
 &gt; 
DealerTrack_Lead_Proxy

#### Fields

##### `private PrimaryApplicant` → `Map&lt;String,Object&gt;`


##### `private BusinessApplicant` → `Map&lt;String,Object&gt;`


---

### Lead

This is the class that gets json serialized for create and update calls, including base classes


**Inheritance**

Lead


**Implemented types**

[ILead](ILead)

#### Fields

##### `public Primary_Applicant` → `DealerTrack_Applicant`


##### `public Co_Applicant` → `DealerTrack_Applicant`


##### `public Business_Applicant` → `DealerTrack_Applicant`


##### `public FinancedVehicle` → `DealerTrack_Vehicle`


##### `public TradeInVehicle` → `DealerTrack_Vehicle`


##### `public Loan` → `DealerTrack_Loan`


##### `public Customer_Notes` → `DealerTrack_Lead`


##### `public Custom_Fields` → `DealerTrack_Lead`


##### `public SendAdfEmail` → `boolean`


##### `public Comments` → `String`


##### `private CoApplicant` → `Map&lt;String,Object&gt;`


##### `private VehicleInfo` → `Map&lt;String,Object&gt;`


##### `private TradeInVehicleInfo` → `Map&lt;String,Object&gt;`


##### `private LoanInfo` → `Map&lt;String,Object&gt;`


##### `private CustomerNotes` → `Map&lt;String,Object&gt;`


##### `private CustomFields` → `Map&lt;String,Object&gt;`


---
#### Properties

##### `public FinanceMethod` → `String`


---
#### Methods
##### `public void Initialize()`
---

### UpdateLead

Updates an existing lead


**Inheritance**

UpdateLead

#### Properties

##### `public LeadReferenceNumber` → `String`


---

### ExistingLead

Gets an existing lead


**Inheritance**

[DealerTrack_Lead](./DealerTrack_Lead.md)
 &gt; 
ExistingLead

#### Properties

##### `public LastName` → `String`


##### `public LeadReferenceNumber` → `String`


---

### CustomerNotes


#### Properties

##### `public Title` → `String`


##### `public Content` → `String`


---

### CustomFields


#### Properties

##### `public Name` → `String`


##### `public Value` → `String`


---

---
## Interfaces
### ILead


#### Methods
##### `public void Initialize()`
---

