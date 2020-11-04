/**
 * ConvertSAtoRO 
 * @description
 */ 
public with sharing class ConvertSAtoRO {
    
    /**
     * @descption
     */
    public String serviceAppointmentId;
    
    /**
     * @descption
     */
    public String RepairOrderID{get;set;}
    
    /**
     * @descption
     */
    public Service_Repair_Order__c repairOrderRecord;
    
    /**
     * @descption
     */
    public Decimal estimateTotal = 0;
    
    /**
     * ConvertSAtoRO 
     * @param  controller 
     * @description          
     */
    public ConvertSAtoRO(ApexPages.StandardController controller) 
    {
    }
   
    /**
     * autoRun description
     * @return void
     * @description This method create the Service Repair Order record from the Service Appointment, and then deletes the Service Appointment Record
     */
    public void autoRun()  
    {  
        try{ 
            serviceAppointmentId = ApexPages.currentPage().getParameters().get('id');
            Service_Appointment__c serviceAppiontmentRecord= new Service_Appointment__c();
            
            //Check if the id is the valid appointment id
            if(serviceAppointmentId!=null && serviceAppointmentId.startsWith(Service_Appointment__c.sobjecttype.getDescribe().getKeyPrefix())){
            serviceAppiontmentRecord=[Select id,
                                            Name,
                                            Appointment_Time__c,
                                            Comapny_Number__c,
                                            Company__c,//W-000697
                                            Comments__c,
                                            Company_Number__c,
                                            Customer_Contact__c,
                                            Customer__c,
                                            Date_Time__c,
                                            External_Id__c,
                                            Last_Odometer__c,
                                            Last_Service__c,
                                            Loaner_Requested__c,
                                            Mileage__c,
                                            Open_DateTime__c,
                                            Promised_Completion_Time__c,
                                            Quote_Total__c,
                                            Recheck__c,
                                            Requested_Technician__c,
                                            SA__c,
                                            Vehicle__c,
                                            VIN__c,
                                            Waiter__c,
                                            Color_Code__c,
                                            dealer__Durration__c
                                        from Service_Appointment__c where id=:serviceAppointmentId];
                
    
                // Create Instance of Repair Order
                repairOrderRecord=new Service_Repair_Order__C();
                
                if(serviceAppiontmentRecord.Mileage__c==null) {
                    serviceAppiontmentRecord.Mileage__c=0;
                }
    
                /* RO Name defined by Current Invoice Number prefixed with RO# (JK) */
                /* RO Number should not have trailing Zeros. */
                if(serviceAppiontmentRecord.Comments__c==null) {
                    serviceAppiontmentRecord.Comments__c='';
                }
                
                //W-000697
                if(serviceAppiontmentRecord.Company__c!=null){
                    repairOrderRecord.Company__c = serviceAppiontmentRecord.Company__c;
                }
                repairOrderRecord.Company_Number__c=serviceAppiontmentRecord.Comapny_Number__c;         
                repairOrderRecord.Comments__c=serviceAppiontmentRecord.Comments__c+' : Converted from Appointment# '+serviceAppiontmentRecord.Name;         
                repairOrderRecord.Company_Number__c=serviceAppiontmentRecord.Company_Number__c;         
                repairOrderRecord.Customer_Contact__c=serviceAppiontmentRecord.Customer_Contact__c;
                repairOrderRecord.Customer__c = serviceAppiontmentRecord.Customer__c;         
                repairOrderRecord.Mileage_In__c=serviceAppiontmentRecord.Mileage__c;            
                repairOrderRecord.Invoiced_Date_Time__c=serviceAppiontmentRecord.Open_DateTime__c;          
                repairOrderRecord.Promise_Date__c=Date.ValueOf(serviceAppiontmentRecord.Promised_Completion_Time__c);
                repairOrderRecord.Service_Advisor__c=serviceAppiontmentRecord.SA__c;            
                repairOrderRecord.Vehicle__c=serviceAppiontmentRecord.Vehicle__c;           
                repairOrderRecord.Waiting__c=serviceAppiontmentRecord.Waiter__c;
                repairOrderRecord.Color_Code__c = serviceAppiontmentRecord.Color_Code__c;
    
                repairOrderRecord.dealer__Expected_Service_Start__c = serviceAppiontmentRecord.dealer__Date_Time__c; 
                
                //Check if DateTime value exists before adding minutes
                if(serviceAppiontmentRecord.dealer__Date_Time__c!=null){          
                    repairOrderRecord.dealer__Expected_Service_End__c = serviceAppiontmentRecord.dealer__Date_Time__c.addMinutes(Integer.valueOf( serviceAppiontmentRecord.dealer__Durration__c) );
                }
                insert repairOrderRecord;
                
                if(serviceAppiontmentRecord.id!=null){
                    serviceAppiontmentRecord.ServiceRepairOrder__c = repairOrderRecord.Id;
                    update serviceAppiontmentRecord;
                }
                
                repairOrderRecord = [Select id, name, Company__c, Color_Code__c, Waiting__c, Vehicle__c, Service_Advisor__c, Promise_Date__c, Invoiced_Date_Time__c, Mileage_In__c, Customer__c, Company_Number__c, Comments__c, Customer_Contact__c from Service_Repair_Order__C where id =: repairOrderRecord.id];
                
                RepairOrderID=repairOrderRecord.ID;
                insertChildRecords();
    
                // Set Estimate Total
                repairOrderRecord.dealer__Estimate__c = estimateTotal;
    
                update repairOrderRecord;
    
                createTask();
            
            }
            else{              
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Id value is not valid for the dealer__Service_Appointment__c standard controller'));
            }                        
            
        } Catch(DmlException e) {
            throw new SROException('DML Exception creating Repair Order '+e+' '+repairOrderRecord);
        } Catch(SObjectException e) {
            throw new SROException('sObject Exception creating Repair Order '+e);
        } Catch(Exception e) {
            throw new SROException('Exception creating Repair Order '+e);
        }
    }
    
    /**
     * insertChildRecords 
     * @return void
     * @description Inserts the Service Job Records from  Service Appointment Line records
     */ 
    public void insertChildRecords()
    {
        List<Service_Appointment_Line__c> serviceApprointmentitems=new List<Service_Appointment_Line__c>();
        serviceApprointmentitems=[Select ID,
                                    Name,
                                    Complaint__c,
                                    dealer__CustomerConcern__c,
                                    Line__c,
                                    Line_Key__c,
                                    Pay_Type__c,
                                    Priority__c,
                                    Qoute__c,
                                    Service_Appointment__c,
                                    Standard_Op_Code__c,
                                    Standard_Op_Code__r.Op_Code__c
                                    from Service_Appointment_Line__c where Service_Appointment__c=:serviceAppointmentId];
        List<Service_Job__c> serviceJobRecords=new List<Service_Job__c>();
        Integer lineNumber = 1;
        for(Service_Appointment_Line__c SAL:serviceApprointmentitems){

            if(SAL.Qoute__c==null) { SAL.Qoute__c = 0; }

            Service_Job__c SJ=new Service_Job__c();
            SJ.Name=repairOrderRecord.Name+'-'+lineNumber;
            SJ.CustomerConcern__c=SAL.dealer__CustomerConcern__c;
            SJ.Line_Number__c=lineNumber;
            SJ.Job_Line_Id__c=repairOrderRecord.Name+'-'+lineNumber; //W-000828 
            SJ.Labor_Type__c=SAL.Pay_Type__c;
            SJ.Estimate__c=SAL.Qoute__c;
            SJ.Op_Code__c=SAL.Standard_Op_Code__r.Op_Code__c;
            SJ.Service_Repair_Order__c=RepairOrderID;
            SJ.Standard_Operation_Code__c=SAL.Standard_Op_Code__c;
            serviceJobRecords.add(SJ);
            lineNumber++;

            estimateTotal += SAL.Qoute__c;
        }
        if(serviceJobRecords.size()>0) 
        try {
            insert serviceJobRecords;
        } Catch(DmlException e) {
            throw new SROException('DML Exception creating Repair Order lines '+e);
        } Catch(SObjectException e) {
            throw new SROException('sObject Exception creating Repair Order lines '+e);
        } Catch(Exception e) {
            throw new SROException('Exception creating Repair Order lines '+e);
        }
    }
    
    /**
     * createTask description
     * @return void
     * @description It created task for the newly created Service Repair Order
     */
    public void createTask()
    { 
        Task serviceRepairOrderTask=new Task();
        serviceRepairOrderTask.WhatId=RepairOrderID;
        serviceRepairOrderTask.OwnerId=Userinfo.getUserId();
        serviceRepairOrderTask.Subject=repairOrderRecord.Name +' SA';
        serviceRepairOrderTask.Description=repairOrderRecord.Name +' SA';
        serviceRepairOrderTask.ActivityDate=System.today();
        serviceRepairOrderTask.Status='Completed';

        serviceRepairOrderTask.WhoId = repairOrderRecord.Customer_Contact__c; // DR1
        insert serviceRepairOrderTask;
    }

    /**
     * SROException
     * @description
     */
    public class SROException extends Exception{}
}