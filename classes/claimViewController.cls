/**
 * claimViewController
 * @description
 */
public with sharing class claimViewController {
	
	/**
	 * @description
	 */
	public Claim__c claim {get;set;}
	
	/**
	 * @description
	 */
	public Dealer_Location__c location {get; set;}
	
	/**
	 * @description
	 */
	public List<Dealer_Location__c> locations {get; set;}

	/**
	 * claimViewController 
	 * @param  sc 
	 * @description
	 */ 
	public claimViewController(ApexPages.standardController sc)
	{



		// Collect All Managed Fields
        Map<String, Schema.SObjectField> M = Schema.SObjectType.Claim__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
		af.add('ServiceRepairOrder__r.Name'); 
        if(!Test.isRunningTest()) {       
            sc.addFields(af);
        }		

		claim = (Claim__c)sc.getRecord();
	if(claim.Id!=null && claim.dealer__Customer__c!=null){
		locations = [SELECT Id, Name, Customer_Pay_Labor_Rate__c, LaborCost__c, Warranty_Labor_Rate__c, Internal_Labor_Rate__c FROM Dealer_Location__c WHERE Location_Account__c=:claim.dealer__Customer__c LIMIT 1];
		if(!locations.isEmpty()){
			location = locations[0];
		}
        }
	}	
	 public String getDealerLocation() {
        return JSON.serialize(location);
    }

	/**
	 * reloadDetail 
	 * @return  Claim__c
	 * @description
	 */ 
	public Claim__c reloadDetail() 
	{
		claim = [SELECT  
				BuyPrice__c, CompanyNumber__c, 
				CosmeticNotes__c, CurrentMMR__c, CurrentMileage__c, CustomerContact__c, 
				Customer__c, Days__c, DesiredProfit__c, Detail__c, DiscountRate__c, 
				Discount__c, EmailApprover__c, EstimateNotes__c, 
				EstimateTotal__c, EstimatedPack__c, FinalizedBy__c, FinishDate__c, 
				InventoryVehicleVIN__c, InventoryVehicle__c, NavigationDiscSDInstalled__c, 
				OwnersManual__c, PartsSubletTotal__c, Safety__c, ServiceAdvisor__c, 
				ServiceRepairOrder__c, ServiceVehicle__c, Smog__c, Status__c, 
				StoreLocation__c, SuggestedRetailPrice__c, Taxable__c, 
				TransportDamageDescription__c, TransportDamage__c, VIN_Verified__c, 
				CosmeticTotal__c, LaborToDiscount__c, PartsToDiscount__c, 
				TotalLaborCharges__c, TotalPartsCharges__c, TotalSubletCharges__c, 
				TotalTax__c, TotalMiscCharges__c, Name, Id 
				FROM Claim__c 
				WHERE Id=:claim.Id 
				LIMIT 1];
		return null;
	}

	/**
	 * getOpCodeHeaders 
	 * @return list<OperationCodeGroup__c>
	 * @description
	 */ 
	public list<OperationCodeGroup__c> getOpCodeHeaders()
	{
		List<OperationCodeGroup__c> headerGroups = new List<OperationCodeGroup__c>();
		for(OperationCodeGroup__c ocg :[select Id, name from OperationCodeGroup__c WHERE TopLevelGroup__c = true] ){
			headerGroups.add(ocg);
		}
		return headerGroups;
	}
	
	/**
	 * OpGroup
	 * @description
	 */
	public class OpGroup
	{
		public OperationCodeGroup__c Parent {get;set;}
		public List<OperationCodeGroup__c> Children {get;set;}
		public List<StandardOpCode__c> OpCodes {get;set;}
		public OpGroup( OperationCodeGroup__c parent, List<OperationCodeGroup__c> children, List<StandardOpCode__c> opCodes){
			this.Parent = parent;
			this.Children = children;
			this.OpCodes = opCodes;
		}
	}

	/* Remotes */
	
	/**
	 * selectCodeGroup 
	 * @param  recordId 
	 * @return  OpGroup
	 * @description
	 */
	@remoteAction
	public static OpGroup selectCodeGroup(String recordId)
	{
		System.assert(recordId != null, 'Parent OperationCodeGroup Id is required to perform this action.');		
		OperationCodeGroup__c parentCodeGroup = [Select Id, Name, TopLevelGroup__c FROM OperatioNCodeGroup__c WHERE Id =: recordId];
		Boolean bottomTier = false;
		Set<Id> opCodeSet = new Set<Id>();
		Set<Id> codeGroupSet = new Set<Id>();

		for(OperationGroupAssignment__c oga : [SELECT Id, OperationGroupParent__c, OperationGroupChild__c, StandardOperationCode__c FROM OperationGroupAssignment__c WHERE OperationGroupParent__c =: recordId]){
			if(oga.StandardOperationCode__c != null){
				bottomTier = true;
				opCodeSet.add(oga.StandardOperationCode__c);
			} else if(!bottomTier) {
				codeGroupSet.add(oga.OperationGroupChild__c); // Don' tneed to get any children if we've already reached bottom tier
			}
		}

		List<StandardOpCode__c> opCodes = new List<StandardOpCode__c>();
		List<OperationCodeGroup__c> childrenGroups = new List<OperationCodeGroup__c>();
		if(bottomTier){
			//get List of Available Op Codes
			for(StandardOpCode__c soc : [SELECT Id, Name FROM StandardOpCode__c WHERE Id IN: opCodeSet]){
				opCodes.add(soc);
			}
		} else {
			// get list of code group children
			for(OperationCodeGroup__c cg :[select Id, Name FROM OperationCodeGroup__c WHERE Id IN: codeGroupSet]){
				childrenGroups.add(cg);
			}
		}
		return new OpGroup( parentCodeGroup, childrenGroups, opCodes);
	}
	
	/**
	 * applyOpCodeToLine 
	 * @param  lineId              
	 * @param  opCodeId           
	 * @param  topLevelCodeGroupId 
	 * @param  clickPath         
	 * @return   String
	 * @description                  
	 */
	@remoteAction
	public static String applyOpCodeToLine(String lineId, String opCodeId, String topLevelCodeGroupId, String clickPath)
	{
		ClaimItem__c claimItem = new ClaimItem__c(Id=lineId,LaborOperation__c=opCodeId, TopOperationGroup__c = topLevelCodeGroupId, OperationCodeSelectPath__c = clickPath);
		update claimItem;
		return JSON.serializePretty(claimItem);
	}

	/**
	 * operationCodes 
	 * @param  selectedId 
	 * @return  List<StandardOpCode__c>    
	 * @description     
	 */ 
	@remoteAction
	public static List<StandardOpCode__c> operationCodes(String selectedId) 
	{
		if(String.isBlank(selectedID)){
			return ServiceAPI.standardOperationCodes();
		} else {
			return [Select Id, Name, Concern__c, Estimate__c, 
						Op_Code_Description__c, Service_Type__c, 
						Book_Time__c, Pay_Type__c
						FROM StandardOpCode__c
						WHERE Id =: selectedID];
		}
	}

	/**
	 * createEstimateLine 
	 * @param  jLine 
	 * @return  ClaimItem__c
	 * @description      
	 */
	@remoteAction
	public static ClaimItem__c createEstimateLine(String jLine) 
	{

		// Cast the sender into an estimate line
		ClaimItem__c line = new ClaimItem__c();

		try {
			line = (ClaimItem__c)JSON.deserialize(jLine, ClaimItem__c.class);
			line = ClaimAPI.createEstimateLine(line);
     
            //createSubLine when SOC is set
            if(line.LaborOperation__c != null && line.LaborOperation__r.dealer__Book_Time__c != null) {
                
            	ClaimSubItem__c subline = new ClaimSubItem__c();
            	subline.dealer__LineType__c = 'Labor';
            	subline.dealer__ClaimItem__c = line.Id;
                subline.dealer__BookTime__c = line.LaborOperation__r.dealer__Book_Time__c;
                system.debug(line.Claim__r.dealer__ServiceAdvisor__c);
                system.debug(line.Claim__r.dealer__ServiceVehicle__c);
                subline.dealer__LaborRate__c = ServiceAPI.getWarrantyLaborRate(line.Claim__r.dealer__Customer__c) > 0 ? ServiceAPI.getWarrantyLaborRate(line.Claim__r.dealer__Customer__c) : line.LaborOperation__r.dealer__Labor_Rate__c;
                

              try {
                  claimAPI.createSubLine(subline);
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

	/**
	 * updateEstimateLine 
	 * @param  line 
	 * @return  ClaimItem__c
	 * @description
	 */
	@remoteAction
	public static ClaimItem__c updateEstimateLine(String line) 
	{
		return ClaimAPI.updateEstimateLine((ClaimItem__c)JSON.deserialize(line, ClaimItem__c.class));
	}
	
	/**
	 * deleteEstimateLine 
	 * @param  lineId 
	 * @return  Boolean
	 * @description
	 */
	@remoteAction
	public static Boolean deleteEstimateLine(String lineId) 
	{
		return ClaimAPI.deleteEstimateLine(lineId);
	}
	
	/**
	 * createSubLine 
	 * @param  subLine 
	 * @return  ClaimSubItem__c  
	 * @description     
	 */ 
	@remoteAction
	public static ClaimSubItem__c createSubLine(String subLine) 
	{
		return ClaimAPI.createSubLine((ClaimSubItem__c)JSON.deserialize(subLine, ClaimSubItem__c.class));
	}
	
	/**
	 * readSubLines 
	 * @param  lineRequest 
	 * @return  List<ClaimSubItem__c>
	 * @description
	 */
	@remoteAction
	public static List<ClaimSubItem__c> readSubLines(String lineRequest) 
	{
		try {
			String[] lineRequestParts = lineRequest.split('~');
			System.debug(lineRequestParts.size());
			if(lineRequestParts.size()!=2) {
				return null;
			}

			System.debug(lineRequestParts);
			System.debug(lineRequestParts.size());
			System.assert(lineRequestParts.size()==2);
			return ClaimAPI.readSubLines(lineRequestParts[0], lineRequestParts[1]);
		} Catch(Exception e) {
			throw new ClaimAPIException(e.getMessage());
		}
	}

	/**
	 * updateSubLine 
	 * @param  lineRequest 
	 * @return   ClaimSubItem__c
	 * @description
	 */ 
	@remoteAction
	public static ClaimSubItem__c updateSubLine(String lineRequest) 
	{
		try {
			return ClaimAPI.updateSubLine((ClaimSubItem__c)JSON.deserialize(lineRequest, ClaimSubItem__c.class));
		} Catch(DmlException e) {
			throw new ClaimAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new ClaimAPIException(e.getMessage());
		}
		//return null;
	}

	/**
	 * deleteSubLine 
	 * @param  subLineId 
	 * @return  void
	 * @description
	 */ 
	@remoteAction
	public static void deleteSubLine(String subLineId) 
	{
		try {
			ClaimAPI.deleteSubLine((Id)subLineId);
		} Catch(Exception e) {
			throw new ClaimAPIException(e.getMessage());
		}
	}
 
	/**
	 * estimateLines 
	 * @param  estimateId 
	 * @return  List<ClaimItem__c>
	 * @description
	 */ 
	@remoteAction
	public static List<ClaimItem__c> estimateLines(String estimateId) 
	{
		return ClaimAPI.estimateLines(estimateId);
	}

	/**
	 * matrix description
	 * @param  pl 
	 * @return  Decimal
	 * @description
	 */
	@remoteAction
	public static Decimal matrix(String pl) 
	{
		String[] p = pl.split('~');
		System.assert(p.size()==2, 'Matrix call expects two parameters.');
		Parts_Master__c pm = [SELECT Id, Cost__c, Retail_Price__c FROM Parts_Master__c WHERE Id=:p[1]];
		return PartAPI.matrix(p[0], pm);
	}

	// @remoteAction
	// public static Id appendToRepairOrder(Id estimateId) {
	// 	throw new ServiceEstimateAPIException('Test Message from the Controller');
	// 	return null;
	// }

	/**
	 * miscChargeCodes 
	 * @param  locationId 
	 * @return   List<MiscChargeCode__c> 
	 * @description
	 */ 
	@remoteAction
	public static List<MiscChargeCode__c> miscChargeCodes(String locationId) 
	{
		return ClaimAPI.miscChargeCodes(locationId);
	}

	/**
	 * ClaimAPIException
	 * @description
	 */
	public class ClaimAPIException extends Exception {}
}