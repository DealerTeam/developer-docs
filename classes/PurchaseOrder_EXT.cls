public without sharing class PurchaseOrder_EXT {

    private final dealer__Purchase_Order__c po;

    public String email {get;set;}
    public String subject {get { return 'Purchase Order from '+UserInfo.getOrganizationName(); } set;}
    public String body { get; set; }
    public String TOADDRESS {get;set;}
    public String ccAddress {get;set;}
    public List<AttachmentClass> listAttachment{get;set;}
    public Attachment objAttachment{get;set;}

    public dealer__Service_Repair_Order__c ro { get; set; }
    public static dealer__Parts_Master__c PartsMaster { get; set; }

    public dealer__FixedOperationsSettings__c ops {get;set;}
    public String postingURL {get;set;}

    public List<PurchaseOrder.lineReceiver> receiverLines {get;set;}
    public Purchase_Order_Receiving__c por {get;set;}

    private Messaging.EmailFileAttachment defaultAttachment;
    public map<id,string> mapRecordType{get;set;}
    public Boolean receiveAccept {get;set;}
    public Boolean allowLeaveOpen {get;set;}
    
    /**
     * getAllowSubletReversal Getter method used to determine if the Org allows Purchase Order Reversal
     * @return   boolean Is the DMS Feature "PurchaseOrderReversal" enabled
     */
    public Boolean getAllowSubletReversal()
    {
        return Utility.isDMSFeatureEnabled('PurchaseOrderReversal');
    }

    /**
     * reversePurchaseOrder Method to redirect to a custom visualforce page allowing the Purchaes Order to be Reversed
     * @return   PageReferece /apex/c__PurchaseOrderReverse?Id=
     */
    public PageReference reversePurchaseOrder()
    {
        return new PageReference('/apex/c__PurchaseOrderReverse?Id=' + po.Id);
    }   

    public String recordTypeName {
        get {
            //T-00983 Begin
            if(mapRecordType!=null && mapRecordType.get(po.RecordTypeId)!=null){
                return mapRecordType.get(po.RecordTypeId);
            }
            else{
                return'';
            }
        }
        set;
    }

    public Decimal LINEQTY { get; set; }
    public Decimal LINEAMT {get;set;}
    public String LINEDESC {get;set;}

    // Sublet Vars
    public String SUBLET_LINEDESC {get;set;}
    public String SUBLET_AMOUNT {get;set;}
    public String CHARGE_AMOUNT {get;set;}
    public String SUBLET_NOTES {get;set;}
    public String repair_order_id {get;set;}
    public String select_part_order_id {get;set;}
    public String job_line_id {get;set;}
    public dealer__Purchase_Order_Line__c SUBLET_JOBLINE = new dealer__Purchase_Order_Line__c();
    public dealer__Purchase_Order_Line__c LINEPO = new dealer__Purchase_Order_Line__c();
    public String vehicleStatusCode {get;set;}

    public String MISC_DESC {get;set;}
    public String MISC_AMT {get;set;}

    public dealer__PartTransfer__c transfer = new dealer__PartTransfer__c();

    public List<SelectOption> roLines {get;set;}    

    // Vehicle Purchase Order Lines
    public List<Purchase_Order_Line__c> purchaseOrderLines { get;set; }
    public String purchaseOrderLineMarkedForDeletion {get;set;} // public variable in form of rowindex:recordId, example: 0:a11111111111 
    
    public PurchaseOrder_EXT (ApexPages.standardController controller) {  

        // Settings
        Set<String> poSettingItems = new Set<String>{ 'PurchaseOrder_AllowLeaveOpen' };
		DMSConfig__mdt[] poSettings = [SELECT NamespacePrefix, Id, DeveloperName, Description__c, Enabled__c, Label 
                                     	FROM DMSConfig__mdt 
                                     	WHERE DeveloperName IN:poSettingItems ];
		allowLeaveOpen = true;
        for(DMSConfig__mdt m : poSettings) {
            if(m.DeveloperName == 'PurchaseOrder_AllowLeaveOpen') {
                allowLeaveOpen = m.Enabled__c;
            }
        }            

        // Instantiate needed variables
        por = new Purchase_Order_Receiving__c();

        mapRecordType = new Map<Id,String>();
        Id subletRTId;
        Id partPurchaseRTId;
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Purchase_Order__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        af.addAll(fieldnames);
        ccAddress='';
        listAttachment = new List<attachmentClass>();
        objAttachment = new Attachment();
        af.add('dealer__Vendor__r.Name');
        af.add('RecordType.DeveloperName');
        if(!Test.isRunningTest()) {
            controller.addFields(af);
        }
        po = (dealer__Purchase_Order__c)controller.getRecord();

        //T-00983 Begin
        //Get all purchase order recordtypes
        for(RecordType r:[select id,developername from RecordType where sObjecttype = 'dealer__Purchase_Order__c']){
            mapRecordType.put(r.id,r.developername);
            if(r.developername=='Sublet'){
                subletRTId = r.id;
            }
            if(r.developername=='Parts_Purchase'){
                partPurchaseRTId = r.id;
            }
        }
        //T-00983 End

        ops = dealer__FixedOperationsSettings__c.getOrgDefaults();
        if(ops.dealer__Purchase_Order_Post_FF__c!=null&&ops.dealer__Purchase_Order_Post_FF__c!='') {
            postingURL=ops.dealer__Purchase_Order_Post_FF__c;
        }
        if(ops.dealer__Purchase_Order_PDF__c==null) {
            ops.dealer__Purchase_Order_PDF__c = '/apex/dealer__PurchaseOrderPDF';
        }

        TOADDRESS=po.Vendor_Email__c;
        // Set User Location

        if(po.Company__c==null) {
            po.Company__c=Utility.lookupUserLocation();
        }

        if(ApexPages.currentPage().getParameters().get('ro')!=null) {
            repair_order_id = ApexPages.currentPage().getParameters().get('ro');
            po.dealer__Service_Repair_Order__c = [Select Id from dealer__Service_Repair_Order__c where Id=:repair_order_id limit 1].Id;
            //T-00983 Begin
            //Ommitted to avoid redundant query
            //RecordType r = [Select Id from RecordType Where DeveloperName = 'Sublet'];
            //po.RecordTypeId=r.Id;
            po.RecordTypeId=subletRTId;
            //T-00983 end

            if(ApexPages.currentPage().getParameters().get('job')!=null) {
                SUBLET_JOBLINE.Service_Job_Line__c=ApexPages.currentPage().getParameters().get('job');
                job_line_id=ApexPages.currentPage().getParameters().get('job');
            }
        }

        if(ApexPages.currentPage().getParameters().get('parts_order')!=null) {
            //T-00983 Begin
            //Ommitted to avoid redundant query
            //RecordType r = [Select Id from RecordType Where DeveloperName = 'Parts_Purchase'];
            //po.RecordTypeId=r.Id;
            po.RecordTypeId=partPurchaseRTId;
            //T-00983 end
        }

        // Set RO by PO Record
        if(po.dealer__Service_Repair_Order__c!=null) {
            repair_order_id=po.dealer__Service_Repair_Order__c;
        }

        roLines = new List<SelectOption>();
        roLines.add(new SelectOption('', ''));
        // grab the reepair order
        if(repair_order_id!=null) {
            ro = [SELECT Id FROM dealer__Service_Repair_Order__c WHERE Id =:repair_order_id limit 1];
            // Get the Job Lines as Picklist Values
            for(dealer__Service_Job__c j : [Select Id, Name, dealer__Line_Number__c from dealer__Service_Job__c where dealer__Service_Repair_Order__c =: ro.Id]) {
                roLines.add(new SelectOption(j.Id, j.dealer__Line_Number__c+' '+j.Name));
            }
        }

        PartsLines(); // Load the parts lines

        // Check to see if this PO is part of a transfer
        if(po.Id!=null) {
            purchaseOrderLines = PurchaseOrderAPI.purchaseOrderLines(po.Id);
            List<dealer__PartTransfer__c> tList = [Select Id, Name from dealer__PartTransfer__c where dealer__Purchase_Order__c =:po.Id limit 1];
            if(tList.size()==1) {
                transfer=tList[0];
            }
        }
        
        // if job is set specify the job line in the active items list
        if(ApexPages.currentPage().getParameters().get('job')!=null && job_line_id==null) {
            job_line_id=(Id)ApexPages.currentPage().getParameters().get('job');
        }    

        if(po.Id!=null) {
            purchaseOrderLines = PurchaseOrderAPI.purchaseOrderLines(po.Id);
        }

        System.debug(purchaseOrderLines);            
    }

    //W-000531 begin
    /**
     * Used to get all attachments related to the purchase order.
     * @returns null pagereference
     * @test PartOrderingUILayer.testPurchaseOrderEXT
     */
    public pagereference getAttachments(){
        listAttachment = new List<attachmentClass>();

        for(Attachment a: [select id,name,ContentType from Attachment where parentId=:po.id]){
            listAttachment.add(new AttachmentClass(a));
        }

        return null;
    }
    /**
     * Handles uploading attachments related to the purchase order.
     * @returns null pagereference
     * @test PartOrderingUILayer.testPurchaseOrderEXT
     */
    public PageReference upload() {
        System.debug('objAttachment - '+objAttachment);
        objAttachment.ParentId = po.id; // the record the file is attached to

        try {
          insert objAttachment;
          objAttachment.body=null;
          listAttachment.add(new AttachmentClass(true,objAttachment));

        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
          return null;
        } finally {
          objAttachment = new Attachment();
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
        return null;
    }
    //W-000531 end
    /**
     * 
     * @test PartOrderingUILayer.testVoid
     */
    public dealer__PartTransfer__c gettransfer() {
        return transfer;
    }
    /**
     * Get Vehicle Inventory Status Code Values
     * @returns List<SelectOption> of available vehicle status options from vehicle inventory status codes.
     * @test PartOrderingUILayer.testVoid
     */
    public List<SelectOption> getVehicleStatusOptions()    {
        List<SelectOption> options = new List<SelectOption>();

        if(po.Vehicle_Status__c==null || po.Vehicle_Status__c == '') {
            options.add(new SelectOption('None','--None--'));
        } else {
            options.add(new SelectOption(po.Vehicle_Status__c, po.Vehicle_Status__c));
        }

        Schema.DescribeFieldResult fieldResult = dealer__Vehicle_Inventory__c.dealer__Status_Code__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p : ple) {
            options.add(new SelectOption(p.getValue(), p.getValue()));
        }

        return options;
    }

    /**
     * PartsLines
     * @return void
     * @notes retrieves the parts lines and runs them through the pwrap class
     * @test PartOrderingUILayer.testVoid
     */
    public void PartsLines() {
        receiverLines = new List<PurchaseOrder.lineReceiver>();
        List<dealer__Purchase_Order_Line__c> poLines = [SELECT dealer__Purchase_Order__c, dealer__Amount__c, dealer__Account__c,
                                                        dealer__Description__c, dealer__Part__c, dealer__Part__r.Name, dealer__Part_Quantity__c,
                                                        dealer__Part_Quantity_Received__c, dealer__Special_Instructions__c, dealer__Item_Value__c,
                                                        dealer__Drop_Ship_Address__c, dealer__Parts_Invoice__c, dealer__Drop_Ship_To__c,
                                                        dealer__Service_Job_Line__c, Name, Id,dealer__Part_Quantity_Outstanding__c,
                                                        dealer__Parts_Master__r.Name, dealer__Parts_Master__r.dealer__Part_Description__c,
                                                        dealer__Parts_Master__r.dealer__Part_No__c, dealer__Purchase_Order__r.dealer__Company__c,
                                                        dealer__Pack_Part_Override__c, Parts_Line__c, Pack_Quantity__c
                                                            FROM dealer__Purchase_Order_Line__c
                                                            where dealer__Purchase_Order__c =:po.Id
                                                            and dealer__Part_Quantity_Outstanding__c != 0
                                                            limit 500];

        for(dealer__Purchase_Order_Line__c p : poLines) {
            if(p.dealer__Part_Quantity__c==null) { p.dealer__Part_Quantity__c =0; }
            if(p.dealer__Part_Quantity_Received__c == null) { p.dealer__Part_Quantity_Received__c = 0; }
            receiverLines.add(new PurchaseOrder.lineReceiver((p.dealer__Part_Quantity__c-p.dealer__Part_Quantity_Received__c), p));
        }
    }

    /**
     * getOrderLines
     * @return List<dealer__Parts_Order__c>
     * @notes Retrieves a list of parts order lines associated with this Purchase Order
     * @test PartOrderingUILayer.testSubletPO
     */
    public List<dealer__Parts_Order__c> getorderLines() {
        List<dealer__Parts_Order__c> pOrder = new List<dealer__Parts_Order__c>();
        if(repair_order_id!=null&&repair_order_id!='') {
        pOrder = [SELECT dealer__Parts_Invoice__c, dealer__Parts_Inventory__c, dealer__Order_Date__c, dealer__Quantity_Ordered__c, dealer__Order__c, dealer__Received__c, dealer__Depot__c, dealer__Back_Ordered__c, dealer__Requested_By__c, dealer__Purchase_Order__c, dealer__Scan_Time__c, dealer__Order_Status__c, dealer__Parts_Line__c, dealer__Value__c, dealer__Line_Posted__c, dealer__Parts_Master__c, Name, Id, dealer__Service_Job_Line__c, dealer__Service_Job_Line_Description__c,
                    dealer__Parts_Master__r.Name, dealer__Parts_Master__r.dealer__Part_Description__c, dealer__Parts_Master__r.dealer__Part_No__c, CreatedById
                FROM dealer__Parts_Order__c where dealer__Order__r.dealer__Service_Repair_Order__c =:repair_order_id and dealer__Purchase_Order__c=null limit 5000];
        }
        return pOrder;
    }

    /**
     * save Overload the save method
     * @return PageReference
     * @notes Custom save method specifically used to validate the Purchase Order at the time of Save.
     * @test PartOrderingUILayer.testSubletPO
     */
    public PageReference save() {

        // Status if Blank
        if(po.Status__c == null || po.Status__c =='') {
            po.Status__c = 'Open';
        }

        // Set the Parent Repair Order

        if(repair_order_id!=null&&repair_order_id!=''&&po.Id==null) {
            po.dealer__Service_Repair_Order__c = repair_order_id;
        }

        // Sublet Requires Service RO
        if(recordTypeName=='Sublet' && po.dealer__Service_Repair_Order__c==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Sublet Purchase Orders require the Service Repair Order to be inlcuded.'));
            return null;
        }

        //

        if(SUBLET_JOBLINE.Service_Job_Line__c!=null && recordTypeName=='Sublet') {
            dealer__Service_Job__c sj = [Select Id, dealer__Service_Repair_Order__c
                                                from dealer__Service_Job__c
                                                where Id=:SUBLET_JOBLINE.Service_Job_Line__c limit 1];
            po.dealer__Service_Repair_Order__c = sj.dealer__Service_Repair_Order__c;
        }

        // Set the Vehicle Status if populated on the temp object
        if(vehicleStatusCode!=null) {
            po.Vehicle_Status__c = vehicleStatusCode;
        }

        // Create the Vehicle if the Vehicle does not exist.
        if(po.dealer__Vehicle_Inventory__c == null && po.dealer__Year__c!=null && po.dealer__Make__c!=null && po.dealer__Model__c!=null && po.dealer__StockNumber__c!=null && po.dealer__VIN__c!=null) {

            // Check to see if the Control# exists
            List<dealer__Vehicle_Inventory__c> vList = [Select Id from dealer__Vehicle_Inventory__c where dealer__Stock_Number__c =:po.dealer__StockNumber__c limit 100];

            if(vList.size()>0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Vehicle Inventory exists with Stock# '+po.dealer__StockNumber__c));
                return null;
            }

            dealer__Vehicle_Inventory__c v = new dealer__Vehicle_Inventory__c();
                v.dealer__Year__c   =   po.dealer__Year__c;
                v.dealer__Make__c   =   po.dealer__Make__c;
                v.dealer__Model__c  =   po.dealer__Model__c;
                v.dealer__VIN__c    =   po.dealer__VIN__c;
                v.dealer__Stock_Number__c  =    po.dealer__StockNumber__c;

            try {
                insert v;
                po.dealer__Vehicle_Inventory__c=v.Id;
            } catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Unable to create vehicle inventory record for this purchase order '+e.getMessage()));
                return null;
            }
        }

        if(po.Id==null) {
            insert po;
        } else {
            update po;
        }

        PageReference p = Page.PurchaseOrder;
        if(SUBLET_JOBLINE.Service_Job_Line__c!=null) {
            p.getParameters().put('job', SUBLET_JOBLINE.Service_Job_Line__c);
            p.getParameters().put('id', po.Id);
            p.setRedirect(true);  
            return p;          
        }
        if(job_line_id != null) {
            p.getParameters().put('job', job_line_id);
            p.getParameters().put('id', po.Id);
            p.setRedirect(true);
            return p;
        }

        return (new ApexPages.StandardController (new Purchase_Order__c(Id=po.id))).view();

    }

    /**
     * voidPO
     * @return PageReference
     * @notes Void the purchase order to prevent adding content
     * @test PartOrderingUILayer.testVoidPO
     */
     
     /*Case# 00002129 Begin*/
    public PageReference voidPO() {        
        //list for PO Line Item under PO
        List<dealer__Purchase_Order_Line__c> poLines = new List<dealer__Purchase_Order_Line__c>();
        //Get PO Line Items if PO Id is not null
        if(po.Id != null){           
            poLines = [SELECT ID FROM dealer__Purchase_Order_Line__c where dealer__Purchase_Order__c =:po.Id];        
        }
        // Prevent Voiding Purchaes Orders if a dollar value exists.
        if(po.dealer__PO_Amount__c != null && po.dealer__PO_Amount__c > 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Unable to void purchase orders with an outstanding value.'));
            return null;
        }
        //Throw error message if PO having PO Line Item
        else if(poLines.size()>0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Unable to void Purchase Order having Purchase Order Line Item'));
            return null;        
        }
            
        if(po.Id!=null) {
            po.dealer__Status__c = 'Void';
            update po;
        }
        PageReference p = Page.PurchaseOrder;
        if(SUBLET_JOBLINE.Service_Job_Line__c!=null) {
            p.getParameters().put('job', SUBLET_JOBLINE.Service_Job_Line__c);
        }
        if(job_line_id != null) {
            p.getParameters().put('job', job_line_id);
        }
        //Create Note
        if(po.Id != null){
            Note objNote = new Note();
            objNote.ParentId = po.Id;
            objNote.Title = UserInfo.getName()+'  has voided this purchase order';
            insert objNote;
        }
        // p.getParameters().put('id', po.Id);
        // p.setRedirect(true);
        // return p;

        return (new ApexPages.StandardController (new Purchase_Order__c(Id=po.id))).view();        
    }
        
    /**
     * unvoicePO
     * @return PageReference
     * @notes added to support the changing of the status of the purchase order
     * @test PartOrderingUILayer.testUnvoidPO
     */
    public PageReference unvoidPO(){
        //Update Status and Create note
        if(po.Id!=null && po.Status__c == 'Void') {
            po.dealer__Status__c = 'Open';

            try {
                update po;
                Note objNote = new Note();
                objNote.ParentId = po.Id;
                objNote.Title = UserInfo.getName()+'  has un-voided this purchase order';
                insert objNote;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
            }

        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Only voided purchased orders may be un-voided'));
            return null;            
        }

        // PageReference p = Page.PurchaseOrder; 
        // p.getParameters().put('id', po.Id);
        // p.setRedirect(true);
        // return p;        
        return (new ApexPages.StandardController (new Purchase_Order__c(Id=po.id))).view();        
    } 

    /**
     * addSublet
     * @return PageReference
     * @notes adds sublet line to the purchase order
     * @test PartOrderingUILayer.testBlocks
     */
    public PageReference addSublet() {
        if(SUBLET_AMOUNT=='' || SUBLET_LINEDESC=='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Sublet Description, Sublet Amount are required.'));
            return null;
        }

        if(job_line_id == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Service Repair Job Line Required'));
            return null;
        }

        if(String.IsBLANK(CHARGE_AMOUNT)) {
            CHARGE_AMOUNT=String.valueOf(0);
        }

        // Look to see if the Decimal Values are Parsable.
        try {
            Decimal dd = Decimal.valueOf(SUBLET_AMOUNT);
            Decimal ca = Decimal.valueOf(CHARGE_AMOUNT);
        } Catch(Exception e) {
            throw new PurchaseOrderException('Error parsing sublet or charge amount into a decimal.  Please use only numbers and decimals.');
        }

        // If Sublet Or Charge == null set to Zero
        if(CHARGE_AMOUNT==null || CHARGE_AMOUNT=='') { CHARGE_AMOUNT='0'; }
        if(SUBLET_AMOUNT==null || SUBLET_AMOUNT=='') { SUBLET_AMOUNT='0'; }
        if(SUBLET_AMOUNT!='0'&&CHARGE_AMOUNT=='0') {
            CHARGE_AMOUNT=SUBLET_AMOUNT;
        }

        dealer__Purchase_Order_Line__c line = new dealer__Purchase_Order_Line__c(
            dealer__Amount__c=Decimal.valueOf(SUBLET_AMOUNT),
            dealer__Customer_Total__c=Decimal.valueOf(CHARGE_AMOUNT),
            dealer__Description__c=SUBLET_LINEDESC,
            dealer__Purchase_Order__c=po.Id,
            dealer__Special_Instructions__c=SUBLET_NOTES,
            dealer__Service_Job_Line__c=job_line_id
        );

        try {
            insert line;
        } catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        PageReference popage = Page.PurchaseOrder;
        popage.getParameters().put('id', po.Id);
        popage.setRedirect(true);
        return popage;
    }

    /**
     * closePurchaseOrder
     * @return PageReference
     * @notes returns the Purchase Order Receive Page
     * @test PartOrderingUILayer.testSubletPO
     */
    public PageReference closePurchaseOrder() {
        if(!PurchaseOrderAPI.isOpen(po.Id)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Purchase Order must be OPEN before RECEIVING'));
            return null;           
        }
        return Page.PurchaseOrderReceive;
    }

    /**
     * acceptPO
     * @return pageReference
     * @notes method performs the users in store accept function.  This records who accepted the purchase order.  Only the Misc, Sublet and Vehicle PO Types are processed via this method.  Parts Purchase Orders are handled in a separete method.
     * @test PartOrderingUILayer.testSubletPO
     */
    public PageReference acceptPO() {

        try {
            PurchaseOrderAPI.receiveAccept = true;
            PurchaseOrderAPI.receive(po, receiverLines, por);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error receiving purchase order '+e.getMessage()));
            return null;
        }

        PageReference p = Page.PurchaseOrder;
        p.setRedirect(true);
        p.getParameters().put('id', po.Id);
        return p;        
    }

    public PageReference postPO() {
        if(postingURL==null || postingURL=='') {

            postingURL = '/apex/dealer__PurchaseOrder';
            
            po.Status__c='Posted';
            po.Post_Date_Time__c=Datetime.now();            
            
            try {
                update po;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                return null;
            } Catch(Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                return null;
            }            
        }

        PageReference p = new PageReference(postingURL);
        p.setRedirect(true);
        p.getParameters().put('id', po.Id);
        return p;
    }

    public PageReference returnToRepairOrder() {
        if(po.dealer__Service_Repair_Order__c==null) {
            return null;
        }

        dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c
                                                    where Id=:po.dealer__Service_Repair_Order__c limit 1];
        return new ApexPages.standardcontroller(ro).view();
    }

    /**
     * receiveParts
     * @return PageReference
     * @notes  Method to receive parts on an open purchaes order
     *         Update the Inventory History
     *         Increase the QOH - Physical
     *         Update FIFO/LIFO Table
     *         Hook to external Accounting Systems
     * @test PartOrderingUILayer.testSubletPO
     */
    public PageReference receiveParts() {

        // Get Custom Setting for Purchase Order Events (Fixed Ops Hierarchy Setting)
        FixedOperationsSettings__c fops = FixedOperationsSettings__c.getOrgDefaults();

        PurchaseOrderAPI.receiveAccept = receiveAccept;
        try {
            PurchaseOrderAPI.receive(po, receiverLines, por);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return null;            
        }

        String pageName = 'PurchaseOrder';
        if(fops!=null && fops.dealer__PartsReceiptPage__c!=null && fops.dealer__PartsReceiptPage__c!='') { pageName = fops.dealer__PartsReceiptPage__c; }

        System.debug('Returning the Purchase Page defined in the Custom Settings');

        PageReference p = new PageReference(pageName);
        p.getParameters().put('id', po.Id);
        p.setRedirect(true);
        return p;
    }

    //
    // Lookup Existing vehicle
    //
    /**
     *  Find vehicle inventory by stock or VIN and set that to po
     * @returns null PageReference
     * @test PartOrderingUILayer.testBlocks
     */
    public PageReference findExisting() {
        // Search by Stock or VIN
        List<dealer__Vehicle_Inventory__c> matched_vehicles = [SELECT Id, dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Stock_Number__c FROM dealer__Vehicle_Inventory__c where dealer__Stock_Number__c =:po.dealer__StockNumber__c limit 1];

        if(matched_vehicles.size()>0) {
            po.Year__c = matched_vehicles[0].dealer__Year__c;
            po.Make__c = matched_vehicles[0].dealer__Make__c;
            po.Model__c = matched_vehicles[0].dealer__Model__c;
            po.StockNumber__c = matched_vehicles[0].dealer__Stock_Number__c;
            po.VIN__c = matched_vehicles[0].dealer__VIN__c;
            po.Vehicle_Inventory__c = matched_vehicles[0].Id;
        }

        return null;
    }

    /**
     *  Find year,make,model from purchase order VIN and set to PO.
     * @returns null PageReference
     * @test PartOrderingUILayer.testVehiclePurchase
     */
    public PageReference decodeVIN() {

        VINDecoder vd = new VINDecoder();

        vd.DecodeVIN(po.VIN__c);

        VINDecoderDataObject.DecodeData ddat = vd.decodeData;
        po.Year__c = ddat.common_data.year;
        po.Make__c = ddat.common_data.make;
        po.Model__c= ddat.common_data.model;

        return null;
    }

    public PageReference addPOLine() {
        purchaseOrderLines.add(new Purchase_Order_Line__c(Purchase_Order__c=po.Id, Quantity__c=1));
        return null;
    }

    public Pagereference savePOLines() {
        try {
            upsert purchaseOrderLines;
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return null;
        }

        return null;        
    } 

    public PageReference deletePOLine() {

        /*
        This method is using an abnormal string passed to the controller via apex:commandLink 
        The reaeson for this logic is to ensure that items in memory and not yet containing an ID are 
        able to be removed prior the their DML operation
        */

        // Obtain the parts of purchaseOrderLineMarkedForDeletion
        String[] rowDetail = purchaseOrderLineMarkedForDeletion.split(':');
        System.assert(rowDetail.size()!=0, 'purchaseOrderLineMarkedForDeletion must have at least one item');
        System.assert(rowDetail.size()<=2, 'purchaseOrderLineMarkedForDeletion may not have more than two items');
        
        // If rowDetail size == 1, we have a record not yet in the database perform removal
        purchaseOrderLines.remove(Integer.valueOf(rowDetail[0]));

        if(rowDetail.size()==1) {
            return null;
        }

        try {
            
            delete new dealer__Purchase_Order_Line__c(Id=rowDetail[1]);

        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return null;            
        }
        return null; 
    }   

    /**
     *  Returns purchaseOrderEmail.page from PO 
     * @returns PageReference page.PurchaseOrderEmail
     * @test PartOrderingUILayer.testPurchaseOrderEXT
     */
    // <name>emailButton</email>
    // <summary>Send vendor PO by email</summary>
    public PageReference emailPO() {
        getAttachments();
        PageReference eb = Page.PurchaseOrderEmail;
        if(po != null) {
            eb.getParameters().put('id', po.Id);
        }
        return eb;
    }

    /**
     * Sends email with PDF attached and generates completed task to log activity.
     * @returns null PageReference if there are errors, otherwise returns purchase order page.
     * @test PartOrderingUILayer.testPurchaseOrderEXT
     */
    //  <name>sendPdf</name>
    //  <summary>send client quote as pdf email attachment</summary>
    public PageReference sendPdf() {

        /*
            Ray Morton - CPT Feature Request

            Have ability to selected related attachments or add new attachment to the email.
        */

        if(TOADDRESS!=null){
            TOADDRESS = TOADDRESS.trim();
        }

        if(TOADDRESS==null || TOADDRESS=='' || !PatternMatcher.validate_Email(TOADDRESS)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid email address'));
            return null;
        }

        Messaging.EmailFileAttachment attach = AttachPDF();

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] { TOADDRESS });
        mail.setSubject(this.subject);
        mail.setHtmlBody(this.body);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });

        if(ccAddress!=null){
            ccAddress = ccAddress.trim();
        }

        if(ccAddress!=null && ccAddress!='' && !PatternMatcher.validate_Email(ccAddress)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Enter a valid cc email address'));
            return null;
        }
        else if(ccAddress!=null && ccAddress!='' && PatternMatcher.validate_Email(ccAddress)){
            mail.setCCAddresses(new String[] { ccAddress });
        }

        //W-000531 begin
        List<Messaging.EmailFileAttachment> listEmailAtt = new List<Messaging.EmailFileAttachment>();
        listEmailAtt.add(attach);

        Set<Id> setAttachId = new Set<Id>();

        for(AttachmentClass a: listAttachment){
            if(a.selected){
                setAttachId.add(a.objAttachment.id);
            }
        }

        Decimal attachmentSize=0;
        for(Attachment a:[select id,name,contentType,body,BodyLength from Attachment where id in :setAttachId]){
            Messaging.EmailFileAttachment mattach = new Messaging.EmailFileAttachment();
            mattach.setContentType(a.ContentType);
            mattach.setFileName(a.Name);
            mattach.setInline(false);
            mattach.Body = a.body;
            listEmailAtt.add(mattach);
            attachmentSize+=a.BodyLength;
        }

        System.debug('attachmentSize - '+attachmentSize);
        if(attachmentSize>26214400){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Attachments must be less then 25MB'));
            return null;
        }

        mail.setFileAttachments(listEmailAtt);
        //W-000531 end

        // Send the email
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception e){
            return null;
        }


        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Purchase Order was sent to '+TOADDRESS));

        // Record Activity
        Task t = new Task( Subject='Emailed Purchase Order to '+TOADDRESS ,
                           ActivityDate=Date.today(),
                           WhatId=po.Id,
                           Status='Completed');
        insert t;

        PageReference sq = Page.PurchaseOrder;
        sq.getParameters().put('id', string.valueOf(po.Id));
        return sq;

    }

    public dealer__Purchase_Order_Line__c getLINEPO() {
        return LINEPO;
    }

    public dealer__Purchase_Order_Line__c getSUBLET_JOBLINE() {
        return SUBLET_JOBLINE;
    }

    // <name>New Line Item</name>
    // <summary>redirect user to add a new line item to their po object</summary>
    public PageReference newPartLine() {
        if(LINEPO.dealer__Parts_Master__c==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A part must be selected in order to add to this purchase order.'));
            return null;
        }

        // Check to see if the Repair Order is Linked require a Job Line
        if(po.dealer__Service_Repair_Order__c!=null && job_line_id==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'When adding Parts to a Purchase Order for a Repair Order a Service Job Line must be selected.'));
            return null;
        }

        // Get Location Data
        dealer__Dealer_Location__c loc = [Select Id, Name, dealer__Company_Number__c from dealer__Dealer_Location__c where Id=:po.dealer__Company__c limit 1];

        // Get pricing details from part
        dealer__Parts_Master__c partData = [Select Id, Name, dealer__Part_Description__c, dealer__Part_No__c, dealer__Cost__c, dealer__Retail_Price__c, dealer__Part_No_Display__c,
                                                dealer__Weight__c, dealer__Warranty_Price__c, dealer__Manufacturer__c,
                                                dealer__Jobber_Price__c, dealer__Pack_QTY__c, dealer__Core_Value__c, dealer__Core_Required__c
                                                from dealer__Parts_Master__c
                                                    where Id = :LINEPO.dealer__Parts_Master__c
                                                    limit 1];

        Decimal packQuantity = (partData.dealer__Pack_QTY__c!=null) ? partData.dealer__Pack_QTY__c : 1;

        if(LINEQTY == 0) {  LINEQTY = 1;    }
        if(partData.dealer__Cost__c == null) { partData.dealer__Cost__c = 0; }
        if(LINEAMT==null) {
            LINEPO.dealer__Amount__c = ((partData.dealer__Cost__c * packQuantity) * LINEQTY);
        } else {
            LINEPO.dealer__Amount__c = LINEAMT;
        }

        LINEPO.dealer__Purchase_Order__c = po.Id;
        LINEPO.dealer__Part_Quantity__c = LINEQTY;
        LINEPO.dealer__Parts_Master__c = partData.Id;
        LINEPO.dealer__Description__c = partData.dealer__Part_No__c+' '+partData.dealer__Part_Description__c;
        LINEPO.dealer__Special_Instructions__c = SUBLET_LINEDESC;

        // Make note of a Pack Quantity if this part is designated as such.
        if(partData.dealer__Pack_QTY__c!=null&&partData.dealer__Pack_QTY__c>1) {
            LINEPO.dealer__Amount__c = (partData.dealer__Cost__c * partData.dealer__Pack_QTY__c) * LINEQTY;
            LINEPO.dealer__Special_Instructions__c = LINEPO.dealer__Special_Instructions__c + ' Part Indicated to have a Pack QTY of '+partData.dealer__Pack_QTY__c;
        }

        // Check for a Job Line Assignment
        if(job_line_id!=null) {
            LINEPO.Service_Job_Line__c = job_line_id; 
        }



        // If the Part was not in the stores inventory, add to inventory
        dealer__Parts_Inventory__c[] invLookup = [SELECT Id FROM dealer__Parts_Inventory__c
                                                    Where dealer__Parts_Master__c =:partData.Id
                                                    and dealer__Location__c =:po.dealer__Company__c
                                                    Limit 1];

        if(invLookup.size()==0) {
            // Create the Parts Inventory
            dealer__Parts_Inventory__c p = new dealer__Parts_Inventory__c();
            p.Name = partData.Name;
            p.dealer__Part_No__c  = loc.dealer__Company_Number__c+':'+partData.Name;
            p.dealer__Description__c = partData.dealer__Part_Description__c;
            p.dealer__MFG__c = partData.dealer__Manufacturer__c;
            p.dealer__Cost__c= partData.dealer__Cost__c;
            p.dealer__List__c= partData.dealer__Retail_Price__c;
            p.dealer__Pack_QTY__c = partData.dealer__Pack_QTY__c;
            p.dealer__Company_Number__c = loc.dealer__Company_Number__c;
            p.dealer__Location__c = loc.Id;

            insert p;
            LINEPO.dealer__Part__c = p.Id;
        } else {
            LINEPO.dealer__Part__c = invLookup[0].Id;
        }

        try {
            insert LINEPO;
        } Catch(DMLException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;            
        }

        // If we are issuing this against a parts invoice line, update the cost on the parts invoice line to match.
        // LINEPO.Parts_Line__c
        if(LINEPO.Parts_Line__c!=null) {
            Parts_Invoice_Line__c invLineUpdate = new Parts_Invoice_Line__c(Id=LINEPO.Parts_Line__c, Cost__c=LINEPO.Amount__c);
            try {
                update invLineUpdate;
            } Catch(DMLException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;  
            }
        }
        

        PageReference uPo = Page.PurchaseOrder;
        uPo.setRedirect(true);
        uPo.getParameters().put('Id', po.Id);
        return uPo;
    }

    /**
    *   selectExistingPartLine - Adds a part to a purchase order from the pre-populated Parts Order Lines as a result of selling the part negative
    * 
    * @test PartOrderingUILayer.testBlocks
    */
    public PageReference selectExistingPartLine() {

        if(select_part_order_id==null||select_part_order_id=='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An existing part on order must be selected in order to add to this purchase order.'));
            return null;
        }

        SavePoint sp = Database.setSavePoint();

        // Get Selected Order Line
        dealer__Parts_Order__c oLine = [SELECT dealer__Parts_Invoice__c, dealer__Parts_Inventory__c, dealer__Order_Date__c, dealer__Quantity_Ordered__c, dealer__Order__c, dealer__Received__c, dealer__Depot__c, dealer__Back_Ordered__c, dealer__Requested_By__c, dealer__Purchase_Order__c, dealer__Scan_Time__c, dealer__Order_Status__c, dealer__Parts_Line__c, dealer__Value__c, dealer__Line_Posted__c, dealer__Parts_Master__c, Name, Id, dealer__Service_Job_Line__c,
                    dealer__Parts_Master__r.Name, dealer__Parts_Master__r.dealer__Part_Description__c, dealer__Parts_Master__r.dealer__Part_No__c, dealer__Parts_Master__r.dealer__Cost__c, CreatedById
                FROM dealer__Parts_Order__c where Id=:select_part_order_id limit 1 for update];

        dealer__Purchase_Order_Line__c poLine = new dealer__Purchase_Order_Line__c(
                                                        dealer__Amount__c=(oLine.dealer__Parts_Master__r.dealer__Cost__c*oLine.dealer__Quantity_Ordered__c),
                                                        dealer__Purchase_Order__c=po.Id,
                                                        dealer__Part_Quantity__c=oLine.dealer__Quantity_Ordered__c,
                                                        dealer__Description__c=oLine.Parts_Master__r.dealer__Part_No__c+' '+oLine.dealer__Parts_Master__r.dealer__Part_Description__c,
                                                        dealer__Parts_Master__c=oLine.dealer__Parts_Master__c,
                                                        dealer__Part__c=oLine.dealer__Parts_Inventory__c,
                                                        dealer__Parts_Line__c=oLine.dealer__Parts_Line__c
                                                    );
        if(job_line_id!=null) {
            poLine.dealer__Service_Job_Line__c = job_line_id;
        }

        // Lookup Job Line based on the Parts Line the Part was sold on
        if(oLine.dealer__Service_Job_Line__c!=null) {
            poLine.dealer__Service_Job_Line__c = oLine.dealer__Service_Job_Line__c;
        }

        oLine.dealer__Purchase_Order__c = po.Id;

        /* Moved to the domain level, PurchaseOrderLineControl.trigger
        dealer__Parts_Inventory__c inv = [select Id, Name, dealer__On_Order__c from dealer__Parts_Inventory__c where Id=:oLine.dealer__Parts_Inventory__c limit 1 for update];
        inv.dealer__On_Order__c+=oLine.dealer__Quantity_Ordered__c;
        */

        try {

            insert poLine;
            update oLine;
            // update inv;

        } Catch(DmlException e) {

            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;

        } Catch(Exception e) {
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        PageReference uPo = Page.PurchaseOrder;
        uPo.setRedirect(true);
        uPo.getParameters().put('Id', po.Id);
        return uPo;
    }

    // <name>AttachPDF</name>
    // <summary></summary>
    /**
     * Handles finding and returning PDF for the PO
     * @returns Messaging.EmailFileAttachment purchase order pdf
     * @test PartOrderingUILayer.testBlocks
     */
    public Messaging.EmailFileAttachment AttachPDF() {
        PageReference pdf;
        //W-000531 begin
        if(ops.dealer__Purchase_Order_PDF__c!=null){
            pdf=new Pagereference(ops.dealer__Purchase_Order_PDF__c);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No PDF added to custom setting'));
        }

        //PageReference pdf = Page.PurchaseOrderPDF;

        //W-000531 end
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id', string.valueOf(po.Id));

        // the contents of the attachment from the pdf
        Blob body;

        try {
          // returns the output of the page as a PDF
          body = pdf.getContent();

        } catch (VisualforceException e) {
          body = Blob.valueOf('Error Generating Attachment');
        }

        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName(po.Name+'-PurchaseOrder.pdf');
        attach.setInline(false);
        attach.Body = body;

        return attach;
    }

    /**
     * Inserts PartsMaster from passed json string
     * @param string JSON with part_master details to save
     * @returns string with the name of parts master record inserted
     * @test PartOrderingUILayer.savePartMaster
     */
    @remoteAction
    public static string SavePartMaster(string jsonString) {
        
        PartsMaster = (dealer__Parts_Master__c)JSON.deserialize(jsonString, dealer__Parts_Master__c.class);

        if(PartsMaster.dealer__Manufacturer__c==null) {
                return null;
        }
        
        PartsMaster.dealer__Raw_Part_Number__c = String.valueOf(PartsMaster.Name).replace('-', '');
        PartsMaster.dealer__Part_No__c = PartsMaster.dealer__Manufacturer__c+':'+PartsMaster.Name;
        PartsMaster.dealer__Price_Tape_Date__c=Date.today();
        insert PartsMaster;
        
        return PartsMaster.Name;
    }

    
    public class PurchaseOrderException extends Exception {}

    /**
     * Classes used for methods involving the PO attachment 
     * @test PartOrderingUILayer.testBlocks
     */
    public class AttachmentClass{
        public boolean selected{get;set;}
        public Attachment objAttachment{get;set;}

        public attachmentClass(Attachment a){
            selected = false;
            objAttachment=a;
        }

        public attachmentClass(boolean sel,Attachment a){
            selected = sel;
            objAttachment=a;
        }
    }
}