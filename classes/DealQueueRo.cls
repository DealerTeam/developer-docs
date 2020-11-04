/**
 * DealQueueRo
 * @description
 */ 
public class DealQueueRo implements Queueable {
    
    /**
     * @description
     */
    private Id dealId;
    
    /**
     * DealQueueRo 
     * @param  id 
     * @description
     */
    public DealQueueRo(Id id) 
    {
        this.dealId = id;
    }
    
    /**
     * execute description
     * @param  context 
     * @return void
     * @description
     */
    public void execute(QueueableContext context)
    {
            Deal__c thedeal = [SELECT Id, Buyer__c, DeliveryRepairOrder__c, Vehicle__c,
                Vehicle__r.Mileage__c, VIN__c,
                Service_Vehicle__c, Store_Location__c, Mileage__c
                FROM Deal__c
                WHERE Id =: dealId
            ];
            ServiceRepairOrderAPI.createRepairOrderFromDeal(thedeal);
    }
}