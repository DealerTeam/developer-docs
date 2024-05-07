---
layout: default
---
# PurchaseOrderAPI



**Group** Parts

## Fields

### `private INVOCABLE_METHODS` → `List<String>`


---
## Properties

### `public purchaseorder` → `Purchase_Order__c`


### `public purchaseorderlines` → `List<Purchase_Order_Line__c>`


### `public purchaseorderReceiverLines` → `List<PurchaseOrder.lineReceiver>`


### `public receipt` → `Purchase_Order_Receiving__c`


### `public receiveAccept` → `Boolean`


### `public coresByPart` → `Map<Id,CoreCharge__c>`


### `public coresToDelete` → `List<CoreCharge__c>`


---
## Methods
### `public static boolean isOpen(Id poId)`

Method forcefully selects from the database the status of the purchase order in the event the PO is open in more than one screen.

#### Parameters

|Param|Description|
|---|---|
|`Id`|of the purchase order to query|

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean which is true if status is open or partial, otherwise false|


**Test** PartOrderingServiceLayer.testPORestService

### `public static Purchase_Order__c create(Purchase_Order__c po, List<Purchase_Order_Line__c> poLines)`

Inserts provided PO and PO Lines

#### Parameters

|Param|Description|
|---|---|
|`purchase_Order__c`|the PO to be inserted|
|`List`|<purchase_Order_Line__c> the related PO Lines to be inserted|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|purchase_Order__c the PO that was inserted|


**Test** PartOrderingServiceLayer.testPORestService

### `public static Purchase_Order__c updatePO(Purchase_Order__c purchaseOrder, List<Purchase_Order_Line__c> poLines)`

Adds provided po lines to the provided po

#### Parameters

|Param|Description|
|---|---|
|`purchase_Order__c`|the PO to be updated|
|`List`|<purchase_Order_Line__c> the related PO Lines to be added|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|purchase_Order__c the PO that was updated|


**Test** PartOrderingServiceLayer.testPORestService

### `public static List<Purchase_Order_Line__c> saveSubletLines(List<Purchase_Order_Line__c> lines, Boolean isReceive)`

handles update of service sublet lines

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|
|`isReceive`|isReceive description|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|return description|


**Method** saveSubletLines

### `public static List<Purchase_Order_Line__c> saveVehicleSubletLines(List<Purchase_Order_Line__c> lines, Boolean isReceive)`

handles update of vehicle sublet lines

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|
|`isReceive`|isReceive description|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|return description|


**Method** saveVehicleSubletLines

### `public static List<Purchase_Order_Line__c> managePartLines(List<Purchase_Order_Line__c> poLines, Id locationId)`

Updates part field on PO Lines, calling method to create local parts inventory if needed

#### Parameters

|Param|Description|
|---|---|
|`List`|<purchase_Order_Line__c> the related PO Lines to be updated|
|`Id`|of location to be referenced|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|List<purchase_Order_Line__c> with updated part field|


**Test** PartOrderingServiceLayer.testPORestService

### `global static List<Purchase_Order_Line__c> purchaseOrderLines(Id purchaseOrderId)`

Queries for PO Lines given a PO Id

#### Parameters

|Param|Description|
|---|---|
|`Id`|of PO to be referenced|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|List<purchase_Order_Line__c> related to given PO Id|


**Test** PartOrderingUILayer.testUnvoidPO

### `public static void deletePurchaseOrderLines(List<Purchase_Order_Line__c> poLines)`

Handles deletion of PO Lines

#### Parameters

|Param|Description|
|---|---|
|`List`|<Purchase_Order_Line__c> to be deleted|


**Test** PartOrderingServiceLayer.testPORESTService

### `public static void ERPInsert(Purchase_Order__c po)`

Synchronously Saves Purchase order to Accounting.

### `public static void ERPUpdateAsync(Purchase_Order__c po)`

- Asynchronously Updates PO in Accounting.

### `public static void ERPDelete(Purchase_Order__c po)`

- Asynchronously Deletes PO from Accounting

### `public static Purchase_Order__c receive(Purchase_Order__c po, List<PurchaseOrder.lineReceiver> linestoReceive, Purchase_Order_Receiving__c receiveHeader)`

Purchase Order Accept Event

#### Parameters

|Param|Description|
|---|---|
|`purchase_Order__c`||
|`List`|<PurchaseOrder.lineReceiver>|
|`Purchase_Order_Receiving__c`||

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|purchase_Order__c|


**Test** PartOrderingUILayer.testVoid

### `global static Purchase_Order__c accept(Purchase_Order__c po)`

