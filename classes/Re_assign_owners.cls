public with sharing class Re_assign_owners {
    
    public Contact allFields = new Contact();
    public List<Contact> ContactList = new List<Contact>();
    public List<Contact> ContactsList = new List<Contact>();
    List<Id> contactIds = new List<Id>();
    List<Id> userIds = new List<Id>();
    public list<SelectOption> addedUserList=new list<SelectOption>(); 
    public List<String> AvailableParticipantList = new List<String>();  
    public List<Task> noteTransfer = new List<Task>();
    public boolean addParticipantToList = true;
    public Integer j = 0;
    private ApexPages.StandardSetController standardController;
    public List<String> selectedParticipantList = new List<String>();
    public List<SelectOption> participantList = new List<SelectOption>();
    public Map<Id, User> userMap = new Map<Id, User>([Select Id, Name from User where Id IN : userIds order by FirstName limit 5000]);
    
    public List<Contact> getContactList(){
        return ContactList;
    }       
    public Re_assign_owners(ApexPages.StandardSetController standardController) {
        //this.allFields = (Contact) controller.getRecord();
        this.standardController = standardController;
        for(User userList : [Select Id, Name from User where isActive = true and (NOT Name like '%Chatter%') order by FirstName limit 5000]){
            participantList.add(new SelectOption(userList.Id,userList.Name));
        }
        ContactsList = (List<Contact>) standardController.getSelected();
        
        // Get Contact Id List
        for(Integer i = 0;i<ContactsList.size();i++){
            contactIds.add(ContactsList[i].Id);
        }
        
        // Collect User ID List
        for(Integer i = 0; i<addeduserList.size(); i++) {
            userIds.add(addeduserList.get(i).getValue());
        }
        
        ContactList = [Select Id, Name, OwnerId,Owner.Name from Contact where Id IN : contactIds limit 5000];
        
        
    }
    
    public PageReference Cancel()
    {
        Schema.DescribeSObjectResult result = Contact.sObjectType.getDescribe();
        PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
        cancelPage.setRedirect(true); 
        return cancelPage;
    }
    
    public PageReference submit(){
        for(Integer i = 0;i<ContactList.size();i++){
            //System.debug(addeduserList+'Hello::'+ContactList);
                
            if(addeduserList.size() > 0){
                
                // Assign user to the record
                ContactList[i].OwnerId = addeduserList.get(j).getValue();
                
                // Set Task to be inserted
                noteTransfer.add(new Task(
                    Description = 'Orphan customer re-assigned to ' + ContactList[i].Owner.Name + ' by ' + UserInfo.getName(),
                    Priority = 'Normal', 
                    Status = 'Completed', 
                    Subject = 'Orphaned customer assigned to ' + ContactList[i].Owner.Name, 
                    WhoId = ContactList[i].Id   
                ));
                
                // 
                j++;
                
                // Iterate Accross Userbase
                if(addeduserList.size() == j) {
                    j = 0;
                }
            }   
        }
        
        // Update Contact Owners
        if(ContactList.size() > 0){
            try{
                // System.debug('Hello::'+ContactList);
                update ContactList;
            }
            catch(Exception e){
                ApexPages.addMessages(e);
            }
        }
        
        // Add Tasks to Owners
        if(noteTransfer.size()>0) {
            try {
                insert noteTransfer;
            } catch(Exception e) {
                ApexPages.addMessages(e);
            }
        }
        
        Schema.DescribeSObjectResult result = Contact.sObjectType.getDescribe();
        PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
        cancelPage.setRedirect(true); 
        return cancelPage;
    }
    

    
    //List of Available Users
    public List<SelectOption> getParticipants(){
        return participantList; 
    } 
    //This function adds selected participants to the Selected Participants list
    public void addusers(){
        addParticipantToList = true;
        if(addeduserList.size()>0){
            if(addeduserList.size()<AvailableParticipantList.size()){
                for(Integer k=0;k<addeduserList.size();k++){
                    for(Integer l=0;l<AvailableParticipantList.size();l++){   
                        if(AvailableParticipantList.get(l) == addeduserList.get(k).getValue()){
                            addParticipantToList = false;
                        }
                    }                               
                }
            }
            else{
                for(Integer k=0;k<AvailableParticipantList.size();k++){
                    for(Integer l=0;l<addeduserList.size();l++){   
                        if(AvailableParticipantList.get(k) == addeduserList.get(l).getValue()){
                            addParticipantToList = false;
                        }
                    }                               
                }
            }
        }    
        if(addParticipantToList){
            for(Integer j=0;j<AvailableParticipantList.size();j++){
                for(Integer i=0;i<participantList.size();i++){ 
                    if(participantList.get(i).getValue() == AvailableParticipantList.get(j)){
                        addeduserList.add(new SelectOption(participantList.get(i).getValue(),participantList.get(i).getLabel()));
                        participantList.remove(i);
                    }               
                }
            }                               
        }  
    }
    //List of Selected participants
    public List<SelectOption> getaddParticipants(){   
        return addedUserList;
    }
    
    //Removes users from the list
    public void removeusers(){   
        for(Integer j=0;j<selectedParticipantList.size();j++){ 
            for(Integer i=0;i<addedUserList.size();i++){ 
                if(addedUserList.get(i).getValue() == selectedParticipantList.get(j)){
                    participantList.add(addedUserList.get(i));
                    addedUserList.remove(i);
                }                    
            }
        }                
        return;
    }
    public List<String> getParticipant(){
        return AvailableParticipantList; 
    }
    //Returns list of selected participants in Selected Participant list 
    public List<String> getAddPart(){
        return selectedParticipantList;
    }    
    public void setAddPart(List<String> values){   
        selectedParticipantList = values;
    }
    public void setParticipant(List<String> values){
        AvailableParticipantList = values;
    }
}