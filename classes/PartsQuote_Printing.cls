public with sharing class PartsQuote_Printing {
    
    private static Integer FIRST_BREAK = 70;
    private static Integer SUBSEQ_BREAKS = 120;
    
    public List<dealer__Parts_Quote_Line__c[]> pageBrokenQuoteLines {get; private set; }
    
    public dealer__Parts_Quote__c quote { get; private set;} 
    public dealer__Parts_Quote_Line__c[] quoteLineItems { get; private set; }
    public Account account { get; private set; }
    public Contact contact { get; private set; } 
    public String InvoiceLogo {get; set;}
    
    public string printDateTime { 
            get {
                datetime dt = datetime.now();
                return dt.format('MM/dd/yyyy HH:mm a');
            }
    }
    
    public dealer__DMS_Settings__c DMSDefaults {get;private set;}

    public dealer__Dealer_Location__c userLoc {get;set;}

    /**
     * Constructor
     * @test PartQuotingServiceLayer.testPartsQuotePrinting
     */

    public PartsQuote_Printing(ApexPages.StandardController controller) {
        
        system.debug('the value is'+ApexPages.currentPage().getParameters().get('id'));
        
        quote = [Select d.dealer__Total__c, d.dealer__Status__c, d.dealer__Price_Level__c, d.dealer__Parts_Invoice__c, d.dealer__Quote_Number__c,
                        d.dealer__Items__c, d.dealer__Customer__c, d.dealer__Customer_Contact__c, d.dealer__Customer_Contact__r.Email, d.dealer__Location__c,
                        d.dealer__Customer_Contact__r.OtherPhone, d.dealer__Customer_Contact__r.HomePhone, d.dealer__Customer_Contact__r.MobilePhone, 
                        d.dealer__Customer_Contact__r.MailingPostalCode, d.dealer__Customer_Contact__r.MailingState, d.dealer__Customer_Contact__r.MailingCity, 
                        d.dealer__Customer_Contact__r.MailingStreet, d.dealer__Customer_Contact__r.Name, d.dealer__Customer_Contact__r.FirstName, 
                        d.dealer__Customer_Contact__r.LastName,d.dealer__Counterman__c, d.dealer__Company_Number__c, d.dealer__Total_Quote_Price__c,
                        d.dealer__Total_Parts_Price__c, d.dealer__Quote_Total__c, d.dealer__Misc_Fee__c, dealer__Tax_Exempt__c, d.dealer__Shipping_Charges__c,
                        d.dealer__Comments__c, d.SystemModstamp, d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, 
                        d.IsDeleted, d.Id, d.CreatedDate, d.CreatedById, (Select Id, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, 
                        LastModifiedById, SystemModstamp, dealer__Parts_Quote__c, dealer__Bin__c, dealer__Core__c, dealer__Cost__c, dealer__List__c, 
                        dealer__On_Hand__c, dealer__Part_Description__c, dealer__Part_Number__c, dealer__Parts_Inventory__c, dealer__Price__c, dealer__Total_Price__c,
                        dealer__Quantity__c From dealer__Parts_Quote_Lines__r) 
                    From dealer__Parts_Quote__c d
                    Where d.Id = :ApexPages.currentPage().getParameters().get('id') limit 1];
                    
        quoteLineItems = quote.dealer__Parts_Quote_Lines__r; 
        prepareQuoteLinesForPrinting();  

        InvoiceLogo = PartsQuote_Printing.logo_url(quote.dealer__Location__c);
        
        // Get defaults for DMS
        DMSDefaults = dealer__DMS_Settings__c.getValues('ActiveSettings'); 
    }
    
    /**
     * Returns url of invoice logo if one exists
     * @returns {String} - url of InvoiceLogo from Documents
     * @test PartQuotingServiceLayer.testPartsQuotePrinting
     */
    public String getInvoiceLogo() {
        List<Document> doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
        if(doc.size() > 0){
            String imageId = doc[0].Id;
            imageId = imageId.substring(0,15);
            return 'servlet/servlet.FileDownload?file='+imageId;
        }
        else{
            return null;
        }
    }    
    /**
     * Arranges quote lines with page breaks for printing
     * @test PartQuotingServiceLayer.testPartsQuotePrinting
     */
    private void prepareQuoteLinesForPrinting(){
        
         pageBrokenQuoteLines = new List<dealer__Parts_Quote_Line__c[]>();
        
        dealer__Parts_Quote_Line__c[] pageOfLines = new dealer__Parts_Quote_Line__c[]{};
        
        Integer counter = 0;
        boolean firstBreakFound = false;
        
        for(dealer__Parts_Quote_Line__c i : quoteLineItems)
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
                    pageBrokenQuoteLines.add(pageOfLines);
                    pageOfLines = new dealer__Parts_Quote_Line__c[]{};
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
                    pageBrokenQuoteLines.add(pageOfLines);
                    pageOfLines = new dealer__Parts_Quote_Line__c[]{};
                }   
            }
        }
        //if we have finished looping and have some quotes left lets assign them
        if(!pageOfLines.isEmpty())
            pageBrokenQuoteLines.add(pageOfLines);
    }    
     private static String logo_url(Id locationId) {
		if(locationId==null) {
			return '';
		}
		return DealershipLocationAPI.formLogoURL(locationId);
	}
}