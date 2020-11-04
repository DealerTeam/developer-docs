/**
 * BatchUpdateVehicleInternalCharges
 * @descriptionBatch Class to populate Vehicle Inventory internal charges fields from related SROs upon package installation
 **/
global with sharing class BatchUpdateVehicleInternalCharges implements Database.Batchable<sObject> {
	
    /**
     * start 
     * @param  BC 
     * @description Collect the batches of records to be passed to execute
     */
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
         
        String query = 'SELECT Id, Name, dealer__Internal_Charges__c, dealer__Internal_Labor__c, dealer__Internal_Misc__c, dealer__Internal_Parts__c, dealer__Internal_Sublet__c, dealer__Work_in_Process__c, dealer__WIP_Labor__c, dealer__WIP_Misc__c, dealer__WIP_Parts__c, dealer__WIP_Sublet__c, ';
               query += '(SELECT Id, Name, dealer__Internal_Charges__c, dealer__Status__c, dealer__Internal_Labor_Charges__c, dealer__Internal_Misc_Charges__c, dealer__Internal_Parts_Charges__c, dealer__Customer_Sublet_Charges__c '; 
               query += 'FROM dealer__Service_Repair_Orders__r) FROM dealer__Vehicle_Inventory__c';
        
        return Database.getQueryLocator(query);
    }
    
    /**
     * execute 
     * @param  BC        
     * @param  vehicleList 
     * @return void
     * @description Process each batch of records
     */
    global void execute(Database.BatchableContext BC, List<dealer__Vehicle_Inventory__c> vehicleList) 
    {
        
        List<dealer__Vehicle_Inventory__c> vehicleInventoryToUpdateList = new List<dealer__Vehicle_Inventory__c>();
        
        for(dealer__Vehicle_Inventory__c objVehicleInventory : vehicleList){
 
         	//Initialize Internal charges to 0.0
            objVehicleInventory.dealer__Internal_Charges__c = 0.0;
            objVehicleInventory.dealer__Internal_Labor__c = 0.0;
            objVehicleInventory.dealer__Internal_Misc__c = 0.0;
            objVehicleInventory.dealer__Internal_Parts__c = 0.0;
            objVehicleInventory.dealer__Internal_Sublet__c = 0.0;
                                                                    
            //Initialize Work in process to 0.0
            objVehicleInventory.dealer__Work_in_Process__c = 0.0;            
            objVehicleInventory.dealer__WIP_Labor__c = 0.0;
            objVehicleInventory.dealer__WIP_Misc__c = 0.0;
            objVehicleInventory.dealer__WIP_Parts__c = 0.0;
            objVehicleInventory.dealer__WIP_Sublet__c = 0.0;
                                                                    
            //For loop to rollup internal charges on Vehicle Inventory
            for(dealer__Service_Repair_Order__c objServiceRepairOrder : objVehicleInventory.dealer__Service_Repair_Orders__r){                  

                //If SRO is having internal charges and status is Posted
                if(objServiceRepairOrder.dealer__Status__c == 'Posted'){
                    
                    //Add SRO's Internal Charges into Vehicle Invetory's Internal charges
                    if(objServiceRepairOrder.dealer__Internal_Charges__c != null) objVehicleInventory.dealer__Internal_Charges__c += objServiceRepairOrder.dealer__Internal_Charges__c;   
                    if(objServiceRepairOrder.dealer__Internal_Labor_Charges__c != null) objVehicleInventory.dealer__Internal_Labor__c += objServiceRepairOrder.dealer__Internal_Labor_Charges__c;   
                    if(objServiceRepairOrder.dealer__Internal_Misc_Charges__c != null) objVehicleInventory.dealer__Internal_Misc__c += objServiceRepairOrder.dealer__Internal_Misc_Charges__c;   
                    if(objServiceRepairOrder.dealer__Internal_Parts_Charges__c != null) objVehicleInventory.dealer__Internal_Parts__c += objServiceRepairOrder.dealer__Internal_Parts_Charges__c;   
                    if(objServiceRepairOrder.dealer__Customer_Sublet_Charges__c != null) objVehicleInventory.dealer__Internal_Sublet__c += objServiceRepairOrder.dealer__Customer_Sublet_Charges__c;   
                }
                
                //Else SRO is having Non-Posted status
                else if(objServiceRepairOrder.dealer__Status__c != 'Posted'){
                    
                    //Add SRO's Internal Charges into Vehicle Invetory's Work In Process field
                    if(objServiceRepairOrder.dealer__Internal_Charges__c != null) objVehicleInventory.dealer__Work_in_Process__c += objServiceRepairOrder.dealer__Internal_Charges__c;                                      
              		if(objServiceRepairOrder.dealer__Internal_Labor_Charges__c != null) objVehicleInventory.dealer__WIP_Labor__c += objServiceRepairOrder.dealer__Internal_Labor_Charges__c;   
                    if(objServiceRepairOrder.dealer__Internal_Misc_Charges__c != null) objVehicleInventory.dealer__WIP_Misc__c += objServiceRepairOrder.dealer__Internal_Misc_Charges__c;   
                    if(objServiceRepairOrder.dealer__Internal_Parts_Charges__c != null) objVehicleInventory.dealer__WIP_Parts__c += objServiceRepairOrder.dealer__Internal_Parts_Charges__c;   
                    if(objServiceRepairOrder.dealer__Customer_Sublet_Charges__c != null) objVehicleInventory.dealer__WIP_Sublet__c += objServiceRepairOrder.dealer__Customer_Sublet_Charges__c;   
                
                }
            }
            
            //Add Vehicle Inventory to list that is going to update
            vehicleInventoryToUpdateList.add(objVehicleInventory);            
        }
        
        try {
            //Update Vehicle Inventory
        	update vehicleInventoryToUpdateList;
         
        } catch(Exception e) {
            System.debug(e);
        }

    }   

    /**
     * finish 
     * @param BC 
     * @return void
     * @description
     */ 
    global void finish(Database.BatchableContext BC) 
    {
  	}
}