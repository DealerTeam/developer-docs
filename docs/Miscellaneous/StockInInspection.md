---
layout: default
---
# StockInInspection
## Constructors
### `public StockInInspection(ApexPages controller)`
---
## Fields

### `public appraisalVehicle` → `dealer__Appraisal_Vehicle__c`


### `public vid` → `String`


### `public dealDefaults` → `list<dealer__DMS_Settings__c>`


---
## Properties

### `private svcVehID` → `String`


### `private appraisalTypeId` → `String`


### `public supId` → `String`


### `public sup` → `dealer__Sales_Up__c`


### `public recId` → `String`


### `public recEditIds` → `String`


### `public purchaseAmt` → `Decimal`


### `public stockNumber` → `String`


### `public invoiceRef` → `String`


### `public appraisal` → `dealer__Appraisal__c`


### `public appraisalVeh` → `dealer__Appraisal_Vehicle__c`


### `public inspection` → `dealer__Inspection_Report__c`


### `public serviceVeh` → `dealer__Service_Vehicle__c`


### `public inspectionReportLine` → `dealer__Inspection_Report_Lines__c`


### `public inspectionRL` → `dealer__Inspection_Report_Lines__c`


### `public inspectionRLPopup` → `dealer__Inspection_Report_Lines__c`


### `public serviceVehicle` → `dealer__Service_Vehicle__c`


### `public vinNumber` → `String`


### `public apprId` → `String`


### `public selectedVehicle` → `String`


### `public appraisalValue` → `Decimal`


### `public ReconditioningTotalCost` → `Decimal`


### `public imageName` → `String`


### `public pOrder` → `dealer__Purchase_Order__c`


### `public body` → `String`


### `public driverdoor` → `String`


### `public passengerdoor` → `String`


### `public driverfront_wheel` → `String`


### `public driverrear_wheel` → `String`


### `public passengerfront_wheel` → `String`


### `public passengerrear_wheel` → `String`


### `public passengerfront_yellow_tire` → `String`


### `public passengerfront_red_tire` → `String`


### `public passengerrear_yellow_tire` → `String`


### `public passengerrear_red_tire` → `String`


### `public driverfront_yellow_tire` → `String`


### `public driverfront_red_tire` → `String`


### `public driverrear_yellow_tire` → `String`


### `public driverrear_red_tire` → `String`


### `public passengerfront_yellow_brake` → `String`


### `public passengerfront_red_brake` → `String`


### `public passengerrear_yellow_brake` → `String`


### `public passengerrear_red_brake` → `String`


### `public driverfront_yellow_brake` → `String`


### `public driverfront_red_brake` → `String`


### `public driverrear_yellow_brake` → `String`


### `public driverrear_red_brake` → `String`


### `public door` → `String`


### `public tire` → `String`


### `public brake` → `String`


### `public interior` → `String`


### `public mechanical` → `String`


### `public wheel` → `String`


### `public driverfront_body` → `String`


### `public driverrear_body` → `String`


### `public passengerfront_body` → `String`


### `public passengerrear_body` → `String`


### `public xCoord` → `decimal`


### `public yCoord` → `decimal`


### `public xCoordDriverDoor` → `decimal`


### `public yCoordDriverDoor` → `decimal`


### `public xCoordPassengerDoor` → `decimal`


### `public yCoordPassengerDoor` → `decimal`


### `public xCoordPassengerFrontDoor` → `decimal`


### `public yCoordPassengerFrontDoor` → `decimal`


### `public xCoordPassengerRearDoor` → `decimal`


### `public yCoordPassengerRearDoor` → `decimal`


### `public xCoordDriverFrontDoor` → `decimal`


### `public yCoordDriverFrontDoor` → `decimal`


### `public xCoordDriverRearDoor` → `decimal`


### `public yCoordDriverRearDoor` → `decimal`


### `public imageStyleClass` → `String`


---
## Methods
### `public String getContactPhone()`
### `public dealer__Appraisal__c newAppraisal()`
### `public List<Schema.FieldSetMember> getFields()`
### `public void init()`
### `public void initLineItem()`
### `public dealer__Sales_Up__c fetchSalesUp()`
### `public void fetchDefaultServiceVeh()`
### `public List<SelectOption> getServiceVehicles()`
### `public void changeVehicle()`
### `public void fetchServiceVehInfo()`
### `public List<dealer__Appraisal__c> getPreviousAppraisals()`
### `public void fetchServiceVehFromVIN()`
### `public PageReference saveInspectionReportLine()`
### `public PageReference saveInspectionRLPopup()`
### `public List<dealer__Inspection_Report_Lines__c> getInspectionReportLines()`
### `public String getInvoiceLogo()`
### `public PageReference calcAppraialValue()`
### `public PageReference saveInspection()`
### `public PageReference saveAndCloseInspection()`
### `public void fetchImageName()`
### `public PageReference stockInServiceVehicle()`
### `public PageReference stockInServiceVehicles()`
### `public PageReference createPurchaseOrder()`
### `public PageReference deleteLineItem()`
### `public void editLineItem()`
### `public void updateIRL()`
### `public void updateInspectionReportLine()`
### `public static Map<String,Object> decodedVin(String vin)`

`REMOTEACTION`
---
