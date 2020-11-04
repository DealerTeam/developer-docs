public without sharing class ServiceROTransports {

  public String trans {get;set;} // What data is the transport expected to return
  public String roId  {get;set;}
  public String jobLineId {get;set;}
  public String ttId {get;set;}
  public String updateResult {get;set;} 
  public String miscResult {get;set;}
  public String lookupPartResult {get;set;}
  public String masterId {get;set;} // Parts Master Id
  public String locationId {get;set;} // Location Id
  public String search {get;set;}
  public String partLine;
  public dealer__Dealer_Location__c location {get;set;}
  public Id repairOrderId;
  public String error_string;
  public Map<String, String> urlParameters = new Map<String, String>();

  public ServiceROTransports() {

    urlParameters = ApexPages.currentPage().getParameters();
    error_string  = null;
    trans = '';
    roId  = '';

    // Putting this first in the logic so it is overwritten later if necessary, but I want to stop declaring every possible action
    if(urlParameters.get('action') == 'PicklistValues') {
      trans = 'PicklistValues';
    }

    if(ApexPages.currentPage().getParameters().get('action')== 'operations') {
      trans='operations';
    }

    if(ApexPages.currentPage().getParameters().get('action')== 'payment_methods') {
      trans='payment_methods';
    }  

    if(ApexPages.currentPage().getParameters().get('action')== 'techs' && ApexPages.currentPage().getParameters().get('rid')!=null) {
      roId =ApexPages.currentPage().getParameters().get('rid');
      trans='techs';
    }

    if(ApexPages.currentPage().getParameters().get('action')== 'misc_types') {
      trans='misc_types';
    }

    if(ApexPages.currentPage().getParameters().get('action')== 'stat') {
      trans='stat';
    }    
    
    if(ApexPages.currentPage().getParameters().get('action')== 'statClaim') {
      trans='statClaim';
    }   

    // Get Service Job Lines 
    if(ApexPages.currentPage().getParameters().get('action')== 'rolines' && ApexPages.currentPage().getParameters().get('id')!=null) {
      trans='rolines';
      roId =ApexPages.currentPage().getParameters().get('id');
    }  

    // Get second-level items
    if(urlParameters.get('action')=='read_tech_time') {
      trans='read_tech_time';
    }

    // Update / Create
    if(urlParameters.containsKey('attributes[type]')) {
      trans='line_update';
    }

    if(urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='create') {
      trans='create';
    }

    // Read Parts Rows
    if(urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='read_parts') {
      if(String.valueOf(urlParameters.get('lid'))!='') {
        jobLineId=String.valueOf(urlParameters.get('lid'));
      }
      trans='read_parts';
    }

    // Read Parts Rows
    if(urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='read_misc') {

        trans='read_misc';
    }    

    // Searh Parts Rows
    if(String.valueOf(urlParameters.get('action'))=='search_parts') {
      search=String.valueOf(urlParameters.get('filter[filters][0][value]'));
      trans='search_parts';
    }

    if(String.valueOf(urlParameters.get('action'))=='global_inventory') {
      masterId = String.valueOf(urlParameters.get('mid'));
      trans='global_inventory';
    }

    /** Retreive A User List */
    if ( ApexPages.currentPage().getParameters().get('action')=='read_users') {
      trans='read_users';
      getUserList();
    }

  }

  public PageReference saveAction() {

    /*
    if((urlParameters.containsKey('attributes[type]') 
        &&  String.valueOf(urlParameters.containsKey('attributes[type]')) == 'dealer__Service_Job__c')
            || (urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='create')) {
    */
    if(urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='create') {
      updateResult = updateLine();
    }

    if(urlParameters.containsKey('action')&&String.valueOf(urlParameters.get('action'))=='update') {
      updateResult = updateLine();
    }    

    if(urlParameters.containsKey('action') && String.valueOf(urlParameters.get('action')) == 'delete_line') {
      dealer__Service_Job__c j = [Select Id from dealer__Service_Job__c where Id=:urlParameters.get('Id') limit 1];
      try {
        delete j;
      } catch(DmlException e) {
        throw new ROException('Failed to remove job line : '+e.getMessage()); 
      }

      trans       =   'delete_line';
      updateResult   =   getRoLines();
    }

    // Read Part Inventory (Moved to SaveAction in event a part must be added (DML not allowed in constructor))
    if(urlParameters.containsKey('action') && String.valueOf(urlParameters.get('action'))=='part') {
      masterId = String.valueOf(urlParameters.get('mid'));
      locationId = String.valueOf(urlParameters.get('lid'));
      roId = String.valueOf(urlParameters.get('roId'));

      trans='part';
      Parts_Service_Pricing_Strategy__c pricingStrat;
      
      if(roId != null){
        Service_Repair_Order__c sro = [SELECT Id, Customer__c, Customer__r.Pricing_Strategy__c, Customer__r.Pricing_Strategy__r.Parts_Variable_Amount__c, Customer__r.Pricing_Strategy__r.Method__c, Customer__r.Pricing_Strategy__r.Formula_Operand__c FROM Service_Repair_Order__c WHERE Id =: roId];
        if(sro.Customer__c != null && sro.Customer__r.Pricing_Strategy__c != null){
          pricingStrat = new Parts_Service_Pricing_Strategy__c(
            Id = sro.Customer__r.Pricing_Strategy__c,
            Parts_Variable_Amount__c = sro.Customer__r.Pricing_Strategy__r.Parts_Variable_Amount__c,
            Method__c = sro.Customer__r.Pricing_Strategy__r.Method__c,
            Formula_Operand__c = sro.Customer__r.Pricing_Strategy__r.Formula_Operand__c
          );
        }
        else{
          List<Parts_Service_Pricing_Strategy__c> strats = [SELECT Id, Parts_Variable_Amount__c, Method__c, Formula_Operand__c FROM Parts_Service_Pricing_Strategy__c WHERE Default__c = True LIMIT 1];
          if(strats.size() > 0){
            pricingStrat = new Parts_Service_Pricing_Strategy__c(
              Id = strats[0].Id,
              Parts_Variable_Amount__c = strats[0].Parts_Variable_Amount__c,
              Method__c = strats[0].Method__c,
              Formula_Operand__c = strats[0].Formula_Operand__c
            );
          }
          
        }

      }

      lookupPartResult = lookupPart(pricingStrat);
    }  

    // Create Tech Time
    if(urlParameters.containsKey('action') && String.valueOf(urlParameters.get('action'))=='create_tech_time') {
      trans= 'create_tech_time';
      ttId = createTechTime();
      updateResult = ttId;
    }
    if(urlParameters.containsKey('action') && String.valueOf(urlParameters.get('action'))=='update_tech_time') {
      trans= 'update_tech_time';
      ttId = updateTechTime();
    }
    if(urlParameters.containsKey('action') && String.valueOf(urlParameters.get('action'))=='delete_tech_time') {
      deletTechTime();
    }  

    // Create Parts Line  
    if(String.valueOf(urlParameters.get('action'))=='create_parts_line') {
      masterId = String.valueOf(urlParameters.get('mid'));
      trans='create_parts_line';
      partLine = createPartLine();
      updateResult = partLine;
    }

    // Delete Parts Line
    if(String.valueOf(urlParameters.get('action'))=='delete_parts_Line') {
      trans = 'delete_parts_Line';
      try {
          
        Parts_Invoice_Line__c line = [SELECT dealer__Quantity_Sold__c, dealer__Price__c,  dealer__Job_Line__c, dealer__Job_Line__r.dealer__Parts_Total__c 
                                   FROM Parts_Invoice_Line__c WHERE Id=: String.valueOf(urlParameters.get('Id')) LIMIT 1];
       
    	Decimal total = line.dealer__Job_Line__r.dealer__Parts_Total__c;
    	Decimal oldPartLine =   line.dealer__Quantity_Sold__c * line.dealer__Price__c;  

        updatePartsMiscCharges(line, total, oldPartLine, true);
  
        PartInvoiceAPI.removeInvoiceLine(urlParameters.get('Id'));
      } Catch(Exception e) {
        throw new ROException(e.getMessage());
      }
    }

    // Update Parts Line
    if(String.valueOf(urlParameters.get('action'))=='update_parts_Line') {
      trans='update_parts_Line';
      partLine=String.valueOf(urlParameters.get('Id'));
      updateResult = updatePartLine();
    }

    // Create / Update MISC
    if(String.valueOf(urlParameters.get('action'))=='create_misc') {
      trans = 'create_misc';
      miscResult = createMisc();

    }  
    if(String.valueOf(urlParameters.get('action'))=='update_misc') {
      trans = 'update_misc';
      miscResult = updateMisc();
    }  
    if(String.valueOf(urlParameters.get('action'))=='delete_misc') {
      trans = 'delete_misc';
      miscResult = deleteMisc();
    }


    return null;
  }

  public String createPartLine() {

      SavePoint sp = Database.setSavePoint();
      
      // Check for bad data input
      if(Decimal.valueOf(String.valueOf(urlParameters.get('QTY'))) < 0) {
        error_string = '{ "error" : "Part QTY may not be negative" }';  
        return null;
      }
      // Get RO Data from RID
      Service_Job__c job = [SELECT Id, Name,Service_Repair_Order__c, Line_Number__c, Labor_Type__c, Parts_Total__c, 
      								Standard_Operation_Code__r.Part_Markup_Internal__c, Standard_Operation_Code__r.Part_Markup_Warranty__c
                      				FROM Service_Job__c
                      				WHERE Id=:urlParameters.get('rid') limit 1];

      Service_Repair_Order__c ro = [SELECT Id, Name, Parts_Invoice__c, RO_Number__c, Company__c, Company_Number__c, Customer__c, Customer__r.Pricing_Strategy__c
                                              FROM Service_Repair_Order__c
                                              WHERE Id=:job.Service_Repair_Order__c
                                              LIMIT 1];

      String pricingStrategyId = '';
      if(ro.Customer__c != null && ro.Customer__r.Pricing_Strategy__c != null){
        pricingStrategyId = ro.Customer__r.Pricing_Strategy__c;
      }
      else{
        List<Parts_Service_Pricing_Strategy__c> defaultStrat = [SELECT Id FROM dealer__Parts_Service_Pricing_Strategy__c WHERE Default__c = true];
        if(defaultStrat.size() == 0){
                throw new ROException('Unable to set parts line pricing strategy. Customer account must have a pricing strategy or set a pricing strategy as default.');
        }
        pricingStrategyId = defaultStrat[0].Id;
      }
      
      dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
      if(ro.dealer__Parts_Invoice__c==null){
        pi.Location__c = ro.Company__c;
        // pi.Name = 'INV#'+ro.dealer__RO_Number__c;
        pi.dealer__Invoice_Number__c = 'RO'+ro.RO_Number__c;
        pi.dealer__Service_Repair_Order__c = ro.Id;
        pi.Wholesale_Pricing_Strategy__c = pricingStrategyId;

        try {
          
          pi = PartInvoiceAPI.createInvoice(pi);
          ro.dealer__Parts_Invoice__c = pi.Id;
          update ro;

        } Catch(Exception e) {
          Database.rollback(sp);
          return '{ "error" : "'+e.getMessage()+'" }';        
        }



      }
      
      pi = [Select Id,Name, Line_Count__c,Service_Repair_Order__c from dealer__Parts_Invoice__c where Id=:ro.dealer__Parts_Invoice__c limit 1];
      
      //  Get the Selected Part
        //  Get the Selected Part
      Parts_Inventory__c inv = new Parts_Inventory__c();
      Parts_Inventory__c[] invlist = [SELECT Id, Name, Source__c, Description__c, List__c, Part_no__c, 
                                        Parts_Master__c,On_Hand__c,Bin__c,Core__c,On_Order__c, Cost__c,
                                        Parts_Master__r.Pack_QTY__c
                                        FROM Parts_Inventory__c 
                                        WHERE Id=:String.valueOf(urlParameters.get('PartInventoryId')) 
                                        LIMIT 1];  
      if(invlist.size()==0) {
        return '{ "error" : "Attempting to sell a part that has not been recorded in this stores local inventory." }'; 
      } else {
        inv = invlist[0];
      }   

      // Incriment Line Count
      Decimal lineNumber = 0;
      if(pi.Line_Count__c==null || pi.Line_Count__c ==0) {
        lineNumber = 1;
      } else {
        lineNumber = pi.Line_Count__c + 1;
      }
      
      Decimal line_qty = Decimal.valueOf(String.valueOf(urlParameters.get('QTY')));
      Decimal order_qty = (line_qty > inv.On_Hand__c) ? line_qty - inv.On_Hand__c : 0;
      
      Parts_Invoice_Line__c line = new Parts_Invoice_Line__c();
      List<Parts_Invoice_Line__c> lines = new List<Parts_Invoice_Line__c>();
      lines.add(new Parts_Invoice_Line__c(
          Parts_Invoice__c = pi.Id,
          Name     = pi.Name+'-'+String.valueOf(lineNumber),
          Part__c  = inv.Id,
          List__c  = inv.List__c,
          Price__c = Decimal.valueOf(String.valueOf(urlParameters.get('SalePrice'))),
          Core__c  = (inv.Core__c!=null)?inv.Core__c:0,
          Cost__c  = null, //ledger entry
          Bin__c   = inv.Bin__c,
          Counterman__c   = UserInfo.getUserId(),
          Sale_Date__c    = System.now(),
          Part_number__c  = inv.Part_no__c,
          Part_Description__c = inv.Description__c,
          Quantity_Sold__c    = Decimal.valueOf(String.valueOf(urlParameters.get('QTY'))),
          Source__c   = inv.Source__c,
          Sold_Via__c = 'Invoice Line',
          Job_Line__c = job.Id,
          Service_Repair_Order__c = (ro.Id != null)?ro.Id: pi.Service_Repair_Order__c,
          Price_Level_Strategy__c = pricingStrategyId
                  //  Service_Repair_Order__c = pi.Service_Repair_Order__c
          // Quantity_ordered__c     = order_qty//move to service layer
      ));
      try {
        line = PartInvoiceAPI.addInvoiceLines(lines)[0];
      } catch(DmlException e) {
        return '{ "error" : "'+e.getMessage()+'" }';
      }
      
  	  createMiscChargeLines(null, line, 'partline');

      // Update Inventory
      if(inv.dealer__On_Hand__c==null) {inv.dealer__On_Hand__c=0;}
      if(inv.dealer__On_Order__c==null) {inv.dealer__On_Order__c=0;}
      if(line.dealer__Quantity_Ordered__c==null) {line.dealer__Quantity_Ordered__c=0;}
      if(line.dealer__Quantity_Sold__c==null) {line.dealer__Quantity_Sold__c=0;}

      inv.dealer__On_Hand__c = inv.dealer__On_Hand__c-line.dealer__Quantity_Sold__c;
      inv.dealer__On_Order__c= inv.dealer__On_Order__c+line.dealer__Quantity_Ordered__c;

      try {
        update inv;
      } Catch(DmlException e) {
        return '{ "error" : "'+e.getMessage()+'" }';
      }

      lineTotalParts(job.Id);  
      lineTotalMisc(job.Id);

      // Process the Misc. Charge Codes
      try {
        // ServiceRepairOrderAPI.automateMiscCharges(job);
      } Catch(Exception e) {
        return '{ "error" : "'+e.getMessage()+'" }';
      }

      return line.Id;

  }

  public String updatePartLine() {

    Parts_Invoice_Line__c line = new Parts_Invoice_Line__c();

    if(Decimal.valueOf(String.valueOf(urlParameters.get('QTY'))) < 0) {
      error_string = '{ "error" : "Part QTY may not be negative" }';  
      return null;
    }

    // Isolate Variables
    Decimal qty = Decimal.valueOf(String.valueOf(urlParameters.get('QTY')));
    Decimal salePrice = Decimal.valueOf(String.valueOf(urlParameters.get('SalePrice')));
    String invoiceLineId = String.valueOf(urlParameters.get('Id')); // InvoiceLineID
    String partId = String.valueOf(urlParameters.get('PartInventoryId')); // PartId
    system.assert(invoiceLineId != null,'Invoice Line Id needed in update call');
    
    Parts_Invoice_Line__c l = [SELECT dealer__Quantity_Sold__c, dealer__Price__c,  dealer__Job_Line__c, dealer__Job_Line__r.dealer__Parts_Total__c FROM Parts_Invoice_Line__c WHERE Id=:invoiceLineId LIMIT 1];
       
    Decimal total = l.dealer__Job_Line__r.dealer__Parts_Total__c;
    Decimal oldPartLine =   l.dealer__Quantity_Sold__c * l.dealer__Price__c;
      
    try {
      line = PartInvoiceAPI.updateInvoiceLine(invoiceLineId, qty, salePrice, null);
      updatePartsMiscCharges(line, total, oldPartLine, false);

    } Catch(Exception e) {
      error_string = '{ "error" : "'+e.getMessage()+'" }';
      return null;
    } 

    return JSON.serializePretty(new PartRow(line));

  }

  public String getPartLine() {

    // Error Trapping passed back in the form of JSON
    if(error_string!=null) {
      return error_string;
    }

    if(partLine==null || partLine =='') {
      return '{ "error" : "Part Line not specified, please contact support" }';
    }

    dealer__Parts_Invoice_Line__c line = [SELECT dealer__Parts_Invoice__c , dealer__Bin__c, dealer__Core__c, dealer__Cost__c, dealer__Counterman_No__c, dealer__Counterman__c, dealer__Currently_Available__c, dealer__Drop_Ship__c, dealer__Extended_Price__c, dealer__Gross_Margin__c, dealer__Job_Line__c, dealer__List__c, dealer__MFG__c, dealer__Net_Price__c, dealer__Net__c, dealer__Order_Type__c, dealer__Part_Description__c, dealer__Part_Number__c, dealer__Part__c, dealer__Pay_Type__c, dealer__Price_Level_Strategy__c, dealer__Price_Level__c, dealer__Price__c, dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Sale_Date__c, dealer__Service_Job_Line_Number__c, dealer__Service_Line_Payment_Method__c, dealer__Service_Repair_Order__c, dealer__Sold_Via__c, dealer__Source__c, dealer__Stocking_Group__c, dealer__Total_Price__c, dealer__Total_Tax__c, dealer__Transaction_Code__c, dealer__Part_Master_Record__c, dealer__Currently_On_Order__c, dealer__Negative_QTY__c, Name, Id FROM dealer__Parts_Invoice_Line__c where Id=:partLine limit 1];

    return JSON.serializePretty(new PartRow(line));
  }

  /**
   * updateLine
   * @return String
   * @notes creates or updates a service job line based on if the record has an ID or is new
   * Additionaly this process will add techtime and parts if the standard operation code contains a parts kit
   */
  public String updateLine() {
     
    // Set Transaction Control
    SavePoint sp = Database.setSavePoint();

    // Job Line Instance
    Service_Job__c j = new Service_Job__c();

    // Get the job line if the Job ID Is present in the payload
    if(urlParameters.get('Id')!=null && urlParameters.get('Id')!='') {
      j = [Select Id, Standard_Operation_Code__c, Standard_Operation_Code__r.Part_Markup_Internal__c, Standard_Operation_Code__r.Part_Markup_Warranty__c  from Service_Job__c where Id=:urlParameters.get('Id') limit 1];
      jobLineId = String.valueOf(urlParameters.get('Id'));

      if(j.Id==null) {
        Database.rollback(sp);
        return '{ "error" : "Job Line ID not found." }'; 
      }
    }

    // Deconstruct payload to update the respective row
    j.CustomerConcern__c = String.valueOf(urlParameters.get('dealer__CustomerConcern__c'));
    j.Cause__c   = String.valueOf(urlParameters.get('dealer__Cause__c'));
    j.CauseExtended__c   = String.valueOf(urlParameters.get('dealer__CauseExtended__c'));
    j.Correction__c = String.valueOf(urlParameters.get('dealer__Correction__c'));

    //T-00832 :begins
    string opCodeKeyPrefix = StandardOpCode__c.sobjecttype.getDescribe().getKeyPrefix();

    if(urlParameters.get('dealer__Standard_Operation_Code__c')!=null && urlParameters.get('dealer__Standard_Operation_Code__c').startsWith(opCodeKeyPrefix) ){
        j.Standard_Operation_Code__c = String.valueOf(urlParameters.get('dealer__Standard_Operation_Code__c'));  
    }
    
    j.Stat__c =  String.valueOf(urlParameters.get('dealer__Stat__c'));

    StandardOpCode__c opcode = new StandardOpCode__c();

    List<StandardOpCode__c> listOpCode = [Select Id, Name, Pay_Type__c, Include_Kit__c, Labor_Estimate__c, Labor_Rate__c, Book_Time__c from StandardOpCode__c 
                        where Id=:j.Standard_Operation_Code__c 
                        limit 1];    

    if(listOpCode!=null && listOpCode.size()>0){
        opcode = listOpCode[0];
    }
    //T-00832 : ends

    // Use the user Selected Labor Type if sent
    if( urlParameters.get('dealer__Labor_Type__c') != null && urlParameters.get('dealer__Labor_Type__c') != '' ) {
        j.Labor_Type__c =   urlParameters.get('dealer__Labor_Type__c');                        

    } else {
        j.Labor_Type__c =   opcode.Pay_Type__c;                        
    }

    if(j.Labor_Type__c==null) {
        j.Labor_Type__c='C';
    }

    j.Op_Code__c    =   opcode.Name;

    // Handle the Creates
    if(urlParameters.get('action')=='create') {
      roId = String.valueOf(urlParameters.get('rid'));
      j.Service_Repair_Order__c = roId;

      // Get Job Line as Incrimental Number
      Service_Job__c[] job_line_counter = [Select Line_Number__c from Service_Job__c where Service_Repair_Order__c =:roId order by Line_Number__c desc limit 1];
      if(job_line_counter.size()==0) {
        j.Line_Number__c = 1;
      } else {
        if(job_line_counter[0].Line_Number__c==null) { job_line_counter[0].Line_Number__c = 0; }
        j.Line_Number__c = job_line_counter[0].Line_Number__c + 1;
      }

      Service_Repair_Order__c rodata = [SELECT Name FROM Service_Repair_Order__c WHERE Id=:roId limit 1];
      j.Name = rodata.Name +'-'+ j.Line_Number__c;

      try {
        insert j;
      } Catch(Exception e) {
        Database.rollback(sp);
        return '{ "error" : "'+e.getMessage()+'" }'; 
      }

      // If an assocaited parts kit is present, add the labor and parts.
      if(opcode.Include_Kit__c!=null) {
        // Get the kit details
        dealer__Parts_Kit__c kitdetails = [SELECT Id, Name, dealer__Description__c, dealer__Kit_Hours__c, dealer__Kit_Notes__c, dealer__Kit_Price__c, dealer__Labor_Sale__c, dealer__Labor_Cost__c, dealer__Item_Count__c, (SELECT dealer__Parts_Kit__c, dealer__Cost__c, dealer__Extended_Cost__c, dealer__Extended_List__c, dealer__Gross_Margin__c, dealer__List__c, dealer__Part_Description__c, dealer__Part_Name__c, dealer__Part__c, dealer__Parts_Master__c, dealer__Quantity__c, dealer__Sale_Price__c, Name, Id FROM Parts_Kit_Items__r) FROM dealer__Parts_Kit__c WHERE ID=:opcode.dealer__Include_Kit__c LIMIT 1];

        // Add the Labor
        List<Technician_Job_Time__c> tts = new List<Technician_Job_Time__c>();

        // PreFlight 
        if(kitdetails.Labor_Sale__c==null) { kitdetails.Labor_Sale__c=0; }
        if(kitdetails.Kit_Hours__c==null) {kitdetails.Kit_Hours__c=1; }

        tts.add(new Technician_Job_Time__c(
                        Service_Job_Line__c=j.Id,
                        Technician__c=null,
                        Actual_Time_Entry__c=kitdetails.Kit_Hours__c,
                        Book_Time_Entry__c=kitdetails.Kit_Hours__c,
                        Date__c=Date.today(),
                        Labor_Cost__c=kitdetails.Labor_Cost__c,
                        Labor_Total__c=kitdetails.Labor_Sale__c,
                        Time_Punch_Notes__c='Added via kit sale',
                        Payment_Method_Labor_Rate__c=(kitdetails.Labor_Sale__c/kitdetails.Kit_Hours__c)
                )
        );

        try {
            System.debug('Creating tech time');
            TechnicianJobTimeAPI.addTechTime(tts);
        } Catch(Exception e) {
            Database.rollback(sp);
            return '{ "error" : "Failed to create labor from kit, '+e.getMessage()+'" }';
        }

        if(kitdetails.dealer__Item_Count__c>0) {
            // Add any associated parts
            dealer__Service_Repair_Order__c roPInv = [Select Id, Name, dealer__Parts_Invoice__c, dealer__RO_Number__c, dealer__Company__c 
                              from dealer__Service_Repair_Order__c
                              Where Id=:j.dealer__Service_Repair_Order__c
                              limit 1];
            
            dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
            if(roPInv.dealer__Parts_Invoice__c==null){
              
              pi.Name = 'INV#'+roPInv.dealer__RO_Number__c;
              pi.dealer__Invoice_Number__c = 'RO'+roPInv.RO_Number__c;
              pi.dealer__Service_Repair_Order__c = roPInv.Id;

              try {
                pi = PartInvoiceAPI.createInvoice(pi);
                roPInv.Parts_Invoice__c = pi.Id;
                update roPInv;
              } Catch(Exception e) {
                Database.rollback(sp);
                return '{ "error" : "'+e.getMessage()+'" }';
              }
            }

            // Get a list of the master Items and return a map of existing parts for this location
            List<Parts_Master__c> masterItems = new List<Parts_Master__c>();
            for(Parts_Kit_Item__c kl : kitdetails.Parts_Kit_Items__r) {
                if(kl.Parts_Master__c!=null) {
                    masterItems.add(new Parts_Master__c(Id=kl.Parts_Master__c));
                }
            }

            if(!masterItems.isEmpty()) {

                Map<Id, Parts_Inventory__c> invRecords = PartAPI.createInventoryFromMaster(masterItems, roPInv.dealer__Company__c);

                for(Parts_Kit_Item__c kl : kitdetails.Parts_Kit_Items__r) {
                    //addInvoiceLine
                    try {
                        
                        if(kl.Sale_Price__c==null && kl.List__c!=null) {
                            kl.Sale_Price__c=kl.List__c;
                        }
                        
                        if(kl.Sale_Price__c==null) {
                           kl.Sale_Price__c=0;
                        }

                        PartInvoiceAPI.addInvoiceLine(roPInv.dealer__Parts_Invoice__c, j.Id, invRecords.get(kl.Parts_Master__c).Id, kl.dealer__Quantity__c, (kl.Sale_Price__c * kl.Quantity__c), null);
                    } Catch(Exception e) {
                        Database.rollback(sp);
                        return '{ "error" : "'+e.getMessage()+'" }';
                    }
                }
            }
        }

      } // End auto add kit labor and parts 

      // If Kit is NULL but Labor Estimate and Book Time are not, create a tech line
//      if(opcode.Include_Kit__c == null && opcode.Book_Time__c!=null && opcode.Labor_Rate__c!=null && opcode.Labor_Estimate__c!=null) {
        if(opcode.Include_Kit__c == null && opcode.Book_Time__c!=null && opcode.Labor_Rate__c!=null) {

          Technician_Job_Time__c tt = new Technician_Job_Time__c(
                        Service_Job_Line__c=j.Id,
                        Technician__c=null,
                        Book_Time_Entry__c=opcode.Book_Time__c,
                        Date__c=Date.today(),
                        //Labor_Cost__c=opcode.Labor_Estimate__c,
                        Labor_Total__c=opcode.Labor_Estimate__c,
                        Payment_Method_Labor_Rate__c=opcode.Labor_Rate__c
          );

          try {
              TechnicianJobTimeAPI.addTechTime(new List<Technician_Job_Time__c>{ tt });
              //Create misc charges
              createMiscChargeLines(tt, null,'techtime');
   
              // Re-total misc items
              lineTotalMisc(tt.dealer__Service_Job_Line__c);
              
          } Catch(Exception e) {
              Database.rollback(sp);
              return '{ "error" : "Failed to create labor from kit, '+e.getMessage()+'" }';
          }          
      }    

    } else {
      roId = Id.valueOf(String.valueOf(urlParameters.get('dealer__Repair_Order_Id__c')));
    }

    /*** Re-Calculate Child Rows ***/
    List<dealer__Parts_Invoice_Line__c> partLines = new List<dealer__Parts_Invoice_Line__c>();

    if(!String.ISBLANK(jobLineId)){
      partLines = [SELECT dealer__Parts_Invoice__c, dealer__Bin__c, dealer__Core__c, dealer__Cost__c, dealer__Counterman_No__c, dealer__Counterman__c, dealer__Currently_Available__c, dealer__Drop_Ship__c, dealer__Extended_Price__c, dealer__Gross_Margin__c, dealer__Job_Line__c, dealer__List__c, dealer__MFG__c, dealer__Net_Price__c, dealer__Net__c, dealer__Order_Type__c, dealer__Part_Description__c, dealer__Part_Number__c, dealer__Part__c, dealer__Pay_Type__c, dealer__Price_Level_Strategy__c, dealer__Price_Level__c, dealer__Price__c, dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Sale_Date__c, dealer__Service_Job_Line_Number__c, dealer__Service_Line_Payment_Method__c, dealer__Service_Repair_Order__c, dealer__Sold_Via__c, dealer__Source__c, dealer__Stocking_Group__c, dealer__Total_Price__c, dealer__Total_Tax__c, dealer__Transaction_Code__c, Part_Master_Record__c, Currently_On_Order__c, Negative_QTY__c, Name, Id FROM dealer__Parts_Invoice_Line__c WHERE dealer__Job_Line__c =: jobLineId FOR UPDATE];        
    }

    if(partLines.size() >0){
      for(dealer__Parts_Invoice_Line__c pl: partLines) {

        pl.dealer__Pay_Type__c = j.dealer__Labor_Type__c;

        if (j.dealer__Labor_Type__c == 'W') {

          if(j.dealer__Standard_Operation_Code__c != null 
              && j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Warranty__c != null
              && j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Warranty__c > 0 ) {

            // Add markup to cost
            pl.dealer__Price__c = ((j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Warranty__c/100) * pl.dealer__Cost__c) + pl.dealer__Cost__c;
          } else {
            pl.dealer__Price__c = pl.dealer__Cost__c; 
          }

        } else if(j.dealer__Labor_Type__c == 'I') {

          if(j.dealer__Standard_Operation_Code__c != null 
            && j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Internal__c != null 
            && j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Internal__c > 0) {

            pl.dealer__Price__c = ((j.dealer__Standard_Operation_Code__r.dealer__Part_Markup_Internal__c/100) * pl.dealer__Cost__c) + pl.dealer__Cost__c;
          
          } else {
            pl.dealer__Price__c = pl.dealer__Cost__c; 
          }

        } else { // "C" is default
          if(pl.dealer__Price__c == null) {
            pl.dealer__Price__c = pl.dealer__List__c;
          }
        }

      }
      
      try {
        update partLines;
      } Catch(Exception e) {
        Database.rollback(sp);
        return '{ "error" : "'+e.getMessage()+'" }';
      }
    }

    try {
      if(j.Id!=null) {
        update j;
      }
    } catch(DmlException e) {
        Database.rollback(sp);
        return '{ "error" : "'+e.getMessage()+'" }';
    } Catch(Exception e) {
        Database.rollback(sp);
        return '{ "error" : "'+e.getMessage()+'" }'; 
    }

    jobLineId = j.Id;

    // Process the Misc. Charge Codes
    try {
      //  ServiceRepairOrderAPI.automateMiscCharges(j);
    } Catch(Exception e) {
      return '{ "error" : "'+e.getMessage()+'" }';
    }

    return getRoLines();
  }
  public String createMisc() {
    dealer__Service_Misc_Charge__c m =   new dealer__Service_Misc_Charge__c();
    m.Service_Job_Lines__c   =   String.valueOf(urlParameters.get('lid'));
    m.Type__c         =   String.valueOf(urlParameters.get('dealer__Type__c'));
    m.Amount__c        =  Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Amount__c')));
    m.MiscChargeCode__c = urlParameters.get('MiscObj[Id]');
    m.Description__c = urlParameters.get('MiscObj[dealer__Description__c]') == null ? '' : urlParameters.get('MiscObj[dealer__Description__c]');

    try {
      insert m;
    } catch(DmlException e) {
      return '{ "error" : "'+e.getMessage()+'" }';
    }
    
    lineTotalMisc(String.valueOf(urlParameters.get('lid')));

    // Update RO
    dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c where Id=:String.valueOf(urlParameters.get('rid')) limit 1];
    update ro;

    return 'true';
    //return JSON.serializePretty(m);
  }

  public String updateMisc() {
    dealer__Service_Misc_Charge__c m = [Select Id from dealer__Service_Misc_Charge__c where Id=:urlParameters.get('Id') limit 1];
    m.Amount__c = Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Amount__c')));
    m.Type__c = String.valueOf(urlParameters.get('dealer__Type__c'));

    // Is there a new line being set?
    if( urlParameters.get('newLineId') != null ) {
      m.Service_Job_Lines__c =  String.valueOf(urlParameters.get('newLineId'));
    }

    try {
      update m;
    } catch(DmlException e) {
      return '{ "error" : "'+e.getMessage()+'" }';
    }

    // Total Line - Service_Job_Lines__c is the original line even if a new line is sent in the payout
    lineTotalMisc(String.valueOf(urlParameters.get('dealer__Service_Job_Lines__c')));
    
    // calculate the new line totals
    if( urlParameters.get('newLineId') != null ) {
      lineTotalMisc(String.valueOf(urlParameters.get('newLineId')));
    }

    // Update RO
    dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c where Id=:String.valueOf(urlParameters.get('rid')) limit 1];
    update ro;    

    return 'true';
    //return JSON.serializePretty(m);
  }

  public String deleteMisc() {

    // Check reference integrity.
    if(urlParameters.get('Id')== null 
        || urlParameters.get('dealer__Service_Job_Lines__c')==null 
        || urlParameters.get('rid') == null ) {
      
          throw new ROException('deleteMisc requires Misc ID, ServiceJobLine, rId as GET Parameters');
    }

    dealer__Service_Misc_Charge__c m = [Select Id from dealer__Service_Misc_Charge__c where Id=:urlParameters.get('Id') limit 1];
    try {
      delete m;
    } catch (DmlException e) {
      return '{ "error" : "'+e.getMessage()+'" }';
    }

    lineTotalMisc(String.valueOf(urlParameters.get('dealer__Service_Job_Lines__c')));

    // Update RO
    //dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c where Id=:String.valueOf(urlParameters.get('rid')) limit 1];
    //update ro;

    return 'true';
  }

  public void lineTotalMisc(String jobId) {
      
    system.debug('---> Calculate techtime');
    AggregateResult[] sumLine = [Select SUM(dealer__Amount__c) line 
                      FROM dealer__Service_Misc_Charge__c 
                      where dealer__Service_Job_Lines__c =:jobId];                  

    AggregateResult[] sumTime = [Select SUM(dealer__Actual_Time_Entry__c) time, 
                      SUM(dealer__Labor_Total__c) lineTotal,
                      SUM(dealer__Book_Time_Entry__c) bookTime,
                      SUM(dealer__Labor_Cost__c) lineCost
                      FROM dealer__Technician_Job_Time__c
                      Where dealer__Service_Job_Line__c=:jobId];                   

    Decimal sum = (decimal) sumLine[0].get('line');
    if(sum==null) { sum = 0; }

    dealer__Service_Job__c job   = [Select Id, dealer__Misc_Charges__c, dealer__Actual_Time__c, dealer__Book_Time__c, dealer__Labor_Charges__c, dealer__Technician_Cost__c, dealer__Service_Repair_Order__c from dealer__Service_Job__c where Id=:jobId limit 1 for update];

    // Check the before and after values
    if(job.dealer__Misc_Charges__c!=sum ||
        job.dealer__Actual_Time__c != (Decimal)sumTime[0].get('time') ||
        job.dealer__Book_Time__c != (Decimal)sumTime[0].get('bookTime') ||
        job.dealer__Labor_Charges__c != (Decimal)sumTime[0].get('lineTotal') ||
        job.dealer__Technician_Cost__c != (Decimal)sumTime[0].get('lineCost')) {


          job.dealer__Misc_Charges__c = sum;
          job.dealer__Actual_Time__c   = (Decimal)sumTime[0].get('time');
          job.dealer__Book_Time__c     = (Decimal)sumTime[0].get('bookTime');
          job.dealer__Labor_Charges__c= (Decimal)sumTime[0].get('lineTotal');
          job.dealer__Technician_Cost__c = (Decimal)sumTime[0].get('lineCost'); 

          update job;  

    }

    //dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c where Id=:job.dealer__Service_Repair_Order__c limit 1];
    //update ro;
  } 

  public void lineTotalParts(String jobId) {
    AggregateResult[] sumLine = [Select SUM(dealer__Extended_Price__c) line, SUM(Extended_Cost__c) cost 
                      FROM  dealer__Parts_Invoice_Line__c
                      where dealer__Job_Line__c =:jobId]; 
    if(sumLine.size() > 0) {


      Decimal sum = (decimal) sumLine[0].get('line');
      Decimal cost = (decimal) sumLine[0].get('cost');
      dealer__Service_Job__c job   = [Select Id, dealer__Parts_Total__c, dealer__Parts_Cost__c 
                                        from dealer__Service_Job__c where Id=:jobId limit 1 for update];

      if(job.dealer__Parts_Total__c != sum || job.dealer__Parts_Cost__c != cost) {
        job.dealer__Parts_Total__c = sum;
        job.dealer__Parts_Cost__c = cost;
        update job;
      }
    } 
  }

  public void lineTotalLabor(String jobId) {
    AggregateResult[] sumLine = [Select SUM(Labor_Total__c) line, SUM(Labor_Cost__c) cost 
                      FROM  dealer__Technician_Job_Time__c  
                      where dealer__Service_Job_Line__c =:jobId];          

    if(sumLine.size() > 0) {
      Decimal sum = (Decimal) sumLine[0].get('line');
      Decimal cost= (Decimal) sumLine[0].get('cost');

      dealer__Service_Job__c job   = [Select Id, dealer__Labor_Charges__c, dealer__Technician_Cost__c
                                         from dealer__Service_Job__c where Id=:jobId limit 1 for update];
      job.dealer__Labor_Charges__c   = sum;
      job.dealer__Technician_Cost__c   = cost;

      if(job.dealer__Labor_Charges__c != sum || job.dealer__Technician_Cost__c != cost) {

          try {
            update job;
          } Catch(DmlException e) {
            throw new ROException('DML Exception '+e);
          } Catch(SObjectException e) {
            throw new ROException('SObject Exception '+e);
          } Catch(Exception e) {
            throw new ROException('Exception '+e);
          }

      }
    }

  }  

  /**
  * Update the Labor Total based on BookTime if Booktime is set.
  */
  public String createTechTime() {
    /* 
      Initialize Technician Time
    */
    dealer__Technician_Job_Time__c tt = new dealer__Technician_Job_Time__c();
    tt.dealer__Service_Job_Line__c   =  String.valueOf(urlParameters.get('lid'));
    tt.dealer__Technician__c    =  String.valueOf(urlParameters.get('dealer__Technician__c[Id]'));
    tt.dealer__Actual_Time_Entry__c   =  (urlParameters.get('dealer__Actual_Time_Entry__c')!=NULL) ? Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Actual_Time_Entry__c'))) : 0;
    tt.dealer__Book_Time_Entry__c     =  (urlParameters.get('dealer__Book_Time_Entry__c')!=NULL) ? Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Book_Time_Entry__c'))) : 0;
    tt.dealer__Payment_Method_Labor_Rate__c = 0;
    tt.dealer__Labor_Total__c = 0;
    
    if(urlParameters.get('dealer__Payment_Method_Labor_Rate__c')!=null && urlParameters.get('dealer__Payment_Method_Labor_Rate__c')!='') {
      tt.dealer__Labor_Total__c               =   Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Payment_Method_Labor_Rate__c')));
      tt.dealer__Payment_Method_Labor_Rate__c =   Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Payment_Method_Labor_Rate__c')));
    }

    // Calc The Labor Total
    if(tt.dealer__Actual_Time_Entry__c==null) { tt.dealer__Actual_Time_Entry__c=0; }
    if(tt.dealer__Book_Time_Entry__c==null) { tt.dealer__Book_Time_Entry__c=0; }
    tt.dealer__Labor_Total__c = (tt.dealer__Payment_Method_Labor_Rate__c * tt.dealer__Book_Time_Entry__c);

    tt.dealer__Date__c         =  Date.parse(String.valueOf(urlParameters.get('dealer__Date__c')));

    try {
      insert tt;
    } catch(DmlException e) {
      return '{error:"'+e.getMessage()+'"}';
    }
    
    createMiscChargeLines(tt, null,'techtime');
   
    // Re-total misc items
    lineTotalMisc(tt.dealer__Service_Job_Line__c);
 
    return tt.Id;
  }

  public void createTechMisc(dealer__Technician_Job_Time__c tt_pc, String jobLineID) {
    dealer__Service_Job__c jobline = [Select Id, Name, dealer__Service_Repair_Order__r.dealer__Company__r.dealer__State__c
        FROM dealer__Service_Job__c WHERE Id=:jobLineID
        LIMIT 1];

    // add misc Hazmat line if applicable
    List<dealer__Service_Misc_Charge__c> miscLines = new List<dealer__Service_Misc_Charge__c>();
    //if(jobline.dealer__Payment_Method__r.Hazmat_Fee__c!=null && jobline.dealer__Payment_Method__r.Hazmat_Fee__c!=0) {
    //  // Add Misc Line
    //  miscLines.add(new dealer__Service_Misc_Charge__c(Service_Job_Lines__c=jobline.Id, Type__c='Hazardous Materials', Amount__c=jobline.dealer__Payment_Method__r.Hazmat_Fee__c, Technician_Job_Time_Creator__c = tt_pc.Id));
    //}

    // add misc Supplies line if applicable
    //if(jobline.dealer__Payment_Method__r.Shop_Supplies_Rate__c!=null&&jobline.dealer__Payment_Method__r.Shop_Supplies_Rate__c!=0) {
    //  // Labor Charges times Rate
    //  Decimal shop_supplies = tt_pc.Labor_Total__c * (jobLine.dealer__Payment_Method__r.Shop_Supplies_Rate__c / 100);

    //  // Check to see if we are in CA
    //  if(jobline.dealer__Service_Repair_Order__r.dealer__Company__r.dealer__State__c != 'CA') {
    //    miscLines.add(new dealer__Service_Misc_Charge__c(Service_Job_Lines__c=jobline.Id, Type__c='Shop Supplies', Amount__c=shop_supplies, Technician_Job_Time_Creator__c = tt_pc.Id));
    //  }
    //}

    if(miscLines.size()>0) {
      insert miscLines;
    }

    // lineTotalMisc( jobline.Id ); JVK - Method Duplicated
  }

  // Overload for null parameters
  public String updateTechTime() {
    // Default Id

    System.debug('UpdateTechTime - No Params');

    // Ensure NULL Values are not passed. 
    String recordId = String.valueOf(urlParameters.get('Id')); 
    Decimal actualTime = (urlParameters.get('dealer__Actual_Time_Entry__c')!=NULL) ? Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Actual_Time_Entry__c'))) : 0;
    Date entryDate = Date.parse(String.valueOf(urlParameters.get('dealer__Date__c')));
    Decimal bookEntry = (urlParameters.get('dealer__Book_Time_Entry__c')!=NULL) ? Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Book_Time_Entry__c'))) : 0;
    Decimal paymentLaborRate = (urlParameters.get('dealer__Payment_Method_Labor_Rate__c')!=NULL) ? Decimal.valueOf(String.valueOf(urlParameters.get('dealer__Payment_Method_Labor_Rate__c'))) : 0;
    String techId = String.valueOf(urlParameters.get('dealer__Technician__c[Id]'));

    if(recordId==NULL) {
      return '{error:"Error: Record ID not passed to Update Method"}';
    }

    return updateTechTime( 
        recordId,
        actualTime,
        entryDate,
        bookEntry,
        paymentLaborRate,
        techId
      ); 
  }
  
  public String updateTechTime(String ttimeId, Decimal ttTime, Date ttDate, Decimal bookTime, Decimal laborRateOverride, String technicianId ) {

    dealer__Technician_Job_Time__c tt = [SELECT Id, dealer__Service_Job_Line__c, dealer__Payment_Method_Labor_Rate__c,
                                              dealer__Actual_Time_Entry__c,dealer__Date__c, dealer__Labor_Total__c, dealer__Book_Time_Entry__c,
                                              dealer__Technician__c 
                                          FROM dealer__Technician_Job_Time__c
                                          WHERE Id=:ttimeId 
                                          LIMIT 1];                       

	  Decimal total = tt.dealer__Labor_Total__c;
      
      // Set the values passed by the urlParameters if present else use existing values.
      tt.dealer__Actual_Time_Entry__c = (ttTime != null) ? ttTime : tt.dealer__Actual_Time_Entry__c;
      tt.dealer__Book_Time_Entry__c = (bookTime != null) ? bookTime : tt.dealer__Book_Time_Entry__c;
      tt.dealer__Date__c   = (ttDate != null) ? ttDate : tt.dealer__Date__c;
      
      // Change the technician on the job line
      if(technicianId!=null && technicianId!= '' && technicianId != tt.dealer__Technician__c) {
          tt.dealer__Technician__c = technicianId;
      }
      // Store Original tt.Labor_Total__c before override
      Decimal laborOg = tt.Labor_Total__c;
      
      // Calculeate labor total
      if(tt.Payment_Method_Labor_Rate__c == null) { tt.Payment_Method_Labor_Rate__c = 0; }
      tt.Labor_Total__c = tt.Payment_Method_Labor_Rate__c * tt.dealer__Book_Time_Entry__c;
      if(laborRateOverride!=null) {
          tt.Payment_Method_Labor_Rate__c = laborRateOverride;
          tt.Labor_Total__c = laborRateOverride * tt.dealer__Book_Time_Entry__c;
      }
      
      // Is there a new job line being set? OR did the labor total change?
      if((urlParameters.get('newLineId') != null || tt.Labor_Total__c != laborOg) && Limits.getQueries() < 88 ) {
              // update misc lines related to the original job line
              updateLaborMiscCharges(tt, total, false);
          
              // re-total lines on Original Job Line
              lineTotalMisc( tt.dealer__Service_Job_Line__c );
          }

      // ** Set the Job Line to the new Line Id. ** 
      if(urlParameters.get('newLineId') != null){
        	tt.dealer__Service_Job_Line__c = String.valueOf(urlParameters.get('newLineId'));
      }

        try {
          update tt;
        } catch(DmlException e) {
          return '{error:"'+e.getMessage()+'"}';
        }
      
       	// re-total lines on Original Job Line
      	lineTotalMisc( tt.dealer__Service_Job_Line__c );

    	return tt.Id;    
  }

  //W-001295   Create misc charges based on SRO Location and Labor Type (W, I, C) for Tech time and parts
  private void createMiscChargeLines(dealer__Technician_Job_Time__c tt, Parts_Invoice_Line__c line, String lineType){
        
    Service_Job__c j;
    List<dealer__Service_Misc_Charge__c> currMiscLines;
    String locId;

    try{
        
        if(lineType == 'techtime'){

            //Get Service Job line
            j = [SELECT Id, Labor_Type__c, dealer__Service_Repair_Order__c, dealer__Service_Repair_Order__r.dealer__Company__c 
                 FROM Service_Job__c WHERE Id =: tt.dealer__Service_Job_Line__c];
            
            locId = j.dealer__Service_Repair_Order__r.dealer__Company__c;
            
            //Get misc charges
            currMiscLines = [Select Id, Amount__c, Type__c from dealer__Service_Misc_Charge__c where dealer__Service_Job_Lines__c =: tt.dealer__Service_Job_Line__c Limit 500];
            
        }else if(lineType == 'partline'){
            
			//Get Service Job line
            j = [SELECT Id, Labor_Type__c, dealer__Service_Repair_Order__c, dealer__Service_Repair_Order__r.dealer__Company__c 
                 FROM Service_Job__c WHERE Id =: line.Job_Line__c];
            
            locId = j.dealer__Service_Repair_Order__r.dealer__Company__c;

            //Get misc charges
            currMiscLines = [Select Id, Amount__c, Type__c from dealer__Service_Misc_Charge__c where dealer__Service_Job_Lines__c =: line.dealer__Job_Line__c Limit 500];
        }      
   	}catch(Exception e){
        e.getMessage();
    }
    
    if(j != null && locId != '' && locId != null){
        
        //Get Misc charges for SRO Location that apply for the Service Job Line Labor Type (W, I, C)
      	List<MiscChargeCode__c> mCharges = [SELECT Id, Name, Active__c, ApplicablePayType__c, BaseCharge__c, 
                                          Description__c, FlatAmount__c, PercentageBasedAmount__c, MaximumCharge__c
                                          FROM MiscChargeCode__c
                                          WHERE Active__c=true 
                                          AND Location__c=:locId
                                          AND ApplicablePayType__c INCLUDES (:j.Labor_Type__c)
                                          LIMIT 200];  

      	List<dealer__Service_Misc_Charge__c> miscLinesNew = new List<dealer__Service_Misc_Charge__c>();
        Map<String,dealer__Service_Misc_Charge__c> miscLinesMap = new Map<String,dealer__Service_Misc_Charge__c>();
        
        //Existing misc lines
        if(!currMiscLines.isEmpty()){
            
            for(dealer__Service_Misc_Charge__c smc: currMiscLines){
                if(miscLinesMap.get(smc.dealer__Type__c) == null){
                    String mcName = smc.dealer__Type__c;
                    mcName = mcName.toLowerCase();
                    miscLinesMap.put(mcName, smc); 
                }
            }

        }
        
        //Misc charges to apply 
        if(!mCharges.isEmpty()){
            
            for(MiscChargeCode__c mCharge: mCharges){
                
              if(lineType != null && lineType != ''){
                  //Tech Time
                  if(lineType == 'techtime' && tt.dealer__Labor_Total__c != null && tt.dealer__Labor_Total__c > 0 
                     && mCharge.BaseCharge__c=='Labor Sale'){
                         
                      System.debug('Techtime Misc Charge');
       
                      // Calculate Charge
                      Decimal chargeAmount = 0;
                      if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
                      if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
                          chargeAmount = ((tt.dealer__Labor_Total__c * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (tt.dealer__Labor_Total__c * (mCharge.PercentageBasedAmount__c / 100));
                      }
                         
                      String mChargeName = mCharge.Name;
                      mChargeName = mChargeName.toLowerCase();

                      if(miscLinesMap.get(mChargeName) != null){
                         //Update misc line
                         
                         Decimal newAmount = miscLinesMap.get(mChargeName).Amount__c + chargeAmount.setScale(2, System.RoundingMode.HALF_UP);
                         
                         // Josh updated if /else statements so misc charges would ot get wiped out W-002056
                         
                          if( newAmount >= mCharge.MaximumCharge__c && mCharge.MaximumCharge__c != null ){
                            miscLinesMap.get(mChargeName).Amount__c = mCharge.MaximumCharge__c;
                          }
                          else if(newAmount <= mCharge.MaximumCharge__c){
                             miscLinesMap.get(mChargeName).Amount__c = newAmount;
                         }
                         else{
                            miscLinesMap.get(mChargeName).Amount__c = newAmount;
                         }
                         miscLinesNew.add(miscLinesMap.get(mChargeName));          
                          
                      } else {
                          //Create misc line
                          if(chargeAmount != 0){
                              miscLinesNew.add(new dealer__Service_Misc_Charge__c(
                                  Service_Job_Lines__c   =   tt.dealer__Service_Job_Line__c,
                                  Type__c        =   mCharge.Name,
                                  Amount__c     =   chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
                                  Description__c = mCharge.Description__c,
                                  MiscChargeCode__c = mCharge.Id,
                                  Technician_Job_Time_Creator__c = tt.Id
                              ));
                  
                          }
                       }
                  }
                  //Part Line
                  else if(lineType == 'partline' && line.dealer__Price__c != null && line.dealer__Quantity_Sold__c > 0 
                          && mCharge.BaseCharge__c=='Parts Sale'){
                     
                     Decimal totalSale = line.dealer__Price__c * line.dealer__Quantity_Sold__c;
    
                     // Calculate Charge
                     Decimal chargeAmount = 0;
                     if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
                     if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
                         chargeAmount = ((totalSale * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (totalSale * (mCharge.PercentageBasedAmount__c / 100));
                     }
                     
                     String mChargeName = mCharge.Name;
                     mChargeName = mChargeName.toLowerCase();         
                     if(miscLinesMap.get(mChargeName) != null){
                         //Update misc line

                         // Josh updated if /else statements so misc charges would not get wiped out W-002056
                         Decimal newAmount = miscLinesMap.get(mChargeName).Amount__c + chargeAmount.setScale(2, System.RoundingMode.HALF_UP);
                          if( newAmount >= mCharge.MaximumCharge__c && mCharge.MaximumCharge__c != null ){
                            miscLinesMap.get(mChargeName).Amount__c = mCharge.MaximumCharge__c;
                          }
                          else if(newAmount <= mCharge.MaximumCharge__c){
                             miscLinesMap.get(mChargeName).Amount__c = newAmount;
                         }
                         else{
                            miscLinesMap.get(mChargeName).Amount__c = newAmount;
                         }
                         miscLinesNew.add(miscLinesMap.get(mChargeName));     
                         
                     } else {
                         //Create misc line
                         if(chargeAmount != 0){
                             miscLinesNew.add(new dealer__Service_Misc_Charge__c(
                                 Service_Job_Lines__c   =   j.Id,
                                 Type__c        =   mCharge.Name,
                                 Amount__c     =   chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
                                 Description__c = mCharge.Description__c,
                                 MiscChargeCode__c = mCharge.Id
                                 //dealer__Parts_Line__c  = line.id
                             ));
                         }
                     }
                  }			
              }
            }

           if(miscLinesNew.size()>0){
                try {
                    upsert miscLinesNew;
                } Catch(Exception e) {
                    e.getMessage();
                }  
            }
        }
     }//End W-001295 
  }
  
  //W-001295 
  private void updateLaborMiscCharges(dealer__Technician_Job_Time__c tt, Decimal total, Boolean isDelete){
            
      //Get Service Job
      dealer__Service_Job__c j = [SELECT Id, Labor_Type__c, dealer__Service_Repair_Order__c, dealer__Service_Repair_Order__r.dealer__Company__c, dealer__Labor_Charges__c  
               					FROM dealer__Service_Job__c WHERE Id =: tt.dealer__Service_Job_Line__c];
          
      List<dealer__Service_Misc_Charge__c> currMiscLines = [Select Id, Amount__c, Type__c from dealer__Service_Misc_Charge__c where dealer__Service_Job_Lines__c =: tt.dealer__Service_Job_Line__c Limit 500];
      if(currMiscLines.size()>0){

          String companyId = j.dealer__Service_Repair_Order__r.dealer__Company__c;
          
          //Misc charges
          List<MiscChargeCode__c> mCharges = [SELECT Id, Name, Active__c, ApplicablePayType__c, BaseCharge__c, 
                                              Description__c, FlatAmount__c, PercentageBasedAmount__c, MaximumCharge__c
                                              FROM MiscChargeCode__c
                                              WHERE Active__c=true 
                                              AND Location__c=:companyId
                                              AND ApplicablePayType__c INCLUDES (:j.Labor_Type__c)
                                              LIMIT 200];

          for(MiscChargeCode__c mCharge: mCharges){
              if(tt.dealer__Labor_Total__c != null && tt.dealer__Labor_Total__c > 0 
                 && mCharge.BaseCharge__c=='Labor Sale'){
                     
                     Decimal newLaborTotal = 0;
                     Decimal chargeAmount = 0;
                     
                     if(isDelete){
                         //Calculate new labor total (old total labor - old labor line
                         newLaborTotal = j.dealer__Labor_Charges__c - total;

                     }else{
                         //Calculate new labor total (old total labor - old labor line + new labor line)
                         newLaborTotal = j.dealer__Labor_Charges__c - total + tt.dealer__Labor_Total__c;

                     }  
                     
                     // Calculate Charge
                     if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
                     if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
                         chargeAmount = ((newLaborTotal * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (newLaborTotal * (mCharge.PercentageBasedAmount__c / 100));
                     }
                     
                     //Update misc line
                     for(dealer__Service_Misc_Charge__c smc: currMiscLines){
                         if(smc.Type__c == mCharge.Name){
                             smc.Amount__c =  chargeAmount.setScale(2, System.RoundingMode.HALF_UP);
                             if(smc.Amount__c > mCharge.MaximumCharge__c) { 
                                 smc.Amount__c = mCharge.MaximumCharge__c; 
                             }
                         }
                     }
              }
          }
          
          try {
              update currMiscLines;
          } Catch(Exception e) {
              e.getMessage();
          }
      }
  }
  
  //W-001295 
  private void updatePartsMiscCharges(Parts_Invoice_Line__c line, Decimal total, Decimal oldPartLine, Boolean isDelete){
      

      dealer__Service_Job__c j = [SELECT Id, Labor_Type__c, dealer__Service_Repair_Order__c, dealer__Service_Repair_Order__r.dealer__Company__c, dealer__Parts_Total__c  
               					FROM dealer__Service_Job__c WHERE Id =: line.dealer__Job_Line__c];  
      
      List<dealer__Service_Misc_Charge__c>  currMiscLines = [Select Id, Amount__c, Type__c from dealer__Service_Misc_Charge__c where dealer__Service_Job_Lines__c =: line.dealer__Job_Line__c Limit 500];
      
      if(currMiscLines.size()>0){
                        
          String companyId = j.dealer__Service_Repair_Order__r.dealer__Company__c;
          
          //Misc charges
          List<MiscChargeCode__c> mCharges = [SELECT Id, Name, Active__c, ApplicablePayType__c, BaseCharge__c, 
                                              Description__c, FlatAmount__c, PercentageBasedAmount__c, MaximumCharge__c
                                              FROM MiscChargeCode__c
                                              WHERE Active__c=true 
                                              AND Location__c=:companyId
                                              AND ApplicablePayType__c INCLUDES (:j.Labor_Type__c)
                                              LIMIT 200];
          
          for(MiscChargeCode__c mCharge: mCharges){
                  
              if(line.dealer__Price__c != null && line.dealer__Quantity_Sold__c > 0 
                          && mCharge.BaseCharge__c=='Parts Sale'){
                     
                     Decimal totalSale = 0;  
                     Decimal newPartsTotal  =  0;
                     
                     if(isDelete){
                         // newPartsTotal = Old parts total - old part line
                         newPartsTotal  =  total - oldPartLine;
                         
                     }else{
                         totalSale = line.dealer__Price__c * line.dealer__Quantity_Sold__c;    
                     	 // newPartsTotal = Old parts total - old part line + new total sale line         
                     	 newPartsTotal  =  total - oldPartLine + totalSale;
                         system.debug('newPartsTotal ' + newPartsTotal);
                     }  
                              
                     // Calculate Charge
                     Decimal chargeAmount = 0;
                     if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
                     if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
                         chargeAmount = ((newPartsTotal * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (newPartsTotal * (mCharge.PercentageBasedAmount__c / 100));
                     }
                     system.debug('charge amount ' + chargeAmount);

                     //Update misc line
                     for(dealer__Service_Misc_Charge__c smc: currMiscLines){
                         if(smc.Type__c == mCharge.Name){
                             smc.Amount__c = chargeAmount.setScale(2, System.RoundingMode.HALF_UP);     
                             
                             if(smc.Amount__c > mCharge.MaximumCharge__c) { 
                                 system.debug('new total misc amount set > ' +smc.Amount__c);
                                 smc.Amount__c = mCharge.MaximumCharge__c; 
                             }
                         }
                     }
              }
          }
          
          try {
              update currMiscLines;
          } Catch(Exception e) {
              e.getMessage();
          }
      }
  }

  /**
  *
  *  Calculate Labor Cost
  *
  */ 
  public Decimal calculateLaborCost(String jlId) {

    // Get the location Id from the Service Job Line
    Id locationId = [Select Id, Location_Id__c from dealer__Service_Job__c where Id=:jlId].Location_Id__c;

    // Get the Internal Labor Rate from the Company the Repair Order is Associated with.
    dealer__Dealer_Location__c[] loc = [Select Internal_Labor_Rate__c from dealer__Dealer_Location__c where Id=:locationId limit 1];

    if(loc.size()==1) {
      return loc[0].Internal_Labor_Rate__c;
    }

    return 0;
  }

  public String deletTechTime() {
    dealer__Technician_Job_Time__c tt = [Select Id, dealer__Repair_Order_Name__c, dealer__Service_Job_Line__c, dealer__Labor_Total__c 
                        from dealer__Technician_Job_Time__c where Id =:urlParameters.get('Id') limit 1];
    dealer__Service_Misc_Charge__c[] assCharges = [Select Id, Repair_Order_ID__c from dealer__Service_Misc_Charge__c where Technician_Job_Time_Creator__c =:urlParameters.get('Id') limit 100];
      Decimal total = tt.dealer__Labor_Total__c != null ? tt.dealer__Labor_Total__c : 0; 

    try {
      updateLaborMiscCharges(tt, total, true);
      //removed line that deleted assCharges because deletion of job line would remove misc charges for entire RO, even if another job line existed that should have a misc charge.
      delete tt;
    } catch (DmlException e) {
      return '{error:"'+e.getMessage()+'"}';
    }

    lineTotalLabor(tt.dealer__Service_Job_Line__c);
    lineTotalMisc(tt.dealer__Service_Job_Line__c);
    // Update RO To Re-Calc Line
    dealer__Service_Repair_Order__c ro = [Select Id from dealer__Service_Repair_Order__c 
                        where Name=:tt.dealer__Repair_Order_Name__c limit 1];

    try {                          
      update ro;
    } catch (DmlException e) {
      return '{error:"'+e.getMessage()+'"}';
    } catch (Exception e) {
      return '{error:"'+e.getMessage()+'"}';
    }

    return '';
  }

  public String getTechRow() { 
      if(ttId != null){
    		dealer__Technician_Job_Time__c tt = [SELECT dealer__Service_Job_Line__c, dealer__Actual_Time__c, dealer__Available_Flat_Rate_Time__c, dealer__Book_Time__c, dealer__Book_Time_Entry__c,
                                                dealer__Diag_Repair__c, dealer__Efficiency__c, dealer__Elapsed_Time_Minutes__c, dealer__End_Time__c, dealer__Flat_Rate_Time__c, 
                                                dealer__Job_Name__c, dealer__Job_Status__c, dealer__Labor_Type__c, dealer__Repair_Order_Name__c, dealer__Repair_Order_Number__c, 
                                                dealer__Start_Time__c, dealer__Technician__c, dealer__Time_Punch_Notes__c, Time_Clock_Entry__c, dealer__Actual_Time_Entry__c, 
                                                dealer__Date__c, dealer__Time_Clock__c, Payment_Method_Labor_Rate__c, Labor_Total__c, Name, Id,
                                                dealer__Technician__r.Name, Job_Line_Number__c 
                                            FROM dealer__Technician_Job_Time__c 
                                            WHERE Id=:ttId 
                                            LIMIT 1];
    		return JSON.serializePretty(tt);
      }
      return null;
  }

  // Access via "oepartions"
  public String getOperationCodes() {
    List<StandardOpCode__c> lops = [SELECT Name, Active__c, Associated_Marketing_Template__c, Book_Time__c, Cause__c, Company_Number__c, Concern__c, Correction__c, Default__c, Dispatch_Code__c, 
                                        Estimate__c, Labor_Estimate__c, Make__c, Op_Code_Description__c, Op_Code__c, Operation_Notes__c, Parts_Estimate__c, Pay_Type__c, Primary_Category__c, 
                                        Recommended_Service_Code__c, RecordId__c, Remarketing_Default_Delay__c, Service_Type__c, Labor_Rate__c, Service_Group__c, Id 
                                        FROM StandardOpCode__c 
                                        WHERE Active__c = true
                                        ORDER BY Name ASC LIMIT 2000];
    return JSON.serializePretty(lops);
  }

  /**
  * This method retrieves the service job lines and all underlying records related to a repair order
  */
  public String getRoLines() {

    try {
      List<Service_Job__c> lines = [SELECT ID, Name, Service_Repair_Order__c, Actual_Time__c, Book_Time__c, Cause__c, CauseExtended__c, Concern__c, Correction__c, Customer_Id__c, Estimate__c, Gross_Profit__c, Job_Added_Date__c, Job_ELR__c, Job_Finish__c, Job_Line_Id__c, Job_Start__c, Labor_Charges__c, Labor_Rate__c, Labor_Type__c, Line_Number__c, Line_Total__c, Op_Code__c, Operation_Code_Description__c, Parent_Record__c, Parts_Cost__c, Parts_Invoice_Id__c, Parts_Line__c, Parts_Total__c, RO_Invoice_Date_Time__c, RO_Number__c, RO_Status__c, Repair_Order_Id__c, Repair_Order__c, Service_Type__c, Service_Vehicle_Id__c, Standard_Operation_Code__c, Stat__c, Sublet_Total__c, Technician_Cost__c, Technician__c, Currently_Active__c, Sum_of_Billed_Hours__c, Payment_Notes__c, Add_On__c, Misc_Charges__c, Op_Description__c, Technician_ID__c, CustomerConcern__c, RO_Open_Date_Time__c, Claim__c, Paid_By__c, 
        (SELECT Parts_Invoice__c, Bin__c, Core__c, Cost__c, Counterman_No__c, Counterman__c, Currently_Available__c, Drop_Ship__c, Extended_Price__c, Gross_Margin__c, Job_Line__c, List__c, MFG__c, Net_Price__c, Net__c, Order_Type__c, Part_Description__c, Part_Number__c, Part__c, Pay_Type__c, Price_Level_Strategy__c, Price_Level__c, Price__c, Quantity_Ordered__c, Quantity_Sold__c, Sale_Date__c, Service_Job_Line_Number__c, Service_Line_Payment_Method__c, Service_Repair_Order__c, Sold_Via__c, Source__c, Stocking_Group__c, Total_Price__c, Total_Tax__c, Transaction_Code__c, Name, Id FROM Parts_Lines__r),
        (SELECT Service_Job_Line__c, Actual_Time__c, Available_Flat_Rate_Time__c, Book_Time__c, Diag_Repair__c, Efficiency__c, Elapsed_Time_Minutes__c, End_Time__c, Flat_Rate_Time__c, Job_Name__c, Job_Status__c, Labor_Type__c, Repair_Order_Name__c, Repair_Order_Number__c, Start_Time__c, Technician__c, Technician__r.Name, Time_Punch_Notes__c, Time_Clock_Entry__c, Actual_Time_Entry__c, Date__c, Time_Clock__c, Name, Id, Payment_Method_Labor_Rate__c FROM Technician_Job_Times__r),
        (SELECT Purchase_Order__c, Purchase_Order__r.Name, Account__c, Amount__c, Description__c, Drop_Ship_Address__c, Drop_Ship_To__c, Part_Quantity__c, Part__c, Parts_Invoice__c, Special_Instructions__c, Service_Job_Line__c, Name, Id FROM Purchase_Order_Line__r WHERE Purchase_Order__r.Status__c != 'Void'),
        (SELECT Id, Name, Amount__c, Service_Job_Lines__c, Type__c from Service_Misc_Charge__r),
          Standard_Operation_Code__r.Name, Standard_Operation_Code__r.Id, Standard_Operation_Code__r.Labor_Rate__c, Standard_Operation_Code__r.Book_Time__c
        FROM Service_Job__c WHERE Service_Repair_Order__c =:roId Order By Line_Number__c ASC limit 2000];

      // If We are returning a single job line, only return that one record (Updates and Creates)
      List<Service_Job__c> line_jonbonly = new List<Service_Job__c>();
      if(jobLineId!=null) {
        for(Service_Job__c j : lines) {
          if(j.Id==jobLineId) {
            line_jonbonly.add(j);
          }
        }

        if(line_jonbonly.size()>0) {
          lines = line_jonbonly;
        }
      }  

      return JSON.serializePretty(lines);
    } Catch(Exception e) {
      return JSON.serializePretty(e.getMessage());
    }
    //return null;
  }

  public String getTechTimes() {
    List<Technician_Job_Time__c> tt = [SELECT Service_Job_Line__c, Diag_Repair__c, Elapsed_Time_Minutes__c, End_Time__c, Flat_Rate_Time__c, Start_Time__c, Technician__c, Technician__r.Name, Time_Punch_Notes__c, Job_Status__c, Labor_Type__c, Actual_Time__c, Book_Time__c,Book_Time_Entry__c, Efficiency__c, Job_Name__c, Repair_Order_Name__c, Repair_Order_Number__c, Available_Flat_Rate_Time__c, Date__c, Actual_Time_Entry__c, Time_Clock__c, Labor_Cost__c, Labor_Total__c, Job_Line_Number__c, Payment_Method_Labor_Rate__c, Time_Clock_Entry__c, Name, Id
      FROM Technician_Job_Time__c where Service_Job_Line__c=:urlParameters.get('lid') limit 500];

    return JSON.serializePretty(tt);
  }

  public String getMiscItems() {
    List<dealer__Service_Misc_Charge__c> ml = [SELECT Id, Name, Description__c, dealer__Amount__c, dealer__Type__c, dealer__Service_Job_Lines__c, dealer__Service_Job_Lines__r.dealer__Line_Number__c FROM dealer__Service_Misc_Charge__c WHERE dealer__Service_Job_Lines__c =:urlParameters.get('lid') limit 500];
    
    return JSON.serializePretty(ml);
  }

  public String getTechnicians() {
    // Get Location data from active RO
    if(roId==null) {
      throw new ROException('roId Not set on the Controller');
    }

    dealer__Service_Repair_Order__c ro = [SELECT Id, Name, dealer__Company__c, dealer__Company__r.dealer__Company_Number__c FROM dealer__Service_Repair_Order__c WHERE Id=: roId LIMIT 1];

    if(ro.dealer__Company__r.dealer__Company_Number__c!=null){
      // Get Users Current Location
      List<User> techList = new List<User>();  // Prevent NULL Condition if No Techs exist.
      techList = [Select Id, FirstName, LastName, Name from User where dealer__Technician__c = true and Division =:ro.dealer__Company__r.dealer__Company_Number__c AND IsActive = true limit 500];

      return JSON.serializePretty(techList);
    } else {
      error_string = '{ "error" : "Location Company Number is not set." }';  
      return error_string;
    }

  }
  public String getClaimStatusCodes() {
      Schema.DescribeFieldResult fieldResult = ClaimItem__c.Status__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    
    List<Object> statList = new List<Object>();
    for( Schema.PicklistEntry f : ple) {
      //List<Object> statMap = new List<Object>();
      Map<String, String> statMap = new Map<String, String>();

       statMap.put('label', f.getLabel());
       statMap.put('value', f.getValue());

       statList.add(statMap);
    }       
    return JSON.serializePretty(statList);
  }
  public String getstatusCodes() {

    Schema.DescribeFieldResult fieldResult = dealer__Service_Job__c.dealer__Stat__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    
    List<Object> statList = new List<Object>();
    for( Schema.PicklistEntry f : ple) {
      //List<Object> statMap = new List<Object>();
      Map<String, String> statMap = new Map<String, String>();

       statMap.put('label', f.getLabel());
       statMap.put('value', f.getValue());

       statList.add(statMap);
    }       

    return JSON.serializePretty(statList);
  }

  /** Conversion Fields */
  public string getMiscTypes() { 
    
    /*
    List<String> options = new List<String>();
    Schema.DescribeFieldResult fieldResult =
    dealer__Service_Misc_Charge__c.Type__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
    for( Schema.PicklistEntry f : ple) {
      options.add( f.getValue() );
    } 
    */

    /* 
    List<String> options = new List<String>();

    String locationId = String.valueOf(urlParameters.get('locationId'));
    System.assert(locationId!=null&&locationId!='', 'Missing argument, getMiscTypes() requires LocationId to be included in the GET method values.');
    for(MiscChargeCode__c mcc : ServiceAPI.miscChargeCodes(locationId)) {
      options.add( mcc.Name );
    }
    */

        //for(User a : u) {
        //  adv.writeStartObject();
        //    adv.writeStringField('text', a.FirstName+' '+a.LastName);
        //    adv.writeStringField('value', a.Id);
        //    adv.writeStringField('color', '#6eb3fa');
        //  adv.writeEndObject();
        //}
        //adv.writeEndArray();
        //return adv.getAsString();

    // return JSON.serializePretty(options);
    String locationId = String.valueOf(urlParameters.get('locationId'));
    System.debug(ServiceAPI.miscChargeCodes(locationId));
    return JSON.serialize(ServiceAPI.miscChargeCodes(locationId));
  }

  public String getUserList() {

    // Get URL Parameters and SOSL 
    String searchString = String.valueOf(urlParameters.get('filter[filters][0][value]'));

    List<User> userList = new List<User>();

    if(searchString!=null && searchString!='' && searchString.length()>2) {
      // SOSL Execute
      //List<List<sObject>> soslResults = [FIND :searchString IN Name RETURNING User (Id, Name, UserRole.Name, Profile.Name) LIMIT 50];
      //List<User> cResults = (List<User>)soslResults[0];

      String qString = '%'+searchString+'%';

      // Restrict to Users Location?
      userList = [SELECT Id, Name, UserRole.Name, Profile.Name FROM User WHERE IsActive = true AND Name LIKE :qString LIMIT 50];
    } else {
      // Restrict to Users Location?
      userList = [SELECT Id, Name, UserRole.Name, Profile.Name FROM User WHERE IsActive = true LIMIT 50];
    }

    List<cUser> cUsers = new List<cUser>();

    for(User user: userList) {
      cUsers.add(new cUser(user));
    }

    return JSON.serializePretty(cUsers);
  }

  public class cUser {

    public String Id {get;set;}
    public String name {get;set;}
    public String value {get;set;}
    public String role {get;set;}
    public String profile {get;set;}

    public cuser(User sU){
      Id = sU.Id;
      value = sU.Id;

      name = sU.Name;
      role = (sU.UserRole.Name != null) ? sU.UserRole.Name : '';
      profile = (sU.Profile.Name != null) ? sU.Profile.Name : '';
    }
  }

  /*----------------------------------------------------*/
  /*    PARTS RELATED METHODS
  /*----------------------------------------------------*/

  public String getReadParts() {
    List<PartRow> plines = new List<PartRow>();
    if(jobLineId!=null&&jobLineId!='') {
      for(dealer__Parts_Invoice_Line__c p : [SELECT dealer__Parts_Invoice__c, dealer__Bin__c, dealer__Core__c, dealer__Cost__c, dealer__Counterman_No__c, dealer__Counterman__c, dealer__Currently_Available__c, dealer__Drop_Ship__c, dealer__Extended_Price__c, dealer__Gross_Margin__c, dealer__Job_Line__c, dealer__List__c, dealer__MFG__c, dealer__Net_Price__c, dealer__Net__c, dealer__Order_Type__c, dealer__Part_Description__c, dealer__Part_Number__c, dealer__Part__c, dealer__Pay_Type__c, dealer__Price_Level_Strategy__c, dealer__Price_Level__c, dealer__Price__c, dealer__Quantity_Ordered__c, dealer__Quantity_Sold__c, dealer__Sale_Date__c, dealer__Service_Job_Line_Number__c, dealer__Service_Line_Payment_Method__c, dealer__Service_Repair_Order__c, dealer__Sold_Via__c, dealer__Source__c, dealer__Stocking_Group__c, dealer__Total_Price__c, dealer__Total_Tax__c, dealer__Transaction_Code__c, dealer__Part_Master_Record__c, dealer__Currently_On_Order__c, dealer__Negative_QTY__c, Name, Id FROM dealer__Parts_Invoice_Line__c where dealer__Job_Line__c =: jobLineId limit 500]) {
        plines.add(new PartRow(p));
      }
    }

    if(plines.size() > 0) {
      return JSON.serializePretty(plines);
    } else {
      return '[]';
    }
  }

  public String getSearchParts() {

    if(search.length()<2) {
      return '';
    }

    List<List<sObject>> search_results = [FIND :search IN ALL FIELDS Returning dealer__Parts_Master__c (Id, Name, Part_Description__c, Manufacturer__c, Cost__c, Retail_Price__c WHERE Status__c != 'Obsolete') LIMIT 25];

    List<dealer__Parts_Master__c> plines = (List<dealer__Parts_Master__c>)search_results[0];
    List<PartSearch> p_result = new List<PartSearch>();
    for(dealer__Parts_Master__c p : plines) {
      p_result.add(new PartSearch(p));
    }

    return JSON.serializePretty(p_result);
  }

  public class PartSearch {
    public String PartName {get;set;}
    public String PartDescription {get;set;}
    public Id PartMasterId {get;set;}
    public String PartMFG {get;set;}
    public String search_display {get;set;}
    public Decimal cost;
    public Decimal sale;
    public PartSearch(dealer__Parts_Master__c p) {
      PartMasterId   =  p.Id;
      PartName     =  p.Name;
      PartDescription =  p.Part_Description__c;
      PartMFG     =  p.Manufacturer__c;
      search_display  =  p.Name+' '+p.Part_Description__c+' '+p.Manufacturer__c;
      cost = p.Cost__c;
      sale = p.Retail_Price__c;
    }
  }

  public String getStoreInventory() {
    List<StoreInventory> inv = new List<StoreInventory>();

    // To-Do : Add Geo Location to User

    for(dealer__Parts_Inventory__c p : [Select Id, Name, dealer__Location__c, dealer__Location__r.Name, dealer__On_Hand__c 
                        from dealer__Parts_Inventory__c 
                        where dealer__Parts_Master__c =:masterId 
                        and dealer__Location__r.Name != null
                        and dealer__On_Hand__c > 0
                        order by dealer__On_Hand__c DESC
                        limit 20])
    {
      inv.add(new StoreInventory(p.dealer__Location__r.Name, p.dealer__On_Hand__c.intValue()));
    }

    return JSON.serializePretty(inv);
  }

  public class StoreInventory {
    public String store {get;set;}
    public Integer qty {get;set;}
    public StoreInventory(String s, Integer q) {
      store   =   s;
      qty    =  q;
    }
  }

  public class PartRow {
    public Id ServiceJobId {get;set;}
    public Id Id {get;set;}
    public Id PartMasterId {get;set;}
    public Id PartInventoryId {get;set;}
    public String PartName {get;set;}
    public String PartDescription {get;set;}
    public Integer OnHand {get;set;}
    public Integer OnOrder {get;set;}
    public Decimal ListPrice {get;set;}
    public Decimal SalePrice {get;set;}
    public Decimal Cost {get;set;}
    public Integer QTY {get;set;}
    public Integer Order {get;set;}
    public Integer Negative {get;set;}
    public Decimal ExtendedTotal {get;set;}

    public PartRow(dealer__Parts_Invoice_Line__c p) {

      if(p==null 
          || p.dealer__Part__c == null 
          || p.dealer__Currently_Available__c == null 
          || p.dealer__Quantity_Sold__c == null 
          || p.dealer__Quantity_Ordered__c == null 
          || p.Negative_QTY__c == null) {
        throw new ROException('Required fields are missing [Part_Master_Record__c, Part__c]');
      }      

      ServiceJobId    =  p.dealer__Job_Line__c;
      Id              =  p.Id;
      PartMasterId    =  p.Part_Master_Record__c;
      PartInventoryId =  p.dealer__Part__c;
      PartName        =  p.dealer__Part_Number__c;
      PartDescription =  p.dealer__Part_Description__c;
      OnHand          =  p.dealer__Currently_Available__c.intValue();
      OnOrder         =  p.Currently_On_Order__c.intValue();
      ListPrice       =  p.dealer__List__c;
      Cost            =  p.dealer__Cost__c;
      SalePrice       =  p.dealer__Price__c;
      QTY             =  p.dealer__Quantity_Sold__c.intValue();
      Order           =  p.dealer__Quantity_Ordered__c.intValue();
      Negative        =  p.Negative_QTY__c.intValue();
      ExtendedTotal   =  p.dealer__Extended_Price__c;
    }
  }


  public String lookupPart(Parts_Service_Pricing_Strategy__c ps) {

    /*
      Get the Part searched by Dialog belonging to the company number assigned to the individual
        If no part exists in that stores inventory clone from the Master and Create
    */

    dealer__Parts_Inventory__c[] p = [SELECT dealer__Best_Stocking_Level__c, dealer__Bin_2__c, dealer__Bin__c, dealer__Comments__c, dealer__Comp__c, dealer__Company_Number__c, dealer__Core__c, dealer__Cost__c, dealer__Description__c, dealer__Detail__c, dealer__Entry_Date__c, dealer__Extended_Description__c, dealer__Extra_Days__c, dealer__Gross_Margin__c, dealer__Group__c, dealer__High_Days__c, dealer__High_Year__c, dealer__Illustration__c, dealer__Jobber__c, dealer__Kit__c, dealer__Last_Sale_Date__c, dealer__List__c, dealer__Low_Days__c, dealer__Low_Year__c, dealer__MFG__c, dealer__Max__c, dealer__Min__c, dealer__Minimum_Margin__c, dealer__On_Back_Order__c, dealer__On_Hand__c, dealer__On_Order__c, dealer__On_Special_Order__c, dealer__Online_Store_Id__c, dealer__PNC__c, dealer__Pack_QTY__c, dealer__Part_No__c, dealer__Parts_Master__c, dealer__Price_Update__c, dealer__Raw_Part_Number__c, dealer__Re_Order_Point__c, dealer__Remarks__c, dealer__Reserved__c, dealer__Return_Code__c, dealer__Source_List__c, dealer__Source__c, dealer__Static_Price__c, dealer__Status__c, dealer__Stocking_Group__c, dealer__Tax_Exempt__c, dealer__Trade__c, dealer__UPC__c, dealer__Warranty__c, dealer__Weight__c, dealer__Location__c, dealer__Part_Number__c, Id, Name FROM dealer__Parts_Inventory__c where dealer__Parts_Master__c =:masterId and dealer__Location__c=:locationId limit 1];

    if(p.size()==0) {
      // Add new Part to Location Based on Search from Master
      List<dealer__Parts_Master__c> pmList = [SELECT dealer__Applications__c, dealer__Core_Required__c, dealer__Core_Value__c, dealer__Cost__c, dealer__Height__c, dealer__Jobber_Price__c, dealer__Labor_Time__c, dealer__Length__c, dealer__MAP__c, dealer__MFG_Comments__c, dealer__Manufacturer__c, dealer__Pack_QTY__c, dealer__Part_Description__c, dealer__Part_No_Display__c, dealer__Part_No__c, dealer__Price_Tape_Date__c, dealer__Raw_Part_Number__c, dealer__Retail_Price__c, dealer__Return_Code__c, dealer__UPC__c, dealer__Warranty_Price__c, dealer__Weight__c, dealer__Width__c, dealer__Catalog_Image__c, Id, Name FROM dealer__Parts_Master__c where Id=:masterId limit 1];

      Id prtId = PartAPI.createInventoryFromMaster(pmList, locationId).values()[0].Id;
     
      Parts_Inventory__c newp = [SELECT dealer__Best_Stocking_Level__c, dealer__Bin_2__c, dealer__Bin__c, dealer__Comments__c, dealer__Comp__c, dealer__Company_Number__c, dealer__Core__c, dealer__Cost__c, dealer__Description__c, dealer__Detail__c, dealer__Entry_Date__c, dealer__Extended_Description__c, dealer__Extra_Days__c, dealer__Gross_Margin__c, dealer__Group__c, dealer__High_Days__c, dealer__High_Year__c, dealer__Illustration__c, dealer__Jobber__c, dealer__Kit__c, dealer__Last_Sale_Date__c, dealer__List__c, dealer__Low_Days__c, dealer__Low_Year__c, dealer__MFG__c, dealer__Max__c, dealer__Min__c, dealer__Minimum_Margin__c, dealer__On_Back_Order__c, dealer__On_Hand__c, dealer__On_Order__c, dealer__On_Special_Order__c, dealer__Online_Store_Id__c, dealer__PNC__c, dealer__Pack_QTY__c, dealer__Part_No__c, dealer__Parts_Master__c, dealer__Price_Update__c, dealer__Raw_Part_Number__c, dealer__Re_Order_Point__c, dealer__Remarks__c, dealer__Reserved__c, dealer__Return_Code__c, dealer__Source_List__c, dealer__Source__c, dealer__Static_Price__c, dealer__Status__c, dealer__Stocking_Group__c, dealer__Tax_Exempt__c, dealer__Trade__c, dealer__UPC__c, dealer__Warranty__c, dealer__Weight__c, dealer__Location__c, dealer__Part_Number__c, Id, Name FROM dealer__Parts_Inventory__c where Id=:prtId limit 1];

      p.clear();
      p.add(newP);
    }
    if(ps != null){
      p[0].Static_Price__c = calculatePricing(p[0], ps);
    }
    //Handle pricing strategy calculation here
    return JSON.serializePretty(new PartRowInventory(p[0]));
  }

  private Decimal calculatePricing(Parts_Inventory__c pi, Parts_Service_Pricing_Strategy__c ps){
     if(ps.Parts_Variable_Amount__c == null){
            ps.Parts_Variable_Amount__c = 0;
        }

        Decimal netPrice = 0;
        switch on ps.Method__c {
            when 'Jobber' {
                netPrice = pi.Jobber__c;
            }

            when 'MAP' {
                netPrice = pi.MAP__c;
            }

            when 'Warranty' {
                netPrice = pi.Warranty__c;
            }

            when 'List' {
                netPrice = pi.List__c;
            }

            when 'Cost' {
                netPrice = pi.Cost__c;
            }
            //If none of the above we default to list
            when else {
                netPrice = pi.List__c;
            }
        }
        netPrice = netPrice == null ? 0 : netPrice;

        netPrice =  ps.Formula_Operand__c == '-' ? netPrice - (netPrice * (ps.Parts_Variable_Amount__c/100)) : netPrice + (netPrice * (ps.Parts_Variable_Amount__c/100));

        return netPrice.setScale(2, System.RoundingMode.HALF_EVEN);
  }

  public class PartRowInventory {
    public Id ServiceJobId {get;set;}
    public Id Id {get;set;}
    public Id PartMasterId {get;set;}
    public Id PartInventoryId {get;set;}
    public String PartName {get;set;}
    public String PartDescription {get;set;}
    public Integer OnHand {get;set;}
    public Integer OnOrder {get;set;}
    public Decimal ListPrice {get;set;}
    public Decimal SalePrice {get;set;}
    public Decimal Cost {get;set;}
    public Integer QTY {get;set;}
    public Integer Order {get;set;}
    public Integer Negative {get;set;}
    public Decimal ExtendedTotal {get;set;}

    public PartRowInventory(dealer__Parts_Inventory__c p) {

      if(p.dealer__On_Hand__c==null) {
        p.dealer__On_Hand__c=0;
      }

      if(p.dealer__On_Order__c==null) {
        p.dealer__On_Order__c=0;
      }

      ServiceJobId   =   null;
      Id          =   null;
      PartMasterId   =  p.dealer__Parts_Master__c;
      PartInventoryId =  p.Id;
      PartName     =  p.Name;
      PartDescription =  p.dealer__Description__c;
      OnHand       =  p.dealer__On_Hand__c.intValue();
      OnOrder     =  p.dealer__On_Order__c.intValue();
      ListPrice     =  p.dealer__List__c;
      Cost     =  p.dealer__Cost__c;
      QTY       =  1;
      Order       =  0;
      Negative     =  0;
      
      SalePrice =  p.dealer__List__c;
      if(p.dealer__Static_Price__c!=null && p.dealer__Static_Price__c!=0) {
        SalePrice=p.dealer__Static_Price__c;
      }

      ExtendedTotal   =  SalePrice;
    }
  }

  /*
    Utility Methods
   */

  public String getPicklistValues() {

    // Make sure out parameters are set.
    if( trans == 'PicklistValues' &&
        urlParameters.get('object') != '' &&
        urlParameters.get('field') != '') {

      List<String> options = new List<String>();

      SObjectType accountType = Schema.getGlobalDescribe().get( urlParameters.get('object') );
      Map<String,Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();
      Schema.DescribeFieldResult fieldResult = mfields.get( urlParameters.get('field') ).getDescribe();
      List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
          
      for( Schema.PicklistEntry f : ple) {
        options.add( f.getValue() );
      } 

      return JSON.serializePretty(options);

    } else {
      return '{"error": "The PicklistValues method requires both an object api name and a field api name."}';
    }

  }


  public class ROException extends Exception{}  
}