/**
 * ClaimControlHandler
 * @description Claim Control Handler - Service Layer Application Class
 */
public class ClaimControlHandler
{
	/**
     * preflight 
     * @param  subLines 
     * @return void
     * @description Pre-clear values that are going to be saved to the object
     */ 
    public void preflight(List<ClaimSubItem__c> subLines) 
    {
        Set<Id> ciIds = new Set<Id>();
        Set<Id> pmIds = new Set<Id>();
		for(ClaimSubItem__c ses : subLines) {
            if(!ciIds.contains(ses.ClaimItem__c)){
                ciIds.add(ses.ClaimItem__c);
            }
            if(!pmIds.contains(ses.PartsMaster__c)){
                pmIds.add(ses.PartsMaster__c);
            }
        }
        Map<Id, ClaimItem__c> ciMap = new Map<Id, ClaimItem__c>([SELECT Id, LaborType__c FROM ClaimItem__c WHERE Id IN: ciIds]);
        Map<Id, Parts_Master__c> pmMap = new Map<Id, Parts_Master__c>([SELECT Id, Warranty_Price__c FROM Parts_Master__c WHERE Id IN: pmIds]);
        for(ClaimSubItem__c ses : subLines) {
			// If we are storing Labor Values than the Type must be Labor
			if(ses.LineType__c != 'Labor' &&
				(
					(
						ses.LaborRate__c != null && ses.LaborRate__c > 0
						|| ses.BookTime__c != null && ses.BookTime__c > 0
					)
				)
			 ) {
					ses.addError('Line Type must be Labor to store labor values, please append your object to labor type if you are attempting to store labor values.');
			}
            // Use warranty price from parts master if available
            if(ses.LineType__c == 'Parts' && ciMap.get(ses.ClaimItem__c) != null && pmMap.get(ses.PartsMaster__c) != null){
                if(ciMap.get(ses.ClaimItem__c).LaborType__c == 'W' && pmMap.get(ses.PartsMaster__c).Warranty_Price__c > 0){
                    ses.PartPrice__c = pmMap.get(ses.PartsMaster__c).Warranty_Price__c;
                }
            }
		}
	}

	/**
     * handleRollUp 
     * @param  subLines       
     * @param  beforeSubLines 
     * @return void
     * @description Total Values for the parent line
     */
    public void handleRollUp(List<ClaimSubItem__c> subLines, List<ClaimSubItem__c> beforeSubLines) 
    {
		
		// prepare affected Ids'
		Set<Id> estimateLines = new Set<Id>();
		for(ClaimSubItem__c sl : subLines) {
			if(!estimateLines.contains(sl.ClaimItem__c)) {
				estimateLines.add(sl.ClaimItem__c);
			}
		}

		if(!estimateLines.isEmpty()) {
			performRollUp(estimateLines);
		}
	}

    /**
     * handleRollUp 
     * @param  seLines 
     * @return void
     * @description
     */
	public void handleRollUp(List<ClaimItem__c> seLines) 
    {
		Set<Id> seLineIds = new Set<Id>();
		for(ClaimItem__c sel : seLines) {
			seLineIds.add(sel.Id);
		}
		performRollUp(seLineIds);
	}

    /**
     * performRollUp 
     * @param  estimateLineIds 
     * @return void
     * @description
     */ 
	private void performRollUp(Set<Id> estimateLineIds) 
    {

		// Retreive the affected lines and their Labor/Parts Totals
		Map<Id, ClaimItem__c> eLine = new Map<Id, ClaimItem__c>();
		AggregateResult[] ar = [SELECT dealer__ClaimItem__c, 
										SUM(TotalPartPrice__c) partsTotal, 
										SUM(LaborTotal__c) laborTotal,
										SUM(MiscChargeAmount__c) miscTotal 
									FROM ClaimSubItem__c
									WHERE ClaimItem__c IN:estimateLineIds
									GROUP BY ClaimItem__c];

		// It is possible that no results are returned.  In this case let's specify an empty object map based on line Id
		for(Id idvalue : estimateLineIds) {
			eLine.put(idvalue, 
						new ClaimItem__c(
							Id=idvalue, 
							Labor__c=0,
							Parts__c=0,
							MiscCharges__c=0
						)
			);			
		}

		// Exit method if we are not processing any values
		// To-Do
		
		// Allign values into a Map for comparison
		for(AggregateResult arv : ar) {

			// Sanity Check
			if(arv.get('dealer__ClaimItem__c')==null){
				throw new ClaimControlHandlerException('Aggregate Result does not contain the required key of ClaimItem__c');
			}

			eLine.put((Id)arv.get('dealer__ClaimItem__c'), 
						new ClaimItem__c(
							Id=(Id)arv.get('dealer__ClaimItem__c'), 
							Labor__c=(Decimal)arv.get('laborTotal'),
							Parts__c=(Decimal)arv.get('partsTotal'),
							MiscCharges__c=(Decimal)arv.get('miscTotal')
						)
			);
		}

		// If we have values to process being their processing
		if(!eLine.isEmpty()) {
			try {
				System.debug(eLine);
				update eLine.values();
			} Catch(DmlException e) {
				throw new ClaimControlHandlerException(e.getMessage());
			}
		}		
	}
	
