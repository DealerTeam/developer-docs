public with sharing class ServiceEstimateWorksheet_EXT {
	public Service_Estimate__c est {get;set;}
	public Dealer_Location__c location {get; set;}

	public ServiceEstimateWorksheet_EXT(ApexPages.standardController sc) {



		// Collect All Managed Fields
        Map<String, Schema.SObjectField> M = Schema.SObjectType.Service_Estimate__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
		af.add('Service_Repair_Order__r.Name'); 
        if(!Test.isRunningTest()) {       
            sc.addFields(af);
        }		

		est = (Service_Estimate__c)sc.getRecord();

	if(est.Id!=null && est.Store_Location__c!=null){
		location = [SELECT Id, Name, Customer_Pay_Labor_Rate__c, LaborCost__c, Warranty_Labor_Rate__c, Internal_Labor_Rate__c FROM Dealer_Location__c WHERE Id=:est.Store_Location__c LIMIT 1];
        system.debug(location.Customer_Pay_Labor_Rate__c);

        }
	}	
	 public String getDealerLocation() {
        return JSON.serialize(location);
    }

	// PageReference
	public Service_Estimate_Line__c reloadDetail() {
		est = [SELECT Appraisal_VIN__c, Appraisal__c, Body_Type__c, Both_Keys_Fobs__c, 
				Buy_Price__c, Comapny_Number__c, Company_Number__c,Company__c, 
				Cosmetic_Notes__c, Current_MMR__c, Current_Mileage__c, Customer_Contact__c, 
				Customer__c, Days__c, Desired_Profit__c, Detail__c, Discount_Rate__c, 
				Discount__c, EmailApprover__c, Estiamted_Profit__c, Estimate_Notes__c, 
				Estimate_Total__c, Estimated_Pack__c, Finalized_By__c, Finish_Date__c, 
				Inventory_Vehicle_VIN__c, Inventory_Vehicle__c, Navigation_Disc_SD_Installed__c, 
				Owners_Manual__c, Parts_Sublet_Total__c, Safety__c, Service_Advisor__c, 
				Service_Repair_Order__c, Service_Vehicle__c, Smog__c, Status__c, 
				Store_Location__c, Suggested_Retail_Price__c, Taxable__c, 
				Transport_Damage_Description__c, Transport_Damage__c, VIN_Verified__c, 
				Cosmetic_Total__c, Labor_to_Discount__c, Parts_to_Discount__c, 
				Total_Labor_Charges__c, Total_Parts_Charges__c, Total_Sublet_Charges__c, 
				Total_Tax__c, Total_Misc_Charges__c, Name, Id 
				FROM Service_Estimate__c 
				WHERE Id=:est.Id 
				LIMIT 1];
		return null;
	}

	/* Remotes */
	@remoteAction
	public static List<StandardOpCode__c> operationCodes() {
		return ServiceAPI.standardOperationCodes();
	}

	@remoteAction
	public static Service_Estimate_Line__c createEstimateLine(String jLine) {

		// Cast the sender into an estimate line
		Service_Estimate_Line__c line = new Service_Estimate_Line__c();

		try {
			line = (Service_Estimate_Line__c)JSON.deserialize(jLine, Service_Estimate_Line__c.class);
			line = ServiceEstimateAPI.createEstimateLine(line);
     
            //createSubLine when SOC is set
            if(line.Labor_Operation__r.dealer__Book_Time__c != null && line.Labor_Operation__r.dealer__Labor_Rate__c != null) {
          
            	Service_Estimate_SubLine__c subline = new Service_Estimate_SubLine__c();
            	subline.dealer__Line_Type__c = 'Labor';
            	subline.dealer__Service_Estimate_Line__c = line.Id;
                subline.dealer__Labor_Rate__c = line.Labor_Operation__r.dealer__Labor_Rate__c;
                subline.dealer__Book_Time__c = line.Labor_Operation__r.dealer__Book_Time__c;
    
              try {
                  insert subline;
              }catch(Exception ex){
                  system.debug(ex.getMessage());
              }
            }
            
		} Catch(JSONException e) {
			System.debug(e.getMessage());
		} Catch(Exception e) {
			System.debug(e.getMessage());
		}

		return line;
	}

	@remoteAction
	public static Service_Estimate_Line__c updateEstimateLine(String line) {
		return ServiceEstimateAPI.updateEstimateLine((Service_Estimate_Line__c)JSON.deserialize(line, Service_Estimate_Line__c.class));
	}

	@remoteAction
	public static Boolean deleteEstimateLine(String lineId) {
		return ServiceEstimateAPI.deleteEstimateLine(lineId);
	}

	@remoteAction
	public static Service_Estimate_SubLine__c createSubLine(String subLine) {
		return ServiceEstimateAPI.createSubLine((Service_Estimate_SubLine__c)JSON.deserialize(subLine, Service_Estimate_SubLine__c.class));
	}

	@remoteAction
	public static List<Service_Estimate_SubLine__c> readSubLines(String lineRequest) {
		try {
			String[] lineRequestParts = lineRequest.split('~');
			System.debug(lineRequestParts.size());
			if(lineRequestParts.size()!=2) {
				return null;
			}

			System.debug(lineRequestParts);
			System.debug(lineRequestParts.size());
			System.assert(lineRequestParts.size()==2);
			return ServiceEstimateAPI.readSubLines(lineRequestParts[0], lineRequestParts[1]);
		} Catch(Exception e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}
	}

	@remoteAction
	public static Service_Estimate_SubLine__c updateSubLine(String lineRequest) {
		try {
			return ServiceEstimateAPI.updateSubLine((Service_Estimate_SubLine__c)JSON.deserialize(lineRequest, Service_Estimate_SubLine__c.class));
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}
		return null;
	}

	@remoteAction
	public static void deleteSubLine(String subLineId) {
		try {
			ServiceEstimateAPI.deleteSubLine((Id)subLineId);
		} Catch(Exception e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}
	}
 
	@remoteAction
	public static List<Service_Estimate_Line__c> estimateLines(String estimateId) {
		return ServiceEstimateAPI.estimateLines(estimateId);
	}

	@remoteAction
	public static Id convertToRepairOrder(Id estimateId) {
		Service_Estimate__c se = [SELECT Id, Name FROM Service_Estimate__c WHERE Id=:estimateId LIMIT 1];
		try {
			Service_Repair_Order__c ro = ServiceRepairOrderAPI.createRepairOrderFromEstimate(se);
			return ro.Id;
		} Catch(Exception e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		return null;
	}

	@remoteAction
	public static Decimal matrix(String pl) {
		String[] p = pl.split('~');
		System.assert(p.size()==2, 'Matrix call expects two parameters.');
		Parts_Master__c pm = [SELECT Id, Cost__c, Retail_Price__c FROM Parts_Master__c WHERE Id=:p[1]];
		return PartAPI.matrix(p[0], pm);
	}

	@remoteAction
	public static Id appendToRepairOrder(Id estimateId) {
		throw new ServiceEstimateAPIException('Test Message from the Controller');
		return null;
	}

	/* Getters */
	@remoteAction
	public static List<MiscChargeCode__c> miscChargeCodes(String locationId) {
		return ServiceEstimateAPI.miscChargeCodes(locationId);
	}

	public class ServiceEstimateAPIException extends Exception {}
}