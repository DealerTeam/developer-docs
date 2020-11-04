public with sharing class ServiceQuerySelector {

    /**
     * Query all Technicians from a specific Location
     *
     */
    public static List<Dealer_Location_User__c> activeTechnicians(Id LocationId)
    {
        return [SELECT User__c, Technician__c, Name, Id,
                        User__r.Name
                    FROM Dealer_Location_User__c 
                    WHERE Technician__c = true
                    AND User__r.IsActive = true];
    }

    /**
     *
     *
     *
     */
    public static List<DispatchEvent__c> dispatchEvents(Id LocationId)
    {
        return [SELECT StartDateTime__c, EndDateTime__c, ServiceJobLine__c, LastModifiedById, LastModifiedDate, 
										CreatedById, CreatedDate, Resource__c, Resource__r.Name,
										Name, Id, Location__c, ServiceRepairOrder__c, EventId__c,
                                        ServiceJobLine__r.Service_Repair_Order__r.Id, 
                                        ServiceJobLine__r.Service_Repair_Order__r.Status__c,
                                        ServiceJobLine__r.Service_Repair_Order__r.Name,
                                        ServiceJobLine__r.Op_Code__c,
                                        ServiceJobLine__r.Line_Number__c,
                                        ServiceJobLine__r.CustomerConcern__c
									FROM DispatchEvent__c
									WHERE Location__c =:LocationId];
    }

    public static List<Service_Job__c> jobLinesWithoutDispatchEvent(Id LocationId)
    {
        return [SELECT Id, Name, Op_Code__c, Op_Description__c, Service_Repair_Order__c,  Service_Repair_Order__r.Name, 
					Service_Type__c, CreatedDate, Service_Repair_Order__r.Customer__r.Name, Service_Repair_Order__r.Days_Down__c,
					Service_Repair_Order__r.Service_Advisor__r.Name, Standard_Operation_Code__c, Standard_Operation_Code__r.Name,
					Line_Number__c, Technician__c, Service_Repair_Order__r.Status__c, Service_Repair_Order__r.Company__c,
                    Book_Time__c
				FROM Service_Job__c 
				WHERE RO_Status__c = 'Open' 
				AND CurrentDispatchEvent__c = null
                AND Service_Repair_Order__r.Company__c =:LocationId
				ORDER BY Service_Repair_Order__r.Name ASC, Line_Number__c ASC];
    }
}