	/**
     * preventEdit 
     * @param  seLines 
     * @return void
     * @description Prevent Converted Estimates from being Edited
     */ 
    public void preventEdit(List<ClaimItem__c> seLines) 
    {
		Set<Id> headerIds = new Set<Id>();
		for(ClaimItem__c sel : seLines) {
			headerIds.add(sel.Claim__c);
		}

		// Deprecating this method of validation.  
		for(Claim__c se : [SELECT Id, Status__c, ServiceRepairOrder__c FROM Claim__c WHERE Id IN:headerIds]) {
			if(se.Status__c=='Accepted')
				throw new ClaimControlHandlerException('Update Failed: Accepted Claims with Repair Orders may not be edited.');
		}
	}

    /**
     * BeforeHandlerforCalcultingTax 
     * @return void
     * @description
     */ 
    public void BeforeHandlerforCalcultingTax(List <dealer__ClaimItem__c> ListServiceEstimateLine)
    {

        dealer__TaxSettings__c taxDefaults = new dealer__TaxSettings__c();

        if(dealer__TaxSettings__c.getValues('ActiveSettings')!=null) {
            taxDefaults = dealer__TaxSettings__c.getValues('ActiveSettings');   
        }
        //W-001780 Begins
        if(taxDefaults.dealer__State_Tax_Rate__c != null) {
            Set<Id> SEIds = new Set<Id>();
            for(dealer__ClaimItem__c SELine : ListServiceEstimateLine){
                SEIds.add(SELine.dealer__Claim__c);
            }
            Map<Id,Boolean> taxableMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxPartsMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxServiceMap = new Map<Id,Boolean>(); 
            Map<Id,dealer__Claim__c> SEMap = new Map<Id,dealer__Claim__c>();

            if(SEIds.size()>0){
                for(dealer__Claim__c se:[SELECT Id, dealer__Taxable__c, dealer__StoreLocation__r.dealer__Tax_Service__c, dealer__StoreLocation__r.dealer__Tax_Parts__c FROM dealer__Claim__c WHERE Id IN :SEIds]){
            
                    taxableMap.put(se.Id, se.dealer__Taxable__c);
                    taxPartsMap.put(se.Id, se.dealer__StoreLocation__r.dealer__Tax_Parts__c);
                    taxServiceMap.put(se.Id, se.dealer__StoreLocation__r.dealer__Tax_Service__c);
                }
            }
            for(dealer__ClaimItem__c  objServiceLine : ListServiceEstimateLine) {
                    Boolean taxable = taxableMap.get(objServiceLine.dealer__Claim__c);
                    Boolean taxParts = taxPartsMap.get(objServiceLine.dealer__Claim__c);
                    Boolean taxService = taxServiceMap.get(objServiceLine.dealer__Claim__c);
                    if(taxable == true){
                        if(taxParts == true && taxService == true){
                            objServiceLine.dealer__Tax__c = (objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100)) + (objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100));
                        } 
                        else if(taxParts == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        else if(taxService == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        system.debug('Claim found to be taxable');

                    }
                    if(taxable == false){
                        objServiceLine.dealer__Tax__c = (0);
                        system.debug('Claim found to be NOT taxable');

                    }
                    system.debug(objServiceLine);
            }
            //W-001780 Ends
        }
    }
    
    /**
     * setLocation 
     * @param  estimateList 
     * @return void
     * @description
     */ 
    public static void setLocation(List<Claim__c> estimateList) 
    {
        Id userLocation = null;  
        for(Claim__c c : estimateList) {
            if(c.StoreLocation__c==null) {
                if(userLocation==null) {
                    userLocation = Utility.lookupUserLocation(); //This will only fire one time.
                }
                c.StoreLocation__c=userLocation;
            }
        }        
    }

