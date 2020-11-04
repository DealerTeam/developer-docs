/**
 * ContactsDuplicateSearch
 * @description
 */
global with sharing class ContactsDuplicateSearch {
    
    /**
     * @description
     */
    public Contact up;
    
    /**
     * @description
     */
    public searchUps searchOptions { get;set; }
    
    /**
     * @description
     */
    public List<Contact> searchContactResults {get;set;}
    
    /**
     * @description
     */
    public List<dealer__Sales_Up__c> searchUpsResults {get;set;}
    
    /**
     * @description
     */
    public dealer__DMS_Settings__c dms {get; private set;}
    
    /**
     * @description
     */
    public List<AvaliableContacts> activeContacts {get; set;} 
    
    /**
     * @description
     */
    public List<VINDecoder_DataOneSoftware.StyleData> ModelKeyList;
    
    /**
     * @description
     */
    public VINDecoder_DataOneSoftware.StyleData sdat;
    
    /**
     * @description
     */
    public VINDecoder_DataOneSoftware.DecodeResponseStruct ddat;
    
    /**
     * @description
     */
    public String SelectedStyleId;
    
    /**
     * @description
     */
    public Boolean matchEscape = false;
    
    /**
     * @description
     */
    public Boolean isMerge{get;set;}
    
    /**
     * @description
     */
    public VINDecoder vd = new VINDecoder();        
    
   /**
    * ContactsDuplicateSearch 
    * @param  c 
    * @description
    */
    public ContactsDuplicateSearch(ApexPages.StandardController c) 
    { 
        List<String> af = new List<String>();
        if(!Test.isRunningTest()) {
            /*af.add('dealer__Buyer_Contact__c');
            af.add('dealer__Car_Deal__c');
            af.add('dealer__Co_Buyer_Contact__c');
            af.add('dealer__Comments__c');
            af.add('dealer__Desk_Manager_User__c');
            */
            af.add('Email');
            af.add('FirstName');
            //af.add('dealer__Internet_Customer__c');
            af.add('LastName');
            //af.add('dealer__Lead_Date__c');
            //af.add('dealer__Make__c');
            //af.add('dealer__Model__c');
            af.add('Phone');
            //af.add('dealer__Salesperson_1__c');
            //af.add('dealer__Salesperson_2__c');
            //af.add('dealer__Year_High__c');
            af.add('MobilePhone');
            c.addFields(af);
        }   
            
        searchUpsResults = new List<dealer__Sales_Up__c>();
        searchContactResults = new List<Contact>();
        
        up = (Contact)c.getRecord();
        isMerge=false;
        
        // Declare search settings for duplicates
        searchOptions = new searchUps(isBlank(up.FirstName), 
                              isBlank(up.LastName), 
                              isBlank(up.Email), 
                              isBlank(up.Phone), 
                              isBlank(up.MobilePhone), 
                              up.FirstName, 
                              up.LastName, 
                              up.Email,
                              up.Phone,
                              up.MobilePhone);
                                          
        
     activeContacts = new List<AvaliableContacts>();
        
        // If controller search for duplicates page pre-populate search results
        if(ApexPages.currentPage().getUrl().contains('ContactsDuplicateSearch') && up.FirstName!=null) {
            System.debug('Searching existing for dupes');
            searchContactResults = this.searchExistingContacts(up.FirstName, up.LastName, up.Email, up.Phone, up.MobilePhone);
            activeContacts.clear();
            
            for(Contact  s:searchContactResults){
            AvaliableContacts thisContact= new AvaliableContacts();
            thisContact.junctionRecord=s;
            activeContacts.add(thisContact);
         }
            //searchUpsResults   = this.searchExistingUps(up.dealer__FirstName__c, up.dealer__LastName__c, up.dealer__Email__c, up.dealer__Phone__c, up.dealer__Mobile__c);
            //System.debug('searchUpsResults'+searchUpsResults);
            //activeSalesup.clear();  
                    
        }
    }
    
    
    public String getUserName() {
        return UserInfo.getName();
    }
   
    public String getUserId() {
        return UserInfo.getUserId();
    }
    
    public Id selectedCustomerId {get;set;}
    
    public Integer searchCustomerSize {
            get {
                return searchContactResults.size();
            }
            set {}
    }
    
    public Integer searchUpsSize {
        get {
            return searchUpsResults.size();
        }
        set {}
    }
    
    public class searchUps {
        
        public boolean inFirstName {get; set;}
        public boolean inLastName {get;set;}
        public boolean inEmail {get;set;}
        public boolean inPhone {get;set;}
        public boolean inMobile {get;set;}
        public String firstName {get;set;}
        public String lastName {get;set;}
        public String upEmail {get;set;}
        public String upPhone {get;set;}
        public String upMobile {get;set;}
        
        public searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, 
                            string firstn, string lastn, string uemail, string uphone, string umobile) {
            inFirstName =   inFirst;
            inLastName  =   inLast;
            inEmail     =   inEmailAddr;
            inPhone     =   inPhoneNum;
            inMobile    =   inMobileNum;
            
            firstName   =   firstn;
            lastName    =   lastn;
            upphone     =   uphone;
            upmobile    =   umobile;
            upEmail     =   uEmail;
        }
    }   
    public List<Contact> searchExistingContacts(String firstName, String lastName, String emailAddress, String primaryPhone, String mobilePhone) {
        System.debug('searchOptions>>'+searchOptions);
        String scSoql = 'select Id, Name, FirstName, LastName, Email, MobilePhone, Phone, LastActivityDate, OwnerId, '+
                                            ' MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode '+  
                                            ' from Contact where '+ 
                                            ' IsDeleted = false ';
        
        if(firstName!=null&&firstName!='' && searchOptions.inFirstName) {
            scSoql+=' and FirstName = \''+String.escapeSingleQuotes(firstName)+'\' ';
        }
        if(lastName!=null&&lastName!='' && searchOptions.inLastName) {
            scSoql+=' and LastName = \''+String.escapeSingleQuotes(lastName)+'\' ';
        }
        if(emailAddress!=null&&emailAddress!='' && searchOptions.inEmail) {
            scSoql+=' and Email = \''+String.escapeSingleQuotes(emailAddress)+'\' ';
        }
        if(primaryPhone!=null&&primaryPhone!='' && searchOptions.inPhone) {
            scSoql+=' and Phone = \''+String.escapeSingleQuotes(primaryPhone)+'\' ';
        }
        if(mobilePhone!=null&&mobilePhone!='' && searchOptions.inMobile) {
            scSoql+=' and MobilePhone = \''+String.escapeSingleQuotes(mobilePhone)+'\' ';
        }
        
        System.debug(scSoql);
        
        List<Contact> searchContacts = Database.query(scSoql);
        
        if(searchContacts.size()==0) {
            return new List<Contact>();
        } else {
            return searchContacts;
        }                                   
    }
    
    public PageReference FindDupes() {
        searchContactResults = this.searchExistingContacts(searchOptions.firstName, searchOptions.lastName, searchOptions.upEmail, searchOptions.upPhone, searchOptions.upMobile);
        activeContacts.clear();
        for(Contact  s:searchContactResults){
            AvaliableContacts thisContact= new AvaliableContacts();
            thisContact.junctionRecord=s;
            activeContacts.add(thisContact);
        }             
            PageReference searchResultsPage = Page.ContactsDuplicateSearch;
            return searchResultsPage;
    }
    
    
    public Boolean isBlank(String s){
        if(s==null||s=='') {
            return false;
        } else {
            return true;
        }
    }
    public String getSelectedStyleId() {
        return SelectedStyleId;
    }
    
    public void setSelectedStyleId(String SelectedStyleId) {
        this.SelectedStyleId = SelectedStyleId;
    }       
    
    public class SalesUpException extends Exception {}
    
    // inner class for maintaining checkbox
    public class AvaliableContacts{
        public Boolean isChecked {get; set;}
        public Integer counter {get; set;}
        public Contact junctionRecord {get; set;}
        public AvaliableContacts(){
            isChecked = false;
            counter = 0;
            junctionRecord = new Contact();
        }
        
    }
    public Integer ActiveRecordsCount{get;set;}
    
    public pageReference mergeRecords(){
        String pIDs='';
        System.debug('activeSalesup>>'+activeContacts);
        ActiveRecordsCount=0;
         for(AvaliableContacts salesUp : activeContacts){
                
                if(salesUp.isChecked){
                    ActiveRecordsCount=ActiveRecordsCount+1;
                    pIDs = pIDs + salesUp.junctionRecord.ID +':';
                }
            }
        System.debug('pIDs>>'+pIDs+'ActiveRecordsCount'+ActiveRecordsCount);
        if(ActiveRecordsCount ==2 || ActiveRecordsCount ==3){
            PageReference viewPage= new PageReference('/apex/MergeSalesup');
            viewPage.getParameters().put('pIDs',pIDs);
             viewPage.getParameters().put('Type','Contact');
            viewPage.setRedirect(true);
            return viewPage;
        }
        return null;
        
    }
    
}