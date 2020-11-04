/**
 * MyDealershipControl
 * @description
 */
public with sharing class MyDealershipControl {
    
    /**
     * getUserInfo 
     * @description
     */
    @AuraEnabled
    public static User getUserInfo() 
    {
        
        return [Select Id, In_BDC__c, Division, dealer__Dealership_Location__c from User Where Id=:UserInfo.getUserId() limit 1];    
    }
    
    /**
     * getMyDealerships 
     * @return List<dealer__Dealer_Location__c>
     * @description
     */ 
    @AuraEnabled
    public static List<dealer__Dealer_Location__c> getMyDealerships() 
    {
        
        List<Dealer_Location_User__c> availableLocations = new List<Dealer_Location_User__c>();
        try{
        	availableLocations = [select Id, Dealer_Location__c from Dealer_Location_User__c 
                                  where User__c=:UserInfo.getUserId() limit 3000];
        }catch(Exception e){
            system.debug('Error retrieving user locations: ' + e.getStackTraceString());
            throw new AuraHandledException(e.getMessage());
        }
        
        Set<Id> dealershipLocationIds = new Set<Id>();
        if(availableLocations.size() > 0){
            for(Dealer_Location_User__c dl : availableLocations) {
                dealershipLocationIds.add(dl.Dealer_Location__c);
            }
        }
		
        if(dealershipLocationIds.size()>0) {
            
            try{
                return [SELECT dealer__Address__c, dealer__City__c, dealer__Company_Number__c, dealer__Email__c, dealer__General_Manager__c,
                                     dealer__Main_Phone__c, dealer__Physical_Location__c, dealer__Postal_Code__c, dealer__Service_Director__c, dealer__State__c, 
                                     dealer__Website__c, dealer__Tax_Parts__c, Id, Name 
                                    FROM dealer__Dealer_Location__c
                                    Where Id IN:dealershipLocationIds
                                    Limit 3000];
            }catch(Exception e){
                system.debug('Error retrieving location results: ' + e.getStackTraceString());
                throw new AuraHandledException(e.getMessage());
            }
        } 

        return null;
    }
    
    /**
     * getBDCPermissions 
     * @return BDCPermission
     * @description
     */
    @AuraEnabled
    public static BDCPermission getBDCPermissions()
    {
        Boolean read = false;
        Boolean edit = false;
        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.User.fields.getMap();
        if(m.get('dealer__In_BDC__c').getDescribe().isAccessible()){
            read=True;
        }
        if(m.get('dealer__In_BDC__c').getDescribe().isUpdateable()){
            edit=True;
        }
        return new BDCPermission(read,edit);
    }
    
    /**
     * @description
     */
    public class BDCPermission{
        @AuraEnabled
        public Boolean read {get;set;}
        @AuraEnabled
        public Boolean edit {get;set;}
        public BDCPermission(Boolean readT,Boolean editT){
            read = readT;
            edit = editT;
        }
    }
    
    /**
     * chooseDealership 
     * @param  selectedDealershipId 
     * @description
     */
    @AuraEnabled
    public static User chooseDealership(String selectedDealershipId) 
    {
        
        if(selectedDealershipId == null || selectedDealershipId == '') {
            
            return null;
        }

        dealer__Dealer_Location__c d = [Select Id, Name, dealer__Company_Number__c, dealer__General_Manager__c, dealer__Service_Director__c 
                                        FROM dealer__Dealer_Location__c where Id=:selectedDealershipId limit 1];
        User me = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
        
        me.Division                 =   d.dealer__Company_Number__c;
        me.dealer__Dealership_Location__c   =   d.Name; 
        me.dealer__LocationId__c = selectedDealershipId;
        
        try{
            update me;
        }catch(Exception e){
            e.getMessage();
        }
        return me;
    }
    
    /**
     * updateUser 
     * @param  user 
     * @description
     */ 
    @AuraEnabled
    public static User updateUser(User user)
    {
        try{
            update user;
        }catch(DMLException e){
            throw new AuraHandledException(e.getMessage());
        }
        return User;
    }

    /**
     * getBDCRead 
     * @return Boolean
     * @description
     */
    @AuraEnabled(cacheable=true)
    public static Boolean getBDCRead()
    {
        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.User.fields.getMap();
        if(m.get('dealer__In_BDC__c').getDescribe().isAccessible()){
            return true;
        }
        else{
            return false;
        }
    }

    /**
     * getBDCWrite 
     * @return Boolean
     * @description
     */
    @AuraEnabled(cacheable=true)
    public static Boolean getBDCWrite()
    {
        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.User.fields.getMap();
        if(m.get('dealer__In_BDC__c').getDescribe().isUpdateable()){
            return false;
        }
        else{
            return true;
        }
    }

    /**
     * getBDCStatus 
     * @description
     */ 
    @AuraEnabled (cacheable=true)
    public static User getBDCStatus() 
    {
        
        return [Select Id, In_BDC__c, Division, dealer__Dealership_Location__c from User Where Id=:UserInfo.getUserId() limit 1];   
    }

    /**
     * updateBDC 
     * @param  inBDC 
     * @return void
     * @description
     */ 
    @AuraEnabled
    public static void updateBDC(Boolean inBDC)
    {
        user u = [SELECT Id, dealer__In_BDC__c FROM User WHERE Id=:UserInfo.getUserId() LIMIT 1];
        u.dealer__In_BDC__c = inBDC;
        try{
            update u;
        }catch(DmlException e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}