/**
 * DealImpactFormCompiler
 * @description
 */
public without sharing class DealImpactFormCompiler {
	
    /**
     * @description
     */
    public String formId;
	
    /**
     * @description
     */
    public String dealId;
	
    /**
     * @description
     */
    public dealer__Deal__c deal {get;set;}
	
    /**
     * DealImpactFormCompiler
     * @description
     */
    public DealImpactFormCompiler() 
    {
		formId = ApexPages.currentPage().getParameters().get('fid');
		dealId = ApexPages.currentPage().getParameters().get('did');

		if(formId == null ||  dealId == null) {
			// Error
		}
	}

    /**
     * getAllFields 
     * @return void
     * @description
     */ 
    public void getAllFields() 
    {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get('dealer__Deal__c').getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + String.escapeSingleQuotes(fieldName);
            }
        }
 
        String query = 'select ' + commaSepratedFields + ' from dealer__Deal__c where id = \'' + String.escapeSingleQuotes(dealId) + '\' limit 1';
 
        deal = Database.query(query);       
    }

    /**
     * getCompiledForm 
     * @return omponent.Apex.OutputText
     * @description
     */ 
    public Component.Apex.OutputText getCompiledForm() 
    {
        getAllFields();
        Component.Apex.OutputText dvf = new Component.Apex.OutputText();
        if(formId != null) {
            dealer__Form__c form = [Select Id, dealer__Impact_Code__c from dealer__Form__c where Id=:formId limit 1];
            dvf.expressions.value = base64Decode(form.dealer__Impact_Code__c);
        }        
        // dvf.expressions.value = '||2,10,DLE#+2,30,{!deal.dealer__Deal_ID__c}+2,50,ROS+2,70,{!deal.dealer__Stock_Number__c}+||||6,2,{!deal.dealer__Buyer_First_Name__c}+6,30,{!deal.dealer__Co_Buyer_First_Name__c}+6,56,{!$Organization.Name}+|7,2,{!deal.dealer__Buyer_Address__c}+7,30,{!deal.dealer__Co_Buyer_Address__c}+7,56,{!$Organization.Street}+|8,2,{!deal.dealer__Buyer_City__c} {!deal.dealer__Buyer_State__c} {!deal.dealer__Buyer_County__c} {!deal.dealer__Buyer_Postal_Code__c}+8,30,{!deal.dealer__Co_Buyer_City__c} {!deal.dealer__Co_Buyer_State__c} {!deal.dealer__Co_Buyer_County__c} {!deal.dealer__Co_Buyer_Postal_Code__c}+8,56,{!$Organization.City} {!$Organization.State} {!$Organization.PostalCode}+||||||14,13,{!deal.dealer__Make__c}+|15,2,{!deal.dealer__NUO__c}+15,8,{!deal.dealer__Year__c}+15,13,{!deal.dealer__Model__c}+15,24,{!ROUND(deal.dealer__Mileage__c,0)}+15,36,{!deal.dealer__VIN__c}+|||||||||24,48,{!ROUND(deal.dealer__Down_Pymt__c,0)}+|25,5,{!deal.dealer__Rate__c}+25,13,{!deal.dealer__Amt_Financed__c}+25,25,{!deal.dealer__Amt_Financed__c}+25,35,{!deal.dealer__Amt_Financed__c}+25,48,{!deal.dealer__Amt_Financed__c+deal.dealer__Down_Pymt__c}+25,58,N/A+25,71,N/A+25,77,N/A+|26,58,N/A+26,71,N/A+26,77,N/A+|27,67,N/A+27,71,N/A+27,77,N/A+|28,67,N/A+28,71,N/A+28,77,N/A+|29,67,N/A+29,71,N/A+29,77,N/A+|30,67,N/A+30,71,N/A+30,77,N/A+|31,77,N/A+|||||36,5,{!deal.dealer__Term__c-1}+36,28,{!deal.dealer__Monthly_Pymt__c}+36,45,{!deal.dealer__First_Payment_Date__c}+|||||||||||||||||||';
        return dvf;
    }    

    /**
     * base64Decode 
     * @param  s 
     * @return String
     * @description
     */
    public String base64Decode(String s) 
    {
        Blob decodeBlob = EncodingUtil.base64Decode(s);
        String decodeString = decodeBlob.toString();
        if(!decodeString.contains('{!')) {
            return '';
        }
        return decodeString;
    }    	
}