---
layout: default
---
# PurchaseOrderController



**Group** Parts

## Properties

### `public isReceive` → `Boolean`


---
## Methods
### `public static List<LookupSearchResult> searchAccounts(String searchTerm, Boolean isVendor)`

`AURAENABLED`

allows custom lookups on PO components to search for accounts

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm to match accounts against|
|`isVendor`|boolean determining to search for vendor or non vendor accounts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> List of records matching hte search term|


**Method** searchAccounts

### `public static List<LookupSearchResult> recentAccounts(Boolean isVendor)`

`AURAENABLED`

Returns recently viewed Account records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<Purchase_Order_Line__c> getLinesByPO(Id orderId)`

`AURAENABLED`

returns all Parts Invoice Lines belonging to a Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|return description|


**Method** getPartLinesByInvoice

### `public static List<Purchase_Order_Line__c> saveSubletOrderLines(List<Purchase_Order_Line__c> lines, Id poId)`

`AURAENABLED`

creates or updates provided sublet PO Lines related to a single Purchase Order

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines PO Lines to upsert|
|`poId`|poId Parent Purchase Order for the lines|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|List<Purchase_Order_Line> all lines for the related PO|


**Method** saveSubletOrderLines

### `public static List<Purchase_Order_Line__c> saveMiscOrderLines(List<Purchase_Order_Line__c> lines, Id poId)`

`AURAENABLED`

creates or updates provided miscellaneous PO Lines related to a single Purchase Order

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines PO Lines to upsert|
|`poId`|poId Parent Purchase Order for the lines|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|List<Purchase_Order_Line> all lines for the related PO|


**Method** saveMiscOrderLines

### `public static Purchase_Order__c save(Purchase_Order__c po, Purchase_Order_Line__c line)`

`AURAENABLED`

Overloaded save method for saving Purchase Order & Purchase Order Line

#### Parameters

|Param|Description|
|---|---|
|`po`|Purchase Order record to save|
|`line`|Purchse Order Line record to save|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|void|


**Method** save

### `public static List<Purchase_Order_Line__c> savePartsOrderLines(List<Purchase_Order_Line__c> lines, Id poId)`

`AURAENABLED`
### `public static List<Purchase_Order_Line__c> deleteLine(Id lineId)`

`AURAENABLED`
### `public static List<CoreCharge__c> getCoreCharges(Id orderId)`

`AURAENABLED`

returns core charge records ordered on the purchase order line Id provided

#### Parameters

|Param|Description|
|---|---|
|`orderId`|Purchase Order the cores were purchased on|

#### Returns

|Type|Description|
|---|---|
|`List<CoreCharge__c>`|List<CoreCharge__c> related core charges|


**Method** getCoreCharges

### `public static List<LookupSearchResult> searchMiscCodes(String searchTerm, String recordId)`

`AURAENABLED`

returns MiscChargeCodes related to an order's location and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchMiscCodes

### `public static MiscChargeCode__c getMiscCodeById(String codeId)`

`AURAENABLED`

returns a Misc Charge Code record from an ID

#### Parameters

|Param|Description|
|---|---|
|`codeId`|codeId description|

#### Returns

|Type|Description|
|---|---|
|`MiscChargeCode__c`|return description|


**Method** getMiscCodeById

### `public static List<LookupSearchResult> searchServiceJobs(String searchTerm, String recordId)`

`AURAENABLED`

returns Service Jobs related to an order's Service Repair Order and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchServiceJobs

### `public static List<LookupSearchResult> relatedServiceJobs(String recordId)`

`AURAENABLED`

returns all Service Jobs related to an order's Service Repair Order

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** relatedServiceJobs

### `public static Service_Job__c getServiceJobById(String jobLineId)`

`AURAENABLED`

returns Service Job records from the record Id

#### Parameters

|Param|Description|
|---|---|
|`serviceJobId`|serviceJobId description|

#### Returns

|Type|Description|
|---|---|
|`Service_Job__c`|return description|


**Method** getServiceJobById

### `public static List<LookupSearchResult> recentVehicles()`

`AURAENABLED`

Returns recently viewed Vehicle records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static ChartControlNumbers getChartControls(String accountNumber, String vendorId)`

`AURAENABLED`

getChartControls returns the control number and chart of accounts for a given account number

#### Parameters

|Param|Description|
|---|---|
|`accountNumber`||
|`vendorId`||

#### Returns

