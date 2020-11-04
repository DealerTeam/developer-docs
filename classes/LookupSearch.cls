/***
    Description:
    This class deals with returning LookupSearchResult Import these methods when searching
 */
public abstract class LookupSearch {
    
    protected final Integer MAX_RESULTS;
    protected final String DOC_VALUE;

    public List<LookupSearchResult> search(String searchTerm) {
        return this.Search(searchTerm, new List<String>());
    }
    abstract List<LookupSearchResult> search(String searchTerm, List<String> selectedIds);

    public abstract List<LookupSearchResult> getRecent();

    public abstract List<LookupSearchResult> geSelectionById(Id selectionId);

    abstract LookupSearchResult mapSearchResult(SObject o);
    
    protected String getDocIconURL() {

        List<Document> docs = [
            SELECT Id 
            FROM Document 
            WHERE DeveloperName =: DOC_VALUE 
            LIMIT 1
        ];

		if(docs.size()!=0) {
        	String imageId = docs[0].Id;
        	imageId = imageId.substring(0,15);

        	return '/servlet/servlet.FileDownload?file='+imageId;		
		}

		return '';
    }
   
}