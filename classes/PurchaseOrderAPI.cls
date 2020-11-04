public class PurchaseOrderAPI implements PurchaseOrder.IPo {

    /* Shared variables */
    public Purchase_Order__c purchaseorder {get;set;}
    public List<Purchase_Order_Line__c> purchaseorderlines {get;set;}
    public List<PurchaseOrder.lineReceiver> purchaseorderReceiverLines {get;set;}
    public Purchase_Order_Receiving__c receipt {get;set;}
    public static Boolean receiveAccept {get;set;}


    /* Static Methods */
    /**
     * Method forcefully selects from the database the status of the purchase order in the event the PO is open in more than one screen.
     * @param Id of the purchase order to query
     * @returns boolean which is true if status is open or partial, otherwise false
     * @test PartOrderingServiceLayer.testPORestService
     */
    public static boolean isOpen(Id poId) {
        // Method forcefully selects from the database the status of the purchase order in the event the PO is open in more than one screen.
        Purchase_Order__c[] poStatus = [SELECT Id, Status__c FROM Purchase_Order__c WHERE Id =: poId];
        if (poStatus.isEmpty())
            throw new PurchaseOrderAPIException('No record found for ' + poId);

        if (poStatus[0].Status__c == 'Open' || poStatus[0].Status__c == 'Partial') {
            return true;
        }

        return false;
    }

    /**
     * Inserts provided PO and PO Lines 
     * @param purchase_Order__c the PO to be inserted
     * @param List<purchase_Order_Line__c> the related PO Lines to be inserted
     * @returns purchase_Order__c the PO that was inserted
     * @test PartOrderingServiceLayer.testPORestService
     */
    public static Purchase_Order__c create(Purchase_Order__c po, List < Purchase_Order_Line__c > poLines) {
        List < Purchase_Order_Line__c > lines = new List < Purchase_Order_Line__c > ();
       
        try {
            insert(po);
                for (Purchase_Order_Line__c poLine: poLines) {
                    poLine.Purchase_order__c = po.Id;
                    lines.add(poLine);
                }
                //200 batches
                insert managePartLines(lines, po.Company__c);
        } catch (DMLException e) {
            throw new PurchaseOrderAPIException(e.getMessage());
        }
        return po;
    }

    /**
     * Adds provided po lines to the provided po 
     * @param purchase_Order__c the PO to be updated
     * @param List<purchase_Order_Line__c> the related PO Lines to be added
     * @returns purchase_Order__c the PO that was updated
     * @test PartOrderingServiceLayer.testPORestService
     */
    public static Purchase_Order__c updatePO(Purchase_Order__c purchaseOrder, List<Purchase_Order_Line__c> poLines){
        system.debug('porder '+purchaseOrder+ ' poLines '+poLines);
        List<Purchase_Order_Line__c> lines = new List<Purchase_Order_Line__c>();
        
        for(Purchase_Order_Line__c poLine : poLines){
            //If were adding a NEW po line to the purchase Order
            if(poLine.Purchase_Order__c == null)
            poLine.Purchase_Order__c = purchaseOrder.Id;
            lines.add(poLine);
        }
        try{
            upsert purchaseOrder;
            //200 batches
            upsert managePartLines(lines, purchaseOrder.Company__c);

        } catch(DMLException e){
            throw new PurchaseOrderAPIException(e.getMessage());
        }
        return purchaseOrder;
    }

    /**
     * Updates part field on PO Lines, calling method to create local parts inventory if needed
     * @param List<purchase_Order_Line__c> the related PO Lines to be updated
     * @param Id of location to be referenced
     * @returns List<purchase_Order_Line__c> with updated part field
     * @test PartOrderingServiceLayer.testPORestService
     */
    public static List<Purchase_Order_Line__c> managePartLines(List<Purchase_Order_Line__c> poLines, Id locationId){
            //Dealer_Location__C.Id = locationId
            List<Purchase_Order_Line__c> returnLines = new List<Purchase_Order_Line__c>();
            
            Set<Id> partMasterIdSet = new Set<Id>();
            Map<Id, Parts_Inventory__c> partList = new Map<Id,Parts_Inventory__c>();
            Map<Id,Parts_Inventory__c> newParts  = new Map<Id,Parts_Inventory__c>();
            List<Id> pmIds = new List<Id>();

            for(Purchase_Order_Line__c l : poLines){
                if (l.Parts_Master__c != null && l.Part_Quantity__c!=null){
                    partMasterIdSet.add(l.Parts_Master__c);
                }else{
                    throw new PurchaseOrderAPIException('Parts Master and Part Quantity are needed to create new Purchase Order Lines for PO line with Id: '+l.Id);
                }
            }
            for(Parts_Inventory__c p : [SELECT Id, Parts_Master__c FROM Parts_Inventory__c WHERE Parts_Master__c IN: partMasterIdSet AND Location__c =: locationId]){
                partList.put(p.Parts_Master__c, p);
            }
            for(Purchase_Order_Line__c l : poLines){
                if(partlist.get(l.Parts_Master__c)==null){
                    pmIds.add(l.Parts_Master__c);
                }
            }
            List<Parts_Master__c> inventoryToCreate = [SELECT Id From Parts_Master__c WHERE Id In: pmIds];
            if(inventoryToCreate != null){
                //returns Map<partsMasterId, part>
                 newParts = PartAPI.createInventoryFromMaster(inventoryToCreate,locationId);
            }
            partList.putAll(newParts);
            for(Purchase_Order_Line__c l : poLines){
                l.Part__c = partList.get(l.Parts_Master__c).Id;
                returnLines.add(l);
            }
        return returnLines;
    }
    /**
     * Queries for PO Lines given a PO Id
     * @param Id of PO to be referenced
     * @returns List<purchase_Order_Line__c> related to given PO Id
     * @test PartOrderingUILayer.testUnvoidPO
     */
    public static List<Purchase_Order_Line__c> purchaseOrderLines(Id purchaseOrderId) {
        return [SELECT Purchase_Order__c, Account__c, Amount__c, Customer_Total__c, Description__c, Drop_Ship_Address__c, Drop_Ship_To__c, Item_Value__c, 
                                            Pack_Quantity__c, Part_Cost__c, Part_Quantity_Outstanding__c, Part_Quantity_Received__c, Part_Quantity__c, Part__c, Parts_Invoice__c, 
                                            Parts_Line__c, Parts_Master__c, Product__c, Purchase_Order_Accepted_Date__c, Quantity__c, RecordType__c, Returned_to_Vendor__c, 
                                            Service_Job_Line__c, Special_Instructions__c, Name, Id, CreatedById, CreatedDate, LastModifiedDate, LastModifiedById,
                                            Purchase_Order__r.dealer__Company__c 
                    FROM Purchase_Order_Line__c
                    WHERE Purchase_Order__c=:purchaseOrderId];
    }

    /**
     * Handles deletion of PO Lines
     * @Param List<Purchase_Order_Line__c> to be deleted
     * @test PartOrderingServiceLayer.testPORESTService
     */
    public static void deletePurchaseOrderLines(List<Purchase_Order_Line__c> poLines){
        try{
            system.debug(' tt '+[select id from purchase_Order_Line__c]);
            delete poLines;
        }catch(DMLException e){
            throw new PurchaseOrderAPIException(e.getMessage());
        }
    }

    /**
     * Purchase Order Accept Event
     * @Param purchase_Order__c
     * @Param List<PurchaseOrder.lineReceiver>
     * @Param Purchase_Order_Receiving__c
     * @returns purchase_Order__c
     * @test PartOrderingUILayer.testVoid
     */
    public static Purchase_Order__c receive(Purchase_Order__c po, List<PurchaseOrder.lineReceiver> linestoReceive, Purchase_Order_Receiving__c receiveHeader) {

        // Instantiate Instance for Receive Method
        PurchaseOrderAPI poApi = new PurchaseOrderAPI();

        poApi.receipt = receiveHeader;
        
        if(po!=null && po.Id!=null) {
            po = [SELECT Id, Name, Status__c, RecordType.DeveloperName, PO_Amount__c FROM Purchase_Order__c WHERE Id=:po.id];
            poApi.purchaseorder      = po;
            poApi.purchaseorderlines = PurchaseOrderAPI.purchaseOrderLines(po.Id);
            poApi.purchaseorderReceiverLines = linestoReceive;
        } else {
            throw new PurchaseOrderAPIException('receive method requires a valid purchase order to be passed as the primary argument');
        }


        if(po.Status__c != 'Open' && po.Status__c != 'Void' && po.Status__c != 'Partial') /* Double Check to see that it is not Partial */
        {   
            throw new PurchaseOrderAPIException('Purchase Order already received.  You may not receive this purchase order a second time.');
        }           

        // Get Custom Setting for Purchase Order Events (Fixed Ops Hierarchy Setting)
        FixedOperationsSettings__c fops = FixedOperationsSettings__c.getOrgDefaults();

        // Prevent 0 dollar PO's from being accepted.
        if(po.PO_Amount__c==null || po.PO_Amount__c==0 
            && po.RecordType.DeveloperName!='Vehicle_Purchase'
            && po.RecordType.DeveloperName!='Misc') {
            throw new PurchaseOrderAPIException('Unable to Accept a purchase order with no dollar value.  Please add lines or VOID if necessary. ');
        }

        // If this is a parts purchase order process accordingly
        if(po.RecordType.DeveloperName=='Parts_Purchase') {
            poApi.receivePartsPurchaseOrder();
            return po;
        }

        // Transaction Control
        SavePoint sp = Database.setSavePoint();

        // Check to see that all parts lines have been received.
        // This logic should never be encountered as the Accept method does not apply to parts purchases
        if(po.RecordType.DeveloperName == 'Parts_Purchase') {
            for(Purchase_Order_Line__c l : [SELECT Part__c, Part_Quantity_Received__c,
                                                     Part_Quantity_Outstanding__c, Amount__c,
                                                     Name, Id
                                                     FROM Purchase_Order_Line__c
                                                    Where Purchase_Order__c =:po.Id limit 5000]) {

                if(l.Part_Quantity_Received__c == null) {
                    Database.rollback(sp);
                    throw new PurchaseOrderAPIException('Error, all part lines must have a Quantity Received before the Purchase Order may be accepted.');
                }
            }
        }

        try {

            // Perform the acceptance by the user, if an external Accounting system is involved, perform account async actions
            if(po.RecordType.DeveloperName=='Misc' || po.RecordType.DeveloperName=='Sublet' || po.RecordType.DeveloperName=='Vehicle_Purchase') {

                String poAction = '';
                if(po.RecordType.DeveloperName=='Misc') { poAction='purchase_order_misc'; }
                if(po.RecordType.DeveloperName=='Sublet') { poAction='purchase_order_sublet'; }
                if(po.RecordType.DeveloperName=='Vehicle_Purchase') { poAction='vehicle_purchase'; }
                
                String message = '{ "recordId" : "'+po.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "' + poAction + '", "partsReceiptValue" : null }';
                try {
                    Cashier.emailAsyncHandler(message);
                }Catch(Exception e) {
                    throw new PurchaseOrderAPIException(e.getMessage());
                }
            }
            
            if(receiveAccept){
                po.Status__c            =   'Accepted';
                po.Invoice_Number__c = receiveHeader.Vendor_Invoice__c;
                po.Invoice_Date__c = receiveHeader.Vendor_Invoice_Date__c;
                po.Invoice_Amount__c = receiveHeader.Vendor_Invoice_Amount__c;
                po.Accepted_By__c       =   UserInfo.getUserId();
                if(po.Accepted_DateTime__c==null) {
                    po.Accepted_DateTime__c = Datetime.now();
                }
            }else{
                po.Status__c            =   'Open';
            }

            update po;

            poApi.recordReceiveEvent(po);

        } Catch(DmlException e) {
            Database.rollback(sp);
            throw new PurchaseOrderAPIException(e.getMessage());
        } Catch(Exception e) {
            database.rollback(sp);
            throw new PurchaseOrderAPIException(e.getMessage());
        }

        return po;      
    }

    /**
     *
     * Private method for receiving parts purchase orders
     * @test PartOrderingUILayer.testVoid
     */
    private void receivePartsPurchaseOrder() {

        System.assert(purchaseorderReceiverLines.size()>0, 'receivePartsPurchaseOrder() requires receiver lines to be populated.');

        Purchase_Order__c po = purchaseorder;

        Set<id> SetIDPM = new Set<id>();
        Set<id> SetIDLocation = new Set<id>();
        Set<Id> SetPartInvoiceLines = new Set<Id>();
        List<Parts_Inventory__c> ListUpdatePartInv = new List<Parts_Inventory__c>(); // Deprecating due to same part# potentially being on the line. 
        Map<Id, Parts_Inventory__c> MapUpdatePartInv = new Map<Id, Parts_Inventory__c>();
        List<Parts_Ledger__c> negativeSaleLegerList = new List<Parts_Ledger__c>();
 
        // Check to see if this is a Transfer PO
        PartTransfer__c transfer;
        Parts_Invoice__c partsinvoice;
        Boolean isTransfer=false;
        for(PartTransfer__c transferRecord : [SELECT Id, Parts_Invoice__c, Purchase_Order__c FROM PartTransfer__c WHERE Purchase_Order__c=:po.Id]) {
            transfer=transferRecord;
            isTransfer=true;
            partsinvoice = new Parts_Invoice__c(Id=transfer.Parts_Invoice__c); 
        }

        // Stock parts into the inventory of the selected company they are ordered against.
        // 1) Loop the Purchase Order Lines
        Parts_Inventory__c inv = new Parts_Inventory__c();
        List<Part_Inventory_History__c> inHist = new List<Part_Inventory_History__c>();
        List<Purchase_Order_Line__c> rLines = new List<Purchase_Order_Line__c>();

        // TO-DO : Lookup to invoice line

        // Set Savepoint
        Savepoint sp = Database.setSavePoint();
        List<Parts_Ledger__c> ledgerList = new List<Parts_Ledger__c>();
        List<Parts_Ledger__c> ledgerListUpdate = new List<Parts_Ledger__c>();

        // Amount (Value) to post to the General Ledger
        Decimal glValue = 0;
            
        for(PurchaseOrder.lineReceiver l : purchaseorderReceiverLines) {
            SetIDPM.add(l.line.Parts_Master__c);
            SetIDLocation.add(l.line.Purchase_Order__r.Company__c);
            
            if(l.line.Parts_Line__c!=null)
                SetPartInvoiceLines.add(l.line.Parts_Line__c);
        }

        map<id,Parts_Master__c> mapIdPartMaster = new map<id,Parts_Master__c>([SELECT Id, Name, Part_Description__c, Cost__c,
                                                    Retail_Price__c, Part_No_Display__c,
                                                    Weight__c, Warranty_Price__c, Manufacturer__c,
                                                    Jobber_Price__c, Pack_QTY__c, Core_Value__c, Core_Required__c
                                                    FROM Parts_Master__c
                                                    WHERE Id IN: SetIDPM]);

        map<id,Dealer_Location__c> mapIdLocation = new map<id,Dealer_Location__c>([SELECT Id, Company_Number__c 
                                                    FROM Dealer_Location__c 
                                                    WHERE Id IN:SetIDLocation]);

        // Populate the negative sales ledger list
        negativeSaleLegerList = [SELECT Part__c, Current_Value__c, Entry_Date__c, 
                                    Item_Value__c, Parts_Sale_Line__c, Purchase_Order__c, 
                                    Purchased_By__c, Quantity__c, Repair_Order_Line__c, 
                                    Sold_By__c, Transaction_Note__c, Name, Id 
                                        FROM Parts_Ledger__c
                                        WHERE Parts_Sale_Line__c IN:SetPartInvoiceLines
                                        AND Quantity__c < 0];

        map<String,Parts_Inventory__c> mapIdPartInv = new map<String,Parts_Inventory__c>();

        for(Parts_Inventory__c obj:[SELECT Id, On_Order__c,Replenishment_Date__c, On_Hand__c, Parts_Master__c, Location__c, Part_Number__c, Parts_Master__r.Pack_QTY__c
                                                        FROM Parts_Inventory__c
                                                        Where Parts_Master__c IN: SetIDPM
                                                        AND Location__c IN:SetIDLocation])
        {
            mapIdPartInv.put(obj.Parts_Master__c+'-'+obj.Location__c, obj);
        }

        for(PurchaseOrder.lineReceiver l : purchaseorderReceiverLines) {

            // Check that received is not greater than requested
            if(l.updateQuantity > l.line.Part_Quantity__c) {
                Database.rollback(sp); //W-000410
                throw new PurchaseOrderAPIException('Quantity Accepted may not be greated than Quantity Requested.');
            }

            // If never in local store inventory add to store
            Parts_Inventory__c invLookup = new Parts_Inventory__c();
            invLookup = mapIdPartInv.get(l.line.Parts_Master__c+'-'+l.line.Purchase_Order__r.Company__c);

            if(invLookup == null) {
                // Get the Master Data
                Parts_Master__c pm = mapIdPartMaster.get(l.line.Parts_Master__c);
                List<Parts_Master__c> pmList = new List<Parts_Master__c>{
                    pm
                };

                try {
                    inv = PartAPI.createInventoryFromMaster(pmList, l.line.Purchase_Order__r.Company__c).values()[0];

                } Catch(DmlException e) {
                    database.rollback(sp);
                    throw new PurchaseOrderAPIException('Unable to add part to local store inventory. '+e.getMessage());
                }

            } else {
                inv = invLookup;
            }

            // Prevent Nulls
            if(inv.On_Hand__c==null) {inv.On_Hand__c=0;}
            if(inv.On_Order__c==null) {inv.On_Order__c=0;}
            if(l.updateQuantity==null) {l.updateQuantity=0;}


            // Add support for pack - non-pack part purchases
            Decimal packQTY = inv.Parts_Master__r.Pack_QTY__c; //W-000541
            if(l.line.Pack_Part_Override__c==true) {
                packQTY=1;
            }

            // Prepend the GL Value
            glValue += (l.updateQuantity * (l.line.Item_Value__c));
            glValue = glValue.setScale(2, System.RoundingMode.HALF_UP);

            //
            // Create the Ledger Entries, requires a QTY from the PartsMaster
            /*
                If the part is received with an associated part sale line, then the related negative sale line *must* be updated, not skipped.
                If the part is a pack part and only a partial order was sold (Pack parts sell in individual unit of measure) then 
                the resulting ledger entries must respect the Quantity sold and it may be less than the pack value
                Example: Invoice line has a single item sold that is a pack part.  
                    Sale -1
                    Purchase 1 pack of 10
                    On Hand = 9
                    Total Ledger Entries = 10
            */

            // 1) Get the associated negative sale items from the ledger
            Decimal negCount = 0;
            Decimal itemsReceived = l.updateQuantity * packQTY;
            Decimal itemsProcessed = 0;
            Decimal negativeValue = 0;

            for(Parts_Ledger__c pl : negativeSaleLegerList) {

                if(pl.Parts_Sale_Line__c != null
                    && l.line.Parts_Line__c != null
                    && pl.Parts_Sale_Line__c == l.line.Parts_Line__c
                    && l.updateQuantity != null
                    && l.updateQuantity != 0
                    && itemsReceived > itemsProcessed) {
                        pl.Quantity__c=0;
                        pl.Purchase_Order__c=po.Id;
                        pl.Purchased_By__c=UserInfo.getFirstName()+' '+UserInfo.getLastName();
                        pl.Transaction_Note__c=po.Name+' received;'+pl.Transaction_Note__c;
                        ledgerListUpdate.add(pl);
                        negCount++;
                        itemsProcessed++;
                        negativeValue += Math.abs(pl.Item_Value__c);
                }
            }

            // New Ledger Lines
            List<Parts_Ledger__c> receivingLineLedger = new List<Parts_Ledger__c>();  // This will contain only the ledger items for this subline
            for(Decimal i=1; i<=((l.updateQuantity * packQTY) - negCount); i++) {

                // If pack part override is set on PO Line, change Item Value formula.
                Decimal qtyDivisor = packQTY;
                if(l.line.dealer__Pack_Part_Override__c) {
                    qtyDivisor=1;
                }

                Decimal itemValueSet = (l.line.Item_Value__c / qtyDivisor);
 
                receivingLineLedger.add(new Parts_Ledger__c(
                                    Part__c=inv.Id,
                                    Entry_Date__c=Date.today(),
                                    Quantity__c=1,
                                    Purchase_Order__c=po.Id,
                                    Item_Value__c=itemValueSet.setScale(2, RoundingMode.HALF_UP),
                                    Transaction_Note__c=po.Name+' received;',
                                    // Repair_Order_Line__c=l.line.Service_Job_Line__c, //Don't need the RO Line linked, on pack parts this will link all
                                    Purchased_By__c=UserInfo.getFirstName()+' '+UserInfo.getLastName()
                                )
                );
            }

            // Review the sum of the ledger to the line amount to ensure balanced ledger entries.  
            // In some circumstances the PackQTY is not divisible by the line amount, in this case round down/up the last line

            Decimal rawLineAmount = (l.updateQuantity==l.line.Part_Quantity__c) ? l.line.Amount__c : (l.line.Amount__c / l.line.Part_Quantity__c) * l.updateQuantity; // This value can differ from dealernet.  This is a value used when receipting the ledgers to balance
                    // rawLineAmount.setScale(2, System.RoundingMode.HALF_EVEN); ?
            Decimal runningTotal  = negativeValue; // cary forward any negative value
            for(Parts_Ledger__c pl : receivingLineLedger) {
                runningTotal += pl.Item_Value__c;
            }

            if(rawLineAmount!=runningTotal) { // We have an out of balance, possibly due to non-divisble pack parts
                
                // Appply to Ledger Entry
                if (receivingLineLedger.size() > 0){
                Decimal adjustmentLine = (rawLineAmount-runningTotal) + receivingLineLedger[0].Item_Value__c;
                receivingLineLedger[0].Item_Value__c=adjustmentLine.setScale(2, RoundingMode.HALF_UP);
                    }
                }
            // Set the ledger list to the main ledger list
            ledgerList.addAll(receivingLineLedger);

            // Sanity Check
            if(l.updateQuantity > 0) {

                // Check to see if the QTY Received is greater than ordered.  If so throw an error.
                if(l.line.Part_Quantity_Received__c==null) {
                    l.line.Part_Quantity_Received__c=0;
                }

                if((l.updateQuantity+l.line.Part_Quantity_Received__c) > l.line.Part_Quantity__c) {
                    database.rollback(sp);
                    throw new PurchaseOrderAPIException('Error: Quantity Received may not be greated than QTY Ordered');
                }

                rLines.add(new Purchase_Order_Line__c(Id=l.line.Id, Part_Quantity_Received__c=(l.updateQuantity+l.line.Part_Quantity_Received__c)));
            }

            // Reduce On Order prior to Pack Adjust
            if(inv.On_Order__c>0) {
                inv.On_Order__c = inv.On_Order__c - l.updateQuantity;
            }

            // UOM - Pack Quantitiy needs to increase QTY by Pack Amount
            if(inv.Parts_Master__c != null && packQTY != null && packQTY>1) {
                l.updateQuantity = (l.updateQuantity * inv.Parts_Master__r.Pack_QTY__c);
            }

            // Set Inventory
            inv.On_Hand__c  = inv.On_Hand__c + l.updateQuantity;

            // Correct On_Order if it has gone negative
            if(inv.On_Order__c<0) {
               inv.On_Order__c=0;
            }
            
            // Update Replenishmate date
            inv.Replenishment_Date__c = system.today();
            try {

                // if Exists in Map Add Values
                if(MapUpdatePartInv.get(inv.Id)!=null) {
                    Parts_Inventory__c tmpInv = MapUpdatePartInv.get(inv.Id);
                    tmpInv.On_Hand__c  = inv.On_Hand__c;
                    tmpInv.On_Order__c = inv.On_Order__c;
                    tmpInv.Replenishment_Date__c = system.today();
                    MapUpdatePartInv.put(inv.Id, tmpInv);
                } else {
                    MapUpdatePartInv.put(inv.Id, inv);
                }


            } Catch(DmlException e) {
                database.rollback(sp);
                throw new PurchaseOrderAPIException('Error updating inventory '+e.getMessage());
            }

            // Update Inventory History
            if(l.line.Amount__c==null) {
                database.rollback(sp);
                throw new PurchaseOrderAPIException('Purchase Order Line Amount can not be Null');
            }
            inHist.add(new Part_Inventory_History__c(
                                Part__c=inv.Id,
                                Purchase_Order__c=po.Id,
                                Cost__c=((l.line.Item_Value__c / packQTY) * l.updateQuantity),
                                Quantity_Adjustment__c=l.updateQuantity,
                                Transaction_Event__c='Purchase Order Received',
                                Transaction_Time__c=Datetime.now()
                            )
            );
        }
        
        try
        {

            update MapUpdatePartInv.values();
            // insert ledgerList;
            PartAPI.subLedgerDML(ledgerList, 'INSERT');

            if(!ledgerListUpdate.isEmpty()) {
                // update ledgerListUpdate;
                PartAPI.subLedgerDML(ledgerListUpdate, 'UPDATE');
            }
        } Catch(DmlException e) {
            database.rollback(sp);
            throw new PurchaseOrderAPIException('Error '+e.getMessage());
        }
            
            
        try {

            if(inHist.size()>0) {
                insert inHist;
            }

            if(rLines.size()>0) {
                update rLines;
            }

            // Select Sum of Outstanding to see if we have all lines filled.
             AggregateResult[] linesFilled = [Select SUM(Part_Quantity_Outstanding__c) al From Purchase_Order_Line__c where Purchase_Order__c =:po.Id];
             Decimal allPartsLines = (Decimal)linesFilled[0].get('al');

            // Only set if All Lines Accpeted
            if(allPartsLines == 0) {
                if(receiveAccept){
                    po.Status__c            =   'Accepted';
                    po.Accepted_By__c       =   UserInfo.getUserId();
                    po.Accepted_DateTime__c =   Datetime.now();

                }else{
                    po.Status__c            =   'Open';
                }
                
            } else {
                // Add a note for partial acceptance
                // Update to Partial Status (Work: https://dealerteam--agf.na14.visual.force.com/apex/adm_userstorydetail?id=a4sd0000000xCP1&sfdc.override=1)
                po.Status__c            =   'Partial';
            }

            if(receipt != null){
                Purchase_Order_Receiving__c por = recordReceiveEvent(receipt);  //Updated to use the following data map that contains receiver data <purchaseorderReceiverLines>
                po.dealer__Invoice_Number__c = por.dealer__Vendor_Invoice__c;
                po.dealer__Invoice_Date__c = por.dealer__Vendor_Invoice_Date__c;
                po.dealer__Invoice_Amount__c = por.dealer__Vendor_Invoice_Amount__c;
            }
            
            update po;
            
            if(!isTransfer) { // Follows an alternative posting method

                // Updated Posting Interface, email built when the ASYNC Handler is in place
                String message = '{ "recordId" : "'+po.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parts_receipt", "partsReceiptValue" : ' + glValue + ' }';

                try {
                    Cashier.emailAsyncHandler(message);
                }Catch(DmlException e) {
                    Database.rollback(sp);
                    throw new PurchaseOrderAPIException(e.getMessage());
                }
            }

            // Check to see if the Total QTY Shipped is received, if so close the Transfer invoice and update the Transfer
            if(allPartsLines==0 && isTransfer) {
                transfer.Status__c='Received';
                partsinvoice.Status__c='Posted';
                partsinvoice.Invoice_Date_Time__c=Datetime.now();
                partsinvoice.Post_Date_Time__c=Datetime.now();

                String postPartInvoiceMessage = '{ "recordId" : "'+transfer.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parttransfer_post", "partsReceiptValue" : ' + null + ' }';

                try {

                    update transfer;
                    update partsinvoice;

                    Cashier.emailAsyncHandler(postPartInvoiceMessage);

                } Catch(DmlException e) {

                } Catch(Exception e) {
                    database.rollback(sp);
                    throw new PurchaseOrderAPIException(e.getMessage());
                }

            }

        } catch(DmlException e) {
            database.rollback(sp);
            throw new PurchaseOrderAPIException('Purchase Order - Fatal Error: Unable to receive part(s). '+e.getMessage());
        }
    }

    /**
     *
     *  private method to record the receive events to the receiving table
     *  @Param Purchase_Order_Receiving__c
     */
    private Purchase_Order_Receiving__c recordReceiveEvent(Purchase_Order_Receiving__c headerEvent) {

        // Iteration of lines
        Decimal amnt = 0;
        Decimal receivedCount = 0;
        Decimal outstandingCount = 0;

        for(PurchaseOrder.lineReceiver poline : purchaseorderReceiverLines) {
            amnt+=((poline.updateQuantity / poline.line.Pack_Quantity__c) == poline.line.Part_Quantity__c) ? poline.line.Amount__c : (poline.line.Amount__c / poline.line.Part_Quantity__c) * (poline.updateQuantity / poline.line.Pack_Quantity__c);
            receivedCount+=(poline.updateQuantity / poline.line.Pack_Quantity__c);
            outstandingCount+=Math.abs(poline.line.Part_Quantity_Outstanding__c) - (poline.updateQuantity / poline.line.Pack_Quantity__c);
        }

        Purchase_Order_Receiving__c por = new Purchase_Order_Receiving__c(
            Purchase_Order__c=purchaseorderlines[0].Purchase_Order__c,
            Purchase_Order_Line__c=(purchaseorderlines.size()==1) ? purchaseorderlines[0].Id : null,
            Amount__c=amnt,
            Quantity_Received__c=receivedCount,
            Quantity_Outstanding__c=outstandingCount,
            Vendor_Invoice__c=headerEvent.Vendor_Invoice__c,
            Vendor_Invoice_Date__c=headerEvent.Vendor_Invoice_Date__c,
            Vendor_Invoice_Amount__c=headerEvent.Vendor_Invoice_Amount__c,
            Shipping_Handling__c=headerEvent.Shipping_Handling__c
        );


        // DML event
        try {
            insert por;
            return por;
            
        } Catch(DmlException e) {
            throw new PurchaseOrderAPIException(e.getMessage());
        } Catch(Exception e) {
            throw new PurchaseOrderAPIException(e.getMessage());
        }
    }

    /**
     * recordReceiveEvent
     * @notes This method records a non-parts purchase order receive event. 
     */
    private Purchase_Order_Receiving__c recordReceiveEvent(Purchase_Order__c po)
    {

        // Assert Purchase Order Object is populated.
        System.assert(po.Id!=null, 'Purchase Order must be created before receiving event can be stored.');

        Purchase_Order_Receiving__c por = new Purchase_Order_Receiving__c(
            Purchase_Order__c=po.Id,
            Amount__c=po.PO_Amount__c,
            Vendor_Invoice__c=po.Invoice_Number__c,
            Vendor_Invoice_Date__c=po.Invoice_Date__c,
            Vendor_Invoice_Amount__c=po.Invoice_Amount__c
        );

        // DML event
        try {
            insert por;
            return por;
        } Catch(DmlException e) {
            throw new PurchaseOrderAPIException(e.getMessage());
        } Catch(Exception e) {
            throw new PurchaseOrderAPIException(e.getMessage());
        }        

    }

    public class PurchaseOrderAPIException extends Exception {}
    
}