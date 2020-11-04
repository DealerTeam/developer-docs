/**
 *  	PartNew LC Controller
 * 		Test class: PartCreateControllerTest
 * */
public with sharing class PartCreateController {
    
    @AuraEnabled
    public static String Company(){
        
         try{
             User u = [SELECT Id, Division FROM User WHERE Id =: UserInfo.getUserId()];
             if(u.Division != null){
                Dealer_Location__c loc = [SELECT Id, Name From Dealer_Location__c WHERE Company_Number__c =: u.Division];
        		return loc.Id;
             }
        }catch(QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
        
        return null;
    }
    
    @AuraEnabled
    public static dealer__Parts_Master__c getPartMasterById(String pmId){
              
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        try{
             pm = [SELECT Id, Name, dealer__Cost__c, dealer__Part_Description__c, dealer__Retail_Price__c, dealer__Product_Tax_Code__c, dealer__Jobber_Price__c  
                   From dealer__Parts_Master__c WHERE Id =: String.escapeSingleQuotes(pmId)];
            
        }catch(QueryException e){
            throw new AuraHandledException(e.getMessage());
        }
        
        return pm;
    }
    
    @AuraEnabled
    public static String getObjectTypeById(Id pmId){
        
		return pmId.getSObjectType().getDescribe().getName();
    } 

}