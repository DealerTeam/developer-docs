# Classes
## Miscellaneous

### [B2CAccounts](/Miscellaneous/B2CAccounts.md)


Class used in system context to represent individual type accounts.  Usually accessed by trigger(s) hooked to the contact object</description>



### [BatchCarfaxHistoryReport](/Miscellaneous/BatchCarfaxHistoryReport.md)






### [BatchCompletePhysical](/Miscellaneous/BatchCompletePhysical.md)


@description



### [BatchDeleteVehicleEquipment](/Miscellaneous/BatchDeleteVehicleEquipment.md)






### [BatchMigrateVehicleEquipment](/Miscellaneous/BatchMigrateVehicleEquipment.md)






### [BatchPopulateServiceIdOnVehicleInventory](/Miscellaneous/BatchPopulateServiceIdOnVehicleInventory.md)


@description



### [BatchUpdateEquippedField](/Miscellaneous/BatchUpdateEquippedField.md)


@description



### [BatchUpdatePartSaleMetric](/Miscellaneous/BatchUpdatePartSaleMetric.md)


Handles Batch processing of parts inventory



### [BatchUpdatePartSaleMetricExec](/Miscellaneous/BatchUpdatePartSaleMetricExec.md)


@description



### [BatchUpdateVehicleInternalCharges](/Miscellaneous/BatchUpdateVehicleInternalCharges.md)


Batch Class to populate Vehicle Inventory internal charges fields from related SROs upon package installation



### [BirthDayRemainderScheduler](/Miscellaneous/BirthDayRemainderScheduler.md)


@description



### [CarDealsActivity](/Miscellaneous/CarDealsActivity.md)


@description



### [CarDealsActivityBatchable](/Miscellaneous/CarDealsActivityBatchable.md)


@description



### [ChangeContactAccountOwnerOnCarDeal](/Miscellaneous/ChangeContactAccountOwnerOnCarDeal.md)


@description



### [ChangeContactAccountOwnerOnCarDeal_Batch](/Miscellaneous/ChangeContactAccountOwnerOnCarDeal_Batch.md)


@description



### [ClaimAPI](/Miscellaneous/ClaimAPI.md)


@description



### [ClaimPrintController](/Miscellaneous/ClaimPrintController.md)


@description



### [ContactsDuplicateSearch](/Miscellaneous/ContactsDuplicateSearch.md)


@description



### [DMSBatchCleanRecords](/Miscellaneous/DMSBatchCleanRecords.md)


Cleans records of invalid external Ids



### [DMSImportsRESTService](/Miscellaneous/DMSImportsRESTService.md)


@description



### [DMSSyncBulkLoadBatch](/Miscellaneous/DMSSyncBulkLoadBatch.md)






### [DealForm_EXT](/Miscellaneous/DealForm_EXT.md)


Mobility Deal Controller Extension



### [DealPrintController](/Miscellaneous/DealPrintController.md)


@description



### [DealerTrade_EXT](/Miscellaneous/DealerTrade_EXT.md)


@description



### [DealershipLocationAPI](/Miscellaneous/DealershipLocationAPI.md)


@description



### [DeskLog_EXT](/Miscellaneous/DeskLog_EXT.md)






### [EmailADFGeneralHandler](/Miscellaneous/EmailADFGeneralHandler.md)






### [EmailADFHandler](/Miscellaneous/EmailADFHandler.md)






### [EmailADFVoiceHandler](/Miscellaneous/EmailADFVoiceHandler.md)






### [EmailHandler](/Miscellaneous/EmailHandler.md)






### [EnterpriseAPIMock](/Miscellaneous/EnterpriseAPIMock.md)






### [EquipmentTable_EXT](/Miscellaneous/EquipmentTable_EXT.md)






### [EvalExpression](/Miscellaneous/EvalExpression.md)


 Port - Apex EvalEx - Apex Expression Evaluator An Apex port of EvalEx @ https://github.com/uklimaschewski/EvalEx /** Port - RT_Expression - Apex Expression Eval https://github.com/jdcrensh/apex-evalex /** EvalExpression is an eval engine ported to support DealerTeam Sage Integration Functions Modifications List



