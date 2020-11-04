public class TimeClock_AC {
    public boolean clockin1{get;set;}
    public boolean clockout1{get;set;}

    public boolean LunchStart1{get;set;}
    public boolean LunchEnd1{get;set;}
    
    public dealer__Time_Clock_Line__c currentEntry {get; set;}
    public List<Time_Clock__c> masterTimeClock = new List<Time_Clock__c>();
    public List<cTimeClockLine> timeEntries = new List<cTimeClockLine>();

    public TimeClock_AC(){
        // SHow Clock in Button by Default
        clockin1=true;

        /*
            String SessionID='%'+USerinfo.getSessionId();
            Hours=0;MIns=0;Secs=0;

            ExistingTimeClock=[SELECT ID, Name, Clock_In__c, Clock_Out__c, Session_ID__c, Lunch_Break_End__c, Lunch_Break_Start__c,FROM Time_Clock__c WHERE user__c=:userinfo.getUserId() AND Session_ID__c LIKE :SessionID Order by Createddate desc];  

            if(ExistingTimeClock.size()>0){
                clockin1=false;
                if(ExistingTimeClock[0].Clock_Out__c!=null){
                    LunchStart1=false;
                    clockin1=false; 
                    LunchEnd1=false;
                    clockIN1=true;
                }
                else if(ExistingTimeClock[0].Lunch_Break_End__c!=null){
                    clockout1=true;
                }
                else if(ExistingTimeClock[0].Lunch_Break_Start__c!=null){
                    clockout1=true; 
                    LunchEnd1=true;             
                }
                else{
                    LunchStart1=true;
                    clockout1=true;
                }
                
            }
        */
       
        /** With Child **/
        masterTimeClock = [SELECT ID, Name, (SELECT dealer__In__c, dealer__Out__c, dealer__Type__c, LastModifiedBy.Name, LastModifiedDate FROM Time_Clock_Lines__r WHERE Void__c != true  ORDER BY dealer__In__c ASC) 
            FROM Time_Clock__c 
            WHERE User__c =:userinfo.getUserId() AND CreatedDate = TODAY ORDER BY CreatedDate DESC];

        // Do Any Clock In's exist?
        if(masterTimeClock.size()>0){
            // Hide CLock in
            clockin1=false;

            // Populate timeEntries List
            if( masterTimeClock[0].Time_Clock_Lines__r.size() > 0 ) {

                for(Time_Clock_Line__c te : masterTimeClock[0].Time_Clock_Lines__r) {
                    timeEntries.add( new cTimeClockLine(te,null)  );
                }
            }

            // Does last entry have a clock out?
            Integer lastIndex = masterTimeClock[0].Time_Clock_Lines__r.size() - 1;
            if( lastIndex >= 0 && masterTimeClock[0].Time_Clock_Lines__r.get(lastIndex).dealer__Out__c == null ) {

                // Get Currenty Time Entry
                currentEntry = masterTimeClock[0].Time_Clock_Lines__r.get(lastIndex);

                // Show Clock Out Button
                clockin1 = false;

                if(currentEntry.Type__c == 'on') {
                    // If ON show clockout
                    LunchStart1 = true;
                    LunchEnd1 = false;
                    clockout1 = true;

                } else {
                    // This is an OFF clock 
                    LunchStart1 = false;
                    LunchEnd1 = true;
                    clockout1 = false;
                }

            } else {
                clockin1 = true;

                LunchStart1 = false;
                LunchEnd1 = false;

                clockout1 = false;
            }
        }


        // Calculate Time display Table
        //CaluclateTimes();
        //if(!clockin1) 
        //getDatetimer();
    }

    public List<cTimeClockLine> gettimeEntries(){
        return timeEntries;
    }

    public class cTimeClockLine {
        public Id Id {get;set;}
        public String inTime {get;set;}    
        public String outTime {get;set;}    
        public String type {get;set;}    
        public DateTime lastModDate {get;set;}    
        public String lastModName {get;set;}    
        
        public Decimal timeSince {get;set;}

        public cTimeClockLine(Time_Clock_Line__c dl, Decimal ts){
            if(dl.In__c!=null) {
                inTime = dl.In__c.format('h:mm a');
            }
            if(dl.Out__c!=null) {
                outTime = dl.Out__c.format('h:mm a');
            }
            type = dl.Type__c;
            timeSince = ts;
            lastModDate = dl.LastModifiedDate;
            lastModName = dl.LastModifiedBy.Name;
            Id = dl.id;
        }
    }

    public void clockin(){
        /*
            String SessionID='%'+USerinfo.getSessionId();

            List<Time_Clock__c> timeClockList=[select ID,User__C,Clock_in__c,Clock_out__c,Session_ID__c from Time_Clock__c where Session_ID__c like :SessionID order by Createddate desc];
            System.debug('timeClockList'+timeClockList);
            if(timeClockList.size()>0){
                if(timeClockList[0].Clock_out__c!=null){
                    String OrderNumberString=timeClockList[0].session_id__C.left(4);
                    Integer OrderNumber;
                    if(OrderNumberString.contains('ses')) OrderNumber=Integer.ValueOF(OrderNumberString.right(1))+1;
                    else OrderNumber=1;
                    Time_Clock__c timeclock=new Time_Clock__c(User__c=userinfo.getUserId(),Clock_In__c=System.now());
                    timeclock.Session_ID__c='ses'+String.ValueOf(OrderNumber)+userinfo.getSessionId();
                    insert timeclock;
                    System.debug('>>>>>>>>>'+timeclock);
                    clockin1=false;
                    LunchStart1=true;
                    LunchEnd1=false;
                    clockout1=true;
                }
                
            }
            else{
                Time_Clock__c timeclock=new Time_Clock__c(User__c=userinfo.getUserId(),Clock_In__c=System.now(),Session_ID__c=userinfo.getSessionId());
                insert timeclock;
                System.debug('>>>>>>>>>'+timeclock);
                clockin1=false;
                LunchStart1=true;
                LunchEnd1=false;
                clockout1=true;
            }
        */

        createNewEntry('On');

        //CaluclateTimes();
        //Datetime1='00 Hrs:00 mins : 00 Sec';
    }

    public void clockout(){
        /*
            String SessionID='%'+USerinfo.getSessionId();
            List<Time_Clock__c> ExistingTimeClockOuts=[select ID,Name,Clock_In__c,Clock_Out__c,Lunch_Break_End__c,Lunch_Break_Start__c from Time_Clock__c where user__c=:userinfo.getUserId() and Session_ID__c like :SessionId Order by Createddate Desc];
            ExistingTimeClockOuts[0].Clock_Out__c=System.now();
            update ExistingTimeClockOuts;
            LunchStart1=false;
            
            LunchEnd1=false;
        
        */

        closeCurrentEntry();
    }

    public void lunchStart(){

        // Do we need to clock out first?
        if(currentEntry != null && currentEntry.Out__c == null) {
            currentEntry.dealer__Out__c = System.now();

            update currentEntry;

            // Update In memory entries to match database.
            for(cTimeClockLine l:timeEntries){
                if(l.Id == currentEntry.Id) {
                    l.outTime = currentEntry.Out__c.format('h:mm a');
                }
            }

        }

        // Create new OFF the clock entry.
        createNewEntry('Off');

        LunchStart1 = false;
        LunchEnd1 = true;

        //    String SessionID='%'+USerinfo.getSessionId();
        //    List<Time_Clock__c> ExistingTimeClockOuts=[select ID,Name,Clock_In__c,Clock_Out__c,Lunch_Break_End__c,Lunch_Break_Start__c from Time_Clock__c where user__c=:userinfo.getUserId() and Session_ID__c like :SessionId Order by Createddate Desc];
        //    ExistingTimeClockOuts[0].Lunch_Break_Start__c=System.now();
        //    update ExistingTimeClockOuts;
        //    System.debug('>>>>>>>>'+ExistingTimeClockOuts);
        //    LunchStart1=false;
        //    LunchEnd1=true;
        //    clockout1=true;
        //    CaluclateTimes();   
    }

    public void lunchEnd(){
        
        // Close out current lunch
        closeCurrentEntry();

        // Automatically Clock In
        createNewEntry('On');

        //    String SessionID='%'+USerinfo.getSessionId();
        //    List<Time_Clock__c> ExistingTimeClockOuts=[select ID,Name,Clock_In__c,Clock_Out__c,Lunch_Break_End__c,Lunch_Break_Start__c from Time_Clock__c where user__c=:userinfo.getUserId() and Session_ID__c like :SessionId Order by Createddate Desc];
        //    ExistingTimeClockOuts[0].Lunch_Break_End__c=System.now();
        //    update ExistingTimeClockOuts;
        //    LunchStart1=false;
        //    clockin1=false;
        //    LunchEnd1=false;
        //    clockout1=true;
        //    CaluclateTimes();


    }

    /**
     * Create a new time entry
     * @param String - on/off
     */
    public void createNewEntry(String type) {

        // Setup Header ID
        String masterId = null;
        if(masterTimeClock.size()>0){

            masterId = masterTimeClock[0].Id;

        } else {

            //Create new master Time Clock
            Time_Clock__c masterClock = new Time_Clock__c(
                User__c = userinfo.getUserId()
            );
            insert masterClock;

            // Populate master list
            masterTimeClock.add(masterClock);

            masterId = masterClock.Id;

        }

        // Save Child Time Entry
        if(masterId != null){

            // Create the new entry
            dealer__Time_Clock_Line__c entry = new dealer__Time_Clock_Line__c(
                Time_Clock__c = masterId,
                Type__c = type, // Variable Type of entry
                In__c = System.now()
            );
            insert entry;

            // Set Current entry to newest punch event
            currentEntry = entry;

            // Add to time entries
            timeEntries.add( new cTimeClockLine(currentEntry,null)  );

            // Hide Clock in Button
            clockin1 = false;

            // Only show clock out if there is not an OFF clock period
            if(currentEntry.Type__c == 'On') {
                // Show clock out
                clockout1 = true;

                // Show Meal Start
                LunchStart1 = true;

            } else {
                // THis is an OFF

                clockout1 = false;
                LunchEnd1 = true;

            }

        }

    }

    /**
     * Close the cirrent time clock entry. This method will handle the button display depending on entry type
     */
    public void closeCurrentEntry() {
        System.debug('Close Current: ' + currentEntry);
        if(currentEntry != null) {
            
            currentEntry.dealer__Out__c = System.now();

            update currentEntry;

            // Update In memory entries to match database.
            for(cTimeClockLine l:timeEntries){
                if(l.Id == currentEntry.Id) {
                    l.outTime = currentEntry.Out__c.format('h:mm a');
                }
            }

        } else {
            // Any type of error here?
        }

        if(currentEntry.Type__c == 'On') {
            // Handle ON entries
            clockin1 = true;       
            clockout1 = false;

        } else {
            // Handle OFF
            clockin1 = false;     
            clockout1 = true;   
        }

        LunchStart1 = false;
        LunchEnd1 = false;

    }

    /** METHOD GRAVEYARD **/
    
    public Boolean isClockIntime{get;set;}
    public Boolean isClockOutTime{get;set;}
    public Boolean isLunchStartTime{get;set;}
    public Boolean isLunchEndTime{get;set;}
    public String ClockIntime{get;set;}
    public String ClockOutTime {get;set;}
    public String LunchStartTime {get;set;}
    public String LunchEndTime {get;set;}

    public List<Time_Clock__c> ExistingTimeClock = new List<Time_Clock__c>(); // DEPRECATRED

    //public Integer Hours{get;set;}
    //public Integer Mins{get;set;}
    //public Integer Secs{get;set;}

    /**
     * A Method to Calculate the time difference between two diffeent DateTimes
     * @param  date1 DateTime - The end DateTime of the calculation
     * @param  date2 DateTime - The START time of the calculation
     * @return       String - 
     */
    //public String CalculateBetweenHours(DateTime date1, DateTime date2){
    //        Long Diff=date1.getTime()/1000 ;
    //        Long diff1=date2.getTime()/ 1000;
    //        Integer Hours=Integer.ValueOF(Math.Floor((Diff- Diff1)/3600));
    //        Integer Mins=Integer.valueOf(Math.mod((Diff- Diff1),3600)/60);
    //        //Integer Secs=Integer.ValueOF(Math.ceil(math.mod(math.mod((Diff- Diff1),3600),60)));
    //        return ' ('+String.ValueOf(Hours)+'h '+ String.ValueOf(Mins)+'m'+')';
    //}    

    //public String addZero(Integer value1){
    //    if(value1>12){
    //        Value1=Value1-1;
    //    }
    //    String Value=String.ValueOf(value1);
    //    String time1;
    //    if(Value.length()==1)time1='0'+Value;
    //    else 
    //    time1=Value;
    //    return time1;
        
    //}

    //public String iSPMAM(Integer Hour){
    //    if(Hour>=12) return 'PM';
    //    else return 'AM';
    //}

    //public Void CaluclateTimes(){


    //    // Did results get retreived?
    //    if(masterTimeClock.size()>0){

    //        /** DRYer Logic - DR */
    //        dealer__Time_Clock__c tClock = masterTimeClock[0];

    //        /*
    //            // CLOCK IN
    //            if(tClock.Clock_in__c!=null){
    //                //ClockInTime = tClock.Clock_in__c.format('H:mm a');// Formatted time
    //                isClockIntime = true;
    //            } else { isClockIntime = false; }

    //            // CLOCK OUT
    //            if(tClock.Clock_out__c!=null){
    //                //ClockOutTime = tClock.Clock_out__c.format('H:mm a'); // Formatted time
    //                //ClockOutTime += CalculateBetweenHours(tClock.clock_out__c, ( tClock.Lunch_Break_End__c != null ) ? tClock.Lunch_Break_End__c : tClock.clock_in__c ); // Diff Calc
    //                isClockOutTime = true;
    //            } else { isClockOutTime = false; }

    //            // Lunch Start
    //            if(tClock.Lunch_Break_Start__c!=null){
    //                //LunchStartTime = tClock.Lunch_Break_Start__c.format('H:mm a');// Formatted time
    //                //LunchStartTime += CalculateBetweenHours(tClock.Lunch_Break_Start__c,tClock.clock_in__c);
    //                isLunchStartTime = true;
    //            } else { isLunchStartTime = false; }

    //            // Lunch End
    //            if(tClock.Lunch_Break_End__c!=null){
    //                //LunchEndTime = tClock.Lunch_Break_End__c.format('H:mm a');// Formatted time
    //                //LunchEndTime += CalculateBetweenHours(tClock.Lunch_Break_end__c,tClock.Lunch_Break_Start__c);
    //                IsLunchEndTime = true;
    //            } else { IsLunchEndTime = false; }

    //        */
    //    }

        

    //        // Set Session ID
    //        String SessionID='%'+USerinfo.getSessionId();

    //        // Get existing Time Clock objects from Database
    //        List<Time_Clock__c> timeClockList=[select ID,Lunch_Break_End__c,Lunch_Break_Start__c,User__C,Clock_in__c,Clock_out__c,Session_ID__c from Time_Clock__c where Session_ID__c like :SessionID order by Createddate desc];

    //        // Did results get retreived?
    //        if(timeClockList.size()>0){
                
    //        if(timeClockList[0].Clock_out__c!=null){
    //            // Don' Display any time.
    //            ClockIntime=addZero(timeClockList[0].Clock_in__c.hour())+':'+timeClockList[0].Clock_in__c.minute()+' '+iSPMAM(timeClockList[0].Clock_in__c.hour());
    //            ClockOutTime=addZero(timeClockList[0].Clock_out__c.hour())+':'+timeClockList[0].Clock_out__c.minute()+' '+iSPMAM(timeClockList[0].Clock_out__c.hour())+CalculateBetweenHours(timeClockList[0].clock_out__c,timeClockList[0].clock_in__c);
    //            if(timeClockList[0].Lunch_Break_End__c!=null)LunchEndTime=addZero(timeClockList[0].Lunch_Break_End__c.hour())+':'+timeClockList[0].Lunch_Break_End__c.minute()+' '+iSPMAM(timeClockList[0].Lunch_Break_End__c.hour())+CalculateBetweenHours(timeClockList[0].Lunch_Break_End__c,timeClockList[0].clock_in__c);
    //            if(timeClockList[0].Lunch_Break_Start__c!=null) LunchStartTime=addZero(timeClockList[0].Lunch_Break_Start__c.hour())+':'+timeClockList[0].Lunch_Break_Start__c.minute()+' '+iSPMAM(timeClockList[0].Lunch_Break_Start__c.hour())+CalculateBetweenHours(timeClockList[0].Lunch_Break_Start__c,timeClockList[0].clock_in__c);
    //            IsLunchEndTime=true;
    //            isClockIntime=true;
    //            isClockOutTime=true;
    //            isLunchStartTime=true;
    //        }

    //        else if(timeClockList[0].Lunch_Break_End__c!=null){
    //            //Display Except Clockout
    //            LunchEndTime=addZero(timeClockList[0].Lunch_Break_End__c.hour())+':'+timeClockList[0].Lunch_Break_End__c.minute()+' '+iSPMAM(timeClockList[0].Lunch_Break_End__c.hour())+CalculateBetweenHours(timeClockList[0].Lunch_Break_end__c,timeClockList[0].clock_in__c);
    //            ClockIntime=addZero(timeClockList[0].Clock_in__c.hour())+':'+timeClockList[0].Clock_in__c.minute()+' '+iSPMAM(timeClockList[0].Clock_in__c.hour());
    //            LunchStartTime=addZero(timeClockList[0].Lunch_Break_Start__c.hour())+':'+timeClockList[0].Lunch_Break_Start__c.minute()+' '+iSPMAM(timeClockList[0].Lunch_Break_Start__c.hour())+CalculateBetweenHours(timeClockList[0].Lunch_Break_Start__c,timeClockList[0].clock_in__c);
    //            isClockIntime=true;
    //            IsLunchEndTime=true;
    //            isLunchStartTime=true;
    //            isClockOutTime=false;
    //        }

    //        else if(timeClockList[0].Lunch_Break_Start__c!=null){
    //            ClockIntime=addZero(timeClockList[0].Clock_in__c.hour())+':'+timeClockList[0].Clock_in__c.minute()+' '+iSPMAM(timeClockList[0].Clock_in__c.hour());
    //            LunchStartTime=addZero(timeClockList[0].Lunch_Break_Start__c.hour())+':'+timeClockList[0].Lunch_Break_Start__c.minute()+' '+iSPMAM(timeClockList[0].Lunch_Break_Start__c.hour())+CalculateBetweenHours(timeClockList[0].Lunch_Break_Start__c,timeClockList[0].clock_in__c);
    //            isClockIntime=true;
    //            isLunchStartTime=true;
    //            IsLunchEndTime=false;
    //            isClockOutTime=false;
                
    //        }

    //        else if(timeClockList[0].Clock_in__c!=null){
    //            System.debug('>>>timeClockList'+timeClockList[0].Clock_in__c.hour()+'>>>'+timeClockList[0].Clock_in__c.hourgmt());
    //            ClockIntime=addZero(timeClockList[0].Clock_in__c.hour())+':'+timeClockList[0].Clock_in__c.minute()+' '+iSPMAM(timeClockList[0].Clock_in__c.hour());
    //            isClockIntime=true;
    //            IsLunchEndTime=false;
    //            isClockOutTime=false;
    //            isLunchStartTime=false;
    //        }
                
                
    //        }

        
    //}


        
        //public String Datetime1;
        //public Void getDatetimer(){
        //    if(!clockin1) {
        //        Time_Clock__c   ExistingTimeClockOuts=[select ID,Name,Clock_In__c,Clock_Out__c,Lunch_Break_End__c,Lunch_Break_Start__c from Time_Clock__c where user__c=:userinfo.getUserId() and Session_ID__c=:userinfo.getSessionId()];
        //        Long Diff=System.Now().getTime()/1000 ;
        //        Long diff1=ExistingTimeClockOuts.Clock_In__c.getTime()/ 1000;
        //        Hours=Integer.ValueOF(Math.Floor((Diff- Diff1)/3600));
        //        Mins=Integer.valueOf(Math.mod((Diff- Diff1),3600)/60);
        //        Secs=Integer.ValueOF(Math.ceil(math.mod(math.mod((Diff- Diff1),3600),60)));
        //    }
            
        //}

}