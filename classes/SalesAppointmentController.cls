/**
 * 	Sales Appointment LC Controller
 *  Test class: SalesAppointmentControlTest
**/
public with sharing class SalesAppointmentController {
    
    @AuraEnabled
    public static boolean createTask(String toId, String salesApptId) {
        
        system.debug('create task to ----> ' + toId);
        Task t = new Task();
        t.OwnerId = toId;
        t.Subject = 'Reschedule Sales Appointment';
        t.Status = 'Open';
        t.Priority = 'Normal';
        t.WhatId = salesApptId;
        
        try{
            insert t;
            return true;
        }catch(Exception e){
            system.debug('Error creating task ' + e.getMessage());
        }
        
        return false;
    }
    
    @AuraEnabled
    public static List<dealer__Inventory_Images__c> getImages(String vehicleId) {
                
        List<dealer__Inventory_Images__c> images = new List<dealer__Inventory_Images__c>();
        
        images = [Select Id, Name, dealer__Image_URL__c 
                  FROM dealer__Inventory_Images__c 
                  Where dealer__Vehicle_Inventory__c =: vehicleId
            	  Limit 100];
        return images;
    }
    
    @AuraEnabled
    public static dealer__Vehicle_Inventory__c getVehicle(String salesApptId) {
        
        dealer__Vehicle_Inventory__c vehicle = new dealer__Vehicle_Inventory__c();
        
        try{
            Id salesVehicle = [Select dealer__Vehicle__c From dealer__Sales_Appointment__c
                           Where Id =: salesApptId].dealer__Vehicle__c;
            
            if(salesVehicle != null){

                String query = 'SELECT';
                Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get('dealer__Vehicle_Inventory__c').getDescribe().fields.getMap();
                for(String s : objectFields.keySet()) {
                    query += ' ' + s + ',';
                }
        
                if (query.subString(query.Length()-1,query.Length()) == ','){
                    query = query.subString(0,query.Length()-1);
                }
                
                query += ' FROM dealer__Vehicle_Inventory__c';
                query += ' WHERE Id = ' + '\'' + salesVehicle + '\''; 
                system.debug('query ---> ' + query);
                vehicle = database.query(query);
            }
            
        }catch(Exception e){
            system.debug(e.getMessage());
            return null;
        }
        
        return vehicle;
    }
    
    @AuraEnabled
   	public static List<dealer__Equipment__c> getEquipment(String serviceVehicleId) {
        
        system.debug('serviceVehicleId --->' + serviceVehicleId);
        List<dealer__Equipment__c> equipment = new List<dealer__Equipment__c>();
        if(serviceVehicleId != null && serviceVehicleId != ''){
            
            equipment = EquipmentTable_EXT.readEquipmentLEX(serviceVehicleId);

            for(Integer i = 0; i<equipment.size(); i++){
                
                //Include only published equipment
                if(!equipment[i].Publish__c){
                    equipment.remove(i);
                }
            }
        }
        return equipment;
    }

}