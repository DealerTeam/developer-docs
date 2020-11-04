public with sharing class ServiceAppointment_EXT {

    private final dealer__Service_Appointment__c sa;
    public Id advisor {get {return UserInfo.getUserId(); } set;}
    public dealer__Service_Vehicle__c sv {get;set;}
    public List<dealer__Service_Appointment_Line__c> sl {get;set;}
    public Event e {get;set;}
    public String timeString {get;set;}
    public String opCodeId {get;set;}
    public String opCodeName {get;set;}
    public String lineConcern {get;set;}
    public String opCodeDescription {get;set;}
    public String payType {get;set;}
    public String estimate {get;set;}
    public Decimal booktime {get;set;}
    public String apptDay {get;set;}
    public String apptMonth {get;set;}
    public String apptYear {get;set;}
    public Boolean renderDecodeButt {get;set;}
    public Map<String, String> urlParameters = new Map<String, String>();
    public Id myDealershipId { get { return Utility.lookupUserLocation(); } set; }

    //ServiceOpCodes opCodesObj =  dealer.ServiceOpCodes();
    //ServiceOpCodes opCodes = opCodesObj.opCodes();

    public List<User> advisorList = new List<User>();
    public List<cLocation> locationList = new List<cLocation>();

    public class customException extends Exception {}

    public class cContact {
        public String custId {get; set;}
        public String Name {get; set;}
        public String custEmail {get; set;}
        public String custPhone {get; set;}
        public String custMobilePhone {get; set;}
        public String custHomePhone {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact( Account c ) {
            custId = c.Id;
            Name = c.Firstname + ' ' + c.LastName;
            custEmail = c.PersonEmail;
            custPhone = c.Phone;
            custMobilePhone = c.PersonMobilePhone;
            custHomePhone = c.PersonHomePhone;
        }
        public cContact( sObject c ) {
            custId = c.id;
            Name = (String)c.get('name');
            custEmail = (String)c.get('PersonEmail');
            custPhone = (String)c.get('Phone');
        }
    }

    public class cVehicle {
        public dealer__Service_Vehicle__c con {get; set;}
        public String custid {get; set;}
        public String id {get; set;}
        public String name {get; set;}
        public String licence {get; set;}
        public String vin {get; set;}
        public String modelCode {get; set;}
        public String year {get; set;}
        public String make {get; set;}
        public String model {get; set;}
        public String trim {get; set;}

        public cVehicle(dealer__Service_Vehicle__c v) {
            custid = v.dealer__Veh_Owner_Contact__c;
            id = v.Id;
            name = v.Name;
            licence = v.dealer__Licence__c;
            vin = v.dealer__VIN__c;
            modelCode = v.dealer__Model_Code__c;
            year = v.dealer__Year__c;
            make = v.dealer__Make__c;
            model = v.dealer__Carline__c;
            trim = v.dealer__Trim_Level__c;
        }
    }

    // Custom Location wrapper class
    public class cLocation {
        // LOC Wrap
        public String Id {get; set;}
        public String Name {get; set;}
        public Decimal aptLength {get; set;}
        public String OpenHour {get; set;}
        public String CloseHour {get; set;}
        public String companyNumber {get; set;}
        public List<cMember> Members {get; set;}

        public cLocation(dealer__Dealer_Location__c l, List<cMember> ml) {
            Id = l.Id;
            Name = l.Name;
            aptLength = l.dealer__Appt_Duration__c;
            OpenHour = l.dealer__Open_Hour__c;
            CloseHour = l.dealer__Close_Hour__c;

            companyNumber = l.dealer__Company_Number__c;

            Members = ml;
        }
    }

    public class cMember {
        public String id {get; set;}
        public String name {get; set;}
        public cMember(String l_id , String l_name){
            id = l_id;
            // name = l_name.replaceAll('[^a-zA-Z0-9\\s+]', '');
            name = l_name;
        }
    }

    public ServiceAppointment_EXT(ApexPages.Standardcontroller sc) {
        List<String> af = new List<String>();
        if(!Test.isRunningTest()) {
            renderDecodeButt = SecureVDCSettings.getOrgByDefault('ActiveSettings').dealer__Active__c;
            af.add('dealer__Vehicle__c');
            af.add('dealer__Date_Time__c');
            sc.addFields(af);
        }

        sa  =   (dealer__Service_Appointment__c)sc.getRecord();
        sa.dealer__SA__c=advisor;
        e = new Event();

        // If LKID is present, lookup the value and set as specified.
        // Check Apex Get Variables and Assign Account
        if(ApexPages.currentPage()!=null) {
            urlParameters = ApexPages.currentPage().getParameters();
            for(String p : urlParameters.keySet()) {
                if(p.contains('_lkid')) {
                    sa.dealer__Customer__c  = Utility.lookupParentAccount(urlParameters.get(p));
                }
            }
        }

        // If Id present search service vehicle
        if(ApexPages.currentPage().getParameters().get('vId')!='' && ApexPages.currentPage().getParameters().get('vId') != null) {
            dealer__Service_Vehicle__c[] svs = [Select Id, dealer__Veh_Owner__c,
                                                    dealer__Veh_Owner_Contact__c, dealer__Last_Odometer__c, dealer__Last_Service__c
                                                    from dealer__Service_Vehicle__c
                                                    where Id =:ApexPages.currentPage().getParameters().get('vId') limit 1];
            if(svs.size()>0) {
                sv=svs[0];
                sa.dealer__Vehicle__c=sv.Id;
                sa.dealer__Customer_Contact__c=sv.dealer__Veh_Owner_Contact__c;
                sa.dealer__Customer__c=sv.dealer__Veh_Owner__c;

                // Check to see if that customer has any other open appointments
                dealer__Service_Appointment__c[] svas = [Select Id from dealer__Service_Appointment__c
                                                            where dealer__Vehicle__c =:sa.dealer__Vehicle__c
                                                            or dealer__Customer_Contact__c =:sa.dealer__Customer_Contact__c
                                                            limit 10 ];

                if(svas.size() > 0) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer or Vehicle have an existing appointment. '));
                }

            }
        }


        // Added By KVP
        // If Id present search service vehicle
        if(ApexPages.currentPage().getParameters().get('weoweid')!='' && ApexPages.currentPage().getParameters().get('weoweid') != null) {
            dealer__We_Owe__c[] weOwe = [Select Id, dealer__Car_Deal__c, dealer__Closed_Date__c, dealer__Code__c, dealer__Cost__c, dealer__Deal_Key__c,
                                        dealer__Description__c, dealer__External_Id__c, dealer__Parts_Department_Reviewed__c, dealer__RetailPrice__c,
                                        dealer__Satisfied_By__c, dealer__Service_Department_Reviewed__c, dealer__Service_Repair_Order__c, dealer__Status__c,
                                        dealer__Car_Deal__r.dealer__Service_Vehicle__r.dealer__Veh_Owner_Contact__c,
                                        dealer__Car_Deal__r.dealer__Service_Vehicle__c,
                                        dealer__Car_Deal__r.dealer__Service_Vehicle__r.dealer__Veh_Owner__c
                                        FROM dealer__We_Owe__c
                                        where Id =:ApexPages.currentPage().getParameters().get('weoweid') limit 1];
            if(weOwe.size()>0) {
                //sv=svs[0];
                sa.dealer__We_Owe__c = weOwe[0].Id;
                sa.dealer__Customer_Contact__c= weOwe[0].dealer__Car_Deal__r.dealer__Service_Vehicle__r.dealer__Veh_Owner_Contact__c;
                sa.dealer__Customer__c=weOwe[0].dealer__Car_Deal__r.dealer__Service_Vehicle__r.dealer__Veh_Owner__c;
                sa.dealer__Vehicle__c = weOwe[0].dealer__Car_Deal__r.dealer__Service_Vehicle__c;

                List<dealer__Service_Appointment__c> svas = new List<dealer__Service_Appointment__c>();
                // Check to see if that customer has any other open appointments
                if(sa.dealer__Customer_Contact__c != null){
                    svas = [Select Id from dealer__Service_Appointment__c
                                                            where dealer__We_Owe__c =:sa.dealer__We_Owe__c
                                                            or dealer__Customer_Contact__c =:sa.dealer__Customer_Contact__c
                                                            limit 10 ];
                }
                if(svas.size() > 0) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer or Weowe have an existing appointment. '));
                }

            }
        }

        if(sa.Id != null) {
        // Get Appointment Lines
            getJobLines();
            if(sa.dealer__Vehicle__c == null) {
                System.debug('Not picking up SA Vehicle');
            }
        }

        if(sa.dealer__Date_Time__c!=null) {
            this.apptDay = String.valueOf(sa.dealer__Date_Time__c.day());
            this.apptMonth = String.valueOf((sa.dealer__Date_Time__c.month()-1));
            this.apptYear = String.valueOf(sa.dealer__Date_Time__c.year());
        }

    }

    public void getJobLines() {
        sl = [Select d.dealer__Service_Appointment__c, d.Name, d.dealer__Qoute__c, d.dealer__Priority__c, d.dealer__Pay_Type__c,
                d.dealer__Complaint__c, d.dealer__CustomerConcern__c, d.Id, d.dealer__Standard_Op_Code__r.Name, d.dealer__Standard_Op_Code__r.dealer__Op_Code_Description__c, d.dealer__Standard_Op_Code__c
                From dealer__Service_Appointment_Line__c d
                where d.dealer__Service_Appointment__c =:sa.Id limit 500];
    }


    public String getServiceHistoryJSON() {
        if(sa.dealer__Vehicle__c!=null) {
            return ServiceHistory.serviceHistoryJSON(sa.dealer__Vehicle__c);
        } else {
            return null;
        }
    }

    public PageReference create() {

        // Generate the Date/Time field based upon the date and timepicker
        DateTime md = DateTime.newInstance(e.Custom_Search_Start_Date__c.year(), e.Custom_Search_Start_Date__c.month(), e.Custom_Search_Start_Date__c.day());
        DateTime an = Utility.stringToDateTime(md.format('MM/dd/yyyy')+' '+sa.dealer__Appointment_Time__c);
        system.debug(an);
        sa.dealer__Date_Time__c =   an;

        // Moved to Trigger - Jarrett Kuljis : 08/16/2013
        //Contact c = [Select FirstName, LastName from Contact where Id=:sa.dealer__Customer_Contact__c limit 1];

        //sa.Name = 'SVCAPT: '+c.FirstName+' '+c.LastName;

        // Create Service Appointment
        if(sa.Id==null) {
            insert sa;
        } else {
            update sa;
        }

        PageReference acctPage = new ApexPages.StandardController(sa).view();
        acctPage.setRedirect(true);
        return acctPage;
    }

    public PageReference addJobLine() {
        System.debug('Adding Job Line');
        dealer__Service_Appointment_Line__c line = new dealer__Service_Appointment_Line__c();

        if(this.lineConcern == null) { this.lineConcern = String.valueOf(''); }

        line.Name = '';
        line.dealer__Service_Appointment__c = this.sa.Id;
        line.dealer__Standard_Op_Code__c = this.opCodeId;
        line.dealer__CustomerConcern__c = this.lineConcern;
        line.dealer__Qoute__c = Decimal.valueOf(this.estimate);
        line.dealer__Pay_Type__c = this.payType;
        //System.debug(line);
        insert line;
        getJobLines();
        return null;
    }

    public List<User> advisorList() {
        advisorList = getAdvisorList();
        return advisorList;
    }

    public List<User> getAdvisorList() {

        return [Select Id, FullPhotoUrl, FirstName, LastName from User where IsActive = true and dealer__Service_Advisor__c = true limit 500];
    }

    public String getAdvisorResourceJSON() {
        JSONGenerator adv = JSON.createGenerator(false);
        adv.writeStartArray();
        User[] u = [Select Id, FullPhotoUrl, FirstName, LastName from User where IsActive = true and (dealer__Service_Advisor__c = true OR dealer__Technician__c = true) limit 500];
        for(User a : u) {
          adv.writeStartObject();
            adv.writeStringField('text', a.FirstName+' '+a.LastName);
            adv.writeStringField('value', a.Id);
            adv.writeStringField('color', '#6eb3fa');
          adv.writeEndObject();
        }
        adv.writeEndArray();
        return adv.getAsString();
    }
    
    public static List<cLocation> buildLocUserList() {
        List<cLocation> cLocations = new List<cLocation>();
        List<cMember> cMembers = new List<cMember>();
        List<dealer__Dealer_Location__c> ls = new List<Dealer_LOcation__c>();
        
        Set<Id> applicableLocs = new Set<Id>();
        Map<Id,Id> applicableLocMap = Utility.applicableLocations();
    
        for(Id locId : applicableLocMap.Values()){
            if(!applicableLocs.contains(locId))
                applicableLocs.add(locId);
        }

        if(applicableLocs.size() > 0){
            ls = [SELECT Id, Name, dealer__Company_Number__c,
                                                     dealer__Appt_Duration__c, dealer__Open_Hour__c,
                                                     dealer__Close_Hour__c,
                                                     (SELECT id,dealer__Dealer_Location__c,dealer__User__c,dealer__User__r.Name, dealer__Sequence_Number__c 
                                                      FROM Dealer_Location_Users__r 
                                                      WHERE dealer__Technician__c = true AND dealer__User__r.IsActive = true 
                                                      Order By dealer__Sequence_Number__c, dealer__User__r.Name) // W-000744
                                                     FROM dealer__Dealer_Location__c WHERE Id IN: applicableLocs  Order By Name ASC    
                                                     ];
        } 

        // Loop trough locations
        for(dealer__Dealer_Location__c l : ls) {

            List<cMember> tmpM = new List<cMember>();

            for(Dealer_Location_User__c luser:l.Dealer_Location_Users__r) {
                if(luser.Dealer_Location__c==l.Id) {
                    tmpM.add( new cMember( luser.dealer__User__c, luser.dealer__User__r.Name ) );
                }
            }

            cLocation tmpL = new cLocation( l, tmpM);

            // Add new Location to cLocations list
            cLocations.add(tmpL);
        }

        System.debug(cLocations);
        return cLocations;
    }

    public static List<cLocation> buildLocUserList(string SearchAsk) {
        system.debug('searchAsk '+searchAsk);
        List<cLocation> cLocations = new List<cLocation>();
        List<cMember> cMembers = new List<cMember>();
        List<dealer__Dealer_Location__c> ls = new List<Dealer_LOcation__c>();
        
        Set<Id> applicableLocs = new Set<Id>();
        Map<Id,Id> applicableLocMap = Utility.applicableLocations();
        
        for(Id locId : applicableLocMap.Values()){
            if(!applicableLocs.contains(locId))
                applicableLocs.add(locId);
        }
        if(applicableLocs.size() > 0){
            ls = [SELECT Id, Name, dealer__Company_Number__c,
                                                     dealer__Appt_Duration__c, dealer__Open_Hour__c,
                                                     dealer__Close_Hour__c,
                                                     (SELECT id,dealer__Dealer_Location__c,dealer__User__c,dealer__User__r.Name, dealer__Sequence_Number__c 
                                                      FROM Dealer_Location_Users__r 
                                                      WHERE dealer__Technician__c = true AND dealer__User__r.IsActive = true 
                                                      Order By dealer__Sequence_Number__c, dealer__User__r.Name) // W-000744
                                                     FROM dealer__Dealer_Location__c WHERE Id IN: applicableLocs AND
                                                     (Company_Number__c Like: SearchAsk OR Name Like: SearchAsk OR City__c Like: SearchAsk OR State__c Like:SearchAsk or County__c Like:SearchAsk)
                                                      Order By Name ASC    
                                                     ];
        } 

        // Loop trough locations
        for(dealer__Dealer_Location__c l : ls) {

            List<cMember> tmpM = new List<cMember>();

            for(Dealer_Location_User__c luser:l.Dealer_Location_Users__r) {
                if(luser.Dealer_Location__c==l.Id) {
                    tmpM.add( new cMember( luser.dealer__User__c, luser.dealer__User__r.Name ) );
                }
            }

            cLocation tmpL = new cLocation( l, tmpM);

            // Add new Location to cLocations list
            cLocations.add(tmpL);
        }

        System.debug(cLocations);
        return cLocations;
    }

    public static List<cLocation> buildLocUserList(Id locId) {
        List<cLocation> cLocations = new List<cLocation>();
        List<cMember> cMembers = new List<cMember>();
        List<dealer__Dealer_Location__c> ls = [SELECT Id, Name, dealer__Company_Number__c,
                                                     dealer__Appt_Duration__c, dealer__Open_Hour__c,
                                                     dealer__Close_Hour__c,
                                                     (SELECT id,dealer__Dealer_Location__c,dealer__User__c,dealer__User__r.Name, dealer__Sequence_Number__c 
                                                      FROM Dealer_Location_Users__r 
                                                      WHERE dealer__Technician__c = true AND dealer__User__r.IsActive = true 
                                                      Order By dealer__Sequence_Number__c, dealer__User__r.Name) // W-000744
                                                     FROM dealer__Dealer_Location__c WHERE Id =: locId];

        // Loop trough locations
        for(dealer__Dealer_Location__c l : ls) {

            List<cMember> tmpM = new List<cMember>();

            for(Dealer_Location_User__c luser:l.Dealer_Location_Users__r) {
                if(luser.Dealer_Location__c==l.Id) {
                    tmpM.add( new cMember( luser.dealer__User__c, luser.dealer__User__r.Name ) );
                }
            }

            cLocation tmpL = new cLocation( l, tmpM);

            // Add new Location to cLocations list
            cLocations.add(tmpL);
        }

        System.debug(cLocations);
        return cLocations;
    }

    // Retrieve Appointemnt Colors
    public static String getLocationsJSON() {

        // Setup JSON Generator
        JSONGenerator lGen = JSON.createGenerator(false);
        // Create Array
        lGen.writeStartArray();

        // Loop through locations
        for(cLocation l : buildLocUserList() ) {

            lGen.writeStartObject();

                lGen.writeStringField('Id', l.Id );
                lGen.writeStringField('Name', l.Name);
                lGen.writeStringField('companyNumber', l.companyNumber);
                if(l.aptLength==null) { l.aptLength = 0; }
                lGen.writeNumberField('aptLength', Double.valueOf(l.aptLength));

                if(l.OpenHour != null) {
                    lGen.writeStringField('OpenHour', String.valueOf(l.OpenHour));
                } else {
                    lGen.writeNullField('OpenHour');
                }

                if(l.CloseHour != null) {
                    lGen.writeStringField('CloseHour', String.valueOf(l.CloseHour));
                } else {
                    lGen.writeNullField('CloseHour');
                }

              // Add Members
                lGen.writeFieldName('Members');
                lGen.writeStartArray();
                for(cMember m : l.Members) {
                    lGen.writeStartObject();

                        if(m.id!=null) {
                            lGen.writeStringField('Id', m.Id);
                        } else {
                            lGen.writeNullField('Id');
                        }

                        if(m.Name!=null) {
                            lGen.writeStringField('Name', m.Name);
                        } else {
                            lGen.writeNullField('Name');
                        }

                        lGen.writeStringField('color', '#6eb3fa');

                    lGen.writeEndObject();
                }
                lGen.writeEndArray();

            lGen.writeEndObject();
        }

        lGen.writeEndArray();

        return lGen.getAsString();
    }

    public static String getLocationSearch(String searchAsk){

        // Setup JSON Generator
        JSONGenerator lGen = JSON.createGenerator(false);
        // Create Array
        lGen.writeStartArray();

        // Loop through locations
        for(cLocation l : buildLocUserList(searchAsk) ) {

            lGen.writeStartObject();

                lGen.writeStringField('Id', l.Id );
                lGen.writeStringField('Name', l.Name);
                lGen.writeStringField('companyNumber', l.companyNumber);
                if(l.aptLength==null) { l.aptLength = 0; }
                lGen.writeNumberField('aptLength', Double.valueOf(l.aptLength));

                if(l.OpenHour != null) {
                    lGen.writeStringField('OpenHour', String.valueOf(l.OpenHour));
                } else {
                    lGen.writeNullField('OpenHour');
                }

                if(l.CloseHour != null) {
                    lGen.writeStringField('CloseHour', String.valueOf(l.CloseHour));
                } else {
                    lGen.writeNullField('CloseHour');
                }

              // Add Members
                lGen.writeFieldName('Members');
                lGen.writeStartArray();
                for(cMember m : l.Members) {
                    lGen.writeStartObject();

                        if(m.id!=null) {
                            lGen.writeStringField('Id', m.Id);
                        } else {
                            lGen.writeNullField('Id');
                        }

                        if(m.Name!=null) {
                            lGen.writeStringField('Name', m.Name);
                        } else {
                            lGen.writeNullField('Name');
                        }

                        lGen.writeStringField('color', '#6eb3fa');

                    lGen.writeEndObject();
                }
                lGen.writeEndArray();

            lGen.writeEndObject();
        }

        lGen.writeEndArray();

        return lGen.getAsString();
    }

    public List<cLocation> getLocationList() {
        return buildLocUserList();
    }

    // Retrieve Appointemnt Colors
    public String getAppointmentColors() {
        String appointmentcolors = '[]';
        dealer__FixedOperationsSettings__c fixedops_settings = new dealer__FixedOperationsSettings__c();
        if(dealer__FixedOperationsSettings__c.getOrgDefaults()!=null) {
            fixedops_settings = dealer__FixedOperationsSettings__c.getOrgDefaults();
            appointmentcolors = fixedops_settings.dealer__Appointment_Color_Chart__c;
        }
        return appointmentcolors;
    }

    // Retrieve Appointemnt Settings
    public Decimal getAppointmentDuration() {
        Decimal aptDuration = 20;
        dealer__FixedOperationsSettings__c fixedops_settings = new dealer__FixedOperationsSettings__c();
        if(dealer__FixedOperationsSettings__c.getOrgDefaults()!=null) {
            fixedops_settings = dealer__FixedOperationsSettings__c.getOrgDefaults();
            aptDuration = fixedops_settings.dealer__Appointment_Durration__c;
        }
        return aptDuration;
    }

    /**
     * getSelectedAdvisors
     * @return String
     * @notes returns a valid json string containing a list of advisors.
     */
    public String getSelectedAdvisors() {

        SchedulerSelection__c saobj = new SchedulerSelection__c();
        SchedulerSelection__c[] saobjs = [SELECT Id, dealer__Selected_Users__c FROM SchedulerSelection__c WHERE dealer__User__c =:UserInfo.getUserId()];
        
        if(saobjs.isEmpty()) {
            return '[]';
        } else {
            saobj = saobjs[0];
        }

        if(saobj.Id==NULL || saobj.Selected_Users__c==NULL) {
            return '[]';
        }

        try {
            JSON.deserializeUntyped(saobj.Selected_Users__c);
        } catch (JSONException ex1) {
            return '[]';
        }

        return saobj.Selected_Users__c;
    }

    // Broken Method, I get a null error on writeStringField
    public String getCalendarEventsJSON() {
        JSONGenerator apts = JSON.createGenerator(false);
        apts.writeStartArray();

        dealer__Service_Appointment__c[] sa = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, dealer__Comments__c, dealer__Mileage__c, dealer__SA__c,
            dealer__Vehicle__c, dealer__Customer__c, dealer__Customer_Contact__c, dealer__Company_Number__c,
            dealer__Waiter__c, dealer__Promised_Completion_Time__c, dealer__Recheck__c, dealer__Requested_Technician__c,
            dealer__Date_Time__c, dealer__Loaner_Requested__c, dealer__Appointment_Time__c, dealer__External_Id__c, dealer__Confirmed__c,
            dealer__VIN__c, dealer__Last_Service__c, dealer__Last_Odometer__c, dealer__Quote_Total__c, dealer__Open_DateTime__c,
            dealer__Email__c, dealer__Advisor_Number__c, dealer__Inspection_Report__c, dealer__Customer_Number__c,
            dealer__Vehicle_VIN__c
            FROM dealer__Service_Appointment__c
             limit 1000];
            //where dealer__Date_Time__c = TODAY limit 500];

        for(dealer__Service_Appointment__c apt : sa) {
          apts.writeStartObject();
            apts.writeStringField('id', apt.Id);
            apts.writeStringField('name', apt.Name);
            //apts.writeStringField('vehicle', apt.dealer__Vehicle__c);
            //apts.writeStringField('quoteTotal', apt.dealer__Quote_Total__c);
            //apts.writeStringField('advisorId', String.isNotEmpty(apt.dealer__SA__c ) ? apt.dealer__SA__c : ' ' );
          apts.writeEndObject();
        }

        apts.writeEndArray();
        return apts.getAsString();
    }

    public String getDefaultLocation(){
        Id locId = getLastLocationId();
        // Setup JSON Generator
        JSONGenerator lGen = JSON.createGenerator(false);
        // Create Array
        lGen.writeStartArray();

        // Loop through locations
        for(cLocation l : buildLocUserList(locId) ) {

            lGen.writeStartObject();

                lGen.writeStringField('Id', l.Id );
                lGen.writeStringField('Name', l.Name);
                lGen.writeStringField('companyNumber', l.companyNumber);
                if(l.aptLength==null) { l.aptLength = 0; }
                lGen.writeNumberField('aptLength', Double.valueOf(l.aptLength));

                if(l.OpenHour != null) {
                    lGen.writeStringField('OpenHour', String.valueOf(l.OpenHour));
                } else {
                    lGen.writeNullField('OpenHour');
                }

                if(l.CloseHour != null) {
                    lGen.writeStringField('CloseHour', String.valueOf(l.CloseHour));
                } else {
                    lGen.writeNullField('CloseHour');
                }

              // Add Members
                lGen.writeFieldName('Members');
                lGen.writeStartArray();
                for(cMember m : l.Members) {
                    lGen.writeStartObject();

                        if(m.id!=null) {
                            lGen.writeStringField('Id', m.Id);
                        } else {
                            lGen.writeNullField('Id');
                        }

                        if(m.Name!=null) {
                            lGen.writeStringField('Name', m.Name);
                        } else {
                            lGen.writeNullField('Name');
                        }

                        lGen.writeStringField('color', '#6eb3fa');

                    lGen.writeEndObject();
                }
                lGen.writeEndArray();

            lGen.writeEndObject();
        }

        lGen.writeEndArray();

        return lGen.getAsString();
    }


    /**
     * getLastLocationId
     * @notes Used by the scheduler page to provide the last location used within the scheduler.
     *
     */
    public String getLastLocationId()
    {

        dealer__FixedOperationsSettings__c config = FixedOperationsSettings__c.getValues( UserInfo.getUserId() );

        if(config==null || config.Default_Scheduler_Location__c == null ) {
            config = new dealer__FixedOperationsSettings__c(
                SetupOwnerId = UserInfo.getUserId(),
                Default_Scheduler_Location__c = myDealershipId
            );
        } 

        return config.Default_Scheduler_Location__c;
    }

    /**
     * getCalendarEvents
     * @notes RemoteAction returning events related to service appointments 
     *
     *
     */
    @RemoteAction
    public static List<Service_Appointment__c> getCalendarEvents() 
    {
        // List of Service Appoinemnts - no filter so not sure how this works entirely.    
        Service_Appointment__c[] sa = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, Comments__c, Mileage__c, SA__c, SA__r.name,
            Vehicle__c,Vehicle__r.name, Customer__c, Customer_Contact__r.name, Company_Number__c,
            Waiter__c, Promised_Completion_Time__c, Recheck__c, Requested_Technician__c,
            Date_Time__c, Loaner_Requested__c, Appointment_Time__c, External_Id__c, Confirmed__c,
            VIN__c, Last_Service__c, Last_Odometer__c, Quote_Total__c, Open_DateTime__c,
            Email__c, Advisor_Number__c, Inspection_Report__c, Customer_Number__c,
            Vehicle_VIN__c
            FROM Service_Appointment__c
                limit 1000];

        return sa;
    }

    // Create new contact remote action - Using lookup by ID for testing...
    @RemoteAction
        public static List<cContact> contactUpdateInsert(String contactJSON){

            // Setup JSON data to read
            Map<String,Object> j = ( Map<String,Object> ) JSON.deserializeUntyped(contactJSON);

            List<cContact> ListDuplicate = new List<cContact>();

            String i = String.valueOf(j.get('existingUserId'));

            // Get Person Account Type
            // Id personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'].Id;

            Account c = new Account (
                // Type = 'Customer - Direct',
                FirstName  =   String.valueOf(j.get('firstName')),
                LastName  =   String.valueOf(j.get('lastName')),
                PersonEmail =   String.valueOf(j.get('email')),
                Phone =   String.valueOf(j.get('phone')),
                PersonMobilePhone =   String.valueOf(j.get('mobile')),
                PersonMailingStreet =   String.valueOf(j.get('mailingStreet')),
                PersonMailingCity =   String.valueOf(j.get('mailingCity')),
                PersonMailingState =   String.valueOf(j.get('mailingState')),
                PersonMailingPostalCode =   String.valueOf(j.get('mailingZip'))
            );

            try{
                if( !String.isBlank(i) ) {
                    system.debug(i);
                    c.Id = i;
                }

                Database.UpsertResult sr = Database.upsert(c, false);
                if (!sr.isSuccess()) {
                    
                    // Insertion failed due to duplicate detected
                    for(Database.Error duplicateError : sr.getErrors()){
                        Datacloud.DuplicateResult duplicateResult = 
                                  ((Database.DuplicateError)duplicateError).getDuplicateResult();
                        System.debug('Duplicate records have been detected by ' + 
                                  duplicateResult.getDuplicateRule());
                        
                        System.debug(duplicateResult.getErrorMessage());
                        
                        Datacloud.MatchResult[] matchResults = duplicateResult.getMatchResults();
                        Datacloud.MatchResult matchResult = matchResults[0];
                        Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();
                        if(matchRecords.size()>0)
                        {
                            account acc = new account(Firstname= '', LastName = 'DuplicateRecords',personEmail='duplicate@error.com');
                            ListDuplicate.add(new cContact(acc));
                        }
                        for (Datacloud.MatchRecord matchRecord : matchRecords) {
                            System.debug('MatchRecord: ' + matchRecord.getRecord());
                            ListDuplicate.add(new cContact(matchRecord.getRecord()));
                        }
                    }
                    //throw new customException('DUPLICATES_DETECTED');
                    return ListDuplicate;
                }
                ListDuplicate.clear();
                ListDuplicate.add(new cContact(c));
                return ListDuplicate;
            } catch(DmlException e) {
                String msg = '';
                for (Integer ii = 0; ii < e.getNumDml(); ii++) {
                    msg += e.getDmlMessage(ii) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(ii));
                }
                //return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
                throw new customException(msg);
            }
        }
        
    //Method to create new account ignoring duplicates.
    @RemoteAction 
    public static List<cContact> createServiceVehicleIgnore(String contactJSON){
        // Setup JSON data to read
            Map<String,Object> j = ( Map<String,Object> ) JSON.deserializeUntyped(contactJSON);

            List<cContact> ListDuplicate = new List<cContact>();

            String i = String.valueOf(j.get('existingUserId'));

            // Get Person Account Type
            // Id personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'].Id;

            Account c = new Account (
                // Type = 'Customer - Direct',
                FirstName  =   String.valueOf(j.get('firstName')),
                LastName  =   String.valueOf(j.get('lastName')),
                PersonEmail =   String.valueOf(j.get('email')),
                Phone =   String.valueOf(j.get('phone')),
                PersonMobilePhone =   String.valueOf(j.get('mobile')),
                PersonMailingStreet =   String.valueOf(j.get('mailingStreet')),
                PersonMailingCity =   String.valueOf(j.get('mailingCity')),
                PersonMailingState =   String.valueOf(j.get('mailingState')),
                PersonMailingPostalCode =   String.valueOf(j.get('mailingZip'))
            );

            try{
                if( !String.isBlank(i) ) {
                    system.debug(i);
                    c.Id = i;
                }
                
                Database.DMLOptions dml = new Database.DMLOptions(); 
                dml.DuplicateRuleHeader.AllowSave = true;
                Database.SaveResult sr2 = Database.insert(c, dml);                
                ListDuplicate.clear();
                ListDuplicate.add(new cContact(c));
                return ListDuplicate;
            }
            catch(DmlException e) {
                String msg = '';
                for (Integer ii = 0; ii < e.getNumDml(); ii++) {
                    msg += e.getDmlMessage(ii) + ' - ' ;
                    // Process exception here
                    System.debug(e.getDmlMessage(ii));
                }
                //return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
                throw new customException(msg);
            }
    }
    // Create new vehicle
    @RemoteAction
        public static cVehicle createServiceVehicle(String vehicleJSON){
            /*
              // Incoming JSON Payload
                {
                  "vehOwnerId": "003E000001Ar0P5IAJ",
                  "vin": "12341234",
                  "licence": "1234541",
                  "odometer": "1234321",
                  "year": "1969",
                  "make": "Chevy",
                  "model": "Camero",
                  "trim": "SS",
                }
             */

            Map<String,Object> j = ( Map<String,Object> ) JSON.deserializeUntyped(vehicleJSON);

            dealer__Service_Vehicle__c v = new dealer__Service_Vehicle__c (
                Name  =   String.valueOf(j.get('year')) + ' ' + String.valueOf(j.get('make')) + ' ' + String.valueOf(j.get('model')),
                dealer__Licence__c  =   String.valueOf(j.get('licence')),
                dealer__VIN__c  =   String.valueOf(j.get('vin')),
                dealer__Model_Code__c =   String.valueOf(j.get('modelCode')),
                dealer__Year__c =   String.valueOf(j.get('year')),
                dealer__Make__c =   String.valueOf(j.get('make')),
                dealer__Carline__c =   String.valueOf(j.get('model')),
                dealer__Trim_Level__c =   String.valueOf(j.get('trim')),

                dealer__Veh_Owner__c  =   String.valueOf(j.get('vehOwnerId'))
            );

            if(String.valueOf(j.get('odometer')) != ''|| String.valueOf(j.get('odometer')) == null ){
                v.dealer__Last_Odometer__c  =   Double.valueOf( (j.get('odometer')) );
            }

            try {
                Insert v;
                return new cVehicle(v);

            } catch(DmlException e) {
                    String msg = '';
                    for (Integer i = 0; i < e.getNumDml(); i++) {
                        msg += e.getDmlMessage(i) + ' - ' ;
                        // Process exception here
                        System.debug(e.getDmlMessage(i));
                    }
                    //return '{"error" : {"type": "DML Exception", "message":"'+msg+'" } }';
                    throw new customException(msg);
            }
        }

    // Setup Vin Decoder remote Action.
    @RemoteAction
        public static Map<String,Object> decodedVin(String vin){
            // Setup respoinse object
            Map<String,Object> v = new Map<String,Object>();
            // Setup result boolean
            v.put('success', null );
            
            if(vin!=null){
               
               if(vin.length() == 17 ) {

                    v.put('dealer__VIN__c', vin );

                    List<String> trims = new List<String>();

                    VINDecoder vd = new VINDecoder();
                    vd.DecodeVIN( String.valueOf( v.get('dealer__VIN__c') ) );
                    VINDecoderDataObject.DecodeData ddat = vd.decodeData;

                    // Is there an error?
                    if(vd.decodeError != ''){
                        v.put('message', vd.decodeError );
                        v.put('success', false );
                    }

                    // is there return data
                    if( ddat.common_data != null  ) {
                        v.put('dealer__Year__c',  ddat.common_data.year);
                        v.put('dealer__Make__c', ddat.common_data.make);
                        v.put('dealer__Carline__c', ddat.common_data.model);

                        for(VINDecoderDataObject.Style sd : ddat.styles) {
                            trims.add(sd.basic_data.trim);
                        }
                        v.put('dealer__Trim_Level__c', trims );
                        v.put('success', true );
                    }


                } else {
                    // Incorrect VIN Error
                    v.put('success', false );
                    v.put('message', 'VIN must be 17 Characters long to decode' );
                }         
            }

            return v;
        }

    @RemoteAction
        public static List<dealer__Service_Job__c> getJobListHistory(String vehicleId) {

            return ServiceHistory.jobList(vehicleId);

        }

    /**
     * updateAdvisorSelectionRemote
     * @param  String [json string of advisor id's]
     * @return Boolean
     * @notes updated to use a lightweight object to store the values, custom setting textarea (255) was insufficient. 
     */
    @RemoteAction
    public static boolean updateAdvisorSelectionRemote(String advIds) {
        // JSON Payload
        /*
            ['123456asdf','123456asdf','123456asdf']
        */

        SchedulerSelection__c saobj = new SchedulerSelection__c();
        SchedulerSelection__c[] saobjs = [SELECT Id, dealer__Selected_Users__c FROM SchedulerSelection__c WHERE dealer__User__c =:UserInfo.getUserId()];        
        if(saobjs.isEmpty()) {
            saobj.User__c=UserInfo.getUserId();
            saobj.Selected_Users__c=advIds;
            try {
                insert saobj;
                return true;
            } Catch(DmlException e) {
                throw new customException(e.getMessage());
            }
        } else {
            saobj=saobjs[0];
            saobj.Selected_Users__c=advIds;
            try {
                update saobj;
                return true;
            } Catch(DmlException e) {
                throw new customException(e.getMessage());
            }
        }
        return null;
    }

    @RemoteAction
    public static boolean updateDefaultLocation(String locId) {

       // validate incoming ID
        //if( !(locId.length() == 15 || locId.length() == 18) && !Pattern.matches('^[a-zA-Z0-9]*$', locId)) {
        //    return false;
        //}

        List<String> newIds = new List<String>();
        //System.debug(ids);

        dealer__FixedOperationsSettings__c config = dealer__FixedOperationsSettings__c.getValues(UserInfo.getUserId());

        if(config==null) {
            config = new dealer__FixedOperationsSettings__c(
                SetupOwnerId = UserInfo.getUserId(),
                dealer__Default_Scheduler_Location__c = locId
            );
        } else {
            config.SetupOwnerId = UserInfo.getUserId();
            config = dealer__FixedOperationsSettings__c.getValues(UserInfo.getUserId());
            config.dealer__Default_Scheduler_Location__c = locId;
        }

        try {
            //Database.Upsertresult result = Database.upsert(config);
            upsert config;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return false;
        }

        return true;
    }

    @RemoteAction
    public static boolean deleteSAline(String lineId) {
        if(lineId==null || lineId=='') {
            return false;
        }

        dealer__Service_Appointment_Line__c l = [SELECT Id,Name FROM dealer__Service_Appointment_Line__c WHERE Id =: lineId LIMIT 1];

        try {
            delete l;
        } catch(System.DMLException e) {
            return false;
        }

        return true;
    }

}