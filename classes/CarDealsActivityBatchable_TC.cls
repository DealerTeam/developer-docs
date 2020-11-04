/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CarDealsActivityBatchable_TC {
    public static String CRON_EXP = '0 0 0 3 9 ? 2022';
    
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Test.startTest();
        Contact Con=new Contact(FirstName='Test',LastName='Test',OwnerID=userinfo.getUserId());
        insert Con;
       
        dealer__Deal__c deal = new dealer__Deal__c(OwnerID=userinfo.getUserId(),dealer__Deal_ID__c='A1234XX',dealer__Buyer_Contact__c=con.ID,dealer__Deal_Date__c=System.today().adddays(-90));
        insert deal;
        Task t=new Task(Subject='Test',WhatID=Deal.ID,Activitydate=System.today().adddays(-90));
        insert t;
        String jobId = System.schedule(
                  'TestCouponSchedule',
                  CRON_EXP, 
                  new CarDealsActivityBatchable());
          
           String DealList = 'select id,dealer__Buyer_Contact__c from Dealer__Deal__c where dealer__Buyer_Contact__c!=null';
           
           Id batchInstanceIdPrescriber = Database.executeBatch(new CarDealsActivity(DealList), 500);
           Test.stopTest();
           
            
        
    }
}