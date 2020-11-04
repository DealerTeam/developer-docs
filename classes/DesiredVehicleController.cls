public class DesiredVehicleController {

    public class desiredVehicleWrapper{
            @AuraEnabled public List<Desired_Vehicle__c> vehicles;
            @AuraEnabled public List<Desired_Vehicle__c> primaryVehicle;

            public desiredVehicleWrapper(List<Desired_Vehicle__c> vehicles, List<Desired_Vehicle__c> primaryVehicle){
                this.vehicles = vehicles;
                this.primaryVehicle = primaryVehicle;
            }
    }

    @AuraEnabled (cacheable=true)
    public static desiredVehicleWrapper getDesiredVehicles(Id supId) {
        Sales_Up__c sup = [SELECT Id, dealer__DesiredVehicle__c FROM dealer__Sales_Up__c WHERE Id =: supId];

        Desired_Vehicle__c [] dvList = [SELECT Id, Name, Conversion__c, Conversion__r.Name, Exterior_Color__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, Sales_Up__c, 
                                                    Status__c, Trim_Level__c, Vehicle_Inventory__c, Vehicle_Inventory__r.Name, VIN__c, Year__c, MakeModelYearTrim__c FROM dealer__Desired_Vehicle__c WHERE Sales_Up__c =: supId AND Id !=: sup.DesiredVehicle__c];
        
        Desired_Vehicle__c [] primary = new List<Desired_Vehicle__c>(); 
        if(sup.DesiredVehicle__c != null){
            primary = [SELECT Id, Name, Conversion__c, Conversion__r.Name, Vehicle_Inventory__r.Name, Exterior_Color__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, Sales_Up__c, 
            Status__c, Trim_Level__c, Vehicle_Inventory__c, VIN__c, Year__c, MakeModelYearTrim__c FROM dealer__Desired_Vehicle__c WHERE Id =: sup.DesiredVehicle__c];
        }
        return new desiredVehicleWrapper(dvList, primary);
    }

    @AuraEnabled (cacheable=true)
    public static List<dealer__Desired_Vehicle__c> getVehicles(Id supId) {
        List<dealer__Desired_Vehicle__c> dvList = [SELECT Id, Name, Conversion__c, Conversion__r.Name, Exterior_Color__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, Sales_Up__c, 
                                                    Status__c, Trim_Level__c, Vehicle_Inventory__c, VIN__c, Year__c, MakeModelYearTrim__c FROM dealer__Desired_Vehicle__c WHERE Sales_Up__c =: supId];
        return dvList;
    }

    @AuraEnabled (cacheable=true)
    public static List<dealer__Desired_Vehicle__c> getPrimaryVehicle(Id supId) {
        List<dealer__Desired_Vehicle__c> primaryDV = new List<dealer__Desired_Vehicle__c>();
        List<dealer__Sales_Up__c> sup = [SELECT Id, dealer__DesiredVehicle__c FROM dealer__Sales_Up__c WHERE Id =: supId];
        if(sup.size() > 0 && sup[0].dealer__DesiredVehicle__c != null){
            primaryDV = [SELECT Id, Name, Conversion__c, Conversion__r.Name, Exterior_Color__c, Interior_Color__c, Make__c, Model__c, New_Used_Other__c, Sales_Up__c, 
                            Status__c, Trim_Level__c, Vehicle_Inventory__c, VIN__c, Year__c, MakeModelYearTrim__c FROM dealer__Desired_Vehicle__c WHERE Id =: sup[0].dealer__DesiredVehicle__c];
        }

        return primaryDV;
    }

    @AuraEnabled
    public static dealer__Vehicle_Inventory__c getVehicleInventoryRecord(Id vehicleId){
        dealer__Vehicle_Inventory__c vi = [SELECT Id, Name, dealer__Conversion__c, dealer__Status_Code__c, dealer__Exterior_Color__c, dealer__Interior_Color__c, dealer__New_Used_Other__c, 
                                            dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Trim_Level__c FROM dealer__Vehicle_Inventory__c WHERE Id =: vehicleId];
        return vi;
    }

    @AuraEnabled
    public static string setPrimary(Id dvId, Id supId){
        Desired_Vehicle__c dv = [SELECT Id, Vehicle_Inventory__c FROM Desired_Vehicle__c WHERE Id =: dvId];
        dealer__Sales_Up__c sup = [SELECT Id, dealer__DesiredVehicle__c FROM dealer__Sales_Up__c WHERE Id =: supId];
        sup.dealer__DesiredVehicle__c = dvId;
        sup.Desired_Stock_Num__c = dv.Vehicle_Inventory__c;
        update sup;
        sup = [SELECT Id, dealer__DesiredVehicle__c FROM dealer__Sales_Up__c WHERE Id =: supId];
        system.assert(dvId == sup.DesiredVehicle__c, 'Desired Vehicle was unable to be set on the sales up.');
        return sup.Id;
    }

    @AuraEnabled
    public static string removePrimaryVehicle(Id dvId, Id supId){
        dealer__Sales_Up__c sup = [SELECT Id, dealer__DesiredVehicle__c FROM dealer__Sales_Up__c WHERE Id =: supId];
        if(sup.dealer__DesiredVehicle__c == dvId){
            sup.dealer__DesiredVehicle__c = null;
            sup.Desired_Stock_Num__c = null;
            update sup;
            
            return sup.Id;
        }
        return sup.Id;
    }

    @AuraEnabled
    public static Sales_Up__c getSalesUp(Id recordId)
    {
        Sales_Up__c sup = [SELECT Id, Car_Deal__c FROM Sales_Up__c WHERE Id =: recordId];
        return sup;
    }
}