validates and accept a purchase order

#### Parameters

|Param|Description|
|---|---|
|`po`|Purchase_Order__c PO to accept, must have Id and Status|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|Purchase_Order__c accepted purchase order|


**Method** accept

### `private static void updateLinesFromReceivers(Purchase_Order__c po, List<PurchaseOrder.lineReceiver> linestoReceive, Purchase_Order_Receiving__c receiveHeader)`

This private method updates Purchase Order Lines from Receiver Lines' data.

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global static Purchase_Order__c post(Purchase_Order__c po)`

validates and post a purchase order

#### Parameters

|Param|Description|
|---|---|
|`po`|Purchase_Order__c PO to post, must have Id and Status|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|Purchase_Order__c posted purchase order|


**Method** post

### `global static Purchase_Order__c void(Purchase_Order__c po)`

validates and voids a PO with a related note with the user who voided

#### Parameters

|Param|Description|
|---|---|
|`po`|Purchase_Order__c to be validated and updated, can provide custom field values to save|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|return description|


**Method** void

### `private void processPartsPurchaseOrderLines()`

processPartsPurchaseOrderLines *MAIN LOGIC* for processing parts purchase order lines.  This logic is complex as it processes subledgers for parts and associated invoices.

### `private void updatePartsInvoiceLines(List<PartAPI.PartReceivingLedger> finalLedger)`

updatePartsInvoiceLines description

#### Parameters

|Param|Description|
|---|---|
|`finalLedger`|finalLedger description|

### `private static List<PurchaseOrder.lineReceiver> setLineValues(List<Purchase_Order_Line__c> poLines, List<PurchaseOrder.lineReceiver> receiverLines)`

setLineValues pre-processes the purchase order lines to ensure the Amount each part is being received at is from the database if null.

#### Parameters

|Param|Description|
|---|---|
|`poLines`|poLines description|
|`receiverLines`|receiverLines description|

#### Returns

|Type|Description|
|---|---|
|`List<PurchaseOrder.lineReceiver>`|List<PurchaseOrder.lineReceiver> List of Purchase Order Line Receiver wrapper class items.|

### `private void updatePartsPurchaseLines(List<PartAPI.PartReceivingLedger> finalLedger)`
### `private void notifyExternalGeneralLedger(PartTransfer__c transfer, Purchase_Order__c po, Decimal ledgerValue)`
### `private PartTransfer__c processPartsTransfer()`
### `private void updatePartsPurchaseOrder()`
### `private Map<Id,Purchase_Order_Receiving_Line__c> recordReceivingEvent(List<PartAPI.PartReceivingLedger> finalLedger, Purchase_Order_Receiving__c porHeader)`
### `private void recordReceivingEvent(Purchase_Order_Receiving__c porHeader)`

creates receiving event for non-part POs

#### Parameters

|Param|Description|
|---|---|
|`porHeader`|porHeader description|


**Method** recordReceivingEvent

### `private void recordInventoryHistory(List<PartAPI.PartReceivingLedger> finalLedger)`
### `private List<Parts_Ledger__c> flattenPartsLedgers(Map<Id,List<Parts_Ledger__c>> ledgerByPart, Map<Id,Purchase_Order_Receiving_Line__c> receivingLines)`
### `private Decimal partLedgerValue(List<PartAPI.PartReceivingLedger> finalLedger)`

Calculates total value of the ledger transactions

#### Parameters

|Param|Description|
|---|---|
|`finalLedger`|finalLedger description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Method** partLedgerValue

### `private PartAPI processNegativeLedgers(PurchaseOrder l, PartAPI activeLedger)`

processNegativeLedgers description

#### Parameters

|Param|Description|
|---|---|
|`l`|l description|
|`ledgerList`|ledgerList description|

#### Returns

|Type|Description|
|---|---|
|`PartAPI`|return description|

### `private PartAPI processPositiveLedgers(PurchaseOrder l, PartAPI activeLedger)`

processPositiveLedgers description

#### Parameters

|Param|Description|
|---|---|
|`l`|l description|
|`ledgerList`|ledgerList description|

#### Returns

|Type|Description|
|---|---|
|`PartAPI`|return description|

### `private Parts_Inventory__c processInventory(PurchaseOrder l, Parts_Inventory__c part)`
### `private Integer setPackQuantity(PurchaseOrder receiverLine)`
### `private Map<Id,List<Parts_Ledger__c>> obtainInventoryLedger(List<PurchaseOrder.lineReceiver> receiverLines)`

obtainInventoryLedger obtains existing negative ledgers and returns them in a map by part Id

#### Parameters

|Param|Description|
|---|---|
|`receiverLines`|List<PurchaseOrder.lineReceiver> List of receiver lines|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Parts_Ledger__c>>`|Map<Id, List<Parts_Ledger__c> Parts Map containing negative ledger|

