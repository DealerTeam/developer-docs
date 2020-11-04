/**
 * batchRemoveInStoreExec
 * @description
 */ 
global with sharing class batchRemoveInStoreExec implements Schedulable {
  
  /**
   * execute description
   * @param  sc 
   * @return void
   * @description
   */ 
  global void execute(SchedulableContext sc) 
  {
    batchRemoveInStore bremove = new batchRemoveInStore('dealer__Sales_Up__c');
    ID batchprocessID = Database.executeBatch(bremove, 1);
  }
}