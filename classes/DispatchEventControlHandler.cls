public class DispatchEventControlHandler {

    /**
     * recordDispatchEventToJobLine - Applies dispatch event to associated Job Line
     *
     */
    public static void recordDispatchEventToJobLine(List<DispatchEvent__c> triggerNew)
    {

        // List<Service_Job__c> jobLines = new List<Service_Job__c>();

        // // Iterate Trigger Events and apply dispatchEvent
        // for(DispatchEvent__c de : triggerNew)
        // {
        //     jobLines.add(
        //         new Service_Job__c(
        //             Id=de.ServiceJobLine__c,
        //             CurrentDispatchEvent__c=de.Id               
        //         )
        //     );
        // }

        // try {
        //     update jobLines;
        // } Catch(DmlException e) {
        //     throw new DmlException(e.getMessage());
        // } Catch(Exception e) {
        //     throw new ServiceAPI.ServiceException(e.getMessage());
        // }
    }

}