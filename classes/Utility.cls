/** 
* Date            |Developer            |Work#
* Notes
* 
* 13/01/17           Sneha Utture         ||W-000897
* Added trigger handler Interface method and migrated AccountControl trigger on Account
* and ContactControl trigger on Contact
* 
*/

global class Utility {

    //MKS 9/5/16 Takes 2 contact records and returns true if relevant info has changed, false if not
    public static boolean isContactInfoChanged(Contact newContact, Contact oldContact){
        Boolean isChanged = false;

        if(oldContact.FirstName != newContact.FirstName && newContact.FirstName != '') isChanged = true;
        if(oldContact.LastName != newContact.LastName && newContact.LastName != '') isChanged = true;
        if(oldContact.Phone != newContact.Phone) isChanged = true;
        if(oldContact.HomePhone != newContact.HomePhone) isChanged = true;
        if(oldContact.MobilePhone != newContact.MobilePhone) isChanged = true;
        if(oldContact.Email != newContact.Email) isChanged = true;
        if(oldContact.MailingStreet != newContact.MailingStreet) isChanged = true;
        if(oldContact.MailingCity != newContact.MailingCity) isChanged = true;
        if(oldContact.MailingState != newContact.MailingState) isChanged = true;
        if(oldContact.MailingPostalCode != newContact.MailingPostalCode) isChanged = true;
        
        return isChanged;
    }

    //MKS 9/5/16 Takes 2 account records and returns true if relevant info has changed, false if not
    public static boolean isAccountInfoChanged(Account newAccount, Account oldAccount){
        Boolean isChanged = false;

        if(oldAccount.FirstName != newAccount.FirstName && newAccount.FirstName != '') isChanged = true;
        if(oldAccount.LastName != newAccount.LastName && newAccount.LastName != '') isChanged = true;
        if(oldAccount.Phone != newAccount.Phone) isChanged = true;
        if(oldAccount.PersonHomePhone != newAccount.PersonHomePhone) isChanged = true;
        if(oldAccount.PersonMobilePhone != newAccount.PersonMobilePhone) isChanged = true;
        if(oldAccount.PersonEmail != newAccount.PersonEmail) isChanged = true;
        if(oldAccount.PersonMailingStreet != newAccount.PersonMailingStreet) isChanged = true;
        if(oldAccount.PersonMailingCity != newAccount.PersonMailingCity) isChanged = true;
        if(oldAccount.PersonMailingState != newAccount.PersonMailingState) isChanged = true;
        if(oldAccount.PersonMailingPostalCode != newAccount.PersonMailingPostalCode) isChanged = true;
        
        return isChanged;
    }

    //MKS 9/5/16 Takes a Contact and a Sales Up. Returns the Sales Up if the info is different
    //returns null if the info is the same
    public static dealer__Sales_Up__c isSUContactInfoDifferent(dealer__Sales_Up__c s, Contact c){
        Boolean isUpdated = false;

        if(s.dealer__FirstName__c != c.FirstName){ s.dealer__FirstName__c = c.FirstName; isUpdated = true; }
        if(s.dealer__LastName__c != c.LastName){ s.dealer__LastName__c = c.LastName; isUpdated = true; }
        if(s.dealer__Phone__c != c.Phone){ s.dealer__Phone__c = c.Phone; isUpdated = true; }
        if(s.dealer__Home_Phone__c != c.HomePhone){ s.dealer__Home_Phone__c = c.HomePhone; isUpdated = true; }
        if(s.dealer__Mobile__c != c.MobilePhone){ s.dealer__Mobile__c = c.MobilePhone; isUpdated = true; }
        if(s.dealer__Email__c != c.Email){ s.dealer__Email__c = c.Email; isUpdated = true; }
        if(s.dealer__Mailing_Street__c != c.MailingStreet){ s.dealer__Mailing_Street__c = c.MailingStreet; isUpdated = true; }
        if(s.dealer__Mailing_City__c != c.MailingCity){ s.dealer__Mailing_City__c = c.MailingCity; isUpdated = true; }
        if(s.dealer__Mailing_State__c != c.MailingState){ s.dealer__Mailing_State__c = c.MailingState; isUpdated = true; }
        if(s.dealer__Mailing_Zip__c != c.MailingPostalCode){ s.dealer__Mailing_Zip__c = c.MailingPostalCode; isUpdated = true; }

        if(isUpdated) return s;
        else return null;
        
    }

    //MKS 9/5/16 Takes an Account and a Sales Up. Returns the Sales Up if the info is different
    //returns null if the info is the same
    public static dealer__Sales_Up__c isSUAccountInfoDifferent(dealer__Sales_Up__c s, Account a){
        Boolean isUpdated = false;

        if(s.dealer__FirstName__c != a.FirstName){ s.dealer__FirstName__c = a.FirstName; isUpdated = true; }
        if(s.dealer__LastName__c != a.LastName){ s.dealer__LastName__c = a.LastName; isUpdated = true; }
        if(s.dealer__Phone__c != a.Phone){ s.dealer__Phone__c = a.Phone; isUpdated = true; }
        if(s.dealer__Home_Phone__c != a.PersonHomePhone){ s.dealer__Home_Phone__c = a.PersonHomePhone; isUpdated = true; }
        if(s.dealer__Mobile__c != a.PersonMobilePhone){ s.dealer__Mobile__c = a.PersonMobilePhone; isUpdated = true; }
        if(s.dealer__Email__c != a.PersonEmail){ s.dealer__Email__c = a.PersonEmail; isUpdated = true; }
        if(s.dealer__Mailing_Street__c != a.PersonMailingStreet){ s.dealer__Mailing_Street__c = a.PersonMailingStreet; isUpdated = true; }
        if(s.dealer__Mailing_City__c != a.PersonMailingCity){ s.dealer__Mailing_City__c = a.PersonMailingCity; isUpdated = true; }
        if(s.dealer__Mailing_State__c != a.PersonMailingState){ s.dealer__Mailing_State__c = a.PersonMailingState; isUpdated = true; }
        if(s.dealer__Mailing_Zip__c != a.PersonMailingPostalCode){ s.dealer__Mailing_Zip__c = a.PersonMailingPostalCode; isUpdated = true; }

        if(isUpdated) return s;
        else return null;
        
    }
    public static Boolean isValidId(String idString){
        Id validId;
        try{
            validId = idString;
            return true;
        } catch(Exception e) {
            return false;
        }
    }
    //To validate Decimal field as not null and greater than zero
    public static boolean isGreaterThanZero(Decimal val)
    {
        if(val != null && val > 0)
        {
            return true;
        }

        return false;
    }

    public static Decimal eval(String evalString, sObject obj){
        return new EvalExpression(evalString).matching(obj.getpopulatedfieldsasmap()).eval() + 0; //The + 0 prevents scientific notation being returned 1500 = 1.5E+3.
    }

    public static Object getSobjectValue(sObject obj, string fieldName){
        Map<String,Object> objMap = obj.getpopulatedfieldsasmap();
        return fieldName == null ? null : objMap.get(fieldName);
    }

    // map to hold global describe data
    private static Map<String,Schema.SObjectType> gd;
    
    // map to store objects and their prefixes
    private static Map<String, String> keyPrefixMap;

    // to hold set of all sObject prefixes
    private static Set<String> keyPrefixSet;
    
    public static datetime stringToDateTime(String datestring)
    {
        /*
            Format of incoming string is : mm/dd/yyyy hh:mm AM
        */
        // Split date part of string
        System.debug(datestring);
        
        List<String> datelist = new List<String>();
        datelist = datestring.split('/',3);
        Integer imonth = Integer.valueOf(datelist[0]);
        Integer iday = Integer.valueOf(datelist[1]);
        Integer iyear = Integer.valueOf(datelist[2].substring(0,4));
        
        // Split time part of string        
        Integer colonpos = datestring.indexOf(':');
        Integer stringlen = datestring.length();
        //MKS 5/30/16: To handle 1- or 2-digit hours
        String hour = datestring.substring(colonpos - 2,colonpos );
        Integer ihour = Integer.valueOf(hour.trim());
        Integer imin = Integer.valueOf(datestring.substring(colonpos + 1, colonpos + 3));
        Integer isec = 0;
        String sampm = datestring.substring(stringlen - 2, stringlen);
        
        if (sampm == 'PM' && ihour != 12)
            ihour = ihour + 12;
        
        // Create datetime return type
        datetime parsedDate = datetime.newInstance(iyear, imonth, iday, ihour, imin, isec);
        
        // return datetime formatted date               
        return parsedDate;
    }

    //Incoming format: yyyyMMDD
    public static Date stringToDate(String datestring){
        String year = datestring.substring(0, 4);
        String month = datestring.substring(4, 6);
        String day = datestring.substring(6);
        
        String formatted = year+'-'+month+'-'+day+' 00:00:00';
        return Date.valueOf(formatted);
    }
    
    public static Map<Id, Id> applicableLocations(){
        Map<Id,Id> dluMap = new  Map<Id,Id>();
        for(Dealer_Location_User__c dlu : [SELECT Id, Name, Dealer_Location__c FROM Dealer_Location_User__c WHERE User__c =: UserInfo.getUserId()]){
            dluMap.put(dlu.Id, dlu.Dealer_Location__c);
        }
        return dluMap;
    }

    public static String GetKeyPrefix(String ObjId)
    {
        schemaInit() ;
        String tPrefix = ObjId;
        tPrefix = tPrefix.subString(0,3);
        
        //get the object type now
        String objectType = keyPrefixMap.get(tPrefix);
        return objectType;
    }
    
    private static void schemaInit() {
        // get all objects from the org
        gd = Schema.getGlobalDescribe();
        
        // to store objects and their prefixes
        keyPrefixMap = new Map<String, String>{};
        
        //get the object prefix in IDs
        keyPrefixSet = gd.keySet();
        
        // fill up the prefixes map
        for(String sObj : keyPrefixSet)
        {
            Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
            String tempName = r.getName();
            String tempPrefix = r.getKeyPrefix();
            keyPrefixMap.put(tempPrefix, tempName);
        }
    }  

    /**
     * classAccess : Determine if a user has access to a named Class
     * @param  String Name of the Class to search if access exists for 
     * @return Boolean
     * @notes Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.  
     * 
     */
    public static Boolean classAccess(String className) {
        List<SetupEntityAccess> entities = [SELECT Id, Parent.Name, Parent.Profile.Name, Parent.Profile.Id 
                            FROM SetupEntityAccess WHERE Parent.Profile.Id = :UserInfo.getProfileId() 
                            AND SetupEntityId in (SELECT Id FROM ApexClass WHERE Name =:className AND NamespacePrefix = 'dealer')];
        if(entities.isEmpty()) {
            return false;
        } else {
            return true;
        }
    }  

    /**
     * pageAccess : Determine if a user has access to a named visualforce page
     * @param  String Name of the page to search if access exists for 
     * @return Boolean
     * @notes Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.  This is first released on v. 1.572
     * 
     */
    public static Boolean pageAccess(String pageName) {
        List<SetupEntityAccess> entities = [SELECT Id, Parent.Name, Parent.Profile.Name, Parent.Profile.Id 
                            FROM SetupEntityAccess WHERE Parent.Profile.Id = :UserInfo.getProfileId() 
                            AND SetupEntityId in (SELECT Id FROM ApexPage WHERE Name =:pageName AND NamespacePrefix = 'dealer')];
        if(entities.isEmpty()) {
            return false;
        } else {
            return true;
        }
    } 
    
    public static Id findContactId(String objectName, Id objectRecordId) {
        System.debug(objectName+' '+objectRecordId);
        if(objectName == 'dealer__Sales_Up__c') {
            dealer__Sales_Up__c[] sup = [Select Id, dealer__Buyer_Contact__c from dealer__Sales_Up__c where Id =:objectRecordId limit 1];
            System.debug('Searching Sales Up '+sup.size());
            if(sup.size()>0) {
                System.debug(sup[0].dealer__Buyer_Contact__c);
                return sup[0].dealer__Buyer_Contact__c;
            }
        }
        return null;
    }   
    
    public static String formatPhoneTen(String p) {
        if(p.length()==10) {
             String tempPhone;
             tempPhone = '('+p.substring(0, 3) + ') ' +p.substring(3, 6) + '-' + p.substring(6, 10);
             return tempPhone;
        } else {
            return p;
        }
    }

    public static boolean emailValid(String email) {
        
        Boolean res = true;
        String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$'; 
        // source: <a href="http://www.regular-expressions.info/email.html" target="_blank" rel="nofollow">http://www.regular-expressions.info/email.html</a>
        Pattern MyPattern = Pattern.compile(emailRegex);
        Matcher MyMatcher = MyPattern.matcher(email);

        if (!MyMatcher.matches()) 
            res = false;
    

        return res;
    }

    // Calculate the distance of two Long values in Minutes
    public static Integer timeDistance_Minutes(Long s, Long e) {
        // Capture Distance
        Long timeDiff       =   (e-s);
        Integer timeDiffMinutes = Integer.valueOf((timeDiff / 60) / 1000);
        return timeDiffMinutes;
    }

    /*
    |
    |   Check to see if persons accounts are enabled
    |
    */
    public static Boolean personsAccountsEnabled() {
        try {
            sObject testPersonsAccount = new Account();
            testPersonsAccount.get('isPersonAccount');
            return true;
        } catch(Exception e) {
            return false;
        }
    }

    /*
    |
    |   Lookup Account based on passed ID
    |
    */
    public static Id lookupParentAccount(String pid){
        Contact[] cons = [select Id, AccountId from Contact where Id=:pid limit 1];
        if(cons.size()==1) {
            return cons[0].AccountId;
        } else {
            return null;
        }
    }

    /**
     * Check if a string is blank
     * @param  s [String]
     * @return   [boolean]
     */
    public static Boolean isBlank(String s){
        if(s == null || s == '') {
            return true;
        }

        return false;
    }

    /*
    |
    |   Query sobject for all fields, preventing fieldoverlap
    |
    */
    global static Sobject queryAllFields(String objectName, String objectId){
        System.assert(objectName != 'User' && objectName != 'user','Cannot use dealer.Utility.queryAllFields on the User object');
        List<String> managedFieldNames = new List<String>();
        List<String> otherFieldNames = new List<String>();
        try{
            // get object type from schema 
            // get all fields from object in schema      
            SObjectType objectType = Schema.getGlobalDescribe().get(ObjectName);
            Map<String,sObjectField> fieldMap = objectType.getDescribe().fields.getMap();
            List<SobjectField> fieldList = fieldMap.values();

            // Step 1: separate managed vs. un managed fields.
            for(SobjectField field : fieldList){
                List<Schema.SObjectType> fieldSobjectType = fieldMap.get(String.valueOf(field)).getDescribe().getReferenceTo();
                String relatedObjectName = fieldSobjectType.size() > 0 ? String.valueOf(fieldSobjectType[0]) : null;
                String relationshipName = fieldMap.get(String.valueOf(field)).getDescribe().getRelationshipName();

                Boolean isRelatedField = relationshipName == null || !relationShipName.contains('__r') ? false : true;

                String[] fieldParts = String.valueOf(field).split('dealer__');
                if(fieldParts.size() > 1){
                    //managed Fields
                    managedFieldNames.add(String.valueOf(field));
                    if(isRelatedField){
                        //get fields from object (related objectName) create fields : __r.fieldName to add to query

                    }
                }
                if(fieldParts.size() == 1){
                    //unmanaged Fields
                    otherFieldNames.add(fieldParts[0]);
                    if(isRelatedField){
                        //get fields from object (related objectName) create fields : __r.fieldName to add to query

                    }
                }
            }

            // Map to store fieldnames and their values 
            Map<String,String> fieldValueMap = new Map<String,String>();
            
            //Step 2: Query object for managed fields
            if(managedFieldNames.size() > 0){
                String managedQuery = 'Select '+String.join(managedFieldNames, ', ')+' FROM '+ObjectName+' WHERE Id =\''+objectId+'\'';
                sObject managedObjResult = database.query(managedQuery);
                for(String field : managedFieldNames){
                    if(managedObjResult.get(field) != NULL){
                        fieldValueMap.put(field,String.ValueOf(managedObjResult.get(field)));
                    }
                }
            }

            //Step 3: Query non-managedfields (id,Name .. etc. And Customer Created Custom Fields)
            String otherQuery = 'Select '+String.join(otherFieldNames, ', ')+' FROM '+ObjectName+' WHERE Id =\''+objectId+'\'';
            sObject otherObjResult = database.query(otherQuery);
            for(String field : otherFieldNames){
                if(otherObjResult.get(field) != NULL){
                    fieldValueMap.put(field,String.ValueOf(otherObjResult.get(field)));
                }
            }

            // Step 4: objw holds the object attributes (Type and URL) For deserialization.
            ObjectWrapper objW = (objectWrapper)JSON.deserialize(JSON.serialize(otherObjResult),ObjectWrapper.class);

            //Step 5: Combine attributes(objw) and field data into a single sObject.
            return (sObject)JSON.deserialize(writesObjectJSON(objW,objectType,fieldValueMap),sObject.class);
            
        }catch (Queryexception e){
            throw new UtilityException(e.getMessage());
        } catch (JSONException e){
            throw new UtilityException(e.getMessage());
        }catch (Exception e){
            throw new UtilityException(e.getMessage());
        } 

    }

    /*
    |
    |   Querys for a list of sobject for all fields, preventing fieldoverlap
    |   Returns a list of Sobjects, expects a list of record Ids.
    |
    */
    global static List<Sobject> queryAllFields(String objectName, List<String> objectIdList){
        System.assert(objectName != 'User' && objectName != 'user','Cannot use dealer.Utility.queryAllFields on the User object');
        system.assert(objectIdList.size() > 0,'At least one valid Id is required to query '+objectName);

        List<String> managedFieldNames = new List<String>();
        List<String> otherFieldNames = new List<String>();
        try{
            // get object type from schema 
            // get all fields from object in schema      
            SObjectType objectType = Schema.getGlobalDescribe().get(ObjectName);
            Map<String,sObjectField> fieldMap = objectType.getDescribe().fields.getMap();
            List<SobjectField> fieldList = fieldMap.values();

            // Step 1: separate managed vs. un managed fields.
            for(SobjectField field : fieldList){
                List<Schema.SObjectType> fieldSobjectType = fieldMap.get(String.valueOf(field)).getDescribe().getReferenceTo();
                String relatedObjectName = fieldSobjectType.size() > 0 ? String.valueOf(fieldSobjectType[0]) : null;
                String relationshipName = fieldMap.get(String.valueOf(field)).getDescribe().getRelationshipName();

                Boolean isRelatedField = relationshipName == null || !relationShipName.contains('__r') ? false : true;

                String[] fieldParts = String.valueOf(field).split('dealer__');
                if(fieldParts.size() > 1){
                    //managed Fields
                    managedFieldNames.add(String.valueOf(field));
                    if(isRelatedField){
                        //get fields from object (related objectName) create fields : __r.fieldName to add to query
                        // system.debug('MANAGED relationship.. Field: '+String.valueOf(field)+' relationshipName '+relationShipName +' Object -> '+ relatedObjectName);
                    }
                }
                if(fieldParts.size() == 1){
                    //unmanaged Fields
                    otherFieldNames.add(fieldParts[0]);
                    if(isRelatedField){
                        //get fields from object (related objectName) create fields : __r.fieldName to add to query
                        // system.debug('UNMANAGED relationship.. Field: '+String.valueOf(field)+' relationshipName '+relationShipName +' Object -> '+ relatedObjectName);
                    }
                }
            }

            //Map to store fieldnames and their values 
            //Sobject Row Id Map , of FieldNames
            Map<String,Map<String,String> > fieldValueMap = new Map<String, Map<String,String> >();
            
            //Step 2: Query non-managedfields (id,Name .. etc. And Customer Created Custom Fields)
            String otherQuery = 'Select '+String.join(otherFieldNames, ', ')+' FROM '+ObjectName+' WHERE Id IN (\''+String.Join(objectIdList, '\',\'' )+'\')';
            sObject[] otherObjResult = database.query(otherQuery);
            for(Sobject so: otherObjResult){
                Map<String,String> vMap = new Map<String,String>();
                for(String field : otherFieldNames){
                    if(so.get(field) != NULL){
                        String recordId = String.valueOf(so.get('Id'));
                        vMap.put(field,String.ValueOf(so.get(field)));
                        fieldValueMap.put(recordId,vMap );
                    }
                }
            }

            //Step 3: Query Managed Fields
            if(managedFieldNames.size() > 0){
                String managedQuery = 'Select Id,'+String.join(managedFieldNames, ', ')+' FROM '+ObjectName+' WHERE Id IN (\''+String.Join(objectIdList, '\',\'' )+'\')';
                // sObject managedObjResult = database.query(managedQuery);
                for(Sobject so: database.query(managedQuery)){
                    Map<String,String> vMap = new Map<String,String>();
                    for(String field : managedFieldNames){
                        if(so.get(field) != NULL){
                            if(field != 'Id'){
                                String recordId = String.valueOf(so.get('Id'));
                                vMap = fieldValueMap.get(recordId);
                                vMap.put(field,String.ValueOf(so.get(field)));
                                fieldValueMap.put(String.valueOf(so.get('Id')),vMap );
                            }    
                        }
                    }
                }
            }

            List<Sobject> returnList = new List<Sobject>();

            // Step 4: objw holds the object attributes (Type and URL) For deserialization.
            ObjectWrapper objW = (objectWrapper)JSON.deserialize(JSON.serialize(otherObjResult[0]),ObjectWrapper.class);
            for(String recordIdKey : fieldValueMap.keySet()){
                returnList.add((sObject)JSON.deserialize(writesObjectJSON(objW,objectType,fieldValueMap.get(recordIdKey)),sObject.class));
            }

            //Step 5: Combine attributes(objw) and field data into a single sObject.
            return returnList;
            
        }catch (Queryexception e){
            throw new UtilityException(e.getMessage());
        } catch (JSONException e){
            throw new UtilityException(e.getMessage());
        }catch (Exception e){
            throw new UtilityException(e.getMessage());
        } 
    }
    /*
    |
    |   Combines sObject Attributes object and field data into Salesforce Object JSON Structure.
    |
    */

    public static String writesObjectJSON(ObjectWrapper objW, SObjectType objectType, Map<String,String> fieldValueMap){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('attributes');
        gen.writeObject(objW.attributes);

        for(String field :fieldValueMap.keySet()){
            String type = String.ValueOf(objectType.getDescribe().fields.getMap().get(field).getDescribe().getType());
            switch on type {
                when 'PHONE','STRING','EMAIL','TEXTAREA','PICKLIST','ID','REFERENCE','MULTIPICKLIST','URL','TextAREA','ENCRYPTEDSTRING','BASE64'{
                    gen.WriteStringField(field, fieldValueMap.get(field));
                }
                when 'CURRENCY','DOUBLE','INTEGER','LONG','PERCENT'{
                    gen.writeNumberField(field, Decimal.valueOf(fieldValueMap.get(field)) );
                }
                when 'BOOLEAN'  {
                    gen.writeBooleanField(field, Boolean.valueOf(fieldValueMap.get(field)) );
                }
                when 'DATE'  {
                    gen.writeDateField(field, Date.valueOf(fieldValueMap.get(field)) );
                }
                when 'DATETIME'  {
                    gen.writeDateTimeField(field, DateTime.valueOf(fieldValueMap.get(field)) );
                }
            }
        }
        gen.writeEndObject();
        return gen.getAsString();
    }
    /**
    * Updates related fields from an object. Compatibility for field sets on visual force pages.
    * Added to allow saving records from custom related lists added to page.
    * Compatible with all fields, custom or managed(dealer).
    */
    public static void updateRelatedObjects(sObject obj){
        Map<String, Object> objMap = obj.getPopulatedFieldsAsMap();
        List<sObject> relatedObjs = new List<sObject>();
        for(String s : objMap.keySet()){
            try{
                //If the deserialization is successful it is a related object of this record (example: Service_Vehicle__r(...)))
                objectWrapper owl = (objectWrapper)Json.Deserialize(JSON.serializePretty(objMap.get(s)), objectWrapper.class);
                if(owl != null){
                    relatedObjs.add((sObject)objMap.get(s));
                }
            } catch (JSONException e){
                //If there is an error it tried to deserialize  a field, not a related object.
            } 
        }
        if(relatedObjs.size() > 0 ){
            try{
                update relatedObjs;
            }catch (DmlException e){
                throw new DmlException(e.getMessage());
            }
        }
    }
    //This wrapper class is to test the deserialization
    public class ObjectWrapper{
        public Attributes attributes {get;set;}
    }
    public class Attributes{
        public String type {get;set;}
    }

    /**
    * Get the Dealership Location of Running User
    * @return Dealership Location Id
    */
    public static Id lookupUserLocation() {
        User u = [Select Id, Division from User Where Id=:UserInfo.getUserId() limit 1];
        if(u.Division==null) 
            return null;
        dealer__Dealer_Location__c[] loc = [Select Id, dealer__Company_Number__c 
                                                FROM dealer__Dealer_Location__c 
                                                WHERE dealer__Company_Number__c =:u.Division
                                                Limit 1];
        if(loc.size()==1) {
            return loc[0].Id;
        }

        return null;
    }

    /**
     *  Obtain Dealereship Location by User Division
     *
     */
    public static Dealer_Location__c userLocation(Id userId)
    {
        User u = [SELECT Id, Name, Division, Dealership_Location__c FROM User WHERE Id=:userId];
        dealer__Dealer_Location__c[] loc = [SELECT Id, dealer__Company_Number__c 
                                                FROM dealer__Dealer_Location__c 
                                                WHERE dealer__Company_Number__c =:u.Division
                                                LIMIT 1];

        if(loc.size()==1) {
            return loc[0];
        }

        return null;        
    }

    /**
    * Apex does not have a Modulus(decimal) method, so we create one.
    * @return Integer
    **/
    public static Integer Modulus(Decimal dec){
        dec = dec.setScale(2);
        String decimalStr = dec.toPlainString();
        return Integer.valueOf(decimalStr.split('\\.')[1]);
    }

    /**
    * Returns the days between two datetime objects. Expects two datetime arguments
    * @Return Decimal with Modulus ( 1.5  = 1 day 12 hours).
    * */
    public static decimal daysBetweenDatetime(DateTime firstDate, DateTime secondDate){
        Decimal millisecondsBetween = (secondDate.getTime() - firstDate.getTime());
        Decimal daysBetween = millisecondsBetween / 86400000;
        return daysBetween;
    }

    /**
    *
    * protectedStatusCodes - returns a list of strings reprsenting status codes protected for the object requested
    *
    */
    public static Set<String> protectedStatusCodes(String objectName)
    {
        Set<String> protectedCodes = new Set<String>();
        ProtectedStatusCodes__mdt[] pscList = [SELECT ProtectedValues__c 
                                                FROM ProtectedStatusCodes__mdt 
                                                WHERE Object__c =:objectName
                                                LIMIT 1];
        if(pscList.isEmpty()) {
            return protectedCodes;
        }

        // Split on command and return
        try {
            List<String> codeList = pscList[0].ProtectedValues__c.split(',');
            protectedCodes.addAll(codeList);
            return protectedCodes;
        } Catch(Exception e) {
            throw new UtilityException(e.getMessage());
        }
    }

    public static DealerMethodOverride__mdt methodOverride(String className, String methodName)
    {
        DealerMethodOverride__mdt[] mo = [SELECT ClassName__c, QualifiedApiName, MethodName__c, OverrideClass__c, Label, NamespacePrefix, MasterLabel, DeveloperName, Id 
                                        FROM DealerMethodOverride__mdt
                                        WHERE ClassName__c=:className 
                                        AND MethodName__c=:methodName 
                                        LIMIT 1];

        if(!mo.isEmpty()) {
            return mo[0];
        }

        return new DealerMethodOverride__mdt();
    }

    /**
     * nextDealNumber
     * @return Integer
     * @notes Issue Deal Number from the DMS Settings (Protected Setting)
     *
     */
    global static Integer nextDealNumber() {

        List<dealer__DMS_Settings__c> dmsSettings = [SELECT Id, Name, dealer__DMSName__c, dealer__Deal_Number__c
                                                         FROM dealer__DMS_Settings__c
                                                         WHERE Name = 'ActiveSettings' limit 1 for update];

        if(dmsSettings.isEmpty()) {
            throw new UtilityException('DMS Settings have not been set, contact your System Administrator');
        }

        try {

            Integer nextNumber = Integer.valueOf(dmsSettings[0].dealer__Deal_Number__c);
            nextNumber++;
            dmsSettings[0].dealer__Deal_Number__c=nextNumber;
            update dmsSettings;

            return nextNumber;

        } Catch(DmlException e) {
            throw new UtilityException('Unable to reserve next deal# '+e.getMessage());
        }
    }
    
    public static String generateGuid() {        
        String randomStringAsHex = EncodingUtil.ConvertTohex(Crypto.GenerateAESKey(128));

        String versionHexBits = randomStringAsHex.SubString(14,16); // 7th bit 
        String variantHexBits = randomStringAsHex.SubString(18,20); // 9th bit

        Integer versionIntBits = convertHexToInt(versionHexBits);
        Integer variantIntBits = convertHexToInt(variantHexBits);

        Integer versionShiftedIntBits = versionIntBits & 15 | 64;  // (i & 0x0f) | 0x40
        Integer variantShiftedIntBits = variantIntBits & 63 | 128; // (i & 0x3f) | 0x80

        String versionShiftedHexBits = convertIntToHex(versionShiftedIntBits); // Always begins with 4
        String variantShiftedHexBits = convertIntToHex(variantShiftedIntBits); // Always begins with one of 8,9,a,b

        String guid = randomStringAsHex.SubString(0,8) + '-' + randomStringAsHex.SubString(8,12) + '-' + versionShiftedHexBits + randomStringAsHex.SubString(14,16) + '-' + variantShiftedHexBits + randomStringAsHex.SubString(18,20) + '-' + randomStringAsHex.substring(20);        

        return guid;
    }

    static Integer convertHexToInt(String hex) {   
        List<String> hexMap = new List<String> {
        '0', '1', '2', '3', '4', '5', '6', '7', 
        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
        };     
        Integer d0 = hexMap.IndexOf(hex.Substring(1,2));
        Integer d1 = hexMap.IndexOf(hex.Substring(0,1));

        Integer intval = d0 + (d1*16);
        return intval;
    }

    static String convertIntToHex(Integer intval) {
        List<String> hexMap = new List<String> {
        '0', '1', '2', '3', '4', '5', '6', '7', 
        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
        };
        String hs0 = hexMap.Get(intval & 15); // i & 0x0f
        String hs1 = hexMap.Get(((intval >> 4) & 15)); //(i >> 4) & 0x0f        
        return hs1+hs0;
    }

    public static void UpdateAccountSalesUp(Map<Id, Account> newAccountMap, Map<Id, Account> oldAccountMap){
        
        Set<Id> changedAccts = new Set<Id>();
        List<dealer__Sales_Up__c> sups;
        List<dealer__Sales_Up__c> supsToUpdate = new List<dealer__Sales_Up__c>();
        
        for (Account newAccount : newAccountMap.values()) {
            //if contact info changed, add Id to changed list           
            if(Utility.isAccountInfoChanged(newAccount, oldAccountMap.get(newAccount.Id))){
                changedAccts.add(newAccount.Id);
            }
        }       
        //********************* Update related Sales Ups *********************
        //query for all sales ups with customer account in the changed list
        if(changedAccts.size() > 0){
            sups = [SELECT Id, dealer__Customer_Account__c, dealer__FirstName__c, dealer__LastName__c, 
                            dealer__Phone__c, dealer__Home_Phone__c, dealer__Mobile__c, dealer__Email__c, 
                            dealer__Mailing_Street__c, dealer__Mailing_City__c, dealer__Mailing_State__c, 
                            dealer__Mailing_Zip__c
                            FROM dealer__Sales_Up__c WHERE dealer__Customer_Account__c in :changedAccts];

                    //iterate over sales ups, checking if the contact info is different than the account
                    for(dealer__Sales_Up__c s : sups){
                        dealer__Sales_Up__c tmp = Utility.isSUAccountInfoDifferent(s, newAccountMap.get(s.dealer__Customer_Account__c));
                        if(tmp != null){
                            supsToUpdate.add(tmp);
                        }
                    }
                    
                    if(supsToUpdate.size()>0){
                        update supsToUpdate;        
                    }
        }
        
    }
    
    public static void UpdateContactSalesUp(Map<Id, Contact> newContactMap, Map<Id, Contact> oldContactMap){
        
        Set<Id> changedCons = new Set<Id>();
        List<dealer__Sales_Up__c> sups;
        List<dealer__Sales_Up__c> supsToUpdate = new List<dealer__Sales_Up__c>();
        
        for (Contact newContact : newContactMap.values()) {
            //if contact info changed, add Id to changed list           
            if(Utility.isContactInfoChanged(newContact, oldContactMap.get(newContact.Id))){
                changedCons.add(newContact.Id);
            }
        }       
        //********************* Update related Sales Ups *********************
        //query for all sales ups with customer account in the changed list
        sups = [SELECT Id, dealer__Customer_Account__c, dealer__FirstName__c, dealer__LastName__c, 
                dealer__Phone__c, dealer__Home_Phone__c, dealer__Mobile__c, dealer__Email__c, 
                dealer__Mailing_Street__c, dealer__Mailing_City__c, dealer__Mailing_State__c, 
                dealer__Mailing_Zip__c
                FROM dealer__Sales_Up__c WHERE dealer__Customer_Account__c in :changedCons];

        //iterate over sales ups, checking if the contact info is different than the account
        for(dealer__Sales_Up__c s : sups){
            dealer__Sales_Up__c tmp = Utility.isSUContactInfoDifferent(s, newContactMap.get(s.dealer__Customer_Account__c));
            if(tmp != null){
                supsToUpdate.add(tmp);
            }
        }
        
        if(supsToUpdate.size()>0){
            update supsToUpdate;        
        }
    }
    
    /**
     * getDMSSettings
     * @return default dms settings (Custom Setting)
     * @notes Used to retrieve the active default dms settings
     */
    global static dealer__DMS_Settings__c getDMSSettings() {
        return dealer__DMS_Settings__c.getValues('ActiveSettings');
    }

    /**
     * isDMSFeatureEnabled
     *
     */
    global static boolean isDMSFeatureEnabled(String featureName)
    {

        DMSConfig__mdt config;

        try {
            config = [SELECT Enabled__c FROM DMSConfig__mdt WHERE DeveloperName =:featureName LIMIT 1];
        } Catch(QueryException e) {
            throw new QueryException('DMS Feature "' + featureName + '" does not exist.');
        }

        return config.Enabled__c;
    }

    /**
     *
     * DMSConfiguration
     *
     */
    global static String DMSConfiguration(String featureName)
    {
        DMSConfig__mdt config;

        try {
            config = [SELECT DefaultValue__c FROM DMSConfig__mdt WHERE DeveloperName =:featureName LIMIT 1];
        } Catch(QueryException e) {
            throw new QueryException('DMS Feature "' + featureName + '" does not exist.');
        }

        return config.DefaultValue__c;           
    }

    /**
     *
     * isSandbox returns boolean if org is a sandbox
     * 
     */
    public static Boolean isSandbox()
    {
        return [SELECT IsSandbox FROM Organization].isSandbox;
    }

    /**
     * emailAsyncHandler 
     * @param payload
     * 
     */
    global static void emailAsyncHandler(String payload) {

        /*
            Discoved this class does not allow for the MobilityWorks custom email handler
            update to allow for their custom class.
         */
        
        /* 
            adding support for SageLive, in the event Sage is the processing engine, the 
            email handler is different
        */

        try {
            // Derive Email Handle from Org Configuation
            String emailHandle ='';
            if(!Test.isRunningTest()) {  
                emailHandle =  Utility.emailServiceAddress();
            } else {
                emailHandle = 'fake@blackhole.org';
            }

            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {emailHandle};
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Asyncnronous Processing Request');
            mail.setPlainTextBody(payload);
        
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Account Service Error - Posting service not enabled.'));            
        } 
    } 

    public static Date getEarliestDate(List<Date> dates){
        dates.sort();
        return dates[0];
    }

    public static Date getLatestDate(List<Date> dates){
        dates.sort();
        return dates[dates.size()-1];
    }

    /**
     * emailServiceAddress
     * @return email address
     * @notes determines the email handle for processing the integrated financials requests
     */
    private static String emailServiceAddress() {

        String emailHandle = '';

        // Get the Org Defaults
        dealer__DMS_Settings__c dms = Utility.getDMSSettings();
        if(dms.dealer__Integrated_Financial_Application__c==null || dms.dealer__Integrated_Financial_Application__c=='') {
            return null;
        }
        
        // Are we integrated with the Financial Force Application
        if(dms.dealer__Integrated_Financial_Application__c=='FinancialForce') {

            ApexClass apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'FinancialForceEmailService' and NamespacePrefix = 'dtffa') or (Name='AccountingEmailService') limit 1];
            
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass.Id limit 1]; 

            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];

            emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;
        }

        // Are we integrated with SageLive
        if(dms.dealer__Integrated_Financial_Application__c=='SageLive') {

            ApexClass apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'SageLiveEmailService' and NamespacePrefix = 'dtsa') limit 1];
            
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass.Id limit 1]; 

            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];

            emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;
        }


        return emailHandle;
    }

    public static String generateDoc(String fileName, String bodyString){
        ContentVersion doc = new ContentVersion(
            Title = fileName,
            PathOnClient = fileName+'.txt',
            VersionData = Blob.valueOf(bodyString),
            IsMajorVersion = false
        );
        insert doc;
        ContentVersion cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: doc.Id LIMIT 1];
        return '/sfc/servlet.shepherd/version/download/' + cv.Id;
    }

    public static Component.Apex.OutputPanel sObjectRelatedListComponent(String objectName) 
    {
        Component.Apex.OutputPanel dynOutPanel= new Component.Apex.OutputPanel(); 

        for(DMSRelatedListConfig__mdt dmsconfig : [SELECT Id, Disabled__c, RelatedListReference__c, ObjectName__c, ObjectName__r.QualifiedApiName, Theme__c 
                                                    FROM DMSRelatedListConfig__mdt 
                                                    WHERE ObjectName__r.QualifiedApiName =:objectName
                                                    ORDER BY Sequence__c ASC]) 
        {
            if(dmsconfig.Disabled__c==false && (dmsconfig.Theme__c=='All' || UserInfo.getUiThemeDisplayed() == dmsconfig.Theme__c)) {
                Component.Apex.RelatedList dynRelList = new Component.Apex.RelatedList();
                dynRelList.list = dmsconfig.RelatedListReference__c;
                dynOutPanel.childComponents.add(dynRelList);
            }
        }

        return dynOutPanel;
    }

    // Work-002110 Begins
    /**
     * Wrapper class used to return record type info used by combo box options
     *
     */

     //check if wrapper class can be annotated auraenabled
    public class Selection {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String value {get;set;}
        
        public Selection(String RTName, Id RTI, String RTDesc) {
            //label = RTName + ' - ' + RTDesc;
            label = RTDesc == null? RTName : RTName + ' - ' + RTDesc;
            value = RTI;
        }
    }
    
    
    /**
     * Handles returning the recordType info of provided accountId
     * @param {Id} - AccountId to query recordType info
     * @returns {Account} - Account object with the recordTypeId and recordType.Name used by the LWC accountConvert
     * @test UtilityUILayer.testConvertToPersonAccount
     */
    @AuraEnabled(cacheable=true)
    public static Account getRecordType(Id acctId) {
        account a = [SELECT Id,FirstName, LastName, Name, recordTypeId, RecordType.name, RecordType.isPersonType FROM Account WHERE Id=:acctId];
        system.debug(a);
        return a;  
    }

    /**
     * Handles returning all available record types available to convert to
     * @param {Boolean} = Opposite of isPersonType used to filter records
     * @returns {List<Selection>} - List of record type Ids & Names for combo box drop down list
     * @test UtilityUILayer.testConvertToPersonAccount
     */
    @AuraEnabled(cacheable=true)
    public static List<Selection> getRecordSelect(Boolean b2b){
        system.debug(b2b);
        List<RecordType> rts = [SELECT Id, Name, Description, IsActive, IsPersonType, SobjectType FROM RecordType WHERE sObjectType = 'Account' AND IsActive = true AND IsPersonType=:b2b];
        system.debug(rts);
        List<Selection> selList = new List<Selection>();
        for(RecordType rt: rts){
        Selection sel = new Selection(rt.Name, rt.Id, rt.Description);
        selList.add(sel);
        }
        system.debug(selList);
        return selList; 
    }

    public static Boolean validSearchTerm(String searchStr){
        return !String.isBlank(searchStr) && searchStr.length() >= 2 ? true : false;
    }
  
    /**
     * Called by LWC AccountConvert to convert person account to business account
     * @param {Account} - Account to be converted
     * @param {String} - First Name to be used for person account
     * @param {String} - Last Name to be used for person account
     * @param {String} - The recordTypeId the account will be updated with
     * @test UtilityUILayer.testConvertToPersonAccount
     */
    @AuraEnabled
    public static Boolean convertToPersonAccount(Account acct, String First, String Last, String RTId){ 
        //Set save point to roll back database in event of DMLexception.
        SavePoint sp = Database.setSavePoint();
        Id acctId = acct.Id;

        //Obtain contacts and ensure there is 1, create if needed.
        List<Contact> conList = [SELECT Id, Name FROM Contact WHERE AccountId =:acctId];
        system.assert(conList.size() <= 1, 'unable to convert account more than 1 contact exists, please consolidate.');

        if(conList.size() == 0){
            contact c = new Contact(firstName = First, lastName = Last, AccountId = acct.Id);
            insert c;
        }
        //Must update recordTypeId before any other fields
        Account a = new Account();
        try{
            a.Id = acct.Id;
            a.RecordTypeId = RTId;
            update a;
        }catch(DmlException e){
            Database.rollback(sp);
            system.debug('DML Exception updating Account to Person Account type: ' + e.getMessage());
        }
        try{
            a.FirstName = First;
            a.LastName = Last;
            update a;
        }catch(DmlException e){
            Database.rollback(sp);
            system.debug('DML Exception adding First and Last name to account: ' + e.getMessage());
        }
        return true;
    }

    /**
     * Called by LWC AccountConvert to convert person account to business account
     * @param {Account} - Account to be converted
     * @param {String} - Name to be used for business account
     * @param {String} - The recordTypeId the account will be updated with
     * @test UtilityUILayer.testConvertToPersonAccount
     */
    @AuraEnabled
    public static Boolean convertToBusinessAccount(Account acct, String Name, String RTId){
        SavePoint sp = Database.setSavePoint();
        Account b2b = new Account();
        

        try{
            b2b.Id = acct.Id;
            b2b.RecordTypeId = RTId;
            system.debug(b2b);
            update b2b;
        } catch(DmlException e){
            Database.rollback(sp);
            system.debug('DML Exception updating to business account record type: ' + e.getMessage());
        }
        //Create contact if one doesn't exist already
        try{
            b2b.Name = Name;
            update b2b;
        }catch(DmlException e){
            Database.rollback(sp);
            system.debug('DML Exception updating to business account name: ' + e.getMessage());
        }

        return true;
    }

    /**
     * isManaged used to verify if code is running inside a package, code in scratch orgs will return false
     * @return   true indicates code is running inside dealer namespace, false means it is not, for example in scratch orgs
     */
    public static boolean isManaged(){
        boolean result;
        try{
            UserInfo.isCurrentUserLicensed('dealer');
            result = true;
        }catch(System.TypeException e){
            result = false;
        }
        return result;  
}
    // Work-002110 Ends


    /**
     * getObjectKeyPrefix provides the 3-digit prefix of an object when provided the api name
     * @param  objName String Object API name
     * @return         return String Object Key Prefix
     */ 
    public static String getObjectKeyPrefix(String objName){
    
    	schema.sObjectType sObjType = Schema.getGlobalDescribe().get(objName);
    	return (sObjType.getDescribe().getKeyPrefix());
	}

    /**
     * hasCustomPermission 
     * @param  permName Api Name of the permission
     * @notes Checks whether a custom permission is enabled
     * @return boolean true if permission is enabled else false
     */
    public static Boolean hasCustomPermission(String permName){
        return FeatureManagement.checkPermission(permName);
    }

    public static String evaluateFormula(String formula){
        try{
            string renderUrl = '/apex/dealer__FormulaRenderJSON?formula=' + formula;
            string evaluatedFormula = '';
            Pagereference pageRef = new Pagereference(renderUrl);
            if(!Test.isRunningTest()){
                formulaRender formulaValue = (formulaRender)JSON.deserialize(pageRef.getContent().toString(), formulaRender.class);

                //Remove any whitespace from evaluated formula
                evaluatedFormula = formulaValue.value.replace(' ', '');
            }

            return evaluatedFormula;
        }
        catch(JSONException e){
            system.debug('Error deserializing: ' + e.getMessage());

            return null;
        }
        
    }

    public class formulaRender{
        public string status{get;set;}
        public string value {get;set;}
    }

    global class UtilityException extends Exception {}
}