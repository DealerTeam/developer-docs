/**
 * ADFVoice
 * @description Parses ADF Voice doc to identify Customer and Sales Up
 */
 public with sharing class ADFVoice {
    /**
     * @description
     */
    public String phoneNumber;
    
    /**
     * @description
     */ 
    public String callerFirst;
    
    /**
     * @description
     */ 
    public String callerLast;
    
    /**
     * @description
     */ 
    public String companyNumber = null;
    
    /**
     * ADFVoice
     * @description
     */ 
    public ADFVoice() {}
    
    /**
     * parseADF 
     * @param  XML  
     * @param  toEmail 
     * @return boolean
     * @description
     */ 
    public boolean parseADF(String XML, String toEmail) 
    {
        DOM.Document adfDoc = new Dom.Document();
        try {
            
            // Some vendors include bullshit whitespace
            // XML = XML.deleteWhitespace();
            XML = XML.replaceAll('[\r\n]+', '');
            XML = XML.replace('<?ADF VERSION "1.0"?>', '');
            // temporary hack to remove the <![CDATA[ ]]>
            // 12/18/2012 - to be removed once solution decided upon (Jarrett Kuljis)
            // DOM.XmlNode does not understand cdata, possible 
            // we may need to conver to XmlStreamReader
            XML = XML.replace('<![CDATA[', '');
            XML = XML.replace(']]>', '');
            XML = XML.replace('&', '&amp;');
            
            adfDoc.load(XML);
            DOM.Xmlnode root = adfDoc.getRootElement();
            
            setCompanyNumber(toEmail);
            
            return unpackDoc(root);
            
        } catch (System.Xmlexception e) {
            
            alertFailedADF(XML);
            
            new ADFException(e.getMessage());
            return false;
        }       
    } 
    
    /**
     * unpackDoc 
     * @param  nodes 
     * @return boolean
     * @description Unpack XML, Set Traffic Type, Locate Customer and get Matching Sales Up
     */ 
    public boolean unpackDoc(DOM.Xmlnode nodes) 
    {
        
        if(nodes==null) {
            
            alertFailedADF('Nodes not found in unpackDoc()');
            throw new ADFException('Malformed ADF Voice Document');
            return false;
        }   
        
        String ns = 'http://www.callbright.com/InboundCallCrm';
                
        DOM.Xmlnode call    =   nodes.getChildElement('call', ns);
        DOM.Xmlnode caller  =   nodes.getChildElement('caller', ns);
        DOM.Xmlnode inumber =   nodes.getChildElement('number', ns);
        DOM.Xmlnode account =   nodes.getChildElement('account', ns);
        
        dealer__Traffic_Log__c t = new dealer__Traffic_Log__c();
        
        if(call!=null) {
            
            String callAcctId = (call.getChildElement('id', ns)!=null) ? String.valueOf(call.getChildElement('id', ns).getText()) : null;
            // t = [Select Id, dealer__Company_Number__c from dealer__Traffic_Log__c where dealer__Call_Accounting_ID__c =:callAcctId ];    
            
            System.debug('Testing T'+t);
            
        } else {
            return false;
        }
        
        if(companyNumber!=null) {
            t.dealer__Company_Number__c = companyNumber;
        }
        
        // Set Traffic Type
        t.dealer__Type__c = 'Phone';
        
        if(call!=null) {
            
            t.dealer__Call_Accounting_ID__c     =   (call.getChildElement('id', ns)!=null) ? String.valueOf(call.getChildElement('id', ns).getText()) : null;
            t.dealer__Call_Start__c             =   (call.getChildElement('callStart', ns)!=null) ? parseDateTime(call.getChildElement('callStart', ns).getText()) : null;
            t.dealer__Call_End__c               =   (call.getChildElement('callEnd', ns)!=null) ? parseDateTime(call.getChildElement('callEnd', ns).getText()) : null;
            t.dealer__Call_Termination_Cause__c =   (call.getChildElement('terminationCause', ns)!=null) ? String.valueOf(call.getChildElement('terminationCause', ns).getText()) : null;
            t.dealer__Conversation_Start__c     =   (call.getChildElement('conversationStart', ns)!=null) ? parseDateTime(call.getChildElement('conversationStart', ns).getText()) : null;
            t.dealer__Conversation_End__c       =   (call.getChildElement('conversationEnd', ns)!=null) ? parseDateTime(call.getChildElement('conversationEnd', ns).getText()) : null;
            t.dealer__Call_Profile_Link__c      =   (call.getChildElement('profileLink', ns)!=null) ? String.valueOf(call.getChildElement('profileLink', ns).getText()) : null;
            t.dealer__Call_Direction__c         =   'Inbound';
        }
        
        if(caller!=null) {
            // Locate Customer
            phoneNumber = caller.getChildElement('id', ns).getText();
            callerFirst = caller.getChildElement('firstName', ns).getText();
            callerLast  = caller.getChildElement('lastName', ns).getText();
            
            Contact[] c = [Select Id 
                                from Contact 
                                where FirstName =:callerFirst 
                                and LastName =:callerLast
                                and (
                                    Phone =:phoneNumber
                                    or MobilePhone =:phoneNumber
                                    or OtherPhone =:phoneNumber 
                                )]; 
            
            // Get Matching Sales Ups
            dealer__Traffic_Log__c[] msup = [Select Id from dealer__Traffic_Log__c where dealer__Calling_Number__c = :phoneNumber limit 1];
            if(msup.size()>0){
                 t.dealer__Fresh_Call__c=false;   
            }
            
            if(c.size()>0) {
                t.dealer__Customer_Contact__c = c[0].Id;
            }                   
            
            t.dealer__Calling_Number__c = (caller.getChildElement('id', ns)!=null) ? String.valueOf(caller.getChildElement('id', ns).getText()) : null;
            t.dealer__Phone_Type__c     = (caller.getChildElement('phoneType', ns)!=null) ? String.valueOf(caller.getChildElement('phoneType', ns).getText()) : null;
            t.dealer__Caller_Id_FirstName__c    =(caller.getChildElement('firstName', ns)!=null) ? String.valueOf(caller.getChildElement('firstName', ns).getText()) : null;
            t.dealer__Caller_Id_LastName__c     =(caller.getChildElement('lastName', ns)!=null) ? String.valueOf(caller.getChildElement('lastName', ns).getText()) : null;
            t.dealer__Customer_Email__c         =(caller.getChildElement('email', ns)!=null) ? String.valueOf(caller.getChildElement('email', ns).getText()) : null;
            t.Name = t.dealer__Calling_Number__c+' '+t.dealer__Caller_Id_FirstName__c+' '+t.dealer__Caller_Id_LastName__c;
            if(t.dealer__Caller_Id_FirstName__c!=null) { 
                if(t.dealer__Caller_Id_FirstName__c.length() >= 48) {
                    t.dealer__Caller_Id_FirstName__c = t.dealer__Caller_Id_FirstName__c.substring(0, 48);
                }
            }
        }
        
        if(inumber!=null) {
            t.dealer__Called_Number__c  =   (inumber.getChildElement('id', ns)!=null) ? String.valueOf(inumber.getChildElement('id', ns).getText()) : null;
            t.dealer__Called_Internal_Number__c = (inumber.getChildElement('destinationNumber', ns)!=null) ? String.valueOf(inumber.getChildElement('destinationNumber', ns).getText()) : null;
            t.dealer__Source__c = (inumber.getChildElement('label', ns)!=null) ? String.valueOf(inumber.getChildElement('label', ns).getText()) : null;
        }
        
        if(account!=null) {
            t.dealer__Call_Integration_Account_ID__c    =   (account.getChildElement('id', ns)!=null) ? String.valueOf(account.getChildElement('id', ns).getText()) : null;
        }
        
        System.debug(t);

        if(t.Id != null) {
            update t;
        } else {
            insert t;
        }
        
        if(t.Id==null) {
            return false;
        } else {
            return true;    
        }
    }
    
    /**
     * parseDateTime 
     * @param  d 
     * @return DateTime
     * @description Formats Date/Time to the following: 2013-06-04T23:41:55Z
     */ 
    public DateTime parseDateTime(String d) 
    {
        // Format:2013-06-04T23:41:55Z
        if(d.length()!=20) {
            return null;
        }
        
        string year = d.substring(0, 4);
        string month = d.substring(5, 7);
        string day = d.substring(8, 10);
        string hour = d.substring(11, 13);
        string minute = d.substring(14, 16);
        string second = d.substring(17, 19);
        string stringDate = year + '-' + month
         + '-' + day + ' ' + hour + ':' + 
        minute +  ':' + second;
        DateTime dt = DateTime.valueOf(stringDate);
        if(dt!=null) {
            return dt;
        } else {
            return null;
        }
    }
    
    /**
     * alertFailedADF 
     * @param  emailBody 
     * @return void
     * @description Sends email alert notifying DealerTeam of ADF Voice Package Failure for an Org.
     */ 
    public void alertFailedADF(String emailBody) 
    {
            
            Messaging.reserveSingleEmailCapacity(1);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'support@dealerteam.com'}; 
            mail.setToAddresses(toAddresses);
            mail.setSenderDisplayName('DealerTeam Support');
            mail.setSubject('ADF Voice Package Failure : ' + UserInfo.getOrganizationName() + ' : ' +UserInfo.getOrganizationId());
            mail.setPlainTextBody(emailBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
    }
    
    /**
     * setCompanyNumber 
     * @param  toEmail 
     * @return void
     * @description Capture local part of email for reference in routing table.
     */ 
    public void setCompanyNumber(String toEmail) 
    {
        // Capture local part of email for reference in routing table.
        // Email's are only allowed to be 80 characters in Salesforce, yet the email services email address issued id usually over 90 charachters...
        String[] emailLocalPart = toEmail.split('@', 2);
        System.debug(emailLocalPart[0]);
        dealer__IntercompanyLeadRouting__c[] lr = [Select Id, dealer__Company_Number__c from dealer__IntercompanyLeadRouting__c where dealer__LocalName__c = :emailLocalPart[0] limit 1];
        if(lr.size()>0) {
            this.companyNumber = lr[0].dealer__Company_Number__c;
        }
    }
    
    /**
     * ADFException
     * @description
     */ 
    public class ADFException extends Exception{}
    
}