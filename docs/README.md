# Classes
## Miscellaneous

### [Auction123RESTService](/Misc/Auction123RESTService.md)



### [BatchPopulateServiceIdOnVehicleInventory](/Misc/BatchPopulateServiceIdOnVehicleInventory.md)



### [BatchUpdateEquippedField](/Misc/BatchUpdateEquippedField.md)



### [BatchUpdatePartSaleMetricExec](/Misc/BatchUpdatePartSaleMetricExec.md)



### [BirthDayRemainderScheduler](/Misc/BirthDayRemainderScheduler.md)



### [CarDealsActivity](/Misc/CarDealsActivity.md)



### [CarDealsActivityBatchable](/Misc/CarDealsActivityBatchable.md)



### [CarfaxAPIMock](/Misc/CarfaxAPIMock.md)



### [ChangeContactAccountOwnerOnCarDeal](/Misc/ChangeContactAccountOwnerOnCarDeal.md)



### [ChangeContactAccountOwnerOnCarDeal_Batch](/Misc/ChangeContactAccountOwnerOnCarDeal_Batch.md)



### [ClaimAPI](/Misc/ClaimAPI.md)



### [ClaimPrintController](/Misc/ClaimPrintController.md)



### [ContactsDuplicateSearch](/Misc/ContactsDuplicateSearch.md)



### [DMSBatchCleanRecords](/Misc/DMSBatchCleanRecords.md)

DMSBatchCleanRecords

### [DMSImportsRESTService](/Misc/DMSImportsRESTService.md)



### [DMSSyncBulkLoadBatch](/Misc/DMSSyncBulkLoadBatch.md)



### [DealForm_EXT](/Misc/DealForm_EXT.md)

DealForm_EXT 
 * @group Sales

### [DealPrintController](/Misc/DealPrintController.md)



### [DealerTrade_EXT](/Misc/DealerTrade_EXT.md)



### [DealershipLocationAPI](/Misc/DealershipLocationAPI.md)



### [EnterpriseAPIMock](/Misc/EnterpriseAPIMock.md)



### [EquipmentTable_EXT](/Misc/EquipmentTable_EXT.md)



### [FormAPIMock](/Misc/FormAPIMock.md)



### [GenericHistoryComponentController](/Misc/GenericHistoryComponentController.md)



### [IdentityApi](/Misc/IdentityApi.md)

Identiy API provides access to a number of external consumer databases.  
 * The purposes of these API&apos;s are to assist the end user with additional 
 * data related to the Account records he/she is working with. First Available in 1.601 https://success.dealerteam.com/Middleware/API_Guide/Caller_Identification

### [ImpactFormController](/Misc/ImpactFormController.md)



### [InstallScript](/Misc/InstallScript.md)

2016-06-30   |Jarrett Kuljis | Updated to create custom settings for Payment Methods on Install and insert new settings on update if none exist. 2016.10.25      |Abhishek Goel         |W-000572 Run batch class to update service lookup on Vehicle Inventory 
 * 2016.10.27      |Abhishek Goel         |W-000622 Update new equipped field with old mis-spelled equiped field for version &lt;= 1.582

### [InstallScriptAPI](/Misc/InstallScriptAPI.md)



### [InstallScriptOrgAPI](/Misc/InstallScriptOrgAPI.md)



### [InvocableADF](/Misc/InvocableADF.md)



### [MockHttpResponseGenerator](/Misc/MockHttpResponseGenerator.md)



### [PartInventoryControl](/Misc/PartInventoryControl.md)



### [SecureVDCSettings](/Misc/SecureVDCSettings.md)



### [TestFactory](/Misc/TestFactory.md)

// The TestFactory will pre-fill all the fields we typically need

// You can use the methods like a void to populate SetupData TestFactory.createSObjectList(new Account(), 200, true);

// Or return the object Account a = (Account)TestFactory.createSObject(new Account()); insert a;

// You can also set values to be used. Any values set in the constructor will override the defaults Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id));

// You can also specify a specific set of overrides for different scenarios Account a = (Account)TestFactory.createSObject(new Account(), &apos;TestFactoryFieldData.AccountDefaults&apos;);

// Finally, get a bunch of records for testing bulk Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 200); // You can optionally insert records as created like this: // Note the final parameter of true. Account a = (Account) TestFactory.createSObject(new Account(), true); Contact c = (Contact) TestFactory.createSObject(new Contact(AccountID = a.Id), true);
  @group Test

### [USPSHttpCalloutMock](/Misc/USPSHttpCalloutMock.md)



### [Utility](/Misc/Utility.md)

Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact

### [VINDecodeRemote](/Misc/VINDecodeRemote.md)

Date              |Developer             |Work 2016-07-11         Sneha                  T-00854 Date              |Developer             |Case 2016-07-11         Sneha                  C-00002224 To decode VIN when common data is null, and take basic data from the array of styles. @group Sales

### [autoCompleteController](/Misc/autoCompleteController.md)



### [batchCalculateRewardsBalance](/Misc/batchCalculateRewardsBalance.md)



### [batchCalculateRewardsExec](/Misc/batchCalculateRewardsExec.md)



### [batchRemoveInStore](/Misc/batchRemoveInStore.md)



### [batchRemoveInStoreExec](/Misc/batchRemoveInStoreExec.md)



