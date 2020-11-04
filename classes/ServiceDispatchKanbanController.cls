public class ServiceDispatchKanbanController {

    public static final String REPAIR_ORDER_MOVED = '{0} was moved successfully to {1} and column ordering was updated.';
    
    //////////////////
    //Aura Handlers //
    //////////////////

    @AuraEnabled
    public static DataFetchResult initialize() {
        DataFetchResult result = new DataFetchResult();

        getDispatchStatuses( result );
        fetchDispatchEvents( result );

        return result;
    }
    
    @AuraEnabled
    public static StatusUpdateResult updateDispatchStatus( Id dispatchEventId, String newStatus, List<String> ordering ) {

        System.debug(dispatchEventId);

        try {
            DispatchEvent__c de = [
                SELECT  Id
                        ,Name
                FROM    DispatchEvent__c
                WHERE   Id = :dispatchEventId
            ];
        
            UPDATE new DispatchEvent__c(Id=de.Id, Status__c=newStatus);
            
            /**
             * Update all the RO Dispatch Event records
             * with the new ordering.
             */
            List<DispatchEvent__c> dispatchUpdate = new List<DispatchEvent__c>();
            Integer counter = 1;
            for( String recId : ordering ) {
                dispatchUpdate.add( new DispatchEvent__c( Id = recId, Order__c = counter++ ) );
            }
            
            UPDATE dispatchUpdate;
        
            return new StatusUpdateResult(
                TRUE,
                'Success',
                String.format( REPAIR_ORDER_MOVED, new List<String>{ de.Name, newStatus } )
            );
        }
        catch( Exception ex ) {        
            return new StatusUpdateResult(
                FALSE,
                'Error',
                ex.getMessage()
            );
        }
    }        
    
    ///////////////////
    //Public Classes //
    ///////////////////
    
    public class Column {
        @AuraEnabled
        public String label 					{ get; set; }
        
        @AuraEnabled
        public Boolean isDropEnabled 			{ get; set; }
        
        public Column( String label, Boolean isDropEnabled ) {
            this.label = label;
            this.isDropEnabled = isDropEnabled;
        }
    }
    
    public class DataFetchResult {
        @AuraEnabled
        public List<Column> columns        		{ get; set; }

        @AuraEnabled
        public Map<String, List<DispatchEvent__c>> rows    	{ get; set; }
    }

    public class StatusUpdateResult {
        @AuraEnabled
        public Boolean isSuccess				{ get; set; }

        @AuraEnabled
        public String title						{ get; set; }
        
        @AuraEnabled
        public String message					{ get; set; }

        public StatusUpdateResult( Boolean isSuccess, String title, String message ) {
            this.isSuccess  = isSuccess;
            this.title      = title;
            this.message    = message;
        }
    }

    ///////////////////////////
    //Private Helper Methods //
    ///////////////////////////
    
    static void getDispatchStatuses( DataFetchResult result ) {
        result.columns = new List<Column>();
        
        String protectedStatuses = '';
        
        Set<String> dropProhibtedCols = new Set<String>();
        if( protectedStatuses != NULL ) {            
            dropProhibtedCols.addAll( protectedStatuses.split( ',' ) );
        }
        
        for(String ds : DealerMetadata.getSobjectPicklistValues('dealer__DispatchEvent__c', 'dealer__Status__c')) {
            result.columns.add(
                new Column(
                    ds,
                    !dropProhibtedCols.contains( ds )
                )
			);
        }
    }
    
    static void fetchDispatchEvents( DataFetchResult result ) {
        List<DispatchEvent__c> ros = [
            SELECT  Id
                    ,Name
                    ,OwnerId
                    ,Owner.Name
                    ,Status__c
            		,Order__c
                    ,Resource__c
                    ,Resource__r.Name
                    ,ServiceRepairOrderRef__c
                    ,ServiceRepairOrderRef__r.Name
                    ,ServiceRepairOrderRef__r.Waiting__c
                    ,ServiceRepairOrderRef__r.Days_Down__c
                    ,ServiceRepairOrderRef__r.Customer__r.Name
                    ,ServiceRepairOrderRef__r.Vehicle__c
                    ,ServiceRepairOrderRef__r.Vehicle__r.Name
                    ,ServiceRepairOrderRef__r.Expected_Service_End__c
                    ,ServiceRepairOrderRef__r.Number_of_Repair_Lines__c
                    ,ServiceRepairOrderRef__r.Service_Advisor__c
                    ,ServiceRepairOrderRef__r.Service_Advisor__r.Name
            FROM    DispatchEvent__c
            ORDER BY Order__c ASC
        ];
        
        result.rows = new Map<String, List<DispatchEvent__c>>();
        
        for( Column col : result.columns ) {
            result.rows.put( col.label, new List<DispatchEvent__c>{} );
        }
        
        for( DispatchEvent__c ro : ros ) {
            if( result.rows.containsKey( ro.Status__c ) ) {
                result.rows.get( ro.Status__c ).add( ro );
            }
        }
    }
}