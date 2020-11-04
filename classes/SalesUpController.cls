//Tested by SalesUpControllerTest
public class SalesUpController {
    @AuraEnabled
    public static List < List < sObject > > suggestResults(String name, String fName, String lName, String phone, String email) {
        Integer queryCharSize = (name+fName+lName+phone+email).length();
        if(queryCharSize <=1)
            return new List< List<sObject> >();

        name = name != null && name != '' ? name : null;
        fName = fName != null && fName != '' ? fName : null;
        lName = lName != null && lName != '' ? lName : null;
        phone = phone != null && phone != '' ? phone : null;
        email = email != null && email != '' ? email : null;

        if (name == null && fName == null && lName == null && phone == null && email == null) {
            List < Sobject > accList = new List < sObject > ();
            Account a = new Account(
                Name = '', FirstName = '', LastName = '', PersonEmail = '', Phone = ''
                );
            accList.add(a);
            List < sObject > supList = new List < sObject > ();
            Sales_Up__c su = new Sales_Up__c();
            supList.add(su);
            List < List < Sobject > > sob = new List < List < Sobject > > ();
            sob.add(accList);
            sob.add(supList);
            return sob;
        }
        //build search query string
        List < String > filterFields = new List < String > ();
        String filter = ' ';

        if (name != null)
        filterFields.add(name != null ? name + ' ' : ' ');
        if (fName != null)
        filterFields.add(filterFields.size() == 0 ? fName + ' ' : 'AND ' + fName + '* ');
        if (lName != null)
        filterFields.add(filterFields.size() == 0 ? lName + ' ' : 'AND ' + lName + '* ');
        if (phone != null)
        filterFields.add(filterFields.size() == 0 ? phone + ' ' : 'AND ' + phone + '* ');
        if (email != null)
        filterFields.add(filterFields.size() == 0 ? email + ' ' : 'AND ' + email + '* ');

        for (Integer i = 0; i < filterFields.size(); i++) {
            filter += filterFields[i];
        }
        List < List < SObject >> searchList = [FIND: filter IN ALL FIELDS RETURNING
        Contact(Id, CreatedDate, RecordTypeId, IsPersonAccount, AccountId, Name, Firstname, LastName, Email, Phone),
        Account(ID, CreatedDate, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, IsPersonAccount, Name, FirstName, LastName, PersonEmail, PersonMobilePhone, Phone),
        dealer__Sales_Up__c(Id, Owner.Name, RecordType.Name, Desired_Stock_Num__r.Stock_Number__c, CreatedDate, Lead_Status__c, Source__c, Name, Customer_Account__r.Name, Customer_Account__r.FirstName, Customer_Account__r.LastName, Customer_Account__r.PersonEmail, Customer_Account__r.Phone, dealer__Lead_Date__c)
        ];

        Contact[] contacts = ((List < Contact > ) searchList[0]);
        Account[] accounts = ((List < Account > ) searchList[1]);
        Sales_Up__c[] salesUps = ((List < Sales_Up__c > ) searchList[2]);


        List < List < Sobject > > returnList = new List < List < sObject > > ();
        List < Sobject > b2bCustomerList = new List < sObject > ();
        List < Sobject > b2cCustomerList = new List < sObject > ();
        //we only use person accounts or business accounts.
        for (Account a: accounts) {
            if (a.IsPersonAccount)
            b2cCustomerList.add(a);
            if (!a.IsPersonAccount)
            b2bCustomerList.add(a);
        }
        Set<Id> b2bAccounts = new Set<Id>();
        for (Contact c: contacts) {
            if(c.AccountId!= null){
                if(!b2bAccounts.contains(c.AccountId)) b2bAccounts.add(c.AccountId);
            }
        }

        returnList.add(b2bCustomerList);
        returnList.add(b2cCustomerList);
        returnList.add(salesUps);
        return returnList;
    }
    @AuraEnabled
    public static String getRecordTypes() {

        List<Id> rtIds = new List<Id>();
        Map<Id,RecordTypeInfo> rtInfoMap = new Map<Id,RecordTypeInfo>();

        schema.sobjecttype objType = Sales_Up__c.sobjecttype;
        for (RecordTypeInfo rti: objType.getDescribe().getRecordTypeInfos()) {
            if (rti.isAvailable() && rti.isActive()) {
                rtInfoMap.put(rti.recordTypeId, rti);
            }
        }

        //initialize variables for wrapper
        RecordType defaultRT = new RecordType();
        List<RecordType> rTypes = new List<RecordType>();

        for(RecordType rt : [SELECT Id, IsActive, Name, Description FROM RecordType WHERE sobjecttype = 'dealer__Sales_Up__c']){
            if(rtInfoMap.get(rt.Id) != null && rtInfoMap.get(rt.Id).isDefaultRecordTypeMapping()){
                defaultRT = rt;       
            } else {
                rTypes.add(rt);
            }
        }
        return JSON.serializePretty(new recordTypeWrapper(defaultRT,rTypes));
    }
    public Class recordTypeWrapper{
        Public RecordType defaultType {get;set;}
        Public List<RecordType> types {get;set;}

        public recordTypeWrapper(RecordType defaultType, List<RecordType> types){
            this.defaultType = defaultType;
            this.types = types;
        }
    }
    @AuraEnabled
    public static List < String > getSourcePicklistValues() {
        List < String > pickListValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Sales_Up__c.Source__c.getDescribe();

        String defaultVal = (String)fieldResult.getDefaultValue(); 
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            if(pickListVal.getLabel()!=defaultVal)
            pickListValues.add(pickListVal.getLabel());
        }
        
