/**
 * CarDealsActivity 
 * @description
 */ 
global with sharing class CarDealsActivity implements Database.Batchable<sobject>{
    global final string Query;
    
    /**
     * CarDealsActivity
     * @param  q 
     * @description
     */ 
    global CarDealsActivity(string q)
    { 
     Query = q;
    }
    
    /**
     * start 
     * @param  BC
     * @description
     */
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator (query);
    }
    
    /**
     * execute description
     * @param  BC              
     * @param  prescriberScope 
     * @return void
     * @description
     */ 
    global void execute(Database.BatchableContext BC,List<sobject> prescriberScope)
    {
           Set<ID> CarID=new set<ID>();
           for(sobject S:prescriberScope){
            CarID.add(S.ID);
           }
           List<Dealer__Deal__c> CarDeals=[Select dealer__Buyer_Contact__c, dealer__Buyer_Contact__r.OwnerID,id from Dealer__Deal__c where ID in:carID];
           List<Task> InsertTask=new List<Task>();
           for(Dealer__Deal__c S:CarDeals){
                Task t=new Task();
                t.Subject='Every 90 day customer contact';
                t.ActivityDate=System.today();
                t.Description='';
                t.WhoId=s.dealer__Buyer_Contact__c;
                t.WhatId=s.Id;
                t.ownerID=s.dealer__Buyer_Contact__r.OwnerID;
                InsertTask.add(t);
           }
           insert InsertTask;
           //System.debug('>>'+InsertTask);
               
       }
        global void finish(Database.BatchableCOntext BC){
    }

}