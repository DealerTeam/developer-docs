@isTest
private class ChangeContactAccountOwnerOnCarDeal_TC {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
        EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
      
        Contact Con=new Contact(FirstName='Test',LastName='Test');
        Account Acc=new Account(Name='test');
        insert Acc;
        insert Con;
        insert u;
        Deal__c d=new Deal__c(dealer__Deal_ID__c='1239',Salesperson_1__c=u.id,Salesperson_2__c=u.id,Buyer_Contact__c=con.id,dealer__Buyer__c=Acc.id);
        insert d;
        List<Deal__c> dealList =new List<Deal__c>();
        dealList.add(d);
        string batch = 'select id,ownerId,Owner.Name,Salesperson_1__c,Salesperson_2__c,Buyer_Contact__c,dealer__Buyer__c from Deal__c where Salesperson_1__c != null OR Salesperson_2__c != null';
        ChangeContactAccountOwnerOnCarDeal test = new ChangeContactAccountOwnerOnCarDeal(batch);
        test.ContactsOwners.put(Con.Id,d.Salesperson_1__c);
        test.AccountOwners.put(Acc.Id,d.Salesperson_1__c);
        test.consList.add(Con.Id);
        test.AccsList.add(Acc.Id);
        test.updateOwners(test.ContactsOwners,test.AccountOwners);
        ChangeContactAccountOwnerOnCarDeal_Batch.execute();
        ID batchprocessID=Database.executeBatch(new ChangeContactAccountOwnerOnCarDeal('select id,ownerId,Salesperson_1__c,Salesperson_2__c,Buyer_Contact__c,Buyer__c from Deal__c where Salesperson_1__c != null OR Salesperson_2__c != null limit 1'),1);
        Database.BatchableContext bc;
        test.start(BC);
        test.execute(bc,dealList);
        test.finish(bc);
    }
}