global with sharing class SchedulableOutboundFileTransfer implements Schedulable{
    global void execute(SchedulableContext sc) 
	{
        List<OFTJob__c> ofts = [SELECT Id, DestinationFileName__c, ExportFileType__c, Password__c, Port__c, SOQLStatement__c, TransportProtocol__c, URN__c, Username__c FROM OFTJob__c WHERE Active__c = true];
        List<OFTJob__c> pendingOFTs = new List<OFTJob__c>();
        for(OFTJob__c o : ofts){
            o.LastRunStatus__c = 'In Progress'; 
            o.LastRunResults__c = '';
            pendingOFTs.add(o);
        }
        if(pendingOFTs.size() > 0){
            update pendingOFTs;
        }
        OutboundFileTransferAPI.futureCallout(null);
	}
}