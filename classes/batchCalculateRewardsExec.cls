/**
 * batchCalculateRewardsExec
 * @description
 */ 
@deprecated
global with sharing class batchCalculateRewardsExec implements Schedulable {
  
  /**
   * execute 
   * @param  sc 
   * @return void
   * @description
   */ 
  global void execute(SchedulableContext sc) 
  {
    batchCalculateRewardsBalance br = new batchCalculateRewardsBalance();
    ID batchprocessID = Database.executeBatch(br);
  }
}