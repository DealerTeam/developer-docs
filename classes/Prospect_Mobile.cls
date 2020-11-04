public without sharing class Prospect_Mobile {

    /** WRAPPER CLASSES ***/

    /**
     *  A Wrapper class to send back to the a lightning component.
     *  @param savedUp  String      - the Id of the saved
     *  @param dupes    List<Sales_Up__c> - a List of duplicate Sales Up records.
     *  @param aDupes   List<Account>     - List of Accounts
     */
    public class resultWrap {

        @AuraEnabled
        public boolean hasDups {get; set;}
        @AuraEnabled
        public String dupeType {get; set;}

        @AuraEnabled
        public String Id {get; set;}

        @AuraEnabled
        public List<dealer__Sales_Up__c> dSups {get; set;}
        
        @AuraEnabled
        public List<Account> dActs {get; set;}

        public resultWrap(String resultId, List<dealer__Sales_Up__c> dupes, List<Account> aDupes) {

            if(resultId!=null && aDupes == null && dupes == null) {
                Id = resultId;
                dSups = null;
                hasDups = false;
                dActs = null;

            }else if (aDupes!=null && dupes == null && resultId == null ) {
                dActs = aDupes;
                dupeType = 'account';

                Id = null;
                dSups = null;
                hasDups = true;
            } else {
                dSups = dupes;
                dupeType = 'sales up';

                Id = null;
                hasDups = true;
                dActs = null;
            }
        }
    }

    /**
     * Act Result Class: a wrapper class so we know if account creation has duplicates or not.
     * @param  wrap a resultWrap object to pass through
     */
    public class actResult {
        @AuraEnabled
        public Boolean hasDupes {get;set;}
        @AuraEnabled
        public resultWrap daWrap   {get;set;}
        @AuraEnabled
        public Account acct   {get;set;}

        public actResult(resultWrap wrap, Account act) {
            
            if(wrap != null) {
                daWrap = wrap;
                hasDupes = true;

                acct = null;
            } else {
                hasDupes = false;
                daWrap = null;
                
                acct = act;
            }
        }
    }

    /**
     * A method to connect a newly created Account to a Sales Up
     * @param  act An Account object
     * @param  sup a Sales_Up__c object
     * @return     boolen true id successful
     */
    public Sales_up__c assignAccountToSup(dealer__Sales_Up__c sup, String actId ) {
            // Success updating Sales Up!
            sup.dealer__Customer_Account__c = actId; 

            // Get the Related Contact
            Contact[] c = [Select Id from Contact where AccountId =:actId limit 1];
            if(c.size()==1) {
                sup.dealer__Buyer_Contact__c = c[0].Id; 
            } 

            /*
            try {
                update sup;
            } catch (DmlException e) {
                //return false;
            }
            */
           
            return sup;
    }

    /**
     * A Method to return the associated Account and Contact of a newly created accout that can 
     * be associated with a Sales Up
     * @param  nup  THe sales up record to create the account from
     * @return      Returns Map<String,sObject> with Keys ['a','c'].
     */
    public actResult accountFromSup(dealer__Sales_Up__c nup, Boolean checkDupli) {

        // Create the Account
        Account a = new Account();
        a.FirstName         =   nup.dealer__FirstName__c;
        a.LastName          =   nup.dealer__LastName__c;
        a.PersonEmail       =   nup.dealer__Email__c;
        a.PersonHomePhone   =   nup.dealer__Phone__c;
        a.PersonMobilePhone =   nup.dealer__Mobile__c;      

        List<Account> daDupes = new List<Account>();

        if(checkDupli) {

            // Begin the query string
            String queryStart = 'SELECT Name, FirstName, LastName, PersonMobilePhone, PersonEmail, PersonHomePhone FROM Account WHERE FirstName = \''+nup.dealer__FirstName__c+'\' AND LastName = \''+nup.dealer__LastName__c+'\' ';
            String queryTail = 'ORDER BY Name LIMIT 1000';
            
            // Make a list for the Query Parts.
            List<String> qBits = new List<String>();

            // Build out query parts
            if( !dealer.Utility.isBlank(nup.dealer__Email__c) ) {
                qBits.add(' PersonEmail LIKE  \'%' +nup.dealer__Email__c+ '%\'' );
            }
            if( !dealer.Utility.isBlank(nup.dealer__Phone__c) ) {
                qBits.add(' PersonHomePhone LIKE  \'%' +nup.dealer__Phone__c+ '%\'' );
            }
            if( !dealer.Utility.isBlank(nup.dealer__Mobile__c) ) {
                qBits.add(' PersonMobilePhone LIKE  \'%' +nup.dealer__Mobile__c+ '%\'' );
            }        

            String queryMid = '';
            // Then build the query string from the Bits.
            for(Integer i = 0; i < qBits.size(); i++){

                // Prefix the bits with some query operators
                if (i == 0) {
                     queryMid += ' AND ( ';
                }
                if (i > 0) {
                    queryMid += ' OR ';
                }
                // Concatenate the bits
                queryMid += qBits.get(i);

                if(i == qBits.size()-1) {
                    queryMid += ' ) ';
                }
            }

            daDupes = Database.query( queryStart + queryMid + queryTail );

            // Duplicates found
            if(daDupes.size()>0) {

                return new actResult(new resultWrap( null, null, daDupes), null );
            }
        } 

        // No Duplicates Found and override check duplicates
        if(!checkDupli || daDupes.isEmpty()) {
            insert a;
        }

        return new actResult(null , a);
    }
    
    /**
     * Upsert a new Sales Up
     * @param  nup Sales_Up__c to insert
     * @param  acct Account to associate with Nup
     * @param  chkAcct Boolean a boolean to turn off account duplicate checking
     * @return     A resultWrap object
     */
    @AuraEnabled
    public static resultWrap upsertProspect(dealer__Sales_Up__c nup ) {

        System.debug('** Upsert Prospect **');

        System.debug(nup);

        // Instantiate this class to create accounts and stuff
        Prospect_Mobile supMob = new Prospect_Mobile();
        return supMob.upsertProWOAcct(nup,true);
    }

    /**
     * Upsert a Sales_Up__c skipping account duplicate checking
     * @param  nup Sales_Up__c
     * @return     resultWrap object
     */
    @AuraEnabled
    public static resultWrap upsertProSkip(dealer__Sales_Up__c nup ) {
        // Instantiate this class to create accounts and stuff
        Prospect_Mobile supMob = new Prospect_Mobile();
        return supMob.upsertProWOAcct(nup,false);
    }

    /**
     * Upsert a Sales Up without checking for duplicate Accounts
     * @param  nup           Sales_Up__c
     * @param  skipAcctDupli Boolean
     * @return               resultWrap Object
     */
    public resultWrap upsertProWOAcct( dealer__Sales_Up__c nup, Boolean skipAcctDupli ){

        // Instantiate this class to create accounts and stuff
        Prospect_Mobile supMob = new Prospect_Mobile();

        // If the account is already set dont create or check for duplicates.
        if(nup.dealer__Customer_Account__c != null) {
            
            nup = supMob.assignAccountToSup(nup, nup.dealer__Customer_Account__c);

        } else {
            // Create account from user input SU data entry

            // Create account and return Map<String,sObject>
            actResult actSuccess = supMob.accountFromSup(nup,skipAcctDupli);
            if( actSuccess.hasDupes == true ) {

                // actSuccess.resultWrap
                return actSuccess.daWrap;

            } else {
                
                if(actSuccess.acct!=null) {
                    // An Account is created and passed through a ActResult Object
                    nup = supMob.assignAccountToSup(nup,actSuccess.acct.Id);
                }
            }

        }
        
        //Try saving the Sales Up
        Database.SaveResult saveResult = Database.insert(nup, false);

        // Did it save?
        if(!saveResult.isSuccess()) {

            // It didnt sace so get the errors
            for(Database.Error error : saveResult.getErrors()) {
                
                // Was this a duplicate error?
                Prospect_Mobile pm = new Prospect_Mobile();
                List<sObject> duplicateRecords = pm.getDuplicateList(error);
                List<String> duplicateIds = new List<String>();
                
                if(duplicateRecords != null && duplicateRecords.size()>0){
                    // Loop through sObject list and cast as Sales_Up - I couldnt get the MatchRecords to be casted as Sales_Ups
                    for (sObject o : duplicateRecords) {
                        duplicateIds.add( o.Id );
                    }

                    // Fields
                    List<dealer__Sales_Up__c> daDupes = [SELECT Name, dealer__FirstName__c, dealer__LastName__c, dealer__Mobile__c, dealer__Email__c, dealer__Phone__c, dealer__Desired_Stock_Num__c FROM Sales_Up__c WHERE Id in: duplicateIds];

                    return new resultWrap( null, daDupes, null);
                }
            }
        }   

        // Setup return 
        resultWrap resultWrapR = new resultWrap( saveResult.getId(), null, null);
        return resultWrapR;

    }

    /**
     * Get a list of duplicate sObjects
     * @param  error a Database.DuplicateError object
     * @return       Returns a lits of sObjects
     */
    public List<sObject> getDuplicateList(Database.Error error) {

        // Was this a duplicate error?
        if(error instanceof Database.DuplicateError) {

            Database.DuplicateError duplicateError = (Database.DuplicateError)error;
            Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();

            Datacloud.Matchresult[] matchResults = duplicateResult.getMatchResults();
            Datacloud.MatchResult matchResult = matchResults[0];
            Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();

            List<sObject> duplicateRecords = new List<sObject>();

            for(Datacloud.Matchrecord matchRecord : matchRecords) {
              duplicateRecords.add(matchRecord.getRecord());
            }

            return duplicateRecords;
        }

        return null;
    }

    /**
     * Upsert Sales_Up__c and override the duplicate settings.
     * @param  nup Sales_Up__c to insert
     * @return     A resultWrap object
     */
    @AuraEnabled
    public static resultWrap upsertUpOverride(dealer__Sales_Up__c nup) {
        
        // instantiate this class to use the account method
        Prospect_Mobile supMob = new Prospect_Mobile();

        if(nup.dealer__Customer_Account__c != null) {
            // Dont check for du[plicate accounts if there is an account
            nup = supMob.assignAccountToSup(nup , nup.dealer__Customer_Account__c);
        } else {

            // Create account and return Map<String,sObject>
            actResult actSuccess = supMob.accountFromSup(nup,true);

            if( actSuccess.hasDupes == true ) {

                // actSuccess.resultWrap
                return actSuccess.daWrap;

            } else {
                if(actSuccess.acct!=null) {
                    // An Account is created and passed through a ActResult Object
                    nup = supMob.assignAccountToSup(nup,actSuccess.acct.Id);
                }
            }

        }


        Database.DMLOptions options = new Database.DMLOptions();
        options.DuplicateRuleHeader.AllowSave = true;
        Database.SaveResult sr2 = Database.Insert(nup, options);
        if(!sr2.isSuccess()) {
            throw new prospectException( 'Error Saving Record : '+sr2.getErrors() );
              return null;
        }

        return new resultWrap( nup.Id, null, null);
    }

    public class prospectException extends Exception {}


    /*
    public PageReference saveDuplicateOverride() {
        
        Database.DMLOptions options = new Database.DMLOptions();
        options.DuplicateRuleHeader.AllowSave = true;
        Database.SaveResult sr2 = Database.Insert(up, options);
        if(!sr2.isSuccess()) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error Saving Record : '+sr2.getErrors()));
          return null;
        }

        // Create the Account and link to the Sales Up
        Account a = new Account();
        a.FirstName     =   up.dealer__FirstName__c;
        a.LastName      =   up.dealer__LastName__c;
        a.PersonEmail   =   up.dealer__Email__c;
        a.PersonHomePhone  =up.dealer__Phone__c;
        a.PersonMobilePhone=up.dealer__Mobile__c;      
         
         insert a;

          // Get the Related Contact
          Contact[] c = [Select Id from Contact where AccountId =:a.Id limit 1];
          if(c.size()==1) {
              up.dealer__Buyer_Contact__c = c[0].Id;
          }

          // Set the Account
          up.dealer__Customer_Account__c = a.Id; 

          update up;
          
        return (new ApexPages.Standardcontroller(up)).view();    
    }
    */

    //public List<Contact> searchExistingContacts(String firstName, String lastName, String emailAddress, String primaryPhone, String mobilePhone) {
        
        //    String scSoql = 'SELECT Id, Name, FirstName, LastName, Email, MobilePhone, Phone, LastActivityDate, OwnerId, '+
        //                                        ' MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, '+ 
        //                                        ' CreatedDate, dealer__External_ID__c '+ 
        //                                        ' FROM Contact WHERE '+ 
        //                                        ' IsDeleted = false ';
        //    system.debug('******searchOptions'+searchOptions);
        //    scSoql+='and((';
        //    if(firstName!=null&&firstName!='' && searchOptions.inFirstName) {
        //        scSoql+=' FirstName = \''+String.escapeSingleQuotes(firstName)+'\' ';
        //    }
            
        //    if(firstName!=null&&firstName!='' && searchOptions.inFirstName)  {
        //        scSoql += ' and ';  
        //    }
            
        //    if(lastName!=null&&lastName!='' && searchOptions.inLastName) {
        //        scSoql+=' LastName = \''+String.escapeSingleQuotes(lastName)+'\' ';
        //    }
        //    scSoql+=')';
            
        //    if(emailAddress!=null&&emailAddress!='' && searchOptions.inEmail) {
        //        scSoql+=' or Email = \''+String.escapeSingleQuotes(emailAddress)+'\' ';
        //    }
        //    if(primaryPhone!=null&&primaryPhone!='' && searchOptions.inPhone) {
        //        scSoql+=' or Phone = \''+String.escapeSingleQuotes(primaryPhone)+'\' ';
        //    }
        //    if(mobilePhone!=null&&mobilePhone!='' && searchOptions.inMobile) {
        //        scSoql+=' or MobilePhone = \''+String.escapeSingleQuotes(mobilePhone)+'\' ';
        //    }
            
        //    scSoql += ' ) ';
            
        //    // Check to see if all contact methods where blank and strip the AND ( )
        //    scSoql.replace('and ( )', '');
            
        //    scSoql+=' order by LastActivityDate desc limit 25';
            
        //    System.debug('the soql is'+scSoql);
            
        //   List<Contact> searchContacts= Database.query(scSoql);
        //   system.debug('*****searchContacts**'+searchContacts);
        //    if(searchContacts.size()==0) {
        //        return new List<Contact>();
        //    } else {
        //        return  searchContacts; 
        //    }                                   
    //}



}