---
layout: default
---
# StockInInspection class

 Date            |Developer            |Work# Notes -- 2016.07.12       |Sneha                |T-00869 Added Null Check to avoid null pointer exception

---
## Constructors
### `StockInInspection( ApexPages.StandardController controller )`
---
## Properties

### `ReconditioningTotalCost` → `Decimal`

### `apprId` → `String`

### `appraisal` → `dealer__Appraisal__c`

### `appraisalValue` → `Decimal`

### `appraisalVeh` → `dealer__Appraisal_Vehicle__c`

### `appraisalVehicle` → `dealer__Appraisal_Vehicle__c`

### `body` → `String`

### `brake` → `String`

### `dealDefaults` → `list<dealer__DMS_Settings__c>`

### `door` → `String`

### `driverdoor` → `String`

### `driverfront_body` → `String`

### `driverfront_red_brake` → `String`

### `driverfront_red_tire` → `String`

### `driverfront_wheel` → `String`

### `driverfront_yellow_brake` → `String`

### `driverfront_yellow_tire` → `String`

### `driverrear_body` → `String`

### `driverrear_red_brake` → `String`

### `driverrear_red_tire` → `String`

### `driverrear_wheel` → `String`

### `driverrear_yellow_brake` → `String`

### `driverrear_yellow_tire` → `String`

### `imageName` → `String`

### `imageStyleClass` → `String`

### `inspection` → `dealer__Inspection_Report__c`

### `inspectionRL` → `dealer__Inspection_Report_Lines__c`

### `inspectionRLPopup` → `dealer__Inspection_Report_Lines__c`

### `inspectionReportLine` → `dealer__Inspection_Report_Lines__c`

### `interior` → `String`

### `invoiceRef` → `String`

### `mechanical` → `String`

### `pOrder` → `dealer__Purchase_Order__c`

### `passengerdoor` → `String`

### `passengerfront_body` → `String`

### `passengerfront_red_brake` → `String`

### `passengerfront_red_tire` → `String`

### `passengerfront_wheel` → `String`

### `passengerfront_yellow_brake` → `String`

### `passengerfront_yellow_tire` → `String`

### `passengerrear_body` → `String`

### `passengerrear_red_brake` → `String`

### `passengerrear_red_tire` → `String`

### `passengerrear_wheel` → `String`

### `passengerrear_yellow_brake` → `String`

### `passengerrear_yellow_tire` → `String`

### `purchaseAmt` → `Decimal`

### `recEditIds` → `String`

### `recId` → `String`

### `selectedVehicle` → `String`

### `serviceVeh` → `dealer__Service_Vehicle__c`

### `serviceVehicle` → `dealer__Service_Vehicle__c`

### `stockNumber` → `String`

### `sup` → `dealer__Sales_Up__c`

### `supId` → `String`

### `tire` → `String`

### `vid` → `String`

### `vinNumber` → `String`

### `wheel` → `String`

### `xCoord` → `decimal`

### `xCoordDriverDoor` → `decimal`

### `xCoordDriverFrontDoor` → `decimal`

### `xCoordDriverRearDoor` → `decimal`

### `xCoordPassengerDoor` → `decimal`

### `xCoordPassengerFrontDoor` → `decimal`

### `xCoordPassengerRearDoor` → `decimal`

### `yCoord` → `decimal`

### `yCoordDriverDoor` → `decimal`

### `yCoordDriverFrontDoor` → `decimal`

### `yCoordDriverRearDoor` → `decimal`

### `yCoordPassengerDoor` → `decimal`

### `yCoordPassengerFrontDoor` → `decimal`

### `yCoordPassengerRearDoor` → `decimal`

---
## Methods
### `calcAppraialValue()` → `PageReference`
### `changeVehicle()` → `void`
### `createPurchaseOrder()` → `PageReference`
### `decodedVin(String vin)` → `Map<String,Object>`
### `deleteLineItem()` → `PageReference`
### `editLineItem()` → `void`
### `fetchDefaultServiceVeh()` → `void`
### `fetchImageName()` → `void`
### `fetchSalesUp()` → `dealer__Sales_Up__c`
### `fetchServiceVehFromVIN()` → `void`
### `fetchServiceVehInfo()` → `void`
### `getContactPhone()` → `String`
### `getFields()` → `List<Schema.FieldSetMember>`
### `getInspectionReportLines()` → `List<dealer__Inspection_Report_Lines__c>`
### `getInvoiceLogo()` → `String`
### `getPreviousAppraisals()` → `List<dealer__Appraisal__c>`
### `getServiceVehicles()` → `List<SelectOption>`
### `init()` → `void`
### `initLineItem()` → `void`
### `newAppraisal()` → `dealer__Appraisal__c`
### `saveAndCloseInspection()` → `PageReference`
### `saveInspection()` → `PageReference`
### `saveInspectionRLPopup()` → `PageReference`
### `saveInspectionReportLine()` → `PageReference`
### `stockInServiceVehicle()` → `PageReference`
### `stockInServiceVehicles()` → `PageReference`
### `updateIRL()` → `void`
### `updateInspectionReportLine()` → `void`
---
