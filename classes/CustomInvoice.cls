/**
 * CustomInvoice
 * @description
 */
public without sharing class CustomInvoice {

    /**
     * createROFromDeal 
     * @param  dealObject 
     * @description
     */
    public dealer__Service_Repair_Order__c createROFromDeal(dealer__Deal__c dealObject) 
    {
        // Get Associated Creating User
        String invoiceName = 'RO#';

        // Get location infomration
        dealer__Dealer_Location__c location = [Select Id, Name, dealer__Company_Number__c, dealer__Service_Director__c from dealer__Dealer_Location__c WHERE Id =:dealObject.dealer__Store_Location__c limit 1];

        // Get service vehicle record
        dealer__Service_Vehicle__c sv = null;  // BLL1c
        // BLL1a begin - get service vehicle using reference field if possible
        if (dealObject.Service_Vehicle__c!=null) {
            sv = [Select Id from dealer__Service_Vehicle__c where Id=:dealObject.Service_Vehicle__c limit 1];
        }
        if (sv==null && dealObject.dealer__Vehicle__c!=null) {
            sv = [Select Id from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c=:dealObject.dealer__Vehicle__c limit 1];
        }

        if (sv==null && !String.isBlank(dealObject.dealer__VIN__c)) {  // BLL1a - only if still need service veh and VIN is not missing
           sv = [Select Id from dealer__Service_Vehicle__c where dealer__VIN__c =:dealObject.dealer__VIN__c limit 1];
        } 
        
        // Instantiate the RO  
        dealer__Service_Repair_Order__c ro = new dealer__Service_Repair_Order__c();         

        if(dealObject.dealer__Mileage__c == null) { 
            dealObject.dealer__Mileage__c = 0;
        }
        ro.dealer__Company_Number__c = location.dealer__Company_Number__c;
        ro.dealer__Company__c  = location.Id; //JVK1
        ro.dealer__Create_Date_Time__c = Datetime.now();
        ro.dealer__Service_Advisor__c = location.dealer__Service_Director__c;
        if (sv!=null) {
            ro.dealer__Vehicle__c = sv.Id;
        }
        ro.dealer__Vehicle_Inventory__c = dealObject.dealer__Vehicle__c;
        ro.dealer__Mileage_In__c = dealObject.dealer__Mileage__c;
        ro.dealer__Customer__c = dealObject.dealer__Buyer__c;
        ro.dealer__RO_Number__c = ro.dealer__RO_Number__c;

        // Add Service Vehicle Linking for Equipment Only


        System.debug(ro);
        try {

            insert ro;            

            createLines(ro, dealObject);

        } catch(DmlException e) {
            dealObject.addError('Unable to create the delivery repair order '+e.getMessage());
        }   



        // Update the Proposal
        try {
            dealObject.DeliveryRepairOrder__c = ro.Id;

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to update proposal with RO# '+ro.Name));
            return null;
        }

        return ro;
    }

    /**
     * createLines 
     * @param  ro       
     * @param  dealObject 
     * @return  Boolean
     * @description JVK1 - Moved to seperate method so we can re-create lines if necessary
     */
    public Boolean createLines(dealer__Service_Repair_Order__c ro, dealer__Deal__c dealObject) 
    {

        // Delete Lines if they exists.
        if(ro.Id==null) {
            dealObject.addError('Unable to add job lines, the repair order ID is missing');
        }
        System.debug('--ro.Id--'+ro.Id);
        dealer__Service_Job__c[] jobLines = [Select Name, Id, dealer__Line_Total__c from dealer__Service_Job__c where dealer__Service_Repair_Order__c=:ro.Id limit 500];
        if(jobLines.size()>0) {
            try {
                for(dealer__Service_Job__c j : jobLines) {
                    if(j.dealer__Line_Total__c != null && j.dealer__Line_Total__c > 0) {
                        dealObject.addError('Unable to remove existing job lines, this repair has dollars associated with the job lines.');
                    }
                }                
                delete jobLines;
            } catch(DmlException d) {
                dealObject.addError('Failed to remove existing job lines. '+d.getMessage());
            }
        }

        // Create Job Lines based on the Additional Equipment Items
        List<dealer__After_Market__c> lines = [SELECT dealer__Car_Deal__c, dealer__Company_Number__c, dealer__Cost__c, dealer__Description__c, dealer__Labor_Sale__c, dealer__List_Price__c, dealer__Parts_Kit__c, dealer__Parts_Sale__c, dealer__Sale_Price__c, dealer__Vendor__c, dealer__Labor_Hours__c, dealer__Taxable__c, dealer__Gross__c, Id, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById FROM dealer__After_Market__c where dealer__Car_Deal__c=:dealObject.Id limit 500];  
        System.debug('--lines--'+lines);
        // Get Vehicle Data
        if(dealObject.Id != null){
            dealer__Deal__c dl = [SELECT Id, dealer__Deal_Type__c, dealer__NUO__c, dealer__Vehicle__r.dealer__NUO__c FROM dealer__Deal__c where Id=:dealObject.Id];
        }
        // Get Default Op Code
        dealer__StandardOpCode__c[] sop = [Select Id, Name from dealer__StandardOpCode__c where Name = '99PROD' limit 1];
        
        /*
        // Not required - KVP 
        // Get NUO Payment Methods
        ServicePaymentType__c ieo = [Select Id from ServicePaymentType__c where Name = 'IEO'];
        ServicePaymentType__c ieu = [Select Id from ServicePaymentType__c where Name = 'IEU'];
        ServicePaymentType__c ien = [Select Id from ServicePaymentType__c where Name = 'IEN'];
        */
        List<dealer__Service_Job__c> jLines = new List<dealer__Service_Job__c>();
        Integer i = 1;
        for(dealer__After_Market__c a : lines) {
            dealer__Service_Job__c newLine = new dealer__Service_Job__c();
            newLine.dealer__Service_Repair_Order__c = ro.Id;
            newLine.Name = ro.Name+'-'+i;
            newLine.dealer__Line_Number__c=i;
            newLine.dealer__Service_Type__c='MR';
            newLine.dealer__Labor_Type__c='I';
            newLine.dealer__CustomerConcern__c = a.dealer__Description__c;  // Add the suggested hours

            if(a.Labor_Hours__c != null) {
                newLine.dealer__CustomerConcern__c = newLine.dealer__CustomerConcern__c + ' Estimated Service Hours : ' +a.Labor_Hours__c;
            }


            if(sop.size()>0) {
                newLine.dealer__Standard_Operation_Code__c = sop[0].Id;
                newLine.dealer__Op_Code__c = sop[0].Name;
            }
            /*
            // Not Required - KVP
            if(dl.dealer__Vehicle__r.dealer__NUO__c != null && dl.dealer__Vehicle__r.dealer__NUO__c =='U') {
                newLine.Payment_Method__c = ieu.Id;
            }

            if(dl.dealer__Vehicle__r.dealer__NUO__c != null && dl.dealer__Vehicle__r.dealer__NUO__c =='N') {
                newLine.Payment_Method__c = ien.Id;
            }            

            if(dl.dealer__Deal_Type__c == 'Equipment Only Sale') {
                newLine.Payment_Method__c = ieo.Id;
            }
            */
            // add support for New (IEN), Used (IEU), Equipment Only (IEO)

            
            jLines.add(newLine);

            i++;
        } 
          
        if(jLines.size()>0) {
            try {
                insert jLines;
                return true;
            } catch (DmlException e) {
                dealObject.addError('Unable to create the delivery repair order job lines '+e);
            }
        } 
        return false;   
    }
    
    /**
     * createServEst 
     * @param  inspReports 
     * @param  dealObject  
     * @return  List<dealer__Service_Estimate__c>   
     * @description        
     */ 
    public static List<dealer__Service_Estimate__c> createServEst(List<dealer__Inspection_Report__c> inspReports, dealer__Deal__c dealObject){
        List<dealer__Service_Estimate__c> servEstimations = new List<dealer__Service_Estimate__c>();
        for(Integer i=0 ; i<inspReports.size(); i++){
            dealer__Service_Estimate__c servEstimation = new dealer__Service_Estimate__c();
            servEstimation.dealer__Service_Vehicle__c = inspReports[i].dealer__Service_Vehicle__c;
            servEstimations.add(servEstimation);
        }
        try{
            insert servEstimations;     
        }catch(Exception e){
            dealObject.addError('Unable to create Service Estimates'+e);
        }
        
        return servEstimations;
    }
   
}