public class DMSSyncBulkLoad {
    public Blob csvFileBody{get;set;}
    public String[] contactDataLines {get;set;}
    public List < Account > accList {get;set;}
    public boolean readSuccess {get;set;}
    public List<String> lstFieldNames{get;set;}
    String contactDataAsString;
    String dataType;
    
    public void readFromFile(String fileName, String fileType){
        try{
            Document doc = [SELECT Id, Body FROM Document WHERE folderId =: UserInfo.getUserId() AND Name =: fileName LIMIT 1];
            csvFileBody = doc.Body;
            contactDataAsString = csvFileBody.toString();
            lstFieldNames = new List<String>();
            accList = new List<Account>();
            dataType = fileType;

            readCSVFile();
        }
        catch(exception e){
            readSuccess = FALSE;
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'Error reading CSV file');
            ApexPages.addMessage(errorMessage);
        }
    }    
    
    public void readCSVFile() {
        
        //Get Record Types
        String businessType = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND isPersonType = false LIMIT 1].Id;
        String personType = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND isPersonType = true LIMIT 1].Id;
        
        //Split csv into lines and send those lines as a list of strings to batchable for processing
        contactDataLines = safeSplit(contactDataAsString,'\n');
        DMSSyncBulkLoadBatch batchable = new DMSSyncBulkLoadBatch(contactDataLines, dataType);
        Database.executeBatch(batchable, 200);
           
  }
  List<String> safeSplit(String inStr, String delim)
{
    Integer regexFindLimit = 100;
    Integer regexFindCount = 0;
    
    List<String> output = new List<String>();
    
    Matcher m = Pattern.compile(delim).matcher(inStr);
    
    Integer lastEnd = 0;

    while(!m.hitEnd())
    {
        while(regexFindCount < regexFindLimit && !m.hitEnd())
        {
            if(m.find())
            {
                output.add(inStr.substring(lastEnd, m.start()));  
                lastEnd = m.end();
            }
            else
            {
                output.add(inStr.substring(lastEnd));
                lastEnd = inStr.length();
            }
            
            regexFindCount++;
        }

        // Note: Using region() to advance instead of substring() saves 
        // drastically on heap size. Nonetheless, we still must reset the 
        // (unmodified) input sequence to avoid a 'Regex too complicated' 
        // error.
        m.reset(inStr);        
        m.region(lastEnd, m.regionEnd());
        
        regexFindCount = 0;
    }
    
    return output;
}
}