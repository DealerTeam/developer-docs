/**
 * ServiceEstimateAPI - Service Controller for the public facing service estimate solutions.
 *
 */
public class ServiceEstimateAPI {

	/* create line call */
	public static Service_Estimate_Line__c createEstimateLine(Service_Estimate_Line__c line) {

		// Check to see we are not adding a line to an estimate that has a converted repair order already
		if(line.Service_Estimate__c != null) {
			try {
				Set<String> protectedCodes = Utility.protectedStatusCodes('dealer__Service_Repair_Order__c');
			 	Service_Estimate__c[] estimateOnDisk = [SELECT Id, Service_Repair_Order__c FROM Service_Estimate__c WHERE Id=:line.Service_Estimate__c AND Service_Repair_Order__r.Status__c IN:protectedCodes];
				if(!estimateOnDisk.isEmpty() && estimateOnDisk[0].Service_Repair_Order__c!=null) {
					throw new ServiceEstimateAPIException('Unable to add Estimate Line.  This estimate has already been converted to a Repair Order that is in protected status.');
				}
			} Catch(Exception e) {
				throw new ServiceEstimateAPIException(e.getMessage());
			}
		}

		try {
			line.Id=null; //Setting this value in the event it is passed in as part of the model.
			insert line;
			line = [SELECT Id, Name, Labor_Operation__c, Labor_Operation__r.Name, Labor_Operation__r.dealer__Book_Time__c, Labor_Operation__r.dealer__Labor_Rate__c, Service_Estimate__c, Description__c,
						Status__c, Labor_Type__c 
						FROM Service_Estimate_Line__c 
						WHERE Id=:line.Id 
						LIMIT 1];

		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		return line;
	} 

	/* update line call */
	public static Service_Estimate_Line__c updateEstimateLine(Service_Estimate_Line__c line) {

		// Determine if the line has any related sub lines generated aumotaically (Misc. Charges)
		// If these are present append the values
		List<Service_Estimate_SubLine__c> subLines = [SELECT Id, Name FROM Service_Estimate_SubLine__c WHERE SystemGeneratedFor__c =:line.Id];


		try {
			update line;
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		return line;
	}	

	/* delete line call */
	public static Boolean deleteEstimateLine(Id lineId) {
		try {
			Service_Estimate_Line__c line = new Service_Estimate_Line__c();
			line.Id=lineId;
			delete line;
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		return true;
	}

	/* -- Sub Lines --*/
	public static List<Service_Estimate_SubLine__c> estimateSubLines(Id lineId) {
		return [SELECT Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, Labor_Rate__c, Book_Time__c, 
						Part_Quantity__c, Part_Price__c, Total_Part_Price__c, CreatedById, CreatedDate, 
						LastModifiedById, LastModifiedDate, Name, Id 
					FROM Service_Estimate_SubLine__c
					WHERE Service_Estimate_Line__c =:lineId 
					LIMIT 200];
	}

	public static Service_Estimate_SubLine__c createSubLine(Service_Estimate_SubLine__c subLine) {

		try {
			subLine.Id=null;
			insert subLine;
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		if(subLine.Line_Type__c=='Parts' || subLine.Line_Type__c=='Labor') {
			ServiceEstimateAPI.createMiscCharges(ServiceEstimateAPI.returnSubLine(subLine.Id));
		}

		return ServiceEstimateAPI.returnSubLine(subLine.Id);
	}

	public static Service_Estimate_SubLine__c updateSubLine(Service_Estimate_SubLine__c subLine) {
		try {
			update subLine;
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		if(subLine.Line_Type__c=='Parts' || subLine.Line_Type__c=='Labor') {
			ServiceEstimateAPI.createMiscCharges(ServiceEstimateAPI.returnSubLine(subLine.Id));
		}		

		return ServiceEstimateAPI.returnSubLine(subLine.Id);		
	}

	public static void deleteSubLine(Id subLine) {

		// Delete any auto generated sub lines based on this misc. sub line
		List<Service_Estimate_SubLine__c> autoSubLines = [SELECT Id, Service_Estimate_Line__c FROM Service_Estimate_SubLine__c WHERE SystemGeneratedFor__c =:subLine]; 

		List<Service_Estimate_Line__c> estimateLinesToRollUp = new List<Service_Estimate_Line__c>();
		for(Service_Estimate_SubLine__c sesubline : autoSubLines) {
			estimateLinesToRollUp.add(new Service_Estimate_Line__c(Id=sesubline.Service_Estimate_Line__c));
		}

		try {

			delete new Service_Estimate_SubLine__c(Id=subLine);
			delete autoSubLines;

		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}
	}

	private static Service_Estimate_SubLine__c returnSubLine(Id subLineId) {

		System.debug(subLineId);

		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, 
					Labor_Rate__c, Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, Part_Description__c, 
					Part_Name__c, Part_Price_List__c, Part_Cost__c, Labor_Total__c, Labor_Type__c, Name, 
					Misc_Charge_Amount__c, Misc_Charge_Code__c, Misc_Charge_Description__c,
					Service_Estimate_Line__r.Service_Estimate__r.Store_Location__c 
					FROM Service_Estimate_SubLine__c
					WHERE Id =: subLineId
					LIMIT 1];
	}

	private static void createMiscCharges(Service_Estimate_SubLine__c subLine) {

		// Remove any existing misc charge lines.
		List<Service_Estimate_SubLine__c> existingChargeLines = [SELECT Id FROM Service_Estimate_SubLine__c WHERE Service_Estimate_Line__c =:subLine.Service_Estimate_Line__c AND SystemGeneratedFor__c =:subLine.Id];
		try {
			delete existingChargeLines;
		} Catch(DmlException e) {
			throw new ServiceEstimateAPIException(e.getMessage());
		}

		// Get associated Misc Charge Setup
		List<Service_Estimate_SubLine__c> miscLines = new List<Service_Estimate_SubLine__c>();
		for(MiscChargeCode__c mCharge : [SELECT Id, Name, Active__c, ApplicablePayType__c, BaseCharge__c, 
												Description__c, FlatAmount__c, PercentageBasedAmount__c,
												MaximumCharge__c 
											FROM MiscChargeCode__c
											WHERE Active__c=true 
											AND Location__c=:subLine.Service_Estimate_Line__r.Service_Estimate__r.Store_Location__c
											AND ApplicablePayType__c INCLUDES (:subLine.Labor_Type__c )
											LIMIT 200]) {

			// Process Labor
			if(subLine.Line_Type__c == 'Labor' && (mCharge.BaseCharge__c=='Labor Sale')) {

				// Calculate Charge
				Decimal chargeAmount = 0;
				if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
				if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
					chargeAmount = ((subLine.Labor_Total__c * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (subLine.Labor_Total__c * (mCharge.PercentageBasedAmount__c / 100));
				}
				
				if(chargeAmount!=0) {
					miscLines.add(new Service_Estimate_SubLine__c(
							Service_Estimate_Line__c=subLine.Service_Estimate_Line__c, 
							Line_Type__c='Miscellaneous',
							Misc_Charge_Amount__c=chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
							Misc_Charge_Code__c=mCharge.Name,
							Misc_Charge_Description__c=mCharge.Description__c,
							SystemCreatedMiscCharge__c=true,
							SystemGeneratedFor__c=subLine.Id
					));
				}
			}

			if(subLine.Line_Type__c == 'Parts' && (mCharge.BaseCharge__c=='Parts Sale')) {

				System.debug('Parts Misc Charge');

				// Calculate Charge
				Decimal chargeAmount = 0;
				if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
				if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
					chargeAmount = ((subLine.Total_Part_Price__c * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (subLine.Total_Part_Price__c * (mCharge.PercentageBasedAmount__c / 100));
				}
				
				if(chargeAmount!=0) {
					miscLines.add(new Service_Estimate_SubLine__c(
							Service_Estimate_Line__c=subLine.Service_Estimate_Line__c, 
							Line_Type__c='Miscellaneous',
							Misc_Charge_Amount__c=chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
							Misc_Charge_Code__c=mCharge.Name,
							Misc_Charge_Description__c=mCharge.Description__c,
							SystemCreatedMiscCharge__c=true,
							SystemGeneratedFor__c=subLine.Id
					));
				}
				System.debug( mCharge );
				System.debug( miscLines );
			}			
		}	

		// Process any misc. Lines that exist.
		if(!miscLines.isEmpty()) {
			try {
				insert miscLines;
			} Catch(DmlException e) {
				throw new ServiceEstimateAPIException(e.getMessage());
			}
		}				
	}

	/* List of sublines */
	public static List<Service_Estimate_SubLine__c> readSubLines(Id serviceEstimateLineId) {
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, 
					Labor_Rate__c, Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, Part_Description__c, 
					Part_Name__c, Part_Price_List__c, Part_Cost__c, Labor_Total__c, Labor_Type__c, Name, 
					Misc_Charge_Amount__c, Misc_Charge_Code__c, Misc_Charge_Description__c
					FROM Service_Estimate_SubLine__c
					WHERE Service_Estimate_Line__c =: serviceEstimateLineId
					ORDER BY CreatedDate ASC];
	}

	public static List<Service_Estimate_SubLine__c> readSubLines(set<Id> estimateLines) {
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, 
					Labor_Rate__c, Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, Part_Description__c, 
					Part_Name__c, Part_Price_List__c, Part_Cost__c, Labor_Total__c, Labor_Type__c, Name, 
					Misc_Charge_Amount__c, Misc_Charge_Code__c, Misc_Charge_Description__c
					FROM Service_Estimate_SubLine__c
					WHERE Service_Estimate_Line__c IN: estimateLines
					ORDER BY CreatedDate ASC];
	}	

	public static List<Service_Estimate_SubLine__c> readSubLines(Id serviceEstimateLineId, String sublineType) {
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, 
					Labor_Rate__c, Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, Part_Description__c, 
					Part_Name__c, Part_Price_List__c, Part_Cost__c, Labor_Total__c, Labor_Type__c, Name,
					Misc_Charge_Amount__c, Misc_Charge_Code__c, Misc_Charge_Description__c
					FROM Service_Estimate_SubLine__c
					WHERE Service_Estimate_Line__c =: serviceEstimateLineId
					AND Line_Type__c =:sublineType
					ORDER BY CreatedDate ASC];
	} 

	/* Getter for the estimate line items */ 
	public static List<Service_Estimate_Line__c> estimateLines(Id estimateId) {
		return [SELECT Id, Name, Labor_Operation__c, Labor_Operation__r.Name, Labor_Operation__r.dealer__Book_Time__c, Labor_Operation__r.dealer__Labor_Rate__c, Service_Estimate__c, Description__c,
						Status__c, Labor_Type__c, Labor__c, Parts__c, Line_Total__c, Misc_Charges__c  
					FROM Service_Estimate_Line__c 
					WHERE Service_Estimate__c=:estimateId 
					LIMIT 200];
	}

	/* Getter for the Misc Charge Types by Location */
	public static List<MiscChargeCode__c> miscChargeCodes(Id locationId) {
		return [SELECT Location__c, FlatAmount__c, PercentageBasedAmount__c, Active__c, Description__c, BaseCharge__c, ApplicablePayType__c, Id, Name 
					FROM MiscChargeCode__c
					WHERE Location__c=:locationId];
	}

	public class ServiceEstimateAPIException extends Exception{}

}