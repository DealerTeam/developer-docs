global class FormAPI{

    global Static String mergeForms(Id dealId, List<Form__c> forms) {
        return FormAPI.bundleForms(dealId, forms);
    }
    
    public static List<String> getObjectFieldNames(){
        // Only Deal Object supported for impact printing
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Deal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        for(String fn : fieldnames) {
          af.add('{!'+fn+'}');
        }
        return af;
        // af.addAll(fieldnames);  
    }
    
    public static String getObjectFieldNamesSimple(){
        // Only Deal Object supported for impact printing
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Deal__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 

        // Generate Response
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();

        for(String fn : fieldnames) {
          //gen.writeString(fn);

          //af.add('{!'+fn+'}');
          //af.add(fn);
            gen.writeStartObject();
              //gen.writeStringField('name', fn);
              gen.writeStringField('name', '{!deal.' + fn +'}');
              gen.writeStringField('value', '{!deal.' + fn +'}');
            gen.writeEndObject();
        }
        // af.addAll(fieldnames);  

        gen.writeEndArray();
        return gen.getAsString(); 
        
    }
    
    public static Component.Apex.OutputText getPreview(dealer__Form__c form){
        Component.Apex.OutputText ot = new Component.Apex.OutputText();

        if(form.dealer__Impact_Code__c!=null && form.dealer__Impact_Code__c.Length()>0){
          ot.expressions.value = base64Decode(form.dealer__Impact_Code__c);
        }
        
        return ot ;
        
    }
    
    public static Component.Apex.OutputText getFDF(dealer__Form__c form) {

        Component.Apex.OutputText ot = new Component.Apex.OutputText();

        if(form.dealer__FDF_Code__c!=null && form.dealer__FDF_Code__c.Length()>0){
          ot.expressions.value = form.dealer__FDF_Code__c;
        }
        return ot ;    
    }

    public static String bundleForms(Id dealId, List < Form__c > forms) {
        Map < String, String > fdfMap = new Map < String, String > ();
        List < String > vfResource = new List < String > ();
        system.assert(dealId != null, 'A proper deal Id must be submitted to print this form.');
        system.assert(forms.size() > 0, 'At least one  form must be submitted.');

        List < Form__c > fdfForms = new List < Form__c > ();
        List < Form__c > laserForms = new List < Form__c > ();

        for (Form__c f: forms) {
            Map < String, Object > fieldsToCheck = f.getPopulatedFieldsAsMap();
            system.assert(fieldsToCheck.get('dealer__Print_Type__c') != null, 'Form Print Type needed to print this form.');
            if (f.Print_Type__c == 'FDF') {
                system.assert(fieldsToCheck.get('dealer__DocumentContentId__c') != null, 'DocumentContentId__c needed to print a FDF Form');
                fdfForms.add(f);
            } else if (f.Print_Type__c == 'Laser') {
                laserForms.add(f);
            }
        }
        fdfMap = generateFDF(dealId, fdfForms);
        vfResource = createRemoteVFResource(dealId, laserForms);

        String jsonBody;
        try {
            jsonBody = generateBodyJSON(fdfMap, vfResource);

        } catch (JSONException e) {
            throw new JSONException(e.getMessage());
        }
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://apsv1.dealerteam.com/docgen/merge/');
        req.setMethod('POST');
        req.setBody(jsonBody);

        try {
            
            if(!Test.isRunningTest()) {
	            res = http.send(req);
     	       return res.getBody();
            }

        } catch (System.CalloutException e) {
            throw new FormAPIException(e.getMessage());
        }

        return null;
    }

    private static List < String > createRemoteVFResource(Id dealId, List < Form__c > forms) {
        List < String > body = new List < String > ();
        for (Form__c f: forms) {
            system.assert(f.Page_Name__c != null, 'A form name must be included to print a laser form.');
            PageReference pdf = new PageReference('/apex/' + f.Page_Name__c);
            pdf.getParameters().put('id', dealId);
            try {
                if(Test.isRunningTest()) { 
                    blob pdfBody;
                    pdfBody = blob.valueOf('Unit.Test');
                    body.add(EncodingUtil.base64Encode(pdfBody));
                } else {
                body.add(EncodingUtil.base64Encode(pdf.getContent()));
                }
            } catch (VisualforceException e) {
                throw new VisualforceException('Problem printing document: ' + e.getMessage());
            }
        }

        return (body.size() > 0 ? body : new List < String > ());
    }

    private static Map < String, String > generateFDF(Id dealId, List < Form__c > forms) {

        // Obtain DMS Settings 
        DMS_Settings__c dms = Utility.getDMSSettings();
        // Set Rendering Engine
        String FDF_Renderer = (dms.FDF_Renderer__c!=null && dms.FDF_Renderer__c!='') ? dms.FDF_Renderer__c : 'dealer__FormFDFData';


        Map < String, String > formMap = new Map < String, String > ();
        for (Form__c f: forms) {
            if (f.FDF_Code__c != null && f.FDF_Code__c.Length() > 0) {

                String urlPR = '/apex/' + FDF_Renderer + '?fid=' + f.Id + '&did=' + dealId;
                PageReference p = new PageReference(urlPR);
                Blob uContent;
                if (Test.isRunningTest()) {
                    uContent = blob.valueof('TEST');
                } else {
                    uContent = p.getContent();
                }
                if (uContent != null) {
                    formMap.put(f.DocumentContentId__c, EncodingUtil.base64Encode(uContent));
                }
            }
        }
        return formMap.size() > 0 ? formMap : new Map < String, String > ();
    }

    public class formWrapper {
        String documentId;
        String docType;
        String content;
        String mergeData;

        public formWrapper(String documentId, String docType, String content, string mergeData) {
            documentId = documentId;
            docType = docType;
            content = content;
            mergedata = mergedata;
        }
    }

    private static String generateBodyJSON(Map < String, String > fdfMap, List < String > forms) {
        Json j = new Json();

        JSONGenerator gen = JSON.createGenerator(true);
        List < formWrapper > formList = new List < formWrapper > ();

        for (String dId: fdfMap.keyset()) {
            formWrapper f = new formWrapper('', '', '', '');
            f.documentId = dId;
            f.docType = 'FDF';
            f.content = '';
            f.mergeData = fdfMap.get(dId);
            formList.add(f);
        }
        for (String pdf: forms) {
            formWrapper f = new formWrapper('', '', '', '');
            f.documentId = '';
            f.docType = 'Laser';
            f.content = pdf;
            f.mergeData = '';
            formList.add(f);
        }

        gen.writeStartObject();
        gen.writeFieldName('Forms');
        gen.writeObject(formList);
        gen.writeEndObject();

        system.debug('g ' + gen.getAsString());
        return gen.getAsString();
    }

    
    public static String base64Decode(String s) {
        if (Utility.IsBlank(s)) {
          return '';
        }

        Blob decodeBlob = EncodingUtil.base64Decode(s);
        String decodeString = decodeBlob.toString();
        if(!decodeString.contains('{!')) {
          return '';
        }
        return decodeString;
    }

    public static Form__c processFeeVariables(Form__c form, Deal__c deal) {
        
        if(form.FDF_Code__c == null || form.FDF_Code__c == '' || deal.Id == null) {
            return form;
        }

        // Isolate Form for Replace
        String formInMemory = '';

        // Perform the correct replace action
        Map<String, dealer__Sales_Fee__c> feeMap = FormAPI.retrieveFees(deal);
        
        String[] lines = form.dealer__FDF_Code__c.split('\n');

        for(String s : lines) {
            // String replace all fees 
            if(s.contains('{!fee')) {
                // obtian the isolated variable from the string
                Integer pos_start     =   s.indexOf('{!fee['); //7
                Integer pos_var_start =   pos_start + 6;    
                Integer pos_var_end   =   s.lastIndexOf(']}'); //
                Integer pos_end       =   pos_var_end + 2;

                String subString = s.substring((Integer)pos_var_start, (Integer)pos_var_end);
                String subReplace = s.substring((Integer)pos_start, (Integer)pos_end);

                if(feeMap.get(subString)!=null) {
                    s = s.replace(subReplace, String.valueOf(feeMap.get(subString).Fee_Amount__c));
                }
            }

            formInMemory += s;
        }

        form.dealer__FDF_Code__c = formInMemory;

        return form;
    }
    
    public static dealer__Appraisal__c lookupAppraisal(Id aprId) {

        Appraisal__c appraisal = (Appraisal__c)Utility.queryAllFields('dealer__Appraisal__c',aprId);
        
        //Preferably, the code below could be achieved with one Utility.queryAllFields Call
        // Option for the future - Create overloaded Utility.queryAllFields. 
        // Utility.QueryAllFields(ObjectName,objectId, String[ListOfRelatedObjectsToInclude]);

        if(appraisal.Service_Vehicle__c != null){
            appraisal.Service_Vehicle__r = (Service_Vehicle__c)Utility.queryAllFields('dealer__Service_Vehicle__c',appraisal.Service_Vehicle__c);
        }
        if(appraisal.dealer__Sales_Up__c != null){
            appraisal.Sales_Up__r = (Sales_Up__c)Utility.queryAllFields('dealer__Sales_Up__c',appraisal.Sales_Up__c);
        }
        if(appraisal.Store_Location__c != null){
            appraisal.Store_Location__r = (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c',appraisal.Store_Location__c);
        }
        if(appraisal.Vehicle_Owner__c != null){
            appraisal.Vehicle_Owner__r = (Account)Utility.queryAllFields('Account',appraisal.Vehicle_Owner__c);
        }

        return appraisal;
    }

    public static dealer__Deal__c lookupDeal(Id dealId) 
    {   
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c',dealId);

        //Preferably, the code below could be achieved with one Utility.queryAllFields Call
        // Option for the future - Create overloaded Utility.queryAllFields. 
        // Utility.QueryAllFields(ObjectName,objectId, String[ListOfRelatedObjectsToInclude]);

        if(deal.Vehicle__c != null){
            deal.Vehicle__r = (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c',deal.Vehicle__c);
        }
        if(deal.Store_Location__c != null){
            deal.Store_Location__r = (Dealer_Location__c)Utility.queryAllFields('dealer__Dealer_Location__c',deal.Store_Location__c);
        }
        if(deal.dealer__Finance_Institution_Account__c != null){
            deal.dealer__Finance_Institution_Account__r = (Finance_Company__c)Utility.queryAllFields('dealer__Finance_Company__c',deal.dealer__Finance_Institution_Account__c);
        }
        if(deal.dealer__Salesperson_1__c != null){
            deal.SalesPerson_1__r = [SELECT Id, Name, dealer__Dealership_Location__c, dealer__Flat_Rate_Hourly_Wage__c, dealer__Flat_Rate_Technician__c, dealer__In_BDC__c, dealer__License_Type__c, dealer__LocationId__c, dealer__Service_Advisor__c, dealer__Technician__c FROM User WHERE Id =: deal.dealer__Salesperson_1__c];
        }

        return deal;
    }
    
    public static List<dealer__Trade_In__c> lookupTradeIns(Id dealId) {
        if(dealId != null){
            List<String> tiIds = new List<String>();
            for(Trade_In__c ti : [SELECT Id FROM Trade_In__c WHERE Car_Deal__c =: dealId]){
                tiIds.add(ti.Id);
            }
            if(tiIds.size()>0){
                List<Trade_In__c> tradeInList = (List<Trade_In__c>)Utility.queryAllFields('dealer__Trade_In__c',tiIds);
                Map<Id,Trade_In__c> tradeInMap = new Map<Id,Trade_In__c>();
                for(Trade_In__c tradeIn : tradeInList){
                    tradeInMap.put(tradeIn.Id, tradeIn);
                }
                List<Trade_In__c> returnList = new List<Trade_In__c>();

                List<String> fieldsToQuery = new List<String>();
                fieldsToQuery.add('dealer__Pay_Off_Account__r.Name');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.BillingStreet');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.BillingCity');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.BillingState');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.BillingPostalCode');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.BillingCountry');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.ShippingStreet');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.ShippingCity');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.ShippingState');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.ShippingPostalCode');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.ShippingCountry');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.Fax');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.Phone');
                fieldsToQuery.add('dealer__Pay_Off_Account__r.Website');

                String query = 'SELECT Id, '+String.join(fieldsToQuery,', ')+' FROM Trade_In__c WHERE Car_Deal__c =: dealId';
                for(Trade_In__c ti : Database.query(query) ){
                    Trade_In__c thisTrade = tradeInMap.get(ti.Id);
                    thisTrade.Pay_Off_Account__r = ti.Pay_Off_Account__r;
                    returnList.add(thisTrade);
                }
            return returnList;
            }
        }
        return new List<Trade_In__c>();
    }
    
    public static Account getBuyer(dealer__Deal__c deal) {
        if(deal != null && deal.dealer__Buyer__c != null) {
            return (Account)Utility.queryAllFields('Account',deal.Buyer__c);
        } 
        return new Account();
    }
    
    public static Account getCoBuyer(dealer__Deal__c deal) {
        if(deal != null && deal.dealer__Co_Buyer__c != null) {
            return (Account)Utility.queryAllFields('Account',deal.Co_Buyer__c);
        } 
        return new Account();
    }
    
    public static Boolean getisPersonAccount(dealer__Deal__c deal) {
        if(deal != null && deal.dealer__Buyer__c != null) {

          Account retA = [SELECT isPersonAccount FROM Account Where Id =:deal.dealer__Buyer__c Limit 1];

          return retA.isPersonAccount;
        } 

        return null;
    }
    
    public static List<dealer__Deal_Tax__c> retreiveTaxList(dealer__Deal__c deal) {
        if(deal != null) {
            List<String> dtIds = new List<String>();
            for(Deal_Tax__c dt: [SELECT Id FROM Deal_Tax__c WHERE Deal__c =: deal.Id And IsDeleted=False]){
                dtIds.add(dt.Id);
            }
            if(dtIds.size()>0){
                return (List<Deal_Tax__c>)Utility.queryAllFields('dealer__Deal_Tax__c',dtIds);
            }
        }
        return new List<Deal_Tax__c>();
    }
    
    public static List<dealer__Discount_Rebate__c> retreiveDiscountList(dealer__Deal__c deal) {
       
        if(deal.Id != null) {
            List<String> drIds = new List<String>();
            for(Discount_Rebate__c dr: [SELECT Id FROM Discount_Rebate__c WHERE Deal__c =: deal.Id And IsDeleted=False]){
                drIds.add(dr.Id);
            }
            if(drIds.size()>0){
                return (List<Discount_Rebate__c>)Utility.queryAllFields('dealer__Discount_Rebate__c',drIds);
            }
        }
        return new List<Discount_Rebate__c>();
    }
    
    public static List<dealer__After_Market__c> retreiveAftermarketList(dealer__Deal__c deal) {

        if(deal.Id != null) {
            List<String> AmIds = new List<String>();
            For(dealer__After_Market__c am : [SELECT Id FROM dealer__After_Market__c WHERE Car_Deal__c =: deal.Id AND IsDeleted = False]){
                AmIds.add(am.Id);
            }
            if(AmIds.size() > 0){
                return (List<After_Market__c>)Utility.queryAllFields('dealer__After_Market__c',AMIds);
            }
        }
        return new List<After_Market__c>();
    }
    
    public static List<dealer__Service_Contract__c> retreiveServiceContractList(dealer__Deal__c deal) {

        if(deal.Id != null) {
            List<String>scIds = new List<String>();
            for(dealer__Service_Contract__c sc : [SELECT Id FROM Service_Contract__c WHERE Car_Deal__c =: deal.Id AND IsDeleted = false]){
                scIds.add(sc.Id);
            }
            if(scIds.size()>0){
                return (List<Service_Contract__c>)Utility.queryAllFields('dealer__Service_Contract__c',scIds);
            }
        }
        return new List<Service_Contract__c>();
    }

    public static Map<String, dealer__Sales_Fee__c> retrieveFees(Deal__c deal) {
        Map<String, Sales_Fee__c> salesFees = new Map<String, Sales_Fee__c>();
        String feeNameFormatted = '';
        for(Sales_Fee__c sf : [SELECT Fee_Name__c, Car_Deal__c, Fee_Amount__c, Name, Id FROM Sales_Fee__c WHERE Car_Deal__c =:deal.Id]) {
            feeNameFormatted = sf.Fee_Name__c.replace(' ', '_');
            salesFees.put(sf.Fee_Name__c, sf);
        }
        return salesFees;
    }

    public static List<String> preventFieldOverlap(Set<String> fieldMetadataKeyset)
    {
        // Prepare unique set of fields by omitting namespace
        Set<String> uFields = new Set<String>();
        for(String s : fieldMetadataKeyset) {
            if(!uFields.contains(s)){
                uFields.add(s);
            }
        }
        List<String> returnValues = new List<String>();
        returnValues.addAll(uFields);
        return returnValues;
    }
    
    public class FormAPIException extends Exception{}
}