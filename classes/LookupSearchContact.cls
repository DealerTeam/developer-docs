public with sharing class LookupSearchContact extends LookupSearch{
    public LookupSearchContact() {
        this.MAX_RESULTS = 10;
        this.DOC_VALUE = 'Contact';

    }

    public List<LookupSearchResult> search(String searchTerm, String AccountId) {

        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            Contact (Id, Name, RecordType.Name WHERE AccountId =: AccountId)
            LIMIT :MAX_RESULTS];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        Contact [] contacts = ((List<Contact>) searchResults[0]);
        for (Contact c : contacts) {
            results.add( mapSearchResult(c) );
        }

        return results;
    }

    public list<LookupSearchResult> relatedContacts(String AccountId){
                // Prepare results
                List<LookupSearchResult> results = new List<LookupSearchResult>();
        
                Contact [] contacts = [SELECT Id, Name, RecordType.Name FROM Contact WHERE AccountId =: AccountId];
                for (Contact c : contacts) {
                    results.add( mapSearchResult(c) );
                }
        
                return results;
    }
    
    public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {

        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            Contact (Id, Name, RecordType.Name WHERE id NOT IN :selectedIds)
            LIMIT :MAX_RESULTS];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        Contact [] contacts = ((List<Contact>) searchResults[0]);
        for (Contact c : contacts) {
            results.add( mapSearchResult(c) );
        }

        return results;
    }

    public override List<LookupSearchResult> getRecent() {
        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        
        Map<ID, RecentlyViewed> recents = new Map<ID, RecentlyViewed>([
            SELECT Id
            FROM RecentlyViewed 
            WHERE Type IN ('Contact')
            ORDER BY LastViewedDate DESC 
            LIMIT 10
        ]);

        Contact [] contacts = [
            SELECT Id, Name, RecordType.Name
            FROM Contact 
            WHERE Id IN :recents.keySet()
        ];

        for (Contact c : contacts) {
            results.add( mapSearchResult(c));
        }
        
        return results;
    }
    
    public override List<LookupSearchResult> geSelectionById(Id selectionId) {

        List<Contact> contacts = [
            SELECT Id, Name, RecordType.Name
            FROM Contact
            WHERE Id =: selectionId
            LIMIT 1
        ];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        for (Contact c : contacts) {
            results.add( mapSearchResult(c) );
        }

        return results;
    }

    private LookupSearchResult mapSearchResult(SObject o) {
        Contact c = (Contact) o;
        return new LookupSearchResult(
            c.Id, 
            'Contact', 
            'standard:contact',
            c.Name,
            null,
            LookupSearchResult.IconType.SLDS
        );
    }
}