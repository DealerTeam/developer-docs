public with sharing class PartsQuote_EXT {
    
    public dealer__Parts_Quote__c quote {get;set;}
    
    public List<dealer__Stock_Order__c> CurrentOrders {get;set;}
    
    public String email {get;set;}
    public String subject {get { return 'Parts Quote from '+UserInfo.getOrganizationName(); } set;}
    public String body { get; set; }
    private Messaging.EmailFileAttachment defaultAttachment;
    /**
     * PartsQuote_EXT Constructor
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public PartsQuote_EXT (ApexPages.standardController controller) {
       Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Parts_Quote__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.add('Customer_Contact__r.Email');
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
            controller.addFields(af);
        }
        quote = (dealer__Parts_Quote__c)controller.getRecord();
    }
    /**
     * Save parts quote
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public PageReference save() {
      if(quote.Id==null) {
        insert quote;
      } else {
        update quote;
      }
      PageReference p = new PageReference('/'+quote.Id);
      p.setRedirect(true);
      return p;
    }
    /**
     * Converts the parts quote to an invoice
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public PageReference ConvertToInvoice() {
        // Incrimental ID Numbering not dependent on object
    
        
        // Get record type ID
        RecordType rt = [Select Id from RecordType where DeveloperName = 'Retail_Sale' limit 1];
        
         // Build Invoice Object        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(           
                                                        // Name='INV#'+pset.dealer__Parts_Current_Invoice_Number__c, 
                                                        Location__c = quote.Location__c,
                                                        // dealer__Invoice_Number__c='PI'+String.valueOf(pset.dealer__Parts_Current_Invoice_Number__c),                 
                                                        dealer__Customer_Contact__c=quote.dealer__Customer_Contact__c,
                                                        dealer__Counterman__c=quote.dealer__Counterman__c,
                                                        dealer__Comments__c=quote.dealer__Comments__c,
                                                        RecordTypeId=rt.Id
                                                    );
        //insert PI PartInvoiceAPI                                               
        // Database.SaveResult insResult = Database.Insert(pi, false);
        pi = PartInvoiceAPI.createInvoice(pi);
        if(pi==null) { new PartsQuoteException('Unable to create invoice, parent ID missing '); return null; }
        
        String invoiceInsResultId = pi.Id;
        
        dealer__DMS_Settings__c pset = [Select Id, dealer__Parts_Current_Invoice_Number__c 
                                                                From dealer__DMS_Settings__c 
                                                                where Name = 'ActiveSettings' limit 1];
        // pset.dealer__Parts_Current_Invoice_Number__c += 1; // updated in the domain layer    
        // Process Parts Lines
        Integer i = 1;
        
        List<dealer__Parts_Invoice_Line__c> invoiceLineList = new List<dealer__Parts_Invoice_Line__c>();   
        for(dealer__Parts_Quote_Line__c pql : [Select d.dealer__Quantity__c, d.dealer__Price__c, d.dealer__Parts_Quote__c, d.dealer__Parts_Inventory__c, 
                                                      d.dealer__Part_Number__c, d.dealer__Part_Description__c, d.dealer__On_Hand__c, d.dealer__List__c, 
                                                      d.dealer__Cost__c, d.dealer__Core__c, d.dealer__Bin__c, d.Name, d.Id, d.dealer__Parts_Inventory__r.dealer__MFG__c 
                                                      from dealer__Parts_Quote_Line__c d where d.dealer__Parts_Quote__c = :quote.Id
                                                      and d.IsDeleted = false
                                                      limit 1000]) {
                                                        
                    dealer__Parts_Invoice_Line__c ql = new dealer__Parts_Invoice_Line__c();  
                     
                         ql.Name = 'INV#'+pset.dealer__Parts_Current_Invoice_Number__c+'-'+i;
                         ql.dealer__Part__c = pql.dealer__Parts_Inventory__c;
                         ql.dealer__List__c = pql.dealer__List__c;
                         ql.dealer__Price__c= pql.dealer__Price__c;
                         ql.dealer__Core__c = pql.dealer__Core__c;
                         ql.dealer__Cost__c = pql.dealer__Cost__c;
                         ql.dealer__Bin__c  = pql.dealer__Bin__c;
                         ql.dealer__Counterman__c = quote.dealer__Counterman__c;
                         ql.dealer__Part_Number__c = pql.dealer__Part_Number__c;
                         ql.dealer__Part_Description__c = pql.dealer__Part_Description__c;
                         ql.dealer__Quantity_Sold__c = pql.dealer__Quantity__c;
                         
                         ql.dealer__Sale_Date__c=Date.today();
                         ql.dealer__Source__c=String.valueOf('');
                         ql.dealer__MFG__c=pql.dealer__Parts_Inventory__r.dealer__MFG__c;
                         ql.dealer__Sold_Via__c=String.valueOf('Quote');
                         if(pql.dealer__On_Hand__c < ql.dealer__Quantity_Sold__c) {
                            ql.dealer__Quantity_Ordered__c=(ql.dealer__Quantity_Sold__c - pql.dealer__On_Hand__c);
                            ql.dealer__Order_Type__c=String.valueOf('Special Order');
                         }  
                         ql.dealer__Parts_Invoice__c = invoiceInsResultId;
                            
             invoiceLineList.add(ql);  
                  
            i++; 
        } 
        //Parts Invoice API
        // insert invoiceLineList;  
        invoiceLineList = PartInvoiceAPI.addInvoiceLines(invoiceLineList);
                     
         // Order Creation, lookup parts sold via quote to see if they are in stock, if not add to special order bank
                     
         if(invoiceLineList.size()>0) {
             for(dealer__Parts_Invoice_Line__c pil : invoiceLineList) { 
                 if(pil.dealer__Quantity_Ordered__c > 0) {
                                PartsOrderLine( pil.dealer__Part__c, 
                                     pil.dealer__Parts_Invoice__c,
                                     pil.Id,
                                     pil.dealer__Quantity_Ordered__c,
                                     String.valueOf(UserInfo.getUserId()),
                                     pil.dealer__Sold_Via__c,
                                     pil.dealer__MFG__c
                                    );
                 }            
             }                                                       
         } 
        
        
        // Update Parts Quote to be Sold
        quote.dealer__Status__c = 'Sold - Converted';
        quote.dealer__Parts_Invoice__c = invoiceInsResultId;
        update quote;
        
        // Record Activity
        Task t = new Task( Subject='Converted Quote to Invoice '+pi.Name,
                           ActivityDate=Date.today(),
                           WhatId=quote.Id,
                           Status='Completed');
        insert t;             
                
        PageReference partsInvoicePage = new ApexPages.StandardController(pi).view();
        partsInvoicePage.setRedirect(true);
         
        return partsInvoicePage;                
    }
    
    
    // Order Line Creation, attempted to place into seperate class, package upload failed. 
    /**
     * Populate Parts Order Line into parent invoice
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public static void PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg) {
        
        ID orderNumber;
        dealer__Parts_Inventory__c  inventoryRecord = [Select Id, dealer__Cost__c from dealer__Parts_Inventory__c where Id =:partId limit 1];
        Decimal orderValue  =   quantityOrdered * inventoryRecord.dealer__Cost__c;
        
        List<dealer__Stock_Order__c> so = [Select Id, dealer__Manufacturer__c
                                                    from dealer__Stock_Order__c
                                                    where dealer__Date_Ordered__c = TODAY 
                                                    and dealer__Manufacturer__c = :mfg
                                                    and dealer__Order_Type__c =:orderType
                                                    and dealer__Status__c != 'Posted'
                                                    limit 1];
                                                    
        if(so.size()==0) {
            Date todaysDate = Date.today();
            dealer__Stock_Order__c dSo = new dealer__Stock_Order__c(Name=mfg+String.valueOf(todaysDate.month())+String.valueOf(todaysDate.day()),
                                                                    dealer__Manufacturer__c=String.valueOf(mfg),
                                                                    dealer__Date_Ordered__c=Date.today(),
                                                                    dealer__Status__c='Incomplete',
                                                                    dealer__Order_Type__c=orderType
                                                                    );
            insert dSo; 
            orderNumber=dSo.Id;                                                 
        } else {
            orderNumber=so[0].Id;
        }           
        
        // Set the lines 
        dealer__Parts_Order__c orderLine = new dealer__Parts_Order__c(dealer__Order__c=orderNumber,
                                                                      dealer__Order_Date__c=Date.today(),
                                                                      dealer__Parts_Inventory__c=partId,
                                                                      dealer__Parts_Invoice__c=invoiceId,
                                                                      dealer__Quantity_Ordered__c=quantityOrdered,
                                                                      dealer__Requested_By__c=requestedBy,
                                                                      dealer__Parts_Line__c=invoiceLineId,
                                                                      dealer__Value__c=orderValue   
                                                                     );
        System.debug(orderLine);                                                             
        insert orderLine;
        
        /*
        if(orderLine.Id=='') {
            return false;
        } else {
            return true;
        }
        */                          
        
    }   
    
    //
    //
    //  Remote Actions
    //
    //
    
    /**
     *
     * loadPartsLines - Quote
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    @RemoteAction
    public static List<dealer__Parts_Quote_Line__c> loadPartsQuoteLines(String masterRecordId){
        return [Select Id, Name, dealer__Core__c, dealer__Cost__c, dealer__List__c, dealer__Part_Description__c, dealer__Bin__c, dealer__On_Hand__c,
                                                    dealer__Part_Number__c, dealer__Parts_Inventory__c, dealer__Parts_Quote__c, dealer__Quantity__c
                                                    From dealer__Parts_Quote_Line__c where dealer__Parts_Quote__c = :masterRecordId limit 100];                                                   
    }
    
    /**
     * PDF Emailer
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    
    // <name>emailButton</email>
    // <summary>Send user to email estimate page</summary>
    public PageReference emailQuote() {
        PageReference eb = Page.PartsQuoteEmailPDF;
        if(quote != null) {
            eb.getParameters().put('id', string.valueOf(quote.Id));
        }
        return eb;
    } 
      
    /**
     * Send client quote as pdf email attachment
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public PageReference sendPdf() {
               
        // Get Customer Email address
        
        Contact c = [Select Id, Email from Contact where Id =: quote.dealer__Customer_Contact__c limit 1];
        
        if(c.Email == null) {
            
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer Account has no email address'));
                return null;
            
        }
        
        Messaging.EmailFileAttachment attach = AttachPDF();
     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] { c.Email });
        mail.setSubject(this.subject);
        mail.setHtmlBody(this.body);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
     
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Parts Quote was sent to '+c.Email));
        
        // Record Activity
        Task t = new Task( Subject='Emailed Parts Quote to '+c.Email,
                           ActivityDate=Date.today(),
                           WhatId=quote.Id,
                           Status='Completed');
        insert t;             
                           
        PageReference sq = Page.PartsQuote;
        sq.getParameters().put('id', string.valueOf(quote.Id));
        return sq;
     
    }    
    
    /**
     * Handles attaching the pdf quote to email
     * @test PartQuotingUILayer.testPartsQuoteEXT
     */
    public Messaging.EmailFileAttachment AttachPDF() {
                
        PageReference pdf = new PageReference('/apex/dealer__PartsQuotePDF');
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id', string.valueOf(quote.Id));
     
        // the contents of the attachment from the pdf
        Blob body;
        
        try {
          // returns the output of the page as a PDF
          body = pdf.getContent();
          
        } catch (VisualforceException e) {
          body = Blob.valueOf('Error Generating Attachment');
        }
     
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName(quote.Name+'-PartsQuote.pdf');
        attach.setInline(false);
        attach.Body = body;
        
        return attach;
    }
    
    
    public class PartsQuoteException extends Exception {}
}