global with sharing class SchedulableInventoryMedia implements Schedulable{
    global void execute(SchedulableContext sc) 
    {       
        InventoryMediaAPI.processExternalMediaUpload();
    }
}