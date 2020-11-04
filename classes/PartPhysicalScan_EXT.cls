public with sharing class PartPhysicalScan_EXT {
    // Init
    public String searchInput {get;set;}
    public String searchEmpty {get;set;}
    public Integer itemCount {get;set;}
    public Boolean pageError {get; set;}

    public PartsPhysicalDetail__c physicalDetailRecord {get;set;}
    public List<PartsPhysicalDetail__c> pdresults {get;set;}
	
    public PartPhysicalScan_EXT(ApexPages.StandardController sc) {
        resetSearch();
    }
    
    public PageReference returnToPhsyicalInventory() {
        PageReference pr = new ApexPages.StandardController(physicalDetailRecord).view();
        pr.setRedirect(true);
        return pr;
     }
    
    public PageReference returnToPhsyicalInventoryTab() {
        
        PageReference pr = new PageReference('/'+PartPhysicalInventory__c.sobjecttype.getDescribe().getKeyPrefix());
        pr.setRedirect(true);
        return pr;
        
    }
    
    public PageReference saveRow() {
        
        try {
            update new PartsPhysicalDetail__c(Id=physicalDetailRecord.Id, Count__c=itemCount);
			resetSearch();
        } Catch(DmlException e) {
            // Add Error Message Here
        }
        return null;
    }
    
    public PageReference searchPart() {
        System.debug(searchInput);
        String searchInputLike = '%'+searchInput+'%';
        try {
        	pdresults = [SELECT dealer__Parts_Physical_Inventory__c, dealer__Bin__c, dealer__Cost__c, dealer__Count_Variance__c, dealer__Count__c, 
                                	dealer__Description__c, dealer__Initial_Quantity__c, dealer__Net__c, dealer__Part__c, dealer__Variance_Count_1__c, 
                                	dealer__Variance_Value__c, dealer__Variance__c, dealer__Write_In__c, dealer__Notes__c, dealer__General_Ledger_Variance_Value__c, 
                                	Name, Id,
                         			dealer__Part__r.dealer__Parts_Master__r.dealer__Part_No__c, 
                         			dealer__Part__r.dealer__Parts_Master__r.Name,
                         			dealer__Part__r.dealer__Parts_Master__r.dealer__Part_Description__c,
                         			dealer__Part__r.dealer__Parts_Master__r.dealer__UPC__c
                                FROM dealer__PartsPhysicalDetail__c
                                WHERE dealer__Part__r.dealer__Parts_Master__r.Name LIKE :searchInputLike 
                                	OR dealer__Part__r.dealer__Parts_Master__r.dealer__UPC__c LIKE :searchInputLike
                         			OR dealer__Part__r.dealer__Parts_Master__r.dealer__Part_No__c LIKE :searchInputLike
                                LIMIT 25];
          	System.debug(pdresults);
            
            if(pdresults.size()>=1) {
                pageError=false;
                physicalDetailRecord = pdresults[0];
            }
                            
        } Catch(QueryException e) {
            System.debug(e.getMessage());
            pageError=true;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No Results Found')); 

            searchEmpty = 'No results found for '+searchInput;
        }
		return null;
    }
    
    public void resetSearch() {
        searchInput = null;
        itemCount = null;
        searchEmpty = null;
        pdresults = new List<PartsPhysicalDetail__c>();
        physicalDetailRecord = new PartsPhysicalDetail__c();         
    }
    
}