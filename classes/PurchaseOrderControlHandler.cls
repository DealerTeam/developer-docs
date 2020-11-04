public class PurchaseOrderControlHandler {

    //Before Insert
    public void populateVIN(List<Purchase_Order__c> triggerNew)
    {   
        RecordType [] rt = [SELECT Id, IsActive, Name, Description FROM RecordType WHERE sObjectType = 'dealer__Purchase_Order__c' AND Name ='Sublet'];
        String rtId = rt.size() > 0 ? rt[0].Id : null;

        Map<Id, Service_Repair_Order__c> roMap = new Map<Id, Service_Repair_Order__c>();
        List<Purchase_Order__c> subletPOs = new List<Purchase_Order__c>();
        for(Purchase_Order__c po : triggerNew){
            if(po.VIN__c == null && po.RecordTypeId == rtId && po.Service_Repair_Order__c != null){
                subletPOs.add(po);
                roMap.put(po.Service_Repair_Order__c, new Service_Repair_Order__c());
            }
        }

        for(Service_Repair_Order__c ro : [SELECT Id, VIN_Service_Vehicle__c FROM Service_Repair_Order__c WHERE Id IN: roMap.keySet()]){
            roMap.put(ro.Id, ro);
        }

        for(Purchase_Order__c po : subletPOs){
            po.VIN__c = roMap.get(po.Service_Repair_Order__c).VIN_Service_Vehicle__c;
        }

    }

    //Before Update
    public void validateStatus(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)
    {
        for(Purchase_Order__c objPurchaseOrder : triggernew){
            
            // Check to see that a PO is not reverting from Accepted to Open
            if(objPurchaseOrder.Status__c == 'Open' && triggerOldMap.get(objPurchaseOrder.Id).Status__c == 'Accepted') {
                objPurchaseOrder.addError('Accepted Purchase Orders can not be returned to Open status.');
            }
            
            //Check if company is updated
            if(objPurchaseOrder.dealer__Company__c != null && triggerOldMap.get(objPurchaseOrder.Id).dealer__Company__c != objPurchaseOrder.dealer__Company__c){
                //Add error to prevent user to change company
                objPurchaseOrder.addError('You can not change company of an existing Purchase Order.');
            }
        }
    }

    //Before Update
    public void updatePartTransfers(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)
    {
        Set<Id> PurchaseOrderIdSet = new Set<Id>();    
        List<dealer__PartTransfer__c> PartTransferList = new List<dealer__PartTransfer__c>();
        for(Purchase_Order__c objPurchaseOrder : triggernew){
            
            //Condition to check purchase order status changed to 'Void' from non void status
            if(objPurchaseOrder.dealer__Status__c == 'Void' && triggerOldMap.get(objPurchaseOrder.Id).dealer__Status__c != 'Void'){
                //Add that id to set
                PurchaseOrderIdSet.add(objPurchaseOrder.Id);
            }
            
        }
        //For loop for selected purchase orders
        for(dealer__Purchase_Order__c objPurchaseOrder : [SELECT Id, (SELECT ID, dealer__Status__c FROM dealer__Parts_Transfers__r) FROM dealer__Purchase_Order__c WHERE ID IN : PurchaseOrderIdSet]){
            
            //For loop for all related Part Transfers
            for(dealer__PartTransfer__c objPartTransfer : objPurchaseOrder.dealer__Parts_Transfers__r){
            
                //Changed status of Part Transfer to 'Void'
                objPartTransfer.dealer__Status__c = 'Void';
                
                //Add that part transfer to list that is going to be updated
                PartTransferList.add(objPartTransfer);
            }
        }    

        //Check the size of update list
        if(PartTransferList.size()>0){
            //Update Part Transfer List
            try {
                update PartTransferList;    
            } Catch(DmlException e) {
                Trigger.new[0].addError(e.getMessage());
            }
        }
    }

    //Before Insert || Before Update
    public void updateVendorInfo(List<Purchase_Order__c> triggerNew)
    {
        Set<Id> VendorID = new Set<ID>();
        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.dealer__Purchase_Order__c.getRecordTypeInfosById();
        for(dealer__Purchase_Order__c po : triggerNew) {
            
            // Get Vendor ID's
            if(!VendorID.contains(po.dealer__Vendor__c)) {
                VendorID.add(po.dealer__Vendor__c);
            }

            // Set the Type 
            po.dealer__Type__c = rtMap.get(po.RecordTypeId).getName();
        }
        
        Map<Id, Account> vendor = new Map<Id, Account>([Select Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, dealer__Billing_Email__c 
                                                        From Account where Id IN :VendorID limit 5000]);
                                                        
        //  Process update handle on purchase order
        for(dealer__Purchase_Order__c pu : triggerNew) {
            System.assert(pu.Vendor__c != null,'Required field: Vendor not present');
            pu.dealer__Vendor_Name__c = vendor.get(pu.dealer__Vendor__c).Name;
            pu.dealer__Vendor_Email__c= vendor.get(pu.dealer__Vendor__c).dealer__Billing_Email__c;
            pu.dealer__Vendor_Street__c = vendor.get(pu.dealer__Vendor__c).BillingStreet;
            pu.dealer__Vendor_City__c = vendor.get(pu.dealer__Vendor__c).BillingCity;
            pu.dealer__Vendor_State__c = vendor.get(pu.dealer__Vendor__c).BillingState;
            pu.dealer__Vendor_Postal_Code__c = vendor.get(pu.dealer__Vendor__c).BillingPostalCode;
            pu.dealer__Vendor_Country__c = vendor.get(pu.dealer__Vendor__c).BillingCountry;
        }
    }

    //Before Delete
    public void preventDelete(List<Purchase_Order__c> triggerOld){
        dealer__TriggerControl__c tc = dealer__TriggerControl__c.getOrgDefaults();
        for(dealer__Purchase_Order__c pu : triggerOld) {
            if(tc.dealer__DeletionOverride__c==false) { //This value if set to true should bypass the Error
                pu.addError('Purchase Orders may not be deleted.  Void this Purchase Order instead.');
            }
        }
    }

}