### `private Set<Id> partIdsByReceiverLines(List<PurchaseOrder.lineReceiver> receiverLines)`

partIdsByReceiverLines description

#### Parameters

|Param|Description|
|---|---|
|`receiverLines`|List<PurchaseOrder.lineReceiver> List of Receiver Lines|

#### Returns

|Type|Description|
|---|---|
|`Set<Id>`|Set<Id> Set of Part IDS|

### `private List<PurchaseOrder.lineReceiver> obtainInventory(List<PurchaseOrder.lineReceiver> receiverLines)`

obtainInventory obtains moment-in-time inventory data for uptake of inventory

#### Parameters

|Param|Description|
|---|---|
|`receiverLines`|List<PurchaseOrder.lineReceiver> List of lines to receive|

#### Returns

|Type|Description|
|---|---|
|`List<PurchaseOrder.lineReceiver>`|List<PurchaseOrder.lineReceiver> Updated list of purchaes order receiver lines|

### `private void validate()`

validate description

### `private List<PurchaseOrder.lineReceiver> createPartInventoryRecords(List<PurchaseOrder.lineReceiver> poLines, Purchase_Order__c po)`

This method adjusts the Purchaes Order Receiver Lines object to include parts inventory when ordered for the first time.

#### Parameters

|Param|Description|
|---|---|
|`poLines`|List<PurchaseOrder.lineReceiver> Wrapper class data of parts purchase order lines.|
|`po`|Purchase_Order__c The parent purchase order data.|

#### Returns

|Type|Description|
|---|---|
|`List<PurchaseOrder.lineReceiver>`|PurchaseOrder.lineReceiver|

### `public static Purchase_Order__c updatePOHeader(Purchase_Order__c po, Purchase_Order_Receiving__c receiveHeader)`

Updates a Purchase Order as part of the receiving process

#### Parameters

|Param|Description|
|---|---|
|`po`|Purchase Order to update|
|`receiveHeader`|Purchase Order Receiving object with Vendor Invoice data optionally populated|

#### Returns

|Type|Description|
|---|---|
|`Purchase_Order__c`|Updated PO|

### `private static CoreCharge__c createCoreCharge(Purchase_Order_Line__c line, CoreCharge__c existingCore)`

instantiates a Core Charge record and returns for later DML

#### Parameters

|Param|Description|
|---|---|
|`line`|Purchase_Order_Line__c line to create a core from|
|`part`|Parts_Inventory__c part related to the core|

#### Returns

|Type|Description|
|---|---|
|`CoreCharge__c`|CoreCharge__c core record that has not been inserted|


**Method** createCoreCharge

### `public static PurchaseOrderController createReceivingEvent(Id poId, List<PurchaseOrder.LineReceiver> lines, Purchase_Order_Receiving__c por)`

Creates Receive Event from Line Receivers prior to the receive method to create the necessary data

#### Parameters

|Param|Description|
|---|---|
|`poId`|poId description|
|`lines`|lines description|
|`por`|Receiving event header|


**Method** createReceivingEvent

### `global static List<InvocableResponse> invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Returns

|Type|Description|
|---|---|
|`List<InvocableResponse>`|return description|


**Method** invoke

### `private static void validateInputs(List<InvocableParams> params)`

Verify the inputs are valid for the invoked method

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|


**Method** validateInputs

### `private static List<PurchaseOrder.LineReceiver> buildReceiverData(InvocableParams inputData)`

Build the line receivers from the input data

#### Parameters

|Param|Description|
|---|---|
|`inputData`|inputData description|

#### Returns

|Type|Description|
|---|---|
|`List<PurchaseOrder.LineReceiver>`|return description|

---
## Classes
### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `global methodName` → `String`

`INVOCABLEVARIABLE` 

##### `global orderLines` → `List&lt;Purchase_Order_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `global receivingHeader` → `dealer__Purchase_Order_Receiving__c`

`INVOCABLEVARIABLE` 

##### `global accept` → `Boolean`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `global order` → `Purchase_Order__c`

`INVOCABLEVARIABLE` 

##### `global orderLines` → `List&lt;Purchase_Order_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `global status` → `String`

`INVOCABLEVARIABLE` 

##### `global message` → `String`

`INVOCABLEVARIABLE` 

---

### PurchaseOrderAPIException

**Inheritance**

PurchaseOrderAPIException


---
