/**
 * BatchCompletePhysical
 * @description
 */ 
global with sharing class BatchCompletePhysical implements Database.Batchable<sObject>{

    /**
     * @description
     */ 
    global final String query;
    
    /**
     * BatchCompletePhysical 
     * @param  q 
     * @description
     */
    global BatchCompletePhysical(String q)
    {
        query = q; 
    }
    
    /**
     * start 
     * @param  BC 
     * @description
     */ 
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
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
        for(sobject s : scope){
        }
    }
    
    /**
     * finish 
     * @param  BC 
     * @return void
     * @description
     */ 
    global void finish(Database.BatchableContext BC)
    {
    }
}