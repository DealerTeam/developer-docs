// Tested by TestVehicleEquipmentViewControl

public with sharing class VehicleEquipmentAPI {
    public VehicleEquipmentAPI() {}

    public static List<Decode_Values__b> getBigObjectEquipment(Service_Vehicle__c serviceVehicle){
        system.assert(serviceVehicle.Id != null,'Service_Vehicle__c.Id needed to query decode data.');
        try{
            return [SELECT Id, EquipmentName__c, DecodeDate__c, Description__c, EquipmentCategory__c, Equipped__c, OptionId__c, OrderCode__c, Vehicle__c FROM Decode_Values__b WHERE Vehicle__c =: serviceVehicle.Id];
        } catch (QueryException e){
            return new List<Decode_Values__b>();
        }
    }
    
    public static void migrateVehicleEquipment(String sVehicles){
        
        List<Decode_Values__b> decodeLines = new List<Decode_Values__b>();
        Set<Id> svIds = new Set<Id>();
        Set<Id> vIds = new Set<Id>();

        for(Service_Vehicle__c sv : (List<Service_Vehicle__c>)JSON.deserialize(sVehicles, List<Service_Vehicle__c>.class)){
            svIds.add(sv.Id);
            if(sv.Sales_Inventory__c != null ){
                vIds.add(sv.Sales_Inventory__c);
            }
        }

        //Get Vehicle Inventory Equipment
        for(Vehicle_Equipment__c ve :[SELECT CreatedDate, Vehicle_Inventory__r.Service_Vehicle__c, Vehicle_Inventory__c, Category__c, Description__c, Equiped__c, Equipment_Type__c, Equipped__c, Installed_By__c, Name__c, Option_Id__c,Order_Code__c, Id, Name FROM Vehicle_Equipment__c WHERE Vehicle_Inventory__c IN: vIds]){
            decodeLines.add(new Decode_Values__b(
                DecodeDate__c = ve.CreatedDate, 
                Description__c = ve.Description__c.length() > 255 ? ve.Description__c.subString(0,250) +'...' :ve.Description__c,
                EquipmentCategory__c = ve.Category__c, 
                EquipmentName__c= ve.Name__c != null ? ve.Name__c : ve.Name, 
                Equipped__c = ve.Equipped__c ? 1 : 0, 
                OptionId__c = ve.Option_Id__c, 
                OrderCode__c = ve.Order_Code__c, 
                Vehicle__c = ve.Vehicle_Inventory__r.Service_Vehicle__c
            ));      
        }

        // get Service Vehicle Equipment
        for(Service_Vehicle_Equipment__c ve : [SELECT CreatedDate, Service_Vehicle__c, Description__c, Category__c, Equipped__c, Equipment_Type__c, Installed_By__c, Option_Id__c, Order_Code__c, dealer_Name__c, Name, Id FROM Service_Vehicle_Equipment__c WHERE Service_Vehicle__c IN:svIds ]){
            decodeLines.add(new Decode_Values__b(
                DecodeDate__c = ve.CreatedDate, 
                Description__c = ve.Description__c.length() > 255 ? ve.Description__c.subString(0,250) +'...' :ve.Description__c, 
                EquipmentCategory__c = ve.Category__c, 
                EquipmentName__c= ve.dealer_Name__c != null ? ve.dealer_Name__c : ve.Name, 
                Equipped__c = ve.Equipped__c ? 1 : 0, 
                OptionId__c = ve.Option_Id__c, 
                OrderCode__c = ve.Order_Code__c, 
                Vehicle__c = ve.Service_Vehicle__c 
            ));                                       
        }

        if(decodeLines.size() > 0){
            insertDecodeData(JSON.serialize(decodeLines));

        }
    }

    public static void insertDecodeData(String boJSON){
        List<String> errors = new List<String>();
        List<Decode_Values__b> decodeLines = (List<Decode_Values__b>)JSON.deserialize(boJSON, List<Decode_Values__b>.class);
        if(!Test.isRunningTest()){
            for(Database.SaveResult sr : Database.insertImmediate(decodeLines)){
                if(sr.getErrors().size()>0){
                    System.debug('ERROR inserting Decode Data: '+sr.getErrors().toString());
                }
            }
        }
    }


    public static void deleteVehicleEquipment(List<Service_Vehicle__c> sVehicles){
        
        List<Decode_Values__b> decodeLines = new List<Decode_Values__b>();
        Set<Id> svIds = new Set<Id>();
        Set<Id> vIds = new Set<Id>();

        for(Service_Vehicle__c sv : sVehicles){
            svIds.add(sv.Id);
            if(sv.Sales_Inventory__c != null ){
                vIds.add(sv.Sales_Inventory__c);
            }
        }

        //Get Vehicle Inventory Equipment
        List<Vehicle_Equipment__c> vEquip = new List<Vehicle_Equipment__c>();
        for(Vehicle_Equipment__c ve :[SELECT CreatedDate, Vehicle_Inventory__r.Service_Vehicle__c, Vehicle_Inventory__c, Category__c, Description__c, Equiped__c, Equipment_Type__c, Equipped__c, Installed_By__c, Name__c, Option_Id__c,Order_Code__c, Id, Name FROM Vehicle_Equipment__c WHERE Vehicle_Inventory__c IN: vIds]){
           vEquip.add(ve);
        }

        // get Service Vehicle Equipment
        List<Service_Vehicle_Equipment__c> svEquip = new List<Service_Vehicle_Equipment__c>();
        for(Service_Vehicle_Equipment__c ve : [SELECT CreatedDate, Service_Vehicle__c, Description__c, Category__c, Equipped__c, Equipment_Type__c, Installed_By__c, Option_Id__c, Order_Code__c, dealer_Name__c, Name, Id FROM Service_Vehicle_Equipment__c WHERE Id IN:svIds ]){
            svEquip.add(ve);                                    
        }

        try{
            if(vEquip.size() > 0){
                delete vEquip;
            }
    
            if(svEquip.size() > 0 ){
                delete svEquip;
            }
        } catch(DmlException e){
            throw new VehicleEquipmentAPIException(e.getMessage());
        }
    }

    public class VehicleEquipmentAPIException extends Exception {}

}