    /**
     * setCompanyNumber 
     * @param  estimateList 
     * @return void
     * @description
     */ 
    public static void setCompanyNumber(List<Claim__c> estimateList)
    {
        set<Id> locationIds = new set<Id>();
        for(Claim__c se : estimateList){
            locationIds.add(se.StoreLocation__c);
        }
        map<Id, dealer__Dealer_Location__c> locationMap = new Map<Id, dealer__Dealer_Location__c>([Select Id, Company_Number__c, Name from Dealer_Location__c where Id IN: locationIds]);

        for(Claim__c se: estimateList){
            se.CompanyNumber__c = (locationMap.get(se.StoreLocation__c)!=null) ? locationMap.get(se.StoreLocation__c).Company_Number__c : null;
        }
    }

    /**
     * setAccountVehicleByROReference 
     * @param  estimateList 
     * @return void
     * @description When creating an estimate exclusively from an RO reference, the Account and Vehicle will populate
     */
    public static void setAccountVehicleByROReference(List<Claim__c> estimateList) 
    {

        // Document relationshipds
        Set<Id> roIds = new Set<Id>();

        // Do we need to run this logic?
        Boolean isNecessary = false;
        for(Claim__c se : estimateList) {
            if(se.Customer__c==null && se.ServiceRepairOrder__c!=null) {
                isNecessary=true;
                roIds.add(se.ServiceRepairOrder__c);
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
        for(Claim__c se : estimateList) {
            if(se.ServiceRepairOrder__c!=null) {

                // Map the customer record
                if(se.Customer__c==null && sro.get(se.ServiceRepairOrder__c)!=null && sro.get(se.ServiceRepairOrder__c).Customer__c!=null) {
                    se.Customer__c=sro.get(se.ServiceRepairOrder__c).Customer__c;
                }

                // Force Map the Vehicle Record
                if(sro.get(se.ServiceRepairOrder__c)!=null && sro.get(se.ServiceRepairOrder__c).Vehicle__c!=null) {
                    se.ServiceVehicle__c=sro.get(se.ServiceRepairOrder__c).Vehicle__c;  //This is forced to match the RO
                }
            }
        }
    }

    // This logic will be moved to service layer
    // public static void beforeUpdate(List<Claim__c> ServiceEstimateList, Map<Id, Claim__c> ServiceEstimateOldMap)
    // {
    //     Set<Id> serviceEstIds = new Set<Id>();
    //     List<Claim__c> serviceEstimates = new List<Claim__c>();
    //     List<dealer__Service_Job__c> servRepOrderLines = new List<dealer__Service_Job__c>();
    //     List<dealer__Service_Repair_Order__c> servRepOrdersToInsert = new List<dealer__Service_Repair_Order__c>();    
    //     List<dealer__Service_Job__c> servRepOrderLinesToInsert = new List<dealer__Service_Job__c>();
    //     Map<dealer__Service_Repair_Order__c, List<dealer__Service_Job__c>> servRepOrderToLines = new Map<dealer__Service_Repair_Order__c, List<dealer__Service_Job__c>>();
    
    //     for(dealer__Claim__c objServiceEstimate : ServiceEstimateList){
    //         if(objServiceEstimate.dealer__Status__c == 'Finalized' && objServiceEstimate.dealer__Status__c != ServiceEstimateOldMap.get(objServiceEstimate.Id).dealer__Status__c){
    //             serviceEstIds.add(objServiceEstimate.Id);
    //         }
    //     }
        
    //     // List of dealer__Claim__c with dealer__ClaimItem__c
    //     serviceEstimates = [Select Id, Name, dealer__ServiceVehicle__c, dealer__Customer__c, dealer__ServiceAdvisor__c, 
    //                         dealer__CustomerContact__c, dealer__CompanyNumber__c, dealer__AppraisalVIN__c, dealer__StoreLocation__c, 
    //                         dealer__EstimateTotal__c, dealer__CurrentMileage__c, dealer__InventoryVehicle__c, 
    //                         (Select Id, Name, dealer__BookTime__c, dealer__SubTotal__c, dealer__LaborOperation__c FROM Claims__r) 
    //                         From dealer__Claim__c WHERE Id IN : serviceEstIds AND dealer__ServiceRepairOrder__c = null];    

    //     for(dealer__Claim__c serviceEst : serviceEstimates){
    //         dealer__Service_Repair_Order__c servRepOrder = new dealer__Service_Repair_Order__c();           
    //         servRepOrder.dealer__Customer__c = serviceEst.dealer__Customer__c;
    //         servRepOrder.dealer__Service_Advisor__c = serviceEst.dealer__ServiceAdvisor__c;
    //         servRepOrder.dealer__Customer_Contact__c = serviceEst.dealer__CustomerContact__c;
    //         servRepOrder.dealer__Company_Number__c = serviceEst.dealer__CompanyNumber__c;
    //         servRepOrder.dealer__RO_Number__c = serviceEst.Id;
    //         servRepOrder.dealer__Vehicle__c = serviceEst.dealer__ServiceVehicle__c;
    //         servRepOrder.dealer__VIN__c = serviceEst.dealer__AppraisalVIN__c;
    //         servRepOrder.dealer__Company__c = serviceEst.dealer__StoreLocation__c;
    //         servRepOrder.dealer__Estimate__c = serviceEst.dealer__EstimateTotal__c;
    //         servRepOrder.dealer__Mileage_In__c = serviceEst.dealer__CurrentMileage__c;
    //         servRepOrder.dealer__Vehicle_Inventory__c = serviceEst.dealer__InventoryVehicle__c;
            
    //         for(dealer__ClaimItem__c servEstLine : serviceEst.Claims__r){
    //             dealer__Service_Job__c servRepOrderLine = new dealer__Service_Job__c();             
    //             servRepOrderLine.dealer__Book_Time__c = servEstLine.dealer__BookTime__c;
    //             servRepOrderLine.dealer__Estimate__c = servEstLine.dealer__SubTotal__c;
    //             servRepOrderLine.dealer__Standard_Operation_Code__c = servEstLine.dealer__LaborOperation__c;
    //             servRepOrderLines.add(servRepOrderLine);
    //         }
    //         servRepOrderToLines.put(servRepOrder, servRepOrderLines);   
    //     }
        
    //     servRepOrdersToInsert.addAll(servRepOrderToLines.keyset());
        
    //     //Insert dealer__Service_Repair_Order__c records
    //     if(servRepOrdersToInsert.size() > 0){
    //         insert servRepOrdersToInsert;
    //     }
        
    //     //Linking dealer__Service_Job__c to dealer__Service_Repair_Order__c
    //     for(dealer__Service_Repair_Order__c servRepOrder : servRepOrderToLines.keyset()){
    //         for(List<dealer__Service_Job__c> lines : servRepOrderToLines.values()){
    //             for(dealer__Service_Job__c line : lines){
    //                 line.dealer__Service_Repair_Order__c = servRepOrder.Id;
    //                 servRepOrderLinesToInsert.add(line);
    //             }
    //         }
    //     }
    //     // Insert dealer__Service_Job__c records
    //     if(servRepOrderLinesToInsert.size() > 0 ){
    //         insert servRepOrderLinesToInsert;   
    //     }

    //     // Linking Ro on Service Estimate 
    //     for(dealer__Claim__c s : ServiceEstimateList) {
    //         for(dealer__Service_Repair_Order__c servRepOrder : servRepOrderToLines.keySet()){
    //             if(s.dealer__ServiceVehicle__c == servRepOrder.dealer__Vehicle__c ){
    //                 s.dealer__ServiceRepairOrder__c = servRepOrder.Id;
    //             }
    //         }
    //     }
    // }

    /**
     * ServiceVehicleForServiceEstimate 
     * @param  ServiceEstimateList 
     * @return  void
     * @description
     */ 
    public static void ServiceVehicleForServiceEstimate(List<dealer__Claim__c> ServiceEstimateList)
    {
        
        Set<Id> vehicleIds = new Set<Id>();
        Map<String, dealer__Service_Vehicle__c> ServiceVehicleMap = new Map<String, dealer__Service_Vehicle__c>();
        User objUser = null;

        for(dealer__Claim__c objServiceEstimate : ServiceEstimateList){
            if(objServiceEstimate.dealer__InventoryVehicle__c != null && objServiceEstimate.dealer__ServiceVehicle__c == null){
                vehicleIds.add(objServiceEstimate.dealer__InventoryVehicle__c);
            }           
        }

        Map<Id, dealer__Vehicle_Inventory__c> vehicle_inventory = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Name, VIN__c FROM Vehicle_Inventory__c where Id IN:vehicleIds]);
        
        System.debug(vehicle_inventory.keySet());

        for(Service_Vehicle__c objServiceVehicle : [SELECT Id, VIN__c FROM Service_Vehicle__c WHERE Sales_Inventory__c IN : vehicle_inventory.keySet()]){
            ServiceVehicleMap.put(objServiceVehicle.VIN__c, objServiceVehicle);
        }      

        for(dealer__Claim__c objServiceEstimate : ServiceEstimateList){
            if(objServiceEstimate.dealer__InventoryVehicle__c != null 
                    && objServiceEstimate.dealer__ServiceVehicle__c == null 
                    && ServiceVehicleMap.get(vehicle_inventory.get(objServiceEstimate.dealer__InventoryVehicle__c).VIN__c) != null){

                        objServiceEstimate.dealer__ServiceVehicle__c = ServiceVehicleMap.get(vehicle_inventory.get(objServiceEstimate.dealer__InventoryVehicle__c).VIN__c).Id;
            }   

            // If the Company has not been set on the Service Estimate
            if(objServiceEstimate.CompanyNumber__c == null) {

                // If our Object User is Null, only set once
                if(objUser==null) {
                    objUser = [Select Id, Division from User where Id =: UserInfo.getUserId()];
                }

                if(objUser.Division != null && objUser.Division != ''){
                    objServiceEstimate.dealer__CompanyNumber__c = objUser.Division;
                }
            }
        }
    }
    
