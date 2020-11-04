/**
 * @description Trigger level class for handling servicevehicle records
 */
public without sharing class ServiceVehicleSanitizeHandler {

    /**
     * setSystemValues description
     * @param  triggerNew triggerNew description
     */
    public void setSystemValues(List<Service_Vehicle__c> triggerNew) 
    {
        for(Service_Vehicle__c sv : triggerNew) {

            // VIN should only consist of uppercase numbers
            sv.VIN__c = (sv.VIN__c!=null) ? sv.VIN__c.toUpperCase() : null;

            // LAST 6 of VIN Should be searchable
            sv.Last_6__c = (sv.VIN__c!=null) ? String.valueOf(sv.VIN__c).right(6) : null;

            // LAST 8 of VIN should be searchable 
            sv.Last_8__c = (sv.VIN__c!=null) ? String.valueOf(sv.VIN__c).right(8) : null;

            // Set the record name based on business logic specified by DealerTeam 
            sv.Name = (sv.Last_6__c!=null) ? '(' + sv.Last_6__c + ') ' + sv.Year__c + ' ' + sv.Make__c + ' ' + sv.Carline__c : sv.Year__c + ' ' + sv.Make__c + ' ' + sv.Carline__c;

        }
    }

    /**
     * populateRelatedData description
     * @param newSV Trigger.new context variable
     * @param  oldVehicleMap oldVehicleMap description
     */
    public void populateRelatedData(List<Service_Vehicle__c> triggerNew, Map<ID, Service_Vehicle__c> triggerOldMap ) 
    {

        /* Memory maps to hold relevent data */
        Set<Id> accountID = new Set<Id>();
        Set<Id> viId = new Set<Id>();
        Set<String> customerExternalReference = new Set<String>();
        Map<Id, Account> accounts = new Map<Id, Account>();
        Map<String, Account> accountByKey = new Map<String, Account>();
        List<Service_Vehicle__c> svByInventory = new List<Service_Vehicle__c>();         

        /* Iteratre Trigger context variables for relevent data */
        for(dealer__Service_Vehicle__c objServiceVechile : triggerNew) {

            if(objServiceVechile.Veh_Owner__c != null) {
                accountID.add(objServiceVechile.Veh_Owner__c);
            }
            
            if(objServiceVechile.Customer_Key__c != null) {
                customerExternalReference.add(objServiceVechile.Customer_Key__c);
            } 
               
        }

        /* Obtain customers referenced by External ID */
        if(customerExternalReference.size() > 0){
            for(Account objAccount : [SELECT Id, FirstName, LastName, isPersonAccount, Name, External_ID__c FROM Account WHERE Id IN:AccountId or External_ID__c IN: customerExternalReference]) {
                accounts.put(objAccount.Id, objAccount);
                accountByKey.put(objAccount.External_ID__c, objAccount);
            }
        }
        

        // Iterate Records and assign values 
        for(Service_Vehicle__c objServiceVehicle : triggerNew) {

            // Set account information
            if(accounts.get(objServiceVehicle.Veh_Owner__c)==null && objServiceVehicle.Customer_Key__c != null) {
                if(accountByKey.get(objServiceVehicle.Customer_Key__c)!=null) {
                    objServiceVehicle.Veh_Owner__c = accountByKey.get(objServiceVehicle.Customer_Key__c).Id;
                }
            }
            if(objServiceVehicle.Veh_Owner__c == null && objServiceVehicle.Sales_Inventory__c != null){
                viId.add(objServiceVehicle.Sales_Inventory__c);
                svByInventory.add(objServiceVehicle);
            }
        }
        //Set account based on Store Location of Sales Inventory record
        if(viId.size() > 0){
            Map<Id, Vehicle_Inventory__c> viMap = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Store_Location__c, Store_Location__r.Location_Account__c, In_Stock__c FROM Vehicle_Inventory__c WHERE Id IN: viId]);

            for(Service_Vehicle__c objServiceVehicle : svByInventory){
                if(viMap.get(objServiceVehicle.Sales_Inventory__c) != null && viMap.get(objServiceVehicle.Sales_Inventory__c).In_Stock__c == true){
                    if(viMap.get(objServiceVehicle.Sales_Inventory__c).Store_Location__c != null && viMap.get(objServiceVehicle.Sales_Inventory__c).Store_Location__r.Location_Account__c != null){
                        objServiceVehicle.Veh_Owner__c = viMap.get(objServiceVehicle.Sales_Inventory__c).Store_Location__r.Location_Account__c;
                    }
                }
            }
        }

        for(Service_Vehicle__c objServiceVehicle : triggerNew){
            // Set Search Info based on Account
            if(accounts.get(objServiceVehicle.Veh_Owner__c)!=null) {
                if(accounts.get(objServiceVehicle.Veh_Owner__c).isPersonAccount==false) {
                    objServiceVehicle.Search_Names__c = (String)accounts.get(objServiceVehicle.Veh_Owner__c).Name;
                } else {
                    objServiceVehicle.Search_Names__c = (String)accounts.get(objServiceVehicle.Veh_Owner__c).FirstName +' '+(String)accounts.get(objServiceVehicle.Veh_Owner__c).LastName;
                }
            } else {
                    objServiceVehicle.Search_Names__c = null;  
            } 
        }
  
    }    

    /**
     * preventDelete description
     * @param triggerNew list of Service vehicles
     */
    public void preventDelete(List<Service_Vehicle__c> triggerNew)
    {

        Set<Id> serviceVechileIds = new Set<Id>();
        Map<Id, Service_Repair_Order__c> repairOrders = new Map<Id, Service_Repair_Order__c>();
        Map<Id, Service_Appointment__c> serviceAppointments = new Map<Id, Service_Appointment__c>();

        /* Obtain record Id's for inclusion in delete prevention */
        for(dealer__Service_Vehicle__c objServiceVechile : triggerNew){
            ServiceVechileIds.add(objServiceVechile.id);
        }

        /* Populate map of Service Appointments by Vehicle */
        for(Service_Appointment__c sa : [SELECT Id, Name, Vehicle__c FROM Service_Appointment__c WHERE Vehicle__c IN : serviceVechileIds]) {
            serviceAppointments.put(sa.Vehicle__c, sa);
        }

        /* Populate Map of service repair orders by vehicle */
        for(Service_Repair_Order__c sro : [SELECT Id, Name, Vehicle__c FROM Service_Repair_Order__c WHERE Vehicle__c IN : serviceVechileIds]) {
            repairOrders.put(sro.Vehicle__c, sro);
        }

        /* Ensure no records are present preventing SV Delete */
        for(Service_Vehicle__c objServiceVechile : triggerNew){

            if(serviceAppointments.get(objServiceVechile.Id)!=null){
                objServiceVechile.addError('Unable to delete Service Vehicle ' + objServiceVechile.Name + '.  This Vehicle has service appointments associated.');
            }

            if(repairOrders.get(objServiceVechile.Id)!=null){
                objServiceVechile.addError('Unable to delete this Service Vehicle ' + objServiceVechile.Name + '.  This Vehicle has Repair Orders associated.'); 
            }

        }
 
    } 

    /**
     * UpdateVehicleConversion description
     * @param  triggerNew triggerNew description
     * @param  oldMap     oldMap description
     */
    public void UpdateVehicleConversion(Map<Id, Service_Vehicle__c> triggerNew, Map<Id, Service_Vehicle__c> oldMap)
    {
        
        Set<Id> svIds = new Set<Id>();
        List<Vehicle_Inventory__c> viList = new List<Vehicle_Inventory__c>();
        List<Vehicle_Inventory__c> viUpdates = new List<Vehicle_Inventory__c>();
        List<FeedItem> chatterPosts = new List<FeedItem>();

        for(Service_Vehicle__c sv : triggerNew.values()){
            if(sv.Conversion__c != oldMap.get(sv.Id).Conversion__c){
                svIds.add(sv.Id);
            }
        }

        if(svIds.size() > 0){
            viList = [SELECT Id, Conversion__c, Conversion__r.Name, Service_Vehicle__c, Service_Vehicle__r.Name FROM dealer__Vehicle_Inventory__c WHERE In_Stock__c = true AND Service_Vehicle__c IN: svIds];
        }

        for(Vehicle_Inventory__c vi : viList){
            if(vi.Conversion__c != triggerNew.get(vi.Service_Vehicle__c).Conversion__c){
                vi.Conversion__c = triggerNew.get(vi.Service_Vehicle__c).Conversion__c;
                viUpdates.add(vi);

                //Post conversion update to chatter
                if(vi.Conversion__c != null && vi.Service_Vehicle__c != null){
                    FeedItem post = new FeedItem();
                    post.ParentId = vi.Id;
                    post.Body = 'Conversion was updated to: ' + vi.Conversion__r.Name + ' by Service Vehicle with Id: ' + vi.Service_Vehicle__r.Name;
                    chatterPosts.add(post);
                }
                
            
            }
        }

        if(viUpdates.size() > 0){
            update viUpdates;
        }
        if(chatterPosts.size() > 0){
            insert chatterPosts;
        }
    } 

    /**
     * AfterUpdateApprisals description
     * @param Trigger.new context list of Service Vehicles
     * @description Performs an update to the service vehicle related fields associated with the appraisal if vales have changed. 
     */
    public void UpdateApprisals(List<Service_Vehicle__c> triggerNew)
    {

        Set<Id> SetVechileIds = new Set<Id>();

        for(dealer__Service_Vehicle__c objServiceVechile : triggerNew){
            SetVechileIds.add(objServiceVechile.id);
        }

        List <dealer__Appraisal_Vehicle__c> ListUpdateAppraisals = new list<dealer__Appraisal_Vehicle__c>();

        List <dealer__Service_Vehicle__c> ServiceVechileList = [select id, dealer__Veh_Owner__c, dealer__Veh_Owner_Contact__c, dealer__Make__c,dealer__Carline__c,dealer__Year__c,dealer__Trim_Level__c,dealer__VIN__c,dealer__Last_Odometer__c,dealer__Body_Type__c,
                                                                    (select id, dealer__Make__c,dealer__Model__c,dealer__Year__c,dealer__Trim_Level__c,dealer__VIN__c 
                                                                    from dealer__Appraisal_Vehicles__r),
                                                                    (select id, dealer__Trade_Year__c,dealer__Trade_Trim_Level__c,dealer__Trade_Make__c,dealer__Trade_Model__c, 
                                                                        dealer__Trade_Mileage__c, dealer__Trade_Body_Type__c
                                                                    from dealer__sales_Up__r) from dealer__Service_Vehicle__c where id in : SetVechileIds];

        for(dealer__Service_Vehicle__c objServiceVechile : ServiceVechileList){

            for(dealer__Appraisal_Vehicle__c objAppraisals : objServiceVechile.dealer__Appraisal_Vehicles__r){

                 if(objAppraisals.dealer__Make__c != objServiceVechile.dealer__Make__c || objAppraisals.dealer__Model__c != objServiceVechile.dealer__Carline__c ||  objAppraisals.dealer__Year__c != objServiceVechile.dealer__Year__c ||  objAppraisals.dealer__Trim_Level__c != objServiceVechile.dealer__Trim_Level__c ||  objAppraisals.dealer__VIN__c != objServiceVechile.dealer__VIN__c ) {

                        objAppraisals.dealer__Make__c        =  objServiceVechile.dealer__Make__c;
                        objAppraisals.dealer__Model__c       =  objServiceVechile.dealer__Carline__c;
                        objAppraisals.dealer__Year__c        =  objServiceVechile.dealer__Year__c;
                        objAppraisals.dealer__Trim_Level__c  =  objServiceVechile.dealer__Trim_Level__c;
                        objAppraisals.dealer__VIN__c         =  objServiceVechile.dealer__VIN__c;
                        ListUpdateAppraisals.add(objAppraisals);
                }

            }
           
            for(dealer__sales_Up__c objSalesup : objServiceVechile.dealer__sales_Up__r){

                 if( objSalesup.dealer__Trade_Make__c != objServiceVechile.dealer__Make__c ||  objSalesup.dealer__Trade_Model__c != objServiceVechile.dealer__Carline__c ||  objSalesup.dealer__Trade_Year__c != objServiceVechile.dealer__Year__c ||  objSalesup.dealer__Trade_Trim_Level__c != objServiceVechile.dealer__Trim_Level__c ||  objSalesup.dealer__Trade_Mileage__c != objServiceVechile.dealer__Last_Odometer__c ||  objSalesup.dealer__Trade_Body_Type__c != objServiceVechile.dealer__Body_Type__c ){
                    
                        objSalesup.dealer__Trade_Make__c        = objServiceVechile.dealer__Make__c;
                        objSalesup.dealer__Trade_Model__c       = objServiceVechile.dealer__Carline__c;
                        objSalesup.dealer__Trade_Year__c        = objServiceVechile.dealer__Year__c;
                        objSalesup.dealer__Trade_Trim_Level__c  = objServiceVechile.dealer__Trim_Level__c;
                        objSalesup.dealer__Trade_Mileage__c     = objServiceVechile.dealer__Last_Odometer__c;
                        objSalesup.dealer__Trade_Body_Type__c   =  objServiceVechile.dealer__Body_Type__c != null ? objServiceVechile.dealer__Body_Type__c : null;     
                }

            }

        }

        if(!ListUpdateAppraisals.isEmpty()){
                update ListUpdateAppraisals;
        }

    }      

}