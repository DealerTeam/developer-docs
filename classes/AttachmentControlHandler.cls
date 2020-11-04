/**
 * AttachmentControl - Domain Layer Trigger Handler
 * @test PartPhysicalInventoryDomainLayer.testDeleteAttachmentPartsPhysical
 * @description
 */
public with sharing class AttachmentControlHandler {
    
    /**
     * handleBeforeDelete description
     * @param  oldAttachmentsMap 
     * @return void
     * @description Prevent delete attachments from PartPhysicalInventory__c records
     */
    public void handleBeforeDelete(Map<ID,Attachment> oldAttachmentsMap)
    {

        List<Attachment> attList = [SELECT Id, Name FROM Attachment WHERE (Name = 'VarianceReport.pdf' OR Name = 'PartsPhysicalPost.csv') AND
                                    Parent.Type = 'dealer__PartPhysicalInventory__c' and Id IN: oldAttachmentsMap.keySet() ];
		
        if(!attList.isEmpty()){
            
            for(Attachment a: attList){
                Attachment actualRecord = oldAttachmentsMap.get(a.Id); 
                actualRecord.addError('Part Physical Inventory attachments cannot be deleted');
            }
        }
        
    }

}