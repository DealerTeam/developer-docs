/**
 * MergePartMasterController
 * @test PartPhysicalInventoryServiceLayer.testMergePartMaster
 * @description Controller for MergePartMaster.page to retrieve Part Master information and to merge duplicate Part Master records.
 */
public with sharing class MergePartMasterController {

    /**
     * @description
     */ 
    List<dealer__Parts_Master__c> ListPM {get; set;}
    
    /**
     * @description
     */
    public string MasterRec{get;set;}

    /**
     * MergePartMasterController 
     * @param  controller 
     * @description
     */
    public MergePartMasterController(ApexPages.StandardSetController controller) 
    {
        ListPM = controller.getSelected();
        system.debug('ListPM >>'+ListPM);

        if(ListPM.size() > 3 || ListPM.size() <2)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please select 2 or 3 Part Master records for merge.'));            
        }
    }

    /**
     * getPartMaster 
     * @return List<dealer__Parts_Master__c>
     * @description
     */
    public List<dealer__Parts_Master__c> getPartMaster() 
    {
        
        return MergePartMasterAPI.getPartMaster(ListPM);
    }

    //Map to store Parts data for each Part Master
    
    /**
     * getPartLocOnhand 
     * @return map<id,List<dealer__Parts_Inventory__c>>
     * @description
     */ 
    public map<id,List<dealer__Parts_Inventory__c>> getPartLocOnhand() 
    {

        return MergePartMasterAPI.getPartLocOnhand(ListPM);
    }

    //Method to perform perform merge activity 
    
    /**
     * mergeRecord description
     * @return pageReference
     * @description
     */
    public pageReference mergeRecord()
    {
        try{
            if(MergePartMasterAPI.mergeRecord(ListPM, MasterRec))
            {
                PageReference PmPage = new PageReference('/'+MasterRec);
                return PmPage;                
            }
        }
        catch(Exception e)
        {   
            system.debug('Exception >>'+ e.getMessage() + e.getLineNumber());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Exception >>'+ e.getMessage() +' Line #:'+ e.getLineNumber()));
        }
        return null;
    }

    /**
     * goBack 
     * @return pageReference
     * @description
     */
    public pageReference goBack()
    {
        PageReference PmPage = new PageReference('/'+ApexPages.currentPage().getParameters().get('retURL'));
        return PmPage; 
    }

}