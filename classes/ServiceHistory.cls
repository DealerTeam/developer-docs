public with sharing class ServiceHistory {
        
        public static Id serviceVehicle {get;set;}
        public ServiceHistory() { }
        
        public static List<dealer__Service_Job__c> jobList(ID vehicleId) {

                if(vehicleId==null) {
                    return new List<dealer__Service_Job__c>();
                }

                return [Select d.dealer__RO_Number__c, d.dealer__Parts_Total__c, d.dealer__Line_Total__c, d.dealer__Line_Number__c, 
                                d.dealer__Labor_Type__c, d.dealer__Labor_Charges__c, d.dealer__Correction__c, 
                                d.dealer__CustomerConcern__c, d.dealer__Concern__c, 
                                d.dealer__Cause__c, d.dealer__Book_Time__c, d.dealer__Actual_Time__c, d.dealer__Op_Code__c,
                                d.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c, 
                                d.dealer__Service_Repair_Order__r.dealer__Service_Advisor__r.Name, 
                                d.dealer__Service_Repair_Order__r.dealer__Vehicle__c,
                                d.dealer__Service_Repair_Order__r.dealer__Create_Date_Time__c, d.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c
                            From dealer__Service_Job__c d 
                            where d.dealer__Service_Repair_Order__r.dealer__Vehicle__c = :vehicleId
                            order by d.dealer__RO_Open_Date_Time__c desc, d.dealer__Line_Number__c desc limit 100 ];
        }

        public static String serviceHistoryJSON(ID vehicleId) {
        
        List<dealer__Service_Job__c> jobLines = ServiceHistory.jobList(vehicleId);
        
        if(jobLines.size() > 0) {
                                                            
        Set<Id> inclSA = new Set<Id>();
        Set<Id> inclC  = new Set<Id>();
    
        // Popluate sets 
        for(dealer__Service_Job__c jlt : jobLines) { 
            if(jlt.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c!=null) {
                inclC.add(jlt.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c);
            }
            
            if(jlt.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c!=null) {
                inclSA.add(jlt.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c);
            }
        }                                   
        
        Map<Id, User> sa = new Map<Id, User>([Select Id, Name from User where Id IN:inclSA]);                                           
        Map<Id, Contact> cust = new Map<Id, Contact>([Select Id, Name from Contact where Id IN:inclC]);
        System.debug(cust);
        JSONGenerator jg = JSON.createGenerator(true);
        jg.writeStartArray();
        for(dealer__Service_Job__c jl : jobLines) {
            jg.writeStartObject();
            
            if(jl.dealer__RO_Number__c!=null) { jg.writeStringField('ronumber', jl.dealer__RO_Number__c); } else { jg.writeStringField('ronumber', ''); }
            if(jl.dealer__Service_Repair_Order__r.dealer__Create_Date_Time__c!=null) { 
                    jg.writeDateTimeField('opendate', jl.dealer__Service_Repair_Order__r.dealer__Create_Date_Time__c);
            } 
            if(jl.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c!=null) { 
                    jg.writeStringField('customerid', jl.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c); 
                    if(cust.get(jl.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c) != null){
                        jg.writeStringField('customer', cust.get(jl.dealer__Service_Repair_Order__r.dealer__Customer_Contact__c).Name);
                    }
                    else{
                        jg.writeStringField('customer', '');
                    }
            } else { jg.writeStringField('customerid', ''); jg.writeStringField('customer', ''); }
            if(jl.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c!=null) {
                    jg.writeStringField('advisorid', jl.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c);
                    if(sa.get(jl.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c) != null){
                        jg.writeStringField('advisor', sa.get(jl.dealer__Service_Repair_Order__r.dealer__Service_Advisor__c).Name);
                    }
                    else{
                        jg.writeStringField('advisor', '');
                    }
            } else {
                    jg.writeStringField('advisorid', '');
                    jg.writeStringField('advisor', '');
            }
            if(jl.dealer__Op_Code__c!=null) { jg.writeStringField('operation', jl.dealer__Op_Code__c); } else { jg.writeStringField('operation', ''); }
            if(jl.dealer__Line_Number__c!=null) { jg.writeNumberField('joblinenumber', jl.dealer__Line_Number__c); } else { jg.writeStringField('joblinenumber', ''); }
            if(jl.dealer__Labor_Type__c!=null) { jg.writeStringField('paytype', jl.dealer__Labor_Type__c); } else { jg.writeStringField('paytype', ''); }
            if(jl.dealer__Book_Time__c!=null) { jg.writeNumberField('booktime', jl.dealer__Book_Time__c); } else { jg.writeNumberField('booktime', 0); } 
            if(jl.dealer__CustomerConcern__c!=null) { jg.writeStringField('concern', jl.dealer__CustomerConcern__c.escapeHtml4()); } else { jg.writeStringField('concern', ''); }
            if(jl.dealer__Cause__c!=null) { jg.writeStringField('cause', jl.dealer__Cause__c.escapeHtml4()); } else { jg.writeStringField('cause', ''); }
            if(jl.dealer__Correction__c!=null) { jg.writeStringField('correction', jl.dealer__Correction__c.escapeHtml4()); } else { jg.writeStringField('correction', ''); }
            if(jl.dealer__Labor_Charges__c!=null) { jg.writeNumberField('laborcharges', jl.dealer__Labor_Charges__c); } else { jg.writeNumberField('laborcharges', 0); }
            if(jl.dealer__Parts_Total__c!=null) { jg.writeNumberField('partscharges', jl.dealer__Parts_Total__c); } else { jg.writeNumberField('partscharges', 0); }
            
            jg.writeEndObject();
        }
        jg.writeEndArray();
        
        return jg.getAsString();
        
        } else {
            // Zero History
            return '{ronumber: \'No History\'}';
        }
    }
}