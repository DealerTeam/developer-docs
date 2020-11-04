/**
 * DMSImportsRESTService
 * @description
 */
@RestResource(urlMapping='/dms/import/*')
global with sharing class DMSImportsRESTService {
    
    /**
     * createRecords 
     * @return String
     * @description
     */ 
    @HttpPut
    global static String createRecords()
    {
        objectWrapper body = (objectWrapper)JSON.deserialize(System.RestContext.request.requestBody.toString(),objectWrapper.class);
        System.assert(body.objectApiName != null, 'Missing required variable in request: objectApiName');
        System.assert(body.objectJSON != null, 'Missing required variable in request: objectJSON');
        
        if(body.action != null && body.action == 'cleanrecords'){
            system.debug('cleaning');
            return DMSImportsAPI.cleanRecords(body.objectAPIName, body.objectJSON);
        } else {
            if(body.recordCount == 1 || body.objectApiName == 'dealer__Vehicle_Inventory__c'){
                return DMSImportsAPI.routeObject(body.objectApiName,body.objectJSON,null);
            } else {
                Id jobId = System.enqueueJob(new DMSImportsQueable(body.objectApiName,body.objectJSON));
                return jobId;
            }
        }
    }

    @HttpDelete
    global static String deleteRecord()
    {
        RestRequest req = RestContext.request;
        String bodyJSON = req.params.get('body');
        System.debug(bodyJSON); 
        objectWrapper body = (objectWrapper)JSON.deserialize(bodyJSON,objectWrapper.class);
        System.assert(body.objectApiName != null, 'Missing required variable in request: objectApiName');
        System.assert(body.objectJSON != null, 'Missing required variable in request: objectJSON');
        if(body.objectApiName == 'dealer__Vehicle_Inventory__c'){
            return DMSImportsAPI.deleteVehicleInventory(body.objectJSON);
        }else{
            return 'Object not yet defined for deletion.';
        }
    }

    
    /**
     * @description
     */
    public class objectWrapper{
        public String objectApiName;
        public String objectJSON;
        public Integer recordCount;
        public String action;
    }
}