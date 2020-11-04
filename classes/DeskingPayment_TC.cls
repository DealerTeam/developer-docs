@isTest(seeAllData = true)
Public Class DeskingPayment_TC{
    Static testmethod Void Myunittest(){
    
        Contact Con=new Contact(FirstName='Test',LastName='Test',OwnerID=userinfo.getUserId());
        insert Con;
        dealer__Deal__c deal = new dealer__Deal__c(OwnerID=userinfo.getUserId(),dealer__Deal_ID__c='A1234XX',dealer__Buyer_Contact__c=con.ID,dealer__Deal_Date__c=System.today().adddays(-90));
        insert deal;
        
        dealer__Deal_Payment__c dp = new dealer__Deal_Payment__c();
        
        dp.dealer__Car_Deal__c=deal.id;
        dp.dealer__Due_Date__c=system.today().addDays(10);
        dp.dealer__Amount__c = 100;
        
        insert dp;
        
        ApexPages.CurrentPage().getParameters().put('dealId',deal.id );
        
        ApexPages.StandardController sc = new ApexPages.StandardController(dp);
        ApexPages.currentPage().getParameters().put('id', dp.id);
        DeskingPayment_EXT cs = new DeskingPayment_EXT(sc);
    }

    static testmethod void testSavePayment() {
        Contact Con=new Contact(FirstName='Test',LastName='Test',OwnerID=userinfo.getUserId());
        insert Con;
        dealer__Deal__c deal = new dealer__Deal__c(OwnerID=userinfo.getUserId(),dealer__Deal_ID__c='A1234XX',dealer__Buyer_Contact__c=con.ID,dealer__Deal_Date__c=System.today().adddays(-90));
        insert deal;
        
        dealer__Deal_Payment__c dp = new dealer__Deal_Payment__c();
        
        dp.dealer__Car_Deal__c=deal.id;
        dp.dealer__Due_Date__c=system.today().addDays(10);
        dp.dealer__Amount__c = 100;

        ApexPages.CurrentPage().getParameters().put('dealId',deal.id );
        
        ApexPages.StandardController sc = new ApexPages.StandardController(dp);
        ApexPages.currentPage().getParameters().put('id', dp.id);
        DeskingPayment_EXT cs = new DeskingPayment_EXT(sc);

        cs.savePayment();

    }
}