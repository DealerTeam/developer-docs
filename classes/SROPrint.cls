/**
*   SROPrint - controls the printing of Service Repair Orders. 
*               This file is used both by managed and non-managed code.
*
*/
global with sharing class SROPrint{

    global Service_Repair_Order__c ro {get;set;}
    global Dealer_Location__c userLoc = new Dealer_Location__c();
    global Dealer_Location__c locInfo = new Dealer_Location__c();
    global Vehicle_Inventory__c Vehicle {get; set;}
    global Id loc {get; set;}

    @deprecated
    global List<Id>  jLineIds = new List<Id>(); // Added back to fix metadta veriication

    /**
     *  Controller 
     */
    global SROPrint(ApexPages.StandardController controller) {

        // Get Record
        vehicle = new Vehicle_Inventory__c();
        ro   =  (Service_Repair_Order__c)controller.getRecord();
        loc = [SELECT Company__c FROM Service_Repair_Order__c WHERE Id=:ro.Id].Company__c;

        Service_Repair_Order__c currentSro = [Select id, name, Vehicle_Inventory__c from Service_Repair_Order__c where id =: ro.id];
       
        if(currentSro.Vehicle_Inventory__c != null)
        {
            vehicle = [Select id, name, vin__c, Year__c, make__c, model__c, license__c, Stock_Number__c from Vehicle_Inventory__c where id =:currentSro.Vehicle_Inventory__c];
        }

        String userId = UserInfo.getUserId();
        String userLocKey = [SELECT Division FROM User WHERE Id =: userId LIMIT 1].Division;

        if(userLocKey!=null&&userLocKey!='') {
            list<Dealer_Location__c>    userLocResult = [SELECT Id, Name, Street__c, City__c, Company_Number__c, 
                                                            Main_Phone__c, Postal_Code__c, State__c, Website__c, 
                                                            BAR_Number__c, EPA_Number__c, Tax_ID__c, Service_RO_Disclaimer__c, Company_Contracting_Name__c 
                                                        FROM Dealer_Location__c 
                                                        WHERE Company_Number__c =: userLocKey 
                                                        LIMIT 1];

            if(userLocResult.size()==1) {
            userLoc=userLocResult[0];
            }
        } else {
            userLoc = null;
        }    


    }

    global Dealer_Location__c getuserLoc() {
        return userLoc;
    }
    
    global Dealer__Dealer_Location__c getlocInfo(){
        
        locInfo = [SELECT Id, Name, Company_Contracting_Name__c, Street__c, City__c, State__c, Postal_Code__c, Website__c, Main_Phone__c, BAR_Number__c, EPA_Number__c
                  FROM Dealer__Dealer_Location__c where Id =: loc];
        return locInfo;
    }

    global Decimal total_hazmat {
        get {
            AggregateResult[] sum_hazmat = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Hazardous Materials'];
            Decimal t = (Decimal)sum_hazmat[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }

    global Decimal total_shop {
        get {
            AggregateResult[] sum_shop = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Shop Supplies'];
            Decimal t = (Decimal)sum_shop[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }

    global Decimal total_freight {
        get {
            AggregateResult[] sumf = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Freight'];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    } 

    global Decimal total_sublet {
        get {
            AggregateResult[] sumf = [Select SUM(Sublet_Total__c) line From Service_Job__c where Service_Repair_Order__c=:ro.Id];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }        

    global Decimal total_sublet_w {
        get {
            AggregateResult[] sumf = [Select SUM(Sublet_Total__c) line From Service_Job__c where Service_Repair_Order__c=:ro.Id AND Labor_Type__c = 'W'];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }  

    global Decimal total_sublet_cust {
        get {
            AggregateResult[] sumf = [Select SUM(Sublet_Total__c) line From Service_Job__c where Service_Repair_Order__c=:ro.Id AND Labor_Type__c = 'C'];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }

    global Decimal total_hazmat_w {
        get {
            AggregateResult[] sum_hazmat = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Hazardous Materials'
                    and Payment_Type__c = 'W'];
            Decimal t = (Decimal)sum_hazmat[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }

    global Decimal total_shop_w {
        get {
            AggregateResult[] sum_shop = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Shop Supplies'
                    and Payment_Type__c = 'W'];
            Decimal t = (Decimal)sum_shop[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    }

    global Decimal total_freight_w {
        get {
            AggregateResult[] sumf = [Select SUM(Amount__c) line 
                    FROM Service_Misc_Charge__c
                    where Repair_Order_ID__c =:ro.Id
                    and Type__c = 'Freight'
                    and Payment_Type__c = 'W'];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
        }   
        set;
    } 
        
    global Decimal total_payments {
        get {

            AggregateResult[] sumf = [Select SUM(Amount__c) line 
                    FROM Cashering__c
                    where Service_Repair_Order__c = :ro.Id 
                    and deposit__c = false
                    and Amount__c != null];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);

        }
        set;
    }

    //tk 
    global List<Cashering__c> payment_details{
        get{
            List<Cashering__c> c = [SELECT Name, Id, Customer__r.Name, Payment_Method__c,Amount__c,
                            Customer__c,Deal__c,Service_Repair_Order__c,
                            Close_Date__c
                            FROM Cashering__c
                            WHERE Service_Repair_Order__c =: ro.Id];
                            
                            return c;
        }
        set;
    }

    global string printDateTime { 
            get {
                datetime dt = datetime.now();
                return dt.format('MM/dd/yyyy HH:mm a');
            }
    }    


     global String getInvoiceLogo() {
     
        Id recordId = ro.id;
        if(loc != null){
            return DealershipLocationAPI.formLogoURL(loc);
        }else{
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
    }

    /*
     *  Get Job Lines
     * 
     *      Params: ro.Id
     */
    global List<Service_Job__c> getServiceJobList() {
        List<Service_Job__c> jLines = new List<Service_Job__c>();
        if(ro.Id!=null) {
            jLines = [Select Id, Labor_Type__c, Labor_Rate__c,Actual_Time__c, Labor_Charges__c,     Misc_Charges__c, 
                           Cause__c, CauseExtended__c, Concern__c, CustomerConcern__c, Correction__c,
                            Op_Code__c, Line_Total__c, Parts_Total__c, Service_Type__c, Line_Number__c,
                            Operation_Code_Description__c, Stat__c, Technician__c, Book_Time__c ,
                            Sublet_Total__c,
                                (SELECT Id, Name, Service_Job_Line__c, Actual_Time_Entry__c, Actual_Time__c, 
                                Book_Time__c, Labor_Cost__c, Labor_Total__c, Labor_Type__c, 
                                Job_Status__c, Job_Name__c, Technician__c, Technician__r.Name ,
                                Book_Time_Entry__c
                                    FROM Technician_Job_Times__r) 
                        from Service_Job__c 
                        where Service_Repair_Order__c =:ro.Id 
                        order by Line_Number__c asc
                        limit 1000];
        }

        if(jLines.size() > 0){
            for(dealer__Service_Job__c jl :jLines){
                jLineIds.add(jl.Id);
            }
        }

        //System.debug('from controle '+ JSON.serializePretty(jLines));
        return jLines;
    }  

    /*
     * Get Parts Lines
     * 
     *      params: ro.Id
     */
    global List<Parts_Invoice_Line__c> getServicePartsList() {
        List<Parts_Invoice_Line__c> plines = new List<Parts_Invoice_Line__c>();
        if(ro.Id!=null) {
            plines = [SELECT Id, Job_Line__c, Service_Job_Line_Number__c, 
                        Extended_Price__c, Part_Description__c, Part_Number__c, Price__c, Total_Price__c, Cost__c, Extended_Cost__c, Pay_Type__c, Quantity_Sold__c, Name 
                    FROM Parts_Invoice_Line__c
                    WHERE Service_Repair_Order__c=:ro.Id
                    ORDER by Service_Job_Line_Number__c asc
                    LIMIT 1000];
        }
         if(jLineIds.size() > 0 && pLines.size() < 1 ){
              plines = [SELECT Id, Job_Line__c, Service_Job_Line_Number__c, 
                        Extended_Price__c, Part_Description__c, Part_Number__c, Price__c, Total_Price__c, Cost__c, Extended_Cost__c, Pay_Type__c, Quantity_Sold__c, Name 
                    FROM Parts_Invoice_Line__c
                    WHERE Job_Line__c =: jLineIds 
                    ORDER by Service_Job_Line_Number__c asc
                    LIMIT 1000];
         }

        return plines;
    }  

    /**
     * Get Misc Lines
     * 
     *     Params: ro.Id
     */

    global List<Service_Misc_Charge__c> getMiscList() {
        List<Service_Misc_Charge__c> misclines = new List<Service_Misc_Charge__c>();
        if(ro.Id!=null) {
        misclines = [SELECT Id, Name, Amount__c, Service_Job_Lines__c, Type__c from Service_Misc_Charge__c
                    WHERE Repair_Order_ID__c =:ro.Id
                    LIMIT 1000];
        }
        
        return misclines;
    }  

    /**
     * Get Lines "Loaded" List
     * 
     *     Params: ro.Id
     */
    global List<Service_Job__c> getLinesList() {
        List<Service_Job__c> linesList = new List<Service_Job__c>();
        if(ro.Id!=null) {
        linesList = [SELECT ID, Name, Service_Repair_Order__c, Actual_Time__c, Book_Time__c, Cause__c, CauseExtended__c, Concern__c, Correction__c, Customer_Id__c, Estimate__c, Gross_Profit__c, Job_Added_Date__c, Job_ELR__c, Job_Finish__c, Job_Line_Id__c, Job_Start__c, Labor_Charges__c, Labor_Rate__c, Labor_Type__c, Line_Number__c, Line_Total__c, Op_Code__c, Operation_Code_Description__c, Parent_Record__c, Parts_Cost__c, Parts_Invoice_Id__c, Parts_Line__c, Parts_Total__c, RO_Invoice_Date_Time__c, RO_Number__c, RO_Status__c, Repair_Order_Id__c, Repair_Order__c, Service_Type__c, Service_Vehicle_Id__c, Standard_Operation_Code__c, Stat__c, Sublet_Total__c, Technician_Cost__c, Technician__c, Currently_Active__c, Sum_of_Billed_Hours__c, Payment_Notes__c, Add_On__c, Misc_Charges__c, Op_Description__c, Technician_ID__c, CustomerConcern__c, RO_Open_Date_Time__c, Claim__c, Paid_By__c, 
            (SELECT Parts_Invoice__c, Bin__c, Core__c, Cost__c, Counterman_No__c, Counterman__c, Currently_Available__c, Drop_Ship__c, Extended_Price__c, Gross_Margin__c, Job_Line__c, List__c, MFG__c, Net_Price__c, Net__c, Order_Type__c, Part_Description__c, Part_Number__c, Part__c, Pay_Type__c, Price_Level_Strategy__c, Price_Level__c, Price__c, Quantity_Ordered__c, Quantity_Sold__c, Sale_Date__c, Service_Job_Line_Number__c, Service_Repair_Order__c, Sold_Via__c, Source__c, Stocking_Group__c, Total_Price__c, Total_Tax__c, Transaction_Code__c, Name, Id, Extended_Cost__c FROM Parts_Lines__r),
            (SELECT Service_Job_Line__c, Actual_Time__c, Available_Flat_Rate_Time__c, Book_Time__c, Diag_Repair__c, Efficiency__c, Elapsed_Time_Minutes__c, End_Time__c, Flat_Rate_Time__c, Job_Name__c, Job_Status__c, Labor_Type__c, Repair_Order_Name__c, Repair_Order_Number__c, Start_Time__c, Technician__c, Technician__r.Name, Time_Punch_Notes__c, Time_Clock_Entry__c, Actual_Time_Entry__c, Date__c, Time_Clock__c, Name, Id, Payment_Method_Labor_Rate__c, Labor_Total__c FROM Technician_Job_Times__r),
            (SELECT Purchase_Order__c, Purchase_Order__r.Name, Account__c, Amount__c, Description__c, Drop_Ship_Address__c, Drop_Ship_To__c, Part_Quantity__c, Part__c, Parts_Invoice__c, Customer_Total__c, Special_Instructions__c, Service_Job_Line__c, Name, Id FROM Purchase_Order_Line__r),
            (SELECT Id, Name, Amount__c, Service_Job_Lines__c, Type__c from Service_Misc_Charge__r),
                Standard_Operation_Code__r.Name, Standard_Operation_Code__r.Id
            FROM Service_Job__c WHERE Service_Repair_Order__c =: ro.Id Order By Line_Number__c ASC limit 2000];
        }
        
        return linesList;
    }  
}