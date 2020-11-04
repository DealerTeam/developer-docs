/**
 * CustomObjects
 * @description
 */
public without sharing class CustomObjects {
        
       /**
        * CustomObjects 
        * @description
        */
       public CustomObjects() {}
        
       /**
        * getObjectType 
        * @param  subject 
        * @return  Schema.SObjectType
        * @description
        */ 
       public static Schema.SObjectType getObjectType(id subject)
       {
                Schema.SObjectType result;
                string target = subject;
                Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
                
                string keyPrefix;

                for(Schema.SObjectType describe: gd.values() ){
                        keyPrefix = describe.getDescribe().getKeyPrefix();
                        if(keyPrefix != null && target.startsWith(keyPrefix)){
                                result = describe;
                                break; //no need to keep looking
                        }
                }
                return result;
       }
}