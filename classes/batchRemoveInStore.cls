/**
 * batchRemoveInStore
 * @description
 */ 
global with sharing class batchRemoveInStore implements Database.Batchable<sObject> {
  private String sObjectName;
  
  /**
   * batchRemoveInStore 
   * @param  sObjectName 
   * @description            
   */ 
  global batchRemoveInStore(String sObjectName) 
  {
    this.sObjectName = sObjectName;
  }
 
  /**
   * start 
   * @param  BC 
   * @description
   */ 
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
    String query = 'SELECT Id, dealer__In_Store__c FROM dealer__Sales_Up__c where dealer__In_Store__c = true';
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
    List<dealer__Sales_Up__c> sup = new List<dealer__Sales_Up__c>();
      for(sObject s : scope) {
          dealer__Sales_Up__c up = (dealer__Sales_Up__c)s;
          up.dealer__In_Store__c = false;
          sup.add(up);
      }
      update sup;
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