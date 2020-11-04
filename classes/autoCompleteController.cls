/**
 * autoCompleteController
 * @description
 */
global with sharing class autoCompleteController {

    /**
     * IllegalArgumentException
     * @description
     */ 
    global class IllegalArgumentException extends Exception {}
    
    /**
     * findSObjects 
     * @param  obj   >Object to query</param>    
     * @param  qry   >User spuulied input we are searching for</param>      
     * @param  addFields    >additional fields to query against, in the form field, field, field</param>
     * @param  resultFields     >fields to be returned by SOQL</param>
     * @description execute dynamic SOQL using user supplied input for filter and return criteria</summary>            
     */ 
    @RemoteAction
    global static SObject[] findSObjects(string obj, string qry, string addFields, string resultFields) 
    {
        // more than one field can be passed in the addFields parameter
        // split it into an array for later use
        /*  Removed in favor of searchSObjects, Jarrett Kuljis 2016-08-17
        
        List<String> fieldList;
        List<String> resultList;
        if (addFields != null && addFields != '') fieldList = addFields.split(',');
        if (resultFields != null && resultFields != '') resultList = resultFields.split(',');
        
       // check to see if the object passed is valid
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sot = gd.get(obj);
        if (sot == null) 
        {
            // Object name not valid
            throw new IllegalArgumentException('Object requested is invalid');
            return null;
        }
        // create the filter text
        String filter = ' like \'%' + String.escapeSingleQuotes(qry) + '%\'';
        //begin building the dynamic soql query
        String soql = 'select id, Name';
        // if an additional field was passed in add it to the soql
        if (resultList != null) 
        {
            for (String s : resultList)
            {
                soql += ', ' + String.escapeSingleQuotes(s);
            }
        }
        // add the object and filter by name to the soql
        soql += ' from ' + obj + ' where ( name' + filter;
        // add the filter by additional fields to the soql
        if (fieldList != null) 
        {
            for (String s : fieldList) 
            {
                soql += ' or ' + String.escapeSingleQuotes(s) + filter;
            }
        }

        // Hack to only show Parts_Inventory from the users current location
        soql += ' )';
        if(String.valueOf(sot)=='dealer__Parts_Inventory__c') 
        {
            // Add Filter Criteria
            soql += ' and dealer__Location__c = \''+Utility.lookupUserLocation()+'\' ';
        }

        soql += ' order by Name limit 20';
        System.debug(soql);
        List<sObject> L = new List<sObject>();
        try 
        {
            L = Database.query(soql);
        }
        catch (QueryException e) 
        {
            return null;
        }
        return L;
        */
       
        List<sObject> L = new List<sObject>();
        return L;
    }

    /**
     * searchSObjects 
     * @param  obj             
     * @param  qry              
     * @param  addFields        
     * @param  resultFields     
     * @param  locationOnly     
     * @param  additionalFilter 
     * @description                 
     */
    @RemoteAction
    global static SObject[] searchSObjects(string obj, string qry, string addFields, string resultFields, string locationOnly, string additionalFilter) 
    {
        // more than one field can be passed in the addFields parameter
        // split it into an array for later use
        system.debug('=> location only ' + locationOnly);
        
        List<String> fieldList;
        List<String> resultList;
        if (addFields != null && addFields != '') fieldList = addFields.split(',');
        if (resultFields != null && resultFields != '') resultList = resultFields.split(',');
        
       // check to see if the object passed is valid
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SObjectType sot = gd.get(obj);
        if (sot == null) 
        {
            // Object name not valid
            throw new IllegalArgumentException('Object requested is invalid');
            return null;
        }
        // create the filter text
        String filter = ' like \'%' + String.escapeSingleQuotes(qry) + '%\'';
        //begin building the dynamic soql query
        String soql = 'select id, Name';
        // if an additional field was passed in add it to the soql
        if (resultList != null) 
        {
            for (String s : resultList) 
            {
                soql += ', ' + String.escapeSingleQuotes(s);
            }
        }
        // add the object and filter by name to the soql
        soql += ' from ' + obj + ' where ( name' + filter;
        // add the filter by additional fields to the soql
        if (fieldList != null) 
        {
            for (String s : fieldList) 
            {
                soql += ' or ' + String.escapeSingleQuotes(s) + filter;
            }
        }

        // Hack to only show Parts_Inventory from the users current location
        soql += ' )';
        if(String.valueOf(sot)=='dealer__Parts_Inventory__c' && locationOnly=='') 
        {
            
            system.debug('here');
            List<dealer__Dealer_Location_User__c> availableLocations = [SELECT Id FROM dealer__Dealer_Location_User__c 
                                                                    where dealer__User__c =: UserInfo.getUserId()
                                                                    and dealer__Dealer_Location__c =: locationOnly LIMIT 1];
        
            if(availableLocations == null || availableLocations.isEmpty()) 
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Selected location is not valid for the current user. Please select a valid location.'));
                return null;
            }
            // Add Filter Criteria
           // soql += ' and dealer__Location__c = \''+Utility.lookupUserLocation()+'\' ';
        }

        if(String.valueOf(sot)=='dealer__Parts_Inventory__c' && locationOnly!='') 
        {
            // Add Filter Criteria
            soql += ' and dealer__Location__c = \''+String.escapeSingleQuotes(locationOnly)+'\' ';
        }

        if(additionalFilter!='') 
        {
            soql += ' and ' + String.escapeSingleQuotes(additionalFilter);
        }

        soql += ' order by Name limit 20';
        System.debug(soql);
        List<sObject> L = new List<sObject>();
        try 
        {
            L = Database.query(soql);
        }
        catch (QueryException e) 
        {
            return null;
        }
        return L;
   }   
}