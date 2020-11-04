/**
 * DealershipLocationAPI
 * @description
 */
global class DealershipLocationAPI {

	/**
	 * formLogoURL 
	 * @param  locationId 
	 * @return String 
	 * @descriptoin      
	 */
	global static String formLogoURL(Id locationId)
	{
		Document logoStaticResource = new Document();
		try {
			Dealer_Location__c loc = [SELECT Id, Logo_Name__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1];
			System.assert(loc.Logo_Name__c!=null, 'Location does not contain an associated Logo Name.');

			Document[] docs = [SELECT Id, Name FROM Document WHERE DeveloperName=:loc.Logo_Name__c LIMIT 1];
                if(docs.isEmpty()) {
                    Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
                    String imageId = doc.Id;
                    imageId = imageId.substring(0,15);
                    return 'servlet/servlet.FileDownload?file='+imageId;                     
                } else {
                   logoStaticResource=docs[0]; 
                }
            
			} catch(QueryException e) {
				throw new DealershipLocationAPIException(e.getMessage());
			}

			return 'servlet/servlet.FileDownload?file='+logoStaticResource.Id;
	}
	
	/**
	 * createLocationFees 
	 * @param  dealerLocation 
	 * @param  feeJSON        
	 * @return String
	 * @description               
	 */ 
	public static String createLocationFees(Dealer_Location__c dealerLocation, String feeJSON)
	{
		//get previous JSON and add to it if it exists
		List<Fee> fees = new List<Fee>();
		List<Fee> existingFees = new List<Fee>();
		//try deserialize
		
		Fee newFee = (Fee)Json.Deserialize(feeJSON, Fee.class);
		
		if(dealerLocation.Deal_Fees__c != null)
		 existingFees =(List<Fee>)Json.Deserialize(dealerLocation.Deal_Fees__c, List<Fee>.class);
		
		if(existingFees.size() > 0){
			fees.addAll(existingFees);
			fees.add(newFee);
		}else{
			fees.add(newFee);
		}

		String retJson = '[';
		Integer i = 0;
		for(Fee fee : fees ){
				retJson +=
				'{"feeName": "'+fee.feeName+'","feeDescription": "'+fee.feeDescription+'","feeDefaultAmount": '+fee.feeDefaultAmount+',"feeDefaultOnDeals": '+fee.feeDefaultOnDeals+',"feeTaxable": '+fee.feeTaxable+',"feeCode": "'+fee.feeCode+'","feeDefaultAmountByFormulaField": "'+fee.feeDefaultAmountByFormulaField+'","feeDefaultOnDealsByFormulaField": "'+fee.feeDefaultOnDealsByFormulaField+'"}';

				if(i != fees.size()-1){retJSON +=',';}
				i++;
		}
		retJson+=']';
		dealerLocation.Deal_Fees__c = retJson;

			update dealerLocation;

		return JSON.serializePretty(dealerLocation);
	}
	
	/**
	 * getLocationFees 
	 * @param  LocationId 
	 * @return List<Fee>
	 * @description
	 */ 
	global static List<Fee> getLocationFees(Id LocationId) 
	{

		List<Fee> locationFees = new List<Fee>();

		try {
			String feeString = [SELECT Deal_Fees__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1].Deal_Fees__c;
			locationFees = (List<Fee>)json.Deserialize(feeString, List<Fee>.class);

		} Catch(QueryException e) {
			throw new DealershipLocationAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new DealershipLocationAPIException(e.getMessage());
		}

		return locationFees;
	}
	public static List<AuraFee> getLocationFeesLWC(Id LocationId){
		List<AuraFee> locationFees = new List<AuraFee>();

		try {
			String feeString = [SELECT Deal_Fees__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1].Deal_Fees__c;
			locationFees = (List<AuraFee>)json.Deserialize(feeString, List<AuraFee>.class);

		} Catch(QueryException e) {
			throw new DealershipLocationAPIException(e.getMessage());
		} Catch(Exception e) {
			throw new DealershipLocationAPIException(e.getMessage());
		}

		return locationFees;
	}
	
	/**
	 * editFee 
	 * @param  location 
	 * @param  feeJSON  
	 * @return Dealer_Location__c
	 * @description        
	 */ 
	public static Dealer_Location__c editFee(Dealer_Location__c location, String feeJSON)
	{
		location.Deal_Fees__c = feeJSON;
		update location;
		return location;
	}

	/**
	 * @description
	 */ 
	global List<Fee> Fees = new List<Fee>();
	
	/**
	 * @description
	 */ 
	global class Fee {
		global String  feeName {get;set;}
		global String  feeDescription {get;set;}
		global String  feeCode {get;set;}
		global String  feeDefaultAmountByFormulaField {get;set;}
		global String  feeDefaultOnDealsByFormulaField {get;set;}
		global String  feeDefaultByFormulaField {get;set;}
		global Decimal feeDefaultAmount {get;set;}
		global Boolean feeDefaultOnDeals {get;set;}
		global Boolean feeTaxable {get;set;}
	}
	public List<AuraFee> AuraFee = new List<AuraFee>();
	public class AuraFee {
		@AuraEnabled public String feeName {get;set;}
		@AuraEnabled public String feeDescription {get;set;}
		@AuraEnabled public String feeCode {get;set;}
		@AuraEnabled public String feeDefaultAmountByFormulaField {get;set;}
		@AuraEnabled public String feeDefaultOnDealsByFormulaField {get;set;}
		@AuraEnabled public String feeDefaultByFormulaField {get;set;}
		@AuraEnabled public String feeDefaultAmount {get;set;}
		@AuraEnabled public String feeDefaultOnDeals {get;set;}
		@AuraEnabled public String feeTaxable {get;set;}
	}

	/**
	 * getCoveredSystems 
	 * @param  LocationId 
	 * @return  List<CoveredSystem>   
	 * @description      
	 */
	global static List<CoveredSystem> getCoveredSystems(Id LocationId)
	{
		List<CoveredSystem> coveredSystems = new List<CoveredSystem>();
		try {
			String systemString = [SELECT Buyers_Guide_Covered_Items__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1].Buyers_Guide_Covered_Items__c;
			coveredSystems = (List<CoveredSystem>)json.Deserialize(systemString, List<CoveredSystem>.class);
		} Catch(QueryException e) {
			e.getMessage();
		} Catch(Exception e) {
			e.getMessage();
		}

		return coveredSystems;
	}

	/**
	 * @description
	 */
	global List<CoveredSystem> CoveredSystems = new List<CoveredSystem>();
	
	/**
	 * @description
	 */
	global class CoveredSystem {
		global String  systemCovered {get;set;}
		global String  duration {get;set;}
		global String  warrantyType {get;set;}
	}

	/**
	 * @description
	 */
	global class DealershipLocationAPIException extends Exception {}
}