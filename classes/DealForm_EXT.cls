/**
 * DealForm_EXT 
 * @description Mobility Deal Controller Extension
 */
global without sharing class DealForm_EXT {

    /**
     * @description
     */
    global String dealId {get;set;}
    
     /**
     * @description
     */
    global Decimal vehRetailPrice {get;set;}
    
     /**
     * @description
     */
    global Map<String, String> urlParams = new Map<String, String>();
    
     /**
     * @description
     */
    global dealer__Deal__c deal {get;set;}
    
     /**
     * @description
     */
    global dealer__Sales_Up__c sup {get;set;}
    
     /**
     * @description
     */
    global Decimal TradeTaxCredit {get;set;}

    /**
     * @description Forms Variables
     */
    global Decimal serviceContractPremium {get;set;}

    /**
     * @description Constructor
     */
    global DealForm_EXT(ApexPages.StandardController controller) 
    {

        urlParams  = ApexPages.currentPage().getParameters();

        dealId = urlParams.get('id');
        TradeTaxCredit = calcTradeTaxCredit();
		Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Deal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        af.addAll(fieldnames);
        af.add('dealer__Vehicle__r.RecordType.DeveloperName');
        if(!Test.isRunningTest()) 
        {
            controller.addFields(af);
        }
        
        deal = (dealer__Deal__c)controller.getRecord();
        deal.Conversion_Price__c = deal.Conversion_Price__c == null ?  0 : deal.Conversion_Price__c;
        deal.Conversion_Discount__c = deal.Conversion_Discount__c == null ?  0 : deal.Conversion_Discount__c;
        serviceContractPremium=getServiceContractTotal();
    }

    /**
     * DealForm_EXT 
     * @description
     */
    global DealForm_EXT()
    {        
        urlParams  = ApexPages.currentPage().getParameters();
        dealId = urlParams.get('id');
   	}
    
    /**
     * getVehRetail 
     * @return Decimal
     */
    global Decimal getVehRetail()
    {
        try{
            return [SELECT dealer__Vehicle__r.dealer__Retail_Price__c FROM dealer__Deal__c WHERE Id =: dealId].dealer__Vehicle__r.dealer__Retail_Price__c;
        } catch (DMLException e){
            system.debug(e.getMessage());
            return 0;
        }
    }
    
    /**
     * SoldOnProposal
     * @return List<dealer__Service_Contract__c>
     * @description getter for service contracts sold on proposal
     */ 
    global List<dealer__Service_Contract__c> soldOnProposal 
    {
        get {
            if(dealId!=null) {
                return [SELECT dealer__Contract_Template__c, dealer__Cost__c, 
                                            dealer__Customer_Contact__c, dealer__Customer__c, dealer__Deductable__c, dealer__Description__c, 
                                            dealer__End_Date__c, dealer__Expiration_Mileage__c, dealer__Expiration_Months__c,
                                            dealer__Plan_Code__c, dealer__Product_Code__c, dealer__Sale_Price__c, dealer__Service_Vehicle__c, 
                                            dealer__Start_Date__c, dealer__Vehicle_Inventory__c, Name, Id 
                                            FROM dealer__Service_Contract__c 
                                            Where dealer__Car_Deal__c =: dealId
                                            Limit 100];             
            } else {
                return new List<dealer__Service_Contract__c>();
            }
        }
        set;
    }
    
    /**
     * calcTradeTaxCredit description
     * @return decimal
     * @description
     */ 
    global decimal calcTradeTaxCredit()
    {
        dealer__Deal__c d = new dealer__Deal__c();
        Decimal tradeTax = 0;
        if( dealId != null){
            try{
                d = [SELECT id, Order__c, dealer__NUO__c, dealer__Trade_Allowance__c,  dealer__Store_Location__r.dealer__Tax_Trade__c, 
                            dealer__Store_Location__r.dealer__Tax_Trade_In_Used__c, 
                            dealer__Store_Location__r.dealer__Max_Trade_Tax_Amount__c,
                            dealer__Vehicle__r.RecordType.Name
                            FROM dealer__Deal__c where Id =: dealId];
            }catch(QueryException e){}
            if(d != null){
                Boolean taxNew = d.dealer__Store_Location__r.dealer__Tax_Trade__c;
                Boolean taxUsed = d.dealer__Store_Location__r.dealer__Tax_Trade_In_Used__c;
                Decimal maxTradeTax = d.dealer__Store_Location__r.dealer__Max_Trade_Tax_Amount__c;
                
                String NewOrUsed = 'New';
                if(!d.Order__c){
                    NewOrUsed= d.dealer__Vehicle__r.RecordType.Name == 'New'?'New':'Used';
                }  else if (d.Order__c){
                    newOrUsed = d.dealer__NUO__c == 'New' ? 'New' : 'Used';
                }
                
                if( (NewOrUsed == 'New' && !taxNew) || (NewOrUsed != 'New' && !taxused) ){
                    return 0;
                } 
                tradeTax = d.dealer__Trade_Allowance__c;
                if(maxTradeTax != null && maxTradeTax > 0){
                    tradeTax = tradeTax > maxTradeTax ? maxTradeTax : tradeTax;
                }
            }
        }
        return tradeTax;
    }
    
    /**
     * @description
     */
    global List<dealer__Trade_In__c> tradeInList 
    {
    
        get {
       
            if(dealId!=null) {
            return [SELECT dealer__Car_Deal__c, dealer__ACV__c, dealer__Appraisal_Date__c, dealer__Appraised_By__c, dealer__Black_Book_Retail__c, 
                        dealer__Black_Book_Wholesale__c, dealer__K_B_B_Retail__c, dealer__K_B_B_Wholesale_Value__c, dealer__Lost_Trade__c, 
                        dealer__Make__c, dealer__Model__c, dealer__NADA_Retail__c, dealer__NADA_Wholesale__c, dealer__Odometer_at_Trade_In__c, 
                        dealer__Pay_Off_Amount__c, dealer__Pay_Off_Expiration_Date__c, dealer__Pay_Off_To__c, dealer__Position__c, 
                        dealer__Stock_Number__c, dealer__Trade_Allowance__c, dealer__VIN__c, dealer__Year__c, Id, Name
                        FROM dealer__Trade_In__c
                        Where dealer__Car_Deal__c=:dealId
                        limit 3];
            } else {
                return new List<dealer__Trade_In__c>();
            }
        }
        set;
    }

    /**
     * @description
     */
    global List<dealer__After_Market__c> selectedKits
    {
        get {
            if(dealId != null) {
                return [SELECT Id, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, dealer__Car_Deal__c, 
                dealer__Company_Number__c, dealer__Cost__c, dealer__Quantity__c, dealer__Description__c, dealer__Labor_Sale__c, dealer__List_Price__c, 
                dealer__Parts_Kit__c, dealer__Parts_Sale__c, dealer__Sale_Price__c, dealer__Vendor__c,dealer__Printable__c,
                dealer__Taxable__c, dealer__Sales_Tax__c 
                FROM dealer__After_Market__c
                Where dealer__Car_Deal__c =: dealId 
                and dealer__Car_Deal__c != null
                Order By dealer__Order__c ASC
                Limit 500];
            } else {
                return new List<dealer__After_Market__c>();
            }
        }
        set;
    }
    
    /**
     * getAutoGrantPayor
     * @description
     */
    global Account getAutoGrantPayor()
    {
        return null;
    }
    
    /**
     * getPayor1 
     * @description
     */
    global Account getPayor1()
    {
        if( dealId != null){
            try{
                 Id payorId = [SELECT dealer__Deferred_1_Payee__c FROM dealer__Deal__c WHERE Id=:dealId].dealer__Deferred_1_Payee__c;
            if(payorId != null)
                return[SELECT Name,Phone, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
            } catch (Exception e){
                return null;
            }
        }
        return null;
    }
     global Account getPayor2(){
        if( dealId != null){
            try{
                Id payorId = [SELECT dealer__Deferred_2_Payee__c FROM dealer__Deal__c WHERE Id=:dealId].dealer__Deferred_2_Payee__c;
                if(payorId != null)
                    return[SELECT Name,Phone, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
            } catch (Exception e){
                return null;
            }
        }
        return null;
    }
     global Account getPayor3(){
        if( dealId != null){
            try{
                Id payorId = [SELECT dealer__Deferred_3_Payee__c FROM dealer__Deal__c WHERE Id=:dealId].dealer__Deferred_3_Payee__c;
                if(payorId != null)
                    return[SELECT Name, BillingStreet,BillingCity,BillingState, BillingPostalCode From Account WHERE Id =: payorId];
            } catch (Exception e){
                return null;
            }
        }
        return null;
    }
    
    /**
     * getServiceContractTotal 
     * @return Decimal
     */
    global Decimal getServiceContractTotal() 
    {
		if(dealId==null) {
			return 0;
		}

		AggregateResult ar = [SELECT SUM(dealer__Sale_Price__c) sum FROM dealer__Service_Contract__c where dealer__Car_Deal__c =:dealId];
		return ar != null ? (Decimal) ar.get('sum') : 0;
	}

        global List<SelectOption> getLeadSourcePicklist() {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = dealer__Sales_Up__c.dealer__Source__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            if(f.isDefaultValue()){
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }
        }
        for( Schema.PicklistEntry f : ple) {
            if( !f.isDefaultValue()){
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }
        }       
        return options;
    }

    /**
     * getLeadTypePicklist 
     * @return List<SelectOption>
     */ 
    global List<SelectOption> getLeadTypePicklist() 
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = dealer__Sales_Up__c.dealer__Lead_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple) {
            if(f.isDefaultValue()){
                options.add(new SelectOption(f.getLabel(),f.getValue()));
            }
        }
        for( Schema.PicklistEntry f : ple) {
            if( !f.isDefaultValue()){
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            }
        }       
        return options;
    }

    /**
     * getDiscounts 
     * @return List<dealer__Discount_Rebate__c>
     * @description
     */
    global List<dealer__Discount_Rebate__c> getDiscounts() 
    {

        List<dealer__Discount_Rebate__c> discs = new List<dealer__Discount_Rebate__c>();

        if(dealId!=null) {
            discs = [SELECT Id, Name, dealer__Type__c, dealer__Amount__c, dealer__Desc__c FROM dealer__Discount_Rebate__c WHERE dealer__Deal__c =: dealId ORDER BY dealer__Type__c ASC];
        }
        return discs;
    }
    
    /**
     * getTaxableFees 
     * @return List<dealer__Sales_Fee__c>
     * @description
     */
    global List<dealer__Sales_Fee__c> getTaxableFees()
    {
        if(dealId==null)
        return new List<dealer__Sales_Fee__c>();
        List <dealer__Sales_Fee__c> fees = [SELECT dealer__Type__c, dealer__Taxable__c, dealer__Fee_Code__c, 
            dealer__Default_Amount_Formula_Field__c, dealer__Default_On_Deal_Formula_Field__c, dealer__Default_Formula_Field__c, 
            dealer__Fee_Name__c, dealer__Description__c, dealer__Car_Deal__c, dealer__Fee_Amount__c, Name, Id 
            FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c =:dealId and dealer__Taxable__c = true];
        return fees != null ? fees : new List<dealer__Sales_Fee__c>();
    }
    
    /**
     * getNonTaxableFees 
     * @return List<dealer__Sales_Fee__c>
     * @description
     */
    global List<dealer__Sales_Fee__c> getNonTaxableFees()
    {
        if(dealId==null)
        return new List<dealer__Sales_Fee__c>();
        List <dealer__Sales_Fee__c> fees = [SELECT dealer__Type__c, dealer__Taxable__c, dealer__Fee_Code__c, 
            dealer__Default_Amount_Formula_Field__c, dealer__Default_On_Deal_Formula_Field__c, dealer__Default_Formula_Field__c, 
            dealer__Fee_Name__c, dealer__Description__c, dealer__Car_Deal__c, dealer__Fee_Amount__c, Name, Id 
            FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c =:dealId AND dealer__Taxable__c = false];
        return fees != null ? fees : new List<dealer__Sales_Fee__c>();
    }

    /**
     * getTotalTradeGross description
     * @return Decimal
     * @description
     */
    global Decimal getTotalTradeGross() 
    {
        Decimal totTradeGross = 0;
        // Allowance - payoff
        for(dealer__Trade_In__c t:  tradeInList ){
            totTradeGross += (t.dealer__Trade_Allowance__c - t.dealer__Pay_Off_Amount__c);
        }
        return totTradeGross;
    }

    /**
     * getTotalAllowance 
     * @return Decimal
     * @description
     */
    global Decimal getTotalAllowance() 
    {

        Decimal totAllowance = 0;

        for(dealer__Trade_In__c t:  tradeInList ){
            totAllowance += t.dealer__Trade_Allowance__c;
        }
        return totAllowance;
    }
    
    /**
     * getShowTradeAllowance 
     * @return boolean
     * @description
     */
    global boolean getShowTradeAllowance() 
    {
        
        if(dealId==null || Test.isRunningTest())
            return false;
        
        dealer__Deal__c d = [SELECT Id, dealer__Vehicle__c, dealer__Vehicle__r.RecordType.DeveloperName, dealer__Order__c FROM dealer__Deal__c WHERE Id=:dealId LIMIT 1];
                
        if(d.dealer__Order__c==true)
            return true;
        
        if(d.dealer__Vehicle__c!=null && ( deal.dealer__Vehicle__r.RecordType.DeveloperName == 'New'
                	|| d.dealer__Vehicle__r.RecordType.DeveloperName == 'Consignment'
               		|| d.dealer__Vehicle__r.RecordType.DeveloperName == 'Demo'
         		)
            ) {
                return true;
            }  
        return false;
    }

    /**
     * getInvoiceLogo 
     * @return String
     * @description
     */
    global String getInvoiceLogo() 
    {
        
        String url = '';
        try{
			Id dealLocationId = [SELECT id, dealer__Store_Location__c FROM dealer__Deal__c WHERE Id =: dealId].dealer__Store_Location__c; 
        	dealer__Dealer_Location__c loc = [Select Id, dealer__Logo_Name__c from dealer__Dealer_Location__c where Id =: dealLocationId];
        	url = dealer.DealershipLocationAPI.formLogoURL(loc.Id);
        }catch(Exception e){
            e.getMessage();
        }
        return url;
    } 
    
    /**
     * createBlankDeal 
     * @param  jsonPayload 
     * @return Id
     * @description
     */
    @RemoteAction
    global static Id createBlankDeal(String jsonPayload) 
    {
        
        return null;
    }

}