public with sharing class SalesWorkPlanPDF {
    
    public Integer ups = 0;
    public Integer turns = 0;
    public Integer writeups = 0;
    public Integer demos = 0;
    public Integer sales = 0;
    
    public Integer walkins = 0;
    public Integer phonepops = 0;
    public Integer emails = 0;
    public Integer bebacks = 0;
    
    public double totalsales = 0;
    
    public Set<id> salesLeadIds = new Set<id>();
    public Set<id> salesHistoryIds = new Set<id>();
    public Set<id> customerIds = new Set<id>();
    public Set<id> serviceIds = new Set<id>();
    
    public String userID {
        get {
            return ApexPages.currentPage().getParameters().get('Id');
        }
        public set;
    }
    
    public String getUserName() {
        User u = [Select Name from User where Id = :userID limit 1];
        return u.Name;
    }
    
    public SalesWorkPlanPDF() {
        this.SalesStats();
        this.TaskIDs();
    }
    
    public void TaskIDs() {
        
        List<Task> tsk = [Select Id, Subject, Description, WhatId from Task where OwnerId = :userID and IsClosed = false and ActivityDate <= today and WhatId != null];
        System.debug(tsk);
        Schema.DescribeSObjectResult sUp = dealer__Sales_Up__c.SObjectType.getDescribe();
        Schema.DescribeSObjectResult cDeal = dealer__Deal__c.SObjectType.getDescribe();
        Schema.Describesobjectresult Cust  = Contact.SObjectType.getDescribe();
        Schema.Describesobjectresult sApt  = dealer__Service_Appointment__c.SObjectType.getDescribe();
        
        for(Task allTasks : tsk) {
            String sId = String.valueOf(allTasks.WhatId);
            System.debug(sId);
            if(sId.startsWith(sUp.getKeyPrefix())) {
                this.salesLeadIds.add(allTasks.WhatId);
            }
            // Sold FollowUp
            if(sId.startsWith(cDeal.getKeyPrefix())) {
                this.salesHistoryIds.add(allTasks.WhatId);
            }
            // Customer Follow Up
            if(sId.startsWith(Cust.getKeyPrefix())) {
                this.customerIds.add(allTasks.WhatId);
            }
            // Service Appointment Follow Up
            if(sId.startsWith(sApt.getKeyPrefix())){
                this.serviceIds.add(allTasks.WhatId);
            }
            
        }
        
        System.debug(salesLeadIds);
        System.debug(salesHistoryIds);
        
    }
    
    public List<dealer__Sales_Up__c> SalesLeads() {
                
        return [Select d.dealer__Year_To__c, d.dealer__Year_High__c, d.dealer__Write_Up__c, d.dealer__VIN__c, d.dealer__Trade_Year__c, d.dealer__Trade_VIN__c, 
                        d.dealer__Trade_Model__c, d.dealer__Trade_Mileage__c, d.dealer__Trade_Make__c, d.dealer__Trade_Comments__c, d.dealer__Timeframe__c, 
                        d.dealer__Source__c, d.dealer__Shopper__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, d.dealer__Sale_Date__c, 
                        d.dealer__Price_Low__c, d.dealer__Price_High__c, d.dealer__Present_Vehicle__c, d.dealer__NUO__c, d.dealer__Model__c, d.dealer__Make__c, 
                        d.dealer__Lead_Type__c, d.dealer__Lead_Status__c, d.dealer__Lead_Origination_Service__c, d.dealer__Internet_Lead_Request_Time__c, 
                        d.dealer__Internet_Customer__c, d.dealer__Greet_Meet__c, d.dealer__Finance_Method__c, d.dealer__Desk_Manager_User__c, 
                        d.dealer__Comments__c, d.dealer__Color_Preference_Int__c, d.dealer__Color_Preference_Ext__c, d.dealer__Co_Buyer__c, d.dealer__Co_Buyer_Contact__c, 
                        d.dealer__Car_Deal__c, d.dealer__CCC_Rep__c, d.dealer__Buyer_Contact__c, d.dealer__Buy_or_Lease__c, d.dealer__Assign_Follow_Up_To__c, 
                        d.OwnerId, d.Name, d.LastModifiedById, d.LastActivityDate, d.Id, d.CreatedDate, d.CreatedById, d.dealer__Salesperson_1__r.Name,
                        d.dealer__Salesperson_2__r.Name, d.dealer__Buyer_Contact__r.Phone, d.dealer__Buyer_Contact__r.HomePhone,
                        d.dealer__Buyer_Contact__r.MobilePhone, d.dealer__Buyer_Contact__r.OtherPhone, d.dealer__Buyer_Contact__r.Email, d.dealer__Buyer_Contact__r.MailingStreet,
                        d.dealer__Buyer_Contact__r.MailingCity, d.dealer__Buyer_Contact__r.MailingState, d.dealer__Buyer_Contact__r.MailingPostalCode,
                        d.dealer__Desired_Stock_Num__c,
                        (Select Id, ActivityDate, Description, Status, Subject, OwnerId, CallDisposition, dealer__Quick_Note__c From Tasks order by ActivityDate desc)
                    From dealer__Sales_Up__c d
                    where d.Id in :salesLeadIds
                    order by CreatedDate asc
                    limit 250];
                    
                    /*  Old Where Clause
                    Customer_Account__r.OwnerId = :userID 
                    and Is_Lead_Open__c = 1
                    and ( Salesperson_user_1__c = :userID or Salesperson_user_2__c = :userID )
                    order by CreatedDate desc
                    limit 250
                    */
        
    }
    
    
    public List<dealer__Deal__c> SoldFollowUp() {
        
        return [Select d.dealer__Vehicle__r.dealer__Year__c, d.dealer__Vehicle__r.dealer__VIN__c, d.dealer__Vehicle__r.dealer__Stock_Number__c, 
                        d.dealer__Vehicle__r.dealer__Model__c, d.dealer__Vehicle__r.dealer__Make__c, d.dealer__Vehicle__r.dealer__Exterior_Color__c, 
                        d.dealer__Vehicle__c, d.dealer__Stock_Number__c, d.dealer__Status__c, d.dealer__Salesperson_4__c, d.dealer__Salesperson_3__c, 
                        d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, d.dealer__F_I_Manager__c, d.dealer__Desk_Manager__c, d.dealer__Deal_Type__c, 
                        d.dealer__Deal_Date__c, d.dealer__Co_Buyer_Contact__r.EmailBouncedDate, 
                        d.dealer__Co_Buyer_Contact__r.EmailBouncedReason, d.dealer__Co_Buyer_Contact__r.Birthdate, d.dealer__Co_Buyer_Contact__r.Email, 
                        d.dealer__Co_Buyer_Contact__r.HomePhone, d.dealer__Co_Buyer_Contact__r.MobilePhone, d.dealer__Co_Buyer_Contact__r.Phone, d.dealer__Co_Buyer_Contact__r.OtherPhone, 
                        d.dealer__Co_Buyer_Contact__r.MailingPostalCode, d.dealer__Co_Buyer_Contact__r.MailingState, d.dealer__Co_Buyer_Contact__r.MailingCity, 
                        d.dealer__Co_Buyer_Contact__r.MailingStreet, d.dealer__Co_Buyer_Contact__r.FirstName, d.dealer__Co_Buyer_Contact__r.LastName, 
                        d.dealer__Co_Buyer_Contact__r.AccountId, d.dealer__Co_Buyer_Contact__r.Id, d.dealer__Co_Buyer_Contact__c, d.dealer__Co_Buyer__c,
                        d.dealer__Buyer_Contact__r.EmailBouncedDate, d.dealer__Buyer_Contact__r.EmailBouncedReason, 
                        d.dealer__Buyer_Contact__r.Birthdate, d.dealer__Buyer_Contact__r.Email, d.dealer__Buyer_Contact__r.OtherPhone, d.dealer__Buyer_Contact__r.Phone, 
                        d.dealer__Buyer_Contact__r.HomePhone, d.dealer__Buyer_Contact__r.MobilePhone, d.dealer__Buyer_Contact__r.MailingPostalCode, 
                        d.dealer__Buyer_Contact__r.MailingState, d.dealer__Buyer_Contact__r.MailingCity, d.dealer__Buyer_Contact__r.MailingStreet, 
                        d.dealer__Buyer_Contact__r.FirstName, d.dealer__Buyer_Contact__r.LastName, d.dealer__Buyer_Contact__r.AccountId, d.dealer__Buyer_Contact__c, 
                        d.OwnerId, d.Name, d.LastActivityDate, d.Id, d.dealer__Split__c,d.dealer__Salesperson_1__r.Name, d.dealer__Salesperson_2__r.Name,
                        d.dealer__Year__c, d.dealer__Make__c, d.dealer__Model__c,
                        (Select Id, ActivityDate, Description, Status, Subject, OwnerId, CallDisposition, dealer__Quick_Note__c From Tasks order by ActivityDate desc)
                     From dealer__Deal__c d
                    Where d.Id in :this.salesHistoryIds 
                    limit 200 ];
        
    }
    
    public List<Contact> CustomerFollowUp() {
        return [Select c.Phone, c.OwnerId, c.MobilePhone, c.MailingStreet, c.MailingState, c.MailingPostalCode, 
                        c.MailingCity, c.LastName, c.LastActivityDate, c.Id, c.HomePhone, c.FirstName, c.EmailBouncedReason, c.EmailBouncedDate, 
                        c.Email, c.Description, c.CreatedDate, c.Birthdate, c.AccountId, c.OtherPhone,
                    (Select Id, ActivityDate, Description, Status, Subject, OwnerId, CallDisposition, dealer__Quick_Note__c From Tasks order by ActivityDate desc)
                    From Contact c
                    Where c.Id in :customerIds
                    limit 200];
    }
    
    public List<dealer__Service_Appointment__c> ServiceAppt() {
        return [Select d.dealer__Waiter__c, d.dealer__Vehicle__c, d.dealer__SA__c, d.dealer__Mileage__c, d.dealer__Customer_Contact__r.Email, d.dealer__Customer_Contact__r.Name,
                        d.dealer__Customer_Contact__r.HomePhone, d.dealer__Customer_Contact__r.MobilePhone, d.dealer__Customer_Contact__r.FirstName, 
                        d.dealer__Customer_Contact__r.LastName, d.dealer__Customer_Contact__c, d.dealer__Company_Number__c, d.dealer__Comments__c, 
                        d.OwnerId, d.Name, d.LastModifiedDate, d.LastActivityDate, d.Id, d.CreatedDate, d.dealer__Date_Time__c,
                        (Select Name, dealer__Complaint__c, dealer__Pay_Type__c From dealer__Service_Appointment_Lines__r) 
                From dealer__Service_Appointment__c d 
                where d.Id in : serviceIds
                limit 200];
    }
    
    
    public void SalesStats() {
        if(userID != null && userID != '') {
        List<dealer__Traffic_Log__c> traffic = [Select d.dealer__Write_Up__c, d.dealer__Type__c, d.dealer__Sold__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, 
                                            d.dealer__On_Demo__c, d.dealer__Is_New_Up__c 
                                        From dealer__Traffic_Log__c d
                                        Where dealer__Date_In__c = THIS_MONTH
                                        and dealer__Salesperson_1__c = :userID
                                        limit 1000];
                                        
        List<dealer__Deal__c> salesList = [Select Id, dealer__Split__c 
                                                From dealer__Deal__c
                                                where (dealer__Salesperson_1__c = :userID or dealer__Salesperson_2__c = :userID)
                                                and Deal_Date__c = THIS_MONTH
                                                limit 1000];
        for(dealer__Deal__c s : salesList) {
            this.totalsales = this.totalsales + s.dealer__Split__c;
        }                                       
            
        /*                                
        for(dealer__Traffic_Log__c t : traffic) {
            System.debug('inside traffic list');
            if(t.dealer__Is_New_Up__c == 1 && t.dealer__Type__c != 'Phone Up') {
                this.ups++;
                System.debug('New Up if entered...' + this.ups);
            }
            if(t.dealer__Salesperson_2__c != null) {
                this.turns++;
            }
            if(t.dealer__On_Demo__c == true) {
                this.demos++;
            }
            if(t.dealer__Write_Up__c == true) {
                this.writeups++;
            }
            System.debug('Type'+t.dealer__Type__c);
            // Type of traffic
            
            if(t.dealer__Type__c == 'Walk In') {
                this.walkins++;
            }
            
            if(t.dealer__Type__c == 'Phone Up') {
                this.phonepops++;
            }
            if(t.dealer__Type__c == 'Email') {
                this.emails++;
            }
            if(t.dealer__Type__c == 'Be-Back') {
                this.bebacks++;
            }
            
        } 
        */
        
            // Calculate Sales Stats based on Leads
            for(dealer__Sales_Up__c sup : [Select d.dealer__Write_Up__c, d.dealer__Salesperson_2__c, d.dealer__Salesperson_1__c, d.dealer__Lead_Type__c, d.dealer__Lead_Status__c, 
                                                d.dealer__Demo__c, d.Id 
                                                From dealer__Sales_Up__c d
                                                where d.CreatedDate = THIS_MONTH
                                                and d.dealer__Salesperson_1__c = :userID 
                                                limit 200]) {
                                            
                if(sup.dealer__Demo__c==true) { this.demos++; }
                if(sup.dealer__Write_Up__c==true) { this.writeups++; }
                if(sup.dealer__Salesperson_2__c!=null) { this.turns++; }
                if(sup.dealer__Lead_Type__c=='Walk-In') { this.walkins++; this.ups++; }
                if(sup.dealer__Lead_Type__c=='Phone') { this.phonepops++; }                                 
                if(sup.dealer__Lead_Type__c=='Email') { this.emails++; } 
                
            }       
        }                   
    }
    
    public Integer getUps() {
        return ups;
    }
    
    public Integer getTurns() {
        return turns;
    }
    
    public Integer getDemos() {
        return demos;
    }
    
    public Integer getWriteups() {
        return writeups;
    }
    
    public Integer getWalkins() {
        return walkins;
    }
    
    public Integer getPhonepops() {
        return phonepops;
    }
    
    public Integer getEmails() {
        return emails;
    }
    
    public Integer getBeBacks() {
        return bebacks;
    }
    
    public double getTotalSales() {
        return totalsales;
    }
    
    public List<dealer__Sales_Up__c> getLeads() {
        return SalesLeads();
    }
    
    public List<dealer__Deal__c> getSales() {
        return SoldFollowUp();
    }
    
    public List<Contact> getCustomers() {
        return CustomerFollowUp();
    }
    
    public List<dealer__Service_Appointment__c> getServiceAppointments() {
        return ServiceAppt();
    }
}