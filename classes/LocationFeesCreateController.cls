/**
 * LocationFeesCreateController
 * @description
 */
public with sharing class LocationFeesCreateController {

	/**
	 * getLocations description
	 * @return List<Dealer_Location__c>
	 * @description
	 */ 
	@AuraEnabled
	public static List<Dealer_Location__c> getLocations()
	{
		return [SELECT Id, Name, Company_Number__c FROM Dealer_Location__c];
	}
	
	/**
	 * doCreateFee
	 * @param  locationId 
	 * @param  feeJSON    
	 * @return String
	 * @description
	 */ 
	@AuraEnabled 
	public static String doCreateFee(Id locationId, String feeJSON)
	{	
		Dealer_Location__c location = [SELECT Id, Deal_Fees__c FROM Dealer_Location__c WHERE Id=:locationId];
		try{
			DealershipLocationAPI.Fee newFee = (DealershipLocationAPI.Fee)Json.Deserialize(feeJSON, DealershipLocationAPI.Fee.class);
			return DealershipLocationAPI.createLocationFees(location,feeJSON);
		} catch(DMLException e){
			throw new AuraHandledException(e.getMessage());
		} catch(JSONException e){
			System.debug('JSON EXCEPTION: '+e.getMessage());
			throw new AuraHandledException('ERROR: Malformed JSON. Please see your administrator');
		}
	}
	
	/**
	 * getLocationFees 
	 * @param  locationId 
	 * @return Dealer_Location__c
	 * @description
	 */
	@AuraEnabled
	public static Dealer_Location__c getLocationFees(Id locationId)
	{
		return [SELECT Name, Deal_Fees__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1];
	}

    @AuraEnabled(cacheable=true)
    public static LocationFees getFeeData(String locId) 
    {
        return new LocationFees(locId);
    }

    @AuraEnabled(cacheable=true)
    public static String getTabUrl(String sobjectName){
        return DealerMetadata.getObjectTabUrl(sobjectName);
	}
	
	@AuraEnabled
	public static string getTabURLSync(String sobjectName){
        return DealerMetadata.getObjectTabUrl(sobjectName);
	}

    /**
     * @description Nested wrapper class
     */
    public class LocationFees {

        /** @description List of form sobjects available for printing */
        @AuraEnabled public List<FeeMaster__c> availableFees {get;set;}
        
        /** @description List of form reference of selected forms */
        @AuraEnabled public List<LocationFee__c> selectedFees {get;set;}

        public LocationFees(String locId){
           
            LocationFee__c [] sFees = [SELECT Id, Name, DefaultPrice__c, FeeCode__c, InvoiceType__c, Taxable__c, Printable__c, Description__c, DefaultCost__c, FeeMaster__c FROM LocationFee__c WHERE Location__c =: locId];
           
            set<Id> selectedIds = new Set<Id>();
            for(LocationFee__c f : sFees){
                selectedIds.add(f.FeeMaster__c);
            }

            FeeMaster__c [] aFees = [SELECT Id, Name, DefaultPrice__c, DefaultCost__c, InvoiceType__c, Description__c, Printable__c, FeeCode__c, Active__c FROM FeeMaster__c where Active__c = true AND Id NOT IN: selectedIds];
            
            this.availableFees = aFees;
            this.selectedFees = sFees;
        }
    } 
	
	
	/**
	 * saveEdit 
	 * @param  locationId 
	 * @param  feeJSON  
	 * @return Dealer_Location__c
	 * @description
	 */
	@AuraEnabled
	public static Dealer_Location__c saveEdit(Id locationId, String feeJSON)
	{
		Dealer_Location__c location = [SELECT Id, Deal_Fees__c FROM Dealer_Location__c WHERE Id=:locationId];
		try{
			List<DealershipLocationAPI.Fee> newFee = (List<DealershipLocationAPI.Fee>)Json.Deserialize(feeJSON, List<DealershipLocationAPI.Fee>.class);
			return DealershipLocationAPI.editFee(location, feeJSON);
		} catch(DMLException e){
			throw new AuraHandledException(e.getMessage());
		} catch(JSONException e){
			System.debug('JSON EXCEPTION: '+e.getMessage());
			throw new AuraHandledException('ERROR: Malformed JSON. Please see your administrator');
		}
	}

	@AuraEnabled(cacheable=true)
	public static LocationAssignment getLocationAssignment(String feeMasterId){
		return new LocationAssignment(feeMasterId);
	}

	@AuraEnabled
	public static void deleteLocationFeeFromMaster(String feeMasterId, String locationId){
		LocationFee__c [] fees = [SELECT Id FROM LocationFee__c WHERE Location__c =: locationid AND FeeMaster__c =: feeMasterId];
		if(fees.size() > 0){
			delete fees;
		}
	}


	public class LocationAssignment{
		@AuraEnabled public FeeMaster__c feeMaster;
		@AuraEnabled public List<Dealer_Location__c> availableLocations;
		@AuraEnabled public List<Dealer_Location__c> selectedLocations;
		public LocationAssignment(String feeMasterId){

			
			Map<Id, Dealer_Location__c> selectedLocationMap = new Map<Id, Dealer_Location__c>();
			for(LocationFee__c fm : [SELECT Id, Location__c, FeeMaster__c, Location__r.Name, Location__r.Company_Number__c FROM LocationFee__c WHERE FeeMaster__c =: feeMasterId ]){
				if(fm.Location__c != null)
					selectedLocationMap.put(fm.Location__c, fm.Location__r);
			}

			Dealer_Location__c [] availableLocations = [SELECT Id, Name, Company_Number__c FROM Dealer_Location__c WHERE Id NOT IN :selectedLocationMap.keySet()];

			this.feeMaster = [SELECT Id, Name, DefaultPrice__c, Taxable__c, DefaultCost__c, InvoiceType__c, Description__c, FeeCode__c, Active__c FROM FeeMaster__c where Id=: feeMasterId];
			this.availableLocations = availableLocations;
			this.selectedLocations = selectedLocationMap.Values().size()>0 ? selectedLocationMap.Values() : new List<Dealer_Location__c>();
			
		}
	}

}