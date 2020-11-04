/**
 * PartTransfer_EXT keeps control of transfering parts between two locaitons
 * 
 */

/**
 * 2016-09-19       |Jarrett Kuljis     |W-000541
 * Support for partial parts purchases on transfer PO
 *
 * 2016-10-24       |Jarrett Kuljis     |W-000538
 * add cancel pagereference for return to tab, add 3rd party financial accounting 
 * inetgration to the commit/reverse methods.
 *
 * 2016.10.27       |Jarrett Kuljis     |W-000623
 * Add jobline to new part invoice line Id, if created from an RO
 */
public with sharing class PartTransfer_EXT {
    
    // Primary Record
    public dealer__PartTransfer__c transfer {get;set;}
    public boolean isOpen {get;set;}

    // Detail Page Content ()
    public dealer__Purchase_Order__c po {get;set;}
    public dealer__Parts_Invoice__c invoice {get;set;}
    public dealer__Dealer_Location__c from_location {get;set;}
    public dealer__Dealer_Location__c to_location {get;set;}

    // Line Add Related Vars
    public dealer__Parts_Invoice_Line__c addLine {get;set;}
    public Id addPartId {get;set;}
    public Id removePartId {get;set;}
    public Decimal addPartQty {get;set;}
    public String lineComment {get;set;}
    public dealer__Parts_Order__c partOrder {get;set;}
    public Decimal lineCount { get { return getInvoiceLines().size();} set; }

    public String orderNumber {get;set;}

    public dealer__FixedOperationsSettings__c ops {get;set;}
    public String postingURL {get;set;}

    // Used to retrieve lines from an Order and present them to a transfer initialize screen
    public List<POvSOCheckboxWrapper> ol_list {get;set;}
    public dealer__Stock_Order__c so {get;set;}

    /**
     * __Constructor
     */
    public PartTransfer_EXT(ApexPages.StandardController controller) {

        System.debug(ApexPages.currentPage().getParameters());

        // Declare new lines
        addLine = new dealer__Parts_Invoice_Line__c();
        partOrder = new dealer__Parts_Order__c();

        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__PartTransfer__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.add('dealer__Requested_By__r.Name');
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            controller.addFields(af);
        }

        transfer = (dealer__PartTransfer__c)controller.getRecord();

        if(Test.isRunningTest() && transfer.Id!=null) {
            transfer = [Select Id, dealer__To_Location__c, dealer__From_Location__c, dealer__Parts_Invoice__c, dealer__Purchase_Order__c, 
                                dealer__Requested_By__c, dealer__Status__c 
                            FROM dealer__PartTransfer__c 
                            WHERE Id=:transfer.Id limit 1];
        }

        if(transfer.dealer__Parts_Invoice__c!=null) {
            invoice =   lookupPartsInvoice(transfer.dealer__Parts_Invoice__c);
        }

        if(transfer.dealer__Purchase_Order__c!=null) {
            po  = lookupPurchaseOrder(transfer.dealer__Purchase_Order__c);
        }

        ops = dealer__FixedOperationsSettings__c.getOrgDefaults();
        if(ops.dealer__Purchase_Order_Post_FF__c!=null&&ops.dealer__Purchase_Order_Post_FF__c!='') {
            postingURL=ops.dealer__Purchase_Order_Post_FF__c;
        }
        if(ops.dealer__Purchase_Order_PDF__c==null) {
            ops.dealer__Purchase_Order_PDF__c = '/apex/dealer__PurchaseOrderPDF';
        }  

        // Determine if the Record is open base on Status
        isOpen = true;
        if(transfer.Status__c == 'Void' || transfer.Status__c == 'Received') {
            isOpen = false;
        }    

        // Check to see if we need to set the Part Line on Create
        if(ApexPages.currentPage().getParameters().get('addPartId')!=null && ApexPages.currentPage().getParameters().get('addPartQty')!=null) {
            addPartId=(Id)ApexPages.currentPage().getParameters().get('addPartId');
            addPartQty=Decimal.valueOf(String.valueOf(ApexPages.currentPage().getParameters().get('addPartQty')));
        }

        // Receive Contents from an Order.  These items are manifested ont he NewTransferViaSOPage.
        String orderId = ApexPages.currentPage().getParameters().get('OrderId');
        if(orderId!=null && orderId!='') {
            so = [SELECT Id, Status__c, Packing_Slip__c, Description__c, Company__c, CreatedDate, Name, 
                    (Select Id, Name, 
                            Value__c, 
                            Scan_Time__c, 
                            Requested_By__c, 
                            Received__c, 
                            Quantity_Ordered__c, 
                            Purchase_Order__c,
                            Parts_Line__c, 
                            Parts_Invoice__c, 
                            Parts_Inventory__c, 
                            Parts_Inventory__r.Parts_Master__c, 
                            Parts_Inventory__r.Pack_QTY__c,
                            Parts_Line__r.Drop_Ship__c, 
                            Service_Job_Line__c, 
                            Repair_Order_ID__c, 
                            Repair_Order_Company_ID__c,
                            Order_Status__c, 
                            Parts_Invoice__r.Customer_ShipTo_AddressFormatted__c,
                            Order_Date__c, 
                            Depot__c, 
                            Back_Ordered__c
                        from Parts_Orders__r where  Purchase_Order__c = null)
                    from Stock_Order__c where Id =:orderId];
    
            if(so.Parts_Orders__r.size() > 0) {
                // Initialize the object
                if(ol_list == null) {
                    ol_list = new List<POvSOCheckboxWrapper>();
                } else {
                    ol_list.clear();
                }
                
                for(dealer__Parts_Order__c pl : so.Parts_Orders__r) {
                    POvSOCheckboxWrapper wl = new POvSOCheckboxWrapper(pl, so.Id);
                    ol_list.add(wl);
                }
            }  

            if(so.Company__c!=null) {
                transfer.To_Location__c=so.Company__c;
            }     
        }        
    }

    /**
     * create
     * @return PageRefernce of the created record PartTransfer__C
     */
    public PageReference create() {
        
        // Get the details from the associated Locations
        Map<Id, dealer__Dealer_Location__c> locations = new Map<Id, dealer__Dealer_Location__c>([Select Id, Name, dealer__Location_Account__c, dealer__Company_Number__c from dealer__Dealer_Location__c where ( ID=:transfer.From_Location__c OR ID=:transfer.To_Location__c) limit 2]);
        
        try {
            System.assertEquals(locations.size(), 2);
        } Catch(Exception e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return null;
        }

        try {

            // Prepare the from Invoice Number
            dealer__DMS_Settings__c pset = [Select Id, dealer__Parts_Current_Invoice_Number__c 
                                                                    From dealer__DMS_Settings__c 
                                                                    where Name = 'ActiveSettings' limit 1];
            pset.dealer__Parts_Current_Invoice_Number__c += 1;  
            String invoiceName = locations.get(transfer.From_Location__c).dealer__Company_Number__c+'-'+String.valueOf(pset.dealer__Parts_Current_Invoice_Number__c);
            update pset;

            // Parts Invoice
            dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
            pi.dealer__Customer__c = locations.get(transfer.From_Location__c).dealer__Location_Account__c;
            pi.dealer__Location__c = transfer.From_Location__c;
            pi.dealer__Company_Number__c = transfer.From_Location__c;
            pi.dealer__Open_Date_Time__c = Datetime.now();
            pi.dealer__Invoice_Number__c = invoiceName;
            pi.dealer__Counterman__c = UserInfo.getUserId();
            pi.dealer__Status__c = 'Open';
            pi.Name = 'INV#-'+invoiceName;
            insert pi;

            invoice = pi;               

            transfer.dealer__Parts_Invoice__c = pi.Id;
            transfer.dealer__Status__c = 'Open';
            insert transfer;

            PageReference p = Page.PartsTransfer;
            p.getParameters().put('id', transfer.Id);
            p.setRedirect(true);
            return p;

        } Catch(DmlException e) {

            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return null;

        }

    }

    /**
     * commitTransfer
     * @return PageReference
     * @notes locks the transfer, creates the purchase order with lines
     */
    public PageReference commitTransfer() {

        // Get the details from the associated Locations
        Map<Id, dealer__Dealer_Location__c> locations = new Map<Id, dealer__Dealer_Location__c>([Select Id, Name, dealer__Location_Account__c, dealer__Company_Number__c from dealer__Dealer_Location__c where ( ID=:transfer.From_Location__c OR ID=:transfer.To_Location__c) limit 2]);       

        Savepoint sp = Database.setSavePoint();

        // Step 1 - Create the purchase order
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c =  locations.get(transfer.From_Location__c).dealer__Location_Account__c;
        po.dealer__Status__c =  'Open';
        po.dealer__Company__c = transfer.To_Location__c;
        po.RecordTypeId      =  Schema.SObjectType.dealer__Purchase_Order__c.getRecordTypeInfosByName().get('Parts Purchase').getRecordTypeId();

        if(transfer.dealer__Requested_By__c!=null) {
            User u = [Select Id, Name from User where Id=:transfer.dealer__Requested_By__c limit 1];
            po.dealer__Requested_By__c=u.Name;
        }

        insert po;      
        
        transfer.dealer__Purchase_Order__c = po.Id; 

        invoice.dealer__Customer_Purchase_Order__c = po.Name;
        update invoice;

        // Step 2 - Add the lines to the purchase order
        List<dealer__Purchase_Order_Line__c> poLines = new List<dealer__Purchase_Order_Line__c>();
        List<dealer__Parts_Invoice_Line__c> pinvLines = PartInvoiceApi.invoiceLines(invoice.Id);
        List<dealer__Parts_Order__c> partOrderLines = new List<dealer__Parts_Order__c>();

        // Contains map of existing sales lines that initiated the order 
        Map<Id,dealer__Parts_Invoice_Line__c> soldOnPartsLines = new Map<Id,dealer__Parts_Invoice_Line__c>();
        Map<Id,dealer__Parts_Order__c> soldOnOrderLines = new Map<Id,dealer__Parts_Order__c>();

        if(pinvLines.size()==0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Transfers can only be commited when they have lines, please add transfer lines and attempt to commit.'));
            return null;            
        }

        Set<Id> transferLineIds = new Set<Id>();
        Set<Id> partMasterIds = new Set<Id>();

        for(dealer__Parts_Invoice_Line__c invoiceLines : pinvLines) {
            transferLineIds.add(invoiceLines.Id);
            if(!partMasterIds.contains(invoiceLines.dealer__Part_Master_Record__c)){
                partMasterIds.add(invoiceLines.dealer__Part_Master_Record__c);
            }
        }

        // Get local inventory parts for the master Id's selected
        // Personal note: Gets current part inventory in To Location without transfer???
        Map<Id, dealer__Parts_Inventory__c> localPartsMap = new Map<Id, dealer__Parts_Inventory__c>();
        for(dealer__Parts_Inventory__c p : [Select Id, Name, dealer__Parts_Master__c from dealer__Parts_Inventory__c where dealer__Parts_Master__c IN:partMasterIds and dealer__Location__c =:transfer.To_Location__c]) {
            if(localPartsMap.get(p.dealer__Parts_Master__c)==null) {
                localPartsMap.put(p.dealer__Parts_Master__c, p);
            }
        }

        if(!transferLineIds.isEmpty()) {
            for(dealer__Parts_Order__c p : [Select Id, dealer__Parts_Line__c, dealer__Transfer_Line__c from dealer__Parts_Order__c where dealer__Transfer_Line__c IN:transferLineIds]) {
                partOrderLines.add(new dealer__Parts_Order__c(Id=p.Id, dealer__Purchase_Order__c=po.Id));
                if(p.dealer__Transfer_Line__c!=null) {
                    //soldOnPartsLines.put(p.dealer__Transfer_Line__c, p);
                    //soldOnOrderLines.put(p.Id, p);
                }
            }

            if(!partOrderLines.isEmpty()) {
                try {
                    update partOrderLines;
                } Catch(DmlException e) {
                    Database.rollBack(sp);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Transfers can only be commited when they have lines, please add transfer lines and attempt to commit.'));
                    return null;                    
                }
            }
        }


        // Loop the lines and get associated Transfers set so the purchase order can be associated with them.

            // loop the lines and create the po lines
            for(dealer__Parts_Invoice_Line__c invoiceLines : pinvLines) {

                Id refJobLine;
                if(invoiceLines.Parts_Order__c!=null 
                    && invoiceLines.Parts_Order__r.Service_Job_Line__c!=null 
                    && invoiceLines.Parts_Order__r.Parts_Line__c!=null) {
                        refJobLine=invoiceLines.Parts_Order__r.Service_Job_Line__c;
                }

                // Check to see if the part in the local inventory is present
                if(localPartsMap.get(invoiceLines.dealer__Part_Master_Record__c)==null) {
                    Database.rollBack(sp);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Part for master record '+invoiceLines.dealer__Part_Master_Record__c+' not found in local inventory.'));
                    return null;
                }
                
                poLines.add(new dealer__Purchase_Order_Line__c(
                        dealer__Purchase_Order__c=po.Id,
                        dealer__Parts_Line__c=invoiceLines.Parts_Order__r.Parts_Line__c,
                        dealer__Service_Job_Line__c=refJobLine,
                        dealer__Part__c=localPartsMap.get(invoiceLines.dealer__Part_Master_Record__c).Id, // Should be po inv part 
                        dealer__Amount__c=invoiceLines.dealer__Cost__c,
                        dealer__Part_Quantity__c=invoiceLines.dealer__Quantity_Sold__c,
                        dealer__Pack_Part_Override__c=true, //Always create transfer parts as individualized parts sales, not pre-pack sales
                        dealer__Parts_Master__c=invoiceLines.dealer__Part_Master_Record__c
                    )
                );
            }

            if(poLines.isEmpty()) {
                Database.rollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Transfers can only be commited when they have lines, please add transfer lines and attempt to commit.'));
                return null;
            }

            try {
                
                insert poLines;

                Set<Id> poLineIds = new Set<Id>();
                Map<Id, dealer__Parts_Invoice_Line__c> iLines = new Map<Id, dealer__Parts_Invoice_Line__c>();
                for(dealer__Purchase_Order_Line__c poLine : poLines) {
                    poLineIds.add(poLine.Id);
                    // Associate the parts invoice lines with purchase orders
                    if(poLine.dealer__Parts_Line__c!=null) {
                        iLines.put(poLine.dealer__Parts_Line__c, new dealer__Parts_Invoice_Line__c(
                                Id=poLine.dealer__Parts_Line__c,
                                dealer__Purchase_Order_Line__c=poLine.Id
                            )
                        );
                    }
                }
                
                // Get list of PO Lines with Inventory Lines that have an associated order, update the transfer lines
                Map<Id, Purchase_Order_Line__c> partRefLines = new Map<Id, Purchase_Order_Line__c>();
				Set<Id> poRelatedSet = new Set<Id>();
                
                for(Purchase_Order_Line__c pl : [Select Id, Name, Purchase_Order__c, Amount__c, Part_Quantity__c, Parts_Line__c, Parts_Line__r.Parts_Order__c, 
                                                         Parts_Line__r.Parts_Order__r.Parts_Line__c 
                                                         from Purchase_Order_Line__c where Id IN:poLineIds]) {
                                                             
                    //Part Invoice Line / Purchase Order Line
                    if(pl.dealer__Parts_Line__c!=null) { 
                         partRefLines.put(pl.dealer__Parts_Line__c, pl);
                         poRelatedSet.add(pl.Purchase_Order__c);
                    }
                                                             
                    if(pl.dealer__Parts_Line__r.dealer__Parts_Order__c != null &&
                        pl.dealer__Parts_Line__r.dealer__Parts_Order__r.dealer__Parts_Line__c != null) {
                        iLines.put(pl.dealer__Parts_Line__r.dealer__Parts_Order__r.dealer__Parts_Line__c, 
                            new dealer__Parts_Invoice_Line__c(
                                    Id=pl.dealer__Parts_Line__r.dealer__Parts_Order__r.dealer__Parts_Line__c,
                                    dealer__Purchase_Order_Line__c=pl.Id
                                )
                        );  
                    }

                }
            
                update iLines.values();
                
                // Force backflush of ledger
                List<Parts_Ledger__c> partLedgerDML = new List<Parts_Ledger__c>();
                for(Parts_Ledger__c ll : [SELECT Id, Name, Item_Value__c, Parts_Sale_Line__c FROM Parts_Ledger__c 
                                          WHERE Parts_Sale_Line__c IN:partRefLines.keySet() 
                                          AND Purchase_Order__c IN: poRelatedSet
                                          AND Parts_Sale_Line__c!=null]) {
               
                    partLedgerDML.add(
                        new Parts_Ledger__c(
                            Id=ll.Id,
                            Item_Value__c=(partRefLines.get(ll.Parts_Sale_Line__c).Amount__c / partRefLines.get(ll.Parts_Sale_Line__c).Part_Quantity__c)
                        )
                    );
                                             
                }

                // update partLedgerDML;
                PartAPI.subLedgerDML(partLedgerDML, 'UPDATE');
                
                update poLines;

            } Catch(DmlException e) {
                Database.rollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
            }

            // Step 3 - Update the status of the transfer
            transfer.Status__c = 'Committed';

            try {
                update transfer;
            } Catch(DmlException e) {
                Database.rollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
            }

            // Step 5 - Issue async processing request to the external general ledger system
                    String message = '{ "recordId" : "'+po.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "partsTransferRequest", "partsReceiptValue" : null }';
            try {
                Cashier.emailAsyncHandler(message);
            } Catch(Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }   
        

        PageReference p = Page.PartsTransfer;
        p.getParameters().put('id', transfer.Id);
        p.setRedirect(true);
        return p;
    }

    /**
     * reverseTransfer
     * @return  PageReference
     * @notes reverses the transfer record and unwind the transaction in the General Ledger.  This is prevented if the transfer is complete
     */
    public PageReference reverseTransfer() {

        Savepoint sp = Database.setSavePoint();

        // Step 1 - Remove lines from the purchase order and transfer invoice
        List<dealer__Purchase_Order_Line__c> poLines = [Select Id, Name from dealer__Purchase_Order_Line__c where dealer__Purchase_Order__c =: po.Id];
        try {
            delete poLines;
        } Catch(DmlException e) {
            Database.rollBack(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;            
        }

        // Step 2 - Void the purchase order, leaving the transfer invoice open
        po.dealer__Status__c = 'Void';
        try {
            update po;
        } Catch(DmlException e) {
            Database.rollBack(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;            
        }       

        // Step 3 - Reverse journal entry in the third party accounting system
        transfer.dealer__Status__c = 'Reversed';
        transfer.dealer__Purchase_Order__c = null;
        try {
            update transfer;
        } Catch(DmlException e) {
            Database.rollBack(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }   

        // Step 4 - Issue async processing request to the external general ledger system
        String message = '{ "recordId" : "'+transfer.Parts_Invoice__C+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "partsTransferReverse", "partsReceiptValue" : null }';
        try {
            Cashier.emailAsyncHandler(message);
        } Catch(Exception e) {
            Database.rollBack(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }           

        PageReference p = Page.PartsTransfer;
        p.getParameters().put('id', transfer.Id);
        p.setRedirect(true);
        return p;
    }

    /**
     * [save description]
     * @return [description]
     */
    public PageReference save() {
        // Create the Transfer Request.  This includes a staged Parts Invoice as well as a Staged Purchase Order
        // Map the shipping details to the Purchase Order
        if(po!=null) {

            po.dealer__Date_Required__c = (invoice.dealer__Required_Date__c!=null) ? invoice.dealer__Required_Date__c : null;
            po.dealer__Comments__c = (invoice.dealer__Shipping_Notes__c!=null) ? invoice.dealer__Shipping_Notes__c : null;
            po.dealer__Tracking__c = (invoice.dealer__Shipping_Tracking_No__c!=null) ? invoice.dealer__Shipping_Tracking_No__c : null;
            po.dealer__Carrier__c = (invoice.dealer__Ship_Via__c!=null) ? invoice.dealer__Ship_Via__c : null;
            po.dealer__Freight__c = (invoice.dealer__Shipping_Charges__c!=null) ? invoice.dealer__Shipping_Charges__c : null;

            try {
                //update invoice;
                update po;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }

        }

        PageReference p = Page.PartsTransfer;
        p.getParameters().put('id', transfer.Id);
        p.setRedirect(true);
        return p;
    }

    /**
     * cancel
     * @return PageReference
     * @notes return user to the part transfer tab
     */
    public PageReference cancel() {
        Schema.DescribeSObjectResult result = dealer__PartTransfer__c.sObjectType.getDescribe();
        PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
        cancelPage.setRedirect(true); 
        return cancelPage;      
    }

    /**
     * addPartInvoiceLine 
     * @return PageReference
     */
    public PageReference addPartInvoiceLine() {

        try {
            dealer__Parts_Inventory__c inventory = [SELECT Id, dealer__Parts_Master__c FROM dealer__Parts_Inventory__c WHERE Id=:addPartId LIMIT 1];
            dealer__Parts_Invoice_Line__c invoiceLine = PartTransferAPI.createTransferLine(transfer, invoice, partOrder, inventory.dealer__Parts_Master__c, addPartQty, lineComment);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        addPartId = null;
        addPartQty= null;
        partOrder=new dealer__Parts_Order__c();
        lineComment='';

        // Redirect to the Transfer Page
        PageReference tp = Page.PartsTransfer;
        tp.getParameters().put('Id', transfer.Id);
        tp.setRedirect(true);
        return tp;
    }

    /**
     * removeLine
     * @return PageReference
     * @notes Removes the parts invoice line, returns to stock and corrects ledger as well as removes the purchase order line.  If this fails an ApexPages error is thrown.
     */
    public PageReference removeLine() {

        System.debug(removePartId);

        if(removePartId==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'removePartId can not be NULL'));          
            return null;
        }

        try {



            dealer__Parts_Invoice_Line__c pi = [Select Id from dealer__Parts_Invoice_Line__c 
                                                            where Id=:removePartId limit 1];
            dealer__Purchase_Order_Line__c[] poline = [Select Id from dealer__Purchase_Order_Line__c 
                                                            where dealer__Parts_Line__c =:removePartId limit 1];

            System.debug(pi);
            System.debug(poline);

            if(!poline.isEmpty()) {
                delete poline;
            }

            PartInvoiceAPI.removeInvoiceLine(pi.Id);

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            System.debug(e.getMessage());
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            System.debug(e.getMessage());           
        }

        lineComment='';

        // Redirect to the Transfer Page
        PageReference tp = Page.PartsTransfer;
        tp.getParameters().put('Id', transfer.Id);
        tp.setRedirect(true);
        return tp;
    }

    /**
     * createFromOrderRequest
     * @return PageReference
     * @notes Used as a special method to create the transfer from the "Order"
     */
    public PageReference createFromOrderRequest() {
        // Preflight check
        Savepoint sp = Database.setSavePoint();
        // Create method 
        // 
        try {
            
            PageReference createPage = create();

            // Add Lines 
            for(POvSOCheckboxWrapper slines : ol_list) {
                system.debug(slines);
                if(slines.checked) {

                    try {
                        PartTransferAPI.createTransferLine( transfer, 
                                                            invoice, 
                                                            new dealer__Parts_Order__c(
                                                                    dealer__Order__c = slines.orderId
                                                                ), 
                                                            slines.oline.dealer__Parts_Inventory__r.dealer__Parts_Master__c, 
                                                            slines.oline.dealer__Quantity_Ordered__c, 
                                                            lineComment);
                    } Catch(Exception e) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                        return null;                    
                    }
                }
            }

            PageReference p = Page.PartsTransfer;
            p.getParameters().put('id', transfer.Id);
            p.setRedirect(true);
            return p;

        } Catch(Exception e) {
            Database.rollBack(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;            
        }

        return null;
    }

    /**
     * void
     * @return PageReference
     * @notes void method for the transfer record
     */
    public PageReference void() {

        // Sanity check to see if there are items on either the Invoice or the Purchase Order.
        if(getInvoiceLines().size()==0) {
            
            transfer.dealer__Status__c = 'Void';
            invoice.dealer__Status__c = 'Void';
            
            try {
                update transfer;
                update invoice;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
            }

        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to VOID a Transfer with line data.  Please remove lines before continuing.  '));
            return null;
        }

        if(po!=null && getPurchaseOrderLines().size()==0) {
            po.dealer__Status__c = 'Void';
            try {
                update po;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
            }
        }       

        return null;
    }

    /** 
     * lookupPartsInvoice
     * @param  invoiceId record id of the invoice that we will be looking up
     * @return dealer__Parts_Invoice__c
     */
    public dealer__Parts_Invoice__c lookupPartsInvoice(Id invoiceId) {
        return PartInvoiceApi.invoice(invoiceId);
    }

    /**
     * getInvoiceLines
     * @return List<dealer__Parts_Invoice_Line__c>
     * @notes getter returning list of invoice lines from the partsinvoiceapi based on the public invoice variable
     */
    public List<dealer__Parts_Invoice_Line__c> getInvoiceLines() {
        return PartInvoiceApi.invoiceLines(invoice.Id);
    }

    /**
     * lookupPurchaseOrder
     * @param  poId record Id of the purchase order that you are interested looking up
     * @return dealer__Purchase_Order__c
     */
    public dealer__Purchase_Order__c lookupPurchaseOrder(Id poId) {

        if(poId==null) {
            return null;
        }

        DescribeSObjectResult describePO = dealer__Purchase_Order__c.getSObjectType().getDescribe();
        List<String> po_fieldNames = new List<String>( describePO.fields.getMap().keySet() );   
        
        po = Database.query('SELECT ' + String.join( po_fieldNames, ',' ) + ' FROM dealer__Purchase_Order__c WHERE Id = \''+String.escapeSingleQuotes(poId) +'\' limit 1 ');    

        return po;

    }

    /**
     * getPurchaseOrderLines
     * @return List<dealer__Purchase_Order_Line__c>
     * @notes getter method to retern list of purchase order lines based on the public variable po
     */
    public List<dealer__Purchase_Order_Line__c> getPurchaseOrderLines() {

        if(po==null || po.Id==null) {
            return null;
        }

        List<dealer__Purchase_Order_Line__c> po_lines = new List<dealer__Purchase_Order_Line__c>();

        DescribeSObjectResult describePOLines = dealer__Purchase_Order_Line__c.getSObjectType().getDescribe();
        List<String> po_fieldNames = new List<String>( describePOLines.fields.getMap().keySet() );  
        
        po_lines = Database.query('SELECT ' + String.join( po_fieldNames, ',' ) + ' FROM dealer__Purchase_Order_Line__c WHERE dealer__Purchase_Order__c = \''+String.escapeSingleQuotes(po.Id) +'\' '); 

        return po_lines;
        
    }
}