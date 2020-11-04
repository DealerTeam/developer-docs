/**
 * CarDealsActivityBatchable
 * @description
 */ 
global with sharing class CarDealsActivityBatchable implements Schedulable
{
    /**
     * execute d
     * @param sc 
     * @return void
     * @description
     */ 
    global void execute(SchedulableContext sc) 
    {
      String CarDealList = 'select dealer__Buyer_Contact__r.OwnerID,id, dealer__Deal_Date__c, LastActivityDate from Dealer__Deal__c where dealer__Buyer_Contact__c!=null and (LastActivitydate=n_days_ago:90 or dealer__Deal_Date__c=n_days_ago:90)';
      Id batchInstanceIdPrescriber = Database.executeBatch(new CarDealsActivity(CarDealList), 200); 
      System.Debug('Batch ID is:'+batchInstanceIdPrescriber);
    }

}