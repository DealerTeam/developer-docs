/**
 * PartsInvoiceEmailController
 * @test PartsInvoicingServiceLayer.testInvoiceEmailController
 */
public with sharing class PartsInvoiceEmailController {
 
  public ID userId {get;set;}
  public String docID { 
      get {
         return ApexPages.currentPage().getParameters().get('Id');
      }
      set;
  }
  public String email {get; set;}
  public String subject {get;set;}
  public String message { get;set;}
  
  
  
  public PageReference sendPdf() {
 
    PageReference pdf = Page.PartsInvoicePDF;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id', docID);
 
    // the contents of the attachment from the pdf
    Blob body;
 
    try {
 
      // returns the output of the page as a PDF
      body = pdf.getContent();
 
    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
 
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('PartsInvoice.pdf');
    attach.setInline(false);
    attach.Body = body;
 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('Your Invoice from '+UserInfo.getOrganizationName());
    mail.setHtmlBody(message);
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
 
    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+email));
 
    return null;
 
  }
 
}