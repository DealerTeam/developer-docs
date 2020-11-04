/**
 * AddressPanelController
 * @description Controls whether the Address Panel is displayed and saves new input to the contact record.
 */ 
public with sharing class AddressPanelController {

    /**
     * currentContact
     * @return Contact record
     * @description
     */ 
    public Contact currentContact {get; set;}
    
    /**
     * newContact
     * @return Contact record
     * @description
     */ 
    public Contact newContact {get; set;}
    
    /**
     * showPanel
     * @return Boolean
     * @description
     */ 
    public Boolean showPanel {get; set;}
    
    /**
     * AddressPanelController 
     * @description Don't show Address Panel for existing Contact
     */ 
    public AddressPanelController() 
    {
        showPanel = false;
        
        currentContact = new Contact();
    }
    
    /**
     * openPanel 
     * @return PageReference
     * @description Show Address Panel on new Contact
     */
    public PageReference openPanel() 
    {
        showPanel = true;
        newContact = new Contact();
        /*
        newContact.MailingStreet = currentContact.MailingStreet;
        newContact.MailingCity = currentContact.MailingCity;
        newContact.MailingState = currentContact.MailingState;
        newContact.MailingPostalCode = currentContact.MailingPostalCode;
        newContact.MailingCountry = currentContact.MailingCountry;
        */
        return null;
    }   
    
    /**
     * save 
     * @return PageReference 
     * @description Save Street,City,State,Zip,Country for contact
     */
    public PageReference save() 
    {
        currentContact.MailingStreet = newContact.MailingStreet;
        currentContact.MailingCity = newContact.MailingCity;
        currentContact.MailingState = newContact.MailingState;
        currentContact.MailingPostalCode = newContact.MailingPostalCode;
        currentContact.MailingCountry = newContact.MailingCountry;
        
        showPanel = false;
        return null;
    }
    
    /**
     * cancel 
     * @return PageReference 
     * @description
     */
    public PageReference cancel() 
    {
        showPanel = false;
        return null;
    }

}