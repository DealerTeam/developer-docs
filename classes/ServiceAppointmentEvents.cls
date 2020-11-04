public with sharing class ServiceAppointmentEvents {

    public User uid {get;set;}

    public Date startDate {get;set;}
    public Date endDate {get;set;}
    public Date qDate {get;set;}
    public String action {get;set;}
    public String customerId {get;set;}
    public String selectedLocation {get;set;}
    public String validLocations {get;set;}
    public String crudResponse {get;set;}
    public Map<String, String> urlParameters = new Map<String, String>();
    public List<dealer__Service_Appointment__c> sa = new List<dealer__Service_Appointment__c>();
    public List<dealer__Service_Repair_Order__c> ros = new List<dealer__Service_Repair_Order__c>();
    
    public ServiceAppointmentEvents() {
        startDate=Date.Today();
        endDate=Date.Today();
        customerId = null;
        uid = [Select Id, Division from User Where Id = :UserInfo.getUserId() limit 1];
        urlParameters = ApexPages.currentPage().getParameters();
        validLocations='';

        // If start or end _GET vars are populated use instead
        if(ApexPages.currentPage().getParameters().get('start')!='' 
            && ApexPages.currentPage().getParameters().get('start')!=null
            && ApexPages.currentPage().getParameters().get('end')!=''
            && ApexPages.currentPage().getParameters().get('end')!=null
            && ApexPages.currentPage().getParameters().get('action')!='update_apt'
            && ApexPages.currentPage().getParameters().get('action')!='create_apt') {
                
                
                // Convert time stamp to now
                Long sT         =   Long.valueOf(ApexPages.currentPage().getParameters().get('start'));
                Long eT         =   Long.valueOf(ApexPages.currentPage().getParameters().get('end'));
                Datetime dts    =   Datetime.newInstance(sT);
                Datetime dte    =   Datetime.newInstance(eT);
                /*
                Integer startInt    =   Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
                Integer endInt      =   Integer.valueOf(ApexPages.currentPage().getParameters().get('end'));
                dts                 =   dts.addSeconds(startInt);
                dte                 =   dte.addSeconds(endInt);
                System.debug('IntValue'+Integer.valueOf(ApexPages.currentPage().getParameters().get('start'))+' '+dts);
                */
                
                startDate=Date.newInstance(dts.year(), dts.month(), dts.day());
                endDate=Date.newInstance(dte.year(), dte.month(), dte.day());
            }
            
            if(ApexPages.currentPage().getParameters().get('Id') != '' && ApexPages.currentPage().getParameters().get('Id') !=null) {
                dealer__Service_Appointment__c sa = [select Id, dealer__Date_Time__c 
                                                        from dealer__Service_Appointment__c 
                                                        where Id =:ApexPages.currentPage().getParameters().get('Id') limit 1];
                Date dt = Date.newInstance(sa.dealer__Date_Time__c.year(), sa.dealer__Date_Time__c.month(), sa.dealer__Date_Time__c.day());
                startDate = dt;
                endDate = dt;
            }    

            //System.debug(ApexPages.currentPage().getParameters().get('custid'));
            if(ApexPages.currentPage().getParameters().get('custid')!=null) {
                customerId = ApexPages.currentPage().getParameters().get('custid');
            }

            if(ApexPages.currentPage().getParameters().get('action')!=''&&ApexPages.currentPage().getParameters().get('action')!=null) {
                action = ApexPages.currentPage().getParameters().get('action');

                /*
                if(action=='create_apt') {
                    urlParameters = ApexPages.currentPage().getParameters();
                    // Build Create Object
                }

                if(action=='update_apt') {
                    urlParameters = ApexPages.currentPage().getParameters();
                }

                if(action=='read_customers' && customerId==null) {
                    urlParameters = ApexPages.currentPage().getParameters();
                }
                */
            }
        if(ApexPages.currentPage().getParameters().get('location')!=null) {
                selectedLocation = ApexPages.currentPage().getParameters().get('location');
            System.debug('selectedLocation from get: ' + selectedLocation);
        }
    }


    /*---------------------------------------------------
    |
    |   Setter Methods
    |
    \*--------------------------------------------------*/  

    public PageReference saveAppointment() {
        // CRUD Actions
        if(action=='update_apt') {
            crudResponse = updateAppointmentLogic();
        }
        if(action=='create_apt') {
            crudResponse = createAppointmentLogic();
        }
        if(action=='destroy_apt') {
            crudResponse = deleteAppointment();
        }
        return null;
    }

    /*---------------------------------------------------
    |
    |   General Logic Methods
    |
    \*--------------------------------------------------*/
    public String createAppointmentLogic() {
        System.debug('Create Appointment Method');
        System.debug(urlParameters);
        // Get FixedOperations Settings for Reference
        dealer__FixedOperationsSettings__c fixed_operation_settings = dealer__FixedOperationsSettings__c.getOrgDefaults();

        //W-002108 Begins**
        // Added logic to allow appointment to be set without customer id if color is set to training value.
        // Check for required attributes
        if((String.valueOf(urlParameters.get('custId'))=='') && (String.valueOf(urlParameters.get('color')) != '#d9534f')) { return '{"error" : {"type": "Customer Blank", "message":"Create Appointment required field custId is blank" } }'; }
        // W-002108 Ends**

        // Commented 5-29-2015
        //if(String.valueOf(urlParameters.get('vehId'))=='') { return '{"error" : {"type": "Customer Blank", "message":"Create Appointment required field Vehicle is blank" } }'; }

        if(String.valueOf(urlParameters.get('AdvisorId'))=='') { return '{"error" : {"type": "Customer Blank", "message":"Create Appointment required field Advisor is blank" } }'; }
        
        // Instantiate Appointment Object
        dealer__Service_Appointment__c sa = new dealer__Service_Appointment__c();

        String vehId = String.valueOf(urlParameters.get('vehId'));
        if ( vehId != '' && vehId != null ) {
            sa.dealer__Vehicle__c = vehId;
        }
        //W-002108 Begins**
        String cId  =   String.valueOf(urlParameters.get('custId'));
        if (cId != '' && cId != null){
            sa.dealer__Customer__c = cId;
        }
        //W-002108 Ends**
        sa.dealer__SA__c  =  String.valueOf(urlParameters.get('AdvisorId'));

        //#T-00868: begins
        if(urlParameters.get('start')!='' && urlParameters.get('start')!=null){
            sa.dealer__Date_Time__c  =  DateTime.newInstance(Long.valueOf(urlParameters.get('start')));
        }        
        
        if(urlParameters.get('vehOdometer')!=null && urlParameters.get('vehOdometer')!=''){
            sa.dealer__Mileage__c = Decimal.valueOf(urlParameters.get('vehOdometer'));
        }    
        //#T-00868: ends    

        // Location aware appointment
        System.debug('Selected Location: ' + selectedLocation);
        System.debug('Selected Location url: ' + String.valueOf(urlParameters.get('location')) );
        System.debug(' companynumber : ' + String.valueOf(urlParameters.get('companyNumber')) );

        if(urlParameters.get('location') != null){
            sa.dealer__Company__c  =  String.valueOf(urlParameters.get('location'));
        }
        if(urlParameters.get('companyNumber') != null){
            sa.dealer__Company_Number__c  =  String.valueOf(urlParameters.get('companyNumber'));
        }

        // Get Account from Contact
        //if(sa.dealer__Customer_Contact__c!=null) {
        //    Contact c = [Select Id, AccountId from Contact where Id=:sa.dealer__Customer_Contact__c limit 1];
        //    sa.dealer__Customer__c = c.AccountId;
        //}

        // Supplimental Fields
        sa.dealer__Durration__c     =   dealer.Utility.timeDistance_Minutes(Long.valueOf(urlParameters.get('start')), Long.valueOf(urlParameters.get('end')));
        
        if(String.valueOf(urlParameters.get('color'))!='' && String.valueOf(urlParameters.get('color'))!=null) {
            sa.dealer__Color_Code__c    =   String.valueOf(urlParameters.get('color'));
        } else {
            sa.dealer__Color_Code__c    =   '#80c17f'; // Move to trigger (have trigger pick default value of color code)
        }

        // For testing Failure.
         //return '{"error" : {"type": "DML Exception", "message":"Error Message..." } }';

        try {
            System.debug('Create this appointment: ' + sa);
            insert sa;
        } catch(DmlException e) {
                String msg = '';
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    msg += e.getDmlMessage(i) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(i)); 
                }
                return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
        }
        
        // Generate Appointment Lines
        List<dealer__Service_Appointment_Line__c> sLines = new List<dealer__Service_Appointment_Line__c>();
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        for (Integer i : myInts) {     
            // Insert Service Appointment Lines
            if(urlParameters.get('lines['+i+'][serviceOperationCode]')!=null) {
                dealer__Service_Appointment_Line__c sLine = new dealer__Service_Appointment_Line__c();
                sLine.dealer__Service_Appointment__c = sa.Id;
                sLine.dealer__CustomerConcern__c = String.valueOf(urlParameters.get('lines['+i+'][concern]'));

                // #T-00823: begins
                string standardOpCodeId = urlParameters.get('lines['+i+'][serviceOperationCodeId]').trim();
                //check if the parameter value is a valid dealer__StandardOpCode__c sobject id
                if(standardOpCodeId.startsWith(dealer__StandardOpCode__c.sobjecttype.getDescribe().getKeyPrefix()) ) {
                    sLine.dealer__Standard_Op_Code__c  = standardOpCodeId;
                } 
                // #T-00823: ends
                sLine.Name = String.valueOf(urlParameters.get('lines['+i+'][serviceOperationCode]'));

                /* sLine.dealer__Line_Key__c = String.valueOf(urlParameters.get('lines['+i+'][lineKey]')); */

                sLine.dealer__Line__c = i;
                sLine.dealer__Pay_Type__c = String.valueOf(urlParameters.get('lines['+i+'][payment_method]'));
                if(String.valueOf(urlParameters.get('lines['+i+'][estimate]'))!=''&&String.valueOf(urlParameters.get('lines['+i+'][estimate]'))!=null) {
                    sLine.dealer__Qoute__c  = Decimal.valueOf(urlParameters.get('lines['+i+'][estimate]'));
                } else {
                   sLine.dealer__Qoute__c = 0; 
                }

                //T-00881 - Blank check for time estimate
                if(urlParameters.get('lines['+i+'][time]')!='' && String.valueOf(urlParameters.get('lines['+i+'][time]'))!=null) {
                    sLine.dealer__Time_Estimate__c = Decimal.valueOf(urlParameters.get('lines['+i+'][time]'));
                } else {
                    sLine.dealer__Time_Estimate__c = 0;
                }
                sLines.add(sLine);
            }
        }

        // Check line size, if we have lines commit to database
        if(sLines.size()>0) {
            try {
                insert sLines;
            } catch(DmlException e) {
                String msg = '';
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    msg += e.getDmlMessage(i) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(i)); 
                }
                return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
            }
        }

        // Select data from database and get updated columns from Trigger
        sa = [Select Id, Name, dealer__Company_Number__c, dealer__SA__c, dealer__Vehicle__c, dealer__Color_Code__c, dealer__Durration__c,dealer__Company__c, dealer__Customer_Contact__r.Name, dealer__Customer__c, dealer__Customer__r.Name
                    FROM dealer__Service_Appointment__c 
                    WHERE Id=:sa.Id 
                    LIMIT 1];

        List<dealer__Service_Appointment_Line__c> linesOut = [SELECT Id, Name, dealer__CustomerConcern__c, dealer__Pay_Type__c, dealer__Qoute__c, dealer__Time_Estimate__c, dealer__Standard_Op_Code__c, dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c, dealer__Line_Key__c FROM dealer__Service_Appointment_Line__c WHERE dealer__Service_Appointment__c =: sa.Id LIMIT 10];

        // Generate Response
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
            // Appointment Header Data
            gen.writeStartObject();
                gen.writeStringField('type', 'APT');
                gen.writeStringField('RecordId', sa.Id);
                gen.writeStringField('AdvisorId', sa.dealer__SA__c);
                //gen.writeStringField('custId', sa.dealer__Customer_Contact__c);

                if(sa.dealer__Customer__c != null){
                    gen.writeStringField('custId', sa.dealer__Customer__c);
                    gen.writeStringField('Name', sa.dealer__Customer__r.Name);
                }
                //gen.writeStringField('Name', sa.Name);

                if(sa.dealer__Vehicle__c != null){
                    gen.writeStringField('vehId', sa.dealer__Vehicle__c);                            
                }

                if(sa.dealer__Company__c != null){
                    gen.writeStringField('Location', sa.dealer__Company__c);
                }
                gen.writeStringField('companynumber', sa.dealer__Company_Number__c);  // Could be NULL Value if the User has not selected a company.


                gen.writeStringField('title', sa.Name);
                gen.writeStringField('start', '/Date('+String.valueOf(urlParameters.get('start'))+')/');
                gen.writeStringField('end', '/Date('+String.valueOf(urlParameters.get('end'))+')/');
                gen.writeStringField('allDay', 'false');
                gen.writeStringField('url', '/'+sa.Id);
                gen.writeStringField('color', sa.dealer__Color_Code__c); 
                if(sa.dealer__Durration__c==null) {sa.dealer__Durration__c=20;}
                gen.writeNumberField('durration', sa.dealer__Durration__c);
                gen.writeNullField('StartTimezone');
                gen.writeNullField('EndTimezone');
                gen.writeNullField('RecurrenceRule');
                gen.writeNullField('RecurrenceID');
                gen.writeNullField('RecurrenceException'); 

                // Generate Line Items
                gen.writeFieldName('lines');
                gen.writeStartArray();                
                for(dealer__Service_Appointment_Line__c sl : linesOut) {
                    gen.writeStartObject();
                        gen.writeStringField('serviceOperationCode', sl.Name);

                        if(sl.dealer__Standard_Op_Code__c!=null) {
                            gen.writeStringField('serviceOperationCodeId', sl.dealer__Standard_Op_Code__c);
                        }
                    
                        if(sl.dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c != null){
                           gen.writeStringField('opCodeDescription', sl.dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c);

                        }
                        //System.debug(sl);
                        /*
                        if(sl.dealer__Line_Key__c != null) {
                            gen.writeStringField('lineKey', sl.dealer__Line_Key__c);
                        }
                        */

                        if(sl.dealer__CustomerConcern__c != null) {
                            gen.writeStringField('concern', sl.dealer__CustomerConcern__c);
                        } else {
                            gen.writeNullField('concern');
                        }
                        if(sl.dealer__Pay_Type__c != null) {
                            gen.writeStringField('payment_method', sl.dealer__Pay_Type__c);
                        }
                        if(sl.dealer__Qoute__c==null) { sl.dealer__Qoute__c = 0; }
                        gen.writeNumberField('estimate', sl.dealer__Qoute__c);
                        if(sl.dealer__Time_Estimate__c==null) { sl.dealer__Time_Estimate__c=0; }
                        gen.writeNumberField('time', sl.dealer__Time_Estimate__c);
                    gen.writeEndObject();    
                }
                gen.writeEndArray();                                          
            gen.writeEndObject();
        gen.writeEndArray();
        return gen.getAsString();                
    }

    public String updateAppointmentLogic() {

        // Validate the inputs
        String locationId = String.valueOf(urlParameters.get('location'));
        String vehicleId = String.valueOf(urlParameters.get('vehId'));

        if(locationId==null || locationId=='')
           return '{"error" : {"type": "Exception", "message":"Location ID must be provided to update an appointment." } }';

        if((String.valueOf(urlParameters.get('custId'))=='') && (String.valueOf(urlParameters.get('color')) != '#d9534f')) {
             return '{"error" : {"type": "Customer Blank", "message":"Create Appointment required field custId is blank" } }'; }

        // Get the associated location
        Dealer_Location__c location = [SELECT Id, Company_Number__c FROM Dealer_Location__c WHERE Id=:locationId LIMIT 1];

        dealer__Service_Appointment__c sa = new dealer__Service_Appointment__c();
        List<dealer__Service_Appointment__c> listServiceAppt = [Select Id, Name, dealer__Customer__c, dealer__Customer__r.Name from dealer__Service_Appointment__c where Id=:String.valueOf(urlParameters.get('RecordId')) limit 1];
        
        if(listServiceAppt!=null && listServiceAppt.size()>0){
            sa = listServiceAppt[0];
        }
        String cId = String.valueOf(urlParameters.get('custId'));
        Account c = new Account();
        if(cId != null && cId != ''){
        c = [select Id, Name, FirstName, LastName from Account where Id=:String.valueOf(urlParameters.get('custId')) limit 1];
        sa.dealer__Customer__c = c.Id;
        }
        User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];

        if ( urlParameters.get('vehId') != '' ) {
            sa.dealer__Vehicle__c = String.valueOf(urlParameters.get('vehId'));
        } else {
            sa.dealer__Vehicle__c = null;
        }

        if(urlParameters.get('vehOdometer') != null && urlParameters.get('vehOdometer') != '') {
            if( Decimal.valueOf(urlParameters.get('vehOdometer')) != null ){
                sa.dealer__Mileage__c = Decimal.valueOf(urlParameters.get('vehOdometer'));
            }
        }
        sa.dealer__SA__c = String.valueOf(urlParameters.get('AdvisorId'));
        sa.dealer__Company__c = location.Id;
        sa.dealer__Company_Number__c = location.Company_Number__c;
        sa.dealer__Color_Code__c = String.valueOf(urlParameters.get('color'));
        sa.dealer__Date_Time__c = DateTime.newInstance(Long.valueOf(urlParameters.get('start')));

        // Capture Distance
        sa.dealer__Durration__c =   dealer.Utility.timeDistance_Minutes(Long.valueOf(urlParameters.get('start')), Long.valueOf(urlParameters.get('end')));

        try {
            update sa;
        } catch(DmlException e) {
                String msg = '';
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    msg += e.getDmlMessage(i) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(i)); 
                }
                return '{"error" : {"type": "Exception", "message":"'+msg+'" } }';  
        }

        // New Lines
        List<dealer__Service_Appointment_Line__c> sLines = new List<dealer__Service_Appointment_Line__c>();
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        for (Integer i : myInts) {     

            // Insert Service Appointment Lines
            if(urlParameters.get('lines['+i+'][serviceOperationCode]')!=null) {

                dealer__Service_Appointment_Line__c sLine = new dealer__Service_Appointment_Line__c();

                /*
                if ( !Utility.isBlank( urlParameters.get('lines['+i+'][lineKey]') ) ) {
                    sLine.dealer__Line_Key__c = String.valueOf(urlParameters.get('lines['+i+'][lineKey]'));
                } else {
                    sLine.dealer__Line_Key__c = null;
                }
                */

                if(urlParameters.get('lines['+i+'][Id]')!='') {
                    sLine.Id=urlParameters.get('lines['+i+'][Id]');
                } else {
                    sLine.dealer__Service_Appointment__c = sa.Id;
                }               

                sLine.dealer__CustomerConcern__c = String.valueOf(urlParameters.get('lines['+i+'][concern]'));
                
                // #T-00823: begins
                string standardOpCodeId = urlParameters.get('lines['+i+'][serviceOperationCodeId]').trim();
                //check if the parameter value is a valid dealer__StandardOpCode__c sobject id
                if(standardOpCodeId.startsWith(dealer__StandardOpCode__c.sobjecttype.getDescribe().getKeyPrefix() ) ) {
                    sLine.dealer__Standard_Op_Code__c  = standardOpCodeId;
                }
                // #T-00823: ends

                sLine.Name = String.valueOf(urlParameters.get('lines['+i+'][serviceOperationCode]'));
                sLine.dealer__Op_Code_Name__c = String.valueOf(urlParameters.get('lines['+i+'][serviceOperationCode]'));
                sLine.dealer__Line__c = i;
                sLine.dealer__Pay_Type__c = String.valueOf(urlParameters.get('lines['+i+'][payment_method]'));
                if(String.valueOf(urlParameters.get('lines['+i+'][estimate]'))!=''&&String.valueOf(urlParameters.get('lines['+i+'][estimate]'))!=null) {
                    sLine.dealer__Qoute__c  = Decimal.valueOf(urlParameters.get('lines['+i+'][estimate]'));
                } else {
                   sLine.dealer__Qoute__c = 0; 
                }

                //T-00881 - Blank check for time estimate
                if(urlParameters.get('lines['+i+'][time]')!='' && String.valueOf(urlParameters.get('lines['+i+'][time]'))!=null) {
                    sLine.dealer__Time_Estimate__c = Decimal.valueOf(urlParameters.get('lines['+i+'][time]'));
                } else {
                    sLine.dealer__Time_Estimate__c = 0;
                }

                sLines.add(sLine);
            }
        }

        // Check line size, if we have lines commit to database
        if(sLines.size()>0) {

            System.debug(sLines);

            List<Service_Appointment_Line__c> updateLines = new List<Service_Appointment_Line__c>();
            List<Service_Appointment_Line__c> insertLines = new List<Service_Appointment_Line__c>();

            for(Service_Appointment_Line__c sal : sLines) {
                if(sal.Id!=null) {
                    updateLines.add(sal);
                } else {
                    insertLines.add(sal);
                }
            }

            try {

                if(!updateLines.isEmpty()) {
                    update updateLines;
                }

                if(!insertLines.isEmpty()) {
                    insert insertLines;
                }

            } catch(DmlException e) {
                String msg = '';
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    msg += e.getDmlMessage(i) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(i)); 
                }
                return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
            }
        }

        List<dealer__Service_Appointment_Line__c> linesOut = [SELECT Id, Name, dealer__CustomerConcern__c, dealer__Pay_Type__c, dealer__Qoute__c, dealer__Time_Estimate__c, dealer__Standard_Op_Code__c, dealer__Line_Key__c, dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c FROM dealer__Service_Appointment_Line__c WHERE dealer__Service_Appointment__c =: sa.Id LIMIT 10];
 

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();

            gen.writeStartObject();
            // Build Event
            gen.writeStringField('RecordId', sa.Id);
            gen.writeStringField('type', 'APT');

            gen.writeStringField('AdvisorId', sa.dealer__SA__c);
            gen.writeStringField('companynumber', sa.dealer__Company_Number__c);
            gen.writeStringField('title', sa.Name);


            if(sa.dealer__Customer__c != null){
                gen.writeStringField('Name', sa.dealer__Customer__r.Name);
                gen.writeStringField('custId', sa.dealer__Customer__c);
            } else if(sa.dealer__Customer_Contact__c!=null) {
                gen.writeStringField('custId', sa.dealer__Customer_Contact__c);
                gen.writeStringField('Name', c.Name);
            } else {
                gen.writeNullField('custId');
                gen.writeNullField('Name');
            }
            //gen.writeStringField('Name', sa.Name);
            //gen.writeStringField('custId', sa.dealer__Customer_Contact__c);
            //gen.writeStringField('Name', sa.dealer__Customer_Contact__r.Name);


            if(sa.dealer__Vehicle__c!=null) {
                gen.writeStringField('vehId', sa.dealer__Vehicle__c);
            } else {
                gen.writeNullField('vehId');
            }

            if(sa.dealer__Mileage__c!=null) {
                gen.writeNumberField('vehOdometer', sa.dealer__Mileage__c);
            } else {
                gen.writeNullField('vehOdometer');
            }

            gen.writeStringField('start', '/Date('+String.valueOf(urlParameters.get('start'))+')/');
            gen.writeStringField('end', '/Date('+String.valueOf(urlParameters.get('end'))+')/');
            gen.writeStringField('allDay', 'false');
            gen.writeStringField('url', '/'+sa.Id);
            gen.writeStringField('color', sa.dealer__Color_Code__c);
            //gen.writeStringField('startDate', String str);
            //gen.writeStringField('endDate', String str);
            if(sa.dealer__Durration__c==null) { sa.dealer__Durration__c=20; }
            gen.writeNumberField('durration', sa.dealer__Durration__c);
            gen.writeNullField('StartTimezone');
            gen.writeNullField('EndTimezone');
            gen.writeNullField('RecurrenceRule');
            gen.writeNullField('RecurrenceID');
            gen.writeNullField('RecurrenceException');

            // Lines
            gen.writeFieldName('lines');
            gen.writeStartArray();              
            for(dealer__Service_Appointment_Line__c sl : linesOut) {
                gen.writeStartObject();
                    gen.writeStringField('serviceOperationCode', sl.Name);
                    if(sl.dealer__Standard_Op_Code__c!=null) {
                        gen.writeStringField('serviceOperationCodeId', sl.dealer__Standard_Op_Code__c);
                    }
                
                 	if(sl.dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c != null){
                        gen.writeStringField('opCodeDescription', sl.dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c);

                    }

                    /*
                    if(sl.dealer__Line_Key__c!=null) {
                        gen.writeStringField('lineKey', sl.dealer__Line_Key__c);
                    }
                    */

                    if(sl.dealer__Pay_Type__c!=null) {
                        gen.writeStringField('payment_method', sl.dealer__Pay_Type__c);
                    }
                    if(sl.dealer__CustomerConcern__c!=null) {
                        gen.writeStringField('concern', sl.dealer__CustomerConcern__c);
                    }
                    if(sl.dealer__Qoute__c!=null) {
                        gen.writeNumberField('estimate', sl.dealer__Qoute__c);
                    }
                    if(sl.dealer__Time_Estimate__c!=null) {
                        gen.writeNumberField('time', sl.dealer__Time_Estimate__c);
                    }

                gen.writeEndObject();    
            }
            gen.writeEndArray();

            //Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
            /*
            for (Integer i : myInts) {
                    // For Lines Loop
                    if(urlParameters.get('lines['+i+'][serviceOperationCode]')!=null) {
                        gen.writeStartObject();
                            gen.writeStringField('serviceOperationCode', String.valueOf(urlParameters.get('lines['+i+'][serviceOperationCode]')));
                            gen.writeStringField('concern', String.valueOf(urlParameters.get('lines['+i+'][concern]')));
                            gen.writeStringField('payment_method', String.valueOf(urlParameters.get('lines['+i+'][payment_method]')));
                            gen.writeStringField('estimate', String.valueOf(urlParameters.get('lines['+i+'][estimate]')));
                            gen.writeNumberField('time', Decimal.valueOf(urlParameters.get('lines['+i+'][time]')));
                        gen.writeEndObject();
                    }

                }
                */
            //gen.writeEndArray(); // finished with lines
            gen.writeEndObject(); // finished with line
        gen.writeEndArray();

        //System.debug(gen.getAsString());
        return gen.getAsString();
    }

    public String deleteAppointment() {
        if(String.valueOf(urlParameters.get('RecordId'))!=''&&String.valueOf(urlParameters.get('RecordId'))!=null) {
            dealer__Service_Appointment__c sa = [Select Id from dealer__Service_Appointment__c where Id=:String.valueOf(urlParameters.get('RecordId')) limit 1];
            try {
                delete sa;
            } catch(DmlException e) {
                String msg = '';
                for (Integer i = 0; i < e.getNumDml(); i++) {
                    msg += e.getDmlMessage(i) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(i)); 
                }
                return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
            }
            return '{"result": true,"RecordId":"'+String.valueOf(urlParameters.get('RecordId'))+'"}';
        }
        return '{"error" : "RecordId NULL", "message" : "Destroy Appointment must contain the RecordId to be deleted."}';
    }

    /*---------------------------------------------------
    |
    |   Getter Methods
    |
    \*--------------------------------------------------*/

    /*
    |   getter to return the updated appointment after callout
    */
    public String getcrud() {
        return crudResponse;
    }

    /*
    |   Read the Service Vehicle Object
    |       args: 
    |           URL Param: filter[filters][0][value] - if set wil be used to return 
    |           customerId: will limit the results to only include |           those vehicles owned by this customer
    */
    public String getVehicleRead() {
        List<dealer__Service_Vehicle__c> vehicles = new List<dealer__Service_Vehicle__c>();

        //String filterAsk = String.valueOf(urlParameters.get('filter[filters][0][value]'));
        //if(filterAsk!=null||filterAsk!='') {
        //    vehicles = [Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__VIN__c,
        //        dealer__Year__c, dealer__Make__c, dealer__Carline__c, dealer__Last_Odometer__c
        //        from dealer__Service_Vehicle__c
        //        Where dealer__Veh_Owner__c =: filterAsk
        //        limit 50];
        //} else 

        // No mis server filtering happening
        if( ( (customerId!=null && customerId!='') || (  String.valueOf(urlParameters.get('filter[filters][0][field]')) == 'custid') ) && String.valueOf(urlParameters.get('filter[filters][1][value]')) == null && String.valueOf(urlParameters.get('filter[filters][0][field]'))!='dealer__VIN__c') {

            System.debug('SEACHING BY CUSTOMER ID');
            vehicles = [Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__Veh_Owner_Contact__c, dealer__VIN__c,
                    dealer__Year__c, dealer__Make__c, dealer__Carline__c, dealer__Last_Odometer__c
                    from dealer__Service_Vehicle__c
                    Where dealer__Veh_Owner__c =: customerId
                    limit 50];           
        } else if( String.valueOf(urlParameters.get('filter[filters][1][value]')) != null) {

            System.debug('SEACHING BY user filter');

            String vehSearch = String.valueOf(urlParameters.get('filter[filters][1][value]'));

            //// SOSL Execute
            List<List<sObject>> soslResults = [FIND :vehSearch IN ALL FIELDS RETURNING dealer__Service_Vehicle__c (Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__VIN__c,dealer__Veh_Owner_Contact__c,
                            dealer__Year__c, dealer__Make__c, dealer__Carline__c, dealer__Last_Odometer__c) LIMIT 50];
            vehicles = (List<dealer__Service_Vehicle__c>)soslResults[0];

        // A special Case where we are searching by VIn
        } else if( String.valueOf(urlParameters.get('filter[filters][0][value]')) != null && String.valueOf(urlParameters.get('filter[filters][0][field]'))=='dealer__VIN__c') {

            System.debug('SEACHING BY VIN');


            String searchVin = String.valueOf(urlParameters.get('filter[filters][0][value]'));
            vehicles = [Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__Veh_Owner_Contact__c, dealer__VIN__c,
                                dealer__Year__c, dealer__Make__c, dealer__Carline__c, dealer__Last_Odometer__c
                                from dealer__Service_Vehicle__c
                                Where dealer__VIN__c =: searchVin
                                limit 1];  

        }else {

            vehicles = [Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__VIN__c,dealer__Veh_Owner_Contact__c,
                            dealer__Year__c, dealer__Make__c, dealer__Carline__c, dealer__Last_Odometer__c
                            from dealer__Service_Vehicle__c
                            limit 50];

        }
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for(dealer__Service_Vehicle__c v : vehicles) {
            gen.writeStartObject();

            gen.writeStringField('id', v.Id);
            gen.writeStringField('name', v.Name);

            if( v.dealer__Year__c != null ) {
                gen.writeStringField('year', v.dealer__Year__c);
            }

            if( v.dealer__Make__c != null ) {
                gen.writeStringField('make', v.dealer__Make__c);
            }

            if( v.dealer__Carline__c != null ) {
                gen.writeStringField('model', v.dealer__Carline__c);
            }

            if( v.dealer__Last_Odometer__c != null ) {
                gen.writeNumberField('lastOdom', v.dealer__Last_Odometer__c);
            } else {
                gen.writeNullField('lastOdom');
            }

            if( v.dealer__Veh_Owner__c != null ) {
                gen.writeStringField('custid', v.dealer__Veh_Owner__c);
            } else {
                gen.writeNullField('custid');
            }

            if( v.dealer__Veh_Owner_Contact__c != null ) {
                gen.writeStringField('custid', v.dealer__Veh_Owner_Contact__c);
            } else {
                gen.writeNullField('custid');
            }

            gen.writeEndObject();
        }
        gen.writeEndArray();
        return gen.getAsString();       
    }

    /* IF we have a CustID execute based on ID, else Based on No ID */
    public String getCustomerReadDecision() {
        if(customerId!=null && String.valueOf(urlParameters.get('filter[filters][0][value]')) == null) {
            System.debug('searching by ID');
            return getCustomerReadById();
        } else {
            System.debug('searching by SOSL');
            return getCustomerRead();
        }
    }

    public String getSchedulerLocations(){

        if(String.valueOf(urlParameters.get('filter[filters][0][value]')) == null){
            return ServiceAppointment_Ext.getLocationsJSON();
        } else {
            return getLocationRead();
        }
    }
    
    public string getLocationRead() {
        String searchAsk = String.valueOf(urlParameters.get('filter[filters][0][value]'));
        String alphaChars='';
        if(searchAsk!=null){
            alphaChars = searchAsk.replaceAll('[^A-Za-z0-9 .]','');
        }
        alphaChars = alphaChars.trim();
        if(searchAsk==null || searchAsk=='' || alphaChars.length()<2) {
            return null;
        }
        SearchAsk ='%'+searchAsk+'%';
        return ServiceAppointment_EXT.getLocationSearch(searchAsk);
    }

    /* Customer Read without ID */
    public String getCustomerRead() {

        // Get URL Parameters and SOSL 
        String searchAsk = String.valueOf(urlParameters.get('filter[filters][0][value]'));

        //#T-00829
        String alphaChars='';
        if(searchAsk!=null){
            alphaChars = searchAsk.replaceAll('[^A-Za-z0-9 .]','');  // Case#-1957
        }
        alphaChars = alphaChars.trim();//Case#2087
        //#T-00829
        if(searchAsk==null || searchAsk=='' || alphaChars.length()<2) {
            return null;
        }

        // SOSL Execute
        List<List<sObject>> soslResults = [FIND :searchAsk IN ALL FIELDS RETURNING Account (Id, Name, FirstName, LastName, Phone ,PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, IsPersonAccount) LIMIT 50];
        List<Account> cResults = (List<Account>)soslResults[0];

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
            for(Account ct : cResults) {
                gen.writeStartObject();
                    // Build out JSON feed, 
                    // NOTE: Persons Account fields take precedence over non-persons account fields.

                    gen.writeStringField('custId', ct.Id);
                    gen.writeStringField('Name', ct.Name);
                    if(ct.FirstName!=null)
                        gen.writeStringField('custFirstName', ct.FirstName);
                    if(ct.LastName!=null)
                        gen.writeStringField('custLastName', ct.LastName);
                    if (ct.PersonEmail != null) {
                        gen.writeStringField('custEmail', ct.PersonEmail);
                    } 
                    //else if (ct.Email != null) {
                    //    gen.writeStringField('custEmail', ct.Email);
                    //}

                    if (ct.Phone != null) {
                        gen.writeStringField('custPhone', ct.Phone);
                    }

                    if (ct.PersonMobilePhone != null) {
                        gen.writeStringField('custMobilePhone', ct.PersonMobilePhone);
                    } 
                    //else if (ct.MobilePhone != null) {
                    //    gen.writeStringField('custMobilePhone', ct.MobilePhone);
                    //} 

                    if (ct.PersonHomePhone != null) {
                        gen.writeStringField('custHomePhone', ct.PersonHomePhone);
                    } 
                    //else if (ct.HomePhone != null) {
                    //    gen.writeStringField('custHomePhone', ct.HomePhone);
                    //} 


                    if(ct.IsPersonAccount == true) {

                        if (ct.PersonMailingStreet != null) {
                            gen.writeStringField('custMailingStreet', ct.PersonMailingStreet);
                        }
                        if (ct.PersonMailingCity != null) {
                            gen.writeStringField('custMailingCity', ct.PersonMailingCity);
                        }
                        if (ct.PersonMailingState != null) {
                            gen.writeStringField('custMailingState', ct.PersonMailingState);
                        }
                        if (ct.PersonMailingPostalCode != null) {
                            gen.writeStringField('custMailingPostalCode', ct.PersonMailingPostalCode);
                        }
                        // Build Mailing Address String with all available Address info.
                        String mailingAddress = 
                            ( (null != ct.PersonMailingStreet) ? ct.PersonMailingStreet + ' ' : '' ) +
                            ( (null != ct.PersonMailingCity) ? ct.PersonMailingCity + ', ' : '' ) +
                            ( (null != ct.PersonMailingState) ? ct.PersonMailingState + ' ' : '' ) +
                            ( (null != ct.PersonMailingPostalCode) ? ct.PersonMailingPostalCode + ' ' : '' ) ;

                        if (mailingAddress != '' && mailingAddress != null) {
                            gen.writeStringField('custMailingAddress', mailingAddress);
                        }

                    } 
                    //else {

                    //    if (ct.MailingStreet != null) {
                    //        gen.writeStringField('custMailingStreet', ct.MailingStreet);
                    //    }
                    //    if (ct.MailingCity != null) {
                    //        gen.writeStringField('custMailingCity', ct.MailingCity);
                    //    }
                    //    if (ct.MailingState != null) {
                    //        gen.writeStringField('custMailingState', ct.MailingState);
                    //    }
                    //    if (ct.MailingPostalCode != null) {
                    //        gen.writeStringField('custMailingPostalCode', ct.MailingPostalCode);
                    //    }
                    //    // Build Mailing Address String with all available Address info.
                    //    String mailingAddress = 
                    //        ( (null != ct.MailingStreet) ? ct.MailingStreet + ' ' : '' ) +
                    //        ( (null != ct.MailingCity) ? ct.MailingCity + ', ' : '' ) +
                    //        ( (null != ct.MailingState) ? ct.MailingState + ' ' : '' ) +
                    //        ( (null != ct.MailingPostalCode) ? ct.MailingPostalCode + ' ' : '' ) ;

                    //    if (mailingAddress != '' && mailingAddress != null) {
                    //        gen.writeStringField('custMailingAddress', mailingAddress);
                    //    }
                    //}

                gen.writeEndObject();
            }
        gen.writeEndArray();
        return gen.getAsString();
    }

    /*
    |   Read first 50 Customers
    |       args: URL Parameters, filter[filters][0][field], filter[filters][0][value]
    */
    public String getCustomerReadById() {

        // Dynamic filters passed to this method to search for customer based on Name,Phone,Mobile,Email
        List<Account> c = new List<Account>();

        if(customerId==null || customerId=='') {
            c =[select Id, Name, FirstName, LastName, Phone ,PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, IsPersonAccount,
                            (Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__VIN__c,
                                dealer__Year__c, dealer__Make__c, dealer__Carline__c
                                from ServiceVehicles__r)
                         from Account 
                         Order By LastModifiedDate DESC 
                         limit 50];
        } else {
            c =[select Id, Name, FirstName, LastName, Phone ,PersonEmail, PersonHomePhone, PersonMobilePhone, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, IsPersonAccount,
                            (Select Id, Name, dealer__In_Service_Date__c, dealer__Veh_Owner__c, dealer__VIN__c,
                                dealer__Year__c, dealer__Make__c, dealer__Carline__c
                                from ServiceVehicles__r)
                         from Account 
                         Where Id =: customerId
                         limit 1];          
        }

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
            for(Account ct : c) {
                gen.writeStartObject();
                    // Build out JSON feed, 

                    gen.writeStringField('custId', ct.Id);
                    gen.writeStringField('Name', ct.Name);
                    if(ct.FirstName!=null)
                        gen.writeStringField('custFirstName', ct.FirstName);
                    if(ct.LastName!=null)
                        gen.writeStringField('custLastName', ct.LastName);
                    if (ct.PersonEmail != null) {
                        gen.writeStringField('custEmail', ct.PersonEmail);
                    } 

                    if (ct.Phone != null) {
                        gen.writeStringField('custPhone', ct.Phone);
                    }

                    if (ct.PersonMobilePhone != null) {
                        gen.writeStringField('custMobilePhone', ct.PersonMobilePhone);
                    } 

                    if (ct.PersonHomePhone != null) {
                        gen.writeStringField('custHomePhone', ct.PersonHomePhone);
                    } 

                    if(ct.IsPersonAccount == true) {

                        if (ct.PersonMailingStreet != null) {
                            gen.writeStringField('custMailingStreet', ct.PersonMailingStreet);
                        }
                        if (ct.PersonMailingCity != null) {
                            gen.writeStringField('custMailingCity', ct.PersonMailingCity);
                        }
                        if (ct.PersonMailingState != null) {
                            gen.writeStringField('custMailingState', ct.PersonMailingState);
                        }
                        if (ct.PersonMailingPostalCode != null) {
                            gen.writeStringField('custMailingPostalCode', ct.PersonMailingPostalCode);
                        }
                        // Build Mailing Address String with all available Address info.
                        String mailingAddress = 
                            ( (null != ct.PersonMailingStreet) ? ct.PersonMailingStreet + ' ' : '' ) +
                            ( (null != ct.PersonMailingCity) ? ct.PersonMailingCity + ', ' : '' ) +
                            ( (null != ct.PersonMailingState) ? ct.PersonMailingState + ' ' : '' ) +
                            ( (null != ct.PersonMailingPostalCode) ? ct.PersonMailingPostalCode + ' ' : '' ) ;

                        if (mailingAddress != '' && mailingAddress != null) {
                            gen.writeStringField('custMailingAddress', mailingAddress);
                        }

                    } 

                    // Iterate Vehicles
                    gen.writeFieldName('vehicles');
                    gen.writeStartArray();
                    for(dealer__Service_Vehicle__c v : ct.ServiceVehicles__r) {
                        gen.writeStartObject();
                            gen.writeStringField('id', v.Id);
                            gen.writeStringField('name', v.Name);
                        gen.writeEndObject();   
                    }
                    gen.writeEndArray();
                    // End Vehicle Iteration
                gen.writeEndObject();
            }
        gen.writeEndArray();
        return gen.getAsString();
    }

    /*
    |   Read the standard operation codes defined in the Standard Operation Codes Table
    */
    public String getStandardOperationCodes() {
        List<StandardOpCode__c> ops = [SELECT dealer__Active__c, dealer__Book_Time__c, dealer__Cause__c, dealer__Concern__c, dealer__Correction__c, dealer__Labor_Code__c,
                                        dealer__Labor_Estimate__c, dealer__Make__c, dealer__Op_Code_Description__c, dealer__Op_Code__c, 
                                        dealer__Pay_Type__c, dealer__Service_Type__c, dealer__Parts_Estimate__c, dealer__Estimate__c,
                                        dealer__Company_Number__c, dealer__Primary_Category__c, dealer__RecordId__c, 
                                        dealer__Recommended_Service_Code__c, dealer__Remarketing_Default_Delay__c, dealer__Operation_Notes__c, 
                                        dealer__Associated_Marketing_Template__c, dealer__Default__c, dealer__Dispatch_Code__c, Name, Id 
                                        FROM dealer__StandardOpCode__c
                                        WHERE dealer__Active__c = true
                                        Order by Name ASC
                                        LIMIT 500];
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for(StandardOpCode__c o : ops) {
            gen.writeStartObject();
                if(o.dealer__Book_Time__c==null) { o.dealer__Book_Time__c = 0; }
                if(o.dealer__Concern__c==null) { o.dealer__Concern__c = ''; }
                if(o.dealer__Pay_Type__c==null) { o.dealer__Pay_Type__c = ''; }
                gen.writeStringField('id', o.Id);
                gen.writeStringField('name', o.Name);
            	if(o.dealer__Op_Code_Description__c == null){o.dealer__Op_Code_Description__c = '';}
                gen.writeStringField('opCodeDescription', o.dealer__Op_Code_Description__c);
                if(o.dealer__Book_Time__c==null) { o.dealer__Book_Time__c=0; }
                gen.writeNumberField('time', o.dealer__Book_Time__c);
                gen.writeStringField('concern', o.dealer__Concern__c);
                gen.writeStringField('payment_method', o.dealer__Pay_Type__c);
                
                if(o.dealer__Labor_Code__c!=null) { 
                    gen.writeStringField('laborCode', o.dealer__Labor_Code__c);
                }

            gen.writeEndObject();
        }
        gen.writeEndArray();

        return gen.getAsString();
    }

    /*
        Read Payment Type Picklist values.
     */
    public String getPmtTypeOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        dealer__Service_Appointment_Line__c.dealer__Pay_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        //return options;

        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for(SelectOption o : options) {
            if(o.getDisabled() == false) {
                gen.writeStartObject();
                    gen.writeStringField('value', o.getValue());
                    gen.writeStringField('label', o.getLabel());
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();

        return gen.getAsString();
    }

    /*
    |   Generate the list of Service Appointments stored between two date ranges
    */
    public List<dealer__Service_Appointment__c> listOfEvents() {
        DateTime s = DateTime.newInstance(startDate.year(), startDate.month(), startDate.day(), 0, 0, 0);
        DateTime e = DateTime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23, 59, 59);  
        sa = [Select d.dealer__Waiter__c, d.dealer__Vehicle__c, d.dealer__Vehicle__r.Name, d.dealer__SA__c, d.dealer__Loaner_Requested__c, d.dealer__External_Id__c, dealer__Mileage__c,
                        d.dealer__Date_Time__c, d.dealer__Customer_Contact__c, d.dealer__Company_Number__c, d.dealer__Appointment_Time__c, 
                        d.Name, d.Id, d.dealer__Durration__c, d.dealer__Customer_Contact__r.Name , d.dealer__Color_Code__c, d.dealer__Company__c,
                        d.dealer__Customer__c, d.dealer__Customer__r.Name, d.dealer__Customer__r.IsPersonAccount, d.dealer__Customer__r.Phone, d.dealer__Customer__r.PersonHomePhone, d.dealer__Customer__r.PersonMobilePhone,
                        (select Id, Name, dealer__Line__c,dealer__Line_Key__c, dealer__Standard_Op_Code__c, dealer__Qoute__c, dealer__Pay_Type__c, 
                                dealer__CustomerConcern__c, dealer__Op_Code_Description__c, dealer__Op_Code__c, dealer__Book_Time__c
                                from Service_Appointment_Lines__r)
                    From dealer__Service_Appointment__c d
                    WHERE ( End_Date_Time__c <=:e AND End_Date_Time__c >=:s AND d.dealer__Company__c =: selectedLocation 
                          AND ConvertedtoRepairOrder__c = false)  
                    OR (Date_Time__c >=:s AND End_Date_Time__c >=:e AND d.dealer__Company__c =: selectedLocation)
                    OR (Date_Time__c <=:s AND End_Date_Time__c >:e AND d.dealer__Company__c =: selectedLocation)
                    limit 500];
                    
        System.debug(sa.size()+' '+e+' '+s+' '+Date.today());           
        return sa;  
    }
    
    public List<dealer__Service_Repair_Order__c> listofROs() {
        Date s = startDate;
        Date e = endDate; 

         //WHERE dealer__Promise_Date__c >=:s 
         //           AND dealer__Promise_Date__c <=:e

        //DateTime s = DateTime.newInstance(startDate.year(), startDate.month(), startDate.day(), 0, 0, 0);
        //DateTime e = DateTime.newInstance(endDate.year(), endDate.month(), endDate.day(), 23, 59, 59); 

        ros = [SELECT Id, Name, dealer__Posted_Date_Time__c, dealer__Create_Date_Time__c,
                dealer__RO_Number__c, dealer__Service_Advisor__c, dealer__Waiting__c, 
                dealer__Mileage_In__c, dealer__Mileage_Out__c, dealer__Company_Number__c,
                dealer__Promise_Date__c, dealer__Promise_Time__c, dealer__Color_Code__c,
                dealer__Company__c, dealer__Expected_Service_Start__c, dealer__Expected_Service_End__c,
                dealer__Customer_Contact__c, dealer__Customer_Contact__r.Name,
                dealer__Customer__c, dealer__Customer__r.Name,
                dealer__Vehicle__r.Name, dealer__Customer__r.IsPersonAccount,
                dealer__Service_Advisor__r.Name

                FROM dealer__Service_Repair_Order__c
                WHERE 
                    ((dealer__Expected_Service_End__c >=:s 
                        AND dealer__Expected_Service_End__c <=:e)
                    OR (dealer__Expected_Service_Start__c >=:s 
                        AND dealer__Expected_Service_Start__c <=:e))
                    AND dealer__Company__c =: selectedLocation
                LIMIT 100];
                   
                //AND dealer__Company__c =: selectedLocation

                //WHERE dealer__Create_Date_Time__c >=:s and dealer__Create_Date_Time__c <=:e
    
                //(SELECT Id, Name, dealer__Line_Number__c, dealer__Book_Time__c,
                //        dealer__Standard_Operation_Code__c, dealer__Operation_Code_Description__c,
                //        dealer__Op_Code__c, dealer__Op_Description__c,
                //        dealer__CustomerConcern__c
                //    FROM dealer__Service_Job__r)   
    
        System.debug(ros);

        return ros;  
    }

    /*
    |   Generate the list of events and return as a JSON String
    */
    public String generateEventFeed() {
        List<dealer__Service_Appointment__c> evts = listOfEvents();
        List<dealer__Service_Repair_Order__c> rs = listofROs();
        JSONGenerator gen = JSON.createGenerator(true);

        //W-000697 - Find valid locations 
        Set<Id> myLocations = new Set<Id>();
        for(dealer__Dealer_Location_User__c locU : [SELECT Id, dealer__Dealer_Location__c FROM dealer__Dealer_Location_User__c WHERE dealer__User__c =: UserInfo.getUserId()]) {
            myLocations.add(locU.dealer__Dealer_Location__c);
        }

        //gen.writeStartObject();
            //gen.writeFieldName('events');

            gen.writeStartArray();

                // Service Appointments
                for(dealer__Service_Appointment__c s : evts) {
                
                    if(s.dealer__Durration__c == null) {
                        s.dealer__Durration__c = 20;
                    }   

                    if(s.dealer__Company_Number__c==null) {
                        s.dealer__Company_Number__c='';
                    }

                    //Datetime endDT = s.dealer__Date_Time__c;

                    gen.writeStartObject();
                        gen.writeStringField('RecordId', s.Id);
                        gen.writeStringField('type', 'APT');

                        //W-000697 Write if location is valid
                        if(s.dealer__Company__c!=null && myLocations.contains(s.dealer__Company__c)){
                            gen.writeStringField('validLocation', 'true');
                        }
                        else{
                            gen.writeStringField('validLocation', 'false');
                        }

                        if(s.dealer__SA__c!=null) {
                            gen.writeStringField('AdvisorId', s.dealer__SA__c);
                        } else {
                            gen.writeNullField('AdvisorId');
                        }

                        if(s.dealer__Company__c!=null) {
                            gen.writeStringField('Location', s.dealer__Company__c);
                        } else {
                            gen.writeNullField('Location');
                        }

                        if(s.dealer__Company_Number__c!=null) {
                            gen.writeStringField('companynumber', s.dealer__Company_Number__c);
                        }

                        if(s.dealer__Mileage__c!=null) {
                            gen.writeNumberField('vehOdometer', s.dealer__Mileage__c);
                        }

                        if(s.dealer__Customer__c!=null) {
                            gen.writeStringField('custId', s.dealer__Customer__c);
                            gen.writeStringField('Name', s.dealer__Customer__r.Name);
                        } else {
                            gen.writeNullField('custId');
                            gen.writeNullField('Name');

                        }

                        if(s.dealer__Customer__c!=null && s.dealer__Customer__r.IsPersonAccount != true && s.dealer__Customer__r.Phone!=null) {
                            gen.writeStringField('custPhone', s.dealer__Customer__r.Phone);
                        } else {
                            //gen.writeNullField('custPhone');

                        }

                        if( s.dealer__Customer__c!=null && s.dealer__Customer__r.IsPersonAccount == true && s.dealer__Customer__r.PersonHomePhone!=null) {
                            gen.writeStringField('custPhone', s.dealer__Customer__r.PersonHomePhone);
                        } else {
                            //gen.writeNullField('custPhone');

                        }
                    
                      
                    
                        if(s.dealer__Customer_Contact__r.Name!=null && !s.dealer__Customer__r.IsPersonAccount ){                   
                           gen.writeStringField('contactName', s.dealer__Customer_Contact__r.Name);
                        }else{
                           gen.writeNullField('contactName');
                       }


                        if(s.dealer__Customer__c!=null && s.dealer__Customer__r.IsPersonAccount == true && s.dealer__Customer__r.PersonMobilePhone!=null) {
                            gen.writeStringField('custMobile', s.dealer__Customer__r.PersonMobilePhone);
                        } else {
                            //gen.writeNullField('custMobile');

                        }


                        if(s.dealer__Vehicle__c!=null) {
                            gen.writeStringField('vehId', s.dealer__Vehicle__c);
                            gen.writeStringField('vehName', s.dealer__Vehicle__r.Name);

                        } else {
                            gen.writeNullField('vehId');
                            gen.writeNullField('vehName');
                        }

                        // Durration
                        Long startDateTime  =   s.dealer__Date_Time__c.getTime();
                        Long stdDurration   =   Long.valueOf(String.valueOf(s.dealer__Durration__c));
                        Long apptDurration  =   (stdDurration * 60 * 1000);
                        Long endDateTime    =   (startDateTime + apptDurration);

                        gen.writeStringField('title', s.Name);
                        //gen.writeStringField('start', 'new Date('+s.dealer__Date_Time__c.year()+', '+s.dealer__Date_Time__c.month()+', '+s.dealer__Date_Time__c.day()+', '+s.dealer__Date_Time__c.hour()+', '+s.dealer__Date_Time__c.minute()+')'); // String.valueOf(s.dealer__Date_Time__c.getTime()));
                        gen.writeStringField('start', '/Date('+String.valueOf(s.dealer__Date_Time__c.getTime())+')/');
                        gen.writeStringField('end',  '/Date('+endDateTime+')/');
                        gen.writeBooleanField('allDay', false);
                        gen.writeStringField('url', '/'+s.Id);

                        if(s.dealer__Color_Code__c!=null) {
                            gen.writeStringField('color', s.dealer__Color_Code__c);
                        } else {
                            gen.writeStringField('color', '');
                        } 

                        //gen.writeDateTimeField('startDate', s.dealer__Date_Time__c);
                        //gen.writeDateTimeField('endDate', s.dealer__Date_Time__c);
                        gen.writeStringField('startDate', '/Date('+(s.dealer__Date_Time__c).getTime()+')/');
                        gen.writeStringField('endDate', '/Date('+(s.dealer__Date_Time__c + (0.01042)).getTime()+')/');
                        if(s.dealer__Durration__c==null) { s.dealer__Durration__c=20; }
                        gen.writeNumberField('durration', s.dealer__Durration__c);
                        gen.writeNullField('StartTimezone'); 
                        gen.writeNullField('EndTimezone');
                        gen.writeNullField('RecurrenceRule');
                        gen.writeNullField('RecurrenceID');
                        gen.writeNullField('RecurrenceException');

                        // Add Lines 
                        gen.writeFieldName('lines');
                        gen.writeStartArray();
                        for(dealer__Service_Appointment_Line__c l : s.Service_Appointment_Lines__r) {
                            gen.writeStartObject();
                                // Check Null Fields
                                if(l.dealer__Pay_Type__c==null) { l.dealer__Pay_Type__c = ''; }
                                if(l.dealer__Qoute__c==null) { l.dealer__Qoute__c = 0; }
                                if(l.dealer__CustomerConcern__c==null) { l.dealer__CustomerConcern__c = ''; }

                                gen.writeStringField('lineId', l.Id);
                                if(l.dealer__Book_Time__c!=null) {
                                    gen.writeNumberField('time', l.dealer__Book_Time__c);
                                }
                                if(l.dealer__Standard_Op_Code__c!=null) {
                                    gen.writeStringField('serviceOperationCodeId', l.dealer__Standard_Op_Code__c);
                                }

                                /*
                                if(l.dealer__Line_Key__c!=null) {
                                    gen.writeStringField('lineKey', l.dealer__Line_Key__c);
                                }
                                */

                                if(l.Name!=null) {
                                    gen.writeStringField('serviceOperationCode', l.Name);
                                }
                                gen.writeStringField('payment_method', l.dealer__Pay_Type__c);
                                if(l.dealer__Qoute__c==null) { l.dealer__Qoute__c=0; }
                                gen.writeNumberField('estimate', l.dealer__Qoute__c);
                                gen.writeStringField('concern', l.dealer__CustomerConcern__c);
                            gen.writeEndObject();
                        }
                        gen.writeEndArray();

                        
                    gen.writeEndObject();
                }

                // Repair Orders
                for(dealer__Service_Repair_Order__c r : rs) {
                
                    gen.writeStartObject();

                        gen.writeStringField('type', 'RO');
                        gen.writeStringField('RecordId', r.Id);
                        gen.writeStringField('title', r.Name);
                        gen.writeBooleanField('allDay', false);
                        gen.writeStringField('url', '/'+r.Id);

                        // Default NULL fields to match Appointments

                        if(r.dealer__Service_Advisor__c!=null) {
                            gen.writeStringField('AdvisorId', r.dealer__Service_Advisor__c);
                        } else {
                            gen.writeNullField('AdvisorId');
                        }
                                
                        if(r.dealer__Customer_Contact__r.Name!=null && !r.dealer__Customer__r.IsPersonAccount ){
                            gen.writeStringField('contactName', r.dealer__Customer_Contact__r.Name);
                        }else{           
                           gen.writeNullField('contactName');             
                        }

                        if(r.dealer__Company_Number__c!=null) {
                            gen.writeStringField('companynumber', r.dealer__Company_Number__c);
                        } else {
                             gen.writeStringField('companynumber', '');
                        }

                        if(r.dealer__Customer_Contact__c!=null) {
                            gen.writeStringField('custId', r.dealer__Customer_Contact__c);
                            gen.writeStringField('Name', r.dealer__Customer_Contact__r.Name);
                        }  else if ( r.dealer__Customer__c != null ) {
                            gen.writeStringField('custId', r.dealer__Customer__c);
                            gen.writeStringField('Name', r.dealer__Customer__r.Name);
                        } else {
                            gen.writeNullField('custId');
                            gen.writeNullField('Name');
                        }

                        if(r.dealer__Vehicle__c!=null) {
                            gen.writeStringField('vehId', r.dealer__Vehicle__c);
                            gen.writeStringField('vehName', r.dealer__Vehicle__r.Name);
                        } else {
                            gen.writeNullField('vehId');
                            gen.writeNullField('vehName');
                        }

                        // START
                        if(r.dealer__Expected_Service_Start__c!=null) {
                            gen.writeStringField('start', '/Date('+String.valueOf(r.dealer__Expected_Service_Start__c.getTime())+')/');
                        }

                        // END
                        if(r.dealer__Expected_Service_End__c!=null && r.dealer__Expected_Service_End__c!=null) {
                            gen.writeStringField('end', '/Date('+String.valueOf(r.dealer__Expected_Service_End__c.getTime())+')/');

                        }
                        /*if(r.dealer__Promise_Date__c!=null && r.dealer__Promise_Time__c!=null) {
                            
                            Datetime endTime = DateTime.parse('01/01/1982 ' + r.dealer__Promise_Time__c);

                            DateTime finalEnd = DateTime.newInstance(r.dealer__Promise_Date__c.year(), r.dealer__Promise_Date__c.month(), r.dealer__Promise_Date__c.day(), endTime.hour(), endTime.minute(), 00);  

                            //System.debug(finalEnd);

                            //gen.writeStringField('start', '/Date('+String.valueOf(r.dealer__Create_Date_Time__c.getTime())+')/');
                            gen.writeStringField('end', '/Date('+String.valueOf(finalEnd.getTime())+')/');
                        }*/
                        
                        if(r.dealer__Color_Code__c!=null) {
                            gen.writeStringField('color', r.dealer__Color_Code__c);
                        } else {
                            gen.writeStringField('color', '');
                        } 

                        //gen.writeStringField('end', '/Date('+String.valueOf(r.dealer__Date_Time__c.getTime())+')/');
                        //gen.writeStringField('end',  '/Date('+endDateTime+')/');

                        //gen.writeNullField('StartTimezone'); 
                        //gen.writeNullField('EndTimezone');
                        //gen.writeNullField('RecurrenceRule');
                        //gen.writeNullField('RecurrenceID');
                        //gen.writeNullField('RecurrenceException');

                        
                    gen.writeEndObject();
                }

            gen.writeEndArray();
        //gen.writeEndObject();
        String genString    =   gen.getAsString();
        /*
        genString = genString.replace('"events"', 'events');
        genString = genString.replace('"start"', 'start');
        genString = genString.replace('"title"', 'title');
        genString = genString.replace('"allDay"', 'allDay');
        genString = genString.replace('"new ', 'new ');
        genString = genString.replace(')"', ')');
        */
        return genString;
    }
    
    /* 
    |   Getter to pass the generatedEventFeed back to the browser
    */
    public String getAppointmentJSON() {
        return generateEventFeed();
    }
}