### [FormAPI](/Miscellaneous/FormAPI.md)






### [GenericHistoryComponentController](/Miscellaneous/GenericHistoryComponentController.md)






### [IdentityApi](/Miscellaneous/IdentityApi.md)


 Identiy API provides access to a number of external consumer databases. The purposes of these API's are to assist the end user with additional data related to the Account records he/she is working with. First Available in 1.601 https://success.dealerteam.com/Middleware/API_Guide/Caller_Identification



### [InboundEmailNotifications](/Miscellaneous/InboundEmailNotifications.md)






### [InstallScript](/Miscellaneous/InstallScript.md)


 2016-06-30   |Jarrett Kuljis | Updated to create custom settings for Payment Methods on Install and insert new settings on update if none exist. 2016.10.25      |Abhishek Goel         |W-000572 Run batch class to update service lookup on Vehicle Inventory 2016.10.27      |Abhishek Goel         |W-000622 Update new equipped field with old mis-spelled equiped field for version <= 1.582



### [InstallScriptAPI](/Miscellaneous/InstallScriptAPI.md)






### [InstallScriptOrgAPI](/Miscellaneous/InstallScriptOrgAPI.md)






### [InventoryMediaService](/Miscellaneous/InventoryMediaService.md)






### [InventoryMediaServiceMockCallout](/Miscellaneous/InventoryMediaServiceMockCallout.md)






### [InvocableADF](/Miscellaneous/InvocableADF.md)






### [MockHttpResponseGenerator](/Miscellaneous/MockHttpResponseGenerator.md)






### [PartAPI](/Miscellaneous/PartAPI.md)


 PartAPI - Service layer encapsulation for interaction with Parts



### [PartInventoryControl](/Miscellaneous/PartInventoryControl.md)






### [PartInvoiceAPI](/Miscellaneous/PartInvoiceAPI.md)






### [PartLocationMigrate](/Miscellaneous/PartLocationMigrate.md)


 @test PartPhysicalInventoryDomainLayer.testPartsMasterTriggerHandler Date            |Developer            |Work# Notes -- 2017.13.01      |Gaurav               |W-000892 Created batch class for bulk insertion of Part Physical Detail records



### [PartsInventoryRESTService](/Miscellaneous/PartsInventoryRESTService.md)






### [PartsInvoicePrint](/Miscellaneous/PartsInvoicePrint.md)


 		W-001569 @test PartInvoicingServiceLayer.testPartsInvoicePrint



### [PartsInvoice_EXT](/Miscellaneous/PartsInvoice_EXT.md)






### [PartsInvoice_Printing](/Miscellaneous/PartsInvoice_Printing.md)






### [PartsPhysical_EXT](/Miscellaneous/PartsPhysical_EXT.md)


 PartsPhysical_EXT - Controller Extension to create and perform the physical inventory process @test PartPhysicalInventoryServiceLayer.testPartsMasterTriggerHandler dealer__PartsPhysicalInvenotry__c - Light object, no sharing or bulk API Access dealer__PartsPhysicalDetail - records of each part that is part of the physical (this can be the entire location inventory, specific Bin locations or a periodical / random selection of parts) General Steps to a Physical are as follows. 1) General the physical file based on type - location, bin, dollar or random. Or part# Sequence.  (Zero quantity suppressed) 2) Prepare the Count Sheets for Print / Or Scan 3) Perform the Physical (non software) 4) Process the count sheets - hand enter the values or process the scanner files 5) Enter any hand writes - parts found that do not have a record in the system 6) Variance Report on the values that the hand count differs from the inventory count. 7) Variance Report on the Cost differential betwen the current master and FIFO Value - Optional Step 8) Post the Variance, update the General Ledger and Post the updated Quantity to the Inventory 9) Prepare the physical audit report and attach to the Physical. 2016.08.30       |Gaurav               |Case# 00002013 Added code coverage for part master description change 2016.09.23       |Gaurav               |Case# 00002007 Added Notes field in query of Parts Physical Detail object's records 2017.01.13       |Gaurav               |W-000892 Added code to add Parts using Batch class and moved the logic into PartsPhysicalInventoryAPI class



