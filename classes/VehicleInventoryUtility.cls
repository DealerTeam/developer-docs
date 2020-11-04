/**
* Date            |Developer            |Work#
* Notes
* --
* 2016-11-10    |Sneha Utture    |W-000642
* Implement Trigger Framework
*/

/**
 *  Date          |Developer            |Work#
 *  2018-06-14    |Oscar Quintela       |W-001685
 */
public class VehicleInventoryUtility {

    //Before Insert Context - Populate Name,dealer__NUO__c,dealer__Last_6__c
    public static void beforeInsert ( List<dealer__Vehicle_Inventory__c> newVehicle){
            
        Set<Id> recordTypeIds = new Set<Id>();
        Set<Id> setLocationId = new Set<Id>();
        Map<Id, String> mapStoreLocs = new Map<Id, String>();
        List<dealer__Vehicle_Inventory__c> convVehicles = new List<dealer__Vehicle_Inventory__c>();

        for(dealer__Vehicle_Inventory__c v : newVehicle) {
            recordTypeIds.add(v.RecordTypeId);//get related record type
            setLocationId.add(v.dealer__Store_Location__c);//get related location info
            if(v.Conversion__c != null){
                convVehicles.add(v);
            }
        }

        // get related record type information.  
        Map<Id, RecordType> recordTypeInfo = new Map<Id, RecordType>([Select Id, NameSpacePrefix, DeveloperName from RecordType where Id IN:recordTypeIds limit 2000]);
        
        //Get the related store locations with company number
        for(dealer__Dealer_Location__c dl : [SELECT Id, dealer__Company_Number__c from dealer__Dealer_Location__c where id in :setLocationId]){
            mapStoreLocs.put(dl.Id, dl.dealer__Company_Number__c);
        }

        for(dealer__Vehicle_Inventory__c v : newVehicle) {
            //Update Vehicle Name
            if(v.RecordTypeId!=null && recordTypeInfo.get(v.RecordTypeId)!=null && recordTypeInfo.get(v.RecordTypeId).NameSpacePrefix == 'dealer') {
                v.Name = '('+v.Stock_Number__c+') '+v.Year__c+' '+v.Make__c+' '+v.Model__c;
            }
            
            //Update dealer__NUO__c field
			System.debug(v.RecordTypeId);
            System.debug(recordTypeInfo);
            System.debug(recordTypeInfo.get(v.RecordTypeId));
            
            if(v.RecordTypeId != null) {
            if((recordTypeInfo.get(v.RecordTypeId)!=null && recordTypeInfo.get(v.RecordTypeId).DeveloperName!=null) && 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'New' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Demo' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Used' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Fleet' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Other') { 

                v.dealer__NUO__c = recordTypeInfo.get(v.RecordTypeId).DeveloperName.substring(0,1);
            }
            }

            //update last 6 char of VIN
            if(v.dealer__VIN__c != null) {
                v.dealer__Last_6__c = v.dealer__VIN__c.right(6);
            }

            //Update Company Number
            if(v.dealer__Store_Location__c!=null && mapStoreLocs.get(v.dealer__Store_Location__c)!=null){
                v.dealer__Company_Number__c = mapStoreLocs.get(v.dealer__Store_Location__c);
            }

            v.Retail_Price__c = v.Retail_Price__c != null ? v.Retail_Price__c : 0;
            v.Conversion_Price__c = v.Conversion_Price__c != null ? v.Conversion_Price__c : 0;
            v.TotalVehiclePrice__c = v.Retail_Price__c + v.Conversion_Price__c;
            
        }

        if(convVehicles.size() > 0){
            populateConversionData(convVehicles);
        }
    }

