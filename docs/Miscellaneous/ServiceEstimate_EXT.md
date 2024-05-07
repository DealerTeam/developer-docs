---
layout: default
---
# ServiceEstimate_EXT
## Constructors
### `public ServiceEstimate_EXT(ApexPages sc)`
---
## Fields

### `public dms` → `list<dealer__DMS_Settings__c>`


### `public vid` → `dealer__Vehicle_Inventory__c`


### `private m_controller` → `ApexPages`


### `private showRecordValue` → `String`


### `private idValue` → `String`


### `public InventoryVehicleId` → `String`


### `private defaultAttachment` → `Messaging`


---
## Properties

### `public se` → `dealer__Service_Estimate__c`


### `public email` → `String`


### `public subject` → `String`


### `public body` → `String`


### `public ShowRecord` → `String`


### `public RecordID` → `String`


---
## Methods
### `public void setInventoryVehicleId(String n)`
### `public String getInventoryVehicleId()`
### `public pageReference finalize()`
### `public pageReference convertToRO()`
### `public dealer__Service_Estimate_Line__c getEstimateLines()`
### `public PageReference addService()`
### `public PageReference addPart()`
### `public PageReference addSublet()`
### `public PageReference addCosmetic()`
### `public PageReference emailButton()`
### `public PageReference noRefresh()`
### `public PageReference saveMobile4Square()`
### `public PageReference Save()`
### `public PageReference saveEstimate()`
### `public boolean getHasEstimateLines()`
### `public boolean getHasActivityHistories()`
### `public dealer__Vehicle_Inventory__c getVehicle()`
### `public List<dealer__Service_Job__c> getROJobLines()`
### `public Messaging AttachPDF()`
### `public PageReference sendPdf()`
---
