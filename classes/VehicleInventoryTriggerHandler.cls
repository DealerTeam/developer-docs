/**
* Date            |Developer            |Work#
* Notes
* --
* 2016-11-10    |Sneha Utture    |W-000642
* Implement Trigger Framework
*/
public class VehicleInventoryTriggerHandler {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    public static boolean IsFromBachJob ;
    public static boolean isFromUploadAPI=false;
    public static boolean IsVehicleUpdate=false ;
    
    public VehicleInventoryTriggerHandler(boolean isExecuting, integer size)
    {
        m_isExecuting = isExecuting;
        BatchSize = size;
    }           

    public void OnBeforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)
    {
        system.debug('dealer__Vehicle_Inventory__c Trigger On Before Insert');
        VehicleInventoryUtility.beforeInsert(newVehicle);
    }
    public void OnAfterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)
    {
        system.debug('dealer__Vehicle_Inventory__c Trigger On After Insert');
        IsVehicleUpdate = VehicleInventoryUtility.afterInsert(newVehicle);
        VehicleInventoryUtility.afterInsertStockBookUpdate(newVehicle);
    }
    public void OnAfterUpdate( List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap , Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )
    {
        system.debug('dealer__Vehicle_Inventory__c Trigger On After Update ');
        IsVehicleUpdate = VehicleInventoryUtility.afterUpdate (newVehicle,newVehicleMap,oldVehicleMap);
    }
    public void OnBeforeUpdate( List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap , Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )
    {
        system.debug('dealer__Vehicle_Inventory__c Trigger On Before Update ');
        VehicleInventoryUtility.beforeUpdate(newVehicle,oldVehicleMap);
    }

    @future 
    public static void OnAfterUpdateAsync(Set<ID> newVehicleIDs)
    {

    }      
    public boolean IsTriggerContext
    {
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext
    {
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext
    {
        get{ return !IsTriggerContext;}
    }

}