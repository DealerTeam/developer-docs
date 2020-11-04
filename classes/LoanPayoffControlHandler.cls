public with sharing class LoanPayoffControlHandler {

    public static void updateAppraisalTotalPayoff(List<LoanPayoff__c> triggerNew)
    {
        Set<Id> apprIds = new Set<Id>();
        List<Appraisal__c> apprUpdate = new List<Appraisal__c>();
        
        //Consider the payoffs in the trigger first
        for(LoanPayoff__c lp : triggerNew){
            if(lp.Appraisal__c != null) apprIds.add(lp.Appraisal__c);
        }
               
        // Next acquire other existing payoffs not in the trigger
        LoanPayoff__c [] lpList = [SELECT Id, Appraisal__c, PayoffAmount__c 
                                   FROM LoanPayoff__c WHERE Appraisal__c IN: apprIds];
        if(lpList.size() > 0){
            Map<Id, Decimal > apprMap = new Map<Id, Decimal >();
            for(LoanPayoff__c lp : lpList){
                if(lp.Appraisal__c != null){
                    Decimal payoffAmt = lp.PayoffAmount__c != null ? lp.PayoffAmount__c : 0;
                    if(apprMap.get(lp.Appraisal__c) == null){
                        apprMap.put(lp.Appraisal__c, payoffAmt);
                    } else {
                        payoffAmt += apprMap.get(lp.Appraisal__c);
                        apprMap.put(lp.Appraisal__c, payoffAmt);
                    }
                }
            }
            for(Id i : apprMap.keySet()){
                apprUpdate.add(new Appraisal__c(
                    Id=i,
                    TotalPayoff__c = apprMap.get(i)
                ));
            }
        } else { //No LPs exist for this appraisal, set to 0
            for(Id i : apprIds){
                apprUpdate.add(new Appraisal__c(
                    Id = i,
                    TotalPayoff__c = 0
                ));
            }
        }
        if(apprUpdate.size() > 0)
            update apprUpdate;

    }
}