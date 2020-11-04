public class Form_BuyersGuideController {

	public Vehicle_Inventory__c getVehicleInventory(){
		Id recordId = (Id)ApexPages.currentPage().getParameters().get('Id');
		system.debug(recordId);
		return [SELECT Id, Name, Year__c, Make__c, Model__c, VIN__c, 
				Store_Location__r.Street__c, Store_Location__r.City__c, Store_Location__r.Name,
				Store_Location__r.State__c, Store_Location__r.Postal_Code__c, Store_Location__r.Main_Phone__c,
				Store_Location__r.Buyers_Guide_Covered_Items__c, Store_Location__r.BuyersGuideDuration__c,
				Store_Location__r.BuyersGuideLaborPercent__c, Store_Location__r.BuyersGuidePartsPercent__c,
				Store_Location__r.BuyersGuideCoveredItemsSpanish__c, Store_Location__r.BuyersGuideDurationSpanish__c
				FROM Vehicle_Inventory__c WHERE Id=:recordId];
	}
	public String getWarrantyType(){
		system.debug( ApexPages.currentPage().getParameters().get('warrantyType'));
		return ApexPages.currentPage().getParameters().get('warrantyType');
	}
	public String getDealerWarrantyType(){
		return ApexPages.currentPage().getParameters().get('dealerWarrantyType');
	}
	public String getNonDealerWarrantyType(){
		return ApexPages.currentPage().getParameters().get('nonDealerWarrantyType');
	}	
	public Boolean getIncludesServiceContract(){
		return (ApexPages.currentPage().getParameters().get('includesServiceContract') != null) ? true : false;
	}
	public Boolean getIncludeSecondPage(){
		return (ApexPages.currentPage().getParameters().get('includesSecondPage') != null) ? true : false;
	}
}