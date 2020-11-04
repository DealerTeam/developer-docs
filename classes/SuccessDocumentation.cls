/**
 * Success Documentation Controller 
 */
public without sharing class SuccessDocumentation {
    public SuccessDocumentation() {}
    
    public String getsuccessDocumentationContent() {
        
		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();		
        	for(dealer__Success_Documentation__mdt sd : [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, 
                                                            dealer__Metadata_Type__c, dealer__Success_URL__c, dealer__Metadata_Name__c, 
                                                            QualifiedApiName 
                											FROM dealer__Success_Documentation__mdt]) {
                                                                
						gen.writeStringField(sd.dealer__Metadata_Name__c, sd.dealer__Success_URL__c);                                                                
                    
                }
        gen.writeEndObject();
        
        return gen.getAsString();
    }
    
    public String getObjectKeys() {

        JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
        
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();  
        for(Schema.SObjectType f : gd) {        	
            if(f.getDescribe().isCustom()) {
		        gen.writeStringField(f.getDescribe().getKeyPrefix(), f.getDescribe().getName());			
            }
        }
        
        gen.writeEndObject();
        
        return gen.getAsString();
    }
}