    //After Insert Context - Find associated desired vehicle sales up and create tasks
    public static boolean afterInsert ( List<dealer__Vehicle_Inventory__c> newVehicle )
    {
        // Get user customized settings for applicaiton of Trigger
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        
        if(crm.Inv_Match_Alert__c == true){

            //Create a string of make, model, year, trim and add it to the list.
            Set<String> MakeModelYearTrim = new Set<String>();
            Map<String, String> stockNumtoMMYT = new Map<String, String>();
            List<dealer__Desired_Vehicle__c> dVList1 = new List<dealer__Desired_Vehicle__c>();
            List<Task> Sales_Up_TaskList = new List<Task>();
            Set<Id> activeUserIds = new Set<Id>();
            Set<Id> ownerIds = new Set<Id>();

            for(dealer__Vehicle_Inventory__c vehicleinventory: newVehicle){
                String Make='';
                String Model='';
                String Year='';
                String TrimLevel='';
                String total='';
                if(vehicleinventory.dealer__Make__c != null){
                    Make = vehicleinventory.dealer__Make__c;
                }

                if(vehicleinventory.dealer__Model__c != null){
                    Model = vehicleinventory.dealer__Model__c;
                }
                if(vehicleinventory.dealer__Year__c != null){
                    Year = vehicleinventory.dealer__Year__c;
                }
                if(vehicleinventory.dealer__Trim_Level__c != null){
                    TrimLevel = vehicleinventory.dealer__Trim_Level__c;
                }

                total= Make+Model+Year+TrimLevel;
                MakeModelYearTrim.add(total);
                stockNumtoMMYT.put(total, vehicleinventory.dealer__Stock_Number__c);

            }
            
            //Query for desired vehicles that match and then create tasks for those sales ups.
            dVList1=[SELECT ID,Name,dealer__Make__c,dealer__Model__c,dealer__Year__c,dealer__Trim_Level__c,
                            dealer__Sales_Up__c,dealer__Sales_Up__r.OwnerID,dealer__MakeModelYearTrim__c 
                        FROM dealer__Desired_Vehicle__c 
                        WHERE dealer__MakeModelYearTrim__c 
                        IN :MakeModelYearTrim 
                        AND dealer__Sales_Up__c!=null 
                        AND dealer__Sales_Up__r.Disposition__c='Open'];

            for(dealer__Desired_Vehicle__c dv:dVList1){
                ownerIds.add(dv.dealer__Sales_Up__r.OwnerID);
            }    

            for(User u:[select id from User where id in:ownerIds and isActive=true]){
                activeUserIds.add(u.id);
            }

            for(dealer__Desired_Vehicle__c DV:dVList1){
                    
                String Make, Model, Year, TrimLevel;
                if(DV.dealer__Make__c == null)
                    Make = '';
                else
                    Make = DV.dealer__Make__c.ToLowerCase();

                if(DV.dealer__Model__c == null)
                    Model = '';
                else
                    Model = DV.dealer__Model__c.ToLowerCase();

                if(DV.dealer__Year__c == null)
                    Year = '';
                else
                    Year = DV.dealer__Year__c.ToLowerCase();

                if(DV.dealer__Trim_Level__c == null)
                    TrimLevel = '';
                else
                    TrimLevel = DV.dealer__Trim_Level__c.ToLowerCase();
                
                Task Sales_Up_Task = new Task();
                Sales_Up_Task.WhatId = DV.Sales_Up__c;
                Sales_Up_Task.OwnerId = dv.Sales_Up__r.OwnerId;
                Sales_Up_Task.ActivityDate = Date.today();
                Sales_Up_Task.Subject = 'Inventory Match '+Year+' '+Model+' '+Make;
                Sales_Up_Task.Description = ' Possible inventory match on the customers desired vehicle. '+'\n'+'Desired Vehicle : '+DV.Name
                                            +' New stock: '+stockNumtoMMYT.get(DV.dealer__MakeModelYearTrim__c);
                
                if(activeUserIds.contains(dv.Sales_Up__r.OwnerId)) {
                    Sales_Up_TaskList.add(Sales_Up_Task);
                }
            }
            if(Sales_Up_TaskList!=null && Sales_Up_TaskList.size()>0){
                insert Sales_Up_TaskList;
            }

        }//end if custom setting

        //Create Status Code if Status is not blank
        createStatusCode(newVehicle,false,new Map<Id,dealer__Vehicle_Inventory__c>());

        //create/update service vehicle
        boolean isVehicleUpdated; 

        if(checkCreateServiceVehicle(newVehicle, null, false)) {
            isVehicleUpdated = createServiceVehicle(newVehicle, null, false);
        } else {
            isVehicleUpdated = false;
        }
        
        return isVehicleUpdated;
    }    

