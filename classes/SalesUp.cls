global with sharing class SalesUp {

    /**
    * create 
    * @description Creates a sales up and related records 
    * @param  salesUp wrapper containing all related objects needed for creation
    * @return         return description
    */
    global dealer__Sales_Up__c create(SalesUpWrapper salesUp) 
    {
        return SalesUpAPI.createSalesUp(salesUp);
    }

    /**
    * @description Wrapper class to hold sales up and all related objects needed by SalesUpAPI
    */
    global class SalesUpWrapper{

        /**
        * Determines whether or not duplicate matching rules will apply for related accounts and contacts
        */
        global Boolean BypassDuplicateMatching;
        
        /**
        * @description List of tasks to be created and related to the sales up
        */
        global List<Task> Tasks;

        /**
        * @description List of Desired Vehicles to be created and related to the sales up
        */
        global List<Desired_Vehicle__c> DesiredVehicles;

        /**
        * @description List of traffic logs to be created and related to the sales up
        */
        global List<Traffic_Log__c> TrafficLogs;
        // global List<Appraisal_Vehicle__c> AppraisalVehicles;

        /**
        * @description List of tasks to be created and related to the sales up
        */
        global Account BuyerAccount;

        /**
         * @description when buyer contact is populated and contact is of type person account buyer account will also be populated
         */
        global Contact BuyerContact;


        /**
        * @description Sales up record to be created
        */
        global Sales_Up__c SalesUp;

        global SalesUpWrapper(Account buyerAccount, Contact buyerContact, List<Task> tasks, List<Desired_Vehicle__c> desiredVehicles, List<Traffic_Log__c> trafficLogs, Sales_Up__c salesUp, Boolean bypassDupes){
            //potentially add new record if input is null
            System.assert(buyerContact != null, 'Sales Up requires a contact.');
            this.BuyerAccount = buyerAccount != null ? buyerAccount : new Account();
            this.BuyerContact = buyerContact != null ? buyerContact : new Contact();
            this.Tasks = tasks != null ? tasks : new List<Task>();
            this.DesiredVehicles = desiredVehicles != null ? desiredVehicles : new List<Desired_Vehicle__c>();
            this.TrafficLogs = trafficLogs != null ? trafficLogs : new List<Traffic_Log__c>();
            this.SalesUp = salesUp != null ? salesUp : new Sales_Up__c();
            this.BypassDuplicateMatching = bypassDupes == true ? true : false;
        }
    }
}
