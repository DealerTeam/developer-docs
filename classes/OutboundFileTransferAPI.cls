public with sharing class OutboundFileTransferAPI {
    @future(callout=true)
    public static void futureCallout(Id oftId)
    {
        List<OFTJob__c> ofts = new List<OFTJob__c>();
        if(oftId == null){
            ofts = [SELECT Id, DestinationFileName__c, DynamicFileName__c, Delimiter__c, ColumnEncapsulation__c, ExportFileType__c, Password__c, Port__c, SOQLStatement__c, TransportProtocol__c, URN__c, Username__c, IsPrivate__c, UseBulkQuery__c, PredefinedFunction__c, StoreSelectionJSON__c FROM OFTJob__c WHERE Active__c = true];
        }
        else{
            ofts = [SELECT Id, DestinationFileName__c, DynamicFileName__c, Delimiter__c, ColumnEncapsulation__c, ExportFileType__c, Password__c, Port__c, SOQLStatement__c, TransportProtocol__c, URN__c, Username__c, IsPrivate__c, UseBulkQuery__c, PredefinedFunction__c, StoreSelectionJSON__c FROM OFTJob__c WHERE Active__c = true AND Id =: oftId];
        }

        //get endpoint
        String calloutUrl = !Utility.isSandbox() ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        //attach endpoint
        calloutUrl += '/oft/upload';
        //get instance url
        String instanceUrl = URL.getSalesforceBaseUrl().toExternalForm();
        //get session id
        String sessionId = UserInfo.getSessionId();
		String orgId = UserInfo.getOrganizationId();
        for(OFTJob__c oft : ofts){
            OutboundFileTransferAPI.OFTRequest reqWrapper = new OutboundFileTransferAPI.OFTRequest();
            reqWrapper.host = oft.URN__c;
            reqWrapper.port = (Integer)oft.Port__c;
            reqWrapper.user = oft.Username__c;
            reqWrapper.password = oft.Password__c;
            reqWrapper.filename = oft.DynamicFileName__c != null ? getDynamicFileName(oft) : oft.DestinationFileName__c + '.' + oft.ExportFileType__c;
            reqWrapper.transport = oft.TransportProtocol__c;
            reqWrapper.isPrivate = oft.IsPrivate__c;
            reqWrapper.isBulk = oft.UseBulkQuery__c;
            reqWrapper.predefinedFunction = oft.PredefinedFunction__c;
            reqWrapper.locations = oft.StoreSelectionJSON__c;
            if(oft.Delimiter__c != null){
                reqWrapper.delimiter = oft.Delimiter__c;
            }
            //This order allows for encapsulation to be none
            String encapsulation = oft.ColumnEncapsulation__c != null ? getEncapsulationType(oft.ColumnEncapsulation__c) : null;
            reqWrapper.encapsulation = encapsulation != null ? true : false;
            reqWrapper.encapsulationChar = encapsulation != null ? encapsulation : '"';

            reqWrapper.url = instanceUrl;
            reqWrapper.sessionId = sessionId;
            reqWrapper.organizationId = orgId;
            reqWrapper.query = oft.SOQLStatement__c;
            reqWrapper.recordId = oft.Id;
            reqWrapper.timeout = 30000;

            String resp = Test.isRunningTest() ? '' : EnterpriseControllerAPI.CallOut(calloutUrl, JSON.serialize(reqWrapper));

            if(Test.isRunningTest()) {
                return;  // Need to stub out mock framework
            }
        }

    }

    /**
     * runOFT Used to enable running from a quick action
     * @param  oftId record id of the OFTJob__c calling the quick action
     */
    @AuraEnabled
    public static void runOFT(Id oftId)
    {
        OFTJob__c oft = new OFTJob__c(Id = oftId, LastRunStatus__c = 'In Progress', LastRunResults__c = '');
        OFTJob__c existingOFT = [SELECT Id, Active__c FROM OFTJob__c WHERE Id =: oft.Id];
        if(existingOFT.Active__c == false){
            throw new AuraHandledException('Unable to process, this record is marked inactive. Please set as active prior to running.');
        }
        update oft;
        futureCallout(oftId);

    }



    public class OFTRequest{
        public string host {get;set;}
        public Integer port {get;set;}
        public string user {get;set;}
        public string password {get;set;}
        public string filename {get;set;}
        public string delimiter {get;set;}
        public Boolean encapsulation {get;set;}
        public string encapsulationChar {get;set;}
        public string organizationId {get;set;}
        public string url {get;set;}
        public string sessionId {get;set;}
        public string query {get;set;}
        public string recordId {get;set;}
        public integer timeout {get;set;}
        public string transport {get;set;}
        public Boolean isPrivate {get;set;}
        public Boolean isBulk {get;set;}
        public String predefinedFunction {get;set;}
        public String locations {get;set;}
    }


    /**
    * getDynamicFileName
    * @description evaluates a formula in visualforce formula syntax to allow for dynamic file naming
    * @param  oft Outbound File Transfer record with name to evaluate
    * @return String dynamic file name or the original ExportFileName if null, with .extensions for a complete file name
     */
    public static string getDynamicFileName(OFTJob__c oft)
    {
        string fileName = Utility.evaluateFormula(oft.DynamicFileName__c);
        if(fileName != null){
            return fileName + '.' + oft.ExportFileType__c;
        }

        return oft.DestinationFileName__c + '.' + oft.ExportFileType__c;
    }

    /**
    * getEncapsulationType
    * @description Converts encapsulation type name to it's literal representation
    * @param String encapsulation The name to convert 
    * @return String converted encapsulation type able to be ingested by middleware
    */
    public static string getEncapsulationType(String encapsulation)
    {
        switch on encapsulation{
            when 'Double Quote'{
                return '\"';
            }
            when 'Single Quote'{
                return '\'';
            }
            when 'None'{
                return null;
            }
        }

        return null;
    }

    @AuraEnabled
    public static OFTJob__c getOFT(String recordId)
    {
        return [SELECT Id, StoreSelectionJSON__c FROM OFTJob__c WHERE Id =: recordId];
    }

    /**
	* @method getAllLocations 
	* @description Queries for all Dealer Location records and returns them
	* @return List<Dealer_Location__c>
	*/
	@AuraEnabled
	public static List<Dealer_Location__c> getAllLocations()
    {
		return [SELECT Id, Name FROM Dealer_Location__c];
	}

    @AuraEnabled
    public static void saveStores(OFTJob__c job)
    {
        update job;
    }

}