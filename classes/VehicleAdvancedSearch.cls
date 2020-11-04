/**
 * VehicleAdvancedSearch
 * Used in VehicleSearchAdvanced.page
 * Tested by: VehicleAdvancedSearch_TC
 *
 */
public with sharing class VehicleAdvancedSearch {

    public Boolean debugmode {get;set;}
    public Boolean showLink {get; set;}
    public String proposalId {get;set;}

    public String stockNum { get; set; }
    public String vehType { get; set; }
    public String year { get; set; }
    public String make { get; set; }
    public String model { get; set; }
    public String trim { get; set; }
    public String recordType { get; set; }
    public String minPrice { get; set; }
    public String maxPrice { get; set; }
    public String minOdometer { get; set; }
    public String maxOdometer { get; set; }
    public String convMfg { get; set; }
    public String convModel { get; set; }
    public String minConv { get; set; }
    public String maxConv { get; set; }
    public String minChassis { get; set; }
    public String maxChassis { get; set; }
    public String storeLocation { get; set; }
    //public String region { get; set; }
    public String rampType { get; set; }
    public String rampOperation { get; set; }
    public String extColor { get; set; }
    public String intColor { get; set; }
    public String interior { get; set; }
    public String rampLoc { get; set; }
    public String kneel { get; set; }
    public String status { get; set; }
    public String newUsedOther { get; set; }

    private String query {get;set;}

    private List<User> user {get;set;}
    private String userLocKey {get;set;}
    private Dealer_Location__c userLoc {get;set;}
    private Double userLocLat {get;set;}
    private Double userLocLng {get;set;}

    public List<Vehicle_Inventory__c> vehResult = new List<Vehicle_Inventory__c>();

    public VehicleAdvancedSearch() {
        
        debugmode = false;

        if ( status == null || status == '') {
            // status = 'Ready for Sale';
        }

        // Setup user location for filtering
        String userId = UserInfo.getUserId();
        this.user = [Select Id, Division from User where Id=:userId limit 1]; // DR1a
        userLocKey = this.user[0].Division; // DR1a
        if(userLocKey==null) {
            userLocKey = 'AKR';
        }

        try { 
           userLoc = [SELECT Id, Name, Physical_Location__Latitude__s, Physical_Location__Longitude__s FROM Dealer_Location__c WHERE Company_Number__c =: userLocKey LIMIT 1];
        } catch(Exception e) {  // BLL2a
           userLoc = new Dealer_Location__c(Name='Richfield, OH', Physical_Location__Latitude__s=41.22319, Physical_Location__Longitude__s=-81.63699); 
        }  

        userLocLat = userLoc.Physical_Location__Latitude__s;
        userLocLng = userLoc.Physical_Location__Longitude__s;

        if(storeLocation == null || storeLocation =='') {
            storeLocation = userLoc.Name;
        }

        System.debug('Lat: '+userLocLat+' - Lng: '+userLocLng);

        if(ApexPages.currentPage().getParameters().get('proposalId')!=null) {
            proposalId = ApexPages.currentPage().getParameters().get('proposalId');
        }

        // Auto populate search fields
        if(ApexPages.currentPage().getParameters().get('year')!=null) {
            year = ApexPages.currentPage().getParameters().get('year');
        }
        if(ApexPages.currentPage().getParameters().get('make')!=null) {
            make = ApexPages.currentPage().getParameters().get('make');
        }
        if(ApexPages.currentPage().getParameters().get('model')!=null) {
            model = ApexPages.currentPage().getParameters().get('model');
        }
		/* Commented By KVP
        if ( ApexPages.currentPage().getParameters().get('year')!='' || ApexPages.currentPage().getParameters().get('make')!='' || ApexPages.currentPage().getParameters().get('model')!='' ) {
            doSearch();

        }
        */
        // Added By KVP
		if ( ApexPages.currentPage().getParameters().get('year')!= null || ApexPages.currentPage().getParameters().get('make')!= null || ApexPages.currentPage().getParameters().get('model')!= null ) {
            doSearch();

        }
		
        // Check to see if we are running in Debug mode (displays SQL Statement)
        if( ApexPages.currentPage().getParameters().get('debug')=='true') {
            debugmode=true;
        }
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms.dealer__Vehicle_Search_Default_Status__c != null && dms.dealer__Vehicle_Search_Default_Status__c != ' '){
            status = dms.dealer__Vehicle_Search_Default_Status__c;
        }
        openTab();

    }
    
    public void openTab() {
        System.debug('OPEN TABBBBBBBBBBBBBBBBBB');
        if(ApexPages.currentPage().getParameters().get('sfdc.tabname')!=null){
            showLink = true;
        
    } else{
        showLink = false;
        System.debug('OPEN TABBBBBBBBBBBBBBBBBB'+showLink);
    }
    
   // return null;
    }
    
    

    public PageReference reset() {
        PageReference page = new PageReference(System.currentPageReference().getURL());
        page.setRedirect(true);
        return page;
    }

    public String getQueryString() {
        return buildQuery();
    }

    public String buildQuery() {
        String queryStart = 'SELECT Id, Name, New_Used_Other__c, RecordType.Name, Year__c, Make__c, Model__c,Trim_Level__c, Mileage__c, Exterior_Color__c ,Conv_MFG__c, Conversion_Model__c, Store_Location__r.Name, Retail_Price__c, Conversion_Cost__c, Vehicle_Cost__c, Total_Vehicle_Cost__c, Suggested_Retail_Price__c, Status_Code__c, Stock_Number__c, Vehicle_Type__c, Interior_Color__c, Interior__c, Ramp_Location__c, MV_Ranp_Operation__c, MV_Ramp_Type__c, Coded_Cost__c, Days_in_Stock__c, SuggestedRetailPrice__c FROM Vehicle_Inventory__c ';

        //Vehicle_Inventory__c WHERE ';

        // Make a list for the Query Parts.
        List<String> qBits = new List<String>();

        // Build Query Bits
        if(year != '' && year != null) { 
            qBits.add(' Year__c LIKE \'%' +year+ '%\'' );
        }

        if(make != '' && make != null) { 
            qBits.add(' Make__c LIKE \'%' +make+ '%\'' );
        }

        if(model != '' && model != null) { 
            qBits.add(' Model__c LIKE  \'%' +model+ '%\'' );
        }

        if(trim != '' && trim != null) { 
            qBits.add(' Trim_Level__c LIKE  \'%' +trim+ '%\'' );
        }

        if(storeLocation != ''  && storeLocation != null && storeLocation != 'All') { 
            qBits.add(' Store_Location__r.Name LIKE  \'%' +storeLocation+ '%\'' );
        }       

        if(vehType != ''  && vehType != null && vehType != 'All') { 
            qBits.add(' Vehicle_Type__c = \'' +vehType+ '\'' );
        }

        // RecordType
        if(recordType != '' && recordType != 'All'  && recordType != null) { 
            qBits.add(' RecordType.Name = \''+recordType+'\' ');
        }

        // New_Used_Other
        if(newUsedOther != '' && newUsedOther != null && newUsedOther != 'All') { 
            qBits.add(' New_Used_Other__c = \''+newUsedOther+'\' ');
        }
        
        
        // retail Price (numeric)
        if(minPrice != '' && minPrice != null) { 
            // BLL4d qBits.add(' Retail_Price__c >= '+ minPrice +' ' );
            qBits.add(' SuggestedRetailPrice__c >= '+ minPrice +' ' );  // BLL4a
        }

        if(maxPrice != '' && maxPrice != null) { 
            // BLL4d qBits.add(' Retail_Price__c <= '+ maxPrice +' ' );
            qBits.add(' SuggestedRetailPrice__c <= '+ maxPrice +' ' );  // BLL4a
        }

        /** Advanced Fields **/

        if(extColor != ''  && extColor != null) { 
            qBits.add(' Exterior_Color__c LIKE  \'%' +extColor+ '%\'' );
        }
        if(intColor != ''  && intColor != null) { 
            qBits.add(' Interior_Color__c LIKE  \'%' +intColor+ '%\'' );
        }
        if(interior != ''  && interior != null && interior != 'All') { 
            qBits.add(' Interior__c =  \'' +interior+ '\'' );
        }

        // Mileage (numeric)
        if(minOdometer != '' && minOdometer != null) { 
            qBits.add(' Mileage__c >= '+ minOdometer +' ' );
        }

        if(maxOdometer != '' && maxOdometer != null) { 
            qBits.add(' Mileage__c <= '+ maxOdometer +' ' );
        }

        // Conversion
        if(convMfg != '' && convMfg != null && convMfg != 'All') { 
            qBits.add(' Conv_MFG__c LIKE \'%' +convMfg+ '%\'' );
        }

        if(convModel != '' && convModel != null && convModel != 'All') { 
            qBits.add(' Conversion_Model__c LIKE  \'%' +convModel+ '%\'' );
        }

        if(rampType != ''  && rampType != null && rampType != 'All') { 
            qBits.add(' MV_Ramp_Type__c =  \'' +rampType+ '\'' );
        }
        if(rampOperation != ''  && rampOperation != null && rampOperation != 'All') { 
            qBits.add(' MV_Ranp_Operation__c =  \'' +rampOperation+ '\'' );
        }
        // BLL3a don't forget ramp location & kneeling
        if(!String.isBlank(rampLoc) && rampLoc!='All') {
            qBits.add(' Ramp_Location__c = \'' + rampLoc + '\'');
        }
        if(!String.isBlank(kneel) && kneel!='All') {
            if (kneel=='Yes') {
                qBits.add(' (Kneeling__c = \'' + kneel + '\' or Kneeling__c = \'1\')');
            }
            if (kneel=='No') {
                qBits.add(' (Kneeling__c = \'' + kneel + '\' or Kneeling__c = \'0\')');
            }
        }
        // BLL3a end

        // Conversion COST (numeric)
        if(minConv != '' && minConv != null) { 
            qBits.add(' Conversion_Cost__c >= '+ minConv +' ' );
        }

        if(maxConv != '' && maxConv != null) { 
            qBits.add(' Conversion_Cost__c <= '+ maxConv +' ' );
        }

        // Chassis COST (numeric)
        if(minChassis != '' && minChassis != null) { 
            qBits.add(' Vehicle_Cost__c >= '+ minChassis +' ' );
        }

        if(maxChassis != '' && maxChassis != null) { 
            qBits.add(' Vehicle_Cost__c <= '+ maxChassis +' ' );
        }

        if(maxChassis != '' && maxChassis != null) { 
            qBits.add(' Vehicle_Cost__c <= '+ maxChassis +' ' );
        }

        if(status != '' && status != null  && status != 'All') { 
            qBits.add(' Status_Code__c = \'' +status+ '\'' );
        }

        if(status == null || status == '') {
            qBits.add(' Status_Code__C = \'Ready For Sale\'');
        }      

        // BLL1d - Omit Delivered & Sold - Not Delivered from "All" selection
        // default bits
        if (status!=null && status=='All') {
            qBits.add(' Status_Code__c != \'Delivered\'' );
            //qBits.add(' Status_Code__c != \'Sold - Not Delivered\' ' );  //BLL1d only restrict "Delivered"!
        }
        // BLL1d end block

        // StockNumber Trumps All
        if(stockNum != '' && stockNum != null) { 
            qBits.clear();
            qBits.add(' Stock_Number__c LIKE \'%' +stockNum+ '%\'' );
        }  

        // Start building Query
        query = queryStart;

        // Then build the query string from the Bits.
        for(Integer a = 0; a < qBits.size(); a++){

            // Prefix the bits with some query operators
            if (a == 0) {
                 query += ' WHERE ';
            }
            if (a > 0) {
                query += ' AND ';
            }
            // Concatenate the bits
            query += qBits.get(a);
        }

        // Sort by location
        //  AND Status_Code__c != \'Delivered\'
        if(userLoc != null && userLocLat != null && userLocLng != null) {
            query += ' ORDER BY DISTANCE(Store_Location__r.Physical_Location__c, GEOLOCATION('+userLocLat+','+userLocLng+'), \'mi\') DESC ';
        } 

        query += 'LIMIT 1000';

        return query;
    }

    public PageReference doSearch() {
        if( query != null && query != ''){

            System.debug(buildQuery());

            vehResult = Database.query( buildQuery() );

        }
        System.debug('-----vehResult-----'+vehResult);
        if (vehResult.size() == 0) {
            ApexPages.Message noResults = new ApexPages.Message(ApexPages.Severity.INFO, 'No results Found!');
            ApexPages.addMessage(noResults);
        }
        return null;
    }

    public PageReference returnToDeal() {
        PageReference p = new PageReference('/apex/QuoteManager?id='+proposalId+'#sec_chassis');
        p.setRedirect(true);
        return p;
    }

    public List<Vehicle_Inventory__c> getVehResult(){
        return vehResult;
    }

    /** PICKLIST VALUES */

    public List<SelectOption> getYears() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'All'));

        // JVK1
        Date d = Date.today();
        Integer current_year = d.year() + 1; 
        Integer current_back = current_year - 20;

        for(Integer y = current_year; y>=current_back; y--) {
            options.add(new SelectOption(String.valueOf(y), String.valueOf(y)));
        }
        // JVK1 End

        return options;  
    }

    public List<SelectOption> getMakes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'All'));
        options.add(new SelectOption('Ford', 'Ford'));
        options.add(new SelectOption('Dodge', 'Dodge'));
        options.add(new SelectOption('Ram', 'Ram'));
        options.add(new SelectOption('Chrysler', 'Chrysler'));
        options.add(new SelectOption('Honda', 'Honda'));
        options.add(new SelectOption('Nissan', 'Nissan'));
        options.add(new SelectOption('Toyota', 'Toyota'));

        /*
        List<AggregateResult> makes = [Select Make__c from Vehicle_Inventory__c 
                                                        Where Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        and Make__c != null
                                                        and Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        Group By Make__c
                                                        Order By Make__c ASC
                                                        LIMIT 5000];
        for( AggregateResult m : makes) {
            if((String)m.get('Make__c') != null) {
                options.add( new SelectOption( (String)m.get('Make__c') ,(String)m.get('Make__c') ) );
            }
        } 
        */


        return options;  
    }

    public List<SelectOption> getModels() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'All'));
        /*
        List<AggregateResult> models = [Select Model__c from Vehicle_Inventory__c 
                                                        Where Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        and Model__c != null
                                                        and Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        Group By Model__c
                                                        Order By Model__c ASC
                                                        LIMIT 5000];
        for( AggregateResult m : models) {
            if((String)m.get('Model__c') != null) {
                options.add( new SelectOption( (String)m.get('Model__c') ,(String)m.get('Model__c') ) );
            }
        } 
        */
        return options;  
    }

    public List<SelectOption> getTrims() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'All'));
        /*
        List<AggregateResult> trims = [Select Trim_Level__c from Vehicle_Inventory__c 
                                                        Where Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        and Trim_Level__c != null
                                                        and Status_Code__c != 'Delivered' 
                                                        and Status_Code__c != 'Sold - Not Delivered'
                                                        Group By Trim_Level__c
                                                        Order by Trim_Level__c ASC
                                                        LIMIT 5000];
        for( AggregateResult m : trims) {
            if((String)m.get('Trim_Level__c') != null) {
                options.add( new SelectOption( (String)m.get('Trim_Level__c') ,(String)m.get('Trim_Level__c') ) );
            }
        } 
        */
        return options;  
    }   

    public List<SelectOption> getRecordTypes() {
        List<SelectOption> recordTypes = new List<SelectOption>();
        recordTypes.add(new SelectOption('All','All'));
        recordTypes.add(new SelectOption('Demo','Demo'));
        recordTypes.add(new SelectOption('New','New'));
        recordTypes.add(new SelectOption('Rental','Rental'));
        recordTypes.add(new SelectOption('Used','Used'));
        return recordTypes;
    }

    public List<SelectOption> getnewUsedOthers() {
        List<SelectOption> newUsedOthers = new List<SelectOption>();
        newUsedOthers.add(new SelectOption('All','All'));
        newUsedOthers.add(new SelectOption('Commercial','Commercial'));
        newUsedOthers.add(new SelectOption('Company Vehicle','Company Vehicle'));
        newUsedOthers.add(new SelectOption('Demo','Demo'));
        newUsedOthers.add(new SelectOption('Demo - Not For Sale','Demo - Not For Sale'));
        newUsedOthers.add(new SelectOption('Fixed Asset','Fixed Asset'));
        newUsedOthers.add(new SelectOption('New','New'));
        newUsedOthers.add(new SelectOption('New/Used','New/Used'));
        newUsedOthers.add(new SelectOption('Other','Other'));
        newUsedOthers.add(new SelectOption('Rental','Rental'));
        newUsedOthers.add(new SelectOption('Rental - Not For Sale','Rental - Not For Sale'));
        newUsedOthers.add(new SelectOption('Used','Used'));
        newUsedOthers.add(new SelectOption('Wholesale','Wholesale'));
        return newUsedOthers;
    }

    public List<SelectOption> getInteriors() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Interior__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    public List<SelectOption> getVehTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Unit_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }  

        return options;     
    }

    public List<SelectOption> getBranchLocations() {
        List<SelectOption> options = new List<SelectOption>();
        // Get the Users Current Region
        User u = user[0]; // DR1c
        try { // BLL2a
        Dealer_Location__c loc = [Select Id, Name from Dealer_Location__c where Company_Number__c=:u.Division limit 1];

        if(storeLocation==null || storeLocation=='') {
            storeLocation=loc.Name;
        }

        options.add(new SelectOption(loc.Name, loc.Name));
        } catch(Exception e) {} // BLL2a
        
        options.add(new SelectOption('All','All'));
        List<AggregateResult> vehs = [SELECT Name From Dealer_Location__c group by Name limit 5000];
            
        for( AggregateResult v : vehs) {
            if((String)v.get('Name') != null) {
                options.add( new SelectOption( (String)v.get('Name') ,(String)v.get('Name') ) );
            }
        }       
        return options;     
    }

    public List<SelectOption> getStatusCodes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Ready For Sale', 'Ready For Sale'));
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Status_Code__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
            //if(f.getLabel() != 'Delivered') {  // BLL1d Should be able to search specifically for these!
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            //} // BLL1d
        }            

        return options;         
    }

    public List<SelectOption> getRampTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.MV_Ramp_Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    public List<SelectOption> getRampOperationItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.MV_Ranp_Operation__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    /** Conversion Fields */
    public List<SelectOption> getConversions() { 
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Conv_MFG__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    public List<SelectOption> getConversionModels() { 
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Conversion_Model__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }

    public List<SelectOption> getRampLocations() { 
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));

        Schema.DescribeFieldResult fieldResult =
        Vehicle_Inventory__c.Ramp_Location__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    // used by the visualforce page to send the link to the right dom element
    public string getFormTag() {
        return System.currentPageReference().getParameters().get('frm');
    }
    
    // used by the visualforce page to send the link to the right dom element for the text box
    public string getTextBox() {
        return System.currentPageReference().getParameters().get('txt');
    }
    
    public class AdvancedSearchErrorException extends Exception{}

}