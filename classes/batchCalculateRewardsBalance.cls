/**
 * batchCalculateRewardsBalance
 * @description
 */ 
@deprecated
global with sharing class batchCalculateRewardsBalance implements Database.Batchable<sObject> {

  /**
   * start 
   * @param  BC 
   * @return Database.QueryLocator 
   * @description
   */ 
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
    String query = 'Select d.dealer__Funds_Expired__c, d.dealer__Funds_Expiration_Processed__c, d.dealer__Funds_Expiration_Date__c, d.Id From dealer__Reward_Transaction__c d where d.dealer__Funds_Expired__c = true and d.dealer__Funds_Expiration_Processed__c = null';
    return Database.getQueryLocator(query);   
  }
 
  /**
   * execute 
   * @param  BC   
   * @param  scope 
   * @return void
   * @description
   */ 
  global void execute(Database.BatchableContext BC, List<sObject> scope)
  {   
    List<dealer__Reward_Transaction__c> rt = new List<dealer__Reward_Transaction__c>();
      System.debug('Size of Rewards Transactions to Expire '+scope.size());
      for(sObject s : scope) {
          dealer__Reward_Transaction__c rtr = (dealer__Reward_Transaction__c)s;
          rtr.dealer__Funds_Expiration_Processed__c=Date.today();
          rt.add(rtr);
      }
      update rt;
  }
 
  /**
   * finish 
   * @param  BC 
   * @return void
   * @description
   */ 
  global void finish(Database.BatchableContext BC)
  {
      System.debug('Batch Process Complete');
  }   
}