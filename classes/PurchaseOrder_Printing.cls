/**
* 2016.08.31       |Gaurav               |Case# 2019
 * Add new fields Carrier, VIN/Serial, RO Reference#, Shipping Method, Tracking# 
 */
public with sharing class PurchaseOrder_Printing {
    private static Integer FIRST_BREAK = 70;
    private static Integer SUBSEQ_BREAKS = 120;
    
    
    public List<dealer__Purchase_Order_Line__c[]> pageBrokenOrderLines {get;private set;}
    public dealer__Purchase_Order_Line__c[] poLines {get;set;}
    public dealer__Purchase_Order__c po {get;set;}
    public dealer__DMS_Settings__c DMSDefaults {get;private set;}
    public dealer__Dealer_Location__c dlr {
        get {
            dealer__Dealer_Location__c[] dlr_locations = [SELECT dealer__Company_Number__c, dealer__Street__c, dealer__City__c, dealer__State__c, dealer__Postal_Code__c, dealer__Main_Phone__c, dealer__Email__c, dealer__General_Manager__c, dealer__Service_Director__c, dealer__Website__c, dealer__Service_RO_Disclaimer__c, dealer__Service_Invoice_Disclaimer__c, dealer__Parts_Invoice_Disclaimer__c, Id, Name FROM dealer__Dealer_Location__c where Id=:po.dealer__Company__c limit 1];

            if(dlr_locations.size()==1) {
                return dlr_locations[0];
            } 
            return new dealer__Dealer_Location__c();
        }
        set;
    }
    /**
     * Queries purchase order from current page id then calls prepareOrderLinesForPrinting
     * @param controller
     * @test PartOrderingServiceLayer.testPOPrinting
     */
    public PurchaseOrder_Printing(ApexPages.standardController controller) {
        po = [Select d.dealer__Carrier__c, d.dealer__VIN__c, d.dealer__Shipping_Method__c, d.dealer__Tracking__c, d.dealer__Vendor__c,d.dealer__Vendor__r.Fax, d.dealer__Vendor_Street__c, d.dealer__Vendor_State__c, d.dealer__Vendor_Postal_Code__c, 
                    d.dealer__Vendor_Phone__c, d.dealer__Vendor_Name__c, d.dealer__Vendor_Email__c, d.dealer__Vendor_Country__c, 
                    d.dealer__Vendor_City__c, d.dealer__Type__c, d.dealer__Service_Repair_Order__c,dealer__Service_Repair_Order__r.Name, d.dealer__Requested_By__c, 
                    d.dealer__Post_Date_Time__c, d.dealer__Parts_Line__c, d.dealer__Parts_Invoice__c, d.dealer__PO_Lines__c, 
                    d.dealer__PO_Amount__c, d.dealer__Invoice_Number__c, d.dealer__Invoice_Date__c, d.dealer__Invoice_Amount__c, 
                    d.Name, d.Id, d.CreatedDate, d.CreatedById, d.dealer__PO_Number__c, d.CreatedBy.Name,d.dealer__Company__c,
                        (Select Name, dealer__Amount__c, dealer__Account__c, dealer__Part__c, dealer__Description__c, dealer__Drop_Ship_To__c,
                                    dealer__Part_Quantity__c, dealer__Special_Instructions__c, dealer__Part__r.Name, dealer__Part__r.dealer__Description__c,
                                    dealer__Drop_Ship_Address__c, dealer__Parts_Invoice__c, dealer__Parts_Invoice__r.dealer__Customer_Contact__c,dealer__Service_Job_Line__c,dealer__Service_Job_Line__r.Name 
                                    From dealer__Purchase_Order_Line__r) 
                    From dealer__Purchase_Order__c d
                    Where Id =:ApexPages.currentPage().getParameters().get('id') limit 1];
        poLines = po.dealer__Purchase_Order_Line__r;
        DMSDefaults = dealer__DMS_Settings__c.getValues('ActiveSettings');
        prepareOrderLinesForPrinting();
         
    }
    
    /**
     * Provides current data & time as a string
     * @returns string with current date & time
     * @test PartOrderingServiceLayer.testPOPrinting
     */
    public string printDateTime { 
            get {
                datetime dt = datetime.now();
                return dt.format('MM/dd/yyyy HH:mm a');
            }
    }

    /**
     * Gets the logo url based on location
     * @returns string with logo url
     * @test PartOrderingServiceLayer.testPOPrinting
     */
   public String getInvoiceLogo() {
        Id loc = po.dealer__Company__c;
        if(loc != null){
            return DealershipLocationAPI.formLogoURL(loc);
        }else{
            Document doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
            String imageId = doc.Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
    }
    
    /**
     * Lists PO Lines for printing
     * @test PartOrderingServiceLayer.testPOPrinting
     */
    public void prepareOrderLinesForPrinting(){
        
        pageBrokenOrderLines = new List<dealer__Purchase_Order_Line__c[]>();
        
        dealer__Purchase_Order_Line__c[] pageOfLines = new dealer__Purchase_Order_Line__c[]{};
        
        Integer counter = 0;
        boolean firstBreakFound = false;
        
        for(dealer__Purchase_Order_Line__c i : poLines)
        {
            if(!firstBreakFound)
            {
                if(counter < FIRST_BREAK)
                {
                    pageOfLines.add(i);
                    counter++;  
                }
                if(counter == FIRST_BREAK)
                {
                    firstBreakFound = true;
                    counter = 0;
                    pageBrokenOrderLines.add(pageOfLines);
                    pageOfLines = new dealer__Purchase_Order_Line__c[]{};
                }   
            }
            else
            {
                if(counter < SUBSEQ_BREAKS)
                {
                    pageOfLines.add(i);
                    counter++;
                }
                if(counter == SUBSEQ_BREAKS)
                {
                    counter = 0;
                    pageBrokenOrderLines.add(pageOfLines);
                    pageOfLines = new dealer__Purchase_Order_Line__c[]{};
                }   
            }
        }
        //if we have finished looping and have some quotes left lets assign them
        if(!pageOfLines.isEmpty())
            pageBrokenOrderLines.add(pageOfLines);
    }        
}