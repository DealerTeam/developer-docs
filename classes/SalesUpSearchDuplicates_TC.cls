@isTest
public  class SalesUpSearchDuplicates_TC{
public static  testmethod void MyunitTest(){

dealer__Sales_Up__c  su = new dealer__Sales_Up__c();
su.dealer__LastName__c='Test';
 su.dealer__FirstName__c='Te';
 su.dealer__Mobile__c='9912328805';
 su.dealer__Email__c='Test@gmail.com'; 
 su.dealer__Phone__c='9999999999';
insert su;

SalesUpSearchDuplicates sd = new SalesUpSearchDuplicates();
SalesUpSearchDuplicates.searchUps Sdw = new SalesUpSearchDuplicates.searchUps(True, True, True,True, True, 'True', 'True', 'Test@gmail.com');
sd.cancel();
sdw.upPhone='1234567895';
sdw.upMobile='478785489';
//sd.lookUp('suid');


}
}