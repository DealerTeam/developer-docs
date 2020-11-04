@isTest
private class MergeSalesUp_TC {

    static testMethod void testUtils() {
        
        
        Sales_up__c SP=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP; 
        Sales_up__c SP1=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP1;
        Sales_up__c SP2=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP2;
        
        List<SObject> merginObjects = new List<SObject>();
        merginObjects.add(SP);
        merginObjects.add(SP1);
        merginObjects.add(Sp2);
        
        Map<String, MergeRecordsUtil.InputHiddenValue> flist =  null;
        Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>> selectedObjFields = new Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>();
        
        Test.startTest();
        System.currentPageReference().getParameters().put('Type','dealer__Sales_up__c');
        MergeRecordsUtil.InputHiddenValue ihv = new MergeRecordsUtil.InputHiddenValue(null,false,false);
        MergeRecordsUtil.SelectMasterResult smr = new MergeRecordsUtil.SelectMasterResult();
        MergeRecordsUtil.Field tmoF = new MergeRecordsUtil.Field(null,null,false);
        MergeRecordsUtil.DescribeResult describe = new MergeRecordsUtil.DescribeResult();
        
        describe = MergeRecordsUtil.initDescribes('dealer__Sales_Up__c');
        System.assert(describe.allFieldsKeySet.size()>0,'All fields set is null');
        System.assert(describe.uniqueFieldsKeySet!=null,'unique fields set is null');
        
        smr = MergeRecordsUtil.mergeRecords(merginObjects,SP.Id);
        
        //"select" the fields 
        flist =  new Map<String,MergeRecordsUtil.InputHiddenValue>();
        selectedObjFields.put(SP1.Id, flist);
        for( MergeRecordsUtil.Field f : describe.allFields.values()) flist.put(f.name,new MergeRecordsUtil.InputHiddenValue(f.name,true,f.isWritable));
        flist =  new Map<String,MergeRecordsUtil.InputHiddenValue>();
        selectedObjFields.put(SP.Id, flist);
        for( MergeRecordsUtil.Field f : describe.allFields.values()) flist.put(f.name,new MergeRecordsUtil.InputHiddenValue(f.name,false,f.isWritable));
        flist =  new Map<String,MergeRecordsUtil.InputHiddenValue>();
        selectedObjFields.put(SP2.Id, flist);
        for( MergeRecordsUtil.Field f : describe.allFields.values()) flist.put(f.name,new MergeRecordsUtil.InputHiddenValue(f.name,false,f.isWritable));
        
        MergeRecordsUtil.copyDataIntoMasterRecord(smr, selectedObjFields);
        
        
        
        Test.stopTest();
    }
    
     static testMethod void testController1() {
        
        Sales_up__c SP=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP; 
        Sales_up__c SP1=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP1;
        Sales_up__c SP2=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
        insert SP2;
        System.currentPageReference().getParameters().put('pIDs',SP.ID+':'+SP1.ID+':'+SP2.ID);
        System.currentPageReference().getParameters().put('Type','dealer__Sales_up__c');
        List<SObject> merginObjects = new List<SObject>();
        merginObjects.add(Sp);
        merginObjects.add(SP1);
        merginObjects.add(Sp2);
        
        Map<String, MergeRecordsUtil.InputHiddenValue> flist =  null;
        Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>> selectedObjFields = new Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>();
        
        Test.startTest();
        
        MergeSalesup controller = new MergeSalesup();
        System.assert(controller.sobjectsSlctOpt.size()>0,'No SObject found');
        //controller.initMergeAccounts();
        controller.sObjectType = 'dealer__Sales_UP__c';
        System.assert(controller.describe.allFields.size()>0,'No Field found for Account SObject');
        //controller.initMergeAccounts();
        controller.searchText = null;
        controller.searchRecords(); //no search text
        
        
        // SOSL queries do not return any record in test methods
        Id [] fixedSearchResults= new Id[3];
        fixedSearchResults[0] = SP.Id;
        fixedSearchResults[1] = Sp1.Id;
        fixedSearchResults[2] = SP2.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        
        controller.searchText = 'test';
        controller.searchRecords();
        System.assert(controller.foundRecordList.size()==MergeRecordsUtil.MERGED_RECORDS_COUNT,'Missing or exceding search result list items ['+controller.foundRecordList.size()+']');
        
        controller.selectMergeObjectId = null;
        controller.selectMergeObject();    //no object selected
        
        //acc1 -> position 0
        controller.selectMergeObjectId = SP.Id;
        controller.selectMergeObjectPosition = 0;
        controller.selectMergeObject();
        //acc2 -> position 2
        controller.selectMergeObjectId = SP1.Id;
        controller.selectMergeObjectPosition = 1;
        controller.selectMergeObject();
        //acc3 -> position 2 (override acc2)
        controller.selectMergeObjectId = SP2.Id;
        controller.selectMergeObjectPosition = 2;
        controller.selectMergeObject();
        //acc2 -> position 1 (moves acc2)
        controller.selectMergeObjectId = SP1.Id;
        controller.selectMergeObjectPosition = 1;
        controller.selectMergeObject();
        
        controller.mergeSups();  //no master object selected
        
        controller.masterObjectId = SP1.Id;
        controller.mergeSups();  //no master object selected (id is incorrect, so only loosers object are found)
        
        controller.masterObjectId = Sp.Id;
        
        
        dealer__Desired_Vehicle__c dealerServiceVehicle = new dealer__Desired_Vehicle__c();
        dealerServiceVehicle.dealer__Sales_Up__c = SP1.Id;
        insert dealerServiceVehicle;
        
        controller.mergeSups();
        //select a field of a looser object
        /*controller.selectedObjFields.get(SP.Id).get('DEALER__FIRSTNAME__C').isChecked = true;
        SP.Name = null; //triggers a DML exception
        controller.mergeSups();  //DML exception (acc1 has no name)
        
        SP.Name = 'TESTACCOUNT1';
        controller.mergeSups();*/
        
        Test.stopTest();
    }

    static testMethod void testController2() {
            
            TestClassUtil tu = new TestClassUtil();

            Sales_up__c SP=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
            insert SP; 
            Sales_up__c SP1=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test');
            insert SP1;
            Sales_up__c SP2=new Sales_up__c(DEALER__FIRSTNAME__C='Test',DEALER__LASTNAME__C='test', Customer_Account__c = tu.insertAccount());
            insert SP2;
            System.currentPageReference().getParameters().put('pIDs',SP.ID+':'+SP1.ID+':'+SP2.ID);
            System.currentPageReference().getParameters().put('Type','dealer__Sales_up__c');
            List<SObject> merginObjects = new List<SObject>();
            merginObjects.add(Sp);
            merginObjects.add(SP1);
            merginObjects.add(Sp2);
            
            Map<String, MergeRecordsUtil.InputHiddenValue> flist =  null;
            Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>> selectedObjFields = new Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>();
            
            Test.startTest();
            
            MergeSalesup controller = new MergeSalesup();
            System.assert(controller.sobjectsSlctOpt.size()>0,'No SObject found');
            controller.initMergeAccounts();
            controller.sObjectType = 'dealer__Sales_UP__c';
            System.assert(controller.describe.allFields.size()>0,'No Field found for Account SObject');
            controller.mergeAccounts(); // for null check and exception
            controller.masterObjectId = SP2.Id;
            controller.mergeAccounts();
        Test.stopTest();
    }
}