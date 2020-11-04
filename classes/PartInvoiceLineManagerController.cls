public with sharing class PartInvoiceLineManagerController {
    public PartInvoiceLineManagerController() {}

    @AuraEnabled
    public static dealer__Parts_Inventory__c getPartDetails(Id partId) {
        try {
            return getInventoryById(partId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> partSearchByLocation(string searchTerm, Id locationId) {
        try {
            LookupSearchPartsInventory s = new LookupSearchPartsInventory();
            return s.searchByLocation(searchTerm,locationId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> partsMasterSearchByMfg(string searchTerm, String mfg) {
        try {
            LookupSearchPartMaster s = new LookupSearchPartMaster();
            return s.searchByMfg(searchTerm,mfg);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Parts_Inventory__c getPartByMasterLocation(string masterId, Id locationId) {
        try {
            
            Parts_Inventory__c part;
            
            Parts_Inventory__c[] parts = [SELECT  
                Name, MFG__c, Part_Number__c, Part_No__c, Description__c, Cost__c, Bin__c,Last_Sale_Date__c, Status__c, On_Hand__C, On_Order__c, On_Special_Order__c, On_Back_Order__c, Entry_Date__c 
            FROM Parts_Inventory__c 
            WHERE Location__c =: locationId
                AND Parts_Master__c =: masterId
            LIMIT 1];

            // Without an inventory item we'll create one.
            if(parts.size() <= 0) {
                // List <Parts_Master__c> masterItems, Id location
                Parts_Master__c m =  new Parts_Master__c();
                m.Id = masterId;
                List<Parts_Master__c> pms = new List <Parts_Master__c>();
                pms.add(m);
                Map<Id, Parts_Inventory__c> newInvMap = PartAPI.createInventoryFromMaster(pms,locationId);

                // single part returned since we are dealing with a single part lookup
                part = newInvMap.values().get(0);
            } else {
                part = parts.get(0);
            }

            return part;

        } catch (AuraHandledException e) {
            throw new AuraHandledException(e.getMessage());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Parts_Invoice_Line__c> addInvoicePartLine(Id invoiceId, Id partId, Decimal quantity, Decimal salePrice) {

        try {

            /* addInvoiceLine(
                Id invoiceId, 
                Id jobLineId, 
                Id partId, 
                Decimal quantity, 
                Decimal salePrice, 
                String comment) 
            */
            Parts_Invoice_Line__c newLine = PartInvoiceAPI.addInvoiceLine(
                invoiceId, 
                null, 
                partId, 
                quantity, 
                salePrice, 
                null
            );

            return PartInvoiceAPI.invoiceLines(invoiceId);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Parts_Invoice_Line__c updatePartLine(Id lineId, Decimal quantity, Decimal salePrice) {
        try {
            return PartInvoiceAPI.updateInvoiceLine(lineId,  quantity, salePrice, '');

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Parts_Invoice_Line__c editPartLine(Parts_Invoice_Line__c line) {
        try {

            System.debug(line);

            Id lineId = line.Id;
            Decimal quantity = (line.dealer__Quantity_Sold__c != null) ?line.dealer__Quantity_Sold__c : null;
            Decimal salePrice = (line.dealer__Price__c!=null) ?line.dealer__Price__c : null;
            String comment = (line.dealer__Comment__c!=null) ? line.dealer__Comment__c : null;

            return PartInvoiceAPI.updateInvoiceLine(lineId,  quantity, salePrice, comment);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Parts_Invoice_Line__c> getPartLinesByInvoice(Id invoiceId) {
        try {
            return PartInvoiceAPI.invoiceLines(invoiceId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean deletePartLine(Id lineId) {
        try {
            List<Parts_Invoice_Line__c> deleteLines = new List<Parts_Invoice_Line__c>();

            deleteLines.add( new Parts_Invoice_Line__c (
                Id = lineId
            ));
            return PartInvoiceAPI.removeInvoiceLine(deleteLines);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static dealer__Parts_Inventory__c getInventoryById(Id invId) {
        return [
            SELECT Id, Name, dealer__Bin__c, dealer__Source__c, dealer__Part_No__c, 
            dealer__Comments__c, dealer__List__c, dealer__Cost__c, dealer__Description__c, 
            dealer__Pack_QTY__c, dealer__On_Hand__c, dealer__On_Order__c, dealer__Core__c, 
            dealer__MFG__c, dealer__Kit__c, dealer__Parts_Master__c
            FROM dealer__Parts_Inventory__c
            WHERE Id = :invId
            LIMIT 1]; 
    }   

    public class PartLine {

        @AuraEnabled
        public String partId;
        @AuraEnabled
        public String partName;
        @AuraEnabled
        public String partDescription;
    }
}