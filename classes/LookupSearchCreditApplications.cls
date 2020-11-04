public with sharing class LookupSearchCreditApplications extends LookupSearch  {
    public LookupSearchCreditApplications() {
        this.MAX_RESULTS = 10;
        this.DOC_VALUE = 'Tax_Zone_Tab'; // Deal Tab.
    }
    
    public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {

        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            dealer__Credit_Application__c (Id, Name, dealer__ApplicationType__c 
            WHERE id NOT IN :selectedIds)
            LIMIT :MAX_RESULTS];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        dealer__Credit_Application__c [] apps = ((List<dealer__Credit_Application__c>) searchResults[0]);
        for (dealer__Credit_Application__c z : apps) {
            results.add( mapSearchResult(z) );
        }

        return results;
    }

    public override List<LookupSearchResult> getRecent() {
        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        
        Map<ID, RecentlyViewed> recents = new Map<ID, RecentlyViewed>([
            SELECT Id
            FROM RecentlyViewed 
            WHERE Type IN ('dealer__Credit_Application__c')
            ORDER BY LastViewedDate DESC 
        ]);

        dealer__Credit_Application__c [] tz = [
            SELECT Id, Name, dealer__ApplicationType__c
            FROM dealer__Credit_Application__c 
            WHERE Id IN :recents.keySet()
        ];

        for (dealer__Credit_Application__c t : tz) {
            results.add( mapSearchResult(t));
        }
        
        return results;
    }

    /**
     * supRelatedDeals returns deals related to a sales up
     * @param  dealId dealId description
     * @return List<LookupSearchResult> for displaying in custom lookup component
     */
    public List<LookupSearchResult> dealRelatedApps(String dealId){
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        List<Credit_Application__c> apps = CreditApplicationAPI.dealRelatedApps(dealId);
        
        for (Credit_Application__c a : apps) {
            results.add( mapSearchResult(a));
        }

        return results;
    }

    public override List<LookupSearchResult> geSelectionById(Id selectionId) {

        List<LookupSearchResult> results = new List<LookupSearchResult>();
                    
        Credit_Application__c [] apps = [
            SELECT Id, Name, ApplicationType__c
            FROM Credit_Application__c 
            WHERE Id =: selectionId
        ];

        for(Credit_Application__c a : apps){
            results.add(mapSearchResult(a));
        }
        
        return results;
    }

    private LookupSearchResult mapSearchResult(SObject o) {
        Credit_Application__c l = (Credit_Application__c) o;
        string title = l.Name;
        System.debug('title '+title);
        return new LookupSearchResult(
            l.Id, 
            'dealer__Credit_Application__c', 
            getDocIconURL(), // need URL 
            title, 
            l.ApplicationType__c,
            LookupSearchResult.IconType.DOC
        );
    }
}