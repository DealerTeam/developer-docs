public class ServiceRepairOrderControlHandler{

    //Utility method to restrict user to update company of SRO
    public static void RestrictCompanyUpdate(List<dealer__Service_Repair_Order__c> SROList, Map<Id, dealer__Service_Repair_Order__c> SROOldMap)
    {

        for(dealer__Service_Repair_Order__c objSRO : SROList){
            if(objSRO.dealer__Company__c != null 
                && SROOldMap.get(objSRO.Id) != null
                && SROOldMap.get(objSRO.Id).dealer__Company__c != null
                && SROOldMap.get(objSRO.Id).dealer__Company__c != objSRO.dealer__Company__c){
                objSRO.addError('You can not change the Company referenced on a Service Repair Order.');
            }
        }
    }
    
    //Utility method to update SRO with Vehicle Inventory that is in Stock if Service Vehicle and VIN is provided by user
    private static Map<Id, dealer__Service_Vehicle__c> vehicleServMap = null;
    private static Map<String, dealer__Service_Vehicle__c> serviceVehicleVinMap = null;
    private static Map<Id, dealer__Vehicle_Inventory__c> vehicleInvMap = null;

    public static void UpdateVehicleInventoryWithVIN(List<dealer__Service_Repair_Order__c> SROList)
    {
        Set<Id> serviceVehicleIds = new Set<Id>();
        Set<Id> vehicleInventoryIds = new Set<Id>();
        Set<String> vehicleVins = new Set<String>();

        for(dealer__Service_Repair_Order__c objSRO : SROList) {

            if(objSRO.dealer__Vehicle__c != null && !serviceVehicleIds.contains(objSRO.dealer__Vehicle__c))
            serviceVehicleIds.add(objSRO.dealer__Vehicle__c);

            if(objSRO.dealer__Vehicle__c == null && objSRO.dealer__Vehicle_Inventory__c != null && !vehicleInventoryIds.contains(objSRO.dealer__Vehicle_Inventory__c))
            vehicleInventoryIds.add(objSRO.dealer__VIN__c);
            //these can be combined to one if, but I separated to easily understand the difference
            if(objSRO.dealer__Vehicle_Inventory__c != null && !vehicleInventoryIds.contains(objSRO.dealer__Vehicle_Inventory__c))
            vehicleInventoryIds.add(objSRO.dealer__Vehicle_Inventory__c);
        }

        if(ServiceRepairOrderControlHandler.vehicleServMap==null) {

            ServiceRepairOrderControlHandler.vehicleInvMap = new Map<Id,dealer__Vehicle_Inventory__c>();
            ServiceRepairOrderControlHandler.vehicleServMap = new Map<Id,dealer__Service_Vehicle__c>();
            ServiceRepairOrderControlHandler.serviceVehicleVinMap = new Map<String,dealer__Service_Vehicle__c>();

            for(dealer__Vehicle_Inventory__c objInventoryVehicle: [SELECT Id, VIN__C FROM dealer__Vehicle_Inventory__c where Id IN:vehicleInventoryIds]){
                vehicleVins.add(objInventoryVehicle.VIN__c);
                ServiceRepairOrderControlHandler.vehicleInvMap.put(objInventoryVehicle.Id, objInventoryVehicle);
            }
            for(dealer__Service_Vehicle__c objServiceVehicle: [SELECT Id, VIN__c FROM dealer__Service_Vehicle__c WHERE Id IN:serviceVehicleIds OR VIN__c IN:vehicleVins])
            {
               ServiceRepairOrderControlHandler.serviceVehicleVinMap.put(objServiceVehicle.VIN__c, objServiceVehicle);
               ServiceRepairOrderControlHandler.vehicleServMap.put(objServiceVehicle.Id,objServiceVehicle);
           }
       }

       for(dealer__Service_Repair_Order__c objSRO : SROList)
       {
        if(objSRO.dealer__Vehicle__c != null && objSRO.dealer__Vehicle_Inventory__c != null)
        {
            dealer__Vehicle_Inventory__c inventoryVehicle = vehicleInvMap.get(objSRO.dealer__Vehicle_Inventory__c);
            dealer__Service_Vehicle__c serviceVehicle = vehicleServMap.get(objSro.dealer__Vehicle__c);

            if(inventoryVehicle != null && serviceVehicle != null)
            {            
                    // Check if VIN's match
                    if(serviceVehicle.VIN__c != null && inventoryVehicle.VIN__c != null)
                    {
                        if(serviceVehicle.VIN__c != inventoryVehicle.VIN__c)
                        objSRO.addError('Service vehicle and Inventory vehicle VIN\'s do not match. Please choose the same vehicle');
                    }           
                }
            }
            // If inventory vehicle is added and not the service vehicle. Auto populate the service vehicle if exists
            if(objSRO.dealer__Vehicle__c == null && objSRO.dealer__Vehicle_Inventory__c != null)
            {
                dealer__Vehicle_Inventory__c inventoryVehicle = vehicleInvMap.get(objSRO.dealer__Vehicle_Inventory__c);
                dealer__Service_Vehicle__c serviceVehicle = serviceVehicleVinMap.get(inventoryVehicle.VIN__c);
                objSRO.dealer__Vehicle__c = (serviceVehicle != null) ? serviceVehicle.Id : null;   
            }
        }       
    }   
    
    /*Work 000746 Begin*/     
    //Utility method to rollup Internal charges of Posted SRO on Vehicle Inventory's Internal Charges
    public static void RollUpInternalChargesOnVehicle(List<dealer__Service_Repair_Order__c> SROList)
    {

        //Vehicle inventory Id set
        Set<Id> VehicleInventoryIdSet = new Set<Id>();

        //Vehicle Inventory List to update
        List<dealer__Vehicle_Inventory__c> VehicleInventoryToUpdateList = new List<dealer__Vehicle_Inventory__c>();
        
        //For loop to populate Vehicle Inventory Id set
        for(dealer__Service_Repair_Order__c objSRO : SROList){
            if(objSRO.dealer__Vehicle_Inventory__c != null){
                VehicleInventoryIdSet.add(objSRO.dealer__Vehicle_Inventory__c);
            }           
        }
        
        //For loop to populate Vehicle Inventory's Internal charges and Work in Process fields
        for(dealer__Vehicle_Inventory__c objVehicleInventory : [SELECT Id, Name, dealer__Internal_Charges__c, dealer__Internal_Labor__c, dealer__Internal_Misc__c, dealer__Internal_Parts__c, dealer__Internal_Sublet__c,
                                                                dealer__Work_in_Process__c, dealer__WIP_Labor__c, dealer__WIP_Misc__c, dealer__WIP_Parts__c, dealer__WIP_Sublet__c,
                                                                	(SELECT Id, Name, dealer__Internal_Charges__c, dealer__Status__c, dealer__Internal_Labor_Charges__c, dealer__Internal_Misc_Charges__c, dealer__Internal_Parts_Charges__c, dealer__Customer_Sublet_Charges__c 
                                                                 	FROM dealer__Service_Repair_Orders__r) 
                                                                FROM dealer__Vehicle_Inventory__c WHERE Id IN : VehicleInventoryIdSet]){

            //Initialize Internal charges to 0.0
            objVehicleInventory.dealer__Internal_Charges__c = 0.0;
            objVehicleInventory.dealer__Internal_Labor__c = 0.0;
            objVehicleInventory.dealer__Internal_Misc__c = 0.0;
            objVehicleInventory.dealer__Internal_Parts__c = 0.0;
            objVehicleInventory.dealer__Internal_Sublet__c = 0.0;
                                                                    
            //Initialize Work in process to 0.0
            objVehicleInventory.dealer__Work_in_Process__c = 0.0;           //#W-000814   
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
                
                //#W-000814
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
            VehicleInventoryToUpdateList.add(objVehicleInventory);            
        }

        //Update Vehicle Inventory
        if(VehicleInventoryToUpdateList.size()>0){
            update VehicleInventoryToUpdateList;
        }                                      
    } 
    /*Work 000746 End*/ 
    
    //Utility method to Check Record to see if the record has been posted to accounting, if so, do not allow edit  
    public static void ResrictToEditPostedSRO(List<Service_Repair_Order__c> SROList, Map<Id, Service_Repair_Order__c> SROOldMap)
    {         
        TriggerControl__c tc = TriggerControl__c.getOrgDefaults();
        Set<String> protectedCodes = Utility.protectedStatusCodes('dealer__Service_Repair_Order__c');
        for(Service_Repair_Order__c r : SROList) {

            System.debug(SROOldMap.get(r.Id).Status__c);
            System.debug(r.Status__c);

            if(SROOldMap.get(r.Id).Status__c!=null && protectedCodes.contains(SROOldMap.get(r.Id).Status__c) && tc.DeletionOverride__c==false) {
                r.addError(SROOldMap.get(r.Id).Status__c+' Repair Orders may not be edited.  The status code is protected.');
            }
        }    
    }

    //Utility method to fill company number from logged in user's division if its null
    public static void CompanyNumberFromUser(List<dealer__Service_Repair_Order__c> SROList) 
    {

        Boolean requiresCompanyNumber = false;
        for(dealer__Service_Repair_Order__c d : SROList) {
            if(d.Company_Number__c == null) {
                requiresCompanyNumber=true;
            }
        }
        
        if(!requiresCompanyNumber) {
			return; 
        }

        User u = [SELECT Id, Division FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        // System.assert(u.Division != null, 'User record must contain the company number in the Division input.');
        for(dealer__Service_Repair_Order__c d : SROList) {
            if(d.Company_Number__c == '' || d.Company_Number__c == null) {
                d.Company_Number__c = u.Division;
            }
        }
    }

    //Utility method for calculations on SRO
    public static void SROCalculations(List<dealer__Service_Repair_Order__c> SROList){
       //first, the SRO is created THEN the lines.
        Set<Id> SroIds = new Set<Id>();
        for (dealer__Service_Repair_Order__c dOr: SROList) {
            if ( dOr.Id != null)  {//existing
                SroIds.add(dOr.Id);
            }
        }
        //need to get a list of all jobs for each SRO that was updated .. 
        if(SroIds.size() > 0){
            Map<Id, List<Service_Job__c> > jobMap = new Map<Id,List<Service_Job__c> >();
            for(Service_Job__c job : [SELECT id, Stat__c, Service_Repair_Order__c, Service_Repair_Order__r.Warranty_Deductible__c, Labor_Type__c,Labor_Charges__c,Parts_Total__c,Sublet_Total__c,Misc_Charges__c 
                FROM Service_Job__c WHERE Service_Repair_Order__c IN:SroIds AND Labor_Type__c in('C','W','I')] ){
                if(jobMap.get(job.Service_Repair_Order__c) == null){
                    List<Service_Job__c> j = new List<Service_Job__c>(); 
                    j.add(job);
                    jobMap.put(job.Service_Repair_Order__c,j);
                }else if(jobMap.get(job.Service_Repair_Order__c) != null){
                    jobMap.get(job.Service_Repair_Order__c).add(job);
                }
            }
            //Job Lines Exist for the Service Repair Orders in Question
            for(Service_Repair_Order__c sro : SROList){
                Decimal laborC  = 0;
                Decimal partC   = 0;
                Decimal subletC = 0;
                Decimal miscC   = 0;
                
                Decimal laborW = 0;
                Decimal partW = 0;
                Decimal subletW = 0;
                Decimal miscW = 0;

                Decimal laborI = 0;
                Decimal partI = 0;
                Decimal subletI = 0;
                Decimal miscI = 0;
                Boolean jobs_open = false;
                Boolean jobs_declined = false;

                if(sro.Id != null){
                    if(jobMap.get(sro.Id) != null && jobMap.get(sro.Id).size()>0){
                        for(Service_Job__c job : jobMap.get(sro.Id)){
                            switch on job.Labor_Type__c{
                                when 'C'{
                                    laborC  += job.Labor_Charges__c !=null ? job.Labor_Charges__c:0;
                                    partC   += job.Parts_Total__c   !=null ? job.Parts_Total__c:0;
                                    subletC += job.Sublet_Total__c  !=null ? job.Sublet_Total__c:0;
                                    miscC   += job.Misc_Charges__c  !=null ? job.Misc_Charges__c:0;
                                }
                                when 'W'{
                                    laborW  += job.Labor_Charges__c !=null ? job.Labor_Charges__c:0;
                                    partW   += job.Parts_Total__c   !=null ? job.Parts_Total__c:0;
                                    subletW += job.Sublet_Total__c  !=null ? job.Sublet_Total__c:0;
                                    miscW   += job.Misc_Charges__c  !=null ? job.Misc_Charges__c:0;
                                }
                                when 'I'{
                                    laborI  += job.Labor_Charges__c !=null ? job.Labor_Charges__c:0;
                                    partI   += job.Parts_Total__c   !=null ? job.Parts_Total__c:0;
                                    subletI += job.Sublet_Total__c  !=null ? job.Sublet_Total__c:0;
                                    miscI   += job.Misc_Charges__c  !=null ? job.Misc_Charges__c:0;
                                }
                            }
                            if(jobs_open == false)
                            jobs_open = job.Stat__c != 'Complete' ? true : false;
                            if(jobs_declined == false)
                            jobs_declined = job.Stat__c == 'Declined' ? true : false;
                        }
                    }

                    sro.Customer_Charges__c = laborC + partC + subletC + miscC;
                    sro.Customer_Misc_Charges__c = miscC;
                    sro.Customer_Sublet_Charges__c = subletC;

                    sro.Warranty_Charges__c = laborW + partW + subletW + miscW;
                    sro.Warranty_Misc_Charges__c = miscW;

                    // Increase Customer Charges and reduce Warranty Charges if Deductible exists
                    if(jobMap.get(sro.Id) != null && jobMap.get(sro.Id).size()>0) {
                        // We can use the first row as it is a header level query
                        Decimal warrantyDeductable = ((Decimal)jobMap.get(sro.Id)[0].Service_Repair_Order__r.Warranty_Deductible__c==null) ? 0 : (Decimal)jobMap.get(sro.Id)[0].Service_Repair_Order__r.Warranty_Deductible__c;
                        sro.Warranty_Charges__c -= warrantyDeductable;
                        sro.Customer_Charges__c += warrantyDeductable;
                    }

                    sro.Internal_Charges__c = laborI + partI + subletI + miscI;
                    sro.Internal_Misc_Charges__c = miscI;

                    if(sro.Discount_Type__c != null) {
                        switch on sro.Discount_Type__c{
                            when '5%' {sro.Discount_Total__c = (sro.Customer_Charges__c * -.05);}
                            when '10%' {sro.Discount_Total__c = (sro.Customer_Charges__c * -.10);}
                            when '15%' {sro.Discount_Total__c = (sro.Customer_Charges__c * -.15);}
                            when '20%' {sro.Discount_Total__c = (sro.Customer_Charges__c * -.20);}
                            when '25%' {sro.Discount_Total__c = (sro.Customer_Charges__c * -.25);}
                        }
                    } else if (sro.Discount_Type__c == null && sro.Discount_Total__c != null){
                        sro.Discount_Total__c = sro.Discount_Total__c > 0/*negative discount*/? sro.Discount_Total__c * -1 : sro.Discount_Total__c;
                    }
                    Decimal total_payments = sro.Payments_Total__c != null ? sro.Payments_Total__c.setScale(2, RoundingMode.HALF_UP) : 0 ;

                    sro.Discount_Total__c   = sro.Discount_Total__c == null ? 0 : sro.Discount_Total__c;
                    sro.Discount_Total__c   = sro.Discount_Total__c.setScale(2, RoundingMode.HALF_UP);
                    sro.Customer_Charges__c = sro.Customer_Charges__c.setScale(2, RoundingMode.HALF_UP);
                    Decimal total_due = sro.Customer_Charges__c - total_payments - (Utility.isGreaterThanZero(Math.abs(sro.Discount_Total__c))? Math.abs(sro.Discount_Total__c) : 0);

                    if( (jobs_open && sro.Number_of_Repair_Lines__c != 0 && sro.Status__c == 'Open') || (jobs_open && sro.Number_of_Repair_Lines__c != 0 && total_due > 0) || (jobs_declined) )
                        // sro.Status__c = 'Cashier'; //Do not agree with setting the cashier status via this condition.
                    if(sro.Payments_Total__c != null && total_payments >= sro.Customer_Charges__c && !jobs_open && sro.Status__c != 'Posted'){
                        // sro.Status__c = 'Invoiced';
                        // sro.Invoiced_Date_Time__c = Date.today();
                    }
                    if(jobs_open && !jobs_declined){
                        //sro.Status__c = 'Open';
                    }
                }
            }
        }
    }

    //Utility method to update Vehicle Inventory's Work from SRO's Internal Charges
    public static void VehicleInventoryWorkUpdate(List<dealer__Service_Repair_Order__c> SROList){
        //#W-000814 - Commented the code for rolling up internal charges 
        /*
        Set<Id> setVehicleId = new Set<Id>();
        List<dealer__Vehicle_Inventory__c> listVehicleToUpdate = new List<dealer__Vehicle_Inventory__c>();      

        for(dealer__Service_Repair_Order__c s : SROList) {
            setVehicleId.add(s.dealer__Vehicle_Inventory__c);
        }       
        
        //Get vehicles
        Map<Id,dealer__Vehicle_Inventory__c> mapVehicle = new Map<Id,dealer__Vehicle_Inventory__c>([Select Id, dealer__Work_in_Process__c from dealer__Vehicle_Inventory__c where Id in: setVehicleId limit 1]);
        
        for(dealer__Service_Repair_Order__c s : SROList){
            
            if(s.dealer__Vehicle_Inventory__c != null && s.dealer__Internal_Charges__c != null && s.dealer__Status__c != 'Posted' && mapVehicle.get(s.dealer__Vehicle_Inventory__c) != null) {  
                
                if(s.dealer__Internal_Charges__c != mapVehicle.get(s.dealer__Vehicle_Inventory__c).dealer__Work_in_Process__c){
                    
                    // Should be Internal Charges
                    mapVehicle.get(s.dealer__Vehicle_Inventory__c).dealer__Work_in_Process__c = s.dealer__Internal_Charges__c;
                    listVehicleToUpdate.add(mapVehicle.get(s.dealer__Vehicle_Inventory__c));                    
                }
            }       
        }
        //Update Vehicles
        if(listVehicleToUpdate.size()>0){
            update listVehicleToUpdate;
            } */

    }

    //Utility method to prevent SRO deletion if charges exists
    public static void restrictDeletion(List<dealer__Service_Repair_Order__c> OldSROList){
        dealer__TriggerControl__c tc = dealer__TriggerControl__c.getOrgDefaults();
        for(dealer__Service_Repair_Order__c ro : OldSROList){
            if(tc.dealer__DeletionOverride__c==false 
                && (ro.dealer__Customer_Pay_Labor__c>0 
                    || ro.dealer__Customer_Pay_Parts__c>0 
                    || ro.dealer__Customer_Sublet_Charges__c>0 
                    || ro.dealer__Deposit__c>0 
                    || ro.dealer__Internal_Charges__c>0 
                    || ro.dealer__Hazardous_Materials__c>0 
                    || ro.dealer__Shop_Supplies__c>0 
                    || ro.dealer__Tax__c>0 
                    || ro.dealer__Warranty_Charges__c>0)){
                ro.addError('Delete Failed : Unable to Delete this Repair Order, charges still exist.');
            }
        }
    }

    //Utility method to throw error if custom settings are not present
    public static void checkForCustomSettings(List<dealer__Service_Repair_Order__c> SROList){

        /*
            DMS Defaults are protected settings that control Service Related Settings.  These settings are found on /apex/setupdefaultdmssettings
            Fixed Operations Settings are Org wide settings that control 
            */      

            dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
            dealer__FixedOperationsSettings__c ops = dealer__FixedOperationsSettings__c.getOrgDefaults();
            Map<String, dealer__RO_Status_Settings__c> status = dealer__RO_Status_Settings__c.getall();

            for(dealer__Service_Repair_Order__c objSRO : SROList){
                If(dms == null){
                    objSRO.addError('DMS Settings must be provided before Repair Orders may be Created.  Please contact your System Administrator.'); 
                }
                if(ops == null){
                    objSRO.addError('Fixed Operation Settings for the Organization Defaults must be set before creating Repair Orders.  Please Contact your System Administrator.');
                }
                if(status == null) { 
                    objSRO.addError('Repair Order Status Settings must be created before attempting to Create a Repair Order.  Please Contact Your System Administrator.');         
                }
            }
        }

    //Utility method to calculate totals of charges and applicable settings
    private static List<Contact> contactList = null;
    private static List<User> userList = null;
    private static List<Service_Vehicle__c> vehicleList = null;
    private static List<Dealer_Location__c> dealerLocationList = null;

    public static void CalculateChargeAndCustomSettings(List<dealer__Service_Repair_Order__c> SROList){

        system.debug('CalculateChargeAndCustomSettings');
        Set<Id> customerID = new Set<ID>();
        Set<String> customerExternalReference = new Set<String>();
        Set<String> vehicleExtRef = new Set<String>();
        Set<String> advisorReference = new Set<String>();
        Set<Id> SROCompanyIdSet = new Set<Id>();

        Map<Id, Contact> contacts = new Map<Id, Contact>();
        Map<String, Contact> contactKey = new Map<String, Contact>();
        Map<String, User> advisorKey = new Map<String, User>();
        Map<Id, dealer__Service_Vehicle__c> vehicles = new Map<Id, dealer__Service_Vehicle__c>();
        Map<String, dealer__Service_Vehicle__c> vehicleKey = new Map<String, dealer__Service_Vehicle__c>();
        Map<Id, dealer__Dealer_Location__c> SROLocationMap = new Map<Id, dealer__Dealer_Location__c>();

        Id locId = Utility.lookupUserLocation();
        for(dealer__Service_Repair_Order__c s : SROList) {
            // If Company Number is Blank, assign
            if(s.dealer__Company__c == null && locId==null){
                s.dealer__Company__c = locId;
            }
        }
        

        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');

        for(dealer__Service_Repair_Order__c sr : SROList) {

            if(sr.dealer__Customer_Contact__c != null) {
                customerID.add(sr.dealer__Customer_Contact__c);
            }

            if(sr.dealer__Customer_Number__c != null && sr.dealer__Customer_Contact__c==null) {
                customerExternalReference.add(sr.dealer__Customer_Number__c);
            }

            if(sr.dealer__Vehicle__c == null && sr.dealer__VIN__c != null) {
                vehicleExtRef.add(sr.dealer__VIN__c);
            }

            // Associated Employee Number needs to Link Advisor
            if(sr.dealer__Service_Advisor_ID__c != null) {
                advisorReference.add(sr.dealer__Service_Advisor_ID__c);
            }

            if(sr.dealer__Company__c != null){
                SROCompanyIdSet.add(sr.dealer__Company__c);
            }
        }

        if(ServiceRepairOrderControlHandler.contactList==null || ServiceRepairOrderControlHandler.contactList.size() != customerID.size()) {
            ServiceRepairOrderControlHandler.contactList=[SELECT Id, AccountId, Account.dealer__Tax_ID__c,dealer__External_ID__c FROM Contact WHERE Id IN : customerID OR dealer__External_ID__c IN : customerExternalReference LIMIT 2000];
        }
        for(Contact c : ServiceRepairOrderControlHandler.contactList) {
            contacts.put(c.Id, c);
            contactKey.put(c.dealer__External_ID__c, c);
        }

        if(ServiceRepairOrderControlHandler.userList==null) {
            ServiceRepairOrderControlHandler.userList=[SELECT Id, EmployeeNumber FROM User WHERE EmployeeNumber IN : advisorReference LIMIT 2000];
        }
        for(User u : ServiceRepairOrderControlHandler.userList) {
            advisorKey.put(u.EmployeeNumber, u);
        }

        if(ServiceRepairOrderControlHandler.vehicleList==null) {
            ServiceRepairOrderControlHandler.vehicleList=[SELECT Id, dealer__VIN__c FROM dealer__Service_Vehicle__c WHERE dealer__VIN__c IN : vehicleExtRef LIMIT 2000];
        }
        for(dealer__Service_Vehicle__c dsv : ServiceRepairOrderControlHandler.vehicleList) {
            vehicles.put(dsv.ID, dsv);
            vehicleKey.put(dsv.dealer__VIN__c, dsv);
        }

        if(ServiceRepairOrderControlHandler.dealerLocationList==null) {
            ServiceRepairOrderControlHandler.dealerLocationList=[SELECT Id, Name, Tax_Parts__c, Tax_Service__c, Tax_Misc__c, Tax_Local_Rate__c FROM Dealer_Location__c WHERE Id IN : SROCompanyIdSet];
        }
        for(dealer__Dealer_Location__c objLocation : ServiceRepairOrderControlHandler.dealerLocationList){
            SROLocationMap.put(objLocation.Id, objLocation);
        }

        //begin W-002056 Josh Cruz
        //This below captures all misc charge codes on every location
        // Create map <Id, MiscChargeCode__c> Id == locationId

        Map<Id, List<MiscChargeCode__c> > chargeCodeMap = new Map<Id, List<MiscChargeCode__c> >(); //Map<locId, LIst MiscChargeCode__c>

        for(MiscChargeCode__c mc : [SELECT Id, Name, dealer__Active__c, dealer__Taxable__c, PercentageBasedAmount__c, FlatAmount__c, MaximumCharge__c, dealer__BaseCharge__c, dealer__Location__c FROM MiscChargeCode__c WHERE Location__c IN: SROLocationMap.keySet()] ){
            // If not in Map
            if(chargeCodeMap.get(mc.Location__c) == null) {
                List <MiscChargeCode__c> mclist = new List <MiscChargeCode__c>();
                mclist.add(mc);
                chargeCodeMap.put(mc.Location__c, mclist);
            } 
            if(chargeCodeMap.get(mc.Location__c) != null ){
                List <MiscChargeCode__c> mclist = new List <MiscChargeCode__c>(chargeCodeMap.get(mc.Location__c));
                mclist.add(mc);
                chargeCodeMap.put(mc.Location__c, mclist);
            }
        }

        for(dealer__Service_Repair_Order__c s : SROList){

            if(s.dealer__VIN__c != null){
                s.dealer__VIN__c = s.dealer__VIN__c.toUpperCase();
            }

            /** If Contact is populated and account is not, set account based on Contact */
            if(s.Customer_Contact__c != null 
                && s.Customer__c == null
                && contacts.get(s.Customer_Contact__c) != null
                && contacts.get(s.Customer_Contact__c).AccountId!=null){
                    s.Customer__c = contacts.get(s.Customer_Contact__c).AccountId;
            }

            // Set Customer if Not Previously Set
            if(contacts.get(s.dealer__Customer_Contact__c) == null && s.dealer__Customer_Number__c != null){
                if(contactKey.get(s.dealer__Customer_Number__c) != null){
                    s.dealer__Customer_Contact__c = contactKey.get(s.dealer__Customer_Number__c).Id;
                }
            }

            // Set Advisor
            if(s.dealer__Service_Advisor_ID__c != null){
                if(advisorKey.get(s.dealer__Service_Advisor_ID__c) != null){
                    s.dealer__Service_Advisor__c = advisorKey.get(s.dealer__Service_Advisor_ID__c).Id;
                }
            }

            // Set Vehicle Record by VIN
            if(s.dealer__Vehicle__c==null && s.dealer__VIN__c != null){
                if(vehicleKey.get(s.dealer__VIN__c)!=null) {
                    s.dealer__Vehicle__c = vehicleKey.get(s.dealer__VIN__c).Id;
                }
            }

            // Calculate Totals
            s.dealer__Customer_Labor_Charges__c = s.dealer__Customer_Pay_Labor__c;
            s.dealer__Customer_Parts_Charges__c = s.dealer__Customer_Pay_Parts__c;

            // Calculate tax on customer pay portion
            boolean taxableAccount = false;
            s.dealer__Tax__c = Decimal.valueOf('0.00');

            // Contact based Transaction
            if(s.dealer__Customer_Contact__c != null){
                if(contacts.get(s.dealer__Customer_Contact__c).Account.dealer__Tax_ID__c == null && !s.dealer__Tax_Exempt__c){
                    taxableAccount = true;
                    s.dealer__Taxable__c = true;
                }else if(s.dealer__Tax_Exempt__c){
                    s.dealer__Taxable__c = false;
                }
            //Account based by default...
            } else if (s.dealer__Customer__c != null){
                if(s.dealer__Customer__r.dealer__Tax_ID__c == null && !s.dealer__Tax_Exempt__c){
                    taxableAccount = true;
                    s.dealer__Taxable__c = true;
                }else if(s.dealer__Tax_Exempt__c){
                    s.dealer__Taxable__c = false;
                }
            }

            // Taxable Shop Supplies
            if(s.dealer__Shop_Supplies__c != null && s.dealer__Shop_Supplies__c != Decimal.valueOf('0.0')) {
                s.dealer__Tax__c += (s.dealer__Shop_Supplies__c * (dms.dealer__Default_Tax_Rate__c / 100));
            }

            // get the location based tax Settings
            if(s.Company__c != null && taxableAccount == true && SROLocationMap.get(s.Company__c) != null){

                Dealer_Location__c objLocation = SROLocationMap.get(s.Company__c);

                Decimal totalTax = 0;
                Boolean taxParts = objLocation.Tax_Parts__c;
                Boolean taxLabor = objLocation.Tax_Service__c;
                Decimal taxRate  = objLocation.Tax_Local_Rate__c;

                

                if (objLocation != null && objLocation.Tax_Parts__c != null && objLocation.Tax_Service__c != null && objLocation.Tax_Local_Rate__c != null ) {


                    if(taxParts && s.Customer_Parts_Charges__c != null && s.Customer_Parts_Charges__c > 0) {
                        totalTax += s.Customer_Parts_Charges__c * ( taxRate / 100);
                    }

                    if(taxLabor  && s.Customer_Labor_Charges__c != null && s.Customer_Labor_Charges__c > 0) {
                        totalTax += s.Customer_Labor_Charges__c * ( taxRate / 100);
                    }

                    if(s.Customer_Sublet_Charges__c!=null && s.Customer_Sublet_Charges__c>0) {
                        totalTax += s.Customer_Sublet_Charges__c * (taxRate / 100);
                    }
                    if(objLocation.Tax_Misc__c != null && objLocation.Tax_Misc__c == 'All' && s.Customer_Misc_Charges__c!=null && s.Customer_Misc_Charges__c>0) {
                        totalTax += s.Customer_Misc_Charges__c * (taxRate / 100);
                    }

                    // accounting for discount before calculating tax 
                    if(s.dealer__Discount_Total__c != null ){
          
                        totalTax += s.dealer__Discount_Total__c * (taxRate / 100);
                    }

                    if(objLocation.Tax_Misc__c != null && objLocation.Tax_Misc__c == 'Respect Misc. Charge Code Record' && s.Customer_Misc_Charges__c!=null && s.Customer_Misc_Charges__c>0) {
                      //W-002056 If location tax is set to respects misc charge code This checks every misc charge code against the current location and applies tax to each misc code that needs to be taxed- Josh C.
                        locId = s.dealer__Company__c;

                        List<MiscChargeCode__c> miscChargeList = new List<MiscChargeCode__c>();
                        if(chargeCodeMap.get(locId) != null){
                            miscChargeList = chargeCodeMap.get(locId);
                        }
                        
                        if(miscChargeList.size() > 0) {
                            
                            // we need to determine the taxableMiscTotal here
                            Decimal taxableMiscTotal = 0;
                            List <String> taxed= new List <String>();

                            for(MiscChargeCode__c code: miscChargeList){
                                if(code.Active__c && code.Taxable__c){
                                    if(Code.FlatAmount__c != null && Code.FlatAmount__c > 0){
                                        taxableMiscTotal += Code.FlatAmount__c;
                                    } else {
                                        if(Code.PercentageBasedAmount__c != null && code.PercentageBasedAmount__c > 0) {
                                            Decimal maxAmount = code.MaximumCharge__c;
                                            Decimal charge = 0;
                                            if(code.BaseCharge__c == 'Labor Sale' && taxed.contains(code.id) != true ){
                                                //logic to get the percentagebased amount from labor sale price
                                                charge =  s.dealer__Customer_Pay_Labor__c * (code.PercentageBasedAmount__c / 100);
                                                taxed.add(code.Id);
                                            }
                                            if(code.BaseCharge__c == 'Labor Cost' && taxed.contains(code.id) != true  ){
                                                //logic to get the percentagebased amount from labor Cost price
                                                charge =  s.dealer__Internal_Labor_Charges__c   * (code.PercentageBasedAmount__c / 100);
                                                 taxed.add(code.Id);
                                            }
                                            if(code.BaseCharge__c == 'Parts Sale' && taxed.contains(code.id) != true){
                                                //logic to get the percentagebased amount from Parts sale price
                                                charge =  s.dealer__Customer_Pay_Parts__c   * (code.PercentageBasedAmount__c / 100);
                                                taxed.add(code.Id);
                                            }
                                            if(code.BaseCharge__c == 'Parts Cost' && taxed.contains(code.id) != true){
                                                //logic to get the percentagebased amount from Parts Cost price
                                                charge =  s.dealer__Parts_Cost__c  * (code.PercentageBasedAmount__c / 100);
                                                taxed.add(code.Id);
                                            }   
                                            taxableMiscTotal += maxAmount != null && charge > maxAmount ? maxAmount : charge;
                                        }                
                                    }
                                }     
                            }
                       
                            //AFTER Loop add total tax:
                            //IF There is a max charge, don't exceed it:
                            totalTax += taxableMiscTotal * (taxRate / 100);
                            taxed.clear();
                        }   
                    }
                    //end W-002056
                }
                s.Tax__c = totalTax.setScale(2, System.RoundingMode.HALF_UP);
            }
        }
    }

    //Utility method to RO Close Update Vehicle Last Service Data
    public static void SROCloseUpdateVehicleService(List<dealer__Service_Repair_Order__c> SROList){
        
        // Context of the trigger only evaluates closed repair orders, if we have none in the list, exit
        Boolean executeLogic = false;
        for(Service_Repair_Order__c sro : SROList) {
            if(sro.Invoiced_Date_Time__c!=null || sro.Posted_Date_Time__c!=null) {
                executeLogic = true;
            }
        }
        if(executeLogic==false) {
            return;
        }           

        Set<Id> vehicles = new Set<Id>();
        Set<Id> roIds = new Set<Id>(); 
        Map<Id, dealer__We_Owe__c> repairToWeOweMap = new Map<Id, dealer__We_Owe__c>();
        List<dealer__We_Owe__c> weoweToUpdate = new List<dealer__We_Owe__c>();
        List<dealer__We_Owe__c> weoweToUpdateStatus = new List<dealer__We_Owe__c>();
        Set<Id> setLocationId = new Set<Id>();//W-000697
        Set<Id> myLocations = new Set<Id>();//W-000697      

        for(dealer__Service_Repair_Order__c sr : SROList) {
            if(sr.dealer__Vehicle__c!=null) {
                vehicles.add(sr.dealer__Vehicle__c);
            }
            roIds.add(sr.Id);

            //W-000697 
            if(sr.dealer__Company__c!=null){
                setLocationId.add(sr.dealer__Company__c);
            }
        }
        
        //W-000697
        for(dealer__Dealer_Location_User__c locU : [SELECT Id, dealer__Dealer_Location__c FROM dealer__Dealer_Location_User__c WHERE dealer__User__c =: UserInfo.getUserId() and dealer__Dealer_Location__c in :setLocationId]) {
            myLocations.add(locU.dealer__Dealer_Location__c);
        }

        Map<Id, Service_Vehicle__c> svehicle = new Map<Id, Service_Vehicle__c>([Select Id, dealer__Last_Service__c, dealer__Last_Odometer__c from dealer__Service_Vehicle__c where Id IN:vehicles limit 10000]);
        Map<Id, Service_Vehicle__c> svUpdateMap = new Map<Id, Service_Vehicle__c>();
        for(dealer__Service_Repair_Order__c sro : SROList) {

            //W-000697 Add error if Logged in user is not related to the location of Appointment
            if(sro.dealer__Company__c != null && !myLocations.contains(sro.dealer__Company__c)){
                //sro.addError('Error: Logged in user is not related to the location of service repair order');
            }

            if(svehicle.containsKey(sro.dealer__Vehicle__c) && 
                (  (svehicle.get(sro.dealer__Vehicle__c).dealer__Last_Service__c != null && svehicle.get(sro.dealer__Vehicle__c).dealer__Last_Service__c != null) 
                    && 
                    svehicle.get(sro.dealer__Vehicle__c).dealer__Last_Service__c != Date.valueOf(sro.dealer__Invoiced_Date_Time__c) ||
                    svehicle.get(sro.dealer__Vehicle__c).dealer__Last_Odometer__c != sro.dealer__Mileage_Out__c
                    )) {

                dealer__Service_Vehicle__c sv = svehicle.get(sro.dealer__Vehicle__c);
                sv.dealer__Last_Service__c = Date.valueOf(sro.dealer__Invoiced_Date_Time__c);
                sv.dealer__Last_Odometer__c= sro.dealer__Mileage_Out__c;
                svUpdateMap.put(sv.Id, sv);
            }
        }
        
        // If our update map contains records, perform the update.
        if(svUpdateMap.size()>0) {
            try {
                System.debug(svehicle);
                update svehicle.values();
                } Catch(DmlException e) {
                    SROList[0].addError('Error updating Service Vehicle(s) '+e.getMessage());
                }
            }   

        }

    //Utility method for Rewards Calculations After Insert/Update/Delete
    public static void RewardCalculationsOnSRO(List<dealer__Service_Repair_Order__c> SROList){
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
        Set<Id> SROIdSet = new Set<Id>();
        
        for(dealer__Service_Repair_Order__c objSRO : SROList){
            SROIdSet.add(objSRO.Id);            
        }
        if(crm != null){            
            if(crm.dealer__Rewards_Program_Enabled__c == true){
                // Get Map of Service Job Lines                
                Map<Id, String> opCodes = new Map<Id, String>();
                for(dealer__Service_Job__c jl : [SELECT Id, dealer__Service_Type__c, dealer__Op_Code__c, dealer__Service_Repair_Order__c FROM dealer__Service_Job__c WHERE dealer__Service_Repair_Order__c IN : SROIdSet LIMIT 5000]) {
                    opCodes.put(jl.dealer__Service_Repair_Order__c, opCodes.get(jl.dealer__Service_Repair_Order__c)+jl.dealer__Op_Code__c); 
                }

                // Iterate Trigger Content
                List<dealer__Reward_Transaction__c> rt = new List<dealer__Reward_Transaction__c>();
                String[] oilMatch = crm.dealer__Rewards_OilChange_OpCodes__c.split(',');
                String[] freeMatch= crm.dealer__Rewards_FreeService_OpCodes__c.split(',');
                
                for(dealer__Service_Repair_Order__c sro : SROList){

                    if(sro.dealer__Invoiced_Date_Time__c != null && sro.dealer__Rewards_ID__c != null) {
                        // Calculate Rewards value and Measure Discounting
                        dealer__Reward_Transaction__c nrt = new dealer__Reward_Transaction__c();
                        nrt.dealer__Rewards_Account__c  =   sro.dealer__Rewards_ID__c;
                        nrt.dealer__Customer_Charges_this_visit__c=sro.dealer__Customer_Charges__c;
                        nrt.dealer__Service_Repair_Order__c=sro.Id;
                        nrt.dealer__Transaction_Document__c=sro.dealer__RO_Number__c;
                        nrt.dealer__Transaction_Date__c=Date.valueOf(sro.dealer__Invoiced_Date_Time__c);
                        // Did the consumer recieve a rewards discount?
                        if(sro.dealer__Discount_Code__c==crm.dealer__Rewards_Discount_Code__c) {
                            if(sro.dealer__Discount_Total__c>0) {
                                nrt.dealer__Rewards_Claimed__c=(sro.dealer__Discount_Total__c *-1);
                                } else {
                                    nrt.dealer__Rewards_Claimed__c=sro.dealer__Discount_Total__c.setScale(2);
                                }
                            }

                        // Calculate the rewards earned
                        if(sro.dealer__Customer_Charges__c>0) {
                            nrt.dealer__Rewards_Earned__c=(sro.dealer__Customer_Charges__c*(crm.dealer__Rewards_Percentage__c / 100));
                            nrt.dealer__Rewards_Earned__c=nrt.dealer__Rewards_Earned__c.setScale(2);
                        }
                        
                        // Check for Oil Change and or Free Service
                        for(String om : oilMatch) {
                            if(opCodes.get(sro.Id)!=null) {
                                if(opCodes.get(sro.Id).contains(om)) {
                                    nrt.dealer__Oil_Changed_this_visit__c=true;
                                }
                            }
                        }
                        
                        for(String fm : freeMatch) {
                            if(opCodes.get(sro.Id)!=null) {
                                if(opCodes.get(sro.Id).contains(fm)) {
                                    nrt.dealer__Free_Oil_Change__c=true;
                                }
                            }
                        }

                        rt.add(nrt);                                                
                    }
                }
                // If we have Rewards transactions, add them.
                if(rt.size()>0)
                upsert rt dealer__Transaction_Document__c;              
            }               
        }
    }
    
    //Utility method to Assign RO Number depending upon the custom settings
    public static void AssignRONumber(List<dealer__Service_Repair_Order__c> SROList){
        dealer__FixedOperationsSettings__c fixedSettings;
        List<dealer__FixedOperationsSettings__c> lstFixedSetting = [SELECT Id,dealer__Repair_Order_Index__c FROM dealer__FixedOperationsSettings__c WHERE SetupOwnerId =: UserInfo.getOrganizationId() LIMIT 1 for update];
        
        if(lstFixedSetting!=null && lstFixedSetting.size()>0){
            fixedSettings = lstFixedSetting[0];
        }
        else{
            fixedSettings = dealer__FixedOperationsSettings__c.getOrgDefaults();
        }

        if(fixedSettings != null && fixedSettings.dealer__Repair_Order_Index__c == null) {
            fixedSettings.dealer__Repair_Order_Index__c = 7000;
        }
        
        for(Service_Repair_Order__c objRO : SROList){
            //increment before assigning
            fixedSettings.dealer__Repair_Order_Index__c += 1; 
            objRO.RO_Number__c= objRO.Ro_Number__c == null ? String.valueOf(fixedSettings.dealer__Repair_Order_Index__c.setScale(0)): objRO.Ro_Number__c;
            objRO.Name = 'RO#'+(objRO.Company_Number__c!=null?objRO.Company_Number__c+'-':'')+objRO.RO_Number__c;
        }        
        //update the custom setting with recent RO Number
        upsert fixedSettings;       
    }
    
    //Utility method to Build RO Number if changed
    public static void ChangeRONumber(List<Service_Repair_Order__c> SROList, Map<Id, Service_Repair_Order__c> SROOldMap){
        for(Service_Repair_Order__c objRO: SROList){

            if(SROOldMap.get(objRO.id).Company_Number__c != objRO.Company_Number__c || SROOldMap.get(objRO.id).RO_Number__c != objRO.RO_Number__c){
                objRO.Name = 'RO#'+(objRO.Company_Number__c != null?objRO.Company_Number__c+'-':'')+objRO.RO_Number__c;
            }
        }       
    }

    public static void PreventWarrantyInvoicingSRO(List<dealer__Service_Repair_Order__c> SROList){         
        for(dealer__Service_Repair_Order__c objRO : SROList) {
          
            if(objRO.dealer__Warranty_Charges__c > 0 && objRO.dealer__Warranty_Account__c == null) {
                if (objRO.dealer__Status__c=='Invoiced' || objRO.dealer__Status__c=='Posted') {
                    objRO.addError('Repair Order contains warranty charges without a warranty account included in the warranty account lookup');
                }
            }
        }
    }

    /**
     *
     * DispatchRepairOrders
     * @notes Only called after insert
     *
     */
     public static void DispatchRepairOrders(List<Service_Repair_Order__c> SROList)
     {
        // Does this DMS have dispatching enabled
        if(Utility.isDMSFeatureEnabled('Dispatching')) {

            // Container for new dispatch events
            List<DispatchEvent__c> dispatchEvents = new List<DispatchEvent__c>();

            // Iterate records and insert Dispatch Events
            for(Service_Repair_Order__c sro : SROList){
                dispatchEvents.add(new DispatchEvent__c(
                    ServiceRepairOrderRef__c=sro.Id,
                    Location__c=sro.Company__c
                ));
            }

            // Try and insert records
            try {
                INSERT dispatchEvents;
            } Catch(DmlException e) {
                throw new DmlException(e.getMessage());
            } Catch(Exception e) {
                throw new ServiceRepairOrderControlHandlerException(e.getMessage());
            }
        }
     }

     public class ServiceRepairOrderControlHandlerException extends Exception {}

}