    //After Insert Context - To create stock number for vehicle based on Stock book
    public static void afterInsertStockBookUpdate( List<dealer__Vehicle_Inventory__c> newVehicle )
    {
        //W-000736
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms!=null && dms.dealer__Assign_Stock_Number__c==true && dms.dealer__Assign_Stock_Number_By_Stock_Book__c==true) {

            List<dealer__Stock_Number_Book__c> ListForUpdate = new List<dealer__Stock_Number_Book__c>();
            map<String, Id> mapStockNameVehId = new map<String, Id>();
            for(dealer__Vehicle_Inventory__c obj: newVehicle)
            {
                mapStockNameVehId.put(obj.dealer__Stock_Number__c, obj.id);
            }

            ListForUpdate = [SELECT Id, Name, dealer__Vehicle_Inventory__c FROM dealer__Stock_Number_Book__c WHERE Name IN: mapStockNameVehId.keyset()];

            for(dealer__Stock_Number_Book__c obj: ListForUpdate)
            {
                obj.dealer__Vehicle_Inventory__c = mapStockNameVehId.get(obj.Name); // Broken, to be fixed at a later time. 
            }

            // update ListForUpdate;
        }
    }

    //Before Update Context
    public static void beforeUpdate ( List<dealer__Vehicle_Inventory__c> newVehicle,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )
    {

    	Map<Id, String> mapStoreLocs = new Map<Id, String>();
    	Set<Id> setLocationId = new Set<Id>();
        Set<Id> recordTypeIds = new Set<Id>();
        List<dealer__Vehicle_Inventory__c> convVehicles = new List<dealer__Vehicle_Inventory__c>();


    	for(dealer__Vehicle_Inventory__c v : newVehicle) {
    		setLocationId.add(v.dealer__Store_Location__c);//get related location info
            recordTypeIds.add(v.RecordTypeId);//get related record type
            if(v.Conversion__c != null && oldVehicleMap.get(v.Id).Conversion__c != v.Conversion__c){
                convVehicles.add(v);
            }
		}

		//Get the related store locations with company number
		for(dealer__Dealer_Location__c dl : [SELECT Id, dealer__Company_Number__c from dealer__Dealer_Location__c where id in :setLocationId]){
	        mapStoreLocs.put(dl.Id, dl.dealer__Company_Number__c);
	    }

        // get related record type information.  
        Map<Id, RecordType> recordTypeInfo = new Map<Id, RecordType>([Select Id, NameSpacePrefix, DeveloperName from RecordType where Id IN:recordTypeIds limit 2000]);

        for(dealer__Vehicle_Inventory__c v : newVehicle) {

            Boolean storeLocChanged = false;
            dealer__Vehicle_Inventory__c old = oldVehicleMap.get(v.Id);

            if(v.dealer__Store_Location__c != old.dealer__Store_Location__c){
            	storeLocChanged = true;
        	}

            if(storeLocChanged && v.dealer__Store_Location__c != null){
                v.dealer__Company_Number__c = mapStoreLocs.get(v.dealer__Store_Location__c);
            }

            if(v.dealer__VIN__c != null) {
                v.dealer__Last_6__c = v.dealer__VIN__c.right(6);
            }

            if(old.dealer__Status_Code__c != v.dealer__Status_Code__c) {
                v.dealer__Status_Code_Assignment_Date__c = Date.today();
            }

            // Set Last Retail Price Change Date
            //      Added 2/20/14 by jarrett kuljis
            if(old.dealer__Retail_Price__c != v.dealer__Retail_Price__c) {
                v.dealer__Last_Retail_Price_Change__c=Date.today();
            }

            if(v.dealer__Retail_Price__c!=null) {
                if(v.dealer__Retail_Price__c!=0) {
                    if(v.dealer__Initial_Retail_Price__c==null || v.dealer__Initial_Retail_Price__c==0) 
                        v.dealer__Initial_Retail_Price__c=v.dealer__Retail_Price__c;
                }
            }

            //Update Vehicle Name
            if(recordTypeInfo.get(v.RecordTypeId)!=null && recordTypeInfo.get(v.RecordTypeId).NameSpacePrefix == 'dealer') {
                v.Name = '('+v.Stock_Number__c+') '+v.Year__c+' '+v.Make__c+' '+v.Model__c;
            }
            
            //Update dealer__NUO__c field
            if((recordTypeInfo.get(v.RecordTypeId)!=null && recordTypeInfo.get(v.RecordTypeId).DeveloperName!=null) && 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'New' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Demo' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Used' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Fleet' || 
                recordTypeInfo.get(v.RecordTypeId).DeveloperName == 'Other') { 

                v.dealer__NUO__c = recordTypeInfo.get(v.RecordTypeId).DeveloperName.substring(0,1); 
            }

            if(convVehicles.size() > 0){
                populateConversionData(convVehicles);
            }
            
            v.Retail_Price__c = v.Retail_Price__c != null ? v.Retail_Price__c : 0;
            v.Conversion_Price__c = v.Conversion_Price__c != null ? v.Conversion_Price__c : 0;
            v.TotalVehiclePrice__c = v.Retail_Price__c + v.Conversion_Price__c;
            
        }

    }

    //After Update Context - Create alert task if retail price is changed
    public static boolean afterUpdate ( List<dealer__Vehicle_Inventory__c> newVehicle,Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )
    {
        // Get user customized settings for applicaiton of Trigger
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();

        //Create tasks when dealer__Retail_Price__c is updated

        if(crm.dealer__Enable_Price_Change_Alert__c){

            List<Id> priceChanged = new List<Id>();
            List<Task> taskList = new List<Task>();
            Set<Id> activeUserIds = new Set<Id>();
            Set<Id> ownerIds = new Set<Id>();
            List<dealer__Desired_Vehicle__c> listdesVehicle=new List<dealer__Desired_Vehicle__c>();
        
            for(dealer__Vehicle_Inventory__c inventoryItem : newVehicle){

                //get all price changed vehicles

                if(inventoryItem.dealer__Retail_Price__c < oldVehicleMap.get(inventoryItem.ID).dealer__Retail_Price__c){
                    priceChanged.add(inventoryItem.ID);
                }
            }

            //get all associated desired vehicles of vehicle inventory with price changed
            listdesVehicle = [Select ID,dealer__Vehicle_Inventory__r.dealer__Stock_Number__c,dealer__Vehicle_Inventory__c,dealer__Sales_Up__c,
                                dealer__Sales_Up__r.OwnerID,dealer__Sales_Up__r.dealer__Is_Open__c from dealer__Desired_Vehicle__c 
                                where dealer__Vehicle_Inventory__c in :priceChanged and dealer__Sales_Up__r.dealer__Is_Open__c=1];

            for(dealer__Desired_Vehicle__c dv:listdesVehicle){
                ownerIds.add(dv.dealer__Sales_Up__r.OwnerID);
            }    

            
            for(User u:[select id from User where id in:ownerIds and isActive=true]){
                activeUserIds.add(u.id);
            }

            for(dealer__Desired_Vehicle__c dv:listdesVehicle){
                Task t=new Task();
                t.Whatid=dv.dealer__Sales_Up__c;
                t.subject='Price Change Alert';
                t.ActivityDate = Date.today();
                t.Description=dv.dealer__Vehicle_Inventory__r.dealer__Stock_Number__c
                            + '  price was changed from '+oldVehicleMap.get(dv.dealer__Vehicle_Inventory__c).dealer__Retail_Price__c
                            + ' to ' + newVehicleMap.get(dv.dealer__Vehicle_Inventory__c).dealer__Retail_Price__c
                            +'. This Sales Up has indicated interest in the vehicle.  Please notify them of this price change.';
                t.OwnerID=dv.dealer__Sales_Up__r.OwnerID;
                if(activeUserIds.contains(dv.dealer__Sales_Up__r.OwnerID)) {
                    taskList.add(t);
                }
            }
            if(taskList.size()>0){
                insert taskList;
            }
        }

        //Create Status Code if Status is Updated
        createStatusCode(newVehicle,true,oldVehicleMap);


        boolean isVehicleUpdated; 

        if(checkCreateServiceVehicle(newVehicle, oldVehicleMap, true)) {
            isVehicleUpdated = createServiceVehicle(newVehicle, oldVehicleMap, true);
        } else {
            isVehicleUpdated = false;
        }
        
        //create/update service vehicle
        // Boolean isVehicleUpdated = createServiceVehicle(newVehicle, oldVehicleMap, true);

        return isVehicleUpdated;
    }
    
    //Create Status Code for new VI or status update
    public static void createStatusCode(List<dealer__Vehicle_Inventory__c> newVehicle,Boolean isUpdate,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap){
        List<dealer__Vehicle_Inventory_Status_Code_History__c> listStatusCode = new List<dealer__Vehicle_Inventory_Status_Code_History__c>();

        // Compare New Status Code to Old Status Code, if Status Code has changed, update Status Code Related List and Status Code Assignment Date
        for(dealer__Vehicle_Inventory__c inventoryItem : newVehicle){

            String oldStat = '';
            String newStat = inventoryItem.dealer__Status_Code__c;
            if(isUpdate){
                oldStat = oldVehicleMap.get(inventoryItem.id).dealer__Status_Code__c;
            }

            if(newStat!=null && newStat!='' && ( (isUpdate && oldStat != newStat) || !isUpdate ) ) {
                listStatusCode.add( new dealer__Vehicle_Inventory_Status_Code_History__c(
                    dealer__Inventoried_Vehicle__c = inventoryItem.Id,
                    dealer__Status_Code__c = newStat,
                    dealer__Date_Assigned__c = Date.today()
                ));
            }
        }

        //insert status code records
        if(listStatusCode.size() > 0) {
            insert listStatusCode;
        }
    }

    //Create Service Vehicle
    public static boolean createServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap,Boolean isUpdate){
        Map<Id,dealer__Service_Vehicle__c> mapVehIdServiceVehicle = new Map<Id,dealer__Service_Vehicle__c>();
        Set<string> setSVId = new Set<string>();
        Map<String, dealer__Service_Vehicle__c> svExistingData = new Map<String, dealer__Service_Vehicle__c>();
  	    List<Id> numService = new List<Id>();

        // Create a holding set for vins to check for duplicates often found in DataLoader uploading.
        Set<String> vinCheck = new Set<String>();           

        // Get List of Service vehicles that match the records to compare new and old values, prevent recursion
        //Get all VIN Numbers
        for(dealer__Vehicle_Inventory__c inventoryItem : newVehicle) {
            if(inventoryItem.dealer__VIN__c!=null && inventoryItem.dealer__VIN__c!=''){
                if(oldVehicleMap == null){
                    setSVId.add(inventoryItem.dealer__VIN__c.trim());  
                }
                else if(oldVehicleMap.get(inventoryItem.Id) != null && (inventoryItem.dealer__VIN__c != oldVehicleMap.get(inventoryItem.Id).dealer__VIN__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__VIN__c != inventoryItem.dealer__VIN__c || 
                oldVehicleMap.get(inventoryItem.Id).dealer__Stock_Number__c != inventoryItem.dealer__Stock_Number__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Year__c != inventoryItem.dealer__Year__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Make__c != inventoryItem.dealer__Make__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Model__c != inventoryItem.dealer__Model__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__License__c != inventoryItem.dealer__License__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Ignition_Key_Code__c != inventoryItem.dealer__Ignition_Key_Code__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Transmission_Type__c != inventoryItem.dealer__Transmission_Type__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Engine_Description__c != inventoryItem.dealer__Engine_Description__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Drive_Type__c != inventoryItem.dealer__Drive_Type__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Mileage__c != inventoryItem.dealer__Mileage__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Exterior_Color__c != inventoryItem.dealer__Exterior_Color__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Interior_Color__c != inventoryItem.dealer__Interior_Color__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Package_Code__c != inventoryItem.dealer__Package_Code__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Conversion__c != inventoryItem.dealer__Conversion__c ||
                oldVehicleMap.get(inventoryItem.Id).dealer__Trim_Level__c != inventoryItem.dealer__Trim_Level__c)){
                    setSVId.add(inventoryItem.dealer__VIN__c.trim());  
                } 
            }

        }
        
        // Add VIN's of oldmap to collection so we can grab any service vehicles that still have the old VIN.
        // Problem: If the inventory vehicle's VIN is alreay out of sync, the service vehicle is orphaned
        if(oldVehicleMap != null)
        {
            for(dealer__Vehicle_Inventory__c inventoryItem : oldVehicleMap.values()) 
            {
                if(inventoryItem.dealer__VIN__c!=null && inventoryItem.dealer__VIN__c!='')
                {
                    setSVId.add(inventoryItem.dealer__VIN__c.trim());  
                }

            } 
        }
      

        //Get Service Vehicle and associated VI
        for(dealer__Service_Vehicle__c svExisting : [Select id, dealer__Sales_Inventory__c, dealer__VIN__c, 
                                dealer__Stock_Number__c, dealer__Year__c, dealer__Make__c, dealer__Conversion__c,
                                dealer__Carline__c, dealer__Licence__c, dealer__Key_1__c, 
                                dealer__Transmission_Type__c, dealer__Engine_Description__c,  dealer__Engine_Displacement__c,
                                dealer__Drive_Type__c, dealer__Last_Odometer__c, dealer__Ext_Color__c,
                                dealer__Package_Code__c, dealer__Trim_Level__c, dealer__Int_Color__c,
                                (Select id, name, dealer__VIN__c, dealer__body_style__c from dealer__Vehicle_Inventory__r order by createddate desc limit 1)   
                                From dealer__Service_Vehicle__c where dealer__VIN__c IN:setSVId]) {

            svExistingData.put(svExisting.dealer__VIN__c, svExisting);
            numService.add(svExisting.Id);                       
            
        }

        for(dealer__Vehicle_Inventory__c inventoryItem : newVehicle) {
            // Set the Vehicle Name based on the following criteria.  Name = (Last6) Year Make Model
            String vehicleName = '';

            if(inventoryItem.dealer__VIN__c!= null) {
                vehicleName = '(' + inventoryItem.dealer__VIN__c.right(6) + ') ' + inventoryItem.dealer__Year__c + ' ' + inventoryItem.dealer__Make__c + ' ' + inventoryItem.dealer__Model__c; 
            }
            else{
                vehicleName = inventoryItem.dealer__Year__c + ' ' + inventoryItem.dealer__Make__c + ' ' + inventoryItem.dealer__Model__c;
            }

	        boolean isInventoryItem = svExistingData.get(inventoryItem.dealer__VIN__c) == null;
            //W-001685 Create service if is not created when updating.
	        //If Service Vehicle has not been created, create now.
            if(!isUpdate && isInventoryItem && !vinCheck.contains(inventoryItem.dealer__VIN__c)  && inventoryItem.dealer__VIN__c != null || isUpdate && numService.size() == 0 && isInventoryItem && !vinCheck.contains(inventoryItem.dealer__VIN__c)  && inventoryItem.dealer__VIN__c != null ) {
                mapVehIdServiceVehicle.put(inventoryItem.Id, new dealer__Service_Vehicle__c(
                                    Name = vehicleName,
                                    dealer__Sales_Inventory__c = inventoryItem.Id,
                                    dealer__VIN__c = inventoryItem.dealer__VIN__c,
                                    dealer__Stock_Number__c = inventoryItem.dealer__Stock_Number__c,
                                    dealer__Year__c = inventoryItem.dealer__Year__c,
                                    dealer__Make__c = inventoryItem.dealer__Make__c,
                                    dealer__Carline__c = inventoryItem.dealer__Model__c,
                                    dealer__Licence__c = inventoryItem.dealer__License__c,
                                    dealer__Key_1__c = inventoryItem.dealer__Ignition_Key_Code__c,
                                    dealer__Transmission_Type__c = inventoryItem.dealer__Transmission_Type__c,
                                    dealer__Engine_Description__c = inventoryItem.dealer__Engine_Description__c,
                                    dealer__Engine_Displacement__c = inventoryItem.dealer__Engine_Displacement__c,
                                    dealer__Drive_Type__c = inventoryItem.dealer__Drive_Type__c,
                                    dealer__Last_Odometer__c = inventoryItem.dealer__Mileage__c,
                                    dealer__Ext_Color__c = inventoryItem.dealer__Exterior_Color__c,
                                    dealer__Int_Color__c = inventoryItem.dealer__Interior_Color__c,
                                    dealer__Package_Code__c = inventoryItem.dealer__Package_Code__c,
                                    dealer__Trim_Level__c = inventoryItem.dealer__Trim_Level__c,
                                    dealer__Last_8__c = inventoryItem.dealer__VIN__c.right(8)
                                ) 
                );

                if(inventoryItem.In_Stock__c == true && inventoryItem.Conversion__c != null){
                    mapVehIdServiceVehicle.get(inventoryItem.Id).Conversion__c = inventoryItem.Conversion__c;
                }

                vinCheck.add(inventoryItem.dealer__VIN__c);        
            }
            

            //else
            else if(svExistingData.get(inventoryItem.dealer__VIN__c) != null && 
                (!isUpdate || (isUpdate && svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Vehicle_Inventory__r.size() >0 && svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Vehicle_Inventory__r[0].id == inventoryItem.id ) )&& // allows update to service vehicle only if associated vehicle is the latest one
                (   svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Sales_Inventory__c != inventoryItem.Id ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__VIN__c != inventoryItem.dealer__VIN__c || 
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Stock_Number__c != inventoryItem.dealer__Stock_Number__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Year__c != inventoryItem.dealer__Year__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Make__c != inventoryItem.dealer__Make__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Carline__c != inventoryItem.dealer__Model__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Licence__c != inventoryItem.dealer__License__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Key_1__c != inventoryItem.dealer__Ignition_Key_Code__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Transmission_Type__c != inventoryItem.dealer__Transmission_Type__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Engine_Description__c != inventoryItem.dealer__Engine_Description__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Engine_Displacement__c != inventoryItem.dealer__Engine_Displacement__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Drive_Type__c != inventoryItem.dealer__Drive_Type__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Last_Odometer__c != inventoryItem.dealer__Mileage__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Ext_Color__c != inventoryItem.dealer__Exterior_Color__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Int_Color__c != inventoryItem.dealer__Interior_Color__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Package_Code__c != inventoryItem.dealer__Package_Code__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Trim_Level__c != inventoryItem.dealer__Trim_Level__c ||
                svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Conversion__c != inventoryItem.dealer__Conversion__c
            )
            ) 
            {

                mapVehIdServiceVehicle.put(inventoryItem.Id, new dealer__Service_Vehicle__c(
                                    Name = vehicleName,
                                    dealer__Sales_Inventory__c = inventoryItem.Id,
                                    dealer__VIN__c = inventoryItem.dealer__VIN__c,
                                    dealer__Stock_Number__c = inventoryItem.dealer__Stock_Number__c,
                                    dealer__Year__c = inventoryItem.dealer__Year__c,
                                    dealer__Make__c = inventoryItem.dealer__Make__c,
                                    dealer__Carline__c = inventoryItem.dealer__Model__c,
                                    //dealer__Licence__c = inventoryItem.dealer__License__c, Commented out due to service vehicle's License # updating to the vehicle inventory even if the service veh's lic has changed.
                                    dealer__Key_1__c = inventoryItem.dealer__Ignition_Key_Code__c,
                                    dealer__Transmission_Type__c = inventoryItem.dealer__Transmission_Type__c,
                                    dealer__Engine_Description__c = inventoryItem.dealer__Engine_Description__c,
                                    dealer__Engine_Displacement__c = inventoryItem.dealer__Engine_Displacement__c,
                                    dealer__Drive_Type__c = inventoryItem.dealer__Drive_Type__c,
                                    dealer__Last_Odometer__c = inventoryItem.dealer__Mileage__c,
                                    dealer__Ext_Color__c = inventoryItem.dealer__Exterior_Color__c,
                                    dealer__Int_Color__c = inventoryItem.dealer__Interior_Color__c,
                                    dealer__Package_Code__c = inventoryItem.dealer__Package_Code__c,
                                    dealer__Trim_Level__c = inventoryItem.dealer__Trim_Level__c,
                                    dealer__Last_8__c = inventoryItem.dealer__VIN__c.right(8)
                                ) 
                );  

                if(inventoryItem.In_Stock__c == true && inventoryItem.Conversion__c != null){
                    mapVehIdServiceVehicle.get(inventoryItem.Id).Conversion__c = inventoryItem.Conversion__c;
                }
            }
        } 

        //Upsert Service Vehicle
        if(mapVehIdServiceVehicle.size() > 0 ) {
            Schema.DescribeFieldResult F = Service_Vehicle__c.VIN__c.getDescribe();
            Schema.sObjectField VINFIeld = F.getSObjectField();
            Database.UpsertResult[] srList = Database.upsert(mapVehIdServiceVehicle.values(), VINFIeld, false);
            List<String> Errors = new List<String>();
            for(Database.UpsertResult sr : srList){
                if(!sr.isSuccess()){
                    for(Database.Error err :sr.getErrors()){
                        errors.add(err.getMessage());
                    }
                }
            }
            if(Errors.size() > 0){
                //send email
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                
                String[] toAddresses = new String[] {'apexerror@dealerteam.com'};   
                mail.setToAddresses(toAddresses);
                mail.setSubject('Service Vehicle Creation Error');
                mail.setHtmlBody('We\'ve encountered an error creating '+SObjectType.Service_Vehicle__c.getLabel()+'  <br /> '+errors);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        } 

        List<dealer__Vehicle_Inventory__c>  listVehicleToUpdate= new List<dealer__Vehicle_Inventory__c> ();

        //get all related vehicles to populate service vehicle Id
        for(dealer__Vehicle_Inventory__c vehicle: [select id, dealer__Service_Vehicle__c from dealer__Vehicle_Inventory__c where id in :mapVehIdServiceVehicle.keyset()]){
            if(mapVehIdServiceVehicle.get(vehicle.id)!=null && mapVehIdServiceVehicle.get(vehicle.id).Id!=null && 
                 vehicle.dealer__Service_Vehicle__c != mapVehIdServiceVehicle.get(vehicle.id).Id//check if correct service vehicle is already associated
                ){
                vehicle.dealer__Service_Vehicle__c = mapVehIdServiceVehicle.get(vehicle.id).Id;
                listVehicleToUpdate.add(vehicle);
            }
        }

        //Update vehicles with new service vehicle id
        if(listVehicleToUpdate.size()>0){
            update listVehicleToUpdate;
            return true; //true if vehicle is updated in after context to avoid recurrence
        }

        // update VIN of service vehicles
        List<dealer__Service_Vehicle__c> serviceVehicles = new List<dealer__Service_Vehicle__c>();

        for(dealer__Vehicle_Inventory__c inventoryItem : newVehicle) {
            if(oldVehicleMap != null  && inventoryItem.dealer__VIN__c!=null && inventoryItem.dealer__VIN__c!=''){
               // check if VIN has been changed
               if(oldVehicleMap.get(inventoryItem.Id) != null && inventoryItem.dealer__VIN__c != oldVehicleMap.get(inventoryItem.Id).dealer__VIN__c) {
                   dealer__Service_Vehicle__c sVehicle = svExistingData.get(oldVehicleMap.get(inventoryItem.Id).dealer__VIN__c);
                    if ( sVehicle != null ) {
                        sVehicle.dealer__VIN__c = inventoryItem.dealer__VIN__c;
                        sVehicle.dealer__Last_8__c = inventoryItem.dealer__VIN__c.right(8);
                        serviceVehicles.add(sVehicle);
                    }
               }    
            }
        }

        if(serviceVehicles.size() > 0)
        {
            update serviceVehicles;
        }
        // end update VIN of service vehicles


        return false;
    }

    private static Boolean checkCreateServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap, Boolean isUpdate) {

        Boolean retVal = false;

        // We will store a set of Vehicle Id's with a VIN, or updated to include a VIN
        Set<String> vinList = new Set<String>();   

        for(dealer__Vehicle_Inventory__c i : newVehicle) {

            if(isUpdate) {
                dealer__Vehicle_Inventory__c old = oldVehicleMap.get(i.Id);
                if( (old.dealer__VIN__c == null || old.dealer__VIN__c == '') && (i.dealer__VIN__c != null && i.dealer__VIN__c != '') ) {
                    retVal = true;
                }
            } else {
                if(i.dealer__VIN__c != null && i.dealer__VIN__c != '') {
                    retVal = true;
                }
            }

        }

        return retVal;
    }

    public static void populateConversionData(List<dealer__Vehicle_Inventory__c> triggerNew){
        
        Set<Id> convIds = new Set<Id>();
        for(dealer__Vehicle_Inventory__c vi : triggerNew){
            if(vi.Conversion__c != null){
                convIds.add(vi.Conversion__c);
            }
        }

        if(convIds.size() > 0){
            Map<Id, Parts_Kit__c> convMap = new Map<Id, Parts_Kit__c>([SELECT Id, MFG__c, MFG__r.Name, ConversionModel__c, RampLocation__c, RampOperation__c, RampType__c FROM Parts_Kit__c WHERE Id IN: convIds]);
            for(Vehicle_Inventory__c vi : triggerNew){
               if(vi.Conversion__c != null && convMap.get(vi.Conversion__c) != null){
                    vi.Conv_MFG__c = convMap.get(vi.Conversion__c) != null && convMap.get(vi.Conversion__c).MFG__c != null ? convMap.get(vi.dealer__Conversion__c).MFG__r.Name : '';
                    vi.Conversion_Model__c = convMap.get(vi.Conversion__c) != null ? convMap.get(vi.Conversion__c).ConversionModel__c : null;
                    vi.Ramp_Location__c = convMap.get(vi.Conversion__c) != null ? convMap.get(vi.Conversion__c).RampLocation__c : null;
                    vi.Ramp_Operation__c = convMap.get(vi.Conversion__c) != null ? convMap.get(vi.Conversion__c).RampOperation__c : null;
                    vi.Ramp_Type__c = convMap.get(vi.Conversion__c) != null ? convMap.get(vi.Conversion__c).RampType__c : null;
                } 
            }
        }
    }

}