public with sharing class TechTimeEntry_EXT {
    
    public dealer__Technician_Job_Time__c tt;
    public dealer__Service_Repair_Order__c ro;
    public dealer__Service_Job__c[] jl;
    public techActualTime timeEntry {get;set;}
    public dealer__Technician_Job_Time__c ttime {get;set;}
    public List<dealer__Technician_Job_Time__c> times {get;set;}
    public String timeTechTime {get;set;}

    public String selectedTech {get;set;}
    public List<SelectOption> getTechItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '---'));

        for(Dealer_Location_User__c dlu : [SELECT Id, Name, User__c, User__r.FirstName, User__r.LastName 
                                                FROM Dealer_Location_User__c 
                                                WHERE Dealer_Location__c =:ro.Company__c 
                                                AND Technician__c = true
                                                ORDER BY User__r.LastName ASC]) {
            options.add(new SelectOption(dlu.User__c, dlu.User__r.FirstName + ' ' + dlu.User__r.LastName));
        }

        return options;
    }

    public Id recordId {get;set;}
    
    public String jobId {
        get;
        set {
            jobId = value;
        }
    }

    public dealer__FixedOperationsSettings__c fixedOpsSettings {
        get {
            return dealer__FixedOperationsSettings__c.getOrgDefaults();
        }
        set;
    }    
    
    public TechTimeEntry_EXT(ApexPages.StandardController controller) {
        
        this.tt = (dealer__Technician_Job_Time__c)controller.getRecord();
        if(ApexPages.CurrentPage().getParameters().get('ro') != '' && ApexPages.CurrentPage().getParameters().get('ro') != null) {
            this.ro = QueryRO(ApexPages.CurrentPage().getParameters().get('ro'));    
        }

        selectedTech = '';

        timeEntry = new techActualTime(); 

        ttime = new dealer__Technician_Job_Time__c();
        times = new List<dealer__Technician_Job_Time__c>();

        // Load TechTimes 
        for(dealer__Service_Job__c j : [SELECT Id, dealer__Service_Repair_Order__c 
                                            FROM dealer__Service_Job__c 
                                            Where dealer__Service_Repair_Order__c =:this.ro.Id
                                            Order by dealer__Line_Number__c ASC
                                            Limit 50]) {
            times.add(new dealer__Technician_Job_Time__c(dealer__Service_Job_Line__c=j.Id));
        }

    }
    
    public dealer__Service_Repair_Order__c getRo() {
        return this.ro;
    }
    
    public dealer__Service_Job__c[] getJobLines() {
        return jobLines(ro.Id);
    }
    
    public dealer__Parts_Invoice_Line__c[] getPartsLines() {
        return partsLines(ro.Id);
    }
    
    public dealer__Service_Repair_Order__c QueryRO(String roId) {
        return [SELECT Id, dealer__Comments__c, dealer__Company_Number__c, dealer__Create_Date_Time__c, dealer__Mileage_In__c,dealer__Mileage_Out__c, dealer__Invoiced_Date_Time__c,
                dealer__Promise_Date__c, dealer__RO_Number__c, dealer__Service_Advisor__c,dealer__Vehicle__c, dealer__Tag__c, dealer__Status__c,
                dealer__Waiting__c, dealer__Promise_Time__c, Name, dealer__Company__c, CreatedById, CreatedDate
                FROM dealer__Service_Repair_Order__c 
                WHERE Id = :roId limit 1];
    }
    
    public dealer__Service_Job__c[] jobLines(Id rId) {
        return [Select Id, Name, Book_Time__c, Stat__c, Line_Number__c, CustomerConcern__c, Cause__c, Correction__c,
                Op_Code__c, Labor_Type__c, Currently_Active__c,
                    (Select Id, Name, Start_Time__c, Diag_Repair__c, Technician__c, Time_Punch_Notes__c,
                      End_Time__c, Flat_Rate_Time__c, Technician__r.Name, Elapsed_Time_Minutes__c, Actual_Time__c, Date__c, Actual_Time_Entry__c
                      from Technician_Job_Times__r
                      ORDER BY Start_Time__c ASC NULLS LAST) 
                 from Service_Job__c
                 where Service_Repair_Order__c = :rId
                 order by Line_Number__c asc];
    }

    public dealer__Parts_Invoice_Line__c[] partsLines(Id rId) {
        return [Select Id, dealer__Service_Job_Line_Number__c, dealer__Quantity_Sold__c, dealer__Quantity_Ordered__c, dealer__Pay_Type__c, 
        dealer__Part_Number__c, dealer__Part_Description__c
        from dealer__Parts_Invoice_Line__c
        where dealer__Service_Repair_Order__c = :rId
        order by dealer__Service_Job_Line_Number__c asc];
    }
    
    public PageReference startJobDiag() {
        //dealer__Technician_Job_Time__c[] techtimeList = [Select Id,Name from dealer__Technician_Job_Time__c where dealer__Service_Job_Line__c =:jobId limit 1];
        if(selectedTech==null || selectedTech=='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must select a technician to start diagnostic time'));
            return null;
        }

        dealer__Technician_Job_Time__c techtime = new dealer__Technician_Job_Time__c();
        techtime.Name='TST'+this.ro.Name;
        techtime.dealer__Service_Job_Line__c = jobId;
        techtime.dealer__Start_Time__c = datetime.now();
        techtime.dealer__Technician__c = selectedTech;
        techtime.dealer__Diag_Repair__c= 'Diag';

        try {
            insert techtime;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }

        PageReference readPage =  Page.techtimeentry;
        readPage.getParameters().put('ro', this.ro.Id);
        readPage.setRedirect(true);
        
        return readPage;
    }

    public PageReference saveHeader()
    {

        // Sanity check
        if((ro.Mileage_Out__c!=null && ro.Mileage_In__c!=null) && (ro.Mileage_Out__c < ro.Mileage_In__c)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Mileage Out may not be less than Mileage In'));
            return null;            
        }

        try {
            update ro;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        return null;
    }
    
    public PageReference startJobRepair() {
        
        if(selectedTech==null || selectedTech=='') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must select a technician to start repair time'));
            return null;
        }

        dealer__Technician_Job_Time__c techtime = new dealer__Technician_Job_Time__c();
        techtime.Name='TT-'+this.ro.Name;
        techtime.dealer__Service_Job_Line__c = jobId;
        techtime.dealer__Start_Time__c = datetime.now();
        techtime.dealer__Technician__c = selectedTech;
        techtime.dealer__Diag_Repair__c= 'Repair';

        try { 
            insert techtime;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        PageReference readPage =  Page.techtimeentry;
        readPage.getParameters().put('ro', this.ro.Id);
        readPage.setRedirect(true);
        
        return readPage;
    }
    
    public PageReference endJobClock() {
        dealer__Technician_Job_Time__c openTime = [SELECT Id, Name , dealer__Start_Time__c, dealer__End_Time__c, dealer__Date__c, Actual_Time__c
                                                    	 FROM dealer__Technician_Job_Time__c
                                                         WHERE dealer__Service_Job_Line__c =:jobId 
                                                         AND dealer__Start_Time__c != null
                                                         AND dealer__End_Time__c = null
                                                         LIMIT 1]; 
        openTime.dealer__End_Time__c = datetime.now();
        
        //Populate date field with logged tech time date to be displayed in Job line
        Date myDate = date.newinstance( openTime.dealer__End_Time__c.year(),  openTime.dealer__End_Time__c.month(),  openTime.dealer__End_Time__c.day());
        openTime.dealer__Date__c = myDate;
        
        //Populate date field with logged tech time date to be displayed in Job line
        openTime.dealer__Actual_Time_Entry__c = Decimal.valueOf(openTime.dealer__End_Time__c.getTime() - openTime.dealer__Start_Time__c.getTime()).divide(60 * 60 * 1000, 2);
        
        try {
            update openTime;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }

        PageReference readPage =  Page.techtimeentry;
        readPage.getParameters().put('ro', this.ro.Id);
        readPage.setRedirect(true);
        
        return readPage;                                               
    }

    public PageReference addActualTime() {

        System.debug(times);
        System.debug(timeTechTime);
        /*
        dealer__Technician_Job_Time__c t = new dealer__Technician_Job_Time__c();
        t.dealer__Date__c = ttime.dealer__Date__c;
        t.dealer__Actual_Time_Entry__c = ttime.dealer__Actual_Time_Entry__c;
        t.dealer__Technician__c = ttime.dealer__Technician__c;
        t.dealer__Service_Job_Line__c = jobId;

        // Get relevant time clock information
        dealer__Time_Clock__c[] ptime = [Select Id from dealer__Time_Clock__c 
                                            where dealer__User__c =: t.dealer__Technician__c
                                            and dealer__Date__c =: t.dealer__Date__c  
                                            limit 1];
        if(ptime.size()==1) {
            t.dealer__Time_Clock__c = ptime[0].Id;
        }

        try {
            insert t;
        } catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;
        }

        ttime = new dealer__Technician_Job_Time__c();
        */

        return null;
    }

    public class techActualTime {
        public Date actualDate {get;set;}
        public User actualTechnician {get;set;}
        public Decimal actualAmount {get;set;}
    }
    
    public String getServiceHistoryJSON() {
        return ServiceHistory.serviceHistoryJSON(ro.dealer__Vehicle__c);
    }
    
    /* 
    |
    |   Remote Actions
    |
    */
    
    @remoteAction
    public static boolean saveJobStatus(String linestat) {
        String[] dat = linestat.split('-');
        
        if(dat[0]=='') { return false; }
        
        List<dealer__Service_Job__c> jobstat = [Select Id, dealer__Stat__c from dealer__Service_Job__c where Id =:dat[0] limit 1];
        if(jobstat.size() != 1) { return false; }
        
        jobstat[0].dealer__Stat__c=dat[1];
        update jobstat;
        return true;
    }
    
    @remoteAction
    public static boolean saveFlatHours(String linedata) {
        String[] dat = linedata.split('-');
        if(dat[0]=='') { return false; }
        List<dealer__Technician_Job_Time__c> frt = [Select Id, dealer__Flat_Rate_Time__c, dealer__Available_Flat_Rate_Time__c, dealer__Service_Job_Line__c
                                                        from dealer__Technician_Job_Time__c
                                                        where Id = :dat[0] 
                                                        limit 1];   
        
        Decimal addHours = Decimal.valueOf(dat[1]);
        Decimal sumHours = frt[0].dealer__Available_Flat_Rate_Time__c;
        
        if(addHours > sumHours) {
            return false;
        }
        
        
        // Hours are tied to actual times                                   
        frt[0].dealer__Flat_Rate_Time__c = Decimal.valueOf(dat[1]);
        update frt[0];
        
        /*
        dealer__Technician_Job_Time__c ttAdd = new dealer__Technician_Job_Time__c(  dealer__Service_Job_Line__c=frt[0].dealer__Service_Job_Line__c,
                                                                                    dealer__Flat_Rate_Time__c=addHours,
                                                                                    dealer__Technician__c=UserInfo.getUserId()
                                                                                  );
        insert ttAdd;
        */
        return true;                                            
    }

    @remoteAction
    public static dealer__Technician_Job_Time__c setTechTime(String s) {
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(s);

        // Fix invalid date format
        String[] date_parts = String.valueOf(m.get('date')).split('-');
        Integer year     =   Integer.valueOf(date_parts[0]);
        Integer month    =   Integer.valueOf(date_parts[1]);
        Integer day      =   Integer.valueOf(date_parts[2]);

        dealer__Technician_Job_Time__c techtimeentry = new dealer__Technician_Job_Time__c(
            Name='TT#'+String.valueOf(m.get('roNumber')),
            dealer__Date__c=date.newInstance(year, month, day),
            dealer__Service_Job_Line__c=String.valueOf(m.get('jobId')),
            dealer__Technician__c=String.valueOf(m.get('techId')),
            dealer__Actual_Time_Entry__c=Decimal.valueOf(String.valueOf(m.get('actual')))


        );

        try {
            insert techtimeentry;
        } catch(DmlException e) {
            return null;
        }

        return techtimeentry;
    }
    
    @remoteAction
    public static boolean saveCCCLine(String jsOBJ) {
        System.debug(jsOBJ);
        if(jsOBJ=='') {
            return false;
        }
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(jsOBJ);

        if(m.get('Id') != null && m.get('Id') !='' && m.get('CCC') != null && m.get('CCC') != '' && m.get('Type') != null && m.get('Type') != '' ) {
            String cccId = String.valueOf(m.get('Id'));
            String cccType=String.valueOf(m.get('Type'));
            List<dealer__Service_Job__c> jl = [Select Id, dealer__Cause__c, dealer__CustomerConcern__c, dealer__Correction__c from dealer__Service_Job__c where Id =:cccId limit 1];
            if(jl.size() == 1) {
                if(cccType=='cause') {
                    jl[0].dealer__Cause__c=String.valueOf(m.get('CCC'));
                } else if(cccType=='concern') {
                    jl[0].dealer__CustomerConcern__c=String.valueOf(m.get('CCC'));
                } else if(cccType=='correction') {
                    jl[0].dealer__Correction__c=String.valueOf(m.get('CCC'));
                }
                
                update jl[0];
                return true;
            } else {
                return false;
            }   
        } else {
            return false;
        }
        
        return false;
    }

    @remoteAction
    public static boolean saveTechToLine(String tId)
    {
        
        String[] dat = tId.split('-');
        if(dat[0]=='' || dat[1]=='') { return false; }        

        try {
            update new Technician_Job_Time__c(Id=dat[0], Technician__c=dat[1]);
        } Catch(DmlException e) {
            System.debug('Unable to set Tech on Line');
            return false;
        }

        return true;
    }
    
    public static Time getElapsedTime(Time startTime, Time endTime){
        if(startTime == null || endTime == null)
            return Time.newInstance(0, 0, 0, 0);
    
        Integer elapsedHours = endTime.hour() - startTime.hour();
        Integer elapsedMinutes = endTime.minute() - startTime.minute();
        Integer elapsedSeconds = endTime.second() - startTime.second();
        Integer elapsedMiliseconds = endTime.millisecond() - startTime.millisecond();
    
        return Time.newInstance(elapsedHours, elapsedMinutes, elapsedSeconds, elapsedMiliseconds);
	}
}