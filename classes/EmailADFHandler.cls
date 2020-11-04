global class EmailADFHandler implements Messaging.InboundEmailHandler {
    public dealer__Sales_Up__c adfResult {get;set;}
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
            
        Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();       
        if(result.success) {
            
            ADFAPI adf       =   new ADFAPI();
            if(email.plainTextBody!=null) {
                
                String toAddress;
                String fromAddress;
                
                if(email.toAddresses!=null) {
                    toAddress=email.toAddresses[0];
                    fromAddress=email.fromAddress;
                    //System.debug(email);
                } else {
                    toAddress='test@myemail.com';
                    fromAddress='test@myemail.com';
                }
                adfResult   =   adf.parseADF(email.plainTextBody, toAddress, fromAddress); 
            }
        } 
         
        return result;
    }
}