/**
* AfterMarketControlHandler
* @description Created 11-22-2016 by Abhishek Goel W-000710. Added updateTaxFields method to update Sales Tax value.
*/

public with sharing class AfterMarketControlHandler {

    public AfterMarketControlHandler() 
    {

    }

    /**
    * updateTaxFields
    * @return void
    * @description Sales Tax field with total price value including tax based on Misc Tax code for deal location.Tax Rate field with tax percent of the record(PartKit)
    */
    public static void updateTaxFields(List<After_Market__c> TriggerNewList)
    {

        Decimal TaxRate;
        Set<Id> SetDealId = new Set<Id>();
        Set<Id> SetMiscId = new Set<Id>();

        Map<Id, String>  mapLocationMiscTaxSetting = new Map<Id,String>();
        Map<Id, Decimal> mapLocationMiscTaxRate = new Map<Id,Decimal>();
        Map<Id, Decimal> mapChargeCodeTaxRate = new Map<Id, Decimal>();

        map<id,Decimal> mapDealTotalTax = new map<id,decimal>();
        map<id,Decimal> mapMiscTax = new map<id,decimal>();

        for(After_Market__c am : TriggerNewList){
            if(am.Misc_Tax_Code__c != null)
            {
                SetMiscId.add(am.Misc_Tax_Code__c);
            }
        }

        for(After_Market__c am: [Select Id, MiscChargeCode__r.PercentageBasedAmount__c, MiscChargeCode__r.FlatAmount__c FROM After_Market__c Where Id IN: TriggerNewList]){
            if(!mapChargeCodeTaxRate.containsKey(am.Id)){
                //if percentage rate is greater than 0 set the rate to the percentage rate else set the rate to the Flat rate.
                mapChargeCodeTaxRate.put(am.Id,  (am.MiscChargeCode__R.PercentageBasedAmount__c != Null && am.MiscChargeCode__r.PercentageBasedAmount__c > 0) 
                    ? am.MiscChargeCode__r.PercentageBasedAmount__c 
                    : (am.MiscChargeCode__r.FlatAmount__c != null) 
                    ? am.MiscChargeCode__R.FlatAmount__c : 0 );
            }
        }

        for(Misc_Tax_Codes__c objMisc: [SELECT id, name, Taxable__c, Percent__c FROM Misc_Tax_Codes__c WHERE id IN: SetMiscId])
        {
            if(objMisc.Taxable__c == true)
            {
                mapMiscTax.put(objMisc.id,objMisc.Percent__c);
            }
        }


        for(After_Market__c am : TriggerNewList){
            if(am.Misc_Tax_Code__c != null && mapMiscTax.containsKey(am.Misc_Tax_Code__c)){

                }else{  
                //Store deal id for AfterMarket records without Misc tax codes
                SetDealId.add(am.Car_Deal__c);
            }
        }

        for(Deal_Tax__c objTax:[SELECT id, Deal__c,Deal__r.Store_Location__r.Tax_Local_Rate__c, Deal__r.Store_Location__r.Tax_Misc__c, Tax_Percentage__c FROM Deal_Tax__c WHERE Deal__c IN:SetDealId]){

                // Null Check
                if(objTax.Tax_Percentage__c == null) {
                    objTax.Tax_Percentage__c = 0;
                }

                // Value Processing
                if(!mapDealTotalTax.containskey(objTax.Deal__c)){
                    mapDealTotalTax.put(objTax.Deal__c, objTax.Tax_Percentage__c);
                }else{
                    mapDealTotalTax.put(objTax.Deal__c, mapDealTotalTax.get(objTax.Deal__c)+objTax.Tax_Percentage__c);
                }
                if(!mapLocationMiscTaxRate.containsKey(objTax.Id)){ 
                    mapLocationMiscTaxRate.put(objTax.Id, objTax.Deal__r.Store_Location__r.Tax_Local_Rate__c);
                }
                if(!mapLocationMiscTaxSetting.containsKey(objTax.Id)){
                    mapLocationMiscTaxSetting.put(objTax.Id, objTax.Deal__r.Store_Location__r.Tax_Misc__c);
                }
            }

            for(After_Market__c am :TriggerNewList){
                TaxRate = 0;

                if(am.Misc_Tax_Code__c != null && mapMiscTax.containsKey(am.Misc_Tax_Code__c)){
                    TaxRate = mapMiscTax.get(am.Misc_Tax_Code__c);
                    }else{
                        TaxRate = mapDealTotalTax.get(am.Car_Deal__c);
                    }

                    if(TaxRate != null){
                        am.Tax_Rate__c = TaxRate.setScale(3, RoundingMode.HALF_UP);
                    }
                    else
                    {
                        am.Tax_Rate__c = 0; 
                    }

                if(am.Type__c == 'Part' && am.Parts_Sale__c !=null){
                    System.debug(am.Parts_Sale__c);
                    am.Sale_Price__c = am.Parts_Sale__c.setScale(2, RoundingMode.HALF_UP);
                }else if(am.Type__c == 'Sublet'){
                    //TBD
                }else if(am.Type__c == 'Labor' && am.Labor_Sale__c !=null){
                    am.Sale_Price__c = am.Labor_Sale__c.setScale(2, RoundingMode.HALF_UP);
                    }else if(am.Type__c == 'Part Kit'){
                    //TBD
                }else if(am.Type__c == 'Misc'){
                    if(mapLocationMiscTaxSetting.get(am.Car_Deal__c) == 'None'){
                        am.Tax_rate__c = 0;
                        }else if(mapLocationMiscTaxSetting.get(am.Car_Deal__c) == 'All'){
                            am.Tax_Rate__c = (mapLocationMiscTaxRate.get(am.Car_Deal__c) != null ? mapLocationMiscTaxRate.get(am.Car_Deal__c) : 0);
                            }else if(mapLocationMiscTaxSetting.get(am.Car_Deal__c) == 'Respect Misc. Charge Code Record'){
                                am.Tax_Rate__c = mapChargeCodeTaxRate.get(am.Id);
                            }
                        }

                        if(am.Taxable__c == false)
                        {
                            am.Sales_Tax__c = 0;
                        }
                        else if(am.Sale_Price__c != null && am.Tax_Rate__c != null){
                            am.Sales_Tax__c = ((am.Sale_Price__c * am.Tax_Rate__c)/100).setScale(2, RoundingMode.HALF_UP);
                        }
                    }
                }

    /**
    * updateSaleValues
    * @return void
    * @description Ensure the Sale_Price and Cost values are set
    */
    public static void updateSaleValues(List<After_Market__c> TriggerNewList) 
    {
        for(After_Market__c am : TriggerNewList) {

            if(am.Type__c=='Part') {
                if(am.Sale_Price__c != null){
                    am.Parts_Sale__c = am.Sale_Price__c;
                }
                if(am.Cost__c != null){
                    am.Part_Cost__c = am.Cost__c;
                }
            } else if(am.Type__c=='Labor') {
                if(am.Labor_Sale__c != null) {
                    am.Sale_Price__c = am.Labor_Sale__c;
                }
                if(am.Labor_Hours__c != null){
                    am.Quantity__c = am.Labor_Hours__c;
                }

                if(am.Labor_Hourly_Cost__c != null) {  
                    am.Cost__c = am.Labor_Hourly_Cost__c;
                }
            } else {
                if(am.Cost__c != null){
                    am.Part_Cost__c = am.Cost__C;
                }
            }
        }
    }
    /**
    *  deleteKitItems
    *  @notes When an After Market 'Header' record is deleted, delete associated lines.
    */
    public static void deleteKitItems(List<After_Market__c> triggerOld){
        System.assert(triggerOld.size() == 1);
        After_Market__c am = triggerOld[0];
        if(am.Car_Deal__c != null && am.Parts_Kit__c != null && am.Type__c == 'Part Kit'){
            After_Market__c [] removeItems = [SELECT Id FROM After_Market__c WHERE Car_Deal__c =: am.Car_Deal__c AND Parts_Kit__c =: am.Parts_Kit__c AND Id !=: am.Id];
            if(removeItems.size() > 0){
                delete removeItems;
            }
        }
    }

    /**
    * createWeOwe 
    * @return void
    * @description
    */
    public static void createWeOwe(List<After_Market__c> TriggerNewList)
    {
        Map<id, After_Market__c> afterMarketMap = new Map<id, After_Market__c>();
        Map<id, id> dealMap = new Map<id, id>();
        Map<id, dealer__We_Owe__c> dealToWeOweMap = new Map<id, dealer__We_Owe__c>();
        List<dealer__We_Owe_Line__c> weOweLines = new List<dealer__We_Owe_Line__c>();
        List<dealer__We_Owe__c> weOwes = new List<dealer__We_Owe__c>();

        Map<dealer__We_Owe__c, dealer__We_Owe_Line__c> weoweToLineMap = new Map<dealer__We_Owe__c, dealer__We_Owe_Line__c >();

        for(After_Market__c am :TriggerNewList){
            if(am.dealer__Car_Deal__c != null){
                afterMarketMap.put(am.id, am);
                dealMap.put(am.dealer__Car_Deal__c, am.dealer__Car_Deal__c);              
            }
        }

        for(dealer__We_Owe__c weowe :[Select Id, Name, dealer__Car_Deal__c From dealer__We_Owe__c Where dealer__Car_Deal__c IN :dealMap.keySet()]){
          dealToWeOweMap.put(weowe.dealer__Car_Deal__c, weowe);
      }
      
      for(After_Market__c am :afterMarketMap.values()){
        if(dealToWeOweMap.get(am.dealer__Car_Deal__c) == null){
            dealer__We_Owe__c weowe = new dealer__We_Owe__c(dealer__Car_Deal__c = am.dealer__Car_Deal__c);
            dealer__We_Owe_Line__c weOweLine = new dealer__We_Owe_Line__c();
            weOweLine.dealer__Account__c = am.dealer__Vendor__c;
            weOweLine.dealer__Cost__c = am.dealer__Cost__c;
            weOweLine.dealer__Description__c = am.dealer__Description__c;
            weOweLine.dealer__Labor_Hours__c = am.dealer__Labor_Hours__c;
            weOweLine.dealer__Labor_Sale__c = am.dealer__Labor_Sale__c;
            weOweLine.dealer__List_Price__c = am.dealer__List_Price__c;
            weOweLine.dealer__Parts_Kit__c = am.dealer__Parts_Kit__c;
            weOweLine.dealer__Parts_Sale__c = am.dealer__Parts_Sale__c;
            weOweLine.dealer__Sale_Price__c = am.dealer__Sale_Price__c;
            weOweLine.dealer__Taxable__c = am.dealer__Taxable__c;
            weOweLine.dealer__After_Market_Id__c = am.Id;            
            weoweToLineMap.put(weOwe, weOweLine);
            }else{
                dealer__We_Owe_Line__c weOweLine = new dealer__We_Owe_Line__c();
                weOweLine.dealer__Account__c = am.dealer__Vendor__c;
                weOweLine.dealer__Cost__c = am.dealer__Cost__c;
                weOweLine.dealer__Description__c = am.dealer__Description__c;
                weOweLine.dealer__Labor_Hours__c = am.dealer__Labor_Hours__c;
                weOweLine.dealer__Labor_Sale__c = am.dealer__Labor_Sale__c;
                weOweLine.dealer__List_Price__c = am.dealer__List_Price__c;
                weOweLine.dealer__Parts_Kit__c = am.dealer__Parts_Kit__c;
                weOweLine.dealer__Parts_Sale__c = am.dealer__Parts_Sale__c;
                weOweLine.dealer__Sale_Price__c = am.dealer__Sale_Price__c;
                weOweLine.dealer__Taxable__c = am.dealer__Taxable__c;
                weOweLine.dealer__We_Owe__c = dealToWeOweMap.get(am.dealer__Car_Deal__c).Id;
                weOweLine.dealer__After_Market_Id__c = am.Id;
                weOweLines.add(weOweLine);

            }
        }
        
        /* Temporarily commented out.
        List<dealer__We_Owe__c> weoweLst = new List<dealer__We_Owe__c>(); 
        weoweLst.addAll(weoweToLineMap.keyset());
        if(weoweLst.size() > 0){
            //  insert weoweLst;
        }

        for(dealer__We_Owe__c we :weoweToLineMap.keyset()){
            dealer__We_Owe_Line__c weoweLine = weoweToLineMap.values();  // Needs to be bulkfied. 
            weoweLine.dealer__We_Owe__c = we.Id;
            weOweLines.add(weoweLine);
        }

        if(weOweLines.size() > 0){
            // insert weOweLines;
        }
        */
    } 

    /**
     * deleteTaxTransactionItems 
     * @return void
     * @description Deletes any referenced tax transaction items based on the lit of aftermarkets passed.
     */
    public static void deleteTaxTransactionItems(List<After_Market__c> triggerList)
    {
        Set<Id> amIds = new Set<Id>();
        
        for(After_Market__c am : triggerList)
        {
            amIds.add(am.Id);
        }

        // Delete the associated records
        List<TaxTransactionItem__c> existingTItems = [SELECT Id FROM TaxTransactionItem__c WHERE AfterMarketItem__c IN:amIds];
        
        delete existingTItems;
    }

}