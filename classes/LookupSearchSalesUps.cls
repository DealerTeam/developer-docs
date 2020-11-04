public with sharing class LookupSearchSalesUps extends LookupSearch  {
    public LookupSearchSalesUps() {
        this.MAX_RESULTS = 10;
        this.DOC_VALUE = 'Tax_Zone_Tab'; //Sup Tab
    }
    
    //Done
    public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {

        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            dealer__Sales_Up__c (Id, Name 
            WHERE id NOT IN :selectedIds)
            LIMIT :MAX_RESULTS];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        Sales_Up__c [] sups = ((List<Sales_Up__c>) searchResults[0]);
        for (Sales_Up__c s : sups) {
            results.add( mapSearchResult(s) );
        }

        return results;
    }

    //Done
    public override List<LookupSearchResult> getRecent() {
        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        
        Map<ID, RecentlyViewed> recents = new Map<ID, RecentlyViewed>([
            SELECT Id
            FROM RecentlyViewed 
            WHERE Type IN ('dealer__Sales_Up__c')
            ORDER BY LastViewedDate DESC 
        ]);

        Sales_up__c [] sups = [
            SELECT Id, Name
            FROM Sales_up__c 
            WHERE Id IN :recents.keySet()
        ];

        for (Sales_up__c s : sups) {
            results.add( mapSearchResult(s));
        }
        
        return results;
    }

    // /**
    //  * supRelatedDeals returns deals related to a sales up
    //  * @param  dealId dealId description
    //  * @return List<LookupSearchResult> for displaying in custom lookup component
    //  */
    // public List<LookupSearchResult> appRelatedDeals(String appId){
    //     List<LookupSearchResult> results = new List<LookupSearchResult>();

    //     List<Deal__c> deals = CreditApplicationAPI.relatedDeals(appId);
        
    //     for (Deal__c d : deals) {
    //         results.add( mapSearchResult(d));
    //     }

    //     return results;
    // }

    //Done
    public override List<LookupSearchResult> geSelectionById(Id selectionId) {

        List<LookupSearchResult> results = new List<LookupSearchResult>();
                    
        Sales_Up__c [] ds = [
            SELECT Id, Name
            FROM Sales_Up__c 
            WHERE Id =: selectionId
        ];

        for(Sales_up__c d : ds){
            results.add(mapSearchResult(d));
        }
        
        return results;
    }

    //Done
    private LookupSearchResult mapSearchResult(SObject o) {
        Sales_up__c l = (Sales_up__c) o;
        string title = l.Name;
        // title += l.Vehicle__r != null ? l.Vehicle__r.Name : '';
        System.debug('title '+title);
        return new LookupSearchResult(
            l.Id, 
            'dealer__Deal__c', 
            getDocIconURL(), // need URL 
            title, //Title
            '',
            LookupSearchResult.IconType.DOC
        );
    }
}