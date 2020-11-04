@RestResource(urlMapping = '/purchaseorder/create/*')
global with sharing class PurchaseOrderRESTService {
    public PurchaseOrderRESTService() {

    }
    /**
     * createPurchaseOrder
     * @returns Id of purchase order created
     * @test PartOrderingServiceLayer.testPORESTService
     */
    @HttpPost
    global static Id createPurchaseOrder() {

        String body = System.RestContext.request.requestBody.toString();
        List < Purchase_order_Line__c > poLines = new List < Purchase_order_Line__c > ();

        Purchase_Order__c po = (Purchase_Order__c) JSON.deserialize(body, dealer__Purchase_Order__c.class); // Gives us the header
        Map < String, Object > m = (Map < String, Object > ) JSON.deserializeUntyped(body);
        Map < String, Object > ml = (Map < String, Object > ) m.get('dealer__Purchase_Order_Line__r');

        // Determine record type based on the "Type__c"
        for(RecordType rt: [SELECT NamespacePrefix, DeveloperName, Name, Id, Description, SobjectType FROM RecordType WHERE SobjectType = 'dealer__Purchase_Order__c']) {
            if(po.Type__c == 'Parts' && rt.DeveloperName == 'Parts_Purchase') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Sublet' && rt.DeveloperName == 'Sublet') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Misc' && rt.DeveloperName == 'Misc') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Vehicle Purchase' && rt.DeveloperName == 'Vehicle_Purchase') {
                po.RecordTypeId = rt.Id;
            }
        }

        ////Po Lines of this Purchase Order in Payload
        if(ml != null) {
            String lines = JSON.serialize(ml.get('records'));
            poLines = (List < Purchase_Order_Line__c > ) JSON.deserialize(lines, List < dealer__Purchase_Order_Line__c > .class);
        }

        try {

            Dealer_Location__c location = [SELECT Id FROM Dealer_Location__c WHERE Company_Number__c =: po.Company__c LIMIT 1];
            po.Company__c = location.Id;
            PurchaseOrderAPI.create(po, poLines);
            po = [SELECT Id, Name, Status__c, (SELECT Id, Name, Amount__c FROM Purchase_Order_Line__r ) FROM Purchase_Order__c WHERE Id=:po.Id];

            return po.Id;

        } catch(DMLException e) {
            throw new PurchaseOrderRestServiceException(e.getMessage());
        }

        return null;
    }
    /**
     * Can update Purchase Order OR create new lines for a purchase order
     * Can use HTTP Put to do the
     * @returns String of JSON serialized PO
     * @test PartOrderingServiceLayer.testPORESTService
     */ 
    @HttpPut
    global static String updatePurchaseOrder() {
        
        String body = System.RestContext.request.requestBody.toString();
        Purchase_Order__c po = (Purchase_Order__c) JSON.deserialize(body, dealer__Purchase_Order__c.class);
        List < Purchase_order_Line__c > poLines = new List < Purchase_order_Line__c > ();

        Map < String, Object > m = (Map < String, Object > ) JSON.deserializeUntyped(body);
        Map < String, Object > ml = (Map < String, Object > ) m.get('dealer__Purchase_Order_Line__r');

        if(ml != null) {
            String lines = JSON.serialize(ml.get('records'));
            poLines = (List < Purchase_Order_Line__c > ) JSON.deserialize(lines, List < dealer__Purchase_Order_Line__c > .class);
        }
        //we need one of these fields
        if(po.Id == null && po.Name == null)
            throw new PurchaseOrderRestServiceException('We need either a valid Purchase Order Name or Id in the Put callout header.');

        Purchase_Order__c p = new Purchase_Order__c();
        List < Purchase_Order__c > pl = [SELECT Id, Company__c FROM Purchase_Order__c WHERE Name =: po.Name OR Id =: po.Id LIMIT 1];
        if(pl.size() == 0) throw new PurchaseOrderRestServiceException('No Purchase Orders found using the Name or Id provided.');

        p = pl[0];
        po.Id = p.Id;
        po.Company__c = p.Company__c;

        // Update record type based on the "Type__c"
        for(RecordType rt: [SELECT NamespacePrefix, DeveloperName, Name, Id, Description, SobjectType FROM RecordType WHERE SobjectType = 'dealer__Purchase_Order__c']) {
            if(po.Type__c == 'Parts' && rt.DeveloperName == 'Parts_Purchase') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Sublet' && rt.DeveloperName == 'Sublet') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Misc' && rt.DeveloperName == 'Misc') {
                po.RecordTypeId = rt.Id;
            }

            if(po.Type__c == 'Vehicle Purchase' && rt.DeveloperName == 'Vehicle_Purchase') {
                po.RecordTypeId = rt.Id;
            }
        }

        try {
            PurchaseOrderAPI.updatePO(po, poLines);
            return JSON.serialize(po);
        } catch(DMLException e) {
            throw new PurchaseOrderRestServiceException(e.getMessage());
        }

        return null;
    }
    //to process the PO(void etc.)
    @HttpPatch
    global static String processPurchaseOrder() {
        return null;
    }
    /**
     * Handle httpdelete for PO Lines
     * @test PartOrderingServiceLayer.testPORESTService
     */
    @HttpDelete
    global static Void deletePOLines() {
        RestRequest request = RestContext.request;
        List < Purchase_Order_Line__c > poLines = new List < Purchase_order_Line__c > ();
        String rList = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1);

        if(rList != null) {
            rList = rList.replace('[', '');
            rList = rList.replace(']', '');
            rList = rList.replace('"', '');
            List < String > idList = rList.split(',');
            if(idList.size() >= 1) {
                for(String id: idList) {
                    poLines.add(new Purchase_Order_Line__c(
                        Id = (Id) Id
                    ));
                }

            }
        }
        PurchaseOrderAPI.deletePurchaseOrderLines(poLines);
    }

    Public class PurchaseOrderRestServiceException extends Exception {

    }
}