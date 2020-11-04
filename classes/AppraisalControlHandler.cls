public without sharing class AppraisalControlHandler {
    public static void setAppraisalFields(List<Appraisal__c> triggerNew) {
        Set<Id> svIds = new Set<Id>();
        List<Appraisal__c> appSV = new List<Appraisal__c>();
        for(Appraisal__c app : triggerNew){
            if(app.Appraisal_Date__c == null){
                app.Appraisal_Date__c = System.today();
            }
            if(app.Vehicle_Owner__c == null && app.Service_Vehicle__c != null){
                svIds.add(app.Service_Vehicle__c);
                appSV.add(app);
            }
        }

        if(svIds.size() > 0){
            Map<Id, Service_Vehicle__c> svMap = new Map<Id, Service_Vehicle__c>([SELECT Id, Veh_Owner__c FROM Service_Vehicle__c WHERE Id IN: svIds]);
            for(Appraisal__c app : appSV){
                if(svMap.get(app.Service_Vehicle__c) != null){
                    app.Vehicle_Owner__c = svMap.get(app.Service_Vehicle__c).Veh_Owner__c;
                }
            }
        }
    }

    public static void updateTradeOnInsert(List<Appraisal__c> triggerNew){
        List<Trade_In__c> trades = new List<Trade_In__c>();
        for(Appraisal__c app : triggerNew){
            if(app.Trade_In__c != null){
                Trade_In__c trade = new Trade_In__c(Id = app.Trade_In__c, Appraisal__c = app.Id);
                trades.add(trade);
            }
        }

        if(trades.size() > 0){
            update trades;
        }
    }

    public static void updateTradeOnUpdate(List<Appraisal__c> triggerNew, Map<Id, Appraisal__c> triggerOldMap){
        Map<Id, Trade_In__c> trades = new Map<Id, Trade_In__c>();
        for(Appraisal__c app : triggerNew){
            if(app.Trade_In__c != null && triggerOldMap.get(app.Id).Trade_In__c != app.Trade_In__c){
                Trade_In__c trade = new Trade_In__c(Id = app.Trade_In__c, Appraisal__c = app.Id);
                trades.put(trade.Id, trade);
            }
        }

        //Remove reference to the appraisal from a trade if it is removed from an appraisal, running in second block to prevent overwriting Appraisal__c field when two appraisals reference the same trade in a single update
        for(Appraisal__c app : triggerNew){
            if(app.Trade_In__c == null && triggerOldMap.get(app.Id).Trade_In__c != null){
                Trade_In__c trade = new Trade_In__c(Id = triggerOldMap.get(app.Id).Trade_In__c, Appraisal__c = null);
                if(!trades.containsKey(trade.Id)){
                    trades.put(trade.Id, trade);
                }
            }
        }

        if(trades.size() > 0){
            update trades.values();
        }
    }
}