### [cashierPageController](/Misc/cashierPageController.md)


## Deprecated

### [B2CAccounts](/Deprecated/B2CAccounts.md)

Deprecated - This routine has been scheduled for deprecation
## Batch Processing

### [BatchCarfaxHistoryReport](/Batch-Processing/BatchCarfaxHistoryReport.md)

Performs batch execution to refresh the vehicle history report of Service Vehicles.

### [BatchCompletePhysical](/Batch-Processing/BatchCompletePhysical.md)

Database Batchable interface used with the processing of Parts Physical Inventory workload.
## Service

### [BatchDeleteVehicleEquipment](/Service/BatchDeleteVehicleEquipment.md)



### [BatchMigrateVehicleEquipment](/Service/BatchMigrateVehicleEquipment.md)



### [BatchUpdatePartSaleMetric](/Service/BatchUpdatePartSaleMetric.md)

BatchUpdatePartSaleMetric

### [BatchUpdateVehicleInternalCharges](/Service/BatchUpdateVehicleInternalCharges.md)

BatchUpdateVehicleInternalCharges

### [SROPrint](/Service/SROPrint.md)

SROPrint - controls the printing of Service Repair Orders. 
*               This file is used both by managed and non-managed code.

### [ServiceEstimatePrint](/Service/ServiceEstimatePrint.md)

ServiceEstimatePrint - Print Class

### [ServiceRepairOrderAPI](/Service/ServiceRepairOrderAPI.md)

Service Layer Encapsulation of interaction with the Repair Order Object.

### [ServiceRepairOrderPrint](/Service/ServiceRepairOrderPrint.md)

W-001569

### [ServiceVehicleAPI](/Service/ServiceVehicleAPI.md)



### [WorkOrderPrintController](/Service/WorkOrderPrintController.md)


## Common

### [Cashier](/Common/Cashier.md)

This class performs core cashiering related actions.  Cashier.cls is used throughout the invocing processes.
## Sales

### [DealAPI](/Sales/DealAPI.md)

DealAPI provides service layer logic for processing requests related to the Deal Records

### [DeskLog_EXT](/Sales/DeskLog_EXT.md)



### [EmailADFGeneralHandler](/Sales/EmailADFGeneralHandler.md)



### [EmailADFHandler](/Sales/EmailADFHandler.md)



### [EmailADFVoiceHandler](/Sales/EmailADFVoiceHandler.md)



### [EmailHandler](/Sales/EmailHandler.md)



### [FormAPI](/Sales/FormAPI.md)



### [InboundEmailNotifications](/Sales/InboundEmailNotifications.md)



### [SalesLead_EXT](/Sales/SalesLead_EXT.md)

SalesLead_EXT - Cotnrols interaction wiht the salesup object

### [SalesUp](/Sales/SalesUp.md)



### [SalesUpDuplicateSearchLex_EXT](/Sales/SalesUpDuplicateSearchLex_EXT.md)

SalesUpDuplicateSearchLex_EXT - Controls interaction with the salesup object Date            |Developer            |Work# Notes -- 2016.12.30       |Sneha                |Case#1819 Created controller to redirect to the same page on click of Search Again button of SalesUpDuplicateSearchLex page. 2017.01.04       |Sneha                | Modified controller to redirect to SalesUpDuplicateSearchLex from SalesUpNewLex page.

### [SchedulableCarFaxHistoryReport](/Sales/SchedulableCarFaxHistoryReport.md)



### [SchedulableInventoryMedia](/Sales/SchedulableInventoryMedia.md)



### [SchedulableOutboundFileTransfer](/Sales/SchedulableOutboundFileTransfer.md)



### [VINDecoder](/Sales/VINDecoder.md)



### [VINDecoder_DataOneSoftware](/Sales/VINDecoder_DataOneSoftware.md)



### [resetStockNumber](/Sales/resetStockNumber.md)


## Test

### [InventoryMediaServiceMockCallout](/Test/InventoryMediaServiceMockCallout.md)



### [TestClassUtil](/Test/TestClassUtil.md)


## Parts

### [PartAPI](/Parts/PartAPI.md)

PartAPI - Service layer encapsulation for interaction with Parts

### [PartInvoiceAPI](/Parts/PartInvoiceAPI.md)



### [PartsInventoryRESTService](/Parts/PartsInventoryRESTService.md)



### [PartsInvoicePrint](/Parts/PartsInvoicePrint.md)



### [PartsInvoice_EXT](/Parts/PartsInvoice_EXT.md)



### [PartsInvoice_Printing](/Parts/PartsInvoice_Printing.md)



### [PartsPhysical_EXT](/Parts/PartsPhysical_EXT.md)

PartsPhysical_EXT - Controller Extension to create and perform the physical inventory process

### [PartsTapeRESTService](/Parts/PartsTapeRESTService.md)



### [PurchaseOrderRESTService](/Parts/PurchaseOrderRESTService.md)


## Parts 2017.13.01      |Gaurav               |W-000892 Created batch class for bulk insertion of Part Physical Detail records

### [PartLocationMigrate](/Parts-201713.01------|Gaurav---------------|W-000892-Created-batch-class-for-bulk-insertion-of-Part-Physical-Detail-records/PartLocationMigrate.md)