    /**
     * updateTaxableCalculation 
     * @param  SEList               
     * @param  ServiceEstimateOldMap 
     * @description W-001780 Begins. Forces total tax on Service Estimate to be recalculated if Taxable flag is changed by firing triggers that calculate Service Estimate Line Tax
     */
    public static void updateTaxableCalculation(List<dealer__Claim__c> SEList, Map<Id,dealer__Claim__c> ServiceEstimateOldMap)
    {
        Set<Id> SEIds = new Set<Id>();
        
        for(dealer__Claim__c se : SEList){
            SEIds.add(se.Id);
        }
        List<dealer__ClaimItem__c> SELines = [SELECT Id, dealer__Claim__c, dealer__Tax__c, dealer__Parts__c, dealer__Labor__c 
                                                          FROM dealer__ClaimItem__c WHERE dealer__Claim__c In :SEIds];
        updateServiceLineTax(SELines);
    }

    /**
     * updateServiceLineTax 
     * @return void
     * @description W-001780 Ends
     */ 
    public static void updateServiceLineTax(List <dealer__ClaimItem__c> ListServiceEstimateLine)
    {

        dealer__TaxSettings__c taxDefaults = new dealer__TaxSettings__c();

        if(dealer__TaxSettings__c.getValues('ActiveSettings')!=null) {
            taxDefaults = dealer__TaxSettings__c.getValues('ActiveSettings');   
        }
        system.debug('tax defaults ----> ' + taxDefaults);
        //W-001780 Begins
        if(taxDefaults.dealer__State_Tax_Rate__c != null) {
            Set<Id> SEIds = new Set<Id>();
            for(dealer__ClaimItem__c SELine : ListServiceEstimateLine){
                SEIds.add(SELine.dealer__Claim__c);
            }
            Map<Id,Boolean> taxableMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxPartsMap = new Map<Id,Boolean>();
            Map<Id,Boolean> taxServiceMap = new Map<Id,Boolean>(); 
            Map<Id,dealer__Claim__c> SEMap = new Map<Id,dealer__Claim__c>();

            if(SEIds.size()>0){
                for(dealer__Claim__c se:[SELECT Id, dealer__Taxable__c, dealer__StoreLocation__r.dealer__Tax_Service__c, dealer__StoreLocation__r.dealer__Tax_Parts__c FROM dealer__Claim__c WHERE Id IN :SEIds]){
            
                    taxableMap.put(se.Id, se.dealer__Taxable__c);
                    taxPartsMap.put(se.Id, se.dealer__StoreLocation__r.dealer__Tax_Parts__c);
                    taxServiceMap.put(se.Id, se.dealer__StoreLocation__r.dealer__Tax_Service__c);
                     system.debug('taxable status=======' + se);
                }
            }
            List<dealer__ClaimItem__c> LinesToUpdate = new List<dealer__ClaimItem__c>();
            for(dealer__ClaimItem__c  objServiceLine : ListServiceEstimateLine) {
                    Boolean taxExempt = taxableMap.get(objServiceLine.dealer__Claim__c);
                    Boolean taxParts = taxPartsMap.get(objServiceLine.dealer__Claim__c);
                    Boolean taxService = taxServiceMap.get(objServiceLine.dealer__Claim__c);
                    if(!taxExempt){
                        if(taxParts == true && taxService == true){
                            objServiceLine.dealer__Tax__c = (objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100)) + (objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100));
                        } 
                        else if(taxParts == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Parts__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        else if(taxService == true){
                            objServiceLine.dealer__Tax__c = objServiceLine.dealer__Labor__c * (taxDefaults.dealer__State_Tax_Rate__c / 100);
                        }
                        system.debug('claim found to be taxable');
                        LinesToUpdate.add(objServiceLine);
                    }
                    if(taxExempt){
                        objServiceLine.dealer__Tax__c = (0);
                        system.debug('claim found to be NOT taxable');
                        LinesToUpdate.add(objServiceLine);
                    }
            }
            try{
                update LinesToUpdate;
            }
            catch(DmlException e){
                system.debug('DMLexception trying to update Claim Items======' +e);
            }
        }
    }


    /**
     * updateSRO description
     * @param  triggerNew 
     * @return void
     * @description
     */
    public static void updateSRO(List<Claim__c> triggerNew)
    {
        
        // prepare affected Ids'
		Map<String, Claim__c> claimMap = new Map<String, Claim__c>();
        List<Service_Repair_Order__c> updateRos = new List<Service_Repair_Order__c>();
		for(Claim__c c : triggerNew) {
			if(!claimMap.keyset().contains(c.ServiceRepairOrder__c)) {
				claimMap.put(c.ServiceRepairOrder__c, c);
			}
		}

        List<Service_Repair_Order__c> roList = [SELECT Id, dealer__Claim__c FROM Service_Repair_Order__c WHERE Id IN: claimMap.keyset()];

        for(Service_Repair_Order__c ro : roList){
            if(ro.Claim__c != claimMap.get(ro.Id).Id){
                ro.Claim__c = claimMap.get(ro.Id).Id;
                updateRos.add(ro);
            }
        }
        update updateRos;
    }

    /**
     * AssignClaimNumber
     * @param  triggerNew 
     * @return void
     * @description Utility method to Assign Claim Number depending upon the custom settings
     */
    public static void AssignClaimNumber(List<Claim__c> triggerNew)
    {
        FixedOperationsSettings__c fixedSettings;
        List<FixedOperationsSettings__c> lstFixedSetting = [SELECT Id,ClaimIndex__c FROM dealer__FixedOperationsSettings__c WHERE SetupOwnerId =: UserInfo.getOrganizationId() LIMIT 1 for update];
        
        if(lstFixedSetting!=null && lstFixedSetting.size()>0){
            fixedSettings = lstFixedSetting[0];
        }
        else{
            fixedSettings = dealer__FixedOperationsSettings__c.getOrgDefaults();
        }

        if(fixedSettings != null && fixedSettings.ClaimIndex__c == null) {
            fixedSettings.ClaimIndex__c = 7000;
        }
        
        for(Claim__c claim : triggerNew){
            //increment before assigning
            fixedSettings.ClaimIndex__c += 1; 
            claim.ClaimNumber__c=String.valueOf(fixedSettings.ClaimIndex__c.setScale(0));
            // Removed "Claim#:" from  string concat  so the claim.name can just be a number instead of "Claim#7003'

            claim.Name = (claim.CompanyNumber__c!=null?claim.CompanyNumber__c+'-':'')+claim.ClaimNumber__c;
        }        
        //update the custom setting with recent Claim Number
        upsert fixedSettings;       
    }

    /**
     * ChangeClaimNumber 
     * @param  triggerNew 
     * @param  oldMap  
     * @return void
     * @description   
     */
    public static void ChangeClaimNumber(List<Claim__c> triggerNew, Map<Id, Claim__c> oldMap)
    {
        for(Claim__c claim: triggerNew){
            // Removed "Claim#:" from  string concat  so the claim.name can just be a number instead of "Claim#7003'
            if(oldMap.get(claim.id).CompanyNumber__c != claim.CompanyNumber__c || oldMap.get(claim.id).ClaimNumber__c != claim.ClaimNumber__c){
                claim.Name = (claim.CompanyNumber__c != null?claim.CompanyNumber__c+'-':'')+claim.ClaimNumber__c;
            }
        }       
    }

    /**
    * @method updateOdometer
    * @description Updates service vehicle mileage when claim is put in finalized status
    * @param  triggerNew    triggerNew description
    * @param  triggerOldMap triggerOldMap description
    */
    public static void updateOdometer(List<Claim__c> triggerNew, Map<Id, Claim__c> triggerOldMap){
        Map<Id, Claim__c> claimMap = new Map<Id, Claim__c>();
        List<Service_Vehicle__c> svList = new List<Service_Vehicle__c>();
        for(dealer__Claim__c claim : triggerNew){
            if(claim.dealer__Status__c == 'Finalized' && claim.dealer__Status__c != triggerOldMap.get(claim.Id).dealer__Status__c && claim.ServiceVehicle__c != null && claim.CurrentMileage__c > 0){
                claimMap.put(claim.Id, claim);
            }
        }

        if(claimMap.size() > 0){
            for(Claim__c claim : claimMap.values()){
                Service_Vehicle__c sv = new Service_Vehicle__c(Id = claim.ServiceVehicle__c, Last_Odometer__c = claim.CurrentMileage__c);
                svList.add(sv);
            }

            if(svList.size() > 0){
                update svList;
            }
        }
    }
    
    /**
     * setClaimItemName - This method queries the header record and number of lines to set the ClaimItem__c.Name property based on the parent record and row count. 
     * @param List<ClaimItem__c> trigger new context
     * @return void
     * @description
     */
    public static void setClaimItemName(List<ClaimItem__c> triggerNew)
    {
        
        //Map of claims with int of their row counts (existing)
		Map<Id, Claim__c> parentRecordData = new Map<Id, Claim__c>();  
        
        // Id's of parent records
		Set<Id> parentIds = new Set<Id>();
        for(ClaimItem__c ci : triggerNew) {
            parentIds.add(ci.Claim__c);
        }
        
        // Query claims and their record counts
        for(Claim__c c : [SELECT Id, Name, LineCount__c FROM Claim__c WHERE Id IN:parentIds]) {
            parentRecordData.put(c.Id, c);
        }
        
        // Specify new record name based on query results
        for(ClaimItem__c ci : triggerNew) {
            if(parentRecordData.get(ci.Claim__c)!=null) {
                Integer lineNumber = (Integer)parentRecordData.get(ci.Claim__c).LineCount__c + 1;
             	ci.Name = parentRecordData.get(ci.Claim__c).Name+'-'+String.valueOf(lineNumber);   
            }
        }
    }

    /**
     * setClaimSubItemName - This method queries the header record and number of lines to set the ClaimSubItem__c.Name property based on the parent record and row count. 
     * @param List<ClaimSubItem__c> trigger new context
     * @return
     * @description
     */
    public static void setClaimSubItemName(List<ClaimSubItem__c> triggerNew)
    {
        
        //Map of claims with int of their row counts (existing)
		Map<Id, ClaimItem__c> parentRecordData = new Map<Id, ClaimItem__c>();  
        
        // Id's of parent records
		Set<Id> parentIds = new Set<Id>();
        for(ClaimSubItem__c sub : triggerNew) {
            parentIds.add(sub.ClaimItem__c);
        }
        
        // Query claims and their record counts
        for(ClaimItem__c c : [SELECT Id, Name, (SELECT Id FROM Claim_Sub_Items__r) FROM ClaimItem__c WHERE Id IN:parentIds]) {
            parentRecordData.put(c.Id, c);
        }
        
        // Specify new record name based on query results
        for(ClaimSubItem__c sub : triggerNew) {
            if(parentRecordData.get(sub.ClaimItem__c)!=null) {
                Integer lineNumber = 1;
                for(ClaimSubItem__c csi : parentRecordData.get(sub.ClaimItem__c).Claim_Sub_Items__r){
                    lineNumber += 1;
                }
                //Integer lineNumber = (Integer)parentRecordData.get(sub.Claim__c).LineCount__c + 1;
             	sub.Name = parentRecordData.get(sub.ClaimItem__c).Name+'-'+String.valueOf(lineNumber);   
            }
        }
    }

    /**
     * ClaimControlHandlerException
     * @description
     */
	public class ClaimControlHandlerException extends Exception {}
}