|Type|Description|
|---|---|
|`ChartControlNumbers`|return ChartControlNumbers|

### `public static List<LookupSearchResult> getRecentPartMasters()`

`AURAENABLED`

Returns recently viewed part master records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static Vehicle_Inventory__c selectedVehicle(String vehicleId)`

`AURAENABLED`

Retrieves selected Vehicle on a PO Line record

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|vehicleId description|

#### Returns

|Type|Description|
|---|---|
|`Vehicle_Inventory__c`|return description|


**Method** selectedVehicle

### `public static List<LookupSearchResult> searchVehicleInventory(String searchTerm)`

`AURAENABLED`

Searches for VehicleInventory

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<FieldSetWrapper> getFieldSetMembers(String objRef, String setName)`

`AURAENABLED`

Method for retrieving field set members based off of object name and fieldset name

#### Parameters

|Param|Description|
|---|---|
|`objRef`|API name of object being referenced|
|`setName`|API name of fieldset being referenced on the object|

#### Returns

|Type|Description|
|---|---|
|`List<FieldSetWrapper>`|returns a wrapper class containing fieldnames and required status|


**Method** getFieldSetMembers

### `public static List<PurchaseOrder.lineReceiver> getLinesToReceive(Id poId)`

`AURAENABLED`
### `public static Purchase_Order__c receive(Id poId, List<PurchaseOrder.lineReceiver> receiverLines, Purchase_Order_Receiving__c por, Boolean accept)`

`AURAENABLED`

Method to receive parts on an open purchaes order         Update the Inventory History         Increase the QOH - Physical         Update FIFO/LIFO Table         Hook to external Accounting Systems

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|PageReference|


**Method** receive

### `public static Purchase_Order__c acceptHeader(Id poId)`

`AURAENABLED`

Accept a PO without a receiving event

#### Parameters

|Param|Description|
|---|---|
|`poId`|Id of PO to accept|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|Updated PO|

### `public static Boolean keepOpenEnabled()`

`AURAENABLED`
### `public static Purchase_Order__c accept(Id poId)`

`AURAENABLED`

Calls PurchaseOrderAPI to accept a PO

#### Parameters

|Param|Description|
|---|---|
|`poId`|poId description|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|return description|


**Method** accept

### `public static Purchase_Order__c post(Id poId)`

`AURAENABLED`

Calls PurchaseOrderAPI to post a PO

#### Parameters

|Param|Description|
|---|---|
|`poId`|poId description|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|return description|


**Method** post

### `public static Purchase_Order__c void(Id poId)`

`AURAENABLED`
### `public static Account getAccount(Id acctId)`

`AURAENABLED`

returns account from Id provided

#### Parameters

|Param|Description|
|---|---|
|`acctId`|acctId description|

#### Returns

|Type|Description|
|---|---|
|`Account`|return description|


**Method** getAccount

### `public static List<Utility.fieldSetWrapper> checkPartStockFieldSet()`

`AURAENABLED`

returns field set info for Part Stock Management on Parts Inventory

#### Returns

|Type|Description|
|---|---|
|`List<Utility.fieldSetWrapper>`|return description|


**Method** checkPartStockFieldSet

### `public static ReceivingEvent createReceivingEvent(Id poId, List<PurchaseOrder.LineReceiver> lines, Purchase_Order_Receiving__c por)`

`AURAENABLED`

Creates Receive Event from Line Receivers. This is a UI-specific method used in the purchaseOrderActionReceive LWC.

#### Parameters

|Param|Description|
|---|---|
|`poId`|poId description|
|`lines`|lines description|


**Method** createReceivingEvent

### `public static void deleteReceiveEvent(Purchase_Order_Receiving__c event)`

`AURAENABLED`

On error this method will revert PO lines to original Part Received value.

---
## Classes
### ChartControlNumbers
#### Fields

##### `public controlNumber` → `String`

`AURAENABLED` 

##### `public controlAlternate` → `String`

`AURAENABLED` 

##### `public chartAccounts` → `List&lt;LookupSearchResult&gt;`

`AURAENABLED` 

---

### receivingEvent

Wrapper class to hold receiving related data needed in the chained receiving calls

#### Fields

##### `public recHeader` → `Purchase_Order_Receiving__c`

`AURAENABLED` 

##### `public lineReceivers` → `List&lt;PurchaseOrder.LineReceiver&gt;`

`AURAENABLED` 

---

### PurchaseOrderControllerException

**Inheritance**

PurchaseOrderControllerException


---
