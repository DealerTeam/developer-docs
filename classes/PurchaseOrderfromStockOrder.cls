/**
 * PurchaseOrderFromStockOrder - Class to take values from the staged orders 
 * and create the stock orders and assocated as either purchase orders or transfers
 * 
 */
public with sharing class PurchaseOrderfromStockOrder {

    public String orderId {get;set;}
    public dealer__Stock_Order__c so {get;set;}
    public dealer__Purchase_Order__c po {get;set;}
    public List<dealer__Parts_Order__c> orderLines  {get;set;}    
    public List<POvSOCheckboxWrapper> poLines {get;set;}
    public List<POvSOCheckboxWrapper> selectedLines {
        get {
            if (selectedLines == null) selectedLines = new List<POvSOCheckboxWrapper>();
            return selectedLines;
        }
        set;
    }  
    
    public String itemForRemoval {
        get;
        set {
            itemForRemoval = value;
        }
    }
    
    /**
     * PurchaseOrderfromStockOrder
     * @return null
     * @notes class constructor
     * @vfparams OrderId : Order record
     * @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder
     */
    public PurchaseOrderfromStockOrder() {

            orderId = ApexPages.currentPage().getParameters().get('OrderId');
            
            RecordType r = [Select Id from RecordType where DeveloperName = 'Parts_Purchase' and NamespacePrefix = 'dealer' limit 1];
            if(r==null) {
                throw new POCreationException('Incorrect record type association, please contact DealerTeam support.');
            }
            
            if(orderId!='' && orderId!=null) {
                so = [Select Id, dealer__Status__c, dealer__Packing_Slip__c, dealer__Description__c, CreatedDate, Name, 
                        (Select Id, Name, 
                                dealer__Value__c, 
                                dealer__Scan_Time__c, 
                                dealer__Requested_By__c, 
                                dealer__Received__c, 
                                dealer__Quantity_Ordered__c, 
                                dealer__Purchase_Order__c,
                                dealer__Parts_Line__c, 
                                dealer__Parts_Invoice__c, 
                                dealer__Parts_Inventory__c, 
                                dealer__Parts_Inventory__r.dealer__Parts_Master__c, 
                                dealer__Parts_Inventory__r.dealer__Pack_QTY__c,
                                dealer__Parts_Inventory__r.dealer__Cost__c,
                                dealer__Parts_Line__r.dealer__Drop_Ship__c, 
                                dealer__Service_Job_Line__c, 
                                dealer__Repair_Order_ID__c, 
                                dealer__Repair_Order_Company_ID__c,
                                dealer__Order_Status__c, 
                                dealer__Parts_Invoice__r.dealer__Customer_ShipTo_AddressFormatted__c,
                                dealer__Order_Date__c, 
                                dealer__Depot__c, 
                                dealer__Back_Ordered__c,
                                dealer__Order__c
                            from Parts_Orders__r where  dealer__Purchase_Order__c = null)
                        from dealer__Stock_Order__c where Id =:orderId];
                po = new dealer__Purchase_Order__c(RecordTypeId=r.Id);      
                if(so.Parts_Orders__r.size() > 0) {
                    // Initialize the object
                    if(poLines == null) {
                        poLines = new List<POvSOCheckboxWrapper>();
                    } else {
                        poLines.clear();
                    }
                    
                    for(dealer__Parts_Order__c pl : so.Parts_Orders__r) {

                        POvSOCheckboxWrapper wl = new POvSOCheckboxWrapper(pl, so.Id);
                        poLines.add(wl);
                    //orderLines = so.Parts_Orders__r;
                    }
                }       
            }
    }
    
    /**
     * lineCount
     * @return integer
     * @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder
     */
    public Integer lineCount { 
            get {
                Integer Icount = 0; 
                if(so.Parts_Orders__r!=null) {
                    for(dealer__Parts_Order__c orderLineLoop : so.Parts_Orders__r) {
                        Icount++;
                    }   
                }
                return Icount;
            }
            set;
    }
    
    /**
     * orderValue
     * @return Decimal
     * @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder
     */
    public Decimal orderValue {
            get {
                Decimal oValue = 0;
                for(dealer__Parts_Order__c orderLineLoop : so.Parts_Orders__r) {
                    if(orderLineLoop.dealer__Value__c!=null) {
                        oValue+=orderLineLoop.dealer__Value__c;
                    }
                }
                return oValue;
            }
            set;
    }   
    
    /**
     * createWithSelected
     * @return PageReference
     * @notes create a purchase order with the selected line items
     * @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder
     */
    public PageReference createWithSelected() { 

        SavePoint sp = Database.setSavePoint();

        if(poLines==null) {
            return null;
        }

        if(po.dealer__Vendor__c==null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select a vendor for this purchase order'));
            return null;
        }
        
        for(POvSOCheckboxWrapper pw : poLines) {
            if(pw.checked)
                selectedLines.add(new POvSOCheckboxWrapper(pw.oline, pw.orderId));
                        
        }
        
        if(selectedLines.size()==0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'A minimum of one line must be selected.'));
            return null;
        }
        
        // Create purchase order 
        dealer__Purchase_Order__c thisPO = new dealer__Purchase_Order__c();
        thisPO.dealer__Requested_By__c = UserInfo.getName();
        thisPO.dealer__Vendor__c = po.dealer__Vendor__c;
        thisPO.dealer__Type__c = 'Parts';
        thisPO.dealer__Status__c='Open';
        thisPO.dealer__Company__c=dealer.Utility.lookupUserLocation();  //This should be set to the Repair Order Header if one is found

        for(POvSOCheckboxWrapper slines : selectedLines) {
            if(thisPO.dealer__Service_Repair_Order__c==null && slines.oline.dealer__Repair_Order_ID__c!=null) {
                thisPO.dealer__Service_Repair_Order__c=slines.oline.dealer__Repair_Order_ID__c;

                if(slines.oline.dealer__Repair_Order_Company_ID__c!=null) {
                    thisPO.dealer__Company__c=slines.oline.dealer__Repair_Order_Company_ID__c;
                }

            }
        }

        try {
            insert thisPO;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            Database.rollBack(sp);
            return null;
        }
        
        // Map to Ivnoice for shipping address
        /*
        for(POvSOCheckboxWrapper maplines : selectedLines) {
            System.debug(maplines.oline.dealer__Parts_Invoice__c);
            if(maplines.oline.dealer__Parts_Invoice__c!=null) {
                invoiceSet.add(maplines.oline.dealer__Parts_Invoice__c);
            }
        }
        */
        
        // Add lines
        List<dealer__Purchase_Order_Line__c> pl = new List<dealer__Purchase_Order_Line__c>();
        List<dealer__Parts_Order__c> orderList = new List<dealer__Parts_Order__c>();
        List<dealer__Parts_Invoice_Line__c> invoiceLines = new List<dealer__Parts_Invoice_Line__c>();

        for(POvSOCheckboxWrapper slines : selectedLines) {
            slines.oline.dealer__Purchase_Order__c = thisPO.Id;
            orderList.add(slines.oline);
            
            // Validate Drop Ship Instructions
            String dsAddress = null;
            String dsName = null;
            if(slines.oline.dealer__Parts_Line__r.dealer__Drop_Ship__c==true) {
                dsAddress = slines.oline.dealer__Parts_Invoice__r.dealer__Customer_ShipTo_AddressFormatted__c;
            }
            
            // Check null values
            if(slines.oline.dealer__Parts_Inventory__r.dealer__Pack_QTY__c==null) {
                slines.oline.dealer__Parts_Inventory__r.dealer__Pack_QTY__c=1; 
            }

            if(slines.oline.dealer__Value__c==null) {
               slines.oline.dealer__Value__c=slines.oline.dealer__Parts_Inventory__r.dealer__Cost__c; 
            }

            // If we are creating a Purchase Order Line and the part is a pack part, only apply single pack quantities
            Decimal qtyToOrder  =   slines.oline.dealer__Quantity_Ordered__c;
            Decimal lineAmt     =   slines.oline.dealer__Value__c;  

            /* The order record should only request the number of items divided by packQTY, this was placed incorrectly here. 
            if(slines.oline.dealer__Parts_Inventory__r.dealer__Pack_QTY__c > 1) {
                qtyToOrder  =   slines.oline.dealer__Quantity_Ordered__c / slines.oline.dealer__Parts_Inventory__r.dealer__Pack_QTY__c;
                qtyToOrder  =   qtyToOrder.round(System.RoundingMode.UP);
                lineAmt     =   slines.oline.dealer__Parts_Inventory__r.dealer__Cost__c * qtyToOrder;
                lineAmt     =   lineAmt.setScale(2, System.RoundingMode.HALF_UP);  
            }
            */

            pl.add(new dealer__Purchase_Order_Line__c(
                dealer__Amount__c=((slines.oline.dealer__Value__c * slines.oline.dealer__Parts_Inventory__r.dealer__Pack_QTY__c)*slines.oline.dealer__Quantity_Ordered__c),
                dealer__Part__c=slines.oline.dealer__Parts_Inventory__c,
                dealer__Parts_Master__c=slines.oline.dealer__Parts_Inventory__r.dealer__Parts_Master__c,
                dealer__Part_Quantity__c=qtyToOrder,
                dealer__Purchase_Order__c=thisPO.Id,
                dealer__Parts_Invoice__c=slines.oline.dealer__Parts_Invoice__c,
                dealer__Drop_Ship_Address__c=dsAddress,
                dealer__Service_Job_Line__c=slines.oline.dealer__Service_Job_Line__c,
                dealer__Parts_Line__c=slines.oline.dealer__Parts_Line__c
            ));
        } 

        try {
            
            // Insert Purchase Order Lines
            insert pl;
            
            // Update Order lines
            update orderList;

            // Update Invoice Lines
            for(dealer__Purchase_Order_Line__c uPL : pl) {
                if(uPL.dealer__Parts_Line__c!=null) {
                    invoiceLines.add(new dealer__Parts_Invoice_Line__c(Id=uPL.dealer__Parts_Line__c, dealer__Purchase_Order_Line__c=uPL.Id));
                }
            }

            if(!invoiceLines.isEmpty()) {
                update invoiceLines;
            }

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to create the purchaes order lines. Error '+e.getMessage()));
            Database.rollBack(sp);
            return null;            
        }

        PageReference returnPO = new PageReference('/'+thisPO.Id);
        returnPO.setRedirect(true);
        return returnPO;
    }
    
    /**
     * removeItem
     * @return [description]
     * @notes - deprecated
     * @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder
     */
    public PageReference removeItem() {
        System.debug('Item: '+itemForRemoval);
        return null;
    }
    
    public class POCreationException extends Exception {}
    
}