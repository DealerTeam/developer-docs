public with sharing class AppraisalNewController {
    
    /**
     * getUserLocation wired method that returns the location for the given user
     * @param  userId userId the user used to get a location
     * @return        return location record related to the given user
     */
    @AuraEnabled(cacheable=true)
    public static dealer__Dealer_Location__c getUserLocation(Id userId){
        dealer__Dealer_Location__c loc = Utility.userLocation(userId);

        return loc;
    }
    
    /**
     * createServiceVehicle Checks if a service vehicle exists for a given vin & creates a record if one does not exist
     * @param  sv dealer__Service_Vehicle__c service vehicle to create
     * @return    return Id of the created service vehicle
     */
    @AuraEnabled
    public static string createServiceVehicle(dealer__Service_Vehicle__c sv){
        List<dealer__Service_Vehicle__c> existingSV = [SELECT Id, Year__c, Make__c, Carline__c, Trim_Level__c FROM Service_Vehicle__c WHERE VIN__c =: sv.dealer__VIN__c];

        if(existingSV.size() == 1){
            //This is where we should do field updates
            return existingSV[0].Id;
        }
        else{
            insert sv;
            return sv.Id;
        }
    }

    /**
     * getRelatedVehicle Get all service vehicles related to a sales up
     * @param  supId supId Id of sales up to find related service vehicles
     * @return       return List of service vehicles related to sales up
     */
    @AuraEnabled
    public static Service_Vehicle__c getRelatedVehicle(Id supId){
        Sales_Up__c sup = [SELECT Service_Vehicle__c FROM Sales_Up__c WHERE Id =: supId];
        if(sup.Service_Vehicle__c != null){
            Service_Vehicle__c sv = [SELECT Year__c, Make__c, Carline__c, VIN__c, Trim_Level__c FROM Service_Vehicle__c WHERE Id =: sup.Service_Vehicle__c];
        
            return sv;
        }
        else{
            return null;
        }
        
    }

    /**
     * getExistingTrades Get all trade ins related to a VIN
     * @param  String VIN The VIN to find related trades
     * @return        return List of Trade Ins related to the deal
     */
    @AuraEnabled
    public static List<Trade_In__c> getExistingTrades(String VIN){
        List<Trade_In__c> trades = [SELECT Id, VIN__c, Year__c, Make__c, Model__c, Trim_Level__c, Car_Deal__r.Name, Name, Car_Deal__c, Appraisal__c, Appraisal__r.Name FROM Trade_In__c WHERE VIN__c =: VIN AND Car_Deal__r.Deal_Close_Date__c = null];

        if(trades.size() > 0){
            return trades;
        }
        else{
            return null;
        }
    }

    /**
     * handleDecode Returns year, make and model for a given VIN
     * @param  VIN VIN The VIN to decode
     * @return     return Service_Vehicle__c vehicle with year, make and model populated from VIN Decoder
     */
    @AuraEnabled
    public static Service_Vehicle__c handleDecode(String VIN){
        return VehicleInventoryAPI.simpleVINDecode(VIN);
    }

    /**
     * getObjectName Calls utility class to return the object type for a given record id
     * @param  objId objId record id to retrieve the object type
     * @return       return String the object api name of the provided id
     */
    @AuraEnabled
    public static string getObjectName(String objId){
        return Utility.GetKeyPrefix(objId);       
    }

    /**
     * updateTrades Updates the trades with a new appraisal id
     * @param  trades trades list of trades to update
     * @param  app    app id of the appraisal to relate to the trades
     * @return        return true if the trades were update otherwise false
     */
    @AuraEnabled
    public static Boolean updateTrades(List<Trade_In__c> trades, String app){
        List<Trade_In__c> tradeList = new List<Trade_In__c>();
        if(app != null){
            for(Trade_In__c trade : trades){
                trade.Appraisal__c = app;
                tradeList.add(trade);
            }
            if(tradeList.size() > 0){
                update tradeList;
                return true;
            }
        }
            return false;
    }

    @AuraEnabled(cacheable=true)
    public static Service_Estimate__c getServiceEstimateLines(String appId){
        if(appId != null){
            Appraisal__c appHeader = [SELECT Id, Service_Estimate__c FROM Appraisal__c WHERE Id =: appId]; 
            if(appHeader.Service_Estimate__c != null){
                List<Service_Estimate__c> estimates = [SELECT Id, Estimate_Total__c, (SELECT Id, Name, Repair_Type__c, Description__c, Line_Total__c, Misc_Charges__c, Sublet_Charges__c, Parts__c, Labor__c, Labor_Operation__r.Name, Labor_Operation__c, Line_Number__c FROM Service_Estimate_Lines__r ORDER BY Line_Number__c ASC) FROM Service_Estimate__c WHERE Id =: appHeader.Service_Estimate__c];

                return estimates[0];
            }
        }

        return null;
    }

    @AuraEnabled
    public static Service_Estimate__c refreshEstimateLines(String appId){
        if(appId != null){
            Appraisal__c appHeader = [SELECT Id, Service_Estimate__c FROM Appraisal__c WHERE Id =: appId]; 
            if(appHeader.Service_Estimate__c != null){
                List<Service_Estimate__c> estimates = [SELECT Id, Estimate_Total__c, (SELECT Id, Name, Repair_Type__c, Description__c, Line_Total__c, Misc_Charges__c, Sublet_Charges__c, Parts__c, Labor__c, Labor_Operation__r.Name, Labor_Operation__c, Line_Number__c FROM Service_Estimate_Lines__r ORDER BY Line_Number__c ASC) FROM Service_Estimate__c WHERE Id =: appHeader.Service_Estimate__c];

                return estimates[0];
            }
        }

        return null;
    }

    @AuraEnabled
    public static void saveNewEstimateLine(Service_Estimate_Line__c line){
        if(line.Service_Estimate__c != null) {
			try {
				Set<String> protectedCodes = Utility.protectedStatusCodes('dealer__Service_Repair_Order__c');
			 	Service_Estimate__c[] estimateOnDisk = [SELECT Id, Service_Repair_Order__c FROM Service_Estimate__c WHERE Id=:line.Service_Estimate__c AND Service_Repair_Order__r.Status__c IN:protectedCodes];
				if(!estimateOnDisk.isEmpty() && estimateOnDisk[0].Service_Repair_Order__c!=null) {
					throw new AppraisalNewControllerException('Unable to add Estimate Line.  This estimate has already been converted to a Repair Order that is in protected status.');
				}
			} Catch(Exception e) {
				throw new AppraisalNewControllerException(e.getMessage());
			}
		}
        system.debug(line);
        insert line;
    }

    @AuraEnabled
    public static List<StandardOpCode__c> getReconCodes(){
        List<StandardOpCode__c> codes = [SELECT Id, Active__c, Labor_Estimate__c, Parts_Estimate__c, MiscEstimate__c, SubletEstimate__c, Name, Op_Code_Description__c, dealer__Concern__c, dealer__Service_Type__c FROM StandardOpCode__c WHERE Active__c = true AND AvailableForReconditioning__c = true];
        if(codes.size() == 0){
            throw new AuraHandledException('No Reconditioning Op Codes found. Please ensure active Standard Operation Codes with Available For Reconditioning flag set to true exist.');
        }

        return codes;
    }

    @AuraEnabled(cacheable=true)
    public static Appraisal__c getAppraisal(String appId){
        Appraisal__c app = (Appraisal__c)Utility.queryAllFields('dealer__Appraisal__c', appId);
        return app;
    }

    @AuraEnabled
    public static Service_Estimate__c createEstimate(String appId){
        Service_Estimate__c est = new Service_Estimate__c();
        if(appId == null){
            throw new AppraisalNewControllerException('A valid Appraisal Id is required to create an Estimate.');
        }
        Appraisal__c app = [SELECT Id, Store_Location__c, Service_Vehicle__c, Sales_Up__c, Sales_Up__r.Customer_Account__c FROM Appraisal__c WHERE Id =: appId];
        est.Store_Location__c = app.Store_Location__c;
        est.Appraisal__c = app.Id;
        est.Service_Vehicle__c = app.Service_Vehicle__c;
        if(app.Sales_Up__c != null){
            est.Customer__c = app.Sales_Up__r.Customer_Account__c;
        }
        try{
            insert est;

        }
        catch(Exception e){
            throw new AppraisalNewControllerException('Error creating new Service Estimate.');
        }
        
        return getServiceEstimateLines(app.Id);
    }

    public class AppraisalNewControllerException extends Exception {}
}