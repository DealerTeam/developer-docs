@isTest
private class BirthDayReminder_TC {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        test.startTest();
        Contact c1=new Contact(firstName='test',LastName='test',BirthDate= System.today());
        insert c1;
        BirthDayReminder_AC BR=new BirthDayReminder_AC();
        BR.birthdayWishes();
        test.stopTest();
    }
   
  static testMethod void myUnitTest1() {
      Test.startTest();
      String jobId = System.schedule('testBasicScheduledApex','0 0 0 3 9 ? 2022', new BirthDayRemainderScheduler());
      Test.stopTest();
  }

}