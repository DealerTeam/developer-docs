/**
* Date            |Developer            |Work#
* Notes
* ----------------------------------------------------------------------------
*
* 2017.01.05       |Gaurav               |W-000858
* Modified PartsSalesLine trigger for rolling up cost into Parent Service Job Line.
* @test PartInvoicingDomainLayer
* @test PartInvoicingServiceLayer
*/

public class PartInvoiceLineTriggerHandler{
    
    public List<Parts_Inventory__c> inventoryAdjustments{get;set;}

    public Map<Id, Parts_Invoice__c> invoiceMap {get;set;} //Holds invoices with tax and pricing strategy data 
    public Map<Id, Parts_Inventory__c> partMap {get;set;} //Holds local part pricing data
    public Map<Id, Parts_Service_Pricing_Strategy__c> pricingStrategyMap {get;set;} //Holds local part pricing data
    public Map<Id, Service_Job__c> svcJobs {get;set;}		
    // Constructor for instantiating variables		
    public PartInvoiceLineTriggerHandler() {	
        svcJobs = new Map<Id, Service_Job__c>();		
    }
        
    public void handleBeforeInsert(List<Parts_Invoice_Line__c> ListDealerInvoice){
        FixedOperationsSettings__c fops = FixedOperationsSettings__c.getOrgDefaults();  
        DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');
		Decimal taxRate = (dms.Default_Tax_Rate__c!=null) ? dms.Default_Tax_Rate__c : 0;        
        inventoryAdjustments = new List<Parts_Inventory__c>();
        
        Set<Id> invoiceIds = new Set<Id>();
        Set<Id> partIds = new Set<Id>();
        Set<Id> pricingStrategyIds = new Set<Id>();
        for(Parts_Invoice_Line__c objInvoiceLine : ListDealerInvoice){
            invoiceIds.add(objInvoiceLine.Parts_Invoice__c);
            partIds.add(objInvoiceLine.Part__c);
            pricingStrategyIds.add(objInvoiceLine.Price_Level_Strategy__c);
        }
        queryInvoices(invoiceIds);
        queryParts(partIds);
        queryStrategies(pricingStrategyIds);

        for(Parts_Invoice_Line__c objInvoiceLine : ListDealerInvoice) {
            
            objInvoiceLine.dealer__Price_Level__c = objInvoiceLine.Price_Level_Strategy__c != null && pricingStrategyMap.get(objInvoiceLine.Price_Level_Strategy__c) != null ? pricingStrategyMap.get(objInvoiceLine.Price_Level_Strategy__c).Name : '';
            
            if(objInvoiceLine.Price__c==null) { objInvoiceLine.Price__c = 0; }
            if(objInvoiceLine.Core__c==null) { objInvoiceLine.Core__c = 0; }
            if(objInvoiceLine.Cost__c==null) { objInvoiceLine.Cost__c = 0; }
            if(objInvoiceLine.List__c==null) { objInvoiceLine.List__c = 0; }
            if(objInvoiceLine.Net__c==null) { objInvoiceLine.Net__c = 0; }
            
            // Set Currency Values to Float(2) JK 2/14/2015
            objInvoiceLine.Price__c   =   objInvoiceLine.Price__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.Core__c    =   objInvoiceLine.Core__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.Cost__c    =   objInvoiceLine.Cost__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.List__c    =   objInvoiceLine.List__c.setScale(2, System.RoundingMode.HALF_EVEN);  

            //Allow for manual price entry on line creation
            if(objInvoiceLine.Price__c > 0){
                objInvoiceLine.Net__c = objInvoiceLine.Price__c;
            }
            else{
                objInvoiceLine.Net__c = calculateNet(objInvoiceLine);
                objInvoiceLine.Price__c = objInvoiceLine.Net__c;
            }
            
            
            if(objInvoiceLine.Quantity_Sold__c > 0) {
                
                if(objInvoiceLine.Quantity_Sold__c != null && objInvoiceLine.Price__c != null ) {
                    if(objInvoiceLine.Core__c==null) { objInvoiceLine.Core__c = 0; } 
                    if(fops.Legacy_Parts_Invoice__c) {
                        // Does not offer Support for FIFO / LIFO
                        System.debug('Setting Total Price');
                        objInvoiceLine.Total_Price__c = (objInvoiceLine.Price__c + objInvoiceLine.Core__c) * objInvoiceLine.Quantity_Sold__c;
                    } else {
                        // Supports LIFO/FIFO
                        System.debug('Setting Total Price 2');
                        objInvoiceLine.Total_Price__c = (objInvoiceLine.Price__c + objInvoiceLine.Core__c) * objInvoiceLine.Quantity_Sold__c;
                    }
                }
                
                if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c)!=null) {
                    Parts_Invoice__c objParInvoice = invoiceMap.get(objInvoiceLine.Parts_Invoice__c);
                    if(objParInvoice.Location__r.Tax_Local_Rate__c != null && objParInvoice.Location__r.Tax_Parts__c != null && objParInvoice.Location__r.Tax_Parts__c == true ) {
                        taxRate = objParInvoice.Location__r.Tax_Local_Rate__c;
                    }
                }
                
                objInvoiceLine.Total_Tax__c = (objInvoiceLine.Total_Price__c * (taxRate / 100));
                
                if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c)!=null && 
                  	invoiceMap.get(objInvoiceLine.Parts_Invoice__c).Tax_Exempt__c==true) {
                    	objInvoiceLine.Total_Tax__c=0;
                }
                
                // Set Currency Values to Float(2) JK 2/14/2015
                objInvoiceLine.Total_Price__c =   objInvoiceLine.Total_Price__c.setScale(2, System.RoundingMode.HALF_EVEN);
                objInvoiceLine.Total_Tax__c   =   objInvoiceLine.Total_Tax__c.setScale(2, System.RoundingMode.HALF_EVEN);
                
                if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c)!=null) {
                    // Check the tax override
                    if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c).Tax_Exempt__c == true) {
                        objInvoiceLine.Total_Tax__c = Decimal.valueOf('0.00');
                    } 
                }
                Decimal oldQty = 0;
                Decimal reduceStock = objInvoiceLine.Currently_Available__c - (objInvoiceLine.Quantity_Sold__c - oldQty);
                
                System.debug(reduceStock);

                if(objInvoiceLine.Quantity_Sold__c>=1 && objInvoiceLine.Part__c!=null) { 
                    inventoryAdjustments.add(new Parts_Inventory__c(Id=objInvoiceLine.Part__c, 
                                                                            On_Hand__c=reduceStock,
                                                                            Last_Sale_Date__c=Date.today()
                                                                           ));
                }                      
                
                // Check for Nulls on Sold Via
                if(objInvoiceLine.Sold_Via__c==null) {
                    objInvoiceLine.Sold_Via__c=''; 
                }   
            }else {
                objInvoiceLine.Total_Price__c = Decimal.valueOf('0.00');
                objInvoiceLine.Total_Tax__c = Decimal.valueOf('0.00');
            }           
            
            
        }
        
        if(inventoryAdjustments.size()>0){
            System.debug('Updating inventory adjustments'+inventoryAdjustments);
            // update inventoryAdjustments; // Once we linked the InvoiceLine to the PurchaseOrderLine, triggers cascaded
        } 
    }
    
    public void handleBeforeUpdate(List<Parts_Invoice_Line__c> ListDealerInvoice,Map<Id,Parts_Invoice_Line__c> OldMapDealerParts){
        
        FixedOperationsSettings__c fops = FixedOperationsSettings__c.getOrgDefaults();  
        DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');
       	Decimal taxRate = (dms.Default_Tax_Rate__c!=null) ? dms.Default_Tax_Rate__c : 0;        
        inventoryAdjustments = new List<Parts_Inventory__c>();
        
        Set<Id> invoiceIds = new Set<Id>();
        Set<Id> partIds = new Set<Id>();
        Set<Id> pricingStrategyIds = new Set<Id>();
        for(Parts_Invoice_Line__c objInvoiceLine : ListDealerInvoice){
            invoiceIds.add(objInvoiceLine.Parts_Invoice__c);
            partIds.add(objInvoiceLine.Part__c);
            pricingStrategyIds.add(objInvoiceLine.Price_Level_Strategy__c);
        }

        queryInvoices(invoiceIds);
        queryParts(partIds);
        queryStrategies(pricingStrategyIds);

        for(Parts_Invoice_Line__c objInvoiceLine : ListDealerInvoice) {
            
            objInvoiceLine.dealer__Price_Level__c = objInvoiceLine.Price_Level_Strategy__c != null && pricingStrategyMap.get(objInvoiceLine.Price_Level_Strategy__c) != null ? pricingStrategyMap.get(objInvoiceLine.Price_Level_Strategy__c).Name : '';

            if(objInvoiceLine.Price__c==null) { objInvoiceLine.Price__c = 0; }
            if(objInvoiceLine.Core__c==null) { objInvoiceLine.Core__c = 0; }
            if(objInvoiceLine.Cost__c==null) { objInvoiceLine.Cost__c = 0; }
            if(objInvoiceLine.List__c==null) { objInvoiceLine.List__c = 0; }
            if(objInvoiceLine.Net__c==null) { objInvoiceLine.Net__c = 0; }
            
            // Set Currency Values to Float(2) JK 2/14/2015
            objInvoiceLine.Price__c   =   objInvoiceLine.Price__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.Core__c    =   objInvoiceLine.Core__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.Cost__c    =   objInvoiceLine.Cost__c.setScale(2, System.RoundingMode.HALF_EVEN);
            objInvoiceLine.List__c    =   objInvoiceLine.List__c.setScale(2, System.RoundingMode.HALF_EVEN);  

            //If Price has been updated propagate those changes to net
            if(oldMapDealerParts.get(objInvoiceLine.Id).Price_Level_Strategy__c == objInvoiceLine.Price_Level_Strategy__c){
                objInvoiceLine.Net__c = objInvoiceLine.Price__c;
            }
            else{
                objInvoiceLine.Net__c = calculateNet(objInvoiceLine);
                objInvoiceLine.Price__c = objInvoiceLine.Net__c;
            }

            Boolean performUpdate = false;
            if(objInvoiceLine.Quantity_Sold__c > 0) {
                
                Parts_Invoice_Line__c oldObjPartInvoice = OldMapDealerParts.get(objInvoiceLine.Id);
                if(objInvoiceLine.Quantity_Sold__c != oldObjPartInvoice.Quantity_Sold__c)
                    performUpdate = true;
                
                if(objInvoiceLine.Quantity_Sold__c != null && objInvoiceLine.Price__c != null ) {
                    
                    if(fops.Legacy_Parts_Invoice__c) {
                        // Does not offer Support for FIFO / LIFO
                        objInvoiceLine.Total_Price__c = (objInvoiceLine.Price__c + objInvoiceLine.Core__c) * objInvoiceLine.Quantity_Sold__c;

                    } else {
                        // Supports LIFO/FIFO
                        objInvoiceLine.Total_Price__c = (objInvoiceLine.Price__c + objInvoiceLine.Core__c) * objInvoiceLine.Quantity_Sold__c;
                    }
                }
                
                if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c)!=null) {
                    Parts_Invoice__c objParInvoice = invoiceMap.get(objInvoiceLine.Parts_Invoice__c);
                    if(objParInvoice.Location__r.Tax_Local_Rate__c != null && objParInvoice.Location__r.Tax_Parts__c != null && objParInvoice.Location__r.Tax_Parts__c == true ) {
                        taxRate = objParInvoice.Location__r.Tax_Local_Rate__c;
                    }
                }
                objInvoiceLine.Total_Tax__c = (objInvoiceLine.Total_Price__c * (taxRate / 100));
                objInvoiceLine.Total_Price__c =   objInvoiceLine.Total_Price__c.setScale(2, System.RoundingMode.HALF_EVEN);
                objInvoiceLine.Total_Tax__c   =   objInvoiceLine.Total_Tax__c.setScale(2, System.RoundingMode.HALF_EVEN);

                if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c)!=null) {
                    // Check the tax override
                    if(invoiceMap.get(objInvoiceLine.Parts_Invoice__c).Tax_Exempt__c == true) {
                        objInvoiceLine.Total_Tax__c = Decimal.valueOf('0.00');
                    } 
                }
                Decimal oldQty = 0;
                if(performUpdate){
                    oldQty = oldObjPartInvoice.Quantity_Sold__c;
                }
                Decimal reduceStock = objInvoiceLine.Currently_Available__c - (objInvoiceLine.Quantity_Sold__c - oldQty);
                
                if(objInvoiceLine.Quantity_Sold__c>=1 && objInvoiceLine.Part__c!=null) { 
                    inventoryAdjustments.add(new Parts_Inventory__c(Id=objInvoiceLine.Part__c, 
                                                                            On_Hand__c=reduceStock,
                                                                            Last_Sale_Date__c=Date.today()
                                                                           ));
                }                      
                
                // Check for Nulls on Sold Via
                if(objInvoiceLine.Sold_Via__c==null) {
                    objInvoiceLine.Sold_Via__c=''; 
                }   
            }else {
                objInvoiceLine.Total_Price__c = Decimal.valueOf('0.00');
                objInvoiceLine.Total_Tax__c = Decimal.valueOf('0.00');
            }           
        }
        
        if(inventoryAdjustments.size()>0){
            System.debug('Updating inventory adjustments'+inventoryAdjustments);
            // update inventoryAdjustments; // Once we added the Parts Invoice line as a link to the purchase order line, this trigger was called incorrectly.
        } 
        
        
    }
		
    public void handlePayType(List<Parts_Invoice_Line__c> ListDealerInvoice) {		
        // Get Job Line Ids		
        Set<Id> jobIds = new Set<Id>();		
        for(Parts_Invoice_Line__c pi : ListDealerInvoice) {		
            if(pi.Job_Line__c != null && !jobIds.contains(pi.Job_Line__c)) {		
                jobIds.add(pi.Job_Line__c);		
            }		
        }		
        // Stateful across the insert/update triggers for recursion		
        if(!jobIds.isEmpty() && svcJobs.isEmpty()) {		
            svcJobs = new Map<Id, Service_Job__c>([SELECT Id, Labor_Type__c FROM Service_Job__c WHERE Id IN:jobIds]);		
            // Iterate the Parts Invoice Lines		
            for(Parts_Invoice_Line__c pil : ListDealerInvoice) {		
                if(pil.Job_Line__c != null 		
                    && svcJobs.get(pil.Job_Line__c) != null		
                    && pil.Pay_Type__c != svcJobs.get(pil.Job_Line__c).Labor_Type__c) {		
                        pil.Pay_Type__c = svcJobs.get(pil.Job_Line__c).Labor_Type__c;		
                    }		
            }		
        }		
    }

    public void handleAfterRollup(List<Parts_Invoice_Line__c> ListDealerInvoice){
        
        List<Part_Inventory_History__c> ListInventoryHistory = new List<Part_Inventory_History__c>();
        Set<Id> ServiceJobLineIds = new Set<Id>();
        Map<Id, Service_Job__c> jobLineMap = new Map<Id, Service_Job__c>();
        
        for(Parts_Invoice_Line__c objInvoice : ListDealerInvoice) {
            
            if(objInvoice.Job_Line__c!=null) {
                ServiceJobLineIds.add(objInvoice.Job_Line__c);
            }
            
        } 
        
        // Get all Job Lines affected, so we can total the parts sales on each parts line
        //W-000858 Begins
        if(!ServiceJobLineIds.isEmpty()) {
            List<Service_Job__c> jobLines = new List<Service_Job__c>();
            Map<Id, Service_Job__c> ServiceJobMap   =  new Map<Id, Service_Job__c>([Select Id, Parts_Total__c,Parts_Cost__c From Service_Job__c Where Id IN: ServiceJobLineIds]);    
            AggregateResult[] jobtotals = [SELECT Job_Line__c, sum(Total_Price__c) TotalPrice, sum(Cost__c) TotalCost FROM Parts_Invoice_Line__c WHERE Job_Line__c IN:ServiceJobLineIds GROUP BY Job_Line__c];

            for(AggregateResult objTotal : jobtotals){

                System.debug(objTotal);

                if(ServiceJobMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')))!=null && 
                   ServiceJobMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c'))).Parts_Cost__c != Decimal.valueOf(String.valueOf(objTotal.get('TotalCost')))
                  ) {


                    Service_Job__c sjob = new Service_Job__c();
                    if(jobLineMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')))!=null)
                        sjob=jobLineMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')));

                    sjob.Id=String.valueOf(objTotal.get('dealer__Job_Line__c'));
                    sjob.Parts_Cost__c=Decimal.valueOf(String.valueOf(objTotal.get('TotalCost')));

                    jobLineMap.put(sjob.Id, sjob);

                  }
                
                if(ServiceJobMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')))!=null && 
                   ServiceJobMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c'))).Parts_Total__c != Decimal.valueOf(String.valueOf(objTotal.get('TotalPrice')))
                  ) {

                    // Check to see if the line is already in Mem
                    Service_Job__c sjob = new Service_Job__c();
                    if(jobLineMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')))!=null)
                        sjob=jobLineMap.get(String.valueOf(objTotal.get('dealer__Job_Line__c')));

                    sjob.Id=String.valueOf(objTotal.get('dealer__Job_Line__c'));
                    sjob.Parts_Total__c=Decimal.valueOf(String.valueOf(objTotal.get('TotalPrice')));

                    jobLineMap.put(sjob.Id, sjob);
                  }
            }
            
            if(jobLineMap.size()>0){
                System.debug('Calling the update to the lines');
                update jobLineMap.values();

                System.debug(jobLineMap);
            }

        }
        //W-000858 End
    }

    public void handleAfterInsertHistory(List<Parts_Invoice_Line__c> listInvoiceLine) {
        
        // Method should only fire on Insert Context Items
        List<Part_Inventory_History__c> ListInventoryHistory = new List<Part_Inventory_History__c>();

        for(Parts_Invoice_Line__c objInvoice : listInvoiceLine) {
            // Inventory History object - Tracking and Auditing
            if(objInvoice.Part__c!=null) {
                // Check for Nulls on Sold Via
                String soldVia = objInvoice.Sold_Via__c;
                if(soldVia==null) {
                    soldVia='';
                }
                
                ListInventoryHistory.add(new Part_Inventory_History__c(Quantity_Adjustment__c=objInvoice.Quantity_Sold__c, 
                                                                               Part__c=objInvoice.Part__c,
                                                                               Parts_Invoice__c=objInvoice.Parts_Invoice__c,
                                                                               Transaction_Event__c='Sold Via: '+soldVia,
                                                                               Post_Transaction_QOH__c=objInvoice.Currently_Available__c,
                                                                               Related_Document__c=System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+objInvoice.Parts_Invoice__c,
                                                                               EventId__c=objInvoice.Id
                                                                              ));
            }
        }
        
        if(ListInventoryHistory.size() > 0) {
            insert ListInventoryHistory;
        }   
    }
    
    public void handleDeleteMethod(List<Parts_Invoice_Line__c> ListDealerInvoice){

        List<Service_Job__c>ListJobLine = new List<Service_Job__c>();
        List<Part_Inventory_History__c> invHistoryOld = new List<Part_Inventory_History__c>();
        Set<Id> histLines = new Set<Id>();
        Set<Id> ServiceJobLineIds = new Set<Id>();

        // Get the Event Line of the Sale and Remove
        for(Parts_Invoice_Line__c objInvoice : ListDealerInvoice) {
            histLines.add(objInvoice.Id);
            if(objInvoice.Job_Line__c!=null) {
                ServiceJobLineIds.add(objInvoice.Job_Line__c);
            }
            if(objInvoice.Job_Line__c!=null){
              ServiceJobLineIds.add(objInvoice.Job_Line__c);  
            }
        }
        
        // Due to the fact that this field is not indexed, nor can we make it an indexed field (External ID : managed released) we need to ignore these fields.
        // invHistoryOld = [select Id from Part_Inventory_History__c where EventId__c IN:histLines limit 2000]; /* Non-selective query, EventId__c non-indexed */
        
        // delete invHistoryOld;
        
        /* W-000858 Begin */
        if(!ServiceJobLineIds.isEmpty()){

            //Map of Service Job
            Map<Id,Service_Job__c> ServiceJobMap = new Map<Id,Service_Job__c>([Select Id, Parts_Cost__c, Parts_Total__c,
                                                                                                 (SELECT Cost__c, Total_Price__c FROM Parts_Lines__r) 
                                                                                                    FROM Service_Job__c  
                                                                                                 WHERE Id IN:ServiceJobLineIds]);
            
            //For loop for trigger instance
            for(Parts_Invoice_Line__c objInvLine : ListDealerInvoice){
                                
                Service_Job__c objService = new Service_Job__c();

                if(objInvLine.Job_Line__c != null){
                    objService = ServiceJobMap.get(objInvLine.Job_Line__c);

                    // Get the remaining parts cost and total
                    Decimal cost = 0;
                    Decimal sale = 0;
                    for(Parts_Invoice_Line__c iLine : ServiceJobMap.get(objInvLine.Job_Line__c).Parts_Lines__r) {
                        cost += iLine.Cost__c; //Cost is a derived value from the FIFO/LIFO Table
                        sale += iLine.Total_Price__c;
                    }

                    objService.Parts_Cost__c=cost;
                    objService.Parts_Total__c=sale;
                }

                ListJobLine.add(objService);
            }
            
            if(ListJobLine.size()>0){
                update ListJobLine; 
            }

        }
        /* W-000858 End */
    }

    /**
    * @method calculateNet
    * @description checks the pricing strategy on the invoice to determine net value to use
    * @param  partLine partLine description
    * @return          return description
    */
    public Decimal calculateNet(Parts_Invoice_Line__c partLine)
    {
       
        if(invoiceMap.get(partLine.Parts_Invoice__c) == null || partMap.get(partLine.Part__c) == null){
            return 0;
        }
        Parts_Service_Pricing_Strategy__c pricingStrat = new Parts_Service_Pricing_Strategy__c();
        //Use pricing strategy from part line if one exists
        if(partLine.Price_Level_Strategy__c != null && pricingStrategyMap.get(partLine.Price_Level_Strategy__c) != null){
            pricingStrat.Id = partLine.Price_Level_Strategy__c;
            pricingStrat.Parts_Variable_Amount__c = pricingStrategyMap.get(partLine.Price_Level_Strategy__c).Parts_Variable_Amount__c;
            pricingStrat.Method__c = pricingStrategyMap.get(partLine.Price_Level_Strategy__c).Method__c;
            pricingStrat.Formula_Operand__c = pricingStrategyMap.get(partLine.Price_Level_Strategy__c).Formula_Operand__c;
        }
        //Else use pricing strategy from the invoice
        if(partLine.Price_Level_Strategy__c == null && invoiceMap.get(partLine.Parts_Invoice__c).Wholesale_Pricing_Strategy__c != null){
            pricingStrat.Id = invoiceMap.get(partLine.Parts_Invoice__c).Wholesale_Pricing_Strategy__c;
            pricingStrat.Parts_Variable_Amount__c = invoiceMap.get(partLine.Parts_Invoice__c).Wholesale_Pricing_Strategy__r.Parts_Variable_Amount__c;
            pricingStrat.Method__c = invoiceMap.get(partLine.Parts_Invoice__c).Wholesale_Pricing_Strategy__r.Method__c;
            pricingStrat.Formula_Operand__c = invoiceMap.get(partLine.Parts_Invoice__c).Wholesale_Pricing_Strategy__r.Formula_Operand__c;
        }
        //If neither exist return 0
        if(pricingStrat.Id == null){
            return 0;
        }

        //Base on list at 0%
        if(pricingStrat.Parts_Variable_Amount__c == null){
            pricingStrat.Parts_Variable_Amount__c = 0;
        }
        Parts_Inventory__c part = partMap.get(partLine.Part__c);

        Decimal netPrice = 0;
        switch on pricingStrat.Method__c {
            when 'Jobber' {
                netPrice = part.Jobber__c;
            }

            when 'MAP' {
                netPrice = part.MAP__c;
            }

            when 'Warranty' {
                netPrice = part.Warranty__c;
            }

            when 'List' {
                netPrice = part.List__c;
            }

            when 'Cost' {
                netPrice = part.Cost__c;
            }
            //If none of the above we default to list
            when else {
                netPrice = part.List__c;
            }
        }
        netPrice = netPrice == null ? 0 : netPrice;

        netPrice =  pricingStrat.Formula_Operand__c == '-' ? netPrice - (netPrice * (pricingStrat.Parts_Variable_Amount__c/100)) : netPrice + (netPrice * (pricingStrat.Parts_Variable_Amount__c/100));

        return netPrice.setScale(2, System.RoundingMode.HALF_EVEN);

    }

    /**
    * @method queryInvoices
    * @description Queries invoices to get fields from the pricing strategy on the invoice
    * @param  invoiceIds invoiceIds description
    */
    public void queryInvoices(Set<Id> invoiceIds)
    {
        if(invoiceMap == null){
            invoiceMap = new Map<Id, Parts_Invoice__c>();

            if(invoiceIds.size() > 0){
                List<Parts_Invoice__c> invoices = [SELECT Id, Sales_Tax_ID__c, Tax_Exempt__c, Location__r.Tax_Local_Rate__c, Location__r.Tax_Parts__c, Wholesale_Pricing_Strategy__c, Wholesale_Pricing_Strategy__r.Method__c, Wholesale_Pricing_Strategy__r.Parts_Variable_Amount__c, Wholesale_Pricing_Strategy__r.Parts_Forumula_Base__c, Wholesale_Pricing_Strategy__r.Formula_Operand__c FROM Parts_Invoice__c WHERE Id IN: invoiceIds];
                for(Parts_Invoice__c invoice : invoices){
                    invoiceMap.put(invoice.Id, invoice);
                }
            }
        }
    }

    /**
    * @method queryParts
    * @description Queries parts to return pricing fields used in net calculation
    * @param  partIds partIds description
    */
    public void queryParts(Set<Id> partIds)
    {
        if(partMap == null){
            partMap = new Map<Id, Parts_Inventory__c>();

            if(partIds.size() > 0){
                List<Parts_Inventory__c> parts = [SELECT Id, Warranty__c, MAP__c, Jobber__c, List__c, Cost__c FROM Parts_Inventory__c WHERE Id IN: partIds];
                for(Parts_Inventory__c part : parts){
                    partMap.put(part.Id, part);
                }
            }
        }
    }

    /**
    * @method queryParts
    * @description Queries pricing strategies to return fields used in net calculation
    * @param  psIds psIds description
    */
    public void queryStrategies(Set<Id> psIds)
    {
        if(pricingStrategyMap == null){
            pricingStrategyMap = new Map<Id, Parts_Service_Pricing_Strategy__c>();

            if(psIds.size() > 0){
                List<Parts_Service_Pricing_Strategy__c> strats = [SELECT Id, Name, Parts_Variable_Amount__c, Method__c, Formula_Operand__c FROM Parts_Service_Pricing_Strategy__c WHERE Id IN: psIds];
                for(Parts_Service_Pricing_Strategy__c strat : strats){
                    pricingStrategyMap.put(strat.Id, strat);
                }
            }
        }
    }
    

}