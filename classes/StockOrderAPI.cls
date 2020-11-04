public with sharing class StockOrderAPI {
    public StockOrderAPI() {
    }
    /**
     * Converts single invoiceLine to a list to be accepted by processStockOrders
     * @function processStockOrder
     * @param {Parts_Invoice_Line__c} - invoice line to process stock order from
     * @test PartOrderingServiceLayer.testPartInvoiceAPI
     */
    public void processStockOrder(Parts_invoice_Line__c invoiceLine){
        system.assert(invoiceLine != null,'Missing invoice line to process.');
        List<Parts_Invoice_Line__c> lines = new List<Parts_Invoice_Line__c>();
        lines.add(invoiceLine);
        processStockOrders(lines);
    }

    /**
     * Creates a stock order from invoice lines if needed
     * @function processStockOrders
     * @param {List<Parts_Invoice_Line__c>} - invoice line to process stock order from
     * @test PartOrderingServiceLayer.testPartInvoiceAPI
     */
    public void processStockOrders(List<Parts_invoice_Line__c> invoiceLines){
        
        /* Feature Control */
        if(!Utility.isDMSFeatureEnabled('StockOrder')) {
			return;   
        }
        
        /* Transaction control */
        Savepoint sp = Database.setSavepoint();
        
        Set<Id> pilIdSet = new Set<Id>();
        for(Parts_Invoice_Line__c pil : invoiceLines){
            pilIdSet.add(pil.Id);
        }
        
        /* Instantiating new Parts Invoice Lines to Ensure all Data we need is present */
        /* Creating Map of Parts */
        /* Get locations */
        List<Parts_invoice_Line__c> pi = new List<Parts_invoice_Line__c>();
        Map<Id,Parts_Inventory__c> partMap = new Map<Id,Parts_Inventory__c>();//Parts_Inventory__c.Id,Part
        Set<Id> locIds = new Set<Id>();
        for(Parts_Invoice_Line__c pil : [SELECT Id, Name,Quantity_Ordered__c, Core__c, Cost__c, List__c, Part_Description__c, 
                                        Bin__c, Currently_Available__c,Part_Number__c, Part_Master_Record__c, Part__c,
                                        Part__r.Location__c,Part__r.On_Order__c,Part__r.On_Hand__c,Part__r.Location__r.Company_Number__c,Part__r.Location__r.Name,
                                        Quantity_Sold__c, Extended_Price__c, Price__c,Source__c, Sold_Via__c, Price_Level__c, 
                                        Drop_Ship__c, Transaction_Code__c, Job_Line__c, Service_Job_Line_Number__c, Service_Repair_Order__c
                                        From Parts_Invoice_Line__c WHERE Id IN: pilIdSet]){
            
            system.assert(pil.Part__r.Location__c != null, 'Part '+pil.Part__c+' does not have a location.'); 
            pi.add(pil);     
            partMap.put(pil.Part__c, pil.part__r);
            if(!locIds.contains(pil.Part__r.Location__c)) locIds.add(pil.Part__r.Location__c);  
        }
        
        /*Acquire any existing stock orders for our Parts Invoice Lines*/
        Map<Id,Stock_Order__c> stockOrderMap = new Map<Id,Stock_Order__c>(); //Company__c, Stock_Order__c
        for(Stock_Order__c so : [Select Id, Company__c, Status__c FROM Stock_Order__c WHERE Company__c IN: locIds AND CreatedDate = TODAY]){
            stockOrderMap.put(so.Company__c, so);
        }

        /* Determining which Parts Invoice Lines will need a new Stock Order */
        List<Parts_Invoice_Line__c> linesWithoutSO = new List<Parts_Invoice_Line__c>();
        for(Parts_Invoice_Line__c pil : pi){
            if(stockOrderMap.get(partMap.get(pil.Part__c).Location__c) == null){
                linesWithoutSO.add(pil);
            } 
        }

        /* If a stock Order does not exist for this part create one and add to list. */
        Map<Id,Stock_Order__c> newStockOrders = new Map<Id,Stock_Order__c>();
        if(linesWithoutSO.size() > 0){
            newStockOrders = NewStockOrders(linesWithoutSO, partMap);
        }

        if(newStockOrders.size() > 0){
            try{
                insert newStockOrders.values();
            } catch (DMLException e){
                Database.rollback(sp);
                throw new DMLException(e.getMessage());
            }
        }

        /* Add newly created stock orders to the stock Order Map */
        for(Stock_Order__c so : newStockOrders.values()){
            stockOrderMap.put(so.Company__c, so);
        }

        /* Map for exsiting parts Orders */
        Map<Id, Parts_Order__c> partsOrderMap = new Map<Id, Parts_Order__c>();
        for(Parts_Order__c po : [select Id, Parts_Line__c from Parts_Order__c WHERE Parts_Line__c IN:pilIdSet]){
            partsOrderMap.put(po.Parts_Line__c, po);
        }

        /* Determine if Parts Orders need to be updated or created */
        List<Parts_Order__c> partsOrders = new List<Parts_Order__c>();
        List<Parts_Order__c> partsOrdersToDelete = new List<Parts_Order__c>();
        for(Parts_Invoice_Line__c pil : pi){
            if(pil.Currently_Available__c < 0 && partsOrderMap.get(pil.Id) == null){ 
                //If parts order does NOT exist for this line create new Order
                partsOrders.add(PartsOrderLine(pil,null,stockOrderMap.get(partMap.get(pil.Part__c).Location__c)));
               
            } else if(pil.Currently_Available__c < pil.Quantity_Sold__c && partsOrderMap.get(pil.Id) == null){ 
        

                //If parts order does NOT exist for this line create new Order
                partsOrders.add(PartsOrderLine(pil,null,stockOrderMap.get(partMap.get(pil.Part__c).Location__c)));
               
            } else if((pil.Currently_Available__c < 0 || pil.Currently_Available__c < pil.Quantity_Sold__c) && partsOrderMap.get(pil.Id) != null) { 
                //Update Existing Parts Order
                if(stockOrderMap.get(partMap.get(pil.Part__c).Location__c).Status__c == 'Incomplete' ){
                    partsOrders.add(PartsOrderLine(pil,partsOrderMap.get(pil.Id),null));
                }
            } else if (pil.Currently_Available__c >= 0 && partsOrderMap.get(pil.Id) != null){ //On Hand inventory satisfies this sale
                partsOrdersToDelete.add(partsOrderMap.get(pil.Id));
            }
        }

        if(partsOrders.size() > 0 || PartsOrdersToDelete.size() > 0){
            try{
                if(partsOrders.size() > 0)         upsert partsOrders;
                if(partsOrdersToDelete.size() > 0) delete PartsOrdersToDelete;
            } catch (DMLException e){
                Database.rollback(sp);
                throw new DMLException(e.getMessage());
            }
        }
    }

    /**
     * Instantiates a List of Stock Orders and returns it. 
     * @function NewStockOrders
     * @param {List<Parts_Invoice_Line__c>} - parts invoice lines that need a stock order
     * @param {Map<Id, Parts_inventory__c>} - map of parts to reference location info
     * @returns {Map<Id, Stock_Order__c>} - Map of locations and new stock orders
     * @test PartOrderingServiceLayer.testPartInvoiceAPI
     */
    public Map<Id,Stock_Order__c> NewStockOrders(List<Parts_Invoice_Line__c> linesWithoutSO, Map<Id,Parts_Inventory__c> partMap ){
        Map<Id,Stock_Order__c> stockOrders = new Map<Id,Stock_Order__c>();
        for(Parts_Invoice_Line__c pil : linesWithoutSO){
           
            if((stockOrders.get(pil.Part__c) == null && pil.Currently_Available__c <= 0)
              || (stockOrders.get(pil.Part__c) == null && pil.Currently_Available__c < pil.dealer__Quantity_Sold__c)){
   

                stockOrders.put(partMap.get(pil.Part__c).Location__c, new Stock_Order__c(
                    Name=partMap.get(pil.Part__c).Location__r.Company_Number__c+'-'+Date.Today().year()+'-'+Date.Today().month()+'-'+Date.Today().day(),
                    dealer__Status__c='Incomplete', 
                    dealer__Company__c=partMap.get(pil.Part__c).Location__c,
                    dealer__Date_Ordered__c=Date.Today(),
                    dealer__Order_Type__c='Special Order'
                ));
            }                
        }
        return stockOrders;
    }

    /**
     * Creates a new Parts Order Object if one does not exist or updates a Parts Order with new Data 
     * @function PartsOrderLine
     * @param {Parts_Invoice_Line__c} - line used to populate new Parts Order
     * @param {Parts_Order__c} - updates existing Part Order Line if this is not null
     * @param {Stock_Order__c} - creates new Part Order Line if not updating existing
     * @returns {Parts_Order__c} - Order with updated or newly created Part Order Line
     * @test PartOrderingServiceLayer.testPartInvoiceAPI
     */
    public Parts_Order__c PartsOrderLine(Parts_Invoice_Line__c piLine, Parts_Order__c partsOrder, Stock_Order__c stockOrder){
        
        Decimal qtyOrdered = 0;
        if(piLine.Currently_Available__c >= 0 && piLine.dealer__Quantity_Sold__c > piLine.Currently_Available__c){
            qtyOrdered = piLine.dealer__Quantity_Sold__c - piLine.Currently_Available__c;
        }else{
            qtyOrdered = piLine.dealer__Quantity_Sold__c;
        }
            
        if(partsOrder != null && stockOrder == null){//updates existing Part Order Line
                      
            return new Parts_Order__c(
                Id = partsOrder.Id,
                Parts_Inventory__c=piLine.Part__c,
                Parts_Master__c =piLine.Part_Master_Record__c,
                Quantity_Ordered__c=qtyOrdered,
                Parts_Line__c=piLine.Id
            );
        } else {//creates new Part Order Line
            return new Parts_Order__c(
                Order__c = stockOrder.Id,
                Order_Date__c=Date.today(),
                Parts_Inventory__c=piLine.Part__c,
                Parts_Master__c =piLine.Part_Master_Record__c,
                Quantity_Ordered__c= qtyOrdered, 
                Parts_Line__c=piLine.Id
            );
        }
    }
}