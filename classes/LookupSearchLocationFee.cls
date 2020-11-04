public with sharing class LookupSearchLocationFee extends LookupSearch  {
    
    public Id locationId {get;set;}

    public LookupSearchLocationFee() {
        this.MAX_RESULTS = 10;
        this.DOC_VALUE = 'Tax_Zone_Tab'; // Deal Tab.
    }
    
    public List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {

        List<LookupSearchResult> results = new List<LookupSearchResult>();
        if(locationId == null) return results;
        
        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [FIND :searchTerm IN ALL FIELDS RETURNING
            dealer__LocationFee__c (Active__c, DefaultCost__c, DefaultOnInvoice__c, DefaultPrice__c, Description__c, FeeCode__c, InvoiceType__c, Taxable__c, FeeMaster__c, Location__c, QuickPrice__c, QuickCost__c, Name, Id 
            WHERE id NOT IN :selectedIds AND Location__c =: locationId)
            LIMIT :MAX_RESULTS];

        // Prepare results

        Tax_Zones__c [] zones = ((List<Tax_Zones__c>) searchResults[0]);
        for (Tax_Zones__c z : zones) {
            results.add( mapSearchResult(z) );
        }

        return results;
    }

    public override List<LookupSearchResult> getRecent() {
        // Prepare results
        system.debug('location id from lus : '+locationId);
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        if(locationId == null) return results;

        LocationFee__c [] lf = [
            SELECT Active__c, DefaultCost__c, DefaultOnInvoice__c, DefaultPrice__c, Description__c, FeeCode__c, InvoiceType__c, Taxable__c, FeeMaster__c, Location__c, QuickPrice__c, QuickCost__c, Name, Id
            FROM LocationFee__c 
            WHERE Location__c =: locationId
        ];

        for (LocationFee__c t : lf) {
            results.add( mapSearchResult(t));
        }
        
        return results;
    }

    public override List<LookupSearchResult> geSelectionById(Id selectionId) {

        List<LookupSearchResult> results = new List<LookupSearchResult>();
                    
        Deal__c [] ds = [
            SELECT Id, Name, Sales_Lead__c, Vehicle__r.Name, Conversion_Description__c
            FROM Deal__c 
            WHERE Id =: selectionId
        ];

        for(Deal__c d : ds){
            results.add(mapSearchResult(d));
        }
        
        return results;
    }

    private LookupSearchResult mapSearchResult(SObject o) {
        LocationFee__c l = (LocationFee__c) o;
        string title = l.Name;
        return new LookupSearchResult(
            l.Id, 
            'dealer__LocationFee__c', 
            getDocIconURL(), // need URL 
            title, 
            l.Description__c,
            LookupSearchResult.IconType.DOC
        );
    }
}