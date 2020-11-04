/**
 * MergePartMasterAPI
 * @description API class for merging 2 or more Part Master records along with their children and grand children.
 */
public with sharing class MergePartMasterAPI {

	/**
     * getPartMaster 
     * @param List<dealer__Parts_Master__c>
     * @return List<dealer__Parts_Master__c>
     * @description Returns Part Master records with selected fields for processing.
     * @test PartPhysicalInventoryServiceLayer.testMergePartMaster 
     */
	public static List<dealer__Parts_Master__c> getPartMaster(List<dealer__Parts_Master__c> ListPM)
	{
		 Set<ID> SelectedPM = new Set<ID>();
        for(dealer__Parts_Master__c obj: ListPM)
        {
            SelectedPM.add(obj.id);
        }
        return (List<dealer__Parts_Master__c>) [Select id, name, dealer__Part_Description__c, dealer__Part_No__c, createdDate, lastModifiedDate, dealer__Status__c, createdBy.name, lastModifiedBy.name  from dealer__Parts_Master__c where id in: SelectedPM];
	}

	/**
     * getPartLocOnhand 
     * @param List<dealer__Parts_Master__c>
     * @return map<id,List<dealer__Parts_Inventory__c>>
     * @description Returns Map to store Parts data for each Part Master.
     * @test PartPhysicalInventoryServiceLayer.testMergePartMaster 
     */
	public static map<id,List<dealer__Parts_Inventory__c>> getPartLocOnhand(List<dealer__Parts_Master__c> ListPM) 
    {

        map<id,List<dealer__Parts_Inventory__c>> mapLocationQuantity = new map<id,list<dealer__Parts_Inventory__c>>();
        Set<ID> AllPM = new Set<ID>();

        for(dealer__Parts_Master__c obj: ListPM)
        {
            AllPM.add(obj.id);   
            mapLocationQuantity.put(obj.id, new list<dealer__Parts_Inventory__c>());             
        }

        List<dealer__Parts_Inventory__c> ListAllParts = [SELECT id, name, dealer__Location__c, dealer__On_Hand__c, dealer__Parts_Master__c, dealer__Location__r.name FROM dealer__Parts_Inventory__c WHERE dealer__Parts_Master__c IN: AllPM];
        
 
        system.debug('ListAllParts >>'+ListAllParts);

        for(dealer__Parts_Inventory__c obj: ListAllParts)
        {
            mapLocationQuantity.get(obj.dealer__Parts_Master__c).add(obj);   
        }

        system.debug('mapLocationQuantity >>'+mapLocationQuantity);
        return mapLocationQuantity;
    }

    /**
     * getPartLocOnhand 
     * @param List<dealer__Parts_Master__c>
     * @return boolean
     * @description Method to perform perform merge activity.  
     * Returns true if Merge is successful else set a Apex Page error message and returns false.
     * @test PartPhysicalInventoryServiceLayer.testMergePartMaster
     */
    public static boolean mergeRecord(List<dealer__Parts_Master__c> ListPM, String MasterRec)
    {
        List<dealer__Parts_Master__c> ListDuplicatePM = new List<dealer__Parts_Master__c>();
        List<dealer__Parts_Master__c> MasterPM = new List<dealer__Parts_Master__c>();
        List<dealer__Parts_Inventory__c> ListAllParts = new List<dealer__Parts_Inventory__c>();
        List<dealer__Parts_Ledger__c> ListPartLedger = new List<dealer__Parts_Ledger__c>();
        List<dealer__Parts_Order__c> ListPartOrder = new List<dealer__Parts_Order__c>();

    /**
     * Database.setSavepoint description
     * @description
     */
    Savepoint sp = Database.setSavepoint();

        system.debug('ListPM All Selected Records>>'+ListPM);
        system.debug('Selected as Master >> '+MasterRec);

        try{
            Set<ID> ToBeMergeIDs = new Set<ID>();

            for(dealer__Parts_Master__c obj: ListPM)
            {
                if(obj.id != MasterRec)
                {
                    ToBeMergeIDs.add(obj.id);                
                }
            }

            system.debug('Selected as ToBeMergeIDs >> '+ToBeMergeIDs);

            ListDuplicatePM = [SELECT id, name, dealer__Retail_Price__c FROM dealer__Parts_Master__c WHERE id IN: ToBeMergeIDs];
            MasterPM = [SELECT id, name, dealer__Retail_Price__c FROM dealer__Parts_Master__c WHERE id =: MasterRec];

            ListAllParts = [SELECT id, name, dealer__Location__c, dealer__On_Hand__c FROM dealer__Parts_Inventory__c WHERE (dealer__Parts_Master__c IN: ToBeMergeIDs OR dealer__Parts_Master__c =: MasterRec)];
            
            Map<String, Decimal> mapLocationQty = new Map<String, Decimal>();
            Map<String, dealer__Parts_Inventory__c> mapLocationPart = new Map<String, dealer__Parts_Inventory__c>();
            Map<ID,dealer__Parts_Inventory__c> mapLocationPartForDelete = new map<ID,dealer__Parts_Inventory__c>();
            List<dealer__Purchase_Order_Line__c> ListPurchaseOrderLine = new List<dealer__Purchase_Order_Line__c>();
            List<dealer__Part_Inventory_History__c> ListPartHistory = new List<dealer__Part_Inventory_History__c>();
            List<dealer__Parts_Invoice_Line__c> ListPartInvoiceLine = new List<dealer__Parts_Invoice_Line__c>();
            List<dealer__Parts_Kit_Item__c> ListPartKitItem = new List<dealer__Parts_Kit_Item__c>();

            for(dealer__Parts_Inventory__c obj: ListAllParts)
            {
                //Create map to store Location and one part id for each location
                if(!mapLocationPart.containsKey(obj.dealer__Location__c))
                {
                    mapLocationPart.put(obj.dealer__Location__c, obj);
                }
                else
                {
                    mapLocationPartForDelete.put(obj.id, obj);
                }

                //Create map to store location and sum of On-hand value
                if(!mapLocationQty.containsKey(obj.dealer__Location__c))
                {
                    mapLocationQty.put(obj.dealer__Location__c, obj.dealer__On_Hand__c);
                }
                else
                {
                    mapLocationQty.put(obj.dealer__Location__c, mapLocationQty.get(obj.dealer__Location__c)+obj.dealer__On_Hand__c);
                }
            }


            for(dealer__Parts_Inventory__c obj: mapLocationPart.values())
            {
                obj.dealer__On_Hand__c = mapLocationQty.get(obj.dealer__Location__c);
                obj.dealer__Parts_Master__c = MasterRec;
            }

            // Part Ledger records update to the choosen Part Master related parts 
            ListPartLedger = [Select id, name, dealer__Part__c, dealer__Current_Value__c, dealer__Entry_Date__c, dealer__Item_Value__c, dealer__Parts_Sale_Line__c, dealer__Purchased_By__c, dealer__Purchase_Order__c, dealer__Quantity__c, dealer__Repair_Order_Line__c, dealer__Sold_By__c, dealer__Transaction_Note__c, dealer__Part__r.dealer__Location__c from dealer__Parts_Ledger__c where dealer__Part__c IN: mapLocationPartForDelete.keySet()];
            List<dealer__Parts_Ledger__c> ListAddPartLedger = new List<dealer__Parts_Ledger__c>();

            for(dealer__Parts_Ledger__c obj: ListPartLedger)
            {   
                dealer__Parts_Ledger__c objNew = new dealer__Parts_Ledger__c();
                objNew = obj.clone(false, false, false, false);
                objNew.dealer__Part__c = mapLocationPart.get(obj.dealer__Part__r.dealer__Location__c).id;
                ListAddPartLedger.add(objNew);
            }
            insert ListAddPartLedger;
            delete ListPartLedger;


            // dealer__Parts_Order__c records update to the choosen Part Master related parts 
            ListPartOrder = [Select id, name, dealer__Parts_Inventory__c, dealer__Parts_Inventory__r.dealer__Location__c from dealer__Parts_Order__c where dealer__Parts_Inventory__c IN: mapLocationPartForDelete.keySet()];

            for(dealer__Parts_Order__c obj: ListPartOrder)
            {
                obj.dealer__Parts_Inventory__c = mapLocationPart.get(obj.dealer__Parts_Inventory__r.dealer__Location__c).id;
            }
            update ListPartOrder;


            // dealer__Purchase_Order_Line__c records update to the choosen Part Master related parts 
            ListPurchaseOrderLine = [Select id, name, dealer__Part__c, dealer__Part__r.dealer__Location__c from dealer__Purchase_Order_Line__c where dealer__Part__c IN: mapLocationPartForDelete.keySet()];

            for(dealer__Purchase_Order_Line__c obj: ListPurchaseOrderLine)
            {
                obj.dealer__Part__c = mapLocationPart.get(obj.dealer__Part__r.dealer__Location__c).id;
            }
            update ListPurchaseOrderLine; //"Part may not be changed on an Accepted/Posted Purchase Order" --------------------


            // dealer__Part_Inventory_History__c records update to the choosen Part Master related parts 
            ListPartHistory = [Select id, name, dealer__Part__c, dealer__Part__r.dealer__Location__c from dealer__Part_Inventory_History__c where dealer__Part__c IN: mapLocationPartForDelete.keySet()];

            for(dealer__Part_Inventory_History__c obj: ListPartHistory)
            {
                obj.dealer__Part__c = mapLocationPart.get(obj.dealer__Part__r.dealer__Location__c).id;
            }
            update ListPartHistory;


            // dealer__Parts_Invoice_Line__c records update to the choosen Part Master related parts 
            ListPartInvoiceLine = [Select id, name, dealer__Part__c, dealer__Part__r.dealer__Location__c from dealer__Parts_Invoice_Line__c where dealer__Part__c IN: mapLocationPartForDelete.keySet()];

            for(dealer__Parts_Invoice_Line__c obj: ListPartInvoiceLine)
            {
                obj.dealer__Part__c = mapLocationPart.get(obj.dealer__Part__r.dealer__Location__c).id;
            }
            update ListPartInvoiceLine;

            
            // dealer__Parts_Kit_Item__c records update to the choosen Part Master related parts 
            ListPartKitItem = [Select id, name, dealer__Part__c, dealer__Part__r.dealer__Location__c, dealer__Parts_Master__c from dealer__Parts_Kit_Item__c where (dealer__Part__c IN: mapLocationPartForDelete.keySet() OR dealer__Parts_Master__c IN:ToBeMergeIDs)];

            for(dealer__Parts_Kit_Item__c obj: ListPartKitItem)
            {   
                if(mapLocationPart.containsKey(obj.dealer__Part__r.dealer__Location__c))
                {
                    obj.dealer__Part__c = mapLocationPart.get(obj.dealer__Part__r.dealer__Location__c).id;
                }
                if(ToBeMergeIDs.contains(obj.dealer__Parts_Master__c))
                {
                    obj.dealer__Parts_Master__c = MasterRec;
                }
            }
            update ListPartKitItem;


            Update mapLocationPart.values();
            system.debug('Updated Parts to new Part Master >>'+mapLocationPart.values());
            
            Delete mapLocationPartForDelete.values();
            system.debug('Deleted Parts >>' + mapLocationPartForDelete.values());
            
            //Supersede Old Part Master with new one.
            List<dealer__PartSupersession__c> supersession = new List<dealer__PartSupersession__c>();
            for(dealer__Parts_Master__c obj:ListDuplicatePM)
            {
                supersession.add(new dealer__PartSupersession__c(
                                                        dealer__Parts_Master__c=MasterRec,
                                                        dealer__Old_Part__c=obj.name
                                                   ));
            }
            insert supersession;
            system.debug('Created Supersession >>'+supersession);

            Delete ListDuplicatePM;
            system.debug('Deleted Duplicate Part Masters >>' + ListDuplicatePM);
        }
        catch(Exception e)
        {   
            system.debug('Exception >>'+ e.getMessage() + e.getLineNumber());
            Database.rollback(sp);
            throw new PartsMasterException('MergePartMasterAPI Exception >>'+ e.getMessage() +' Line #: '+ e.getLineNumber());
            return false;
        }

        return true;
	}

    /**
     * @description
     */
	public class PartsMasterException extends Exception{}

}