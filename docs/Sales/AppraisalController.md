---
layout: default
---
# AppraisalController

Allows creation of Appraisal Records with Edit/Save/Delete functionality. Runs VIN Decoder for Trade Ins and allows changes for Line Items.


**Group** Sales

## Constructors
### `public AppraisalController(ApexPages controller)`

Constructor - Allows Trade In record to be created from Sales Up or Deal and populates Account/Sales Person


**Method** AppraisalController

---
## Fields

### `public estimateLines` → `List<dealer__Service_Estimate_Line__c>`


### `private ddat` → `VINDecoderDataObject`

`TESTVISIBLE` 

### `private sdat` → `VINDEcoderDataObject`

`TESTVISIBLE` 

### `public ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `public OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `public InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `public vd` → `VINDecoder`


### `public SelectedStyleId` → `String`


### `public engineSelect` → `List<SelectOption>`


### `public transmissionSelect` → `List<SelectOption>`


---
## Properties

### `public appraisal` → `dealer__Appraisal__c`


The appraisal property stores a public scoped instance of the appraisal object for reference within the visualforce controller extension

### `public sup` → `dealer__Sales_Up__c`


### `public serviceVehicle` → `dealer__Service_Vehicle__c`


### `public repairType` → `List<SelectOption>`


### `public reconRepairType` → `string`


### `public reconDescription` → `String`


### `public reId` → `String`


### `public editId` → `Id`


### `public reconEstimate` → `Decimal`


### `public tradeAllowance` → `Decimal`


### `public payOffAmount` → `Decimal`


### `public totalReconValue` → `Decimal`


### `public isApproval` → `boolean`


### `public serviceVehicleMileage` → `Decimal`


### `public editReExpense` → `boolean`


### `public tradeRecord` → `dealer__Trade_In__c`


### `public appraisalOne` → `dealer__Appraisal__c`


### `public loanPayoff` → `LoanPayoff__c`


### `public isDecode` → `Boolean`


### `public selectedEngine` → `String`


### `public selectedTransmission` → `String`


### `public appraisalSettings` → `AppraisalConfiguration__mdt`


### `public appraisalSettingsJSON` → `String`


---
## Methods
### `public void populateRepairTypePicklist()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** populateRepairTypePicklist

### `public void getTradeAllowance()`

Within deal, be able to save or delete Trade In

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** getTradeAllowance

### `public PageReference returnToDeal()`

After savign Trade record return to Deal

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** returnToDeal

### `public PageReference returnToSalesUp()`

After saving Trade record return to active Sales Up

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** returnToSalesUp

### `public PageReference save()`

Saves Trade Record unless the Vehicle is already associated with a Deal, in which case it updates Appraisal's trade record

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** save

### `public PageReference deleteRecord()`

Deletes Trade record, otherwise gives error message

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** deleteRecord

### `public PageReference createInventoryRecord()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** createInventoryRecord

### `public void saveTradeRecord()`

Save Trade Recode with Appriasal Values

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** saveTradeRecord

### `public PageReference saveLine()`

Save Estimate Line and Reload Appraisal

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** saveLine

### `public PageReference editLine()`

Save Estimate Line and Reload Appraisal

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** editLine

### `public PageReference deleteLine()`

Delete Estimate Line and reload Appraisal

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** deleteLine

### `public LoanPayoff__c fetchLoanPayoff()`

Shows Bank Information for Bank Loans on the appraised Vehicle

#### Returns

|Type|Description|
|---|---|
|`LoanPayoff__c`|LoanPayoff__c|


**Method** fetchLoanPayoff

### `public List<dealer__Service_Estimate_Line__c> getEstimateLines()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Estimate_Line__c>`|List<dealer__Service_Estimate_Line__c>|


**Method** getEstimateLines

### `public Decimal getReconTotalLine()`

Show Service Estimate Total from Appraisal

#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** getReconTotalLine

### `public List<dealer__Service_Vehicle__c> getServiceVehicleByVIN(String VIN)`
#### Parameters

|Param|Description|
|---|---|
|`VIN`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Vehicle__c>`|List<dealer__Service_Vehicle__c>|


**Method** getServiceVehicleByVIN

### `public static Map<String,Object> getData(String vin)`

`REMOTEACTION`

Show user an error when VIN Decode fails

#### Parameters

|Param|Description|
|---|---|
|`vin`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,Object>`|Map<String, Object>|


**Method** getData

### `public pagereference forms()`
#### Returns

|Type|Description|
|---|---|
|`pagereference`|pagereference|


**Method** forms

### `public static boolean saveVehicleDamage(String s)`

`REMOTEACTION`

Returns true if Vehcile Damage was sucessfully saved

#### Parameters

|Param|Description|
|---|---|
|`s`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** saveVehicleDamage

### `public void retrieveBankName()`

Gets Name of Bank from first Wire on the Account

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** retrieveBankName

### `public void doDecode(String VIN)`

Get year/make/model for  Vin Decode

#### Parameters

|Param|Description|
|---|---|
|`VIN`||


**Method** doDecode

### `public PageReference doDecodePage()`

Start Decode, otherwise display error message

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** doDecodePage

### `public PageReference vinNotPresent()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** vinNotPresent

### `public PageReference editPage()`

Determine whether Vehicle is new record, populate transmission fields, get list of optional equipment and get list of installed equipment.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** editPage

### `public List<VINDEcoderDataObject.Style> getModelKeyList()`
#### Returns

|Type|Description|
|---|---|
|`List<VINDEcoderDataObject.Style>`|List < VINDEcoderDataObject.Style >|


**Method** getModelKeyList

### `public VINDecoderDataObject getDecode()`
#### Returns

|Type|Description|
|---|---|
|`VINDecoderDataObject`|VINDecoderDataObject.DecodeData|


**Method** getDecode

### `public String getSelectedStyleId()`

Shows Style Id

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSelectedStyleId

### `public void setSelectedStyleId(String SelectedStyleId)`

Set Style Id


**Method** setSelectedStyleId

### `public List<SelectOption> getEngineSelect()`

Shows selected Engine

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List < SelectOption >|


**Method** getEngineSelect

### `public List<SelectOption> getTransmissionSelect()`

Shows selected Transmission

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List < SelectOption >|


**Method** getTransmissionSelect

### `public List<VinDecoderAPI.OptionalEquipment> getOptEquip()`

Shows list of Optional Equipment

#### Returns

|Type|Description|
|---|---|
|`List<VinDecoderAPI.OptionalEquipment>`|List < VinDecoderAPI.OptionalEquipment >|


**Method** getOptEquip

### `public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment()`

Shows list of Installed Equipment

#### Returns

|Type|Description|
|---|---|
|`List<VinDecoderAPI.InstalledEquipment>`|List < VinDecoderAPI.InstalledEquipment|


**Method** getInstalledEquipment

### `public boolean getIsDecode()`

Returns true if Vin is Decoded successfully

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** getIsDecode

---
## Classes
### AppraisalException

**Inheritance**

AppraisalException


---
