global with sharing class DMSSyncBulkLoadBatch implements Database.Batchable<String> {

    List<String> dataHeader;
    List<String> dataRows;
    String businessType;
    String personType;
    String dataType;

    global DMSSyncBulkLoadBatch(List<String> csvData, String fileType){
         this.dataHeader = csvData[0].split(',');
         this.dataType = fileType;
         csvData.remove(0);
         this.dataRows = csvData;
        this.businessType = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND isPersonType = false LIMIT 1].Id;
        this.personType = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND isPersonType = true LIMIT 1].Id;
    }
    public Iterable<String> start(Database.BatchableContext BC)
    {
        return dataRows;
    }
 
    public void execute(Database.BatchableContext info, List<String> strings) {
        
        List<Account> accList = new List<Account>();
        List<dealer__Service_Vehicle__c> vehList = new List<dealer__Service_Vehicle__c>();
        boolean readSuccess;
        List<String> lstFieldNames = new List<String>();
        Account b2bAcc = new Account();
        Account b2cAcc = new Account();
        dealer__Service_Vehicle__c vehicle = new dealer__Service_Vehicle__c();
        String fieldValue;
        Integer fieldNumber;
        Map < String, Integer > fieldNumberMap = new Map < String, Integer > ();
        //system.debug(dataRows);
        for (Integer i = 0; i < dataHeader.size(); i++) {
            fieldNumberMap.put(dataHeader[i], i);
            lstFieldNames.add(dataHeader[i].trim());

        }
        for (Integer i = 0; i < strings.size(); i++) {
            string[] csvRecordData = strings[i].split(',');
            if(!csvRecordData.isEmpty() && csvRecordData[0] != ''){

                //Do data load for Accounts
                if(dataType.contains('Account')){

                    b2bAcc = new Account(recordTypeId = businessType);
                    b2cAcc = new Account(recordTypeId = personType);
                    for (String fieldName: dataHeader) {
                        fieldNumber = fieldNumberMap.get(fieldName);
                        fieldValue = csvRecordData[fieldNumber];
                        
                        //Transfer select data to account objects
                        if(fieldName == '"BusinessName"' && fieldValue != '"NULL"' && fieldValue !='" "'){
                            fieldValue = fieldValue.replace('"', '');
                            b2bAcc.Name = fieldValue.trim();
                        }
                        if(fieldName =='"Email"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            String emailPattern = fieldValue;
                            String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
                            Pattern MyPattern = Pattern.compile(emailRegex);
                            Matcher MyMatcher = MyPattern.matcher(fieldValue);
                            if(MyMatcher.matches()){
                                b2bAcc.dealer__Billing_Email__c = fieldValue.trim();
                                b2cAcc.PersonEmail = fieldValue.trim();
                            }                        
                        } 
                        if(fieldName == '"FirstName"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            b2cAcc.FirstName = fieldValue.trim();
                        }
                        if(fieldName == '"LastName"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            b2cAcc.LastName = fieldValue.trim();
                        }
                        if(fieldName == '"CustID"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            b2cAcc.External_ID__c = fieldValue.trim();
                        }
                    }
                    system.debug(b2cAcc);
                    system.debug(b2bAcc);
                    //add business accounts
                    if(b2bAcc.Name != '' && b2bAcc.Name != null){
                        // accObj.Name = null;
                        accList.add(b2bAcc); 
                    } 
                    //add person accounts
                    else if(b2cAcc.LastName != '' && b2cAcc.LastName != null){
                        accList.add(b2cAcc);
                    }
                }

                //Do data load for Vehicles
                if(dataType.contains('Vehicle')){
                    
                    vehicle = new dealer__Service_Vehicle__c();
                    for (String fieldName: dataHeader) {
                        fieldNumber = fieldNumberMap.get(fieldName);
                        fieldValue = csvRecordData[fieldNumber];
                        system.debug(fieldName);
                        //Transfer select data to account objects
                        if(fieldName == '"Year"' && fieldValue != '"NULL"' && fieldValue !='" "' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            vehicle.dealer__Year__c = fieldValue.trim();
                        }
                        if(fieldName =='"Make"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            vehicle.dealer__Make__c = fieldValue.trim();
                                                   
                        } 
                        if(fieldName =='"Model"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            vehicle.dealer__Carline__c = fieldValue.trim();
                        }
                        if(fieldName =='"VIN"' && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            vehicle.dealer__VIN__c = fieldValue.trim();
                        }
                        if(fieldName.contains('CustID') && fieldValue !='""' && fieldValue != '"NULL"' && fieldValue != ''){
                            fieldValue = fieldValue.replace('"', '');
                            vehicle.dealer__Customer_Key__c = fieldValue.trim();
                            system.debug(vehicle);
                        } 
                    }
                    system.debug(vehicle);
                    //add business accounts
                    if(vehicle.dealer__Year__c != null && vehicle.dealer__Make__c != null && vehicle.dealer__Carline__C != null){
                        vehList.add(vehicle); 
                    } 
                }
            }
             
        } 
        //Insert any accounts
        if(accList.size() > 0){
            readSuccess = TRUE;
            try{
                system.debug('inserting ' + accList.size() + ' Account records.');
                Database.SaveResult[] result = Database.Insert(accList, false);
            } catch(Exception e){
                system.debug('error inserting Accounts: ' + e.getMessage());
            }
        }


        //Insert any vehicles
        if(vehList.size() > 0){
            readSuccess = TRUE;
            try{
                system.debug('inserting ' + vehList.size() + ' Service Vehicle records.');
                Database.SaveResult[] result = Database.Insert(vehList, false);
            } catch(Exception e){
                system.debug('error inserting Service Vehicles: ' + e.getMessage());
            }
        }
    }
 
    public void finish(Database.BatchableContext info) { }
}