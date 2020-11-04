/**
 * ChangeContactAccountOwnerOnCarDeal
 * @description
 */
global class ChangeContactAccountOwnerOnCarDeal implements Database.Batchable<sObject>,Database.Stateful  {

    /**
     * @description
     */ 
    private final String initialState;
    
    /**
     * @description
     */ 
    String query;
    
    /**
     * @description
     */ 
    Integer batchsize =1;
  
    /**
     * start 
     * @param  BC
     * @return
     * @description    
     */ 
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
    // Access initialState here 
    
        return Database.getQueryLocator(query); 
    }
    
    /**
     * ChangeContactAccountOwnerOnCarDeal 
     * @param  query 
     * @description    
     */ 
    global ChangeContactAccountOwnerOnCarDeal(String query) 
    {
        this.query = query;
        this.batchsize = batchsize;
    }
   
    /**
     * @description
     */
    public Map<String,String> ContactsOwners = new Map<String,String>();
    
    /**
     * @description
     */
    public Map<String,String> AccountOwners = new Map<String,String>();
    
    /**
     * execute description
     * @return void
     * @description
     */ 
    global void execute(Database.BatchableContext BC, List<sObject> batch) 
    {
        // Access initialState here  
        ContactsOwners = new Map<String,String>();
        AccountOwners = new Map<String,String>();
        consList = new List<String>();
        AccsList = new List<String>(); 
        System.debug('SizeOf:'+batch.size());
        for(sObject s : batch){
            System.debug('Hello::'+s);
            if(s.get('Buyer_Contact__c') != null){
                if(s.get('Salesperson_1__c') != null)
                    ContactsOwners.put((String)s.get('Buyer_Contact__c'),(String)s.get('Salesperson_1__c'));
                else
                    ContactsOwners.put((String)s.get('Buyer_Contact__c'),(String)s.get('Salesperson_2__c'));    
                consList.add((String)s.get('Buyer_Contact__c'));
            }
            if(s.get('Buyer__c') != null){
                if(s.get('Salesperson_1__c') != null)
                    AccountOwners.put((String)s.get('Buyer__c'),(String)s.get('Salesperson_1__c'));
                else
                    AccountOwners.put((String)s.get('Buyer__c'),(String)s.get('Salesperson_2__c')); 
                AccsList.add((String)s.get('Buyer__c'));
            }   
        }  
        updateOwners(ContactsOwners,AccountOwners);
    }
    
    /**
     * @description
     */
    public List<String> consList = new List<String>();
    
    /**
     * @description
     */
    public List<String> AccsList = new List<String>();
    
    /**
     * updateOwners 
     * @param  con 
     * @param  Acc 
     * @return void
     * @description
     */ 
    global void updateOwners(Map<String,String> con,Map<String,String> Acc)
    {
        List<Contact> conList = new List<Contact>();
        for(Integer i=0;i<consList.size();i++){
            if(con.get(consList[i]) != null){
                Contact c = new Contact(Id = consList[i],ownerId=Con.get(consList[i]));
                conList.add(c);
            }
        }
        if(conList.size() > 0){
            try{
                update conList;
            }
            catch(Exception e){
                
            }
        }
        List<Account> AccList = new List<Account>();
        for(Integer i=0;i<AccsList.size();i++){
            if(Acc.get(AccsList[i]) != null){
                Account c = new Account(Id = AccsList[i],ownerId=Acc.get(AccsList[i]));
                AccList.add(c);
            }
        }
        if(AccList.size() > 0){
            try{
                update AccList;
            }
            catch(Exception e){
                
            }
        }
    }
    
    /**
     * finish 
     * @param  BC 
     * @return void
     * @description
     */ 
    global void finish(Database.BatchableContext BC) 
    {
    // Access initialState here 
    /*AsyncApexJob a = [SELECT id, ApexClassId,
                       JobItemsProcessed, TotalJobItems,
                       NumberOfErrors, CreatedBy.Email,Status
                       FROM AsyncApexJob
                       WHERE id = :BC.getJobId()];*/
                       
       // Send an email to the Apex job's submitter notifying of job completion. 
    
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {'mahesh.sidhu58@gmail.com'};
       String[] ccAddresses = new String[] {'dchandan_kumar@yahoo.co.in'};
       mail.setToAddresses(toAddresses);
       mail.setCcAddresses(ccAddresses);
       mail.setSubject('Apex Sharing Recalculation ');
       /*mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');*/
       mail.setPlainTextBody('The batch Apex job has been processed');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });                       
    }
}