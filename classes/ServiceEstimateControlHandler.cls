public class ServiceEstimateControlHandler{
	
    //Set taxable based on Account 
    public static void setTaxable(List<Service_Estimate__c> estimateList) {
        
        for(Service_Estimate__c se : estimateList) {
            
            if(se.dealer__Tax_Exempt__c){
                se.dealer__Taxable__c = false;
            }else{
                se.dealer__Taxable__c = true;
            }           
        }        
    }
    
    public static void setLocation(List<Service_Estimate__c> estimateList) {
        Id userLocation = null;  
        for(Service_Estimate__c se : estimateList) {
            if(se.Store_Location__c==null || se.Id==null) {
                if(userLocation==null) {
                    userLocation = Utility.lookupUserLocation(); //This will only fire one time.
                }
                se.Store_Location__c=userLocation;
            }
        }        
    }

    public static void setCompanyNumber(List<Service_Estimate__c> estimateList){
        set<Id> locationIds = new set<Id>();
        for(Service_Estimate__c se : estimateList){
            locationIds.add(se.Store_Location__c);
        }
        map<Id, dealer__Dealer_Location__c> locationMap = new Map<Id, dealer__Dealer_Location__c>([Select Id, Company_Number__c, Name from Dealer_Location__c where Id IN: locationIds]);

        for(Service_Estimate__c se: estimateList){
            se.Company_Number__c = (locationMap.get(se.Store_Location__c)!=null) ? locationMap.get(se.Store_Location__c).Company_Number__c : null;
        }
    }

    /* When creating an estimate exclusively from an RO reference, the Account and Vehicle will populate */
    public static void setAccountVehicleByROReference(List<Service_Estimate__c> estimateList) {

        // Document relationshipds
        Set<Id> roIds = new Set<Id>();

        // Do we need to run this logic?
        Boolean isNecessary = false;
        for(Service_Estimate__c se : estimateList) {
            if(se.Customer__c==null && se.Service_Repair_Order__c!=null) {
                isNecessary=true;
                roIds.add(se.Service_Repair_Order__c);
            }
        }

        // If all account data is present exit
        if(!isNecessary)
            return;
        
        // Looks like we need to obtain customer data
        Map<Id, Service_Repair_Order__c> sro = new Map<Id, Service_Repair_Order__c>(
            [SELECT Id, Customer__c, Vehicle__c FROM Service_Repair_Order__c WHERE Id IN:roIds]
        );

        // Apply matched items
        for(Service_Estimate__c se : estimateList) {
            if(se.Service_Repair_Order__c!=null) {

                // Map the customer record
                if(se.Customer__c==null && sro.get(se.Service_Repair_Order__c)!=null && sro.get(se.Service_Repair_Order__c).Customer__c!=null) {
                    se.Customer__c=sro.get(se.Service_Repair_Order__c).Customer__c;
                }

                // Force Map the Vehicle Record
                if(sro.get(se.Service_Repair_Order__c)!=null && sro.get(se.Service_Repair_Order__c).Vehicle__c!=null) {
                    se.Service_Vehicle__c=sro.get(se.Service_Repair_Order__c).Vehicle__c;  //This is forced to match the RO
                }
            }
        }
    }

    public static void beforeUpdate(List<dealer__Service_Estimate__c> ServiceEstimateList, Map<Id, dealer__Service_Estimate__c> ServiceEstimateOldMap){
        Set<Id> serviceEstIds = new Set<Id>();
        List<dealer__Service_Estimate__c> serviceEstimates = new List<dealer__Service_Estimate__c>();
        List<dealer__Service_Job__c> servRepOrderLines = new List<dealer__Service_Job__c>();
        List<dealer__Service_Repair_Order__c> servRepOrdersToInsert = new List<dealer__Service_Repair_Order__c>();    
        List<dealer__Service_Job__c> servRepOrderLinesToInsert = new List<dealer__Service_Job__c>();
        Map<dealer__Service_Repair_Order__c, List<dealer__Service_Job__c>> servRepOrderToLines = new Map<dealer__Service_Repair_Order__c, List<dealer__Service_Job__c>>();
    
        for(dealer__Service_Estimate__c objServiceEstimate : ServiceEstimateList){
            if(objServiceEstimate.dealer__Status__c == 'Finalized' && objServiceEstimate.dealer__Status__c != ServiceEstimateOldMap.get(objServiceEstimate.Id).dealer__Status__c){
                serviceEstIds.add(objServiceEstimate.Id);
            }
        }
        
        // List of dealer__Service_Estimate__c with dealer__Service_Estimate_Line__c
        serviceEstimates = [Select Id, Name, dealer__Service_Vehicle__c, dealer__Customer__c, dealer__Service_Advisor__c, 
                            dealer__Customer_Contact__c, dealer__Company_Number__c, dealer__Appraisal_VIN__c, dealer__Company__c, 
                            dealer__Estimate_Total__c, dealer__Current_Mileage__c, dealer__Inventory_Vehicle__c, 
                            (Select Id, Name, dealer__Book_Time__c, dealer__Sub_Total__c, dealer__Labor_Operation__c FROM Service_Estimate_Lines__r) 
                            From dealer__Service_Estimate__c WHERE Id IN : serviceEstIds AND dealer__Service_Repair_Order__c = null];    

        for(dealer__Service_Estimate__c serviceEst : serviceEstimates){
            dealer__Service_Repair_Order__c servRepOrder = new dealer__Service_Repair_Order__c();           
            servRepOrder.dealer__Customer__c = serviceEst.dealer__Customer__c;
            servRepOrder.dealer__Service_Advisor__c = serviceEst.dealer__Service_Advisor__c;
            servRepOrder.dealer__Customer_Contact__c = serviceEst.dealer__Customer_Contact__c;
            servRepOrder.dealer__Company_Number__c = serviceEst.dealer__Company_Number__c;
            servRepOrder.dealer__RO_Number__c = serviceEst.Id;
            servRepOrder.dealer__Vehicle__c = serviceEst.dealer__Service_Vehicle__c;
            servRepOrder.dealer__VIN__c = serviceEst.dealer__Appraisal_VIN__c;
            servRepOrder.dealer__Company__c = serviceEst.dealer__Company__c;
            servRepOrder.dealer__Estimate__c = serviceEst.dealer__Estimate_Total__c;
            servRepOrder.dealer__Mileage_In__c = serviceEst.dealer__Current_Mileage__c;
            servRepOrder.dealer__Vehicle_Inventory__c = serviceEst.dealer__Inventory_Vehicle__c;
            
            for(dealer__Service_Estimate_Line__c servEstLine : serviceEst.Service_Estimate_Lines__r){
                dealer__Service_Job__c servRepOrderLine = new dealer__Service_Job__c();             
                servRepOrderLine.dealer__Book_Time__c = servEstLine.dealer__Book_Time__c;
                servRepOrderLine.dealer__Estimate__c = servEstLine.dealer__Sub_Total__c;
                servRepOrderLine.dealer__Standard_Operation_Code__c = servEstLine.dealer__Labor_Operation__c;
                servRepOrderLines.add(servRepOrderLine);
            }
            servRepOrderToLines.put(servRepOrder, servRepOrderLines);   
        }
        
        servRepOrdersToInsert.addAll(servRepOrderToLines.keyset());
        
        //Insert dealer__Service_Repair_Order__c records
        if(servRepOrdersToInsert.size() > 0){
            insert servRepOrdersToInsert;
        }
        
        //Linking dealer__Service_Job__c to dealer__Service_Repair_Order__c
        for(dealer__Service_Repair_Order__c servRepOrder : servRepOrderToLines.keyset()){
            for(List<dealer__Service_Job__c> lines : servRepOrderToLines.values()){
                for(dealer__Service_Job__c line : lines){
                    line.dealer__Service_Repair_Order__c = servRepOrder.Id;
                    servRepOrderLinesToInsert.add(line);
                }
            }
        }
        // Insert dealer__Service_Job__c records
        if(servRepOrderLinesToInsert.size() > 0 ){
            insert servRepOrderLinesToInsert;   
        }

        // Linking Ro on Service Estimate 
        for(dealer__Service_Estimate__c s : ServiceEstimateList) {
            for(dealer__Service_Repair_Order__c servRepOrder : servRepOrderToLines.keySet()){
                if(s.dealer__Service_Vehicle__c == servRepOrder.dealer__Vehicle__c ){
                    s.dealer__Service_Repair_Order__c = servRepOrder.Id;
                }
            }
        }
    }

    public static void ServiceVehicleForServiceEstimate(List<dealer__Service_Estimate__c> ServiceEstimateList){
        
        Set<Id> vehicleIds = new Set<Id>();
        Map<String, dealer__Service_Vehicle__c> ServiceVehicleMap = new Map<String, dealer__Service_Vehicle__c>();
        User objUser = null;

        for(dealer__Service_Estimate__c objServiceEstimate : ServiceEstimateList){
            if(objServiceEstimate.dealer__Inventory_Vehicle__c != null && objServiceEstimate.dealer__Service_Vehicle__c == null){
                vehicleIds.add(objServiceEstimate.dealer__Inventory_Vehicle__c);
            }           
        }

        Map<Id, dealer__Vehicle_Inventory__c> vehicle_inventory = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Name, VIN__c FROM Vehicle_Inventory__c where Id IN:vehicleIds]);
        
        System.debug(vehicle_inventory.keySet());

        for(Service_Vehicle__c objServiceVehicle : [SELECT Id, VIN__c FROM Service_Vehicle__c WHERE Sales_Inventory__c IN : vehicle_inventory.keySet()]){
            ServiceVehicleMap.put(objServiceVehicle.VIN__c, objServiceVehicle);
        }      

        for(dealer__Service_Estimate__c objServiceEstimate : ServiceEstimateList){
            if(objServiceEstimate.dealer__Inventory_Vehicle__c != null 
                    && objServiceEstimate.dealer__Service_Vehicle__c == null 
                    && ServiceVehicleMap.get(vehicle_inventory.get(objServiceEstimate.dealer__Inventory_Vehicle__c).VIN__c) != null){

                        objServiceEstimate.dealer__Service_Vehicle__c = ServiceVehicleMap.get(vehicle_inventory.get(objServiceEstimate.dealer__Inventory_Vehicle__c).VIN__c).Id;
            }   

            // If the Company has not been set on the Service Estimate
            if(objServiceEstimate.Company_Number__c == null) {

                // If our Object User is Null, only set once
                if(objUser==null) {
                    objUser = [Select Id, Division from User where Id =: UserInfo.getUserId()];
                }

                if(objUser.Division != null && objUser.Division != ''){
                    objServiceEstimate.dealer__Company_Number__c = objUser.Division;
                }
            }
        }
    }
    // W-001780 Begins
    // Forces total tax on Service Estimate to be recalculated if Taxable flag is changed by firing triggers that calculate Service Estimate Line Tax
    public static void updateTaxableCalculation(List<dealer__Service_Estimate__c> SEList, Map<Id,dealer__Service_Estimate__c> ServiceEstimateOldMap){
        
        Set<Id> SEIds = new Set<Id>();
        
        for(dealer__Service_Estimate__c se : SEList){
            SEIds.add(se.Id);
        }
        List<dealer__Service_Estimate_Line__c> SELines = [SELECT Id, dealer__Service_Estimate__c, dealer__Tax__c, dealer__Parts__c, dealer__Labor__c 
                                                          FROM dealer__Service_Estimate_Line__c WHERE dealer__Service_Estimate__c In :SEIds];
        system.debug('=======Related Service Estimate Lines' + SELines);
        updateServiceLineTax(SELines);
    }
    
    public static void updateServiceLineTax(List <dealer__Service_Estimate_Line__c> ListServiceEstimateLine){

        system.debug('-------------> updateServiceLineTax');

        Set<Id> SEIds = new Set<Id>();
        for(dealer__Service_Estimate_Line__c SELine : ListServiceEstimateLine){
            SEIds.add(SELine.dealer__Service_Estimate__c);
        }
        Map<Id,Boolean> taxableMap = new Map<Id,Boolean>();
        Map<Id,Boolean> taxPartsMap = new Map<Id,Boolean>();
        Map<Id,Boolean> taxServiceMap = new Map<Id,Boolean>(); 
        Map<Id,Decimal> taxRateMap = new Map<Id,Decimal>(); 

        Map<Id,dealer__Service_Estimate__c> SEMap = new Map<Id,dealer__Service_Estimate__c>();
        
        if(SEIds.size()>0){
            for(dealer__Service_Estimate__c se:[SELECT Id, dealer__Taxable__c, dealer__Store_Location__c, dealer__Tax_Exempt__c, dealer__Store_Location__r.dealer__Tax_Service__c, dealer__Store_Location__r.dealer__Tax_Parts__c, dealer__Store_Location__r.dealer__Tax_Local_Rate__c 
                                                FROM dealer__Service_Estimate__c WHERE Id IN :SEIds]){
                
                taxableMap.put(se.Id, se.dealer__Tax_Exempt__c);
                if(se.dealer__Store_Location__c != null){
                    taxPartsMap.put(se.Id, se.dealer__Store_Location__r.dealer__Tax_Parts__c);
                    taxServiceMap.put(se.Id, se.dealer__Store_Location__r.dealer__Tax_Service__c);
                	taxRateMap.put(se.Id, se.dealer__Store_Location__r.dealer__Tax_Local_Rate__c);
                }
                
                system.debug('taxable status=======' + se);
            }
        }
        
        List<dealer__Service_Estimate_Line__c> LinesToUpdate = new List<dealer__Service_Estimate_Line__c>();
        for(dealer__Service_Estimate_Line__c  objServiceLine : ListServiceEstimateLine) {
            
            Boolean taxExempt = taxableMap.get(objServiceLine.dealer__Service_Estimate__c);
            Boolean taxParts = taxPartsMap.containsKey(objServiceLine.dealer__Service_Estimate__c) ? taxPartsMap.get(objServiceLine.dealer__Service_Estimate__c) : false;
            Boolean taxService = taxServiceMap.containsKey(objServiceLine.dealer__Service_Estimate__c) ? taxServiceMap.get(objServiceLine.dealer__Service_Estimate__c) : false;
            Decimal taxRate = taxRateMap.containsKey(objServiceLine.dealer__Service_Estimate__c) ? taxRateMap.get(objServiceLine.dealer__Service_Estimate__c) : 0;
			system.debug('--------> taxExempt ' + taxExempt + ' taxParts ' + taxParts + ' taxService ' + taxService + ' taxRate ' + taxRate);
            
            if(!taxExempt && taxRate != null && taxRate != 0 ){
                if(taxParts && taxService && objServiceLine.dealer__Parts__c != null && objServiceLine.dealer__Labor__c != null){
                    objServiceLine.dealer__Tax__c = (objServiceLine.dealer__Parts__c * (taxRate / 100)) + (objServiceLine.dealer__Labor__c * (taxRate / 100));
                } 
                else if(taxParts && objServiceLine.dealer__Parts__c != null){
                    objServiceLine.dealer__Tax__c = objServiceLine.dealer__Parts__c * (taxRate / 100);
                }
                else if(taxService && objServiceLine.dealer__Labor__c != null){
                    objServiceLine.dealer__Tax__c = objServiceLine.dealer__Labor__c * (taxRate / 100);
                }
                system.debug('service estimate found to be taxable');
                LinesToUpdate.add(objServiceLine);
            }
            if(taxExempt){
                objServiceLine.dealer__Tax__c = (0);
                system.debug('service estimate found to be NOT taxable');
                LinesToUpdate.add(objServiceLine);
            }
        }
        try{
            system.debug('------> LinesToUpdate ' + LinesToUpdate);
            update LinesToUpdate;
        }
        catch(DmlException e){
            system.debug('DMLexception trying to update service estimate lines======' +e);
        }
    }

    public static void updateAppraisal(List<Service_Estimate__c> triggerNew){
        Map<Id,Id> appMap = new Map<Id, Id>();
        for(Service_Estimate__c se : triggerNew){
            if(se.Appraisal__c != null){
                appMap.put(se.Appraisal__c, se.Id);
            }
        }
        if(appMap.size() > 0){
            List<Appraisal__c> updateList = new List<Appraisal__c>();
            List<Appraisal__c> appList = [SELECT Id, Service_Estimate__c FROM Appraisal__c WHERE Id IN:appMap.keyset()];
            for(Appraisal__c app : appList){
                if(app.Service_Estimate__c == null){
                    app.Service_Estimate__c = appMap.get(app.Id);
                    updateList.add(app);
                }
            }
            if(updateList.size() > 0){
                update updateList;
            }
        }
    }   

    public static void updateAppraisal(List<Service_Estimate__c> triggerNew, Map<Id, Service_Estimate__c> triggerOldMap){
        Map<Id,Id> appMap = new Map<Id, Id>();
        for(Service_Estimate__c se : triggerNew){
            if(se.Appraisal__c != null && triggerOldMap.get(se.Id).Appraisal__c != se.Appraisal__c){
                appMap.put(se.Appraisal__c, se.Id);
            }
        }
        if(appMap.size() > 0){
            List<Appraisal__c> updateList = new List<Appraisal__c>();
            List<Appraisal__c> appList = [SELECT Id, Service_Estimate__c FROM Appraisal__c WHERE Id IN:appMap.keyset()];
            for(Appraisal__c app : appList){
                if(app.Service_Estimate__c == null){
                    app.Service_Estimate__c = appMap.get(app.Id);
                    updateList.add(app);
                }
            }
            if(updateList.size() > 0){
                update updateList;
            }
        }
    }  
}