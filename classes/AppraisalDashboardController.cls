/**
 * AppraisalDashboardController
 * @description
 */
public with sharing class AppraisalDashboardController {
    
    /**
     * @description
     */
    public static integer maxRows { get; set; }

    /**
     * @description
     */
    public List<dealer__Appraisal__c> appraisals {get; set;}

    /**
     * @description
     */
    public List<SelectOption> years          {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> makes          {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> rampOperations {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> rampLocations  {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> conversions    {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> statuses       {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> appraisers     {get; set;}
    
    /**
     * @description
     */
    public List<SelectOption> locations      {get; set;}

    /**
     * @description
     */
    public List<String> year          {get; set;}
    
    /**
     * @description
     */
    public List<String> make          {get; set;}
    
    /**
     * @description
     */
    public List<String> status        {get; set;}
    
    /**
     * @description
     */
    public List<String> rampOperation {get; set;}
    
    /**
     * @description
     */
    public List<String> rampLocation  {get; set;}
    
    /**
     * @description
     */
    public List<String> conversion    {get; set;}
    
    /**
     * @description
     */
    public List<String> appraiser     {get; set;}
    
    /**
     * @description
     */
    public List<String> location      {get; set;}

    /**
     * @description
     */
    public String model          {get; set;}
    
    /**
     * @description
     */
    public String vin            {get; set;}

    /**
     * @description
     */
    public Decimal appraisalMin  {get; set;}
    
    /**
     * @description
     */
    public Decimal appraisalMax  {get; set;}

    /**
     * @description
     */
    public String filter {get;set;}

    /**
     * @description
     */
    static String staticQuery;
    
    /**
     * @description
     */
    static Integer staticMaxRows;

     static String appraisalFields = 'Id, Name, dealer__Service_Vehicle__c, dealer__Odometer__c, dealer__ConversionModel__c, dealer__Ramp_Operation__c, dealer__Ramp_Location__c, dealer__Appraised_By__c, dealer__Appraised_By__r.Name, dealer__Store_Location__c, dealer__Store_Location__r.Name, dealer__Appraised_Value__c, dealer__Reconditioning__c, dealer__Status__c, dealer__Asking_Price__c';
     static String vehicleFields = 'dealer__Service_Vehicle__r.dealer__VIN__c, dealer__Service_Vehicle__r.dealer__Year__c, dealer__Service_Vehicle__r.dealer__Make__c, dealer__Service_Vehicle__r.dealer__Carline__c, dealer__Service_Vehicle__r.dealer__Ext_Color__c, dealer__Service_Vehicle__r.dealer__Last_Odometer__c, dealer__Service_Vehicle__r.dealer__Conversion_MFG__c, dealer__Service_Vehicle__r.dealer__Veh_Owner__r.Name, dealer__Service_Vehicle__r.dealer__Veh_Owner__r.Id';

     static String query = 'SELECT ' + appraisalFields + ', ' + vehicleFields + ' FROM dealer__Appraisal__c ';

    /**
     * AppraisalDashboardController 
     * @description Controller
     */
    public AppraisalDashboardController() 
    {
        appraisals = new List<dealer__Appraisal__c>();

        years = getYears();
        makes = getMakes();
        statuses = getAppraisalStatuses();
        rampOperations = getRampOperations();
        rampLocations = getRampLocations();
        conversions = getConversions();
        appraisers = getAppraisers();
        locations = getLocations();

        year = new List<String>();
        make = new List<String>();
        status = new List<String>();
        //Default status filter to Pending
        status.add('Pending');
        rampOperation = new List<String>();
        rampLocation = new List<String>();
        conversion = new List<String>();
        appraiser = new List<String>();
        location = new List<String>();      
    }

    /**
     * appraisalSearch
     * @return void
     * @description
     */
    public void appraisalSearch() 
    {
        List<String> filterFields = new List<String>();

        if(maxRows==NULL) {
            maxRows=50;
        }
         system.debug('filter beginning vehicleSearch '+filter);

        if(year.size() > 0) {
            filterFields.add('dealer__Service_Vehicle__r.dealer__Year__c in (\'' + String.join(year, '\', \'') + '\')');
        }

        if(make.size() > 0) {
            filterFields.add('dealer__Service_Vehicle__r.dealer__Make__c in (\'' + String.join(make, '\', \'') + '\')');
        }

        if(model != null && model != '') {
            filterFields.add('dealer__Service_Vehicle__r.dealer__Carline__c LIKE \'%' + model + '%\'');
        }

        if(conversion.size() > 0) {
            filterFields.add('dealer__ConversionModel__c in (\'' + String.join(conversion, '\', \'') + '\')');
        }

        if(location.size() > 0) {
            filterFields.add('dealer__Store_Location__c in (\'' + String.join(location, '\', \'') + '\')');
        }

        if(status.size() > 0) {
            filterFields.add('dealer__Status__c in (\'' + String.join(status, '\', \'') + '\')');
        }

        if(rampOperation.size() > 0) {
            filterFields.add('dealer__Ramp_Operation__c in (\'' + String.join(rampOperation, '\', \'') + '\')');
        }

        if(rampLocation.size() > 0) {
            filterFields.add('dealer__Ramp_Location__c in (\'' + String.join(rampLocation, '\', \'') + '\')');
        }

        if(appraiser.size() > 0) {
            filterFields.add('dealer__Appraised_By__c in (\'' + String.join(appraiser, '\', \'') + '\')');
        }

        if(vin != null && vin.length() == 17) {
            filterFields.add('dealer__Service_Vehicle__r.dealer__VIN__c = \'' + vin + '\'');
        }

        if(appraisalMin != null && appraisalMin != 0) {
            filterFields.add('dealer__Appraised_Value__c >= ' + appraisalMin );
        }

        if(appraisalMax != null && appraisalMax != 0) {
            filterFields.add('dealer__Appraised_Value__c <= ' + appraisalMax);
        }

        String finalQuery = query;
        if(filterFields.size() > 0) {
            finalQuery += ' WHERE ' + String.join(filterFields, ' AND ');
            filter = String.join(filterFields, ' AND ');
        }

        finalQuery += ' LIMIT ' + maxRows;

        System.debug(finalQuery);

        filterFields = new List<String>();
        appraisals = Database.query(finalQuery);
        
    }

     /**
     * GetJSON description
     * @param  filterBy 
     * @param  rowlimit 
     * @param  offset   
     * @return JsonResponse
     * @description
     */
    @RemoteAction
    public static JsonResponse GetJSON(String filterBy, String rowlimit, String offset)
    {
         query += ' WHERE ' + filterBy + ' LIMIT ' + rowlimit + ' OFFSET ' + offset;
         string countQuery = 'SELECT Count() FROM dealer__Appraisal__c WHERE ' + filterBy;

         JsonResponse response = new JsonResponse();
         response.appraisals =  Database.query(query);
         response.total = Database.countQuery(countQuery);

         return response;
    }

    /**
     * GetInitialJSON
     * @return String
     * @description
     */
    public String GetInitialJSON
    {
        get
        {
            JsonResponse response = new JsonResponse();
            response.appraisals = appraisals;

            if(filter != null) {
                string countQuery = 'SELECT Count() FROM dealer__Appraisal__c WHERE ' + filter;
                response.total = Database.countQuery(countQuery);
            }

            return JSON.Serialize(response);
        }
    }

    /**
     * JsonResponse
     * @return class
     * @description
     */
    public inherited sharing class JsonResponse
    {
        Integer total;
        List<dealer__Appraisal__c> appraisals;
    }

    /**
     * clearFilters 
     * @return void
     * @description
     */
    public void clearFilters() 
    {
        year = new List<String>();
        make = new List<String>();
        status = new List<String>();
        rampOperation = new List<String>();
        rampLocation = new List<String>();
        conversion = new List<String>();
        appraiser = new List<String>();
        location = new List<String>();

        model = '';
        vin = '';
        appraisalMin = null;
        appraisalMax = null;
    }

    /**
     * getYears 
     * @return List<SelectOption> 
     * @description
     */
    public List<SelectOption> getYears() 
    {
        List<SelectOption> options = new List<SelectOption>();
        
        Date d = Date.today();
        Integer current_year = d.year() + 1; 
        Integer current_back = current_year - 20;

        for(Integer y = current_year; y>=current_back; y--) {
            options.add(new SelectOption(String.valueOf(y), String.valueOf(y)));
        }
        
        return options; 
    }

    /**
     * getMakes 
     * @return List<SelectOption>
     * @description
     */ 
    public List<SelectOption> getMakes() 
    { 
        List<SelectOption> options = new List<SelectOption>();

        options.add(new SelectOption('Ford', 'Ford'));
        options.add(new SelectOption('Dodge', 'Dodge'));
        options.add(new SelectOption('Ram', 'Ram'));
        options.add(new SelectOption('Chevrolet', 'Chevrolet'));    
        options.add(new SelectOption('Chevy', 'Chevy'));    
        options.add(new SelectOption('Chrysler', 'Chrysler'));
        options.add(new SelectOption('GMC', 'GMC'));   
        options.add(new SelectOption('Honda', 'Honda'));
        options.add(new SelectOption('Nissan', 'Nissan'));
        options.add(new SelectOption('Toyota', 'Toyota'));

        return options;  
    }

    /**
     * getRampOperations
     * @return List<SelectOption>
     * @description
     */
    public List<SelectOption> getRampOperations() 
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult = dealer__Appraisal__c.dealer__Ramp_Operation__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    /**
     * getRampLocations
     * @return <SelectOption> 
     * @description
     */
    public List<SelectOption> getRampLocations() 
    { 
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        dealer__Appraisal__c.dealer__Ramp_Location__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    /**
     * getConversions 
     * @return List<SelectOption>  
     * @description
     */
    public List<SelectOption> getConversions() 
    { 
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        dealer__Appraisal__c.dealer__ConversionModel__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    /**
     * getAppraisalStatuses
     * @return List<SelectOption>
     * @description
     */ 
    public List<SelectOption> getAppraisalStatuses() 
    {
        List<SelectOption> options = new List<SelectOption>();
        //options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        dealer__Appraisal__c.dealer__Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    /**
     * getLocations
     * @return public List<SelectOption>
     * @description
     */
    public List<SelectOption> getLocations() 
    {
        List<SelectOption> options = new List<SelectOption>();
        List<dealer__Dealer_Location__c> locations = [SELECT Id, Name FROM dealer__Dealer_Location__c];

        for(dealer__Dealer_Location__c location : locations) {
            options.add(new SelectOption(location.Id, location.Name));
        }
        return options;
    }

    /**
     * getAppraisers 
     * @return List<SelectOption>
     * @description
     */ 
    public List<SelectOption> getAppraisers() 
    {
        List<SelectOption> options = new List<SelectOption>();
        Map<Id,String> mapUsers = new Map<Id,String>();
        //List<User> users = [SELECT Id, Name FROM User];
        
        //W-000461 begin
        List<dealer__Appraisal__c> listAppraisal = new List<dealer__Appraisal__c>();
        listAppraisal = [select id,dealer__Appraised_By__c,dealer__Appraised_By__r.Name from dealer__Appraisal__c where dealer__Appraised_By__c!=null limit 50000];
        
        for(dealer__Appraisal__c appraisal:listAppraisal){
            mapUsers.put(appraisal.dealer__Appraised_By__c,appraisal.dealer__Appraised_By__r.Name);
        }
        /*for(User user : users) {
            options.add(new SelectOption(user.Id, user.Name));
        }*/
        for(Id userId : mapUsers.keyset()) {
            options.add(new SelectOption(userId, mapUsers.get(userId)));
        }
        //W-000461 end
        return options;

    }

}