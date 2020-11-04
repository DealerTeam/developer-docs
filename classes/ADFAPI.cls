public with sharing class ADFAPI {

    /**
     * ADF XML payload used to send or read
     */
    public static String payload {get;set;}
    public static  String toEmail {get;set;}
    public static String fromEmail {get;set;}
    public String readableXML {get;set;}

    /**
     * getInstance
     * @return dealer__CRMSettings__c
     * @description DOM.Document adfDoc = new DOM.Document(); 
     */
    public dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();

    /**
     * @description
     */ 
    public String customerEmail {get;set;}

    /**
     * @description
     */
    public String customerFirstName {get;set;}
    
    /**
     * @description
     */ 
    public String customerLastName {get;set;}
    
    /**
     * @description
     */ 
    public String customerFullName {get;set;}

    /**
     * @description
     */ 
    public String customerDayPhone {get;set;}
    
    /**
     * @description
     */ 
    public String customerEveningPhone {get;set;}
    
    /**
     * @description
     */ 
    public String customerCellPhone {get;set;}

    /**
     * @description
     */ 
    public String customerAddressLine1  {get;set;}
    
    /**
     * @description
     */ 
    public String customerAddressLine2  {get;set;}
    
    /**
     * @description
     */ 
    public String customerCity {get;set;}
    
    /**
     * @description
     */ 
    public String customerState {get;set;}
    
    /**
     * @description
     */ 
    public String customerZip {get;set;}

    /**
     * @description
     */ 
    public String companyNumber = null;

    /**
     * @description
     */ 
    public String providerName = null;
    
    /**
     * @description
     */ 
    public String providerService = null;

    /**
     * storeLocation
     * @return String
     * @description Added MKS 1-26-16
     */ 
    public String storeLocation {get;set;}

    /**
     * @return dealer__Dealer_Location__c 
     * @description To store associated company to take related SalesUp queue
     */
    public dealer__Dealer_Location__c objStoreLocation = new dealer__Dealer_Location__c(); 

    /**
     * @return dealer__IntercompanyLeadRouting__c 
     * @description Intercompany Routing Table for this Request
     */
    public dealer__IntercompanyLeadRouting__c lead_routing = new dealer__IntercompanyLeadRouting__c();

    /**
     * @description
     */ 
    public String stockNumber {get;set;}

    /**
     * @description
     */ 
    public String finance = null;

    public Id curbPurchaseId;
    public Id standardSalesUp;
    public Boolean isBuyInterest=false;
    public Boolean isSaleTradeInterest=false;
    public Appraisal_Vehicle__c av = new Appraisal_Vehicle__c();
    public Sales_Up__c up = new Sales_Up__c();
    public Desired_Vehicle__c dv = new Desired_Vehicle__c();
    public Contact buyerContact = new Contact();
    public Account buyerAccount = new Account();
    public Id buyerContactId;
    public Traffic_Log__c trafficLog = new Traffic_Log__c();
    public Date beforeTime;
    public List<dealer__Sales_Up__c> supCheck = new List<dealer__Sales_Up__c>();
    public String toEmailAddress;
    public String fromEmailAddress;

    private static final ADFAPI instance = new ADFAPI();
    public List<Desired_Vehicle__c> dvList = new List<Desired_Vehicle__c>();
    public List<Task> taskList = new List<Task>();
    List<Traffic_Log__c> trafficLogList = new List<Traffic_Log__c>();


    public static ADFAPI getInstance()
    {
        return instance;
    }
    

    public void readXML()
    {

    }

    
    public static void outputXML(Sales_Up__c s, String email)
    {
		Xmlstreamwriter xmlFeed = new Xmlstreamwriter();
        toEmail = email;
        ADF.ADFHeader header = ADF.createFromSUP(s);
            xmlFeed.writeStartDocument('utf-8','1.0');
            xmlFeed.writeProcessingInstruction('adf','version="1.0"');
    			xmlFeed.writeStartElement(null,'adf', null);
                    xmlFeed.writeStartElement(null,'prospect', null);
                    // Write vehicle tag
                    if(header.vehicles != null && header.vehicles.size() > 0){
                        xmlFeed.writeStartElement(null,'vehicle', null);
                            xmlFeed.writeAttribute(null,null,'interest', header.vehicles[0].interest);
                            xmlFeed.writeAttribute(null,null,'status', header.vehicles[0].status);
                            xmlFeed.writeStartElement(null,'year', null);
                                xmlFeed.writeCharacters(header.vehicles[0].year);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'make', null);
                                xmlFeed.writeCharacters(header.vehicles[0].make);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'model', null);
                                xmlFeed.writeCharacters(header.vehicles[0].model);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'vin', null);
                                xmlFeed.writeCharacters(header.vehicles[0].vin);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'stock', null);
                                xmlFeed.writeCharacters(header.vehicles[0].stock);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'trim', null);
                                xmlFeed.writeCharacters(header.vehicles[0].trim);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'doors', null);
                                xmlFeed.writeCharacters(header.vehicles[0].doors);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'bodystyle', null);
                                xmlFeed.writeCharacters(header.vehicles[0].bodystyle);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'transmission', null);
                                xmlFeed.writeCharacters(header.vehicles[0].transmission);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'odometer', null);
                                xmlFeed.writeAttribute(null,null,'status', header.vehicles[0].odometerStatus);
                                xmlFeed.writeCharacters(header.vehicles[0].odometer);
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null,'condition', null);
                                xmlFeed.writeCharacters(header.vehicles[0].condition);
                            xmlFeed.writeEndElement();
                            if(header.vehicles[0].vPrice != null){
                                xmlFeed.writeStartElement(null,'price', null);
                                xmlFeed.writeAttribute(null,null,'type', header.vehicles[0].vPrice.type);
                                xmlFeed.writeAttribute(null,null,'currency', header.vehicles[0].vPrice.currencyCode);
                                    xmlFeed.writeCharacters(header.vehicles[0].vPrice.value);
                                xmlFeed.writeEndElement();
                            }
                            
                            xmlFeed.writeStartElement(null,'finance', null);
                                xmlFeed.writeStartElement(null, 'method', null);
                                if(header.vehicles[0].financeAmounts != null){
                                    for(ADF.financeAmount fin : header.vehicles[0].financeAmounts){
                                        xmlFeed.writeStartElement(null,'amount', null);
                                        xmlFeed.writeAttribute(null,null,'type', fin.type);
                                        xmlFeed.writeAttribute(null,null,'currency', fin.currencyCode);
                                            xmlFeed.writeCharacters(fin.value);
                                        xmlFeed.writeEndElement();
                                    }
                                }
                                    
                                xmlFeed.writeEndElement(); //close method
                            xmlFeed.writeEndElement(); //close finance
                            

                        xmlFeed.writeEndElement(); //close vehicle
                    }

                        xmlFeed.writeStartElement(null,'customer', null);
                            if(header.customers != null){
                                xmlFeed.writeStartElement(null,'contact', null);

                                xmlFeed.writeAttribute(null,null,'primarycontact', header.customers[0].con.primary);
                                if(header.customers[0].con.firstName != ''){
                                    xmlFeed.writeStartElement(null, 'name', null);
                                        xmlFeed.writeAttribute(null, null, 'part', 'first');
                                        xmlFeed.writeCharacters(header.customers[0].con.firstName);
                                    xmlFeed.writeEndElement();
                                }
                                if(header.customers[0].con.lastName != ''){
                                    xmlFeed.writeStartElement(null, 'name', null);
                                        xmlFeed.writeAttribute(null, null, 'part', 'last');
                                        xmlFeed.writeCharacters(header.customers[0].con.lastName);
                                    xmlFeed.writeEndElement();
                                }
                                if(header.customers[0].con.fullName != '' && header.customers[0].con.fullName != null){
                                    xmlFeed.writeStartElement(null, 'name', null);
                                        xmlFeed.writeAttribute(null, null, 'part', 'full');
                                        xmlFeed.writeCharacters(header.customers[0].con.fullName);
                                    xmlFeed.writeEndElement();
                                }
                                if(header.customers[0].con != null && header.customers[0].con.email != null){
                                    xmlFeed.writeStartElement(null, 'email', null);
                                        if(header.customers[0].con.email.preferred != '' && header.customers[0].con.email.preferred != null){
                                            xmlFeed.writeAttribute(null, null, 'preferredcontact', header.customers[0].con.email.preferred);
                                        }
                                        xmlFeed.writeCharacters(header.customers[0].con.email.emailAddress);
                                    xmlFeed.writeEndElement();
                                }
                                if(header.customers[0].con != null && header.customers[0].con.phones != null){
                                    for(ADF.phone phone : header.customers[0].con.phones){
                                        xmlFeed.writeStartElement(null,'phone', null);
                                            xmlFeed.writeAttribute(null, null, 'type', phone.type);
                                            xmlFeed.writeAttribute(null, null, 'time', phone.timeToCall);
                                            xmlFeed.writeAttribute(null, null, 'preferredcontact', phone.preferred);
                                            xmlFeed.writeCharacters(phone.phoneNumber);
                                        xmlFeed.writeEndElement();
                                    }
                                }
                                if(header.customers[0].con != null && header.customers[0].con.address != null){
                                    xmlFeed.writeStartElement(null, 'address', null);
                                    if(header.customers[0].con.address.street1 != ''){
                                        xmlFeed.writeStartElement(null, 'street', null);
                                            xmlFeed.writeAttribute(null, null, 'line', '1');
                                            xmlFeed.writeCharacters(header.customers[0].con.address.street1);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.customers[0].con.address.street2 != ''){
                                        xmlFeed.writeStartElement(null, 'street', null);
                                            xmlFeed.writeAttribute(null, null, 'line', '2');
                                            xmlFeed.writeCharacters(header.customers[0].con.address.street2);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.customers[0].con.address.city != ''){
                                        xmlFeed.writeStartElement(null, 'city', null);
                                            xmlFeed.writeCharacters(header.customers[0].con.address.city);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.customers[0].con.address.regionCode != ''){
                                        xmlFeed.writeStartElement(null, 'regioncode', null);
                                            xmlFeed.writeCharacters(header.customers[0].con.address.regioncode);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.customers[0].con.address.postalCode != ''){
                                        xmlFeed.writeStartElement(null, 'postalcode', null);
                                            xmlFeed.writeCharacters(header.customers[0].con.address.postalCode);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.customers[0].con.address.country != ''){
                                        xmlFeed.writeStartElement(null, 'country', null);
                                            xmlFeed.writeCharacters(header.customers[0].con.address.country);
                                        xmlFeed.writeEndElement();
                                    }
                                    xmlFeed.writeEndElement(); //close address
                                }
                                xmlFeed.writeEndElement(); //close contact
                            }
                        xmlFeed.writeEndElement(); //close customer
                        if(header.vendor != null && header.vendor.name != null){                        
                            xmlFeed.writeStartElement(null, 'vendor', null);
                                xmlFeed.writeStartElement(null, 'vendorname', null);
                                    xmlFeed.writeCharacters(header.vendor.name);
                                xmlFeed.writeEndElement();
                                xmlFeed.writeStartElement(null, 'url', null);
                                    xmlFeed.writeCharacters(header.vendor.url);
                                xmlFeed.writeEndElement();
                                xmlFeed.writeStartElement(null, 'contact', null);
                                xmlFeed.writeEndElement();
                            xmlFeed.writeEndElement(); //close vendor
                        }
                        xmlFeed.writeStartElement(null, 'provider', null);
                        if(header.leadProvider != null && header.leadprovider.providerName != null){
                            xmlFeed.writeStartElement(null, 'name', null);
                                if(header.leadProvider.service != null && header.leadProvider.service != ''){
                                    xmlFeed.writeCharacters(header.leadProvider.service);
                                }
                            xmlFeed.writeEndElement();
                            xmlFeed.writeStartElement(null, 'service', null);
                                xmlFeed.writeCharacters(header.leadProvider.providerName.fullName);
                            xmlFeed.writeEndElement();
                            if(header.leadProvider.providerName.phones[0].phoneNumber != null){
                                xmlFeed.writeStartElement(null, 'phone', null);
                                    xmlFeed.writeCharacters(header.leadProvider.providerName.phones[0].phoneNumber);
                                xmlFeed.writeEndElement();
                            }
                            xmlFeed.writeStartElement(null, 'contact', null);
                                xmlFeed.writeAttribute(null, null, 'primarycontact', '1');
                                xmlFeed.writeStartElement(null, 'address', null);
                                    if(header.leadProvider.providerName.address.street1 != null){
                                        xmlFeed.writeStartElement(null, 'street', null);
                                            xmlFeed.writeCharacters(header.leadProvider.providerName.address.street1);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.leadProvider.providerName.address.city != null){
                                        xmlFeed.writeStartElement(null, 'city', null);
                                            xmlFeed.writeCharacters(header.leadProvider.providerName.address.city);
                                        xmlFeed.writeEndElement();
                                    }
                                    if(header.leadProvider.providerName.address.regionCode != null){
                                        xmlFeed.writeStartElement(null, 'regioncode', null);
                                            xmlFeed.writeCharacters(header.leadProvider.providerName.address.regionCode);
                                        xmlFeed.writeEndElement();
                                    }                                    
                                    if(header.leadProvider.providerName.address.postalCode != null){
                                        xmlFeed.writeStartElement(null, 'postalcode', null);
                                            xmlFeed.writeCharacters(header.leadProvider.providerName.address.postalCode);
                                        xmlFeed.writeEndElement();
                                    }                                    
                                    if(header.leadProvider.providerName.address.country != null){
                                        xmlFeed.writeStartElement(null, 'country', null);
                                            xmlFeed.writeCharacters(header.leadProvider.providerName.address.country);
                                        xmlFeed.writeEndElement();
                                    }                                    
                                xmlFeed.writeEndElement(); //close address
                            xmlFeed.writeEndElement();//close contact
                        }
                        xmlFeed.writeEndElement(); //close provider


                    xmlFeed.writeEndElement(); //Close prospect			
                xmlFeed.writeEndElement(); //Close adf		

        payload = xmlFeed.getXmlString();
		System.debug('The XML :'+ payload);     
		xmlFeed.close();

        sendXML(payload, toEmail);

    }

    /**
     * sendXML sends an ADF xml payload to the provided email
     */
    public static void sendXML(String payload, String toEmail)
    {
        //what email do we send from?

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                
        List<String> toAddresses = new List<String> {toEmail};   
        mail.setToAddresses(toAddresses);
        mail.setSubject('New ADF Lead');
        mail.setPlainTextBody(payload);
        //We only want to send the email outside of testing
        if(!Test.isRunningTest()){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }

    }

    /**
     * parseADF
     * @description Converts XML into Sales Up and related records
     * @param  XML String of ADF payload
     * @param  toAddress   toAddress description
     * @param  fromAddress fromAddress description
     * @return             return description
     */
    public dealer__Sales_Up__c parseADF(String XML, String toAddress, String fromAddress)
    {
        DOM.Document adfDoc = new DOM.Document();
        try {
            
            // Some vendors include bullshit whitespace
            // XML = XML.deleteWhitespace();
            XML = XML.replaceAll('[\r]+', ''); 
            XML = XML.replaceAll('[\n]+', '');  // This is supposed to catch return carriage
            // Possbile check for Blank Line at begining of email body
            XML = XML.replace('<?ADF VERSION "1.0"?>', '');
            // temporary hack to remove the <![CDATA[ ]]>
            // 12/18/2012 - to be removed once solution decided upon (Jarrett Kuljis)
            // DOM.XmlNode does not understand cdata, possible 
            // we may need to conver to XmlStreamReader
            XML = XML.replace('<![CDATA[', '');
            XML = XML.replace(']]>', '');
            XML = XML.replace('&', '&amp;');

            // Replace HTML Entities, crude hack, needs to be replaced with proper regex.
            XML = XML.replace('<p>', '');
            XML = XML.replace('</p>', '');
            XML = XML.replace('<br />', '');
            XML = XML.replace('<br>', '');
            XML = XML.replace('</br>', '');
            XML = XML.replace('<h3>', '');
            XML = XML.replace('</h3>', '');

            readableXML = XML;

            adfDoc.load(XML);
            DOM.Xmlnode root = adfDoc.getRootElement();

            // Identify a Location Routing Entry if one exist.
            setLocationRouting(toAddress);
            
            // Set company number
            setCompanyNumber(toAddress);
            
            // Declare From email, for storage in the Sales Up
            setFromAddress(fromAddress);
            
            return exposeADF(root);

        } catch (Exception e) {
            logException(new ADFException(e.getMessage()), 'parseADF');
            EmailExceptionToAdmin OutGoingEmail = new EmailExceptionToAdmin('ADF Parser',e, XML);           

            return null;
        }  
    }

    /**
    * setLocationRouting 
    * @param toEmail [email to locate routing table from]
    * @return void
    * @description Assigns the public property of location_routing
    */
    public void setLocationRouting(String toEmail) 
    {
        dealer__IntercompanyLeadRouting__c[] leadrouting_table = [Select dealer__Company_Number__c, dealer__Lead_Type__c, 
                                                                        dealer__LocalName__c, dealer__RoutedEmail__c
                                                                    FROM dealer__IntercompanyLeadRouting__c
                                                                    WHERE dealer__RoutedEmail__c =:toEmail
                                                                    LIMIT 1];
        if(leadrouting_table.size()==1) {
            lead_routing=leadrouting_table[0];
        }
    }

    /**
    * setCompanyNumber 
    * @param  toEmail 
    * @return void
    * @description MKS 1-26-16: Added Store Location information.
    */
    public void setCompanyNumber(String toEmail) 
    {
        // Capture local part of email for reference in routing table.
        // Email's are only allowed to be 80 characters in Salesforce, yet the email services email address issued id usually over 90 charachters...
        this.toEmailAddress = toEmail;
        String[] emailLocalPart = toEmailAddress.split('@', 2);
        dealer__IntercompanyLeadRouting__c[] lr = [Select Id, dealer__Company_Number__c from dealer__IntercompanyLeadRouting__c where dealer__LocalName__c = :emailLocalPart[0] limit 1];

        if(lr.size()>0) {
            this.companyNumber = lr[0].dealer__Company_Number__c;

            //MKS1 Cannot get Store Location from Company Number if no Company Number present
            dealer__Dealer_Location__c[] storeLocationList = [Select Id, Name, dealer__Company_Number__c, dealer__SalesUp_Queue__c from dealer__Dealer_Location__c where dealer__Company_Number__c = :lr[0].dealer__Company_Number__c limit 1];
            if(storeLocationList.size()>0){
                this.storeLocation = storeLocationList[0].Id;
                objStoreLocation = storeLocationList[0];
            }
            //end MKS1
        }
        else{
            System.debug('No Company Number found for the incoming email address.');

        }
    }

    /**
    * setFromAddress 
    * @param fromEmail 
    * @return void
    * @description Sets e-mail as that found within the XML
    */ 
    public void setFromAddress(String fromEmail) 
    {
        this.fromEmailAddress = fromEmail;
    }

    /**
    * exposeADF 
    * @param adfDom 
    * @return dealer__Sales_Up__c 
    * @description
    */
    public dealer__Sales_Up__c exposeADF(DOM.Xmlnode adfDom) 
    {
        
        system.debug('exposeADF');
        
        DOM.Xmlnode header      =   adfDom.getChildElement('prospect', null);
        if(header == null) {
            return null;
        }

        // Get multiple vehicle child nodes.
        DOM.Xmlnode[] subNodes  =   header.getChildElements();
        // dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c();
        // dealer__Appraisal_Vehicle__c av = new dealer__Appraisal_Vehicle__c();

        
        for(DOM.Xmlnode subX : subNodes) {
                if(subX.getName()=='vehicle') {                    
                    parseVehicle(subX);
                } // End vehicle sub node
        }// End sub node iteration
        
        DOM.Xmlnode customer    =   header.getChildElement('customer', null);       
        DOM.XmlNode vehicle     =   header.getChildElement('vehicle',null);
        DOM.XmlNode vendor      =   header.getChildElement('vendor',null);
        DOM.XmlNode provider    =   header.getChildElement('provider',null);

        Set<String> allEmails = new Set<String>();

        if ( vendor != null && vendor.getChildElement('contact', null) != null) {
            DOM.Xmlnode[] nameFields    =   vendor.getChildElement('contact', null).getChildElements();
            for(DOM.Xmlnode nameElements : nameFields) {
                if ( nameElements.getName() == 'email' ) {
                    if ( String.isNotEmpty(nameElements.getText()) ) {
                        allEmails.add(nameElements.getText());
                    }
                }
            }
        }

        for ( User u: [ SELECT Id, Username FROM User WHERE Username IN: allEmails AND IsActive = true ] ) {
            up.OwnerId = u.Id;
            up.dealer__Salesperson_1__c = u.Id;
        }

        for ( Group g: [ SELECT Id,DeveloperName FROM Group WHERE Type = 'Queue' AND DeveloperName IN: allEmails ] ) {
            up.OwnerId = g.Id;
        }

        // Customer (Prospect) Node 
        if(customer != null) {                                                 
            parseCustomer(customer);
        }
    
        // Provider Node
        if(provider != null) {
            parseProvider(provider);        
        }
        
        // Check ID and set if the lead is derived from Urban Science
        // LMS ID Node
        if(header.getChildElement('id',null) != null && up.dealer__Lead_Origination_Service__c == 'Urban Science') {
            up.dealer__LMS_ID__c = String.valueOf(header.getChildElement('id',null).getText());
        } 

        // Record Traffic Log Entry to be tied back to Lead info
        if(up.dealer__Source__c==null) { up.dealer__Source__c = ''; }
        if(up.Name==null) { up.Name = ''; }
        trafficLog = new dealer__Traffic_Log__c(
                            Name=up.dealer__Source__c+' Internet Lead '+up.Name,
                            dealer__Customer_Contact__c=up.dealer__Buyer_Contact__c,
                            dealer__Type__c='Email',
                            dealer__Source__c=up.dealer__Source__c
                        );
        trafficLogList.add(trafficLog);
        
        if(customerEmail!=null){
            customerEmail=customerEmail.trim();//W-000448
        }

        Integer activeTimePeriod = 30;
        if(crm!=null && crm.dealer__ILM_Duplicate_Time_Period__c!=null) {
            activeTimePeriod=Integer.valueOf(crm.dealer__ILM_Duplicate_Time_Period__c);
        }
        beforeTime = Date.today() - activeTimePeriod;
        
        queryExistingSalesUps();
        
        // check for the duplicate match criteria
        // Set the Traffic Entry
        // insert(trafficLog);                                                  
        // up.dealer__Traffic_Log_Entry__c=trafficLog.Id;
        up.dealer__Disposition__c = 'Open';        

        if(supCheck.size()>0 && crm.dealer__ILM_No_Duplicates__c == true && customerEmail!='' && customerEmail!=null) {
            system.debug('SUP is DUPE');
            handleDuplicates();
            
                        
        } else {
             system.debug('SUP is new');

            //Insert respective Contact/Account if not existing
            // If PersonsAccounts Enable use Persons Accounts Else Use Contacts
            handleNew();
        }
        
        // // update trafficLog;   
        
        return up;
    }

    /**
    * parseVehicle extract vehicle data from xml
    * @param  subX xml node with vehicle data
    */
    private void parseVehicle(DOM.Xmlnode subX)
    {
        //W-000521 begin
        String standardName = DealerMetadata.getConfigValue('SalesUpStandardRecordTypeName');
        String curbName = DealerMetadata.getConfigValue('SalesUpCurbPurchaseRecordTypeName');
        //Get Standard & Curb Purchase record type
        try{
            List<RecordType> recTypes = [SELECT Id,developerName FROM RecordType WHERE SobjectType='dealer__Sales_Up__c' and (developerName=:standardName or developerName=:curbName) AND isActive = true];
            for(RecordType recType : recTypes){
                if(recType.developerName== standardName){
                    standardSalesUp = recType.Id;
                }
                if(recType.developerName==curbName){
                    curbPurchaseId=recType.Id;
                }
            }
            if(standardSalesUp == null){
                throw new ADFException('No active standard sales up found.');
            }
        } catch(Exception e){
            logException(new ADFException(e.getMessage()), 'parseVehicle');
            
        }
        

        //W-000521 end

        // Process Trade
        //W-000521 begin - populate trade in Values when interest="Sell"
        if(subX.getAttributeValue('interest', null)=='Trade-In' || subX.getAttributeValue('interest', null)=='trade-in' ||
            subX.getAttributeValue('interest', null)=='Sell' || subX.getAttributeValue('interest', null)=='sell') {
                
            isSaleTradeInterest = true;
            system.debug('interest sell | trade-in');

            //W-000651 If a Vehicle with interest = [Sell, Trade] create a new Appraisal Vehicle                            
            av.dealer__Year__c  =  up.dealer__Trade_Year__c = (subX.getChildElement('year',null) != null) ? String.valueOf(subX.getChildElement('year',null).getText()) : null;
            av.dealer__Make__c  =  up.dealer__Trade_Make__c = (subX.getChildElement('make',null) != null) ? String.valueOf(subX.getChildElement('make',null).getText()) : null;
            av.dealer__Model__c =  up.dealer__Trade_Model__c = (subX.getChildElement('model', null) != null) ? String.valueOf(subX.getChildElement('model', null).getText()) : null;
            av.dealer__VIN__c   =  up.dealer__Trade_VIN__c = (subX.getChildElement('vin',null) != null) ? String.valueOf(subX.getChildElement('vin',null).getText()) : null;
            av.dealer__Trim_Level__c = up.dealer__Trade_Trim_Level__c  = (subX.getChildElement('trim',null) != null) ? String.valueOf(subX.getChildElement('trim',null).getText()) : null;  
                    
            // Trade can not not contain a comma 
            if(subX.getChildElement('odometer',null) != null) {
                String odometer = subX.getChildElement('odometer',null).getText();
                odometer = odometer.replaceAll('[^0-9.]','');
                
                /*Case 00002065 Begin*/
                odometer = odometer.trim();
                if(odometer != ''){
                    up.dealer__Trade_Mileage__c = Decimal.valueOf(odometer);
                }
                /*Case 00002065 End*/    
            }  
            
            up.dealer__Trade_Comments__c = (subX.getChildElement('comments',null) != null) ? String.valueOf(subX.getChildElement('comments',null).getText()) : null;                     
            if(subX.getChildElement('comments',null) != null) {
                if(up.dealer__Trade_Comments__c.length()>255) {
                    up.dealer__Trade_Comments__c = up.dealer__Trade_Comments__c.subString(0, 255);
                }
            }

            //Check if stock number does not exist
            if(subX.getChildElement('stock',null) == null && (subX.getAttributeValue('interest', null)=='Sell' || subX.getAttributeValue('interest', null)=='sell')){
                if(curbPurchaseId == null){
                    throw new ADFException('No active curb purchase sales up found.');                
                }
                //Assign Curb Purchase Record Id if inetrest=sell
                up.recordTypeId = curbPurchaseId;
            }

            //Assign standard sales up Record Id if intrest=trade-in
            if((subX.getAttributeValue('interest', null)=='Trade-In' || subX.getAttributeValue('interest', null)=='trade-in') && standardSalesUp!=null ){
                up.recordTypeId=standardSalesUp;
            }
            
        //W-000521 begin - Check if interest="buy"
        } else if(subX.getAttributeValue('interest', null)=='Buy' || subX.getAttributeValue('interest', null)=='buy' ||
                subX.getAttributeValue('interest', null)=='lease' || subX.getAttributeValue('interest', null)=='Lease'){
                
            isBuyInterest=true;
            system.debug('interest buy | lease');
                
            // Process Interest
            // W-000651 If a Vehicle with interest = [Buy, Lease] create a new desired vehicle
            dv.dealer__Year__c   = up.dealer__Year_High__c    =   (subX.getChildElement('year',null) != null) ? String.valueOf(subX.getChildElement('year',null).getText()) : null;
            dv.dealer__Make__c   = up.dealer__Make__c         =   (subX.getChildElement('make',null) != null) ? String.valueOf(subX.getChildElement('make',null).getText()) : null;
            dv.dealer__Model__c  = up.dealer__Model__c        =   (subX.getChildElement('model', null) != null) ? String.valueOf(subX.getChildElement('model', null).getText()) : null;
            dv.dealer__VIN__c    = up.dealer__VIN__c          =   (subX.getChildElement('vin',null) != null) ? String.valueOf(subX.getChildElement('vin',null).getText()) : null;
            dv.dealer__Trim_Level__c = up.dealer__Trim__c         =   (subX.getChildElement('trim',null) != null) ? String.valueOf(subX.getChildElement('trim',null).getText()) : null;
            up.dealer__Transmission__c =  (subX.getChildElement('transmission',null) != null) ? String.valueOf(subX.getChildElement('transmission',null).getText()) : null;
            //W-000464 - trim the stock string 
            this.stockNumber                =   (subX.getChildElement('stock',null) != null) ? String.valueOf(subX.getChildElement('stock',null).getText()).trim() : null;

            // Specify NUO
            if(subX.getAttributeValue('status', null)=='used') { 
                up.dealer__NUO__c = 'U'; 
                dv.dealer__New_Used_Other__c  = 'Used'; 
            }
            if(subX.getAttributeValue('status', null)=='new') { 
                up.dealer__NUO__c = 'N'; 
                dv.dealer__New_Used_Other__c  = 'New'; 
            }
            
            // Finance Data (Buy)
            if(subX.getChildElement('finance',null)!=null) {
                DOM.Xmlnode[] financeFields =   subX.getChildElement('finance',null).getChildElements();
    
                if(financeFields != null) {
                    for(DOM.Xmlnode financeElements : financeFields) {  
                        if(financeElements.getName() == 'method') {
                            up.dealer__Finance_Method__c = String.valueOf(financeElements.getText());
                        }
                        if(financeElements.getName() == 'amount' && financeElements.getAttribute('type', null) =='monthly' && !String.isBlank(financeElements.getText().remove('$').remove(','))) {
                            up.dealer__Desired_Monthly_Payment__c = Decimal.valueOf(financeElements.getText().remove('$').remove(','));
                        }
                        if(financeElements.getName() == 'amount' && financeElements.getAttribute('type', null)== 'total' && !String.isBlank(financeElements.getText().remove('$').remove(','))) {
                            up.dealer__Pre_qualified_Loan_Amount__c = Decimal.valueOf(financeElements.getText().remove('$').remove(','));
                        }
                        if(financeElements.getName() == 'amount' && financeElements.getAttribute('type', null)== 'downpayment' && !String.isBlank(financeElements.getText().remove('$').remove(','))) {
                            up.dealer__Down_Payment__c = Decimal.valueOf(financeElements.getText().remove('$').remove(','));
                        }                               
                    }
                }
            }
            
        }
        
        if(this.stockNumber != null) {
            dealer__Vehicle_Inventory__c doInv = this.assignInventoryRecord();
            if(doInv != null) {
                up.dealer__Desired_Stock_Num__c = doInv.Id;
            }
        }
        
        if(subX.getChildElement('colorcombination',null) != null && subX.getChildElement('colorcombination',null).getChildElement('exteriorcolor', null) != null) {
            up.dealer__Color_Preference_Ext__c  =   String.valueOf(subX.getChildElement('colorcombination',null).
                                                                getChildElement('exteriorcolor', null).
                                                                getText());
            if(isBuyInterest){ 
                dv.dealer__Exterior_Color__c = String.valueOf(subX.getChildElement('colorcombination',null).
                                                                getChildElement('exteriorcolor', null).
                                                                getText()); 
            }
        }
        
        if(subX.getChildElement('colorcombination',null) != null && subX.getChildElement('colorcombination',null).getChildElement('interiorcolor', null) != null) {
            up.dealer__Color_Preference_Int__c  =   String.valueOf(subX.getChildElement('colorcombination',null).
                                                                getChildElement('interiorcolor', null).
                                                                getText());
            if(isBuyInterest){ 
                dv.dealer__Interior_Color__c = String.valueOf(subX.getChildElement('colorcombination',null).
                                                                getChildElement('interiorcolor', null).
                                                                getText());
            }
        }
        
        if(subX.getChildElement('finance',null) != null && subX.getChildElement('finance',null).getChildElement('method',null) != null){                                                        
            finance = up.Finance_Method__c            =   String.valueOf(subX.getChildElement('finance',null).
                                                                getChildElement('method',null).
                                                                getText()); 
        }  
    }

    /**
    * parseCustomer extract lead customer data from xml
    * @param  customer xml node with customer data
    */
    private void parseCustomer(DOM.XmlNode customer)
    {
        up.dealer__Comments__c          =   (customer.getChildElement('comments',null) != null) ? String.valueOf(customer.getChildElement('comments',null).getText()) : null;
        if(isBuyInterest){
            up.Name =   up.dealer__Year_High__c + ' ' + up.dealer__Make__c + ' ' + up.dealer__Model__c;

        }else{
            up.Name = up.dealer__Trade_Year__c + ' ' + up.dealer__Trade_Make__c + ' ' + up.dealer__Trade_Model__c;
        }
        
        up.dealer__Lead_Type__c         =   (lead_routing!=null && lead_routing.dealer__Lead_Type__c!=null) ? lead_routing.dealer__Lead_Type__c : 'Email';
        up.dealer__Lead_Status__c       =   'Untouched';
        up.dealer__Internet_Customer__c =   true;
        up.dealer__From_Email__c        =   this.fromEmailAddress;


        // Measure source of email
        String[] emailLocalPart = toEmailAddress.split('@', 2);
        
        // Intercompany Routing
        if(companyNumber!=null) {
            up.dealer__Company_Number__c = companyNumber;
        }
        
        up.dealer__Timeframe__c                 =   (customer.getChildElement('timeframe',null) != null) ? String.valueOf(customer.getChildElement('timeframe',null).getText()) : null;
        
        // Customer Name data
        if(customer.getChildElement('contact', null) != null){
            DOM.Xmlnode[] nameFields    =   customer.getChildElement('contact', null).getChildElements();

            for(DOM.Xmlnode nameElements : nameFields) {
                
                if(nameElements.getAttribute('part',null)   ==  'first') {

                    customerFirstName   =   nameElements.getText();
                    customerFirstName   =   customerFirstName.toLowerCase().capitalize();
                    up.dealer__FirstName__c =   customerFirstName;
                }
                
                if(nameElements.getAttribute('part',null)   ==  'last') {

                    customerLastName    =   nameElements.getText();
                    customerLastName    =   customerLastName.toLowerCase().capitalize();
                    up.dealer__LastName__c = customerLastName;
                    if(customerLastName == '') {
                        customerLastName='Not-provided';
                        up.dealer__LastName__c='Not-Provided';
                    }
                }                                                                       
                
                if(nameElements.getAttribute('part',null)   ==  'full') {
                    customerFullName    =   nameElements.getText();
                    if(customerFirstName == null || customerLastName == null || customerFirstName=='' || customerLastName == '') {

                        List<String> customerNameParts = customerFullName.split(' ', 2);

                        if(customerNameParts.size()>0 && customerNameParts[0] != null) {
                            customerFirstName = customerNameParts[0].toLowerCase().capitalize();
                        }
                        
                        if(customerNameParts.size()>1 && customerNameParts[1] != null) {
                            customerLastName  = customerNameParts[1].toLowerCase().capitalize();
                        }
                        
                        up.dealer__FirstName__c = customerFirstName;
                        up.dealer__LastName__c = customerLastName;
                        if(up.dealer__LastName__c==null) {
                            up.dealer__LastName__c='Not-Provided';
                            customerLastName='Not-provided';
                        }
                    } 
                }
                
                if(nameElements.getName() == 'email' && nameElements.getText() != null && nameElements.getText() != '') {
                    
                    // Validate Email - Lead providers may not do this.
                    if(PatternMatcher.validate_Email(nameElements.getText())) {
                        customerEmail       =   nameElements.getText();
                        up.dealer__Email__c =   customerEmail;
                    } else {
                        up.dealer__Comments__c = 'Email address provided does not appear to be valid: '+nameElements.getText();
                    }
                }
                
                if(nameElements.getName() == 'phone' && customerDayPhone==null) {
                    customerDayPhone    =   Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Phone__c =   customerDayPhone;
                    System.debug('Phone only '+ nameElements.getText());
                }
                
                if(nameElements.getName() == 'phone' && nameElements.getAttribute('time',null) == 'morning' && nameElements.getText() != '' && customerDayPhone==null) {
                    customerDayPhone    =   Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Phone__c =   customerDayPhone;
                    System.debug('Phone morning '+ nameElements.getText());
                }                   
                
                if(nameElements.getName() == 'phone' && nameElements.getAttribute('time',null) == 'day' && nameElements.getText() != '' && customerDayPhone==null) {
                    customerDayPhone    =   Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Phone__c =   customerDayPhone;
                    System.debug('Phone day '+ nameElements.getText());
                }
                
                if(nameElements.getName() == 'phone' && nameElements.getAttribute('time',null) == 'evening' && nameElements.getText() != '' && customerEveningPhone==null) {
                    customerEveningPhone=   Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Phone__c = customerEveningPhone;
                    System.debug('Phone evening '+ nameElements.getText());
                }
                    
                if(nameElements.getName() == 'phone' && nameElements.getAttribute('type',null) == 'cellphone' && nameElements.getText() != '' && customerCellPhone==null) {
                    customerCellPhone    =  Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Mobile__c = customerCellPhone;
                    System.debug('Phone cellphone '+ nameElements.getText());
                }           
                
                if(nameElements.getName() == 'phone' && nameElements.getAttribute('type',null) == 'nopreference' && nameElements.getText() != '' && customerDayPhone==null) {
                    customerDayPhone    =   Utility.formatPhoneTen(nameElements.getText());
                    up.dealer__Phone__c =   customerDayPhone;
                    System.debug('Phone nopreference '+ nameElements.getText());
                }                       
            }
            
            //Address Fields
            DOM.Xmlnode addressFields   =   customer.getChildElement('contact', null).getChildElement('address',null);
            if(addressFields != null) {
                customerAddressLine1    =   (addressFields.getChildElement('street',null) != null) ? String.valueOf(addressFields.getChildElement('street',null).getText()) : null;
                customerCity            =   (addressFields.getChildElement('city',null) != null) ? String.valueOf(addressFields.getChildElement('city',null).getText()) : null;
                customerState           =   (addressFields.getChildElement('regioncode',null) != null) ? String.valueOf(addressFields.getChildElement('regioncode',null).getText()) : null;
                customerZip             =   (addressFields.getChildElement('postalcode',null) != null) ? String.valueOf(addressFields.getChildElement('postalcode',null).getText()) : null;
            }
            
            if(customerFirstName != '' && customerLastName != '') {
                // If PersonsAccounts Enable use Persons Accounts Else Use Contacts
                if(!Utility.personsAccountsEnabled()) {
                    buyerContact = this.assignContact();
                    buyerContactId = buyerContact.Id;
                } else {
                    buyerAccount = this.assignAccount();
                    buyerContactId = buyerAccount.PersonContactId;
                }
            }
        }   
    }

    /**
    * parseProvider extract lead provider data from xml
    * @param  provider xml node with provider data
    */
    private void parseProvider(Dom.XmlNode provider)
    {
        providerName = up.dealer__Source__c                    =   (provider.getChildElement('name',null) != null) ? String.valueOf(provider.getChildElement('name',null).getText()) : null;
        providerService = up.dealer__Lead_Origination_Service__c  =   (provider.getChildElement('service',null) != null) ? String.valueOf(provider.getChildElement('service',null).getText()) : null;
    }

    /**
    * queryExistingSalesUps sets supCheck to the result of a query that depends upon interest params
    */
    private void queryExistingSalesUps()
    {
        if(isBuyInterest){
            supCheck = [SELECT Id, CreatedDate,  dealer__Salesperson_1__c, dealer__Salesperson_2__c, 
                                                dealer__Desk_Manager_User__c, OwnerId,Owner.Email,dealer__Buyer_Contact__c,
                                                Name, LastActivityDate, (SELECT Id, dealer__Year__c, dealer__Make__c,  
                                                                dealer__Model__c, dealer__VIN__c, dealer__Trim_Level__c 
                                                                FROM Desired_Vehicles__r)
                                            FROM dealer__Sales_Up__c 
                                            where  ( dealer__Email__c =: customerEmail
                                                    or (dealer__Buyer_Contact__c = :buyerContactId and dealer__Buyer_Contact__c!=null)
                                                )
                                            AND dealer__Is_Open__c = 1
                                            AND ( CreatedDate >= :beforeTime OR LastModifiedDate >= :beforeTime )
                                            LIMIT 100];

        }else if(isSaleTradeInterest){
            
             supCheck = [SELECT Id, CreatedDate,  dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__Trade_VIN__c,
                                                dealer__Desk_Manager_User__c, OwnerId,Owner.Email,dealer__Buyer_Contact__c,
                                                Name, LastActivityDate, (SELECT Id, dealer__Year__c, dealer__Make__c,  
                                                                dealer__Model__c, dealer__VIN__c, dealer__Trim_Level__c 
                                                                FROM Appraisal_Vehicles__r)
                                            FROM dealer__Sales_Up__c 
                                            where  ( dealer__Email__c =: customerEmail
                                                    or (dealer__Buyer_Contact__c = :buyerContactId and dealer__Buyer_Contact__c!=null)
                                                )
                                            AND dealer__Is_Open__c = 1
                                            AND ( CreatedDate >= :beforeTime OR LastModifiedDate >= :beforeTime )
                                            LIMIT 100];
            
        
        }else{
            
            supCheck = [SELECT Id, CreatedDate,  dealer__Salesperson_1__c, dealer__Salesperson_2__c, 
                                                dealer__Desk_Manager_User__c, OwnerId,Owner.Email,dealer__Buyer_Contact__c,
                                                Name, LastActivityDate
                                            FROM dealer__Sales_Up__c 
                                            where  ( dealer__Email__c =: customerEmail
                                                    or (dealer__Buyer_Contact__c = :buyerContactId and dealer__Buyer_Contact__c!=null)
                                                )
                                            AND dealer__Is_Open__c = 1
                                            AND ( CreatedDate >= :beforeTime OR LastModifiedDate >= :beforeTime )
                                            LIMIT 100];
        
        }
    }

    /**
    * handleDuplicates associates the lead with existing records if a match exists
    */
    private void handleDuplicates()
    {
        //Link traffic log to sup
        trafficLog.dealer__Sales_Lead__c=supCheck[0].Id; 
        if(supCheck[0].dealer__Salesperson_1__c!=null) { trafficLog.dealer__Salesperson_1__c=supCheck[0].dealer__Salesperson_1__c;   }
        if(supCheck[0].dealer__Salesperson_2__c!=null) { trafficLog.dealer__Salesperson_2__c=supCheck[0].dealer__Salesperson_2__c;   }
        if(supCheck[0].dealer__Desk_Manager_User__c!=null) { trafficLog.dealer__Desk_Manager__c=supCheck[0].dealer__Desk_Manager_User__c; }
        
        boolean isDupe = false;
        if(isBuyInterest){
            system.debug('SUP is DUPE --> isBuyInterest');
            for(dealer__Desired_Vehicle__c dvl: supCheck[0].Desired_Vehicles__r){
                system.debug('dvl ' + dvl.dealer__VIN__c);
                system.debug('dv ' + dv.dealer__VIN__c);
                if((dv.dealer__VIN__c != null && dv.dealer__VIN__c != '') && dvl.dealer__VIN__c == dv.dealer__VIN__c){
                    system.debug('SUP is DUPE --> isBuyInterest--> same VIN');
                    isDupe = true;
                    break;
                }else if ((dv.dealer__Make__c != null && dv.dealer__Make__c != '' && dv.dealer__Model__c != null && dv.dealer__Model__c != '' 
                            && dv.dealer__Year__c != null && dv.dealer__Year__c != '') && dvl.dealer__Make__c == dv.dealer__Make__c 
                            && dvl.dealer__Model__c == dv.dealer__Model__c && dvl.dealer__Year__c == dv.dealer__Year__c){
                                system.debug('SUP is DUPE --> isBuyInterest--> same make, model, year');
                                isDupe = true;
                                break;
                            }                    
            }
            
            if(!isDupe){
                //Insert Desired Vehicle if not dupe
                dv.dealer__Sales_Up__c = supCheck[0].Id;
                dvList.add(dv);
                // try{
                //     insert dv;
                // }catch(Exception e){
                //     logException(new ADFException(e.getMessage()), 'handleDuplicates');

                // }
            }    
        }//End is buy interest  
        
        isDupe = false;
        
        if(isSaleTradeInterest){
            /*
                ** Removed following appraisal vehicle logic when migrating to salesUp class creation.
            */
            // //if Trade-VIN not set in SUP, set the new VIN
            // if((supCheck[0].dealer__Trade_VIN__c == null || supCheck[0].dealer__Trade_VIN__c == '') &&
            //     (av.dealer__VIN__c != null && av.dealer__VIN__c != '')){ 
            //     supCheck[0].dealer__Trade_VIN__c = av.dealer__VIN__c;
            // }
        
            // for(Appraisal_Vehicle__c avl: supCheck[0].Appraisal_Vehicles__r){
                
            //     if((av.dealer__VIN__c != null && av.dealer__VIN__c != '') && avl.dealer__VIN__c == av.dealer__VIN__c){
            //         system.debug('SUP is DUPE --> isSaleTradeInterest --> VINisDupe');
            //         isDupe = true;
            //         break;
            //     }else if ((av.dealer__Make__c != null && av.dealer__Make__c != '' && av.dealer__Model__c != null && av.dealer__Model__c != '' 
            //                 && av.dealer__Year__c != null && av.dealer__Year__c != '') && avl.dealer__Make__c == av.dealer__Make__c 
            //                 && avl.dealer__Model__c == av.dealer__Model__c && avl.dealer__Year__c == av.dealer__Year__c){
            //                     system.debug('SUP is DUPE --> isSaleTradeInterest --> MAKE,MODEL,YEAR is dupe');
            //                     isDupe = true;
            //                     break;
            //                 }                    
            // }
            
            // if(!isDupe){
            //     av.dealer__Sales_Up__c = supCheck[0].Id;

            //         try{
            //         insert av;
            //     }catch(Exception e){
            //         logException(new ADFException(e.getMessage()), 'handleDuplicates');

            //     }
            // }              
        }
        
        String dupeLeadDescription =  '== Vehicle ==' + '\n';
        if(isBuyInterest){
            if(dv.dealer__Interior_Color__c == null){ dv.dealer__Interior_Color__c = ''; }
            if(dv.dealer__Exterior_Color__c == null){ dv.dealer__Exterior_Color__c = ''; }
            dupeLeadDescription += 'VIN: ' + dv.dealer__VIN__c  +'\n' + 'Make: ' + dv.dealer__Make__c +'\n' + 'Model: ' + dv.dealer__Model__c  +'\n' + 'Year: ' + dv.dealer__Year__c  +'\n' + 'Exterior color: ' + dv.dealer__Exterior_Color__c +'\n' + 'Interior color: ' + dv.dealer__Interior_Color__c +'\n\n' ; 
        }else if(isSaleTradeInterest){
            if(av.dealer__Interior_Color__c == null){ av.dealer__Interior_Color__c = ''; }
            dupeLeadDescription += 'VIN: ' +  av.dealer__VIN__c +'\n' + 'Make: ' + av.dealer__Make__c  +'\n' + 'Model: ' + av.dealer__Model__c +'\n' + 'Year: ' + av.dealer__Year__c +'\n' + 'Interior color: ' + av.dealer__Interior_Color__c  +'\n\n' ; 
            
        }
        if(finance != null && finance != ''){
            dupeLeadDescription += '== Finance ==' + '\n';
            dupeLeadDescription += 'Method: ' + finance+'\n\n';
        }
        dupeLeadDescription += '== Customer ==' + '\n';
        dupeLeadDescription += 'Contact: ' + customerFirstName + ' ' + customerLastName +'\n';
        if(customerAddressLine1 != null && customerCity != null && customerState != null && customerZip != null){
            dupeLeadDescription += 'Address: ' + customerAddressLine1 + ', ' + customerCity + ', '+ customerState +', '+ customerZip +'\n\n';
        }
        if(providerName != null && providerService != null ){
            dupeLeadDescription += '\n== Provider ==' + '\n';
            dupeLeadDescription += 'Name: ' + providerName + '\n';
            dupeLeadDescription += 'Service: ' + providerService;
        }
        if(isBuyInterest){
            dupeLeadDescription += '\n\nNote:\n1) Values were submitted by the customer.\n2) At the time of submission the vehicle was already attached as a desired vehicle record.';
        } else if(isSaleTradeInterest){
            dupeLeadDescription += '\n\nNote:\n1) Values were submitted by the customer.\n2) At the time of submission the vehicle was already attached as an appraisal vehicle record.';
        }


        // Add Activity to Existing Sales Up noting duplicate value.
        // Create Task recording event
        Task dupeLeadT = new Task( Subject='Duplicate Internet Lead Submitted by Customer',
                                Type = 'Email',
                                ActivityDate=Date.today(),
                                WhatId=supCheck[0].Id,
                                WhoId=supCheck[0].dealer__Buyer_Contact__c, 
                                Description= dupeLeadDescription,
                                Status='Completed');

        taskList.add(dupeLeadT); 

        Task xmlActivity = new Task(Subject='ADF message processed.',
                                Type = 'Email',
                                ActivityDate=Date.today(),
                                WhatId=supCheck[0].Id,
                                WhoId=supCheck[0].Buyer_Contact__c,
                                Description = readableXML,
                                Status='Completed');
            
        taskList.add(xmlActivity);

        SalesUp supInstance = new SalesUp();
        SalesUp.SalesUpWrapper salesUp = new SalesUp.SalesUpWrapper(buyerAccount, buyerContact, taskList, dvList, trafficLogList, up, true);

        salesUp.salesUp = supInstance.create(salesUp);

        up = salesUp.salesUp;
        // try{
        //     update supCheck;
        //     insert tasksToInsert;
        // }catch(Exception e){
        //     logException(new ADFException(e.getMessage()), 'handleDuplicates');

        // }
        
        //W-000448 begin           
        List<User> listUser = [select id,Email from User where Id = :salesUp.salesUp.OwnerId];

        // Alert the Record Owner
        if(salesUp.salesUp.OwnerId!=null && listUser!=null && listUser.size()>0) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                
            //String emailAddr = [select Email from User where Id = :supCheck[0].OwnerId].Email;
            //String[] toAddresses = new String[] {emailAddr};   
            String[] toAddresses = new String[] {listUser[0].Email};   
            //W-000448 end             
            mail.setToAddresses(toAddresses);
            mail.setSubject('Your customer submitted a duplicate lead : ' + salesUp.salesUp.Name);
            mail.setHtmlBody(salesUp.salesUp.Name + ' just sent in a new internet lead request to the dealership. <br /> You can access the record <a href="https://login.salesforce.com/'+salesUp.salesUp.Id+'">Here</a>');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }

        // Issue a Chatter Post
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

        mentionSegmentInput.id = salesUp.salesUp.OwnerId;
        messageBodyInput.messageSegments.add(mentionSegmentInput);

        textSegmentInput.text = ' possible Duplicate Internet Lead. ';
        messageBodyInput.messageSegments.add(textSegmentInput);

        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
        feedItemInput.subjectId = salesUp.salesUp.Id;

        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput);
    }

    /**
    * handleNew creates new records if the lead does not exist
    */
    private void handleNew()
    {
        // if(customerFirstName != '' && customerLastName != '') {
        //     if(!Utility.personsAccountsEnabled()) {                 
                
        //         //Update sales up Buyer Contact
        //         if(buyerContact.id==null){
        //             insert buyerContact;
        //         }
        //         up.dealer__Buyer_Contact__c = buyerContact.Id;
        //     } else {
                
        //         //Update salesup customer account & buyer contact
        //         if(buyerAccount.id==null){
        //             insert buyerAccount;
        //             Contact associatedContact = [Select Id from Contact where AccountId=:buyerAccount.Id limit 1];
        //             up.dealer__Customer_Account__c  =   buyerAccount.Id;
        //             up.dealer__Buyer_Contact__c     =   associatedContact.Id;
        //         }       
        //         else{
        //             up.dealer__Customer_Account__c  =   buyerAccount.Id;
        //             up.dealer__Buyer_Contact__c     =   buyerAccount.PersonContactId;
        //         }                   
        //     }
        // }

        if(isBuyInterest && standardSalesUp!=null){
            up.recordTypeId = standardSalesUp;
        }

        // - To update SalesUp owner based on location Salesup queue
        if(! String.isBlank(objStoreLocation.dealer__SalesUp_Queue__c))
        {
            List<Group> ListGroup = new List<Group>();
            ListGroup = [select Id, name from Group where Type = 'Queue' and name =:objStoreLocation.dealer__SalesUp_Queue__c];
            system.debug('ListGroup >>' +ListGroup);
            if(ListGroup.size() > 0)
            {
                up.ownerid = ListGroup[0].id;
            }
        }
        //Set values here to prevent SalesUp trigger to fail for Queue owner records
        if(objStoreLocation.id != null){  up.dealer__Store_Location__c =  objStoreLocation.id; }
        if(objStoreLocation.dealer__Company_Number__c != null && objStoreLocation.dealer__Company_Number__c != '') { up.dealer__Company_Number__c = objStoreLocation.dealer__Company_Number__c; }

        // insert(up);
        
        // if(isBuyInterest){
        //     dv.dealer__Sales_Up__c = up.Id;
                
        // }else{
        //     av.dealer__Sales_Up__c = up.Id;
    
        // }
        
        // Update Traffic Log with Sales Lead Data 
        // Link traffic log to new sup
        // trafficLog.dealer__Sales_Lead__c=up.Id;

        Task xmlActivity = new Task(Subject='ADF message processed.',
                                Type = 'Email',
                                ActivityDate=Date.today(),
                                WhatId=up.Id,
                                WhoId=up.Buyer_Contact__c,
                                Description = readableXML,
                                Status='Completed');
        // insert xmlActivity;

        // List<Desired_Vehicle__c> vehicles = new List<Desired_Vehicle__c>{dv};
        taskList.add(xmlActivity);

        SalesUp supInstance = new SalesUp();
        SalesUp.SalesUpWrapper salesUp = new SalesUp.SalesUpWrapper(buyerAccount, buyerContact, taskList, dvList, trafficLogList, up, true);

        
        up = supInstance.create(salesUp);

        
    }

    /**
    * assignInventoryRecord 
    * @return dealer__Vehicle_Inventory__c
    * @description Assigns Inventory record to Sales Up
    */
    public dealer__Vehicle_Inventory__c assignInventoryRecord() 
    {
        
        dealer__Vehicle_Inventory__c[] inv = [Select Id, dealer__Stock_Number__c 
                                            from dealer__Vehicle_Inventory__c 
                                            where dealer__Stock_Number__c = :this.stockNumber
                                            limit 1];

        if(inv.size() == 1) {
            return inv[0];
        } else {
            return new dealer__Vehicle_Inventory__c();
        }                                    
    }

    /**
    * assignContact 
    * @return Contact
    * @description Looks for Contact to assign and if found, updates it. If no contact is found, a new contact is created.
    */
    public Contact assignContact() 
    {
        // Specify required fields
        if(customerFirstName != '' && customerLastName != '' && customerFirstName != null && customerLastName != null) {
            Contact[] c = [Select Id, FirstName, LastName, Email, MailingStreet, MailingCity, MailingState, 
                                    MailingPostalCode, Phone, MobilePhone
                                from Contact 
                                where  LastName like :customerLastName
                                and ( Email like :customerEmail 
                                      or MobilePhone like: customerCellPhone
                                      or Phone like: customerDayPhone
                                      or FirstName like :customerFirstName )
                                limit 5000]; 
                                
                                

            for(Contact contact : c) {
                System.debug('How many contacts?');

                // Look for the proper assignment
                if( (contact.LastName == customerLastName && contact.FirstName == customerFirstName ) &&
                    (
                        (contact.Email == customerEmail && contact.Email != null)||
                        (contact.MailingStreet == customerAddressLine1 && contact.MailingStreet != null) || 
                        (contact.Phone == customerDayPhone && contact.Phone != null)|| 
                        (contact.MobilePhone == customerCellPhone && contact.MobilePhone != null)
                    )) {
                        if(contact.Email != customerEmail && customerEmail != '' ) {
                            contact.Email = customerEmail;
                        }
                        system.debug(contact.Phone);
                        system.debug(customerDayPhone);

                        if(contact.Phone != customerDayPhone && customerDayPhone != '') { 
                            contact.Phone = customerDayPhone;
                        }
                        if(contact.MobilePhone != customerCellPhone && customerCellPhone != '') {
                            contact.MobilePhone = customerCellPhone;
                        }
                        if(contact.MailingStreet != customerAddressLine1 && customerAddressLine1 != '') {
                            contact.MailingStreet = customerAddressLine1;
                        }
                        if(contact.MailingCity != customerCity && customerCity != '') {
                            contact.MailingCity = customerCity;
                        }
                        if(contact.MailingState != customerState && customerState != '') {
                            contact.MailingState = customerState;
                        }
                        if(contact.MailingPostalCode != customerZip && customerZip != '') {
                            contact.MailingPostalCode = customerZip;
                        }
                        update contact;
                        return contact;
                    }   
            }   
            
            // No customer record found to match
            Contact customer = new Contact(     FirstName=customerFirstName, 
                                                LastName=customerLastName, 
                                                Email=customerEmail,
                                                MailingStreet=customerAddressLine1,
                                                MailingCity=customerCity,
                                                MailingState=customerState,
                                                MailingPostalCode=customerZip,
                                                MobilePhone=customerCellPhone,
                                                HomePhone=customerEveningPhone,
                                                Phone=customerDayPhone
                                            );
            
            return customer;                                
                                
        } else {
            return new Contact();
        }
    }

    /**
    * assignAccount
    * @return Account
    * @description Looks for an Account to assign and if found, updates it. If no account is found, a new account is created.
    */ 
    public Account assignAccount() 
    {
       // Specify required fields
        if(customerFirstName != '' && customerLastName != '' && customerFirstName != null && customerLastName != null) {
            Account[] a = [Select Id, FirstName, LastName, PersonEmail, PersonMailingStreet, PersonMailingCity, PersonMailingState, 
                                    PersonMailingPostalCode, Phone, PersonMobilePhone,PersonContactId 
                                from Account 
                                where  LastName like :customerLastName
                                and ( PersonEmail like :customerEmail 
                                      or PersonMobilePhone like: customerCellPhone
                                      or Phone like: customerDayPhone
                                      or FirstName like :customerFirstName )
                                limit 5000]; 
                                
                                

            for(Account account : a) {
                System.debug('How many Accounts?');

                // Look for the proper assignment
                if( (account.LastName == customerLastName && account.FirstName == customerFirstName ) &&
                    (
                        (account.PersonEmail == customerEmail && account.PersonEmail != null)||
                        (account.PersonMailingStreet == customerAddressLine1 && account.PersonMailingStreet != null) || 
                        (account.Phone == customerDayPhone && account.Phone != null)|| 
                        (account.PersonMobilePhone == customerCellPhone && account.PersonMobilePhone != null)
                    )) {
                        if(account.PersonEmail != customerEmail && customerEmail != '' ) {
                            account.PersonEmail = customerEmail;
                        }
                        if(account.Phone != customerDayPhone && customerDayPhone != '') { 
                            account.Phone = customerDayPhone;
                        }
                        if(account.PersonMobilePhone != customerCellPhone && customerCellPhone != '') {
                            account.PersonMobilePhone = customerCellPhone;
                        }
                        if(account.PersonMailingStreet != customerAddressLine1 && customerAddressLine1 != '') {
                            account.PersonMailingStreet = customerAddressLine1;
                        }
                        if(account.PersonMailingCity != customerCity && customerCity != '') {
                            account.PersonMailingCity = customerCity;
                        }
                        if(account.PersonMailingState != customerState && customerState != '') {
                            account.PersonMailingState = customerState;
                        }
                        if(account.PersonMailingPostalCode != customerZip && customerZip != '') {
                            account.PersonMailingPostalCode = customerZip;
                        }
                        update account;
                        return account;
                    }   
            }   
            
            // No customer record found to match
            Account customer = new Account(     FirstName=customerFirstName, 
                                                LastName=customerLastName, 
                                                PersonEmail=customerEmail,
                                                PersonMailingStreet=customerAddressLine1,
                                                PersonMailingCity=customerCity,
                                                PersonMailingState=customerState,
                                                PersonMailingPostalCode=customerZip,
                                                PersonMobilePhone=customerCellPhone,
                                                PersonHomePhone=customerEveningPhone,
                                                Phone=customerDayPhone
                                            );
            
            return customer;                                
                                
        } else {
            return new Account();
        }        
    }

    /**
    * logException sends exceptions to external logging system
    * @param  e ADFException with message
    * @param  methodName the method where the exception was caught
    */
    public void logException(ADFException e, String methodName)
    {
        VitalApplicationMetrics.telemetryWrapper tel = new VitalApplicationMetrics.telemetryWrapper();
        tel.message = e.getMessage() + 'Org Id: ' + UserInfo.getOrganizationId() + ' Payload: ' + readableXML + ' ' + e.getStackTraceString() ; //Get message and stack trace for log
        tel.application = 'ADFAPI.' + methodName;
        tel.severity = 'critical';
        String exceptionPayload = JSON.serialize(tel);
        VitalApplicationMetrics.logException(exceptionPayload);
    }


    /**
    * ADFException
    * @description
    */
    public class ADFException extends Exception{}

    
}