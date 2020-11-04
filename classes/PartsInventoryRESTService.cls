@RestResource(urlMapping='/Part/Inventory/*')
global with sharing class PartsInventoryRESTService {
	@HttpGet
	global static List<Parts_Inventory__c> getParts() {
		String companyNumber = null;
		String mfg = null;
		RestRequest request = RestContext.request;
		
			String rUrl = request.requestURI.substring(
				request.requestURI.lastIndexOf('Inventory/')+10);

			String[] params = rUrl.split('/');
			companyNumber = (params[0] == null) ? null : params[0];
			if(params.size() == 2)
			mfg = (params[1] == null) ? null : params[1];
		if(companyNumber == null){
				return null;//Must include location number in get call!
				}else{
					List<Id> locationIds = new List<Id>();
					for(Dealer_Location__c location : [SELECT Id FROM Dealer_Location__c WHERE Company_Number__c=: companyNumber LIMIT 1]){
						locationIds.add(location.Id);
					}
					if(locationIds.size()==0){
					return null;//location doesn't exist!
				}
				if(mfg==null){
					return PartAPI.readInventory(locationIds);
				}
				if(mfg!=null){
					return PartAPI.readInventory(locationIds, mfg);
				}
			}
			return null;
		}  
	}