/**
 * MergeSalesup
 * @description
 */
public without sharing class MergeSalesup {

    
    //this guides the number of merged records
    
    /**
     * getMaxRecordsCount 
     * @return Integer
     * @description
     */
    public Integer getMaxRecordsCount(){return MergeRecordsUtil.MERGED_RECORDS_COUNT;}
    
    //choosen sobject
    
    /**
     * @description
     */
    public String sObjectType{set;get;}
    
    //sobject has changed
    
    /**
     * @description
     */
    public String sObjectTypeOld = null;
    
    //search text

    /**
     * @description
     */ 
    public String searchText{get;Set;}
    
    /**
     * @description
     */
    public String soslFields;
    
    
    //results of the search SOSL query

    /**
     * @description
     */
    public List<SObject> foundRecordList{get;set;}
    
    /**
     * @description
     */ 
    public List<dealer__Sales_Up__c> foundSalesUpList{get;set;}
    
    //SObject list

    /**
     * @description
     */
    public List<SelectOption> sobjectsSlctOpt{get;Set;}
    
    //merging objects

    /**
     * @description
     */
    public List<SObject> merginObjects{get;set;}

    
    /*
        list of selected fields of all object
        stores:
            {OBJ-ID1, 
                    {FIELD1, TRUE}
                    {FIELD2, TRUE}
                    ...
                    {FIELDN, FALSE}
            OBJ-ID2, 
                    {FIELD1, FALSE}
                    {FIELD2, FALSE}
                    ...
                    {FIELDN, TRUE}
            }
    */  
    
    /**
     * @description
     */
    public Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>selectedObjFields {get;set;}
    
    //Describe information for the selected sobject
    
    /**
     * @description
     */
    public MergeRecordsUtil.DescribeResult describe{get;set;}
    
    //Move an object form the search list to the "merge table"
    
    /**
     * @description
     */
    public String selectMergeObjectId{get;set;}
    
    /**
     * @description
     */
    public Integer selectMergeObjectPosition{get;set;}
    
    //selected master object
    /**
     * @description 
     */
    public String masterObjectId{get;set;}
    
    /**
     * MergeSalesup
     * @description
     */
    public MergeSalesup()
    {
        initMergeSalesUps();
        //initMergeAccounts();
    }

    public void initMergeAccounts()
    {
        if(merginObjects.size()==0){
            System.debug('MergeSalesup: initMergeAccounts: No merge objects');
        }
        else{
            System.debug('MergeSalesup: initMergeAccounts: objects in merginObjects');

            List<String> accountIdList =  new List<String>();
            for(SObject s : merginObjects){
                dealer__Sales_Up__c sup = (dealer__Sales_Up__c)s;
                accountIdList.add(sup.Customer_Account__c);
            }

            soslFields = '';

            soslFields = 'Id, Name, LastName, FirstName, ParentId, Phone, OwnerId, PersonMailingStreet, PersonMailingCity, '
            +'PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, PersonMailingLatitude, PersonMailingLongitude, '
            +'PersonMobilePhone, PersonHomePhone, PersonOtherPhone, PersonAssistantPhone, PersonEmail, '
            +'PersonLeadSource';
            String acctSearchQuery='Select '+soslFields+' From  Account where ID in :accountIdLIst';
            this.foundRecordList=database.query(acctSearchQuery);

            selectMergeObject();
        }
    }

    /**
     * initMergeSalesUps 
     * @return void
     * @description
     */
    public void initMergeSalesUps()
    {
        this.describe = new MergeRecordsUtil.DescribeResult();
        sObjectType=System.currentPageReference().getParameters().get('Type');


        this.foundRecordList = new List<Sobject>();
        this.sobjectsSlctOpt = new List<SelectOption>();
        //this.uniqueFields = new Map<String,String>();
        this.merginObjects = new List<SObject>();
        //this.allFields = new Map<String,MergeRecordsUtil.Field>();
        this.selectedObjFields = new  Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>();
        
        //set ot store an ordered list of sobjects (by name)
        Set<String> objsOrderName = new Set<String>();
        
        //search for the "searchable" sobjects and stores the describes 
        Map<String,String> sobjNamesLabels = new Map<String,String>();
        for(Schema.Sobjecttype sot : Schema.getGlobalDescribe().values())
        {
            Schema.Describesobjectresult dr = sot.getDescribe();
            if(dr.isSearchable() && dr.isAccessible() && dr.isCustomSetting()==false  && dr.isDeprecatedAndHidden()==false
                && dr.isQueryable() && dr.isUpdateable() && dr.isDeletable())
            {
                sobjNamesLabels.put(dr.getName(), dr.getlabel());
                objsOrderName.add(dr.getName());
            }
        }
        
        System.assert(objsOrderName.size()>0,'No object found.');
        
        //creates a list to make it order its elements
        
        List<String> nameList = new List<String>(objsOrderName);
        nameList.sort();
        
        for(String name : nameList)
        {
            this.sobjectsSlctOpt.add(new SelectOption(name,sobjNamesLabels.get(name)));
        }
        searchRecords();
        selectMergeObject();
    }
    
    /**
     * initDescribe 
     * @return void
     * @description inits the describe information
     */
    public void initDescribe()
    {
        this.masterObjectId = null;
        this.foundRecordList = new List<Sobject>();
        this.selectedObjFields = new  Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>();
        this.merginObjects = new List<Sobject>();
            
        this.describe = MergeRecordsUtil.initDescribes(this.sObjectType);

        //fills with blank objects 
        for(Integer i = this.merginObjects.size(); i < getMaxRecordsCount(); i++)
        {
            this.merginObjects.add(this.describe.sOType.newsobject());
        }
            
            
        System.assert(this.merginObjects.size()==getMaxRecordsCount() ,'Initialization of mergeing object incorrect. Must be exactly '+getMaxRecordsCount()+' void objects');
    }
    
    /**
     * searchRecords 
     * @return void
     * @description
     */ 
    public void searchRecords()
    {
        /*if(this.searchText==null || this.searchText.trim().length()==0)
        { 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Search non void text.'));
            return;
        }
        
        System.assert(sObjectType!=null && sObjectType.length()>0,'Object Type should not be blank.');*/
        
        //if the sobject changes, need for refresh
        if(sObjectTypeOld != sObjectType)
        {
            sObjectTypeOld = this.sObjectType;
            initDescribe();
        }
        
        soslFields = '';
        if(this.describe.allFields.size()>0)
        {
            for(String s : this.describe.allFields.keySet()) soslFields+=s+',';
        }
        
        
        soslFields = soslFields.substring(0,soslFields.length()-1);
        
        
        try
        {
            String SalesUpIDs = System.currentPageReference().getParameters().get('pIDs');    
            List<String> SalesUpList =  new List<String>();
            SalesUpList = SalesUpIDs.split(':');
            //List<List<SObject>> res = search.query(searchquery); 
            //System.debug('Search query: '+res);
            //for(List<SObject> lst : res) this.foundRecordList = lst;
            String searchquery='Select '+soslFields+' From '+sObjectType +' where ID in :SalesUpList';
            this.foundRecordList=database.query(searchquery);
            foundSalesUpList = database.query(searchquery);
            if(this.foundRecordList.size()==0) ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'No record found.'));
            
        }
        catch(Exception e)
        {
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
    }
    
    /**
     * selectMergeObject 
     * @return void
     * @description Moves an object from the search list to the merging list
     */
    public void selectMergeObject()
    {
        integer counter = 0;
        for(SObject obj : this.foundRecordList)
        {
            this.selectMergeObjectId = (String)obj.get('ID');
            this.selectMergeObjectPosition = counter;
            //if((String)obj.get('ID') == this.selectMergeObjectId){
                String prevObjId = (String)this.merginObjects[this.selectMergeObjectPosition].get('Id');
                
                //if current position object is the master object, it is "deselected"
                if(prevObjId == this.masterObjectId) this.masterObjectId = null;
                
                //remove previous "field selection" informations
                if(prevObjId != null) this.selectedObjFields.remove(prevObjId);
                //previous object replaced by current selected object
                this.merginObjects[this.selectMergeObjectPosition] = obj;
                //init the map of "selected" fields
                Map<String, MergeRecordsUtil.InputHiddenValue> flist =  new Map<String,MergeRecordsUtil.InputHiddenValue>();
                selectedObjFields.put((ID)selectMergeObjectId, flist);
                for( MergeRecordsUtil.Field f : this.describe.allFields.values()){
                    flist.put(f.name,new MergeRecordsUtil.InputHiddenValue(f.name,false,f.isWritable));
                 }
                counter = counter+1;
                //break;
            //}
        }
    }
    
    /**
     * mergeSups 
     * @return PageReference
     * @description Merge records into one
     */
    public PageReference mergeSups()
    {
        //MKS1
        Map<Id, Id>soldUps = new Map<Id,Id>();

        for(dealer__Sales_Up__c su : foundSalesUpList){
            if(su.dealer__Lead_Status__c == 'Sold' && su.Id !=masterObjectId){
                soldUps.put(su.Id, su.Id);
            }
        }
        if(soldUps.size()>0){

            if(!soldUps.containsKey(masterObjectId)){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'The Sold record must be the Master record.'));
                return null;
            }
        }
        
        //end MKS1

        if(this.masterObjectId == null || this.masterObjectId.trim().length()==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select a master record.'));
            return null;
        }
        //select the master record and the slave ones      
        MergeRecordsUtil.SelectMasterResult smr = MergeRecordsUtil.mergeRecords(this.merginObjects, this.masterObjectId);

        if(smr.masterObject == null || smr.loserObjs.size()==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You need more than one record to merge.'));
            return null;
        }

        //copy slave fields into master
        MergeRecordsUtil.copyDataIntoMasterRecord(smr,this.selectedObjFields);
        Savepoint sp = Database.setSavepoint();
        try{
            List<String> slaveIds = new List<String>();
            for(SObject s : smr.loserObjs){
                slaveIds.add(s.id);
            }

            List<dealer__Desired_Vehicle__c> DVList = [select id,
                                                                dealer__Sales_Up__c from dealer__Desired_Vehicle__c where 
                                                                dealer__Sales_Up__c in: slaveIds];
            for(dealer__Desired_Vehicle__c d : DVList){
                d.dealer__Sales_Up__c = smr.masterObject.id;
            }
            update DVList;
            List<dealer__Sales_Appointment__c> SAList = [select id,
                                                                dealer__Sales_Up__c from dealer__Sales_Appointment__c where 
                                                                dealer__Sales_Up__c in: slaveIds];
            // get all tasks and events
            List<Task> supTasks = [SELECT ID from Task where whatId in: slaveIds];
            List<Event> supEvents = [SELECT ID from Event where whatId in: slaveIds];

            for(Task t : supTasks)
                t.whatId = smr.masterObject.id;

            for(Event e : supEvents)
                e.whatId = smr.masterObject.id;
            
            for(dealer__Sales_Appointment__c d : SAList){
                d.dealer__Sales_Up__c = smr.masterObject.id;
            }
            if((slaveIds.size() > 1)&&(smr.masterObject != null)&&(sObjectType == 'Contact')) {
                Contact slaveId1 = [Select id from Contact where Id = :slaveIds[0]];
                Contact slaveId2 = [Select id from Contact where Id = :slaveIds[1]];
                Contact masterId = [Select id from Contact where Id = :smr.masterObject.Id];
                merge slaveId1 slaveId2;
                merge masterId slaveId1;
                update smr.masterObject;
            }
            else if((slaveIds.size() == 1 )&&(smr.masterObject != null)&&(sObjectType == 'Contact')) {
                Contact slaveId1 = [Select id, MailingStreet from Contact where Id = :slaveIds[0]];
                Contact masterId = [Select id, MailingStreet from Contact where Id = :smr.masterObject.Id];
                merge masterId slaveId1;
                update smr.masterObject; 
            }
            else if((slaveIds.size() > 1)&&(smr.masterObject != null)&&(sObjectType == 'Account')) {
                Account slaveId1 = [Select id from Account where Id = :slaveIds[0]];
                Account slaveId2 = [Select id from Account where Id = :slaveIds[1]];
                Account masterId = [Select id from Account where Id = :smr.masterObject.Id];
                merge slaveId1 slaveId2;
                merge masterId slaveId1;
                update smr.masterObject;
            }
            else if((slaveIds.size() == 1 )&&(smr.masterObject != null)&&(sObjectType == 'Account')) {
                Account slaveId1 = [Select id from Account where Id = :slaveIds[0]];
                Account masterId = [Select id from Account where Id = :smr.masterObject.Id];
                merge masterId slaveId1;
                update smr.masterObject; 
            }
            else if((slaveIds.size() >= 1)&&(smr.masterObject != null)&&(sObjectType == 'Sales_up__c')) {
                update SAList;
                update supTasks;
                update supEvents;
                delete smr.loserObjs;
                update smr.masterObject;
                LMS.notifyUrbanScience('LeadMergedDealer', smr.masterObject.Id);
            }
            PageReference page = new PageReference('/'+smr.masterObject.Id);
            page.setRedirect(true);
            return page;
        }
        catch(DMLException e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getDMLMessage(0)));
        }
        catch(Exception e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An unexpected error occurred: '+e.getMessage()));
        }
        return null;
    }

    /**
     * mergeAccounts 
     * @return PageReference - A reference to the master object's page
     * @description merges two accounts
     */ 
    public PageReference mergeAccounts()
    {
        if(this.masterObjectId == null || this.masterObjectId.trim().length()==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Select a master record.'));
            return null;
        }
        //select the master record and the slave ones      
        MergeRecordsUtil.SelectMasterResult smr = MergeRecordsUtil.mergeRecords(this.merginObjects, this.masterObjectId);
        if(smr.masterObject == null || smr.loserObjs.size()==0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You need more than one record to merge.'));
            return null;
        }
        //copy slave fields into master
        MergeRecordsUtil.copyDataIntoMasterRecord(smr,this.selectedObjFields);
        Savepoint sp = Database.setSavepoint();
        try{
            List<String> slaveIds = new List<String>();
            for(SObject s : smr.loserObjs){
                slaveIds.add(s.id);
            }
            List<dealer__Desired_Vehicle__c> DVList = [select id,
                                                                dealer__Sales_Up__c from dealer__Desired_Vehicle__c where 
                                                                dealer__Sales_Up__c in: slaveIds];
            for(dealer__Desired_Vehicle__c d : DVList){
                d.dealer__Sales_Up__c = smr.masterObject.id;
            }
            update DVList;
            List<dealer__Sales_Appointment__c> SAList = [select id,
                                                                dealer__Sales_Up__c from dealer__Sales_Appointment__c where 
                                                                dealer__Sales_Up__c in: slaveIds];
            for(dealer__Sales_Appointment__c d : SAList){
                d.dealer__Sales_Up__c = smr.masterObject.id;
            }
            if((slaveIds.size() >= 1)&&(smr.masterObject != null)&&(sObjectType == 'Sales_up__c')) {
                update SAList;
                delete smr.loserObjs;
                update smr.masterObject;
                LMS.notifyUrbanScience('LeadMergedDealer', smr.masterObject.Id);
            }

            PageReference page = new PageReference('/'+smr.masterObject.Id);
            page.setRedirect(true);
            return page;
        }
        catch(DMLException e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getDMLMessage(0)));
        }
        catch(Exception e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An unexpected error occurred: '+e.getMessage()));
        }
        return null;   
    }
    
}