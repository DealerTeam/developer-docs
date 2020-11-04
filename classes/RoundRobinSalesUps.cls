public with sharing class RoundRobinSalesUps {
    
    public List<User> receivingUsers {get;set;}
    public User sendingUser {get;set;}
    public List<Contact> reAssignContact = new List<Contact>();
    public Set<Id> contactsInList = new Set<Id>();
    public Set<Id> upSet = new Set<Id>();
    public Map<Id, User> userMap = new Map<Id, User>();
    
    public Boolean notifyRecipient {get;set;}   
    public Boolean updateContactRecord {get;set;}
    public decimal userListSize {get;set;}
    public decimal reassignUpsListSize {get;set;}
    public integer startInt = 0;
    public List<Task> notifyTasks = new List<Task>();
    public Map<Id, Task> reAssignTasks = new Map<Id, Task>();
    public List<Task> reAssignTasksList = new List<Task>();
    public List<Task> tasksToRM = new List<Task>();
    public List<Task> updateAssignedTasks = new List<Task>();
    public List<salesUpBA> upAfterList = new List<salesUpBA>();
     
    public List<dealer__Sales_Up__c> up;
    public List<dealer__Sales_Up__c> MovedUps = new List<dealer__Sales_Up__c>();
    
    public SelectOption[] selectedUsers { get; set; }
    public SelectOption[] allUsers { get; set; }
    
    public RoundRobinSalesUps(ApexPages.standardSetController ssc) {
        if(!Test.isRunningTest()) {
            ssc.addFields(new List<String> {'Id', 'Name','dealer__Salesperson_1__r.Name', 'dealer__Salesperson_2__r.Name', 'dealer__Buyer_Contact__c'});
        }
        
        this.notifyRecipient        =   false;
        this.updateContactRecord    =   false;
        
        if(!Test.isRunningTest()) {
            this.up                     =   ssc.getSelected();
            this.reassignUpsListSize    =   ssc.getResultSize();    
        } else {
            this.up = [select Id, Name, dealer__Salesperson_1__c, dealer__Salesperson_1__r.Name, dealer__Salesperson_2__c, dealer__Salesperson_2__r.Name,
                         dealer__Buyer_Contact__c
                         from dealer__Sales_Up__c limit 100];
            this.reassignUpsListSize    =   this.up.size();                  
        }
        
        // Create Set of included UP ID's and get associated Tasks
        for(dealer__Sales_Up__c s : this.up) {
            upSet.add(s.Id);
        }
        for(Task t : [Select Id, WhoId, WhatId from Task where Id IN :upSet and IsClosed = false order by ActivityDate desc limit 5000]) {
            if(!this.reAssignTasks.containsKey(t.WhatId)) {
                this.reAssignTasks.put(t.WhatId, t);
            } else {
                this.tasksToRM.add(t);
            }
        }
        
        // Check to see that we have something to re-assign
        if(this.reassignUpsListSize<=0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry, no Sales Ups in your list of reassignments, please try again.'));
        }   
        
        // Build options for MultiSelect
        selectedUsers   =   new List<SelectOption>();
        allUsers        =   new List<SelectOption>();
        
        List<User> userList = [Select Id, Name from User where UserType = 'Standard' and IsActive=true order by FirstName asc limit 500];
        userMap = new Map<Id, User>();
        for(User ul : userList) {
            allUsers.add(new SelectOption(ul.Id, ul.Name));
            userMap.put(ul.Id, ul);
        }
        this.userListSize   = userMap.size();
        
        
        if(this.userListSize==0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'The list of users is empty.'));
        }
        /*
        for(User u : userMap.values()) {
            allUsers.add(new SelectOption(u.Id, u.Name));
        }
        */
    
    }
    
    public class salesUpBA {
        public dealer__Sales_Up__c baUp {get;set;}
        public String beforeUser {get;set;}
        public String afterUser {get;set;}
        
        public salesUpBa(dealer__Sales_Up__c a, String bu, String au) {
            baUp=a;
            beforeUser=bu;
            afterUser=au;
        }
    }
    
    public PageReference ReAssign() {
        if(reassignUpsListSize > 0 && selectedUsers.size() > 0) {
            // We have items to re-assign and users to assign them to.
            reAssignBlock();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Sales Up(s) Re-Assigned'));
            return Page.SalesUps;
        } else {
            return null;
        }   
    }
    
    public Id nextUser() {
        if(this.selectedUsers.size()==0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: no salespersons selected'));
            return null;
        }
        
        if(startInt>=(selectedUsers.size()-1)) {
            startInt=0;
        } else {
            startInt++;
        }
        
        return (ID)selectedUsers[startInt].getValue();
    }
    
    public void reAssignBlock() {
        
        // 
        //  Primary Re-Assign Logic 
        //
        
        for(dealer__Sales_Up__c sup : up) {
            Id afterUser = this.nextUser();

            String assignedName = '';
            if(sup.dealer__Salesperson_1__c==null) {
                assignedName = 'Unassigned';
            } else {
                assignedName = sup.dealer__Salesperson_1__r.Name;
            }

            Id bcontact = null;
            if(sup.dealer__Buyer_Contact__c!=null) { 
                bcontact = sup.dealer__Buyer_Contact__c;
            }

            if(userMap.get(afterUser)==null) {
                return;
            }

            notifyTasks.add(new Task(Subject='Sales Up Re-Assigned from ' + assignedName + ' to '+userMap.get(afterUser).Name,
                                    ActivityDate=Date.today(),
                                    Status='Not Started',
                                    WhatId=sup.Id,
                                    WhoId=bcontact,
                                    OwnerId=afterUser)
                            );
            
            // If Re-Assign Contact set to true
            if(this.updateContactRecord==true && (this.contactsInList.contains(sup.dealer__Buyer_Contact__c)==false)) {
                    this.reAssignContact.add(new Contact(Id=sup.dealer__Buyer_Contact__c, OwnerId=afterUser));
                    this.contactsInList.add(sup.dealer__Buyer_Contact__c);
            }
            
            // Keep List of Changes
            upAfterList.add(new salesUpBA(sup, sup.dealer__Salesperson_1__r.Name, afterUser));              
                                        
            sup.dealer__Salesperson_1__c=afterUser;
            
            // Move existing Tasks
            if(this.reAssignTasks.containsKey(sup.Id)) {
                Task tempT = this.reAssignTasks.get(sup.Id);
                if(tempT!=null) {
                    tempT.OwnerId=sup.dealer__Salesperson_1__c;
                    this.reAssignTasksList.add(tempT);
                }   
            }
            
            MovedUps.add(sup);
            
        }
        
        // Commit Changes to the DML
        if(MovedUps.size()>0) {
            // Updates the Salesperson1 and Contact Owner
            try { 
                update MovedUps;
            } catch(DmlException e) {
                
            }
        
            // Save the Tasks
            if(notifyTasks.size()>0) {
                try {
                    insert notifyTasks;
                } catch(DmlException e) {
                    
                }
            }
            
            // Move existing Tasks
            if(this.reAssignTasksList.size()>0) {
                update this.reAssignTasksList;
            }
            
            
            // Delete Backlogged Tasks
            if(this.tasksToRM.size()>0) {
                delete tasksToRM;
            }
            
            // If Email List of Changes to running user set to true, email.
            if(this.notifyRecipient==true) {
                emailMeResults();
            }
        }
        
        if(this.reAssignContact.size()>0) {
            try {
                update this.reAssignContact;
            } catch(DmlException e) {
                
            }
        }
    }
    
    public void emailMeResults() {
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String emailAddr = UserInfo.getUserEmail();
        String[] toAddresses = new String[] {emailAddr};
        
        mail.setToAddresses(toAddresses);
        mail.setSubject('Re-Assigned Sales Up Change List ');
        mail.setHtmlBody(buildHTMLTableOfResults());
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public String buildHTMLTableOfResults() {
        String rTable = '<html><style type="text/css"> .tg-left { text-align: left; } .tg-right { text-align: right; } .tg-center { text-align: center; } .tg-bf { font-weight: bold; } .tg-it { font-style: italic; } .tg-table-plain { border-collapse: collapse; border-spacing: 0; font-size: 100%; font: inherit; } .tg-table-plain td, .tg-table-plain th { border: 1px #555 solid; padding: 10px; vertical-align: top; } </style><body>';
               rTable+= '<table class="tg-table-plain"> <tr> <th>Sales Up</th> <th>Before</th> <th>After</th> </tr>';   
        for(salesUpBA s : upAfterList) {
            rTable += '<tr class="tg-even"> <td>' + s.baUp.Name + '</td> <td>' + s.beforeUser + '</td> <td>' + userMap.get(s.afterUser).Name + '</td> </tr>';   
        }
        
        rTable += '</table></body></html>';
        
        return rTable;
    }
}