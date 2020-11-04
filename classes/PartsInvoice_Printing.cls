global with sharing class PartsInvoice_Printing {
    
    private static Integer FIRST_BREAK = 70;
    private static Integer SUBSEQ_BREAKS = 120;
    
    global List<dealer__Parts_Invoice_Line__c[]> pageBrokenInvoiceLines {get; private set; }
    
    global dealer__Parts_Invoice__c invoice { get; private set;} 
    global dealer__Parts_Invoice_Line__c[] invoiceLineItems { get; private set; }
    global Account account { get; private set; }
    global Contact contact { get; private set; } 
    
    global string printDateTime { 
            get {
                datetime dt = datetime.now();
                return dt.format('MM/dd/yyyy HH:mm a');
            }
    }
    
    global dealer__DMS_Settings__c DMSDefaults {get;private set;}
    
    global dealer__Dealer_Location__c userLoc {get;set;}
    
    /**
     * Constructor
     * @test PartInvoicingServiceLayer.testPIP
     */
    global PartsInvoice_Printing(ApexPages.StandardController controller) {
        invoice = [Select d.dealer__Location__c, d.dealer__Customer__r.PersonMailingCity, 
                    d.dealer__Customer__r.PersonMailingState, d.dealer__Customer__r.PersonMailingPostalCode,
                    d.dealer__Customer__r.PersonMailingStreet, d.dealer__Customer__r.ShippingCity, 
                    d.dealer__Customer__r.ShippingState, d.dealer__Customer__r.ShippingPostalCode, 
                    d.dealer__Customer__r.ShippingStreet,
                    d.dealer__Total_Tax__c, d.dealer__Total_Invoice__c, d.dealer__Shipping_Tracking_No__c, 
                    d.dealer__Shipping_Notes__c, d.dealer__Shipping_Charges__c, d.dealer__Ship_Via__c, 
                    d.dealer__Required_Date__c, d.dealer__Price_Level__c, d.dealer__Post_Date_Time__c, 
                    d.dealer__Parts_Price__c, d.dealer__Open_Date_Time__c, d.dealer__Misc_Fee__c, 
                    d.dealer__Invoice_Date_Time__c, d.dealer__Customer_Shipto_State__c, d.dealer__Customer_ShipTo_Zip__c, 
                    d.dealer__Customer_ShipTo_City__c, d.dealer__Customer_ShipTo_Address__c, 
                    d.dealer__Customer_Purchase_Order__c, d.dealer__Counterman__c, d.dealer__Comments__c, d.Name, 
                    d.dealer__Counterman__r.Name,
                    d.dealer__Customer_Contact__r.MailingPostalCode, d.dealer__Customer_Contact__r.MailingState, 
                    d.dealer__Customer_Contact__r.MailingCity, d.dealer__Customer_Contact__r.MailingStreet, 
                    d.dealer__Customer_Contact__r.AccountId, d.dealer__Customer_Contact__r.Name, 
                    d.dealer__Customer_Contact__r.FirstName, d.dealer__Customer_Contact__r.LastName, 
                    d.dealer__Wholesale_Pricing_Strategy__c, d.dealer__Wholesale_Pricing_Strategy__r.Name, 
                    d.RecordType.Name, d.RecordTypeId,
                        (Select dealer__List__c, dealer__Quantity_Sold__c, dealer__Part_Number__c, 
                            dealer__Part_Description__c, dealer__Bin__c, dealer__Total_Price__c, 
                            dealer__Extended_Price__c, dealer__Price__c 
                                From dealer__Parts_Invoice_Lines__r),
                            (Select dealer__Payment_Method__c, dealer__Amount__c from Cashiering__r) 
                    From dealer__Parts_Invoice__c d
                    Where d.Id = :ApexPages.currentPage().getParameters().get('id') limit 1];
                    
        invoiceLineItems = invoice.dealer__Parts_Invoice_Lines__r; 
        
        prepareInvoiceLinesForPrinting();  
        
        // Get defaults for DMS
        DMSDefaults = dealer__DMS_Settings__c.getValues('ActiveSettings'); 

        if(invoice.dealer__Location__c!=null) {
        userLoc = [SELECT Id, Name, Street__c, City__c, Company_Number__c, Main_Phone__c, Postal_Code__c, State__c, Website__c, Company_Contracting_Name__c 
                    FROM Dealer_Location__c 
                    WHERE Id =: invoice.dealer__Location__c LIMIT 1];
        } else {
            userLoc = null;
        }

    }
    /**
     * Handles finding logo from documents and returning the url as a string
     * @returns {String} - the url of the logo image
     * @test PartInvoicingServiceLayer.testPIP
     */
    global String getInvoiceLogo() {
         Id recordId = ApexPages.currentPage().getParameters().get('id');
         Id loc = [SELECT Location__c FROM Parts_Invoice__c WHERE Id=:recordId].Location__c;
       
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
     * Arrange lines with page breaks for printing
     * @test PartInvoicingServiceLayer.testPIP
     */
    private void prepareInvoiceLinesForPrinting(){
        
        pageBrokenInvoiceLines = new List<dealer__Parts_Invoice_Line__c[]>();
        
        dealer__Parts_Invoice_Line__c[] pageOfLines = new dealer__Parts_Invoice_Line__c[]{};
        
        Integer counter = 0;
        boolean firstBreakFound = false;
        
        for(dealer__Parts_Invoice_Line__c i : invoiceLineItems)
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
                    pageBrokenInvoiceLines.add(pageOfLines);
                    pageOfLines = new dealer__Parts_Invoice_Line__c[]{};
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
                    pageBrokenInvoiceLines.add(pageOfLines);
                    pageOfLines = new dealer__Parts_Invoice_Line__c[]{};
                }   
            }
        }
        //if we have finished looping and have some quotes left lets assign them
        if(!pageOfLines.isEmpty())
            pageBrokenInvoiceLines.add(pageOfLines);
    }    
     
}