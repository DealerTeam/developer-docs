/**
* AccountConvertController
* @description This class provides lightning components conversion methods for accounts
*/
public with sharing class AccountConvertController {
    
    /**
    * getRecordType
    * @return Account
    * @description Provides record type of respective Account
    */
    @AuraEnabled(cacheable=true)
    public static Account getRecordType(Id acctId) 
    {
        return Utility.getRecordType(acctId);
    }

    /**
    * getRecordSelect
    * @return List<Utility.Selection>
    * @description 
    */
    @AuraEnabled(cacheable=true)
    public static List<Utility.Selection> getRecordSelect(Boolean b2b)
    {
        return Utility.getRecordSelect(b2b);
    }
  
    /**
    * convertToPersonAccount
    * @return Boolean
    * @description returns true if the account was succesfully converted to Person Acct, false if the record type conversion failed.
    */
    @AuraEnabled
    public static Boolean convertToPersonAccount(Account acct, String First, String Last, String RTId)
    { 
        return Utility.convertToPersonAccount(acct, First, Last, RTId);
    }

    /**
    * convertToBusinessAccount
    * @return Boolean
    * @description returns true if the account was succesfully converted to Business Acct, false if the record type conversion failed.
    */
    @AuraEnabled
    public static Boolean convertToBusinessAccount(Account acct, String Name, String RTId)
    {
        return Utility.convertToBusinessAccount(acct,Name,RTId);
    }

    /**
    * Retrieves recent Accounts 
    * @param  acctId String  
    * @return List<LookupSearchResult>
    */
    @AuraEnabled
    public static List<LookupSearchResult> recentAccountResult()
    {
        try {
            LookupSearchAccount ls = new LookupSearchAccount();
            return ls.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * Searches Accounts 
    * @param  searchTerm String
    * @return List<LookupSearchResult>
    */
    @AuraEnabled
    public static List<LookupSearchResult> searchAccounts(String searchTerm)
    {
        try {
            String sObjectName = Account.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void mergeAccount(String acctId, String masterAcct){
        
        try{
            Account masterAccount = [SELECT Id, RecordTypeId FROM Account WHERE Id =: masterAcct];
            Account mergeAccount =new Account(Id = acctId, RecordTypeId = masterAccount.RecordTypeId);
            update mergeAccount;
            merge masterAccount mergeAccount;
        }
        catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}