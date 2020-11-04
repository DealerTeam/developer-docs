public with sharing class PartsReturnController {
    /**
    * @method saveReturn
    * @description updates or creates new Parts_Invoice__c record with certain fields populated
    * @param  recordId Id of the Parts_Invoice__c to upsert
    * @return Parts_Invoice__c saved record with current data
    */
    @AuraEnabled
    public static Parts_Invoice__c saveReturn(Parts_Invoice__c pi){
        try{
            return PartsReturnAPI.savePartsInvoice(pi);
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @method voidReturn
    * @description marks Parts_Invoice__c record as void
    * @param  recordId Id of the Parts_Invoice__c to void
    * @return void
    */
    @AuraEnabled
    public static void voidReturn(String piId){
        try{
            Parts_Invoice__c pi = new Parts_Invoice__c(Id = piId);
            PartsReturnAPI.voidPartsInvoice(pi);
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @method invoiceReturn
    * @description marks Parts_Invoice__c record as invoiced
    * @param  recordId Id of the Parts_Invoice__c to invoice
    * @return void
    */
    @AuraEnabled
    public static void invoiceReturn(String piId){
        try{
            Parts_Invoice__c pi = new Parts_Invoice__c(Id = piId);
            PartsReturnAPI.invoiceRecord(pi);
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @method getReturn
    * @description Returns all fields from the Parts_Invoice__c record Id provided
    * @param  recordId Id of the Parts_Invoice__c to query
    * @return Parts_Invoice__c with all fields queried
    */
    @AuraEnabled(Cacheable=true)
    public static Parts_Invoice__c getReturn(String recordId){
        Parts_Invoice__c pi = (Parts_Invoice__c)Utility.queryAllFields('dealer__Parts_Invoice__c', recordId);
        return pi;
    }

    /**
    * @method getRecordTypeName
    * @description Returns records type name from recordType Id
    * @param  rtId Id of the recordType to get name
    * @return String Name of the record type
    */
    @AuraEnabled
    public static string getRecordTypeName(String rtId){
        List<RecordType> rtName = [SELECT Id, Name FROM RecordType WHERE Id =: rtId];
        if(rtName.size() > 0){
            return rtName[0].Name;
        }
        return null;
    }

    /**
    * @method getPartLines
    * @description Gets all Parts_Invoice_Line__c records for the Parts_Invoice__c Id provided
    * @param  piId Id Parts_Invoice__c record Id to retrieve lines
    * @return List<Parts_Invoice_Line__c> on the invoice
    */
    @AuraEnabled(cacheable=true)
    public static List<Parts_Invoice_Line__c> getPartLines(String piId){
        try{
            Parts_Invoice__c pi = new Parts_Invoice__c(Id = piId);
            return PartsReturnAPI.getInvoiceLines(pi);
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @method getAvailableParts
    * @description Gets all Parts_Inventory__c records matching location from the Parts_Invoice__c Id provided
    * @param  piId Id Parts_Invoice__c record Id to retrieve location
    * @return List<Parts_Inventory__c> related to the location
    */
    @AuraEnabled
    public static List<Parts_Inventory__c> getAvailableParts(String piId){

            Parts_Invoice__c pi = [SELECT Id, Location__c FROM Parts_Invoice__c WHERE Id =: piId];
            if(pi.Location__c == null){
                throw new AuraHandledException('Location must be set on return before adding parts.');
            }
            List<Parts_Inventory__c> availableParts = [SELECT Id, Name, Description__c, Part_No__c FROM Parts_Inventory__c WHERE Location__c =: pi.Location__c] ;

            return availableParts;
    }

    /**
    * @method getAvailableOrders
    * @description Gets all Purchase_Order_Line__c records for a given part that have not been marked returned
    * @param  partId Id Parts_Inventory__c record
    * @return List<Purchase_Order_Line__c> related to the part
    */
    @AuraEnabled
    public static List<Purchase_Order_Line__c> getAvailableOrders(String partId){
            List<Purchase_Order_Line__c> availableOrders = [SELECT Id, Name, Part_Quantity__c, Item_Value__c, Purchase_Order__c, Purchase_Order__r.Name, Purchase_Order__r.Vendor_Name__c, Purchase_Order__r.Invoice_date__c FROM Purchase_Order_Line__c WHERE Part__c =: partId AND Returned_to_Vendor__c = false];

            return availableOrders;
    }

    /**
    * @method saveReturnLine
    * @description Process new return line, checks the order line as returned to vendor and updates ledger
    * @param piId Id of the Parts_Invoice__c to create a line under
    * @param  line Parts_Invoice_Line__c to create
    * @return void
    */
    @AuraEnabled
    public static void saveReturnLine(String piId, Parts_Invoice_Line__c line){
        try{
            system.debug(line);
            Parts_Invoice__c pi = new Parts_Invoice__c(Id = piId);
            PartsReturnAPI.addReturnLine(pi, line);
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @method deleteLine
    * @description removes a return line unchecks the order line as returned to vendor and reverses ledger
    * @param  lineId Parts_Invoice_Line__c to delete
    * @return true upon success
    */
    @AuraEnabled
    public static Boolean deleteLine(String lineId){
        try{
            Parts_Invoice_Line__c line = (Parts_Invoice_Line__c)Utility.queryAllFields('dealer__Parts_Invoice_Line__c', lineId);
            PartsReturnAPI.deleteLine(line);

            return true;

        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}