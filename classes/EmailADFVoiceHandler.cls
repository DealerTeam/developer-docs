global class EmailADFVoiceHandler implements Messaging.InboundEmailHandler {
    public Boolean adfResult {get;set;}
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
            
        Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();       
        if(result.success) {
            ADFVoice adf =  new ADFVoice();
            if(email.plainTextBody!=null) {
                String to;
                if(email.toAddresses!=null) {
                    to=email.toAddresses[0];
                } else {
                    to='test@myemail.com';
                }
                
                System.debug(to);
                adfResult   =   adf.parseADF(email.plainTextBody, to);
            }
        }
         
        return result;
    }
}