public with sharing class ServiceEstimateCreateController {
  
    @AuraEnabled
    public static Service_Estimate__c Company(String userId){
        User u = [SELECT Id, Division FROM User WHERE Id =:userId];
        system.assert(u.Division != null, 'Your User profile does not have a division assigned, please see your administrator.');
        try{
            Dealer_Location__c loc = [SELECT Id, Name From Dealer_Location__c WHERE Company_Number__c =: u.Division];
            return new Service_Estimate__c(
                Company__c=loc.Id
            );
        }catch(QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Service_Vehicle__c> ServiceVehicles(String accId){
        
        List<Service_Vehicle__c> svList = new List<Service_Vehicle__c>();
        
       try{
           svList = [SELECT Id,Name FROM Service_Vehicle__c WHERE Veh_Owner__c =: accId];
           system.debug('svList ' + svList);
       } catch(QueryException e){
           system.debug('Error: ' + e.getMessage());
       }
       
        return svList;
    }
    
    @AuraEnabled
    public static dealer__Service_Vehicle__c serviceVehicleAccountInfo(String svId){
        
       system.debug('----> svId ' +svId);
 
       if(svId==null) {
            return new Service_Vehicle__c();
       }
        
       try{
           return [SELECT Id, Name, dealer__Veh_Owner_Contact__c, dealer__Veh_Owner__c 
                   FROM dealer__Service_Vehicle__c WHERE Id =: svId];
       } catch(QueryException e){
           system.debug('Error: ' + e.getMessage() + ' ' + e.getStackTraceString());
                throw new AuraHandledException(e.getMessage());
       }
        
    }

    /**
    * @method obtainReferences queries reference records necessary
    * @param Polymorhpic Id of the related context
    */
    @AuraEnabled
    public static Service_Estimate__c obtainReferences(Id recordId) {
        
        if(recordId==null) {
            return new Service_Estimate__c();
        }

        // Referenced from a Repair Order
        if(recordId.getSobjectType()==Service_Repair_Order__c.sObjectType) {
            Service_Repair_Order__c sro = [SELECT Id, Name, Mileage_In__c, Company__c, Customer__c, 
                                                    Vehicle__c, Customer_Contact__c 
                                                FROM Service_Repair_Order__c 
                                                WHERE Id=:recordId];
            try {
                return new Service_Estimate__c (
                    Customer__c=sro.Customer__c,
                    Customer_Contact__c=sro.Customer_Contact__c,
                    Service_Vehicle__c=sro.Vehicle__c,
                    Company__c=sro.Company__c,
                    Current_Mileage__c=sro.Mileage_In__c,
                    Service_Repair_Order__c=sro.Id
                );
            } Catch(Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        // Reference on Service Vehicle
        if(recordId.getSobjectType()==Service_Vehicle__c.sObjectType) {
            Service_Vehicle__c veh = [SELECT Id, Veh_Owner__c, Veh_Owner_Contact__c FROM Service_Vehicle__c WHERE Id=:recordId];
            return new Service_Estimate__c(
                Customer__c=veh.Veh_Owner__c,
                Customer_Contact__c=veh.Veh_Owner_Contact__c
            );
        }

        // Reference on Account 
        if(recordId.getSobjectType()==Account.sObjectType) {
            return new Service_Estimate__c(
                Customer__c=recordId
            );
        }

        // Reference on Contact
        if(recordId.getSobjectType()==Contact.sObjectType) {
            Contact c = [SELECT Id, AccountId FROM Contact WHERE Id=:recordId];
            return new Service_Estimate__c(
                Customer__c=c.AccountId,
                Customer_Contact__c=c.Id
            );
        }

        // No reference
        return new Service_Estimate__c();
    }
}