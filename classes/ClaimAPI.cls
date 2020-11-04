/**
 * ClaimAPI
 * @description
 */
global class ClaimAPI {
	
	/**
	 * createEstimateLine - creation of an estimate line
	 * @param  line 
	 * @return  ClaimItem__c
	 * @description Used within the claim creation process
	 */ 
	public static ClaimItem__c createEstimateLine(ClaimItem__c line) 
	{

		// Check to see we are not adding a line to an estimate that has a converted repair order already
		if(line.Claim__c != null) {
			try {
				Set<String> protectedCodes = Utility.protectedStatusCodes('dealer__Service_Repair_Order__c');
			 	Claim__c[] estimateOnDisk = [SELECT Id, ServiceRepairOrder__c FROM Claim__c WHERE Id=:line.Claim__c AND ServiceRepairOrder__r.Status__c IN:protectedCodes];
				if(!estimateOnDisk.isEmpty() && estimateOnDisk[0].ServiceRepairOrder__c!=null) {
					throw new ClaimAPIException('Unable to add Claim Item.  This claim is associated with a Repair Order that is in protected status.');
				}
			} Catch(Exception e) {
				throw new ClaimAPIException(e.getMessage());
			}
		}

		try {
			line.Id=null; //Setting this value in the event it is passed in as part of the model.
			insert line;
			line = [SELECT Id, Name, LaborOperation__c, Authorized__c, LaborOperation__r.Name, LaborOperation__r.dealer__Book_Time__c, LaborOperation__r.dealer__Labor_Rate__c, Claim__c, Description__c , dealer__Concern__c , dealer__Cause__c, dealer__Correction__c, Claim__r.dealer__ServiceAdvisor__c, Claim__r.dealer__ServiceVehicle__c,
						Status__c, LaborType__c, Claim__r.dealer__ServiceAdvisor__r.dealer__Flat_Rate_Technician__c, Claim__r.StoreLocation__r.dealer__Warranty_Labor_Rate__c, Claim__r.Customer__c
						FROM ClaimItem__c 
						WHERE Id=:line.Id 
						LIMIT 1];

		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new ClaimAPIException(e.getMessage());
		}

		return line;
	} 

	/**
	 * updateEstimateLine
	 * @param  line 
	 * @return   ClaimItem__c 
	 * @description Update line call
	 */
	public static ClaimItem__c updateEstimateLine(ClaimItem__c line) 
	{

		// Determine if the line has any related sub lines generated automatically (Misc. Charges)
		// If these are present append the values
		List<ClaimSubItem__c> subLines = [SELECT Id, Name FROM ClaimSubItem__c WHERE SystemGeneratedFor__c =:line.Id];


		try {
			update line;
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}

		return line;
	}	

	/**
	 * deleteEstimateLine 
	 * @param  lineId 
	 * @return  Boolean    
	 * @description Delete line call 
	 */
	public static Boolean deleteEstimateLine(Id lineId) 
	{
		try {
			ClaimItem__c line = new ClaimItem__c();
			line.Id=lineId;
			delete line;
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}

		return true;
	}

	/* -- Sub Lines --*/
	
	/**
	 * estimateSubLines 
	 * @param  lineId 
	 * @return  List<ClaimSubItem__c>
	 * @description
	 */ 
	public static List<ClaimSubItem__c> estimateSubLines(Id lineId) 
	{
		return [SELECT ClaimItem__c, PartsMaster__c, LineType__c, LaborRate__c, BookTime__c, 
						PartQuantity__c, PartPrice__c, TotalPartPrice__c, CreatedById, CreatedDate, 
						LastModifiedById, LastModifiedDate, Name, Id 
					FROM ClaimSubItem__c
					WHERE ClaimItem__c =:lineId 
					LIMIT 200];
	}

	/**
	 * createSubLine 
	 * @param  subLine 
	 * @return  ClaimSubItem__c 
	 * @description      
	 */
	public static ClaimSubItem__c createSubLine(ClaimSubItem__c subLine) 
	{

		try {
			subLine.Id=null;
			insert subLine;
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}

		if(subLine.LineType__c=='Parts' || subLine.LineType__c=='Labor') {
		    ClaimAPI.createMiscCharges(ClaimAPI.returnSubLine(subLine.Id));
		}

		return ClaimAPI.returnSubLine(subLine.Id);
	}

	/**
	 * updateSubLine 
	 * @param  subLine 
	 * @return  ClaimSubItem__c
	 * @description
	 */
	public static ClaimSubItem__c updateSubLine(ClaimSubItem__c subLine) 
	{
		try {
			update subLine;
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}

		if(subLine.LineType__c=='Parts' || subLine.LineType__c=='Labor') {
			ClaimAPI.createMiscCharges(ClaimAPI.returnSubLine(subLine.Id));
		}		

		return ClaimAPI.returnSubLine(subLine.Id);		
	}

	/**
	 * deleteSubLine 
	 * @param  subLine 
	 * @return void
	 * @description
	 */ 
	public static void deleteSubLine(Id subLine) 
	{

		// Delete any auto generated sub lines based on this misc. sub line
		List<ClaimSubItem__c> autoSubLines = [SELECT Id, ClaimItem__c FROM ClaimSubItem__c WHERE SystemGeneratedFor__c =:subLine]; 

		List<ClaimItem__c> estimateLinesToRollUp = new List<ClaimItem__c>();
		for(ClaimSubItem__c sesubline : autoSubLines) {
			estimateLinesToRollUp.add(new ClaimItem__c(Id=sesubline.ClaimItem__c));
		}

		try {

			delete new ClaimSubItem__c(Id=subLine);
			delete autoSubLines;

		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}
	}

	/**
	 * returnSubLine 
	 * @param  subLineId 
	 * @return  ClaimSubItem__c
	 * @description
	 */
	private static ClaimSubItem__c returnSubLine(Id subLineId) 
	{

		System.debug(subLineId);

		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, ClaimItem__c, PartsMaster__c, LineType__c, 
					LaborRate__c, BookTime__c, PartQuantity__c, PartPrice__c, TotalPartPrice__c, PartDescription__c, 
					PartName__c, PartPriceList__c, PartCost__c, LaborTotal__c, LaborType__c, Name, 
					MiscChargeAmount__c, MiscChargeCode__c, MiscChargeDescription__c,
					ClaimItem__r.Claim__r.StoreLocation__c 
					FROM ClaimSubItem__c
					WHERE Id =: subLineId
					LIMIT 1];
	}

	/**
	 * createMiscCharges 
	 * @param  subLine 
	 * @return void
	 * @description
	 */ 
	private static void createMiscCharges(ClaimSubItem__c subLine) 
	{

		// Remove any existing misc charge lines.
		List<ClaimSubItem__c> existingChargeLines = [SELECT Id FROM ClaimSubItem__c WHERE ClaimItem__c =:subLine.ClaimItem__c AND SystemGeneratedFor__c =:subLine.Id];
		try {
			delete existingChargeLines;
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		}

		// Get associated Misc Charge Setup
		List<ClaimSubItem__c> miscLines = new List<ClaimSubItem__c>();
		for(MiscChargeCode__c mCharge : [SELECT Id, Name, Active__c, ApplicablePayType__c, BaseCharge__c, 
												Description__c, FlatAmount__c, PercentageBasedAmount__c,
												MaximumCharge__c 
											FROM MiscChargeCode__c
											WHERE Active__c=true 
											AND Location__c=:subLine.ClaimItem__r.Claim__r.StoreLocation__c
											AND ApplicablePayType__c INCLUDES (:subLine.LaborType__c )
											LIMIT 200]) {

			// Process Labor
			if(subLine.LineType__c == 'Labor' && (mCharge.BaseCharge__c=='Labor Sale')) {

				// Calculate Charge
				Decimal chargeAmount = 0;
				if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
				if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
					chargeAmount = ((subLine.LaborTotal__c * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (subLine.LaborTotal__c * (mCharge.PercentageBasedAmount__c / 100));
				}
				
				if(chargeAmount!=0) {
					miscLines.add(new ClaimSubItem__c(
							ClaimItem__c=subLine.ClaimItem__c, 
							LineType__c='Miscellaneous',
							MiscChargeAmount__c=chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
							MiscChargeCode__c=mCharge.Name,
							MiscChargeDescription__c=mCharge.Description__c,
							SystemCreatedMiscCharge__c=true
    						//Commented out per Jarrett this lookup should not be needed for claims
                            //SystemGeneratedFor__c=subLine.Id
					));
				}
			}

			if(subLine.LineType__c == 'Parts' && (mCharge.BaseCharge__c=='Parts Sale')) {

				System.debug('Parts Misc Charge');

				// Calculate Charge
				Decimal chargeAmount = 0;
				if(mCharge.FlatAmount__c!=null) { chargeAmount=mCharge.FlatAmount__c; }
				if(mCharge.PercentageBasedAmount__c!=null && mCharge.PercentageBasedAmount__c != 0) { 
					chargeAmount = ((subLine.TotalPartPrice__c * (mCharge.PercentageBasedAmount__c / 100)) > mCharge.MaximumCharge__c) ?  mCharge.MaximumCharge__c : (subLine.TotalPartPrice__c * (mCharge.PercentageBasedAmount__c / 100));
				}
				
				if(chargeAmount!=0) {
					miscLines.add(new ClaimSubItem__c(
							ClaimItem__c=subLine.ClaimItem__c, 
							LineType__c='Miscellaneous',
							MiscChargeAmount__c=chargeAmount.setScale(2, System.RoundingMode.HALF_UP),
							MiscChargeCode__c=mCharge.Name,
							MiscChargeDescription__c=mCharge.Description__c,
							SystemCreatedMiscCharge__c=true
							//Commented out per Jarrett this lookup should not be needed for claims
                            //SystemGeneratedFor__c=subLine.Id
					));
				}
				System.debug(mCharge);
				System.debug(miscLines);
			}			
		}	

		// Process any misc. Lines that exist.
		if(!miscLines.isEmpty()) {
			try {
				insert miscLines;
			} Catch(DmlException e) {
				throw new ClaimAPIException(e.getMessage());
			}
		}				
	}

	/* List of sublines */
	
	/**
	 * readSubLines 
	 * @param  serviceEstimateLineId 
	 * @return  List<ClaimSubItem__c> 
	 * @description
	 */ 
	public static List<ClaimSubItem__c> readSubLines(Id serviceEstimateLineId) 
	{
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, ClaimItem__c, PartsMaster__c, LineType__c, 
					LaborRate__c, BookTime__c, PartQuantity__c, PartPrice__c, TotalPartPrice__c, PartDescription__c, 
					PartName__c, PartPriceList__c, PartCost__c, LaborTotal__c, LaborType__c, Name, 
					MiscChargeAmount__c, MiscChargeCode__c, MiscChargeDescription__c
					FROM ClaimSubItem__c
					WHERE ClaimItem__c =: serviceEstimateLineId
					ORDER BY CreatedDate ASC];
	}

	/**
	 * readSubLines 
	 * @param  estimateLines 
	 * @return  List<ClaimSubItem__c>
	 * @description
	 */ 
	public static List<ClaimSubItem__c> readSubLines(set<Id> estimateLines) 
	{
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, ClaimItem__c, PartsMaster__c, LineType__c, 
					LaborRate__c, BookTime__c, PartQuantity__c, PartPrice__c, TotalPartPrice__c, PartDescription__c, 
					PartName__c, PartPriceList__c, PartCost__c, LaborTotal__c, LaborType__c, Name, 
					MiscChargeAmount__c, MiscChargeCode__c, MiscChargeDescription__c
					FROM ClaimSubItem__c
					WHERE ClaimItem__c IN: estimateLines
					ORDER BY CreatedDate ASC];
	}	

	/**
	 * readSubLines 
	 * @param  serviceEstimateLineId 
	 * @param  sublineType           
	 * @return   List<ClaimSubItem__c> 
	 * @description                  
	 */
	public static List<ClaimSubItem__c> readSubLines(Id serviceEstimateLineId, String sublineType) 
	{
		return [SELECT Id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, ClaimItem__c, PartsMaster__c, LineType__c, 
					LaborRate__c, BookTime__c, PartQuantity__c, PartPrice__c, TotalPartPrice__c, PartDescription__c, 
					PartName__c, PartPriceList__c, PartCost__c, LaborTotal__c, LaborType__c, Name, 
					MiscChargeAmount__c, MiscChargeCode__c, MiscChargeDescription__c
					FROM ClaimSubItem__c
					WHERE ClaimItem__c =: serviceEstimateLineId
					AND LineType__c =:sublineType
					ORDER BY CreatedDate ASC];
	} 

	/**
	 * estimateLines 
	 * @param  estimateId 
	 * @return  List<ClaimItem__c> 
	 * @description Getter for the estimate line items       
	 */ 
	public static List<ClaimItem__c> estimateLines(Id estimateId) 
	{
		return [SELECT Id, Name, LaborOperation__c, Authorized__c, LaborOperation__r.Name, LaborOperation__r.dealer__Book_Time__c, LaborOperation__r.dealer__Labor_Rate__c, Claim__c, Description__c,
						Status__c, LaborType__c, Labor__c, Parts__c, LineTotal__c, MiscCharges__c, dealer__Concern__c, dealer__Correction__c, dealer__Cause__c 
					FROM ClaimItem__c 
					WHERE Claim__c=:estimateId 
					LIMIT 200];
	}
	
	/**
	 * miscChargeCodes 
	 * @param  locationId 
	 * @return  List<MiscChargeCode__c>   
	 * @description  Getter for the Misc Charge Types by Location     
	 */
	public static List<MiscChargeCode__c> miscChargeCodes(Id locationId) 
	{
		return [SELECT Location__c, FlatAmount__c, PercentageBasedAmount__c, Active__c, Description__c, BaseCharge__c, ApplicablePayType__c, Id, Name 
					FROM MiscChargeCode__c
					WHERE Location__c=:locationId];
	}

    /**
	 * claimData 
	 * @param  claimId 
	 * @return  claim 
	 * @description       
	 */
	global static claim claimData(Id claimId)
	{
		System.assert(claimId != null ,'claim Id is required to get claim Data.');

		claimAPI.claim claim = new claimAPI.claim();

		//First get claim header.
		claim.claimHeader = (claim__c)Utility.queryAllFields('dealer__Claim__c', claimId);

		//Attached Customer Account to Warranty
		if(claim.claimHeader.Customer__c != null){
			claim.customer = (Account)Utility.queryAllFields('Account', claim.claimHeader.Customer__c);
		}

		//Attached employee that  created the Warranty
		if(claim.claimHeader.CreatedById != null){
			claim.employee = [SELECT Id, Name From User WHERE Id =: claim.claimHeader.CreatedById];// (User)Utility.queryAllFields('User', claim.claimHeader.CreatedById);
		}
        
        //Attached Service Vehicle to Warranty
        if(claim.claimHeader.ServiceVehicle__c != null){
            claim.serviceVehicle = (Service_Vehicle__c)Utility.queryAllFields('dealer__Service_Vehicle__c', claim.claimHeader.ServiceVehicle__c);
        }
		//Getting  SROvehicle attached to

        if(claim.claimHeader.ServiceRepairOrder__c != null){
            claim.sro = (Service_Repair_Order__c)Utility.queryAllFields('dealer__Service_Repair_Order__c', claim.claimHeader.ServiceRepairOrder__c);
		}
		//Getting  dealership/ store Locationthat the  vehicle is attached to

        if(claim.claimHeader.StoreLocation__c != null){
            claim.location = (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c', claim.claimHeader.StoreLocation__c);
		}

		//Getting Equipment Object FROm Claim
        if(claim.claimHeader.Equipment__c!= null){
			claim.claimEquipment = (Equipment__c)Utility.queryAllFields('dealer__Equipment__c', claim.claimHeader.Equipment__c);
		}
			
		//Getting Equipment Inventory Object From Claim
        if(claim.claimHeader.EquipmentInventory__c!= null){
			claim.equipment = (EquipmentInventory__c)Utility.queryAllFields('dealer__EquipmentInventory__c', claim.claimHeader.EquipmentInventory__c);
		}

		//Getting Attached Appraisal to Claim
        if(claim.claimHeader.Appraisal__c!= null){
            claim.appraisal = (Appraisal__c)Utility.queryAllFields('dealer__Appraisal__c', claim.claimHeader.Appraisal__c);
		}
	
		// Getting all claim items & sub items attached to a claim
		List<dealer__ClaimItem__c> cis = new List<dealer__ClaimItem__c>();

		for(dealer__ClaimItem__c ci : [SELECT Id, Authorized__c, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, dealer__Claim__c,
		 dealer__BookTime__c, dealer__CosmeticEstimate__c, dealer__Description__c, dealer__DetailExpense__c, dealer__DiagramReferenceNumber__c, dealer__DiscountLabor__c,
		 dealer__DiscountParts__c, dealer__LaborOperation__c, dealer__LaborType__c, dealer__Labor__c, dealer__LineNumber__c, dealer__LineTotal__c, dealer__MiscCharges__c,
		   dealer__PartDescription__c, dealer__PartItem__c, dealer__Parts__c, dealer__RepairEstimate__c, dealer__RepairType__c, dealer__Status__c, dealer__SubTotal__c,
		    dealer__SubletCharges__c, dealer__SubletWork__c, dealer__Tax__c, dealer__TireQTY__c, dealer__Vendor__c, dealer__damageCoordinateX__c, dealer__damageCoordinateY__c ,
			( SELECT Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, dealer__ClaimItem__c, dealer__BookTime__c, dealer__LaborRate__c,
			  dealer__LaborTotal__c, dealer__LaborType__c, dealer__LineType__c, dealer__LocationId__c, dealer__MiscChargeAmount__c, dealer__MiscChargeCode__c,
			   dealer__MiscChargeDescription__c, dealer__PartCost__c, dealer__PartDescription__c, dealer__PartName__c, dealer__PartPriceList__c, dealer__PartPrice__c,
			    dealer__PartQuantity__c, dealer__PartsMaster__c, dealer__SystemCreatedMiscCharge__c, dealer__SystemGeneratedFor__c, dealer__TotalPartPrice__c FROM Claim_Sub_Items__r)
		FROM dealer__ClaimItem__c Where dealer__Claim__c =: claimId]){
			cis.add(ci);
		}
		if(cis.size() > 0 ){
			claim.cis = cis;
		}

		return claim;
	}

	/**
	 * claim
	 * @description Wrapper class for claim data and related records.
	 */ 
	global class claim 
	{

		// Header Data
		global claim__c claimHeader {get;set;}

		// // Referential Data records available to create at the same time as the claim object. 

		global Account customer {get;set;}
		global User employee {get;set;}
		global Equipment__c claimEquipment {get;set;}
		global EquipmentInventory__c equipment {get;set;}
		global dealer_Location__c location {get;set;}
		global Service_Vehicle__c serviceVehicle {get;set;} 
		global Service_Repair_Order__c sro {get;set;} 
		global Vehicle_Inventory__c vehicle {get;set;}
		global Appraisal__c appraisal {get;set;}

		// // List Data
		global List<dealer__ClaimItem__c> cis {get;set;}


		global claim() {
         cis  =	new List<dealer__ClaimItem__c>();
		}
	}
	
	/**
	 * claimAPIException
	 * @description
	 */
	global class claimAPIException extends Exception {}
	
}