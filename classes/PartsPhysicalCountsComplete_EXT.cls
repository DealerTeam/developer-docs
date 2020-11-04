/* W-001435 Start 
*  Add pagination to Enter Counts Page to manage collection size > 1000 
*/
public class PartsPhysicalCountsComplete_EXT {
	
    public dealer__PartPhysicalInventory__c ppi {get;set;}
    public List<dealer__PartsPhysicalDetail__c> detailRecords {get;set;}
    
    public PartsPhysicalCountsComplete_EXT(ApexPages.StandardController c) { 
        
        ppi = (dealer__PartPhysicalInventory__c)c.getRecord();  
    }     
    
    public ApexPages.StandardSetController setCon {
        get{ 
            if(setCon==null && ppi.Id!=null){ 
                       	
                detailRecords = PartsPhysicalInventoryAPI.loadDetailRecords(ppi.Id);
                setCon = new ApexPages.StandardSetController(detailRecords);
                setCon.setPageSize(50);                
             }
               
            return setCon;
        }
        set;
    }
    
    
    public List<dealer__PartsPhysicalDetail__c> getDetail_records(){
          return (List<dealer__PartsPhysicalDetail__c>) setCon.getRecords();
    }
    
    //Post the count sheets to the detail page.
    public PageReference saveCounts() {       
        return PartsPhysicalInventoryAPI.saveCountApiMethod(detailRecords, ppi);
    }
    
    //publish the physical to the inventory
    public PageReference completePhysical () {
        return PartsPhysicalInventoryAPI.completePhysicalAPIMethod(this.ppi);
    }
        
    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         
      	try{
            setCon.first();
        }catch(Exception e){
            setCon.Save();
            setCon.first();
        }
     }

     // returns the last page of records
     public void last() {
         
        try{
            setCon.last();
        }catch(Exception e){
            setCon.Save();
            setCon.last();
        }
     }

     // returns the previous page of records
     public void previous() {
         
         try{
            setCon.previous();
        }catch(Exception e){
            setCon.Save();
            setCon.previous();
        }         
     }

     // returns the next page of records
     public void next() {
         
        try{
            setCon.Next();
        }catch(Exception e){
            setCon.Save();
            setCon.Next();
        }
     }

}