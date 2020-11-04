/**
 * CarFaxCompController
 * @description
 */
public class CarFaxCompController 
{   
    /**
     * @description
     */
    public String vin {get;set;}

    /**
     * @description
     */
    public String type {get;set;}

    /**
     * @description
     */
    public CarFaxResponse response {get;set;}

    /**
     * @description
     */
    public String pageErrors {get;set;}

    /**
     * CarFaxCompController 
     * @description
     */ 
    Public CarFaxCompController()
    {
      pageErrors= null;
    }

    /**
     * RunCarFaxVF 
     * @return void
     * @description
     */ 
    public void RunCarFaxVF() 
    {
        Dealer_Location__c dealer = [Select Carfax_Username__c, Carfax_Password__c from Dealer_Location__c where Id =: Utility.lookupUserLocation()];
        CarFaxResponse resp = new CarFaxResponse();

        try{  
            CarFaxReportHandler.RequestResult result = CarFaxReportHandler.CreateRequest(new Set<string>{ vin }, dealer.Carfax_Username__c, dealer.Carfax_Password__c, type);
            if(!result.success){
                string error = 'An unknown error has occurred';
                // actual error message
                            system.debug(' 18result was : '+result);
                            system.debug('18result.messages was: ' + result.messages);
                            system.debug('18result.messages[0] was: ' + result.messages[0]);
                if(result.messages.size() > 0)
                    pageErrors = result.messages[0];

                response =  resp;     
            }
            else{
                pageErrors=null;
                resp.vehicle = [SELECT VIN__c, CarFaxAccidentCount__c, CarFaxAccidentIndicator__c, CarFaxBrandedTitleIndicator__c, CarFaxDamageIndicator__c, CarFaxFrameDamageIndicator__c,
                        CarFaxMajorProblemIndicator__c, CarfaxVHR__c, CarfaxNumberOfOwners__c, CarfaxServiceRecordCount__c From Service_Vehicle__c WHERE VIN__c = :vin];
                response = resp;
            }
        }
        catch(System.DmlException e){
            pageErrors = 'A DML Exception has occurred';
            response = resp;
        } 
    }
// W-002054 Josh C.

    /**
     * getVehicleVin 
     * @param  recordId 
     * @return string 
     * @description      
     */ 
    @AuraEnabled
    public static string getVehicleVin(String recordId)
    {
        system.debug('recordId '+recordId);
        String vehicleVin = '';
        
        if(recordId != null){
            try{
                String objectPrefix = recordId.subString(0,3);

                if (objectPrefix == Utility.getObjectKeyPrefix('dealer__Vehicle_Inventory__c')){
                    String vin = [SELECT VIN__c FROM dealer__Vehicle_Inventory__c WHERE Id = :recordId LIMIT 1].VIN__c;
                    vehicleVin = vin;

                }
                else if (objectPrefix == Utility.getObjectKeyPrefix('dealer__Service_Vehicle__c')){
                    String vin = [SELECT VIN__c FROM dealer__Service_Vehicle__c WHERE Id = :recordId LIMIT 1].VIN__c;
                    vehicleVin = vin;
                }
            }
            
            catch(QueryException e)
            {
                throw new AuraHandledException(e.getMessage());
            }
            
            catch(Exception e)
            {
                throw new AuraHandledException(e.getMessage());
            }
        }
        return vehicleVin;
    } 
// end W-00254
	
    /**
     * RunCarFaxReport 
     * @param  vin     
     * @param  reportType 
     * @return CarFaxResponse
     * @description      
     */
    @auraEnabled
    public static CarFaxResponse RunCarFaxReport(string vin, string reportType)
	{
		Dealer_Location__c dealer = [Select Carfax_Username__c, Carfax_Password__c from Dealer_Location__c where Id =: Utility.lookupUserLocation()];

        CarFaxResponse resp = new CarFaxResponse();
        //begin W-002058 J0sh C- if no username / password is found return a more specificerror message to help point end uers in the right direction.
        if(dealer.Carfax_Username__c == null || dealer.Carfax_Password__c == null) {
            string error = 'Your Carfax credentials are missing, please contact your Administrator.';
            resp.error = error;
        
            return resp;       
        }
        // End  W-002058 J0sh C


             try
            {  
                CarFaxReportHandler.RequestResult result = CarFaxReportHandler.CreateRequest(new Set<string>{ vin }, dealer.Carfax_Username__c, dealer.Carfax_Password__c, reportType);

                if(!result.success)
                {
                    // default error message
                    string error = 'An unknown error has occurred';
                    // actual error message
                    if(result.messages.size() > 0)
                        error = result.messages[0];

                    resp.error = error;
                    
                    return resp;              
                }
                else
                {
                    resp.vehicle = [SELECT VIN__c, CarFaxAccidentCount__c, CarFaxAccidentIndicator__c, CarFaxBrandedTitleIndicator__c, CarFaxDamageIndicator__c, CarFaxFrameDamageIndicator__c,
							CarFaxMajorProblemIndicator__c, CarfaxVHR__c, CarfaxNumberOfOwners__c, CarfaxServiceRecordCount__c From Service_Vehicle__c WHERE VIN__c = :vin];

                    return resp;
                }
            }
            catch(System.DmlException e)
            {
                resp.error = 'A DML Exception has occurred';
                return resp;
            } 
	}
    
    /**
     * CarFaxResponse
     * @description
     */ 
    public class CarFaxResponse
    {
        @auraEnabled
        public Service_Vehicle__c vehicle { get; set; }
        @auraEnabled
        public String error { get; set; }
    }

}