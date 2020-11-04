/**
 *   W-1552 | @Author Lorena Xavier
 *   Controller for RentalSchedule.vfp
**/
public with sharing class RentalScheduleControl {
    
    public dealer__Vehicle_Inventory__c vi { get;set; }
    
    public RentalScheduleControl(ApexPages.Standardcontroller sc) {
         vi  =   (dealer__Vehicle_Inventory__c)sc.getRecord();
    }
    
    @RemoteAction
    public static List<dealer__Vehicle_Inventory__c> getVehiclesJSON(String locId, String region) {
        
        system.debug('locId ' + locId);
        List<dealer__Vehicle_Inventory__c> vehicles = new List<dealer__Vehicle_Inventory__c>();
        if(locId != null && locId !=''){
            vehicles = [SELECT Id, Name,  dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Mileage__c,
                        dealer__Vehicle_Type__c, RecordType.Name, RecordTypeId, dealer__Store_Location__c 
                    	FROM dealer__Vehicle_Inventory__c
                        WHERE RecordType.Name = 'Rental' 
                        AND dealer__Rental_Status__c != 'Out of Service'
                        AND dealer__Store_Location__c =: locId
                    	LIMIT 1000];    
        }else if(region != null && region !=''){
            vehicles = [SELECT Id, Name,  dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Mileage__c,
                        dealer__Vehicle_Type__c, RecordType.Name, RecordTypeId, dealer__Store_Location__c 
                    	FROM dealer__Vehicle_Inventory__c
                        WHERE RecordType.Name = 'Rental' 
                        AND dealer__Rental_Status__c  != 'Out of Service'
                        AND dealer__Store_Location__r.dealer__RegionName__c =: region
                    	LIMIT 1000];    
            
        }else{
            
               vehicles = [SELECT Id, Name,  dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Mileage__c,
                        dealer__Vehicle_Type__c, RecordType.Name, RecordTypeId, dealer__Store_Location__c 
                    	FROM dealer__Vehicle_Inventory__c
                        WHERE RecordType.Name = 'Rental' 
                        AND dealer__Rental_Status__c != 'Out of Service'
                    	LIMIT 1000];  
        }
        
        return vehicles;
        
    }

    @RemoteAction
    public static List<Contact> getCustomersJSON(String customerFilter) {
        
        if(!String.isEmpty(customerFilter)){
            String textToSearch = '%'+customerFilter+'%';
            return [Select Id, FirstName, LastName, Name, HomePhone, MailingStreet, MailingCity, MailingState, 
                        MailingPostalCode, Email, MobilePhone, Birthdate, RecordTypeId, 
                        Drivers_License_Number__c,Drivers_License_Expiration_Date__c,Drivers_License_State__c 
                        from Contact Where Name LIKE : textToSearch limit 1000];
            
        }else{
            return [Select Id, FirstName, LastName, Name, HomePhone, MailingStreet, MailingCity, MailingState, 
                        MailingPostalCode, Email, MobilePhone, Birthdate, RecordTypeId, 
                        Drivers_License_Number__c,Drivers_License_Expiration_Date__c,Drivers_License_State__c 
                        from Contact limit 1];
        }
    }
    
    @RemoteAction
    public static List<ContactAccountWrapper> getCustomersAccountJSON(String customerFilter) {
        
        List<ContactAccountWrapper> contactAccounts = new List<ContactAccountWrapper>();
        if(!String.isEmpty(customerFilter)){
            String textToSearch = '%'+customerFilter+'%';
              for(sObject o : [Select Id, Name from Contact WHERE Name LIKE : textToSearch limit 500]){
                ContactAccountWrapper ca = new ContactAccountWrapper(o, 'Contact');
                contactAccounts.add(ca);
            }
            
            for(sObject o : [Select Id, Name from Account Where IsPersonAccount = false AND Name LIKE : textToSearch limit 500]){
                ContactAccountWrapper ca = new ContactAccountWrapper(o, 'Account');
                contactAccounts.add(ca);
            }
            
        }else{
            for(sObject o : [Select Id, Name from Contact limit 500]){
                ContactAccountWrapper ca = new ContactAccountWrapper(o, 'Contact');
                contactAccounts.add(ca);
            }
            
            for(sObject o : [Select Id, Name from Account Where IsPersonAccount = false limit 500]){
                ContactAccountWrapper ca = new ContactAccountWrapper(o, 'Account');
                contactAccounts.add(ca);
            }
            
        }
        
        return contactAccounts;
    }

    
    @RemoteAction
    public static List<dealer__Rental_Rates__c> getRatesJSON() {
        
        List<dealer__Rental_Rates__c> rates = new List<dealer__Rental_Rates__c>();
        
            rates = [Select Id, Name, dealer__Rate_Description__c
                    	from dealer__Rental_Rates__c
                    	limit 1000];    
        
			return rates;
        
    }
    
    @RemoteAction
    public static void deleteRentalEvent(String rentalId) {
        
       	dealer__Rental_Schedule_Event__c rentalEvent = [SELECT Id, dealer__Reservation__c FROM dealer__Rental_Schedule_Event__c WHERE Id=: rentalID ];
       	
        dealer__Rental_Reservation__c reservation;
        
        if(rentalEvent.dealer__Reservation__c != null) {
       		 reservation = [SELECT Id FROM dealer__Rental_Reservation__c WHERE Id =: rentalEvent.dealer__Reservation__c LIMIT 1];
        }
        
        try{
            delete rentalEvent;
            if(reservation != null) delete reservation;
            
        }catch(exception e){
            e.getMessage();
        }
    }
 
    
    @RemoteAction
    public static List<dealer__Rental_Schedule_Event__c> getRentalEventsJSON(String locId) {
        
        
        List<dealer__Rental_Schedule_Event__c> rentalEvents = new List<dealer__Rental_Schedule_Event__c>();
        
        if(locId != null && locId != ''){
            rentalEvents = [SELECT Id, Name, dealer__Agreements__c, dealer__Description__c, dealer__Event_End__c, dealer__Event_Start__c, 
                        	dealer__Location__c, dealer__Reservation__c, dealer__Reservation__r.Name, dealer__Type__c, dealer__Vehicle_In_Stock__c,
                        	dealer__Reservation__r.dealer__Location__c, dealer__Color__c, dealer__Customer_Contact__c, dealer__Customer__c, dealer__Customer_Name__c,
                            dealer__Discount_Percentage__c, dealer__Days_Free__c, dealer__Deposit_Amount__c, dealer__Discount__c,
                            dealer__Rental_Rate__c, dealer__Tax_Exempt__c, dealer__Vehicle_Inventory__c, dealer__Is_Overbooked__c 
                        	FROM dealer__Rental_Schedule_Event__c 
                            WHERE dealer__Location__c =: locId LIMIT 1000];
        }else{
            
             rentalEvents = [SELECT Id, Name, dealer__Agreements__c, dealer__Description__c, dealer__Event_End__c, dealer__Event_Start__c, 
                        	dealer__Location__c, dealer__Reservation__c, dealer__Reservation__r.Name, dealer__Type__c, dealer__Vehicle_In_Stock__c,
                        	dealer__Reservation__r.dealer__Location__c, dealer__Color__c, dealer__Customer_Contact__c, dealer__Customer__c, dealer__Customer_Name__c,
                            dealer__Discount_Percentage__c, dealer__Days_Free__c, dealer__Deposit_Amount__c, dealer__Discount__c,
                            dealer__Rental_Rate__c, dealer__Tax_Exempt__c, dealer__Vehicle_Inventory__c, dealer__Is_Overbooked__c 
                        	FROM dealer__Rental_Schedule_Event__c 
                            LIMIT 1000];
            
        }
        
        return rentalEvents;
    }
    

    @RemoteAction
    public static String getUserLocation(){
        return dealer.Utility.lookupUserLocation();
    }
    
    
    @RemoteAction
    public static List<dealer__Dealer_Location__c> getLocationsJSON(String region){
        Set<Id> locIds = new Set<Id>();
        List<Dealer_Location_User__c> userLocs = [SELECT Id, Dealer_Location__c FROM dealer__Dealer_Location_User__c WHERE User__c =: UserInfo.getUserId()];
        for(Dealer_Location_User__c dlu : userLocs){
            locIds.add(dlu.Dealer_Location__c);
        }
        List<dealer__Dealer_Location__c> locations = new List<dealer__Dealer_Location__c>();
        
        if(region != null && region != ''){
        	locations = [SELECT Id, Name, dealer__Company_Number__c,
                                                     dealer__Open_Hour__c, dealer__Close_Hour__c, dealer__RegionName__c 
                                                     FROM dealer__Dealer_Location__c 
                                                     WHERE dealer__RegionName__c =: region AND Id IN: locIds
                                                     Order By Name ASC    
                                                     LIMIT 100];
            
        }else{
            locations = [SELECT Id, Name, dealer__Company_Number__c,
                                                     dealer__Open_Hour__c, dealer__Close_Hour__c, dealer__RegionName__c 
                                                     FROM dealer__Dealer_Location__c 
                                                     WHERE Id IN: locIds
                                                     Order By Name ASC    
                                                     LIMIT 100];
            
        }
        
        return locations;
    }
    
    @RemoteAction
    public static List<dealer__Region__c> getRegionsJSON(){
        
        List<dealer__Region__c> regions = [SELECT Id, Name, dealer__Description__c 
                                                     FROM dealer__Region__c  
                                                     Order By Name ASC    
                                                     LIMIT 100];
        
        return regions;
    }
    
    
    
    @RemoteAction
    public static boolean saveEvent(List<dealer__Rental_Schedule_Event__c> eventData){
        
       boolean isNewRecord = true;
       boolean isOverbooked = false;
        
       dealer__Rental_Reservation__c res = new dealer__Rental_Reservation__c();
         
       if(eventData != null && !eventData.isEmpty()) {
           
           dealer__Rental_Schedule_Event__c rentalSchedule = new dealer__Rental_Schedule_Event__c();
           
           //Create a map with fields from event list
           Map<String, Object> evtInfo = eventData[0].getPopulatedFieldsAsMap();
           for (String fieldName : evtInfo.keySet()) {
               
               if(evtInfo.get(fieldName) != '' && evtInfo.get(fieldName) != null){
                   rentalSchedule.put(fieldName, evtInfo.get(fieldName));
               }
               
           }
               
           	//Edit event: Update record
           if(eventData[0].get('Id') != '' && eventData[0].get('Id') != null){
                
               	isNewRecord = false;
                String eid = String.valueOf(eventData[0].get('Id'));
                dealer__Rental_Schedule_Event__c oldRentalSchedule = new dealer__Rental_Schedule_Event__c();

                
                oldRentalSchedule = [SELECT Id, Name, dealer__Agreements__c, dealer__Description__c, dealer__Event_End__c, dealer__Event_Start__c, 
                                  dealer__Location__c, dealer__Reservation__c, dealer__Type__c, dealer__Color__c, 
                                  dealer__Reservation__r.dealer__Location__c, dealer__Customer_Contact__c,
                                  dealer__Discount_Percentage__c, dealer__Days_Free__c, dealer__Deposit_Amount__c, dealer__Discount__c,
                            	  dealer__Rental_Rate__c, dealer__Tax_Exempt__c, dealer__Vehicle_Inventory__c, dealer__Is_Overbooked__c  
                                  FROM dealer__Rental_Schedule_Event__c 
                                  WHERE Id =: eid
                                  LIMIT 1];
                                
           		//Customer is set
               if(rentalSchedule.dealer__Customer_Contact__c != null || rentalSchedule.dealer__Customer__c != null){

                   //Create reservation
                   if(oldRentalSchedule.dealer__Reservation__c == null){
                   		res.dealer__Location__c = rentalSchedule.dealer__Location__c;
                       	res.dealer__Vehicle_Inventory__c = rentalSchedule.dealer__Vehicle_Inventory__c;
                            
                       try{
                           insert res;
                           rentalSchedule.dealer__Reservation__c = res.Id;
                       }catch(Exception e){
                           e.getMessage();
                       }
               
                       
                   }else{
                       //Update reservation
                       dealer__Rental_Reservation__c reservation = [SELECT Id, dealer__Location__c, dealer__Vehicle_Inventory__c 
                                                                    FROM dealer__Rental_Reservation__c
                                                                    WHERE Id =: oldRentalSchedule.dealer__Reservation__c LIMIT 1];
                       
                       //Set Reservation Location
                       if(rentalSchedule.dealer__Location__c != null){
                           reservation.dealer__Location__c = rentalSchedule.dealer__Location__c;
                           reservation.dealer__Vehicle_Inventory__c = rentalSchedule.dealer__Vehicle_Inventory__c;
                           
                           try{
                               update reservation;
                           }catch(Exception e){
                               e.getMessage();
                           }
                       }
                       
                   }
              
              }else if(rentalSchedule.dealer__Customer_Contact__c == null && rentalSchedule.dealer__Customer__c == null && oldRentalSchedule.dealer__Reservation__c != null){

                   //Delete reservation
                   dealer__Rental_Reservation__c reservation = [SELECT Id, dealer__Location__c, dealer__Vehicle_Inventory__c
                                                                    FROM dealer__Rental_Reservation__c
                                                                    WHERE Id =: oldRentalSchedule.dealer__Reservation__c LIMIT 1];
                   
                  try{
                      delete reservation;
                  }catch(Exception e){
                      system.debug('Error deleting reservation: '+ e.getMessage());
                  }
               }   
                   
           }
  			
			//Create reservation record if event is new and account is set    
	       if(isNewRecord && (rentalSchedule.dealer__Customer_Contact__c != null || rentalSchedule.dealer__Customer__c != null)){
               
               //Create reservation
               res.dealer__Location__c = rentalSchedule.dealer__Location__c;
               res.dealer__Vehicle_Inventory__c = rentalSchedule.dealer__Vehicle_Inventory__c;

               if(res.dealer__Location__c == null){
                    User me = [Select Id, dealer__LocationId__c from User where Id=:UserInfo.getUserId() limit 1];
                    if(me.dealer__LocationId__c != null){
                        res.dealer__Location__c = me.dealer__LocationId__c;
                    }
                    else{
                        throw new VisualforceException('Location is required to create rental event. Please select a location or choose My Dealership location.');
                    }
               }
               
               try{
                   insert res;
                   rentalSchedule.dealer__Reservation__c = res.Id;
               }catch(Exception e){
                   e.getMessage();
               }
               
           }
           
           //verify vehicle overbooked
           rentalSchedule.dealer__Is_Overbooked__c = isOverbooked = checkEventOverbooked(rentalSchedule);
           if(rentalSchedule.Id != null){
               try{
                   update rentalSchedule;
               }catch(Exception e){
                   e.getMessage();
               }
           }else{
               try{
                   insert rentalSchedule;
               }catch(Exception ex){
                   ex.getMessage();
               }
           }
    }

       return isOverbooked;
    }
    
    
    private static boolean checkEventOverbooked(dealer__Rental_Schedule_Event__c rentalSchedule){
        
        
        List<dealer__Rental_Schedule_Event__c> rentalEvents = [SELECT Id, Name, dealer__Event_Start__c, dealer__Event_End__c, dealer__Vehicle_Inventory__c 
                                                              FROM dealer__Rental_Schedule_Event__c
                                                              WHERE ((dealer__Event_Start__c>=:rentalSchedule.dealer__Event_Start__c AND dealer__Event_Start__c<=:rentalSchedule.dealer__Event_End__c) 
                                                                     OR (dealer__Event_End__c>=:rentalSchedule.dealer__Event_Start__c AND dealer__Event_End__c<=:rentalSchedule.dealer__Event_End__c)) 
                                                               		AND dealer__Vehicle_Inventory__c =: rentalSchedule.dealer__Vehicle_Inventory__c
                                                              LIMIT 5000]; 
        
        
        if(rentalEvents.size()>=1 && rentalSchedule.Id != rentalEvents[0].Id){
           
            rentalSchedule.dealer__Color__c = '#6c757d';
            return true;
        }

        return false;
    }
    
    //Retrieve Rental Colors
    public static String getRentalColors() {
        
        String rentalColors;
        // dealer__RentalSettings__c rs = new dealer__RentalSettings__c();
        // if(dealer__RentalSettings__c.getOrgDefaults()!=null) {
            // rs = dealer__RentalSettings__c.getOrgDefaults();
            // rentalColors = rs.dealer__RentalColorChart__c;
        rentalColors = DealerMetadata.getConfigValue('RentalColorChart');

        // }
        if(rentalColors == null){
            rentalColors = '{\"Pickup\":\"007bff\",\"Insurance\":\"f0ad4e\",\"Customer Pay\":\"5cb85c\", \"Loaner\":\"17a2b8\",\"Unassigned\":\"d9534f\"}';
        }
        return rentalColors;
    }
    
    //Retrieve Fieldset
    public static List<String> getFieldSets() {
        
        List<String> fields = new List<String>();
        
        if(Schema.SObjectType.dealer__Rental_Schedule_Event__c.fieldSets.getMap().get('dealer__RentalSchedule') != null){
            
        	List<Schema.FieldSetMember> fieldList = Schema.SObjectType.dealer__Rental_Schedule_Event__c.fieldSets.getMap().get('dealer__RentalSchedule').getFields();
        	
        	if(!fieldList.isEmpty()){
                String temp = ''; 
                for(Schema.FieldSetMember f : fieldList) {
                    temp = '"'+f.getFieldPath().replace('__c','').replace('dealer__','')+'"';
                    fields.add(temp);
                }
            }
        }
        
        return fields;
    }
    
    //Retrieve required fields
    public static List<String> getRequiredFields() {
    	
     	Map <String, Boolean> returnMap = DealerMetadata.getAllRequiredFields(dealer__Rental_Schedule_Event__c.sobjecttype.getdescribe(), 'Rental Schedule Event Layout');
       
        List<String> fields = new List<String>();
        
        if(!returnMap.isEmpty()){
            
            String temp, aux;
            for(String s : returnMap.keySet()) {
                if(returnMap.get(s) && s.substring(s.length()-3, s.length()) == '__c' && s != 'dealer__Tax_Exempt__c'){
                    temp =  s.replace('dealer__', '').replace('__c', ''); 
                    aux = '"' + toProperCase(temp) + '"';
                }
                if(!fields.contains(aux)){ fields.add(aux); }
            }
        }
        return fields;
    } 
 
    
    public static String toProperCase(String value) {
        
        // Normalize - Convert to lowercase
        value = value.toLowerCase();

        // Hold each word
        List<String> pieces = new List<String>();

        // Split
        for(String s : value.split('_')) {
            // Capitalize each piece
            s = s.capitalize();

            // Add to pieces
            pieces.add(s);
        }

        // Join
        return String.join(pieces, '_');
    }
    
      /**
     * 		Inner class to handle contact / account 
     * 		dropdown data
     * */
    public class ContactAccountWrapper{
        
        public sObject contactAccount {get;set;}
        public String type {get;set;}
        
        public ContactAccountWrapper(sObject ca, String objectType){
            contactAccount = ca;
            type = objectType;
        }
    }
}