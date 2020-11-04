global class EmailADFGeneralHandler implements Messaging.InboundEmailHandler {
    public Boolean adfResult {get;set;}
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
            
        Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();       
        if(result.success) {
            ADFGeneralContactForm adf       = new ADFGeneralContactForm();
            if(email.plainTextBody!=null) {
                adfResult   =   adf.parseADF(email.plainTextBody); 
            }
        } 
        return result;
    }
}