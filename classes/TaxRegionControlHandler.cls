public with sharing class TaxRegionControlHandler {

    public static void setExternalId(List<Tax_Region__c> triggerNew){
        for(Tax_Region__c tr : triggerNew){
            if(tr.ExternalId__c == null){
                List<String> extIdList = new List<String>();
                if(tr.RegionCode__c != null) extIdList.add(tr.RegionCode__c);
                if(tr.Rate__c != null) extIdList.add(String.valueOf(tr.Rate__c));
                if(tr.JurisdictionType__c != null) extIdList.add(tr.JurisdictionType__c);
                if(tr.Rate_Type__c != null) extIdList.add(tr.Rate_Type__c);
                if(tr.ExpirationDate__c != null) extIdList.add(String.valueOf(tr.ExpirationDate__c));
                if(tr.MinTaxableAmount__c != null) extIdList.add(String.valueOf(tr.MinTaxableAmount__c));
                if(tr.MaxTaxableAmount__c != null) extIdList.add(String.valueOf(tr.MaxTaxableAmount__c));
                tr.ExternalId__c = String.join(extIdList,':');
            }
        }
    }

    /**
     * setTaxZoneDates Before Update
     * @param  triggerNew triggerNew description
     */
    public static void setTaxZoneDates(List<Tax_Region__c> triggerNew)
    {
        TaxAPI.setTaxZoneDates(triggerNew);
    }

    public static void expireRegions(List<Tax_Region__c> triggerNew, Map<Id,Tax_Region__c> triggerOldMap){
        
        Map<Id, TaxRegion> expiredRegionMap = new Map<Id, TaxRegion>();
        for(Tax_Region__c tr : triggerNew){
            if(tr.ExpirationDate__c != null && tr.ExpirationRate__c != null){
                //Both Fields needed to kick off this process are populated
                if(triggerOldMap.get(tr.Id).ExpirationDate__c == null || triggerOldMap.get(tr.Id).ExpirationRate__c == null){
                    expiredRegionMap.put(tr.Id, new TaxRegion(tr, new List<TaxJunction__c>()));
                }
            }
        }

        //Query for all tax junctions with the expired region and add to the list.
        if(expiredRegionMap.keySet().size() > 0){
            for(TaxJunction__c tj : [SELECT Id, TaxRegion__c, TaxZone__c FROM TaxJunction__c WHERE TaxRegion__c IN: expiredRegionMap.keySet()]){
                expiredRegionMap.get(tj.TaxRegion__c).taxJunctions.add(tj);
            }
        }

        //Container to hold newly created regions. ParentRegion__c is how we point the new record to the original.
        Tax_Region__c [] newRegions = new List<Tax_Region__c>();
        for(Id trId : expiredRegionMap.keySet()){
            Tax_Region__c tr = expiredRegionMap.get(trId).taxRegion;
            newRegions.add(new Tax_Region__c(
                ParentRegion__c = tr.Id,
                EffectiveDate__c=tr.ExpirationDate__c.addDays(1),
                JurisdictionType__c=tr.JurisdictionType__c,
                MaxTaxFormula__c=tr.MaxTaxFormula__c,
                MaxTaxableFormula__c=tr.MaxTaxableFormula__c,
                MinTaxAmount__c=tr.MinTaxAmount__c,
                MinTaxFormula__c=tr.MinTaxFormula__c,
                MinTaxableAmount__c=tr.MinTaxableAmount__c,
                MinTaxableFormula__c=tr.MinTaxableFormula__c,
                Rate_Type__c=tr.Rate_Type__c,
                Rate__c=tr.ExpirationRate__c,
                RegionCode__c=tr.RegionCode__c
            ));
        }

        if(newRegions.size() > 0){
            insert newRegions;
        }

        //Create new Junctions - Must use original junction's Tax Zone.
        List<TaxJunction__c> newJunctions = new List<TaxJunction__c>();
        for (Tax_Region__c tr : newRegions){
            List<TaxJunction__c> ojunk = expiredRegionMap.get(tr.ParentRegion__c).taxJunctions;
            for(TaxJunction__c tj : ojunk){
                newJunctions.add(new TaxJunction__c(TaxRegion__c = tr.Id, TaxZone__c = tj.TaxZone__c));
            }
        }   

        if(newJunctions.size() > 0 ) {
            insert newJunctions;
        }
    }
    /**
     * Wrapper Container to hold tax junctions part of a region.
     */
    public class TaxRegion{
        public Tax_Region__c taxRegion;
        public List<TaxJunction__c> taxJunctions;
        public TaxRegion(Tax_Region__c taxRegion, List<TaxJunction__c> taxJunctions){
            this.taxRegion = taxRegion;
            this.taxJunctions  = taxJunctions;
        }
    }

}
