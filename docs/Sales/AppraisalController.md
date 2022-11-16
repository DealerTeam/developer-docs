# AppraisalController

`APIVERSION: 45`

`STATUS: ACTIVE`

Allows creation of Appraisal Records with Edit/Save/Delete functionality. Runs VIN Decoder for Trade Ins and allows changes for Line Items.


**Group** Sales

## Constructors
### `AppraisalController(ApexPages.StandardController controller)`

Constructor - Allows Trade In record to be created from Sales Up or Deal and populates Account/Sales Person


**Method** AppraisalController

---
## Fields

### `InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `SelectedStyleId` → `String`


### `engineSelect` → `List<SelectOption>`


### `estimateLines` → `List<dealer__Service_Estimate_Line__c>`


### `transmissionSelect` → `List<SelectOption>`


### `vd` → `VINDecoder`


---
## Properties

### `appraisal` → `dealer__Appraisal__c`


The appraisal property stores a public scoped instance of the appraisal object for reference within the visualforce controller extension

### `appraisalOne` → `dealer__Appraisal__c`


### `appraisalSettings` → `AppraisalConfiguration__mdt`


### `appraisalSettingsJSON` → `String`


### `editId` → `Id`


### `editReExpense` → `boolean`


### `isApproval` → `boolean`


### `isDecode` → `Boolean`


### `loanPayoff` → `LoanPayoff__c`


### `payOffAmount` → `Decimal`


### `reId` → `String`


### `reconDescription` → `String`


### `reconEstimate` → `Decimal`


### `reconRepairType` → `string`


### `repairType` → `List<SelectOption>`


### `selectedEngine` → `String`


### `selectedTransmission` → `String`


### `serviceVehicle` → `dealer__Service_Vehicle__c`


### `serviceVehicleMileage` → `Decimal`


### `sup` → `dealer__Sales_Up__c`


### `totalReconValue` → `Decimal`


### `tradeAllowance` → `Decimal`


### `tradeRecord` → `dealer__Trade_In__c`


---
## Methods
### `populateRepairTypePicklist()`
#### Return

**Type**

void

**Description**

void


**Method** populateRepairTypePicklist

### `getTradeAllowance()`

Within deal, be able to save or delete Trade In

#### Return

**Type**

void

**Description**

void


**Method** getTradeAllowance

### `returnToDeal()`

After savign Trade record return to Deal

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** returnToDeal

### `returnToSalesUp()`

After saving Trade record return to active Sales Up

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** returnToSalesUp

### `save()`

Saves Trade Record unless the Vehicle is already associated with a Deal, in which case it updates Appraisal's trade record

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** save

### `deleteRecord()`

Deletes Trade record, otherwise gives error message

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** deleteRecord

### `createInventoryRecord()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** createInventoryRecord

### `saveTradeRecord()`

Save Trade Recode with Appriasal Values

#### Return

**Type**

void

**Description**

void


**Method** saveTradeRecord

### `saveLine()`

Save Estimate Line and Reload Appraisal

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** saveLine

### `editLine()`

Save Estimate Line and Reload Appraisal

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** editLine

### `deleteLine()`

Delete Estimate Line and reload Appraisal

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** deleteLine

### `fetchLoanPayoff()`

Shows Bank Information for Bank Loans on the appraised Vehicle

#### Return

**Type**

LoanPayoff__c

**Description**

LoanPayoff__c


**Method** fetchLoanPayoff

### `getEstimateLines()`
#### Return

**Type**

List&lt;dealer__Service_Estimate_Line__c&gt;

**Description**

List&lt;dealer__Service_Estimate_Line__c&gt;


**Method** getEstimateLines

### `getReconTotalLine()`

Show Service Estimate Total from Appraisal

#### Return

**Type**

Decimal

**Description**

Decimal


**Method** getReconTotalLine

### `getServiceVehicleByVIN(String VIN)`
#### Parameters

|Param|Description|
|---|---|
|`VIN`||

#### Return

**Type**

List&lt;dealer__Service_Vehicle__c&gt;

**Description**

List&lt;dealer__Service_Vehicle__c&gt;


**Method** getServiceVehicleByVIN

### `static getData(String vin)`

`REMOTEACTION`

Show user an error when VIN Decode fails

#### Parameters

|Param|Description|
|---|---|
|`vin`||

#### Return

**Type**

Map&lt;String,Object&gt;

**Description**

Map&lt;String, Object&gt;


**Method** getData

### `forms()`
#### Return

**Type**

pagereference

**Description**

pagereference


**Method** forms

### `static saveVehicleDamage(String s)`

`REMOTEACTION`

Returns true if Vehcile Damage was sucessfully saved

#### Parameters

|Param|Description|
|---|---|
|`s`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** saveVehicleDamage

### `retrieveBankName()`

Gets Name of Bank from first Wire on the Account

#### Return

**Type**

void

**Description**

void


**Method** retrieveBankName

### `doDecode(String VIN)`

Get year/make/model for  Vin Decode

#### Parameters

|Param|Description|
|---|---|
|`VIN`||


**Method** doDecode

### `doDecodePage()`

Start Decode, otherwise display error message

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** doDecodePage

### `vinNotPresent()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** vinNotPresent

### `editPage()`

Determine whether Vehicle is new record, populate transmission fields, get list of optional equipment and get list of installed equipment.

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** editPage

### `getModelKeyList()`
#### Return

**Type**

List&lt;VINDEcoderDataObject.Style&gt;

**Description**

List &lt; VINDEcoderDataObject.Style &gt;


**Method** getModelKeyList

### `getDecode()`
#### Return

**Type**

VINDecoderDataObject.DecodeData

**Description**

VINDecoderDataObject.DecodeData


**Method** getDecode

### `getSelectedStyleId()`

Shows Style Id

#### Return

**Type**

String

**Description**

String


**Method** getSelectedStyleId

### `setSelectedStyleId(String SelectedStyleId)`

Set Style Id


**Method** setSelectedStyleId

### `getEngineSelect()`

Shows selected Engine

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List &lt; SelectOption &gt;


**Method** getEngineSelect

### `getTransmissionSelect()`

Shows selected Transmission

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List &lt; SelectOption &gt;


**Method** getTransmissionSelect

### `getOptEquip()`

Shows list of Optional Equipment

#### Return

**Type**

List&lt;VinDecoderAPI.OptionalEquipment&gt;

**Description**

List &lt; VinDecoderAPI.OptionalEquipment &gt;


**Method** getOptEquip

### `getInstalledEquipment()`

Shows list of Installed Equipment

#### Return

**Type**

List&lt;VinDecoderAPI.InstalledEquipment&gt;

**Description**

List &lt; VinDecoderAPI.InstalledEquipment


**Method** getInstalledEquipment

### `getIsDecode()`

Returns true if Vin is Decoded successfully

#### Return

**Type**

boolean

**Description**

boolean


**Method** getIsDecode

---
## Classes
### AppraisalException

**Inheritance**

AppraisalException


---
