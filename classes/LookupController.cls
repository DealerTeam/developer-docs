public with sharing class LookupController {
    @AuraEnabled
    public static List<LookupSearchResult> getSearchResult(String sObjectString, String searchTerm) {
        try {

            Boolean verified = verifySObjectTypeString(sObjectString);

            if(verified) {

                LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectString);

                return s.search(searchTerm);
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> getRecent(String sObjectString) {
        try {
            Boolean verified = verifySObjectTypeString(sObjectString);

            if(verified) {

                LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectString);
                
                return s.getRecent();
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getDefault(String sObjectString, Id objectId) {
        try {

            Boolean verified = verifySObjectTypeString(sObjectString);

            if(verified) {
                LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectString);
                
                return s.geSelectionById(objectId);
            } else {
                return null;
            }

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static Boolean verifySObjectTypeString(String sObjectString) {
        
        Boolean contains = Schema.getGlobalDescribe().containsKey(sObjectString);

        if(String.isBlank(sObjectString)) {
            return null;
        } else if(contains) {
            return contains;
        } else {
            throw new LookupException('Improper SObjectType String: ' + sObjectString + ' Please contact your administrator');
        }
    }

    public virtual class LookupException extends Exception {}

}