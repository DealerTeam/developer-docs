/********************************************
Company: Dealer Team
Author: Mahesh S
Description: Test class for ConvertSAtoRO

********************************************/
@isTest
private class ConvertSAtoRO_TC {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        test.startTest();
        
        dealer__TaxSettings__c DTS=new dealer__TaxSettings__c(Name='ActiveSettings',dealer__State_Tax_Rate__c=1,dealer__State_Code__c='te');
        insert DTS;
        dealer__DMS_Settings__c DMS=new dealer__DMS_Settings__c(Name='ActiveSettings', dealer__Service_Current_Invoice_Number__c=100001, dealer__Parts_Current_Invoice_Number__c=100001, dealer__Parts_Current_Quote_Number__c=100001, dealer__Default_Tax_Rate__c=1);
        insert DMS;

        dealer__FixedOperationsSettings__c fops = new dealer__FixedOperationsSettings__c();
        fops.dealer__Repair_Order_Index__c = 7000;
        insert fops;

        Account accountInstance=new Account(name='Test');
        insert accountInstance;
        Contact contactInstance=new Contact(Lastname='Test',FirstName='test',AccountID=accountInstance.ID);
        insert contactInstance;
        StandardOpCode__c SOCInstance=new StandardOpCode__c(Name='test');
        insert SOCInstance;
        Service_Appointment__c serviceAppointmentInstance=new Service_Appointment__c (External_Id__c='Test',Mileage__c=100,Date_Time__c=System.now(),SA__c=Userinfo.getUserId(),Customer_Contact__c=contactInstance.ID);
        insert serviceAppointmentInstance;
        Service_Appointment_Line__c SAL=new Service_Appointment_Line__c(Name='Test',Complaint__c='test',Line__c=123,Line_Key__c='test',Pay_Type__c='test',Qoute__c=123.5,Service_Appointment__c=serviceAppointmentInstance.ID,Standard_Op_Code__c=SOCInstance.ID);
        insert SAL;
        System.currentPageReference().getParameters().put('Id',serviceAppointmentInstance.Id);
        ApexPages.StandardController ctrl = new ApexPages.StandardController(serviceAppointmentInstance);
        ConvertSAtoRO  convertSA= new ConvertSAtoRO(ctrl);
        convertSA.autoRun();
        test.stopTest();
        
    }
       
}