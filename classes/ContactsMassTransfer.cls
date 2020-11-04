/**
 * ContactsMassTransfer
 * @description
 */
public with sharing class ContactsMassTransfer {

    /**
     * @description
     */
    public List<Contacts> ContactList= new List<Contacts>();
    
    /**
     * @description
     */
    public List<Contact> ContactsList = new List<Contact>();
    
     /**
     * @description
     */
    public Contact con = new Contact();
    
     /**
     * @description
     */
    public boolean displayErrorMessage{get;set;}
    
     /**
     * @description
     */
    public boolean showListOfContacts{get;set;}
    
     /**
     * @description
     */
    public boolean EnteredSearchBox{get;set;}
    
     /**
     * @description
     */
    public boolean EnteredTransferBox{get;set;}
    Integer j = 0;
    
     /**
     * @description
     */
    public ContactsMassTransfer()
    {
        for(User userList : [Select Id, Name from User where isActive = true and (NOT Name like '%Chatter%')]){
            participantList.add(new SelectOption(userList.Id,userList.Name));
        }   
    }
    
     /**
     * @description
     */
    public List<SelectOption> participantList = new List<SelectOption>();
    
     /**
     * @description
     */
    public List<String> AvailableParticipantList = new List<String>();  
    
    /**
     * getContactList 
     * @return List<Contacts>
     * @description
     */
    public List<Contacts> getContactList()
    {
        return ContactList;
    }
    
    /**
     * getCon 
     * @return  Contact
     * @description
     */
    public Contact getCon()
    {
        return con;
    }
    
    /**
     * setCon 
     * @param  conId
     * @return void
     * @description 
     */ 
    public void setCon(Id conId)
    {
        con.Transfer_From__c = conId;
    }
    
    /**
     * Cancel 
     * @return  PageReference
     * @description
     */
    public PageReference Cancel()
    {
        Schema.DescribeSObjectResult result = Contact.sObjectType.getDescribe();
        PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
        cancelPage.setRedirect(true); 
        return cancelPage;
    }
    
    /**
     * Transfer 
     * @return  PageReference
     * @description 
     */ 
    public PageReference Transfer()
    {
        EnteredTransferBox = true;
        for(Integer i = 0;i<ContactList.size();i++){
            if(AvailableParticipantList.size() > 0){
                if(ContactList[i].isChecked){
                    // Assign user to the record
                    ContactList[i].OwnerId = AvailableParticipantList.get(j);
                    j++;
                    
                    // Iterate Accross Userbase
                    if(AvailableParticipantList.size() == j) {
                        j = 0;
                    }
                }        
            }   
        }
        for(Integer i = 0;i<ContactList.size();i++){
            if(ContactList[i].isChecked){
                Contact c = new Contact(id = ContactList[i].Id,OwnerId = ContactList[i].OwnerId);
                ContactsList.add(c);
            }   
        }
        try{
            if(ContactsList.size() > 0)
                Database.SaveResult[] ContactsListUpdateResult = Database.update(ContactsList,false);
        }
        catch(Exception e){
            
        }
        if((ContactList.size() == 0) || (AvailableParticipantList.size() == 0)){
            return null;
        }
        else{
            Schema.DescribeSObjectResult result = Contact.sObjectType.getDescribe();
            PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
            cancelPage.setRedirect(true); 
            return cancelPage;
        }    
    }   
    
    /**
     * search 
     * @return void
     * @description
     */
    public void search()
    {
        ContactList.clear();
        EnteredSearchBox = true;
        for(Contact con: [Select Id, Name,Email,Phone,OwnerId,Owner.Name from Contact where OwnerId = :con.Transfer_From__c]){
            Contacts c = new Contacts();
            c.isChecked = true;
            c.Name = con.Name;
            c.Email = con.Email;
            c.Phone = con.Phone;
            c.OwnerName = con.Owner.Name;
            c.Id = con.Id;
            ContactList.add(c);
        }
        if(ContactList.size() == 0){
            displayErrorMessage = true;
        }
        else{
            showListOfContacts = true;
        }
    }
    
    /**
     * setParticipant 
     * @param  values 
     * @return void
     * @description
     */ 
    public void setParticipant(List<String> values)
    {
        AvailableParticipantList = values;
    }
    
    /**
     * getParticipant 
     * @return  List<String>
     */ 
    public List<String> getParticipant()
    {
        return AvailableParticipantList; 
    }

    /**
     * getParticipants 
     * @return List<SelectOption>
     * @description List of Available Users
     */ 
    public List<SelectOption> getParticipants()
    {
        return participantList; 
    } 
    
    /**
     * Contacts
     * @description
     */ 
    public Class Contacts
    {
        public Boolean isChecked {get; set;}
        public String Name {get; set;}
        public String Email {get; set;}
        public String Phone {get; set;}
        public String OwnerName {get; set;}
        public String OwnerId {get;set;}
        public String Id {get;set;}
    }
}