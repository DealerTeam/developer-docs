# StockInInspection

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `StockInInspection(ApexPages.StandardController controller)`
---
## Fields

### `appraisalVehicle` → `dealer__Appraisal_Vehicle__c`


### `dealDefaults` → `list<dealer__DMS_Settings__c>`


### `vid` → `String`


---
## Properties

### `ReconditioningTotalCost` → `Decimal`


### `apprId` → `String`


### `appraisal` → `dealer__Appraisal__c`


### `appraisalValue` → `Decimal`


### `appraisalVeh` → `dealer__Appraisal_Vehicle__c`


### `body` → `String`


### `brake` → `String`


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
### `getContactPhone()`
### `newAppraisal()`
### `getFields()`
### `init()`
### `initLineItem()`
### `fetchSalesUp()`
### `fetchDefaultServiceVeh()`
### `getServiceVehicles()`
### `changeVehicle()`
### `fetchServiceVehInfo()`
### `getPreviousAppraisals()`
### `fetchServiceVehFromVIN()`
### `saveInspectionReportLine()`
### `saveInspectionRLPopup()`
### `getInspectionReportLines()`
### `getInvoiceLogo()`
### `calcAppraialValue()`
### `saveInspection()`
### `saveAndCloseInspection()`
### `fetchImageName()`
### `stockInServiceVehicle()`
### `stockInServiceVehicles()`
### `createPurchaseOrder()`
### `deleteLineItem()`
### `editLineItem()`
### `updateIRL()`
### `updateInspectionReportLine()`
### `static decodedVin(String vin)`

`REMOTEACTION`
---