### [PurchaseOrderRESTService](/Miscellaneous/PurchaseOrderRESTService.md)






### [SROPrint](/Miscellaneous/SROPrint.md)






### [SalesLead_EXT](/Miscellaneous/SalesLead_EXT.md)


 SalesLead_EXT - Cotnrols interaction wiht the salesup object



### [SalesUp](/Miscellaneous/SalesUp.md)






### [SalesUpDuplicateSearchLex_EXT](/Miscellaneous/SalesUpDuplicateSearchLex_EXT.md)


 SalesUpDuplicateSearchLex_EXT - Controls interaction with the salesup object Date            |Developer            |Work# Notes -- 2016.12.30       |Sneha                |Case#1819 Created controller to redirect to the same page on click of Search Again button of SalesUpDuplicateSearchLex page. 2017.01.04       |Sneha                | Modified controller to redirect to SalesUpDuplicateSearchLex from SalesUpNewLex page.



### [SchedulableCarFaxHistoryReport](/Miscellaneous/SchedulableCarFaxHistoryReport.md)






### [SchedulableInventoryMedia](/Miscellaneous/SchedulableInventoryMedia.md)






### [SchedulableOutboundFileTransfer](/Miscellaneous/SchedulableOutboundFileTransfer.md)






### [SecureVDCSettings](/Miscellaneous/SecureVDCSettings.md)






### [ServiceEstimatePrint](/Miscellaneous/ServiceEstimatePrint.md)






### [ServiceRepairOrderPrint](/Miscellaneous/ServiceRepairOrderPrint.md)


 		W-001569



### [ServiceVehicleAPI](/Miscellaneous/ServiceVehicleAPI.md)






### [TestClassUtil](/Miscellaneous/TestClassUtil.md)






### [TestFactory](/Miscellaneous/TestFactory.md)






### [USPSHttpCalloutMock](/Miscellaneous/USPSHttpCalloutMock.md)






### [Utility](/Miscellaneous/Utility.md)


 Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact



### [VINDecodeRemote](/Miscellaneous/VINDecodeRemote.md)


 Date              |Developer             |Work 2016-07-11         Sneha                  T-00854 Date              |Developer             |Case 2016-07-11         Sneha                  C-00002224 To decode VIN when common data is null, and take basic data from the array of styles.



### [VINDecoder](/Miscellaneous/VINDecoder.md)






### [VINDecoder_DataOneSoftware](/Miscellaneous/VINDecoder_DataOneSoftware.md)






### [WorkOrderPrintController](/Miscellaneous/WorkOrderPrintController.md)






### [autoCompleteController](/Miscellaneous/autoCompleteController.md)


@description



### [batchCalculateRewardsBalance](/Miscellaneous/batchCalculateRewardsBalance.md)


@description



### [batchCalculateRewardsExec](/Miscellaneous/batchCalculateRewardsExec.md)


@description



### [batchRemoveInStore](/Miscellaneous/batchRemoveInStore.md)


@description



### [batchRemoveInStoreExec](/Miscellaneous/batchRemoveInStoreExec.md)


@description



### [cashierPageController](/Miscellaneous/cashierPageController.md)


@description



### [resetStockNumber](/Miscellaneous/resetStockNumber.md)





## Common

### [Cashier](/Common/Cashier.md)


This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.


## Sales

### [DealAPI](/Sales/DealAPI.md)


DealAPI provides service layer logic for processing requests related to the Deal Records


## Service

### [ServiceRepairOrderAPI](/Service/ServiceRepairOrderAPI.md)


Service Layer Encapsulation of interaction with the Repair Order Object.


