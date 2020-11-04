public with sharing class Inspection_Report_EXT{
 	
	// private final dealer__Inspection_Report__c mpi;
    
    public dealer__Inspection_Report__c mpi;
    
    public string mpi_id {get;set;}
        
    public Inspection_Report_EXT(ApexPages.StandardController controller) {
    	mpi = (dealer__Inspection_Report__c)controller.getRecord();
    	this.mpi_id = mpi.Id;
    }

}