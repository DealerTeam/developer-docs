/**
 * ChangeContactAccountOwnerOnCarDeal_Batch
 * @description
 */
global class ChangeContactAccountOwnerOnCarDeal_Batch{
   /**
    * execute description
    * @return void
    * @description
    */ 
   global static void execute() {
        ID batchprocessID=Database.executeBatch(new ChangeContactAccountOwnerOnCarDeal('select id,ownerId,Salesperson_1__c,Salesperson_2__c,Buyer_Contact__c,Buyer__c from Deal__c where Salesperson_1__c != null OR Salesperson_2__c != null'),100);
   }
}