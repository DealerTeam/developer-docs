/* Service Estimate Line Control Handler - Service Layer Application Class */
public class ServiceEstimateLineControlHandler
{
	/* Pre-clear values that are going to be saved to the object */
	public void preflight(List<Service_Estimate_SubLine__c> subLines) {
		for(Service_Estimate_SubLine__c ses : subLines) {

			// If we are storing Labor Values than the Type must be Labor
			if(ses.Line_Type__c != 'Labor' &&
				(
					(
						ses.Labor_Rate__c != null && ses.Labor_Rate__c > 0
						|| ses.Book_Time__c != null && ses.Book_Time__c > 0
					)
				)
			 ) {
					ses.addError('Line Type must be Labor to store labor values, please append your object to labor type if you are attempting to store labor values.');
			}
		}
	}


	/* Total Values for the parent line */
	public void handleRollUp(List<Service_Estimate_SubLine__c> subLines, List<Service_Estimate_SubLine__c> beforeSubLines) {
		
		// prepare affected Ids'
		Set<Id> estimateLines = new Set<Id>();
		for(Service_Estimate_SubLine__c sl : subLines) {
			if(!estimateLines.contains(sl.Service_Estimate_Line__c)) {
				estimateLines.add(sl.Service_Estimate_Line__c);
			}
		}

		if(!estimateLines.isEmpty()) {
			performRollUp(estimateLines);
		}

	}

	public void handleRollUp(List<Service_Estimate_Line__c> seLines) {
		Set<Id> seLineIds = new Set<Id>();
		for(Service_Estimate_Line__c sel : seLines) {
			seLineIds.add(sel.Id);
		}
		performRollUp(seLineIds);
	}

	private void performRollUp(Set<Id> estimateLineIds) {

		// Retreive the affected lines and their Labor/Parts Totals
		Map<Id, Service_Estimate_Line__c> eLine = new Map<Id, Service_Estimate_Line__c>();
		AggregateResult[] ar = [SELECT Service_Estimate_Line__c, 
										SUM(Total_Part_Price__c) partsTotal, 
										SUM(Labor_Total__c) laborTotal,
										SUM(Misc_Charge_Amount__c) miscTotal 
									FROM Service_Estimate_SubLine__c
									WHERE Service_Estimate_Line__c IN:estimateLineIds
									GROUP BY Service_Estimate_Line__c];

		// It is possible that no results are returned.  In this case let's specify an empty object map based on line Id
		for(Id idvalue : estimateLineIds) {
			eLine.put(idvalue, 
						new Service_Estimate_Line__c(
							Id=idvalue, 
							Labor__c=0,
							Parts__c=0,
							Misc_Charges__c=0
						)
			);			
		}

		// Exit method if we are not processing any values
		// To-Do
		
		// Allign values into a Map for comparison
		for(AggregateResult arv : ar) {

			// Sanity Check
			if(arv.get('dealer__Service_Estimate_Line__c')==null){
				throw new ServiceEstimateLineControlHandlerException('Aggregate Result does not contain the required key of Service_Estimate_Line__c');
			}

			eLine.put((Id)arv.get('dealer__Service_Estimate_Line__c'), 
						new Service_Estimate_Line__c(
							Id=(Id)arv.get('dealer__Service_Estimate_Line__c'), 
							Labor__c=(Decimal)arv.get('laborTotal'),
							Parts__c=(Decimal)arv.get('partsTotal'),
							Misc_Charges__c=(Decimal)arv.get('miscTotal')
						)
			);
		}

		// If we have values to process being their processing
		if(!eLine.isEmpty()) {
			try {
				System.debug(eLine);
				update eLine.values();
			} Catch(DmlException e) {
				throw new ServiceEstimateLineControlHandlerException(e.getMessage());
			}
		}		
	}

	/* Service Estimate Lines Classes */

	// public List<Service_Estimate_Line__c> sumLineValues(List<Service_Estimate_Line__c> seLines) {

	// 	for(Service_Estimate_Line__c se : seLines) {

	// 		// Prevent nulls
	// 		if(se.Labor__c==null) 
	// 			se.Labor__c=0;

	// 		if(se.Parts__c==null)
	// 			se.Parts__c=0;
			
	// 		if(se.Misc_Charges__c==null)
	// 			se.Misc_Charges__c=0;

	// 		// Sub the line
	// 		se.Line_Total__c = se.Labor__c + se.Parts__c + se.Misc_Charges__c;
	// 	}

	// 	return seLines;
	// }
	
	/* Prevent Converted Estimates from being Edited */
	public void preventEdit(List<Service_Estimate_Line__c> seLines) {
		Set<Id> headerIds = new Set<Id>();
		for(Service_Estimate_Line__c sel : seLines) {
			headerIds.add(sel.Service_Estimate__c);
		}

		// Deprecating this method of validation.  
		for(Service_Estimate__c se : [SELECT Id, Status__c, Service_Repair_Order__c FROM Service_Estimate__c WHERE Id IN:headerIds]) {
			if(se.Status__c=='Accepted')
				throw new ServiceEstimateLineControlHandlerException('Update Failed: Service Estimates converted to Repair Orders may not be edited.');
		}
	}

	public void setLineNumber(List<Service_Estimate_Line__c> triggerNew){
		Set<Id> estIds = new Set<Id>();
		Map<Id, Service_Estimate_Line__c> seMap = new Map<Id, Service_Estimate_Line__c>(); 

		for(Service_Estimate_Line__c line : triggerNew){
			estIds.add(line.Service_Estimate__c);
		}
		if(estIds.size() > 0){
			List<Service_Estimate__c> estimates = [SELECT Id, (SELECT Id, Line_Number__c FROM Service_Estimate_Lines__r ORDER BY Line_Number__c DESC) FROM Service_Estimate__c WHERE Id IN: estIds];
			for(Service_Estimate__c est : estimates){
				if(est.Service_Estimate_Lines__r.size() > 0){
					seMap.put(est.Id, est.Service_Estimate_Lines__r[0]);
				}
				system.debug(seMap);
			}

			for(Service_Estimate_Line__c line : triggerNew){
				if(seMap.get(line.Service_Estimate__c) != null){
					line.Line_Number__c = seMap.get(line.Service_Estimate__c).Line_Number__c + 1;
				}
				else{
					line.Line_Number__c = 1;
				}
			}
		}
	}

	public class ServiceEstimateLineControlHandlerException extends Exception {}
}