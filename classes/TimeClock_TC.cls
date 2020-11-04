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
private class TimeClock_TC {

    // Test the time punching UI
    static testMethod void testPunch() {
        // TO DO: implement unit test
        TimeClock_AC TC = new TimeClock_AC();

        TC.clockin();

        TimeClock_AC TC2 = new TimeClock_AC();
        TC2.clockin();

        TC.lunchStart();
        TC.lunchEnd();
        TC.clockout();

        TC.clockin();
        TC.lunchStart();
        //TC.clockout();

        TC.gettimeEntries();

        //TimeClock_AC TC2 = new TimeClock_AC();
        TC2.clockin();
        TC2.clockout();

        TimeClock_AC TC3 = new TimeClock_AC();

        /*** Test Manager with data ***/
        TimeClockManager TM = new TimeClockManager();
        TM.u = UserInfo.getUserId();

        TM.lookupTime();

        //TM.tclId = TM.tc.Time_Clock_Lines__r[0].Id;
        TM.tclId = [SELECT Id FROM Time_Clock_Line__c LIMIT 1].Id;
        TM.selectLine();

        TM.updateLine();

        TM.tcl.Note__c = 'test note';
        TM.updateLine();

        TM.gettimeEntries();

        TC.isClockIntime = false;
        TC.isClockOutTime = false;
        TC.isLunchStartTime = false;
        TC.isLunchEndTime = false;
        TC.ClockIntime = 'test';
        TC.ClockOutTime = 'test';
        TC.LunchStartTime = 'test';
        TC.LunchEndTime = 'test';

    }

    static testMethod void testManager() {

        TimeClockManager TM = new TimeClockManager();
        TM.u = UserInfo.getUserId();

        TM.lookupTime();
        TM.selectLine();
        TM.updateLine();

        TM.gettimeEntries();

        // test errors
        TimeClockManager TM2 = new TimeClockManager();
        TM2.u = UserInfo.getUserId();

    }
}