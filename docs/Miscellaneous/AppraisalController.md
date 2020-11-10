---
layout: default
---
# AppraisalController class

Allows creation of Appraisal Records with Edit/Save/Delete functionality. Runs VIN Decoder for Trade Ins and allows changes for Line Items.

---
## Constructors
### `AppraisalController(ApexPages.StandardController controller)`

Constructor - Allows Trade In record to be created from Sales Up or Deal and populates Account/Sales Person
---
## Properties

### `InstalledEquipment` → `VinDecoderAPI.`

@description

### `ModelKeyList` → `>`

@description

### `OptEquip` → `>`

@description

### `SelectedStyleId` → `String`

@description

### `appraisal` → `dealer__Appraisal__c`

The appraisal property stores a public scoped instance of the appraisal object for reference within the visualforce controller extension

### `appraisalOne` → `dealer__Appraisal__c`

@description

### `appraisalSettings` → `AppraisalConfiguration__mdt`

@description

### `appraisalSettingsJSON` → `String`

@description

### `editId` → `Id`

@description

### `editReExpense` → `boolean`

@description

### `engineSelect` → `>`

@description

### `estimateLines` → `List<dealer__Service_Estimate_Line__c>`

@description

### `isApproval` → `boolean`

@description

### `isDecode` → `Boolean`

@description

### `loanPayoff` → `LoanPayoff__c`

@description

### `payOffAmount` → `Decimal`

@description

### `reId` → `String`

@description

### `reconDescription` → `String`

@description

### `reconEstimate` → `Decimal`

@description

### `reconRepairType` → `string`

@description

### `repairType` → `List<SelectOption>`

@description

### `selectedEngine` → `String`

@description

### `selectedTransmission` → `String`

@description

### `serviceVehicle` → `dealer__Service_Vehicle__c`

@description

### `serviceVehicleMileage` → `Decimal`

@description

### `sup` → `dealer__Sales_Up__c`

@description

### `totalReconValue` → `Decimal`

@description

### `tradeAllowance` → `Decimal`

@description

### `tradeRecord` → `dealer__Trade_In__c`

@description

### `transmissionSelect` → `>`

### `vd` → `VINDecoder`

@description

### `vinDecoderActive` → `Boolean`

@description

---
## Methods
### `createInventoryRecord()` → `PageReference`
### `deleteLine()` → `PageReference`

Delete Estimate Line and reload Appraisal

### `deleteRecord()` → `PageReference`

Deletes Trade record, otherwise gives error message

### `doDecode(String VIN)` → `void`

Get year/make/model for  Vin Decode

#### Parameters
|Param|Description|
|-----|-----------|
|`` | N |

### `doDecodePage()` → `PageReference`

Start Decode, otherwise display error message

### `editLine()` → `PageReference`

Save Estimate Line and Reload Appraisal

### `editPage()` → `PageReference`

Determine whether Vehicle is new record, populate transmission fields, get list of optional equipment and get list of installed equipment.

### `fetchLoanPayoff()` → `LoanPayoff__c`

Shows Bank Information for Bank Loans on the appraised Vehicle

### `forms()` → `pagereference`
### `getData(String vin)` → `Object>`

Show user an error when VIN Decode fails

#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |

### `getDecode()` → `VINDecoderDataObject.DecodeData`
### `getEngineSelect()` → `>`

Shows selected Engine

### `getEstimateLines()` → `List<dealer__Service_Estimate_Line__c>`
### `getInstalledEquipment()` → `>`

Shows list of Installed Equipment

### `getIsDecode()` → `boolean`

Returns true if Vin is Decoded successfully

### `getModelKeyList()` → `>`
### `getOptEquip()` → `>`

Shows list of Optional Equipment

### `getReconTotalLine()` → `Decimal`

Show Service Estimate Total from Appraisal

### `getSelectedStyleId()` → `String`

Shows Style Id

### `getServiceVehicleByVIN(String VIN)` → `List<dealer__Service_Vehicle__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | N |

### `getTradeAllowance()` → `void`

Within deal, be able to save or delete Trade In

### `getTransmissionSelect()` → `>`

Shows selected Transmission

### `populateRepairTypePicklist()` → `void`
### `retrieveBankName()` → `void`

Gets Name of Bank from first Wire on the Account

### `returnToDeal()` → `PageReference`

After savign Trade record return to Deal

### `returnToSalesUp()` → `PageReference`

After saving Trade record return to active Sales Up

### `save()` → `PageReference`

Saves Trade Record unless the Vehicle is already associated with a Deal, in which case it updates Appraisal's trade record

### `saveLine()` → `PageReference`

Save Estimate Line and Reload Appraisal

### `saveTradeRecord()` → `void`

Save Trade Recode with Appriasal Values

### `saveVehicleDamage(String s)` → `boolean`

Returns true if Vehcile Damage was sucessfully saved

#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

### `setSelectedStyleId(String SelectedStyleId)` → `void`

Set Style Id

### `vinNotPresent()` → `PageReference`
---
## Inner Classes

### AppraisalController.AppraisalException class

@description

---
