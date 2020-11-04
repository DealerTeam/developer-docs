/**
 * ServiceRepairOrderAPI - Service Layer Encapsulation of interaction with the Repair Order Object.
 *
 * 
 */
global class ServiceRepairOrderAPI {

    /* Static Methods */
    global static Service_Repair_Order__c createRepairOrderFromDeal(Deal__c dealObject) {

        SavePoint sp = Database.setSavePoint();

        if(dealObject.Store_Location__c==NULL) {
            throw new ServiceRepairOrderAPIException('Deal must contain the Location Property to Create a Repair Order');
        }

        // Location Designate
        Dealer_Location__c location = [SELECT Id, Name, Company_Number__c, Service_Director__c FROM Dealer_Location__c WHERE Id=:dealObject.Store_Location__c ];

        // Instantiate the RO  
        Service_Repair_Order__c ro = new Service_Repair_Order__c();         

        ro.Company_Number__c    = location.Company_Number__c;
        ro.Company__c           = location.Id;
        ro.Create_Date_Time__c  = Datetime.now();
        ro.Vehicle_Inventory__c = dealObject.Vehicle__c;
        ro.Customer__c          = dealObject.Buyer__c;
        ro.Deal__c              = dealObject.Id;

        // Optional Parameters
        ro.Vehicle__c = dealObject.Service_Vehicle__c;
        ro.Mileage_In__c = dealObject.Mileage__c==null?0:dealObject.Mileage__c;
        ro.Service_Advisor__c = location.Service_Director__c; 

        // Create the Repair Order
        try {
            insert ro;
        } Catch(DmlException e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage()); 
        }

        // Update the Deal Record
        try {
            dealObject.DeliveryRepairOrder__c = ro.Id;
            update dealObject;
        } Catch(DmlException e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        // Create Job Lines
        List<Service_Job__c> svcJobs = ServiceRepairOrderAPI.createJobLinesFromDeal(dealObject);        

        return ro;     
    }

    /* Estimate Conversion Processing */
    global static Service_Repair_Order__c createRepairOrderFromEstimate(Service_Estimate__c estimateObject) {

        SavePoint sp = Database.setSavePoint();

        // Pre-req get data object
        Service_Repair_Order__c ro = new Service_Repair_Order__c();
        Map<Id, Service_Job__c> jobLinesByEstimateLineId = new Map<Id, Service_Job__c>();

        Service_Estimate__c se = new Service_Estimate__c();
        Map<Id, Service_Estimate_Line__c> seLines = new Map<Id, Service_Estimate_Line__c>();
        Map<Id, Service_Estimate_SubLine__c> seSubLines = new Map<Id, Service_Estimate_SubLine__c>();

        try {
            se = [SELECT Appraisal_VIN__c, Appraisal__c, Body_Type__c, Both_Keys_Fobs__c, 
                        Buy_Price__c, Comapny_Number__c, Company_Number__c, Company__c, 
                        Cosmetic_Notes__c, Current_MMR__c, Current_Mileage__c, Customer_Contact__c,
                        Customer__c, Days__c, Desired_Profit__c, Detail__c, Discount_Rate__c, 
                        Discount__c, EmailApprover__c, Estiamted_Profit__c, Estimate_Notes__c, 
                        Estimate_Total__c, Estimated_Pack__c, Finalized_By__c, Finish_Date__c, 
                        Inventory_Vehicle_VIN__c, Inventory_Vehicle__c, Navigation_Disc_SD_Installed__c, 
                        Owners_Manual__c, Parts_Sublet_Total__c, Safety__c, Service_Advisor__c, 
                        Service_Repair_Order__c, Service_Vehicle__c, Smog__c, Status__c, 
                        Store_Location__c, Store_Location__r.Name, Store_Location__r.Company_Number__c, Suggested_Retail_Price__c, Taxable__c, 
                        Transport_Damage_Description__c, Transport_Damage__c, VIN_Verified__c, 
                        Cosmetic_Total__c, Labor_to_Discount__c, Parts_to_Discount__c, 
                        Total_Labor_Charges__c, Total_Parts_Charges__c, Total_Sublet_Charges__c, 
                        Total_Tax__c, Total_Misc_Charges__c, LastActivityDate, LastViewedDate, CreatedDate, 
                        CreatedById, Name, OwnerId, Id, Company__r.Name, Company__r.Company_Number__c 
                        FROM Service_Estimate__c
                        WHERE Id=:estimateObject.Id
                        LIMIT 1];
            
            seLines = new Map<Id, Service_Estimate_Line__c>([SELECT Service_Estimate__c, Book_Time__c, Cosmetic_Estimate__c, Description__c,
                              Detail_Expense__c, Diagram_Reference_Number__c, Discount_Labor__c, 
                              Discount_Parts__c, Labor_Operation__c, Labor__c, Part_Description__c, 
                              Part_Item__c, Parts__c, Repair_Estimate__c, Repair_Type__c, 
                              Sub_Total__c, Sublet_Charges__c, Sublet_Work__c, Tax__c, 
                              Tire_QTY__c, Vendor__c, damageCoordinateX__c, damageCoordinateY__c, 
                              Status__c, Labor_Type__c, Line_Number__c, Line_Total__c, 
                              Labor_Operation__r.Name,
                              Misc_Charges__c, Id, Name,
                                (SELECT Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, 
                                    Labor_Rate__c, Book_Time__c, Part_Quantity__c, Part_Price__c, 
                                    Total_Part_Price__c, Part_Description__c, Part_Name__c, 
                                    Part_Price_List__c, Part_Cost__c, Labor_Total__c, Labor_Type__c, 
                                    Misc_Charge_Code__c, Misc_Charge_Amount__c, Misc_Charge_Description__c, 
                                    Name, Id FROM Service_Estimate_Sub_Lines__r)
                            FROM Service_Estimate_Line__c
                            WHERE Service_Estimate__c =:estimateObject.Id
                            LIMIT 200]);

            seSubLines = new Map<Id, Service_Estimate_SubLine__c>([SELECT Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, Labor_Rate__c, 
                                 Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, 
                                 Part_Description__c, Part_Name__c, Part_Price_List__c, Part_Cost__c, 
                                 Labor_Total__c, Labor_Type__c, Misc_Charge_Code__c, 
                                 Misc_Charge_Amount__c, Misc_Charge_Description__c, SystemGeneratedFor__c, Name, Id 
                            FROM Service_Estimate_SubLine__c
                            WHERE Service_Estimate_Line__c IN:seLines.keySet()]);
            

        } Catch(QueryException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        // Step #1, Create Header 
        try {
            if(se.Service_Repair_Order__c!=null) {
                ro = [SELECT Id, Name, RO_Number__c, Company__c, Parts_Invoice__c, Open_Job_Lines__c FROM Service_Repair_Order__c WHERE Id=:se.Service_Repair_Order__c LIMIT 1];
                // Check to see if we need to create a parts invoice

                // Does this RO have a Parts Invoice?  If not create one.
                if(se.Total_Parts_Charges__c>0 && ro.Parts_Invoice__c==null) {
                    Parts_Invoice__c pi = PartInvoiceAPI.createInvoice(
                        new Parts_Invoice__c(
                            Location__c = ro.Company__c,
                            Service_Repair_Order__c = ro.Id
                        )
                    ); 
                    ro.Parts_Invoice__c=pi.Id;
                    update ro;   
                }
                  
            } else {
                ro = ServiceRepairOrderAPI.createROHeaderFromEstimate(se);
            }
        } Catch(Exception e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        // Step #2, Create Job Lines
        try {
            for(Service_Job__c jl : ServiceRepairOrderAPI.createROJobLinesFromEstimate(ro, seLines.values())) {
                System.debug(jl);
                jobLinesByEstimateLineId.put(jl.External_ID__c, jl);
            }
        } Catch(Exception e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        // Step #3, Create Sub Lines, TechTime, Parts, Misc. 
        try {
            ServiceRepairOrderAPI.createROSubLinesFromEstimate(se, ro.Id, jobLinesByEstimateLineId, seSubLines.values());
        } Catch(Exception e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }
        
        //Calculate charges 
        ServiceRepairOrderAPI.calculateCharges(ro);
		        
        // Step #4, Record an activity that the Estimate Was converted.
        try {
            insert new Task(
                Subject='Estimate converted to Service Repair Order',
                ActivityDate=Date.today(),
                WhatId=se.Id,
                Status='Completed'
            );
        } Catch(DmlException e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());            
        }

        // Step #5, Set the Estimate to Accepted
        if( se.Service_Repair_Order__c == null ) { se.Service_Repair_Order__c=ro.Id; }
        se.Status__c='Accepted';

        try {
            update se;
        } Catch(DmlException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }        
        
        return ro;
    }
    
    public static List < Cashering__c > cashTransactions(String sroId) {
        return [SELECT Id, Customer__c, Credit_Card_Authorization_Code__c, Customer__r.Name, Payment_Method__c, Deposit__c, Amount__c,
            Rental_Agreement__r.Balance_Due__c, Rental_Agreement__r.TotalEstimatedCharges__c
            FROM Cashering__c WHERE Service_Repair_Order__c =: sroId ORDER BY CreatedDate DESC
        ];
    }
    
    public static void calculateCharges(dealer__Service_Repair_Order__c ro){
        
        system.debug('-----------> calculateCharges');
        
        Service_Repair_Order__c sro = [Select Company_Number__c, Company__c, Customer__c, Customer_Contact__c, Create_Date_Time__c, dealer__Parts_Cost__c, Internal_Labor_Charges__c, 
                                           Vehicle__c, Service_Advisor__c, Mileage_In__c, Status__c, Vehicle_Inventory__c, Tax__c, Customer_Misc_Charges__c,
                                           Customer_Pay_Parts__c, Customer_Pay_Labor__c, Customer_Labor_Charges__c, Customer_Charges__c, Taxable__c
                                           From Service_Repair_Order__c Where Id =: ro.Id];
        
        //Calculate Customer Charges
        sro.dealer__Customer_Labor_Charges__c = sro.dealer__Customer_Pay_Labor__c;
        sro.dealer__Customer_Parts_Charges__c = sro.dealer__Customer_Pay_Parts__c;
        sro.Customer_Charges__c = sro.Customer_Labor_Charges__c  + sro.Customer_Parts_Charges__c;

         // get the location based tax Settings
        if(sro.Company__c != null && sro.Taxable__c){
            
           Dealer_Location__c location = [SELECT Id, Name, Customer_Pay_Labor_Rate__c, LaborCost__c, Warranty_Labor_Rate__c, Internal_Labor_Rate__c,
                    Tax_Parts__c, Tax_Service__c, Tax_Local_Rate__c, Tax_Misc__c
                    FROM Dealer_Location__c WHERE Id=:sro.Company__c LIMIT 1];

            Decimal totalTax = 0;
            Boolean taxParts = location.Tax_Parts__c;
            Boolean taxLabor = location.Tax_Service__c;
            Decimal taxRate  = location.Tax_Local_Rate__c != null ? location.Tax_Local_Rate__c : 0;

            if ((taxParts || taxLabor) && taxRate >0 ) {

                if(taxParts && sro.Customer_Parts_Charges__c != null && sro.Customer_Parts_Charges__c > 0) {
                    totalTax += sro.Customer_Parts_Charges__c * ( taxRate / 100);
                }

                if(taxLabor  && sro.Customer_Labor_Charges__c != null && sro.Customer_Labor_Charges__c > 0) {
                    totalTax += sro.Customer_Labor_Charges__c * ( taxRate / 100);
                }

                if(sro.Customer_Sublet_Charges__c !=null && sro.Customer_Sublet_Charges__c>0) {
                    totalTax += sro.Customer_Sublet_Charges__c * (taxRate / 100);
                }
                
                if(location.Tax_Misc__c != null && location.Tax_Misc__c == 'All' && sro.Customer_Misc_Charges__c !=null && sro.Customer_Misc_Charges__c>0) {
                    totalTax += sro.Customer_Misc_Charges__c * (taxRate / 100);
                }

                if(location.Tax_Misc__c != null && location.Tax_Misc__c == 'Respect Misc. Charge Code Record' && sro.Customer_Misc_Charges__c !=null && sro.Customer_Misc_Charges__c>0) {
                    //W-002056 If location tax is set to respects misc charge code This checks every misc charge code against the current location and applies tax to each misc code that needs to be taxed- Josh C.
                    List<MiscChargeCode__c> miscChargeList = ServiceApI.miscChargeCodes(location.Id);
                    
                    if(miscChargeList != null && miscChargeList.size() > 0) {
                        
                        // we need to determine the taxableMiscTotal here
                        Decimal taxableMiscTotal = 0;
                        List <String> taxed= new List <String>();
                        
                        for(MiscChargeCode__c code: miscChargeList){
                            if(code.Active__c && code.Taxable__c){
                                if(Code.FlatAmount__c != null && Code.FlatAmount__c > 0){
                                    taxableMiscTotal += Code.FlatAmount__c;
                                } else {
                                    if(Code.PercentageBasedAmount__c != null && code.PercentageBasedAmount__c > 0) {
                                        Decimal maxAmount = code.MaximumCharge__c;
                                        Decimal charge = 0;
                                        if(code.BaseCharge__c == 'Labor Sale' && taxed.contains(code.id) != true ){
                                            //logic to get the percentagebased amount from labor sale price
                                            charge =  sro.dealer__Customer_Pay_Labor__c * (code.PercentageBasedAmount__c / 100);
                                            taxed.add(code.Id);
                                        }
                                        if(code.BaseCharge__c == 'Labor Cost' && taxed.contains(code.id) != true  ){
                                            //logic to get the percentagebased amount from labor Cost price
                                            charge =  sro.dealer__Internal_Labor_Charges__c   * (code.PercentageBasedAmount__c / 100);
                                            taxed.add(code.Id);
                                        }
                                        if(code.BaseCharge__c == 'Parts Sale' && taxed.contains(code.id) != true){
                                            //logic to get the percentagebased amount from Parts sale price
                                            charge =  sro.dealer__Customer_Pay_Parts__c   * (code.PercentageBasedAmount__c / 100);
                                            taxed.add(code.Id);
                                        }
                                        if(code.BaseCharge__c == 'Parts Cost' && taxed.contains(code.id) != true){
                                            //logic to get the percentagebased amount from Parts Cost price
                                            charge =  sro.dealer__Parts_Cost__c  * (code.PercentageBasedAmount__c / 100);
                                            taxed.add(code.Id);
                                        }   
                                        taxableMiscTotal += maxAmount != null && charge > maxAmount ? maxAmount : charge;
                                    }                
                                }
                            }     
                        }
                        //IF There is a max charge, don't exceed it:
                        totalTax += taxableMiscTotal * (taxRate / 100);
                    }   
                }
            }
            
            sro.Tax__c = totalTax.setScale(2, System.RoundingMode.HALF_UP);
        }
        
        try{
            update sro;
        }catch(Exception e){
            system.debug('Error updating SRO charges ' + e.getMessage());
        }
    }

    /* Method for creation of the RO Header call ed by the createRepairOrderFromEstimate Method */
    private static Service_Repair_Order__c createROHeaderFromEstimate(Service_Estimate__c se) {
        
        // Transaction Control.
        SavePoint sp = Database.setSavePoint();

        // Instantiate Header Level Object Record
        Service_Repair_Order__c s = new Service_Repair_Order__c();
        s.Company_Number__c  = se.Store_Location__r.Company_Number__c;//tk999
        s.Company__c = se.Store_Location__c;
        s.Customer__c = se.Customer__c;
        s.Customer_Contact__c = se.Customer_Contact__c;
        s.Create_Date_Time__c= DateTime.now();
        s.Vehicle__c = se.Service_Vehicle__c;
        s.Service_Advisor__c = UserInfo.getUserId();
        s.Mileage_In__c = (se.Current_Mileage__c!=null) ? se.Current_Mileage__c : 0; 
        s.Status__c = 'Open';
        s.Vehicle_Inventory__c = se.Inventory_Vehicle__c;

        try {

            if (!Schema.sObjectType.Service_Repair_Order__c.fields.Name.isUpdateable()) {
                throw new ServiceRepairOrderAPIException('User does not have permission to Create a Service Repair Order');
            }            

            insert s;

        } Catch(DmlException e) {
            Database.rollback(sp);
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }
        // If we have Parts, create the Parts Invoice.
        Parts_Invoice__c pi = new Parts_Invoice__c();
        if(se.Total_Parts_Charges__c>0) {
            try { 
                pi.Service_Repair_Order__c = s.Id;
                pi.Location__c = se.Store_Location__c;
                pi = PartInvoiceAPI.createInvoice(pi);

            } Catch(DmlException e) {
                throw new ServiceRepairOrderAPIException(e.getMessage());
            } Catch(Exception e) {
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }  

        if(pi.Id!=null) {
            s.Parts_Invoice__c=pi.Id;
            try{
                update s; 
            } catch (DmlException e){
                throw new ServiceRepairOrderAPIException(e.getMessage());
                database.rollback(sp);
            }
        }
        return s;
    }

    private static List<Service_Job__c> createROJobLinesFromEstimate(Service_Repair_Order__c ro, List<Service_Estimate_Line__c> estLines) {
        List<Service_Job__c> jobLines = new List<Service_Job__c>();

        // Get the line count size.
        AggregateResult[] arcount = [SELECT Count(Id) lineCount FROM Service_Job__c WHERE Service_Repair_Order__c=:ro.Id];
        Integer lineNumber = (Integer)arcount[0].get('lineCount');

        // Set the external ID for post processing transaction reference by Estimate ID
        for(Service_Estimate_Line__c el : estLines) {
            lineNumber++;
            Service_Job__c job = new Service_Job__c(
                Name=ro.Name+'-'+lineNumber,
                Service_Repair_Order__c=ro.Id,
                Standard_Operation_Code__c=el.Labor_Operation__c,
                Op_Code__c=(el.Labor_Operation__c!=null) ? el.Labor_Operation__r.Name.left(64) : '',
                Op_Description__c=(el.Labor_Operation__c!=null) ? el.Labor_Operation__r.Name.left(255) : '',
                Concern__c=(el.Description__c!=null) ? el.Description__c.left(255) : '',
                CustomerConcern__c=(el.Description__c!=null) ? el.Description__c.left(3200) : '',
                Labor_Type__c=el.Labor_Type__c,
                Stat__c=el.Status__c,
                External_ID__c=el.Id,
                Service_Estimate_Line_Creator__c=el.Id,
                Line_Number__c=lineNumber
            );
            jobLines.add(job);
        }

        // Check the List Size and Create
        if(!jobLines.isEmpty()) {
            try {
                insert jobLines;
                return jobLines;
            } Catch(DmlException e) {
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }

        return jobLines;
    }

    private static void createROSubLinesFromEstimate(Service_Estimate__c est, Id roId, Map<Id, Service_Job__c> jobsByEstimateId, List<Service_Estimate_SubLine__c> subLines) {
        // Process Each Line and place labor, parts and misc.
        // Each job line is in a map with the estimate Id as a method of reference
        
        // Create map of JobLineId to Service_Job_ID
        // EstimateLine, JobLine
        Map<Id, Service_Job__c> jobMap = new Map<Id, Service_Job__c>();

        // RO Object Details
        Service_Repair_Order__c sro = new Service_Repair_Order__c();
        try {
            sro = [SELECT Id, Name, Parts_Invoice__c FROM Service_Repair_Order__c WHERE Id=:roId];
        } Catch(QueryException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        } 

        for(Service_Estimate_SubLine__c subl : subLines) {
            if(jobsByEstimateId.get(subl.Service_Estimate_Line__c)==null) {
                throw new ServiceRepairOrderAPIException('Exception attempting to set the jobMap by JobEstimateId');
            }
            jobMap.put(subl.Id, jobsByEstimateId.get(subl.Service_Estimate_Line__c));
        }

        // Pre-process parts lines based on Parts Master
        // if we have sublines with type == parts, collect the master Id's
        // ensure we have location aware parts for these id's.
        Set<Id> masterIds = new Set<Id>();
        List<Parts_Master__c> partMaster = new List<Parts_Master__c>();

        Map<Id, Id> locationParts = new Map<Id, Id>();
        for(Service_Estimate_SubLine__c sbl : subLines) {
            if(sbl.Line_Type__c=='Parts' && sbl.Parts_Master__c!=null) {
                if(!masterIds.contains(sbl.Parts_Master__c)) {
                    masterIds.add(sbl.Parts_Master__c);
                    partMaster.add(new Parts_Master__c(Id=sbl.Parts_Master__c));
                }
            }
        }

        // Create Inventory from the master Id
        Map<Id, Parts_Inventory__c> partsMap = new Map<Id, Parts_Inventory__c>();
        if(!partMaster.isEmpty()) {
            partsMap = PartAPI.createInventoryFromMaster(partMaster, est.Store_Location__c);
        }
        
        List<Technician_Job_Time__c> techLines = new List<Technician_Job_Time__c>();
        List<Parts_Invoice_Line__c> partsLines = new List<Parts_Invoice_Line__c>();
        List<Service_Misc_Charge__c> miscCharges = new List<Service_Misc_Charge__c>();

        for(Service_Estimate_SubLine__c sl : subLines) {

            // Process the Tech Times
            if(sl.Line_Type__c=='Labor') {
                try {
                    techLines = ServiceRepairOrderAPI.createLaborLinesFromEstimate(jobMap.get(sl.Id).Id, sl, techLines);
                } Catch(Exception e) {
                    throw new ServiceRepairOrderAPIException(e.getMessage());
                }
            }

            // Process the Parts Lines
            if(sl.Line_Type__c=='Parts') {
                try {
                    partsLines = ServiceRepairOrderAPI.createPartsLinesFromEstimate(sro, partsMap, jobMap.get(sl.Id), sl, partsLines);
                } Catch(Exception e) {
                    throw new ServiceRepairOrderAPIException(e.getMessage());
                }
            }

            // Process the Misc. Lines
            if(sl.Line_Type__c=='Miscellaneous') {
                try {
                    miscCharges = ServiceRepairOrderAPI.createMiscLinesFromEstimate(jobMap.get(sl.Id).Id, sl, miscCharges);
                } Catch(Exception e) {
                    throw new ServiceRepairOrderAPIException(e.getMessage());
                }
            }

        }

        // Transaction Control, multistep insert
        SavePoint sp = Database.setSavePoint();

        // Process Labor Lines
        System.debug(Limits.getQueries());
        if(!techLines.isEmpty()) {
            try {
                insert techLines;
            } Catch(DmlException e) {
                Database.rollback(sp);
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }

        // Process Parts Lines
        if(!partsLines.isEmpty()) {
            try {
                PartInvoiceAPI.addInvoiceLines(partsLines);
            } Catch(Exception e) {
                Database.rollback(sp);
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }

        System.debug(Limits.getQueries());
        // Process Misc Lines
        if(!miscCharges.isEmpty()) {
            try {
                insert miscCharges;
            } Catch(DmlException e) {
                Database.rollback(sp);
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }

    }

    /* Adds to a list of Technician Times based on Estimate SubLine */
    private static List<Technician_Job_Time__c> createLaborLinesFromEstimate(Id jobId, Service_Estimate_SubLine__c subLine, List<Technician_Job_Time__c> addList) {
        
        // Get the subLine based on the map

        
        // Instantiate labor line
        Technician_Job_Time__c tt = new Technician_Job_Time__c(
            Service_Job_Line__c=jobId,
            Service_Estimate_Subline_Creator__c=subLine.Id,
            Book_Time_Entry__c=subLine.Book_Time__c,
            Actual_Time_Entry__c=subLine.Book_Time__c,
            Payment_Method_Labor_Rate__c=subLine.Labor_Rate__c,
            Labor_Total__c=(subLine.Book_Time__c!=null&&subLine.Labor_Rate__c!=null) ? (subLine.Book_Time__c*subLine.Labor_Rate__c) : 0
            // Parent_Record__c=subLine.Id
        );

        // add to labor line list
        addList.add(tt);

        return addList;
    }

    private static List<Parts_Invoice_Line__c> createPartsLinesFromEstimate(Service_Repair_Order__c ro, Map<Id, Parts_Inventory__c> partMap, Service_Job__c job, Service_Estimate_SubLine__c subLine, List<Parts_Invoice_Line__c> addList) {
		
        System.assert(partMap.get(subLine.dealer__Parts_Master__c)!=null, 'Part Inventory Record not found');
        System.assert(job.Id!=null, 'Job Line ID must be provided.');
        System.assert(job.Line_Number__c!=null, 'Job Line Number must be provided.');

        Decimal onHand = (partMap.get(subLine.dealer__Parts_Master__c).On_Hand__c == null) ? 0 : partMap.get(subLine.dealer__Parts_Master__c).On_Hand__c;
        Decimal qtySold = (subLine.Part_Quantity__c != null) ? subLine.Part_Quantity__c : 0;

        /*
            On Hand     Sol     Order   Formula
            1           1       0       On Hand - Sold
            2           1       1       On Hand - Sold
            -1          1       1       if(On hand < 0) Sold
        */

        Decimal orderCount = 0;
        if((qtySold - onHand) > 0) { orderCount = qtySold - onHand; }
        if(onHand < 0) { orderCount = qtySold; }

        // Line Number
        Decimal lineNumber = addList.size() + 1;

        Parts_Invoice_Line__c pil = new Parts_Invoice_Line__c(
            Name=ro.Name+'-'+String.valueOf(job.Line_Number__c),
            Parts_Invoice__c=ro.Parts_Invoice__c,
            Service_Repair_Order__c=ro.Id,
            Job_Line__c=job.Id,
            Service_Estimate_Subline_Creator__c=subLine.Id,
            Price__c=subLine.Part_Price__c,
            Part__c=partMap.get(subLine.dealer__Parts_Master__c).Id,
            Quantity_Ordered__c=orderCount,
            Quantity_Sold__c=qtySold,
            Sold_Via__c='Estimate'
        );

        addList.add(pil); 

        return addList;
    }

    private static List<Service_Misc_Charge__c> createMiscLinesFromEstimate(Id jobId, Service_Estimate_SubLine__c subLine, List<Service_Misc_Charge__c> mLines) {
       
        Service_Misc_Charge__c m = new Service_Misc_Charge__c(
            Service_Job_Lines__c=jobId,
            Service_Estimate_Subline_Creator__c=subLine.Id,
            Code__c=subLine.Misc_Charge_Code__c,
            Description__c=subLine.Misc_Charge_Description__c,
            Amount__c=subLine.Misc_Charge_Amount__c,
            Type__c=subLine.Misc_Charge_Code__c,
            Technician_Job_Time_Creator__c=(subLine.SystemGeneratedFor__c != null && subLine.SystemGeneratedFor__c.getSobjectType() == Service_Job__c.sObjectType) ? subLine.SystemGeneratedFor__c : null
        );

        mLines.add(m);

        return mLines;
    }


    /*
        This method will create job lines from aftermarket items.  

            1) Kit's result in a single line with labor(x) and part(x)
            2) Labor AfterMarket items result in stand alone lines with Labor.
            3) Parts result in stand alone parts lines
            4) Sublet lines result in stand alone lines

    */
    global static List<Service_Job__c> createJobLinesFromDeal(Deal__c dealObject) {

        try {
            system.assert(dealObject.DeliveryRepairOrder__c!=null);
        } Catch(Exception e) {
            throw new ServiceRepairOrderAPIException('createJobLinesFromDeal requires a Repair Order to exists related to the Deal.');
        }
        
        // This method performs a number of steps to handle the creation of Job Lines from the related AfterMarket Lines.
        // Get the Repair Order after the method is loaded as the method is global and can not be redfined.
        Service_Repair_Order__c ro = [SELECT Id, Name, RO_Number__c FROM Service_Repair_Order__c WHERE Id=:dealObject.DeliveryRepairOrder__c LIMIT 1];
        dealer__StandardOpCode__c[] defaultLaborOp = [SELECT Id, Name, Op_Code_Description__c FROM dealer__StandardOpCode__c WHERE Active__c = true AND Default__c = true LIMIT 1];

        // Get the required values
        List<After_Market__c> lines = [SELECT Car_Deal__c, Company_Number__c, Cost__c, Description__c, Labor_Sale__c, Labor_Cost__c,  Part_Cost__c,
                                            List_Price__c, Parts_Kit__c, Parts_Sale__c, Sale_Price__c, Vendor__c, 
                                            Labor_Hours__c, Taxable__c, Gross__c, Part__c,
                                            Id, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById
                                         FROM dealer__After_Market__c 
                                         WHERE dealer__Car_Deal__c=:dealObject.Id 
                                         LIMIT 200];

        // Create a Line for Each Kit, and AfterMarket Entry
        List<Service_Job__c> jobs = new List<Service_Job__c>();
        List<Service_Job__c> kitJobs = ServiceRepairOrderAPI.jobLinesByKit(lines);                                        
        List<Service_Job__c> laborOnly = ServiceRepairOrderAPI.jobLinesByLabor(lines);
        List<Service_Job__c> subletOnly = ServiceRepairOrderAPI.jobLinesBySublet(lines);
        List<Service_Job__c> partsOnly = ServiceRepairOrderAPI.jobLinesByPart(lines);
        // Working Container
        List<Service_Job__c> aJobs = new List<Service_Job__c>();

        if(kitJobs != null && !kitJobs.isEmpty()) { aJobs.addAll(kitJobs); }
        if(laborOnly != null && !laborOnly.isEmpty()) { aJobs.addAll(laborOnly); }
        if(subletOnly !=null && !subletOnly.isEmpty()) { aJobs.addAll(subletOnly); }
        if(partsOnly != null && !partsOnly.isEmpty()) { aJobs.addAll(partsOnly); }

        if(aJobs.isEmpty()) {
            return null;
        }

        Decimal jNumber = 1;
        for(Service_Job__c sj : aJobs) {
            sj.Line_Number__c = jNumber;
            sj.Service_Repair_Order__c=ro.Id;
            if(!defaultLaborOp.isEmpty()) {
                sj.Standard_Operation_Code__c=defaultLaborOp[0].Id;
                sj.Op_Code__c = defaultLaborOp[0].Name;
                sj.Op_Description__c = defaultLaborOp[0].Op_Code_Description__c;
            }

            jobs.add(sj);
            jNumber++;
        }

        try {
            insert jobs;
        } Catch(DmlException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        System.debug(jobs);

        // Link assocated Labor from Kit Lines and Labor Sales
        ServiceRepairOrderAPI.linkTechTime(lines, jobs);
        ServiceRepairOrderAPI.linkPartRecords(lines, jobs);

        return jobs;
    }

    private static void linkPartRecords(List<After_Market__c> amlines, List<Service_Job__c> jobs){

        // This method takes the parts sold via Deals and associates them to the Job Line
        Map<Id, Service_Job__c> jobMap = new Map<Id, Service_Job__c>();
        // Set Map
        for(Service_Job__c sj : jobs) {
            if(sj.Parent_Record__c != null && jobMap.get(sj.Parent_Record__c)==null) {
                jobMap.put(sj.Parent_Record__c, sj);
            }
        }

        // Map of Part Data for Sale Line
        Set<Id> partIds = new Set<Id>();
        for(After_Market__c am : amlines) { 
            if(am.Part__c!=null && !partIds.contains(am.Part__c)) {
                partIds.add(am.Part__c);
            }
        }

        if(partIds.isEmpty()){
            return;
        }

        // Check to see if we have a Parts Invoice 
        Service_Repair_Order__c existingRO = [SELECT Id, Name, Parts_Invoice__c, Company__c, RO_Number__c FROM Service_Repair_Order__c WHERE Id=:jobs[0].Service_Repair_Order__c LIMIT 1];
        Parts_Invoice__c pinv = new Parts_Invoice__c();
        if(existingRO.Parts_Invoice__c==null) {
            pinv = ServiceRepairOrderAPI.createDeliveryROPartInvoice(existingRO);
        } else {
            pinv.Id=existingRO.Parts_Invoice__c;
        }


        Map<Id, Parts_Inventory__c> partsInventory = new Map<Id, Parts_Inventory__c>([SELECT Best_Stocking_Level__c, Bin_2__c, Bin__c, Comments__c, 
                                                                                        Comp__c, Company_Number__c, Core__c, Cost__c, Description__c, 
                                                                                        Detail__c, Entry_Date__c, Extended_Description__c, Extra_Days__c, 
                                                                                        Gross_Margin__c, Group__c, High_Days__c, High_Year__c, Illustration__c, 
                                                                                        Jobber__c, Kit__c, Last_Sale_Date__c, List__c, Low_Days__c, 
                                                                                        Low_Year__c, MFG__c, Max__c, Min__c, Minimum_Margin__c, On_Back_Order__c, 
                                                                                        On_Hand__c, On_Order__c, On_Special_Order__c, Online_Store_Id__c, PNC__c, 
                                                                                        Pack_QTY__c, Part_No__c, Parts_Master__c, Price_Update__c, Raw_Part_Number__c, 
                                                                                        Re_Order_Point__c, Remarks__c, Reserved__c, Return_Code__c, Source_List__c, 
                                                                                        Source__c, Static_Price__c, Status__c, Stocking_Group__c, Tax_Exempt__c, 
                                                                                        Trade__c, UPC__c, Warranty__c, Weight__c, Location__c, Part_Number__c, Id, Name 
                                                                                            FROM Parts_Inventory__c 
                                                                                            WHERE Id IN:partIds]);

        // Iterate the AfterMarket Lines
        List<Parts_Invoice_Line__c> pLines = new List<Parts_Invoice_Line__c>();
        for(After_Market__c am : amlines) {
            if(am.Part__c != null) {

                Service_Job__c referencedJob = new Service_Job__c();
                if(jobMap.get(am.Id)!=null)
                    referencedJob=jobMap.get(am.Id);
                
                if(jobMap.get(am.Parts_Kit__c)!=null)
                    referencedJob=jobMap.get(am.Parts_Kit__c);

                System.assert(referencedJob.Id!=null);

                Parts_Invoice_Line__c pi = new Parts_Invoice_Line__c();  
                // Referenced Header Records
                pi.Parts_Invoice__c = pinv.Id; 
                pi.Service_Repair_Order__c = referencedJob.Service_Repair_Order__c;

                // Referenced Part Record
                pi.Part__c          = partsInventory.get(am.Part__c).Id;
                pi.List__c          = partsInventory.get(am.Part__c).List__c;
                pi.Price__c         = am.Part_Cost__c;
                pi.Core__c          = 0;
                pi.Cost__c          = 0;
                pi.Bin__c           = partsInventory.get(am.Part__c).Bin__c;
                pi.Counterman__c    = UserInfo.getUserId();
                pi.Sale_Date__c     = Date.today();
                pi.Part_Number__c   = partsInventory.get(am.Part__c).Part_No__c;
                pi.Part_Description__c  =   partsInventory.get(am.Part__c).Description__c;
                pi.Quantity_Sold__c     =   0;
                pi.Source__c            =   partsInventory.get(am.Part__c).Source__c;
                pi.Sold_Via__c          =   'Get-Ready Repair Order';
                pi.Job_Line__c          =   referencedJob.Id;

                pLines.add(pi);
                                 
            }
        }

        try {
            insert pLines;
        } Catch(DmlException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

    }

    private static Parts_Invoice__c createDeliveryROPartInvoice(Service_Repair_Order__c ro) {
        
        // Invoice Header
        Parts_Invoice__c pinv = new Parts_Invoice__c(
            Location__c = ro.Company__c,
            Name=ro.Name, 
            Service_Repair_Order__c=ro.Id,
            Invoice_Number__c= 'RO'+ro.RO_Number__c
        );
        
        try {
            insert pinv;
            ro.Parts_Invoice__c=pinv.Id;
            update ro;
        } Catch(DmlException e) {
            throw new ServiceRepairOrderAPIException(e.getMessage());
        }

        return pinv;
    }

    private static void linkTechTime(List<After_Market__c> amlines, List<Service_Job__c> jobs) {
        // Maps of Jobs by parent Id
        Map<Id, Service_Job__c> jobsByKitId = new Map<Id, Service_Job__c>();
        Map<Id, Service_Job__c> jobsByAMId = new Map<Id, Service_Job__c>();

        // Set Maps by value 
        Schema.DescribeSObjectResult pKit = Parts_Kit__c.sObjectType.getDescribe();
        Schema.DescribeSObjectResult amLine = After_Market__c.sObjectType.getDescribe();
        String partsKitKeyPrefix = pKit.getKeyPrefix();
        String afterMarketKeyPrefix = amLine.getKeyPrefix(); 
        for(Service_Job__c jline : jobs) {

            if(jline.Parent_Record__c != null && jline.Parent_Record__c.left(3)==partsKitKeyPrefix) {
                if(jobsByKitId.get(jline.Parent_Record__c)==null) {
                    jobsByKitId.put(jline.Parent_Record__c, jline);
                }
            }   

            if(jline.Parent_Record__c != null && jline.Parent_Record__c.left(3)==afterMarketKeyPrefix) {
                if(jobsByAMId.get(jline.Parent_Record__c)==null) {
                    jobsByAMId.put(jline.Parent_Record__c, jline);
                }
            } 
        }

        List<Technician_Job_Time__c> tjt = new List<Technician_Job_Time__c>();
        for(After_Market__c am : amlines) {
            // Iterate AM Lines that are sold via Kit
            if(am.Parts_Kit__c!=null && am.Name == 'Labor') {
                Technician_Job_Time__c tt = new Technician_Job_Time__c();
                tt.Service_Job_Line__c=jobsByKitId.get(am.Parts_Kit__c).Id;
                tt.Date__c=Date.today();
                tt.Book_Time_Entry__c=am.Labor_Hours__c;
                tt.Labor_Total__c=am.Labor_Cost__c;
                tjt.add(tt);
            }

            // Iterate AM Lines that are sold via Labor Only
            if(am.Parts_Kit__c==null && am.Name == 'Labor') {
                Technician_Job_Time__c tt = new Technician_Job_Time__c();
                tt.Service_Job_Line__c=jobsByAMId.get(am.Id).Id;
                tt.Date__c=Date.today();
                tt.Book_Time_Entry__c=am.Labor_Hours__c;
                tt.Labor_Total__c=am.Labor_Cost__c;
                tjt.add(tt);                
            }
        }

        if(!tjt.isEmpty()) {
            try {
                insert tjt;
            } Catch(DmlException e) {
                throw new ServiceRepairOrderAPIException(e.getMessage());
            }
        }
    }

    private static List<Service_Job__c> jobLinesByLabor(List<After_Market__c> amlines) {
        List<Service_Job__c> jobs = new List<Service_Job__c>();
        for(After_Market__c am : amlines) {
            if(am.Parts_Kit__c==null && am.Name == 'Labor') {
                Service_Job__c thisJob = new Service_Job__c();
                thisJob.Service_Type__c='MR';
                thisJob.Labor_Type__c='I';
                thisJob.CustomerConcern__c = am.Description__c;
                thisJob.Parent_Record__c=am.Id;  

                jobs.add(thisJob);              
            }
        }
        return jobs;
    }

    private static List<Service_Job__c> jobLinesBySublet(List<After_Market__c> amlines) {
        List<Service_Job__c> jobs = new List<Service_Job__c>();
        for(After_Market__c am : amlines) {
            if(am.Parts_Kit__c==null && am.Name == 'Sublet') {
                Service_Job__c thisJob = new Service_Job__c();
                thisJob.Service_Type__c='MR';
                thisJob.Labor_Type__c='I';
                thisJob.CustomerConcern__c = am.Description__c +'\r\n Sale Price: '+am.Sale_Price__c + '\r\n Allowance: ' +am.Cost__c;
                thisJob.Parent_Record__c=am.Id;  

                jobs.add(thisJob);                 
            }
        }
        return jobs;
    } 

    private static List<Service_Job__c> jobLinesByPart(List<After_Market__c> amlines) {
        List<Service_Job__c> jobs = new List<Service_Job__c>();
        for(After_Market__c am : amlines) {
            if(am.Parts_Kit__c==null && am.Part__c!=null) {
                Service_Job__c thisJob = new Service_Job__c();
                thisJob.Service_Type__c='MR';
                thisJob.Labor_Type__c='I';
                thisJob.CustomerConcern__c = am.Description__c;
                thisJob.Parent_Record__c=am.Id;      

                jobs.add(thisJob);             
            }
        }
        return jobs;
    }           

    private static List<Service_Job__c> jobLinesByKit(List<After_Market__c> amlines) {

        // Sanity Check
        if(amlines.isEmpty())
            return null;

        // Return List
        List<Service_Job__c> jobs = new List<Service_Job__c>();

        // Capture kit items
        Map<Id, List<After_Market__c>> kits = new Map<Id, List<After_Market__c>>();
        for(After_Market__c am : amlines) {
            // Do we have a kit item
            if(am.Parts_Kit__c!=null) {
                List<After_Market__c> namList = new List<After_Market__c>();
                if(kits.get(am.Parts_Kit__c)!=null) {
                    namList = kits.get(am.Parts_Kit__c);
                }                    
                namList.add(am);
                kits.put(am.Parts_Kit__c, namList);
            }
        }

        Map<Id, Parts_Kit__c> kitData = new Map<Id, Parts_Kit__c>([SELECT Id, Name, Description__c FROM Parts_Kit__c WHERE Id IN:kits.keySet()]);

        // Now that we have Kits isolated create jobs
        for(Id kitId : kits.keySet()) {
            Service_Job__c thisJob = new Service_Job__c();
            thisJob.Service_Type__c='MR';
            thisJob.Labor_Type__c='I';
            thisJob.CustomerConcern__c = kitData.get(kitId).Description__c;
            thisJob.Parent_Record__c=kitId;
            jobs.add(thisJob);
        }

        return jobs;
    }



    global class ServiceRepairOrderAPIException extends Exception {}


    /*!~--- Lightning Methods --------*/
    
    @AuraEnabled
    public static List<Service_Repair_Order__c> findRecent() {
        return [Select Id, Name, Status__c, RO_Number__c from Service_Repair_Order__c order by LastModifiedDate DESC limit 20];    
    }
    
    @AuraEnabled
    public static List<Service_Repair_Order__c> findRoByName(String searchContext) {
        String nameSearch = '%'+searchContext+'%';
        return [Select Id, Name, Status__c, RO_Number__c from Service_Repair_Order__c where Name like :nameSearch limit 500];
    }
    
    @AuraEnabled
    public static Service_Repair_Order__c findById(Id roId) {
        return [Select Id, Name, Status__c, RO_Number__c from Service_Repair_Order__c where Id=:roId limit 1];        
    }
}