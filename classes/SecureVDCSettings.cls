global with sharing class SecureVDCSettings {

    // public String decoderKey {get;set;}
    public String apiURL {get;set;}
    public String clientID {get;set;}
    public String decoderName {get;set;}
    public Boolean active {get;set;}
    public Boolean useBigObjectStorage {get;set;}
    public transient String decoderKey {get;set;}
    
    public dealer__VINDecoderCS__c instance {get;set;}
    global dealer__OrganizationDefaults__c OrgByDefault {get;set;}
    
    global SecureVDCSettings() {
        instance = dealer__VINDecoderCS__c.getValues('ActiveSettings');
        if(instance != null) {
            //Set Page Values
            decoderName = instance.dealer__DecoderName__c;
            clientID    = instance.dealer__DecoderClientID__c;
            apiURL      = instance.dealer__DecoderAPI_URL__c;
            active      = instance.dealer__Active__c;
            useBigObjectStorage = instance.dealer__UseBigObjectStorage__c;
            // decoderKey  = instance.dealer__DecoderKey__c;
        }
    }
    public PageReference saveVDCSettings() {
        
        if(this.decoderName != null && 
            this.clientID != null &&
            this.apiURL != null &&
            this.decoderKey != null) {
            
            if(instance != null) {
                instance.dealer__DecoderName__c = decoderName;
                instance.dealer__DecoderClientID__c = clientID;
                instance.dealer__DecoderAPI_URL__c = apiURL;
                instance.dealer__DecoderKey__c = decoderKey;
                instance.dealer__Active__c = active;
                instance.dealer__UseBigObjectStorage__c = useBigObjectStorage;
                update instance;
            } else {
                instance = new dealer__VINDecoderCS__c(Name='ActiveSettings',
                                                       dealer__DecoderName__c=decoderName,
                                                       dealer__DecoderClientID__c=clientID,
                                                       dealer__DecoderAPI_URL__c=apiURL,
                                                       dealer__DecoderKey__c=decoderKey,
                                                       dealer__Active__c = active,
                                                       dealer__UseBigObjectStorage__c = useBigObjectStorage
                                                     );
               insert instance;                                        
            }
       
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'All fields are required' ));
        }
        
        return null;
    }

    global static dealer__VINDecoderCS__c getOrgByDefault( String csValue ) {
        return dealer__VINDecoderCS__c.getValues(csValue);
    }

    global static Boolean active() {
        try {
            return VINDecoderCS__c.getValues('ActiveSettings').Active__c;
        } Catch(Exception e) {
            throw new SecureVDCException(e.getMessage());
        }
        return false;
    }
    
    global static void toggleBigObject(Boolean onoff)
    {
        try {
            VINDecoderCS__c secureDecoder = VINDecoderCS__c.getValues('ActiveSettings');
            secureDecoder.UseBigObjectStorage__c = onoff;
            update secureDecoder;
        } Catch(Exception e) {
            throw new SecureVDCException(e.getMessage());
        }
    }    

    global class SecureVDCException extends Exception {}
}