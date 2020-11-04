/**		
 * 		Handler for ServiceMiscChargeControl trigger
 * 		Updates Job Line Totals
 **/
public class ServiceMiscChargeControlHandler {
    
    /**
     * 	Insert / Update context
     * 	@param dealer__Service_Misc_Charge__c new map
     **/
    public void handleInsertUpdate(Map<Id, dealer__Service_Misc_Charge__c> svcMiscChargeMap){
        
         // Post run update List
        Map<Id, Service_Job__c> jobs = new Map<Id, Service_Job__c>();
        AggregateResult[] ar = [SELECT Service_Job_Lines__c,
                                    SUM(Amount__c) smamt
                                    FROM Service_Misc_Charge__c 
                                    WHERE Id IN:svcMiscChargeMap.keyset()
                                    GROUP BY Service_Job_Lines__c];
        
        for(AggregateResult arv : ar) {
            // Set the jobmap
            jobs.put(
                (Id)arv.get('dealer__Service_Job_Lines__c'),
                new Service_Job__c(
                    Id=(Id)arv.get('dealer__Service_Job_Lines__c'),
                    Misc_Charges__c=(Decimal)arv.get('smamt')
                )
            );
        }

        // If we have records to process, execute updates
        if(!jobs.isEmpty()) {
            
            try{
            	update jobs.values();
            }catch(Exception e){
                e.getMessage();
            }
        }
    }
    
    /**
     * 	Delete context
     * 	@param dealer__Service_Misc_Charge__c old list
     **/
    public void handleDelete(List<dealer__Service_Misc_Charge__c> oldSvcMiscChargeList){
        
         // Post run update List
        Map<Id, Service_Job__c> jobs = new Map<Id, Service_Job__c>();

        // Job Lines from oldMap 
        Set<Id> jobLines = new set<Id>();
        for(Service_Misc_Charge__c sm : oldSvcMiscChargeList) {
            if(!jobLines.contains(sm.Service_Job_Lines__c))
                jobLines.add(sm.Service_Job_Lines__c);
        }

        AggregateResult[] ar = [SELECT Service_Job_Lines__c,
                                        SUM(Amount__c) smamt
                                        FROM Service_Misc_Charge__c 
                                        WHERE Service_Job_Lines__c IN:jobLines
                                        GROUP BY Service_Job_Lines__c];

        // AR Could be Empty, This happens if all misc lines are deleted.
        // this loop is iterating all lines, if any are picked up in the next loop then all should be valid
        for(Id jli : jobLines) {
            jobs.put(
                jli,
                new Service_Job__c(
                    Id=jli,
                    Misc_Charges__c=0
                )
            );
        }

        // AR populated, more than one misc. on related lines. 
        for(AggregateResult arv : ar) {
            // Set the jobmap
            jobs.put(
                (Id)arv.get('dealer__Service_Job_Lines__c'),
                new Service_Job__c(
                    Id=(Id)arv.get('dealer__Service_Job_Lines__c'),
                    Misc_Charges__c=(Decimal)arv.get('smamt')
                )
            );
        }

        // If we have records to process, execute updates
        System.debug(jobs);
        System.debug(ar);
        System.debug(jobLines);
        if(!jobs.isEmpty()) {
            try{
            	update jobs.values();
            }catch(Exception e){
                e.getMessage();
            }
        }  
    }

}