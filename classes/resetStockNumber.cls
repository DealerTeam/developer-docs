global class resetStockNumber implements Schedulable{
    global void execute (SchedulableContext ctx) {
        DMS_Settings__c settings = [SELECT Id, Stock_Number_Current_Index__c FROM DMS_Settings__c WHERE Name = 'ActiveSettings' limit 1 FOR UPDATE];
        settings.Stock_Number_Current_Index__c = 0;

        try {
            update settings;
        } Catch(DmlException e) {
           throw new resetStockNumberException(e.getMessage());
        }
    }
    public class resetStockNumberException extends Exception{}
}