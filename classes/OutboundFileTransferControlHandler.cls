public with sharing class OutboundFileTransferControlHandler {
    public static void updateLastRun(List<OFTJob__c> triggerNew, Map<Id, OFTJob__c> triggerOldMap) {
        for(OFTJob__c o : triggerNew){
            //Check if update is result of job running
            if(o.LastRunStatus__c != null && o.LastRunStatus__c != 'In Progress' && o.LastRunStatus__c != triggerOldMap.get(o.Id).LastRunStatus__c){
                o.LastRunDate__c = System.now();
            }
        }
    }

    public static void validateQuery(List<OFTJob__c> triggerNew, Map<Id, OFTJob__c> triggerOldMap){
        List<OFTJob__c> ofts = new List<OFTJob__c>();
        //Skip filtering if insert
        if(triggerOldMap == null){
            ofts = triggerNew;
        }
        else{
            for(OFTJob__c o : triggerNew){
                if(o.SOQLStatement__c != null && o.SOQLStatement__c != triggerOldMap.get(o.Id).SOQLStatement__c){
                    ofts.add(o);
                }
            }
        }
        if(ofts.size() > 0){
            for(OFTJob__c o : ofts){
                String query = o.SOQLStatement__c;
                String modifiedQuery;
                if(query.indexOf(' LIMIT') == -1){
                    modifiedQuery = query + ' LIMIT 1';
                }
                else{
                    modifiedQuery = query.substring(0, query.indexOf(' LIMIT')-1) + ' LIMIT 1';
                }
                try{
                    system.debug(modifiedQuery);
                    List<SObject> validationList = Database.query(modifiedQuery);   
                } catch(QueryException e){
                    o.addError('Invalid SOQL Statement: ' + e);
                }
            }
        }
    }

    public static void validatePermission(List<OFTJob__c> triggerNew){
        Boolean hasPerm = Utility.hasCustomPermission('UpdateOutboundFileTransfer');
        if(hasPerm == false){
            OFTJob__c job = triggerNew[0];
            job.addError('User is not authorized to update Outbound File Transfers. Please contact your administrator to have this feature enabled.');
        }
    }
}