        if(defaultVal!=null)
	        pickListValues.add(0,defaultVal);
        
        return pickListValues;
    }
    @AuraEnabled
    public static List < String > getStatusPicklistValues() {
        List < String > pickListValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Sales_Up__c.Lead_Status__c.getDescribe();
         String defaultVal = (String)fieldResult.getDefaultValue(); 
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            if(pickListVal.getLabel()!=defaultVal)
            pickListValues.add(pickListVal.getLabel());
        }
        
        if(defaultVal!=null)
	        pickListValues.add(0,defaultVal);
        return pickListValues;
    }
    @AuraEnabled
    public static List < String > getLeadTypePicklistValues(){
        List < String > pickListValues = new List < String > ();
        Schema.DescribeFieldResult fieldResult = Sales_Up__c.Lead_Type__c.getDescribe();
        List < Schema.PicklistEntry > ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal: ple) {
            pickListValues.add(pickListVal.getLabel());
        }
        return pickListValues;
    }
    @AuraEnabled
    public static List < sObject > createContainerObjects() {
        List < sObject > returnList = new List < sObject > ();
        Account a = new Account(Name = '', FirstName = '', LastName = '', PersonEmail = '', Phone = '', BillingStreet = '', BillingCity = '', BillingState = '', BillingPostalCode = '', BillingCountry = '');
        Sales_Up__c sup = new Sales_Up__c(Source__c = '', Lead_Status__c = '');
        returnList.add(sup);
        return returnList;
    }
    @AuraEnabled
    public static List<sObject> getUserLocation(){
        List<sObject> returnList = new List<sObject>();
        
        returnList.add(new User());
        returnList.add(new Dealer_Location__c());

        try{
            user u = [SELECT Id, In_BDC__c, Division, Dealership_Location__c FROM User WHERE Id=: userInfo.getUserId()];
            List<Dealer_Location__c> locations = [SELECT Id, Company_Number__c FROM Dealer_Location__c WHERE Company_Number__c=:u.Division];
            if (locations.size() == 0 && u.In_BDC__c == false){
                throw new AuraHandledException('User division does not match any locations. Please set location via My Dealership Selector.');
            }
            returnList[0] = u;
            returnList[1] = locations.size() > 0 ? locations[0] : null;
    
            return returnList;
        } catch (QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<sObject> getCustomer(String objId){
        List<sObject> returnList = new List<sObject>();
        returnList.add(new Account());
        returnList.add(new Contact());
        try{
            //Account
            if(objId != null && objId.startsWith('001')){
                //try return aura handled exception
                Account a = [SELECT Id, Name, FirstName,LastName,PersonMobilePhone,Phone,PersonEmail,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry, isPersonAccount, PersonContactId FROM Account Where Id =:objId];
                returnList[0]=a;

                List<Contact> b2bCon = [SELECT Id, FirstName, LastName, Name FROM Contact WHERE AccountId =: a.Id];
                if(b2bCon.size() == 1){
                    returnList[1] = b2bCon[0];
                }
            }
            //Contact
            if(objId != null && objId.startsWith('003')){
                //try -return aura handled exception
            Contact c = [SELECT Id, Name, FirstName,LastName, Email, Phone, MobilePhone,isPersonAccount, AccountId FROM Contact WHERE Id=:objId];
            returnList[1]=c;
            }
        }catch(Exception e){
            returnList.add(new Account());
            returnList.add(new Contact());
        }
        return returnList;
    }

    // Account Search
    @AuraEnabled
    public static List<LookupSearchResult> searchAccounts(String searchTerm) {
        try {
            String sObjectName = Account.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> selectedAccount(String acctId)
    {
        try {
            String sObjectName = Account.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.geSelectionById(acctId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> recentAccounts()
    {
        try {
            LookupSearchAccount ls = new LookupSearchAccount();
            return ls.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Contact Search
    @AuraEnabled
    public static List<LookupSearchResult> searchContacts(String searchTerm, String accId) {
        try {
            LookupSearchContact l = new LookupSearchContact();
            return l.search(searchTerm, accId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> relatedContacts(String accountId)
    {
        try {
            LookupSearchContact ls = new LookupSearchContact();
            return ls.relatedContacts(accountId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> selectedContact(String contactId)
    {
        try {
            String sObjectName = Contact.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.geSelectionById(contactId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Contact> businessContacts(Account account){
        //try catch for null 
       List<Contact> returnList = [SELECT Id, Name, FirstName,LastName, Email, Phone, MobilePhone,isPersonAccount, AccountId FROM Contact WHERE AccountId=:account.Id];
       return returnList;
    }
    @AuraEnabled
    public static Account parentAccount(String contactId){
        try{
            Id parentId = [SELECT AccountId FROM Contact WHERE Id=:contactId].AccountId;
            Account a = [SELECT Id, Name, FirstName,LastName,PersonMobilePhone,Phone,PersonEmail,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry, isPersonAccount FROM Account Where Id =:parentId];
            return a;
        }catch (QueryException e){
            return new Account();
        }
    }
    @AuraEnabled
    public static Account determineAccountType(Account account) {
        boolean isPersonAccount = false;

        //account exists
        if (account.Id != null) {
            isPersonAccount = [SELECT IsPersonAccount FROM Account WHERE Id =: account.Id].IsPersonAccount;
            if (isPersonAccount) {
                account = formatPersonAccount(account);
            }
            if (!isPersonAccount) {
                account = formatBusinesssAccount(account);
            }

        } else {
            if (String.isBlank(account.Name)) {
                account = formatPersonAccount(account);
            }
            if (!String.IsBlank(account.Name)) {
                account = formatBusinesssAccount(account);
            }
        }
        return account;
    }
    @AuraEnabled
    public static List < sObject > doCreate(Account account, Contact contact, Sales_Up__c salesUp) {
        contact = contact!=null?contact:new Contact();
        List < sObject > returnList = new List < sObject > ();

        if (!String.isBlank(account.Name) && contact.Id == null) {
            contact.FirstName = account.FirstName;
            contact.LastName = account.LastName;
            contact.Phone = account.Phone;
            contact.Email = account.PersonEmail;
            contact.MobilePhone = account.PersonMobilePhone;
            contact.MailingStreet = account.BillingStreet;
            contact.MailingCity = account.BillingState;
            contact.MailingState = account.BillingState;
            contact.MailingCountry = account.BillingCountry;
            contact.MailingPostalCode = account.BillingPostalCode;
        }
        //account already exists
        if (account.id != null) {
            Account a = [SELECT Name, FirstName, LastName, Phone, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, PersonEmail, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingCountry, PersonMailingPostalCode, IsPersonAccount FROM Account WHERE Id =: account.Id];
            account.Name=account.Name!=null?account.Name:a.Name;
            account.FirstName=account.FirstName!=null?account.FirstName:a.FirstName;
            account.LastName=account.LastName!=null?account.LastName:a.LastName;
            account.PersonEmail=account.PersonEmail!=null?account.PersonEmail:a.PersonEmail;
            account.PersonMobilePhone=account.PersonMobilePhone!=null?account.PersonMobilePhone:a.PersonMobilePhone;
            account.BillingStreet=account.BillingStreet!=null?account.BillingStreet:a.BillingStreet;
            account.BillingCity=account.BillingCity!=null?account.BillingCity:a.BillingCity;
            account.BillingState=account.BillingState!=null?account.BillingState:a.BillingState;
            account.BillingPostalCode=account.BillingPostalCode!=null?account.BillingPostalCode:a.BillingPostalCode;
            account.BillingCountry=account.BillingCountry!=null?account.BillingCountry:a.BillingCountry;
           
            Boolean isPersonAccount = a.IsPersonAccount;
            if (isPersonAccount) {
                account = formatPersonAccount(account);
            }
            if (!isPersonAccount) {
                account = formatBusinesssAccount(account);
            }
        }
        //account doesn't already exist
        if (account.Id == null) {
            if (String.isBlank(account.Name)) {
                account = formatPersonAccount(account);
            }
            if (!String.IsBlank(account.Name)) {
                account = formatBusinesssAccount(account);
            }
        }
        if(account.Name == null && account.FirstName == null && account.LastName == null) throw new AuraHandledException('This Contact does not have an Account and an Account is required to create a Sales Up.');
        // Sales_Up__c newSalesUp = SalesUpApi.createSalesUp(account, contact, salesUp);

        SalesUp supInstance = new SalesUp();
        SalesUp.SalesUpWrapper salesUpWrapper = new SalesUp.SalesUpWrapper(account, contact, null, null, null, salesup, true);
        Sales_Up__c newSalesUp = supInstance.create(salesUpWrapper);
        
        Contact newContact = new Contact();
        //get information from newly created records:

        Account newAccount = [Select Id, Name, IsPersonAccount, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, Phone, PersonEmail,
            PersonMobilePhone, Firstname, LastName FROM Account WHERE Id =: newSalesUp.Customer_Account__c];

        try {
            newSalesUp = [SELECT Customer_Account__c, Lead_Status__c, Source__c, Owner.Name, Id, Lead_Date__c, Name From Sales_Up__c WHERE ID =: newSalesUp.Id];
        } catch (Exception ex) {
            newSalesUp = null;
        }
        

        try {
            if (newAccount.IsPersonAccount) {
                newContact = null;
            } else {
                newContact = [Select Id, AccountId, Name, FirstName, LastName, Phone, MobilePhone, Email FROM Contact WHERE AccountId =: newAccount.Id];
            }

        } catch (Exception ex) {
            newContact = null;
        }

        returnList.add(newSalesUp);
        returnList.add(newAccount);
        returnList.add(newContact);

        return returnList;
    }
    @AuraEnabled
    public static List < sObject > findCustomerDuplicates(Account account) {
        return SalesUpApi.findCustomerDuplicates(determineAccountType(account));
    }
    @AuraEnabled
    public static Map<String,String> getFieldLabels(){
      //Get Object Global Describe
        Map < String, String > fieldLabels = new Map < String, String > ();

        Schema.SObjectType supObjDescribe = Schema.getGlobalDescribe().get('dealer__Sales_Up__c');
        Schema.SObjectType accountObjDescribe = Schema.getGlobalDescribe().get('Account');

        //Get Field Labels
        Map < string, Schema.SObjectField > supMap = supObjDescribe.getDescribe().fields.getMap();
        for (String FieldApiName: supMap.keySet()) {
            if (fieldLabels.get(FieldApiName) == null)
                fieldLabels.put(FieldApiName, supMap.get(FieldApiName).getDescribe().getLabel());
        }

        Map < string, Schema.SObjectField > accountMap = accountObjDescribe.getDescribe().fields.getMap();
        for (String FieldApiName: accountMap.keySet()) {
            if (fieldLabels.get(FieldApiName) == null)
                fieldLabels.put(FieldApiName, accountMap.get(FieldApiName).getDescribe().getLabel());
        }

        return fieldLabels;
    }
    private static Account formatPersonAccount(Account account) {
        Account a =  new Account();
        a.Firstname = account.FirstName;
        a.LastName = account.LastName;
       
        a.Phone = a.Phone != null ? a.Phone : account.Phone;
        a.BillingStreet  = account.BillingStreet;
        a.BillingCity = account.BillingCity;
        a.BillingState = account.BillingState;
        a.BillingPostalCode = account.BillingPostalCode;
        a.BillingCountry = account.BillingCountry;
        a.PersonEmail = account.PersonEmail;
        a.PersonMobilePhone = account.PersonMobilePhone;
        a.PersonMailingStreet  = account.BillingStreet;
        a.PersonMailingCity = account.BillingCity;
        a.PersonMailingState = account.BillingState;
        a.PersonMailingPostalCode = account.BillingPostalCode;
        a.PersonMailingCountry = account.BillingCountry;
        if(account.Id != null){
            a.Id = account.Id;
        }
        
        return a;
    }
    private static Account formatBusinesssAccount(Account account) {
        return new Account(Id = account.Id, Name = account.Name,
            Phone = account.Phone,
            BillingStreet = account.BillingStreet,
            BillingCity = account.BillingCity,
            BillingState = account.BillingState,
            BillingPostalCode = account.BillingPostalCode,
            BillingCountry = account.BillingCountry);
    }
        @AuraEnabled
    public static List < List < sObject > > suggestSUPResults(String acctId) {
        Account acct = [SELECT Id, Name, firstName, lastName, PersonEmail, Phone, PersonMobilePhone FROM Account WHERE Id =: acctId];
        String name = acct.Name != null ? acct.Name : '';
        String fName = acct.firstName != null ?acct.firstName : '';
        String lName = acct.lastName != null ? acct.lastName : '';
        String mobile = acct.PersonMobilePhone != null ? acct.PersonMobilePhone : '';
        String phone = acct.Phone != null ? acct.Phone : mobile;
        String email = acct.personEmail != null ? acct.PersonEmail : '';
        Integer queryCharSize = (name+fName+lName+phone+email).length();
        if(queryCharSize <=1)
            return new List< List<sObject> >();

        name = name != null && name != '' ? name : null;
        fName = fName != null && fName != '' ? fName : null;
        lName = lName != null && lName != '' ? lName : null;
        phone = phone != null && phone != '' ? phone : null;
        email = email != null && email != '' ? email : null;

        //build search query string
        List < String > filterFields = new List < String > ();
        String filter = ' ';

        if (name != null)
        filterFields.add(name != null ? name + ' ' : ' ');
        if (fName != null)
        filterFields.add(filterFields.size() == 0 ? fName + ' ' : 'AND ' + fName + '* ');
        if (lName != null)
        filterFields.add(filterFields.size() == 0 ? lName + ' ' : 'AND ' + lName + '* ');
        if (phone != null)
        filterFields.add(filterFields.size() == 0 ? phone + ' ' : 'AND ' + phone + '* ');
        if (email != null)
        filterFields.add(filterFields.size() == 0 ? email + ' ' : 'AND ' + email + '* ');

        for (Integer i = 0; i < filterFields.size(); i++) {
            filter += filterFields[i];
        }
        List < List < SObject >> searchList = [FIND: filter IN ALL FIELDS RETURNING
        dealer__Sales_Up__c(Id, Owner.Name, RecordType.Name, Desired_Stock_Num__r.Stock_Number__c, CreatedDate, Lead_Status__c, Source__c, Name, Customer_Account__r.Name, Customer_Account__r.FirstName, Customer_Account__r.LastName, Customer_Account__r.PersonEmail, Customer_Account__r.Phone, dealer__Lead_Date__c)
        ];

        Sales_Up__c[] salesUps = ((List < Sales_Up__c > ) searchList[0]);


        List < List < Sobject > > returnList = new List < List < sObject > > ();
        
        returnList.add(salesUps);
        return returnList;
    }

    @AuraEnabled
    public static Boolean getPersonAccountStatus(String acctId){
        List<Account> accts = [SELECT isPersonAccount FROM Account WHERE Id =: acctId LIMIT 1];
        if(! accts.isEmpty()){
            Boolean b = accts[0].isPersonAccount;
            return b;
        }

        return true;
        
    }

    @AuraEnabled
    public static List<fieldSetWrapper> getSalesUpFieldset(){
        List<fieldSetWrapper> fields = new List<fieldSetWrapper>();
        List<Schema.FieldSetMember> fs = SObjectType.dealer__Sales_Up__c.FieldSets.dealer__NewRecordFieldSet.getFields();
        for(Schema.FieldSetMember field : fs){
            fieldSetWrapper o = new fieldSetWrapper();
            o.fieldName = field.getFieldPath();
            o.required = field.getRequired();
            fields.add(o);
        }
        return fields;
    }

    public class fieldSetWrapper{
        @AuraEnabled
        public String fieldName;

        @AuraEnabled
        public Boolean required;
        
    }
}