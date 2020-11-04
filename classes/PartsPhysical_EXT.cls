/**
*
*   PartsPhysical_EXT - Controller Extension to create and perform the physical inventory process
*   @test PartPhysicalInventoryServiceLayer.testPartsMasterTriggerHandler
*       dealer__PartsPhysicalInvenotry__c - Light object, no sharing or bulk API Access      
*       dealer__PartsPhysicalDetail - records of each part that is part of the physical 
*          (this can be the entire location inventory, specific Bin locations or a periodical / 
*           random selection of parts)
*
*       General Steps to a Physical are as follows.
*
*           1) General the physical file based on type - location, bin, dollar or random. 
*                Or part# Sequence.  (Zero quantity suppressed)
*           2) Prepare the Count Sheets for Print / Or Scan
*           3) Perform the Physical (non software)
*           4) Process the count sheets - hand enter the values or process the scanner files
*           5) Enter any hand writes - parts found that do not have a record in the system
*           6) Variance Report on the values that the hand count differs from the inventory count.
*           7) Variance Report on the Cost differential betwen the current master and FIFO Value - Optional Step
*           8) Post the Variance, update the General Ledger and Post the updated Quantity to the Inventory
*           9) Prepare the physical audit report and attach to the Physical.
* 2016.08.30       |Gaurav               |Case# 00002013
* Added code coverage for part master description change
*
* 2016.09.23       |Gaurav               |Case# 00002007
* Added Notes field in query of Parts Physical Detail object's records
*
* 2017.01.13       |Gaurav               |W-000892
* Added code to add Parts using Batch class and moved the logic into PartsPhysicalInventoryAPI class
*/
global class PartsPhysical_EXT {

    public dealer__PartPhysicalInventory__c ppi{get;set;}

    public String physicalType {get;set;}
    public Decimal dollarValue {get;set;}
    public String binLocations {get;set;}
    public dealer__Dealer_Location__c loc {get;set;}
    public Id batchId{get;set;}
    public List<AsyncApexJob> jobs{get;set;}
    public boolean isBatchRunning{get;set;}
    public string progress{get;set;}           
    public List<dealer__PartsPhysicalDetail__c> detail_records {get;set;}
    
    public PartsPhysical_EXT(ApexPages.StandardController c) {
        
        jobs = new List<AsyncApexJob>();
        isBatchRunning = false;
        progress = '0%'; 
        
        // Get all requested fields
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__PartPhysicalInventory__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.add('dealer__Location__r.dealer__Company_Number__c');
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
                c.addFields(af);
        }
        ppi = (dealer__PartPhysicalInventory__c)c.getRecord();  

        if(ppi.Id!=null) {
            detail_records = PartsPhysicalInventoryAPI.loadDetailRecords(ppi.Id);
        }
    }

    //Create new Physical Inventory Header Record
    public PageReference newPhysicalInventory() {

        // Set the Transaction Control Required
        SavePoint sp = Database.setSavePoint();

        // Get the location record based on the company input
        dealer__Dealer_Location__c location = [Select Id, Name, dealer__Company_Number__c from dealer__Dealer_Location__c where Id=:ppi.dealer__Location__c limit 1];

        loc=location;
        
        //Set the record name
        Date d = Date.today();
        ppi.Name = location.dealer__Company_Number__c+'-'+String.valueOf(d.year())+'-'+String.valueOf(d.month());
        ppi.dealer__Status__c='Not Started';

        //Ensure that there is not an open physical for this location
        dealer__PartPhysicalInventory__c[] sizeOfOpen = [Select Id, Name, dealer__Status__c from dealer__PartPhysicalInventory__c where dealer__Location__c=:ppi.dealer__Location__c and dealer__Status__c != 'Complete' limit 500];
        if(sizeOfOpen.size()>0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to open a new Physical workfile, this location has an open physical in process.'));
            return null;            
        }

        try {

            insert ppi;
            
            physicalInventory(ppi);

        } Catch(DmlException e) {

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failed to Delete Physical '+e.getMessage()));

            // Rollback the transaction
            Database.Rollback(sp);
            return null;            
        }
        return null;        
    }

    /**
     * Create the physical file and lock the remaining inventory for that store.  When the physical inventory is created it essentially
     * makes a copy of the active inventory for that location.  All physical assesment of that inventory is applied to the records in 
     * this copy.
    **/
    private void physicalInventory(dealer__PartPhysicalInventory__c objPPI) {
        
        PartLocationMigrate pl = new PartLocationMigrate(objPPI);
        batchId = database.executeBatch(pl,200);        
        //W-000892
        getBatchStatus();
    }
    
    /* W-000892 Begin*/
    //Method to get the status of Batch class execution
    public Pagereference getBatchStatus(){
         if(batchId!=null)
             jobs = new List<AsyncApexJob>([select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, Id, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob where jobType='BatchApex' and Id = :batchId]);     
         else
             jobs = new List<AsyncApexJob>([select TotalJobItems, Status, NumberOfErrors, MethodName, JobType, JobItemsProcessed, ExtendedStatus, Id, CreatedDate, CreatedById, CompletedDate, ApexClassId, ApexClass.Name From AsyncApexJob WHERE JobType='BatchApex' and Status in ('Queued', 'Preparing', 'Processing') order by CreatedDate desc limit 1]);         
    
         Integer perComplete = 0;

         if(jobs.size()>0){
             batchId = jobs[0].id;
             isBatchRunning = true;                        
             if(jobs[0].TotalJobItems!=0)
                 perComplete = ((jobs[0].JobItemsProcessed  / Double.valueOf(jobs[0].TotalJobItems)) * 100.0).intValue();
             progress = perComplete+'%'; 
             if(jobs[0].Status=='Completed') 
                 progress = '100%';                 
             
             if(jobs[0].Status=='Failed' || jobs[0].Status=='Completed' || jobs[0].Status=='Aborted')
                 isBatchRunning = false;                 
         }
         return null;
    }    
    
    public PageReference redirectPage(){
        PageReference pg = new PageReference('/'+ppi.Id);
        return pg;
    }
    
    //Post the count sheets to the detail page.
    public PageReference saveCounts() {
        return PartsPhysicalInventoryAPI.saveCountApiMethod(detail_records, ppi);
    }

    //Calculate the physical variance on these parts 
    // Deprecated 2017-02-25 * Added stateful value to detail record and roll-up on header    
    // public Decimal getGLVariance() {
    //     return PartsPhysicalInventoryAPI.GLVariance(ppi.Id);
    // }

    //publish the physical to the inventory
    public PageReference completePhysical () {
        return PartsPhysicalInventoryAPI.completePhysicalAPIMethod(ppi);
    }

    public List<SelectOption> getPhyscialTypeOptions() {
        return PartsPhysicalInventoryAPI.PhyscialTypeOptions();
    }  
    
    /* W-000892 End*/ 
}