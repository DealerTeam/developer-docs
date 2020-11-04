global class EmailHandler implements Messaging.InboundEmailHandler {
    boolean lead_parsed_successfully = false;
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();       
        if(result.success) {
            String plainTextBody = email.plainTextBody;
            String convertedBody = null;
            if (email.htmlBody!=null) convertedBody = convertToPlainText(email.htmlBody);       
            
            if (String.isEmpty(plainTextBody) && convertedBody<>null) {
                plainTextBody = convertedBody;
            }
            
			if(plainTextBody!=null) {
                try {
                    LeadParser p = new LeadParser();
                    //braunlift.com
                    // if(email.fromAddress.contains('braunlift.com') || email.subject.contains('Braun') || email.subject.contains(' AbilityLead ')) {
                    //     lead_parsed_successfully = p.processBraunPayload(plainTextBody); 
                    // }
                } Catch(Exception e) {
                    
                }
            }
        }
        
        return result;
    }
    
    public String convertToPlainText(String html) {
        String body = html;
        // Remove style block
        body = body.replaceAll('<head>.*</head>','');
        // ensure there are newlines
        //body = body.replace('Â','');  // BLL3a
        body = body.replace('</tr>', '</tr>\n').replace('</p>','</p>\n').replaceAll('</td>\\s+<td', ':</td><td');
        body = body.replace('::', ':'); // BLL2a
        body = body.replace('<br />','\n').replace('<br/>','\n'); // BLL5a 
        body = body.replace('\n','{|}').stripHtmlTags().replace('{|}','\n').replaceAll(':\\s*:', ':');
        //BLL5 now that we've done the special stuff ...
        //body = body.stripHtmlTags(); // BLL5 don't use this, it removes new lines too. Ugh!
        body = body.replaceAll('<[^>]*>','');  // my strip tags 
        System.debug(body.left(1024));
        return body;
    }    
}