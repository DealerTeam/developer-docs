/**
 * 		W-001569
 * @test PartInvoicingServiceLayer.testPartsInvoicePrint
 **/
global with sharing class PartsInvoicePrint {
 
	global Parts_Invoice__c pi {get;set;}
    private static Integer FIRST_BREAK = 70;
    private static Integer SUBSEQ_BREAKS = 120;
    
	global PartsInvoicePrint(ApexPages.standardController sc) {
		pi = (Parts_Invoice__c)sc.getRecord();	
	}

	global PartsInvoice getPartsInvoice() {
		return new PartsInvoice(pi.Id);
	} 
 
	global class PartsInvoice {
		global String logoUrl {get;set;}
		global Dealer_Location__c location {get;set;}
		global Account customer {get;set;}
		global String printDateTime {get;set;}
		global Parts_Invoice__c header {get;set;}
        global Dealer_Location__c userLoc {get;set;} 
        global List<Parts_Invoice_Line__c[]> pageBrokenInvoiceLines {get; set;}
        global List<Cashering__c> casheringList {get; set;} 
        global DMS_Settings__c DMSDefaults {get; set;}
        global User counterman {get; set;}
 
		PartsInvoice(Id piId) {
			header = PartsInvoicePrint.queryHeader(piId);
			customer = (header.Customer__c!=null) ? PartsInvoicePrint.queryAccount(header.Customer__c) : new Account();
			userLoc = (header.Location__c !=null)? PartsInvoicePrint.queryLocation(header.Location__c ) : null;
			counterman = (header.Counterman__c !=null)? PartsInvoicePrint.queryUser(header.Counterman__c ) : new User();
            logoUrl = PartsInvoicePrint.logo_url();
			printDateTime = PartsInvoicePrint.formattedDateTime();
            pageBrokenInvoiceLines = PartsInvoicePrint.prepareInvoiceLinesForPrinting(piId);
			casheringList = PartsInvoicePrint.queryCashering(piId);
            DMSDefaults = dealer__DMS_Settings__c.getValues('ActiveSettings');
		
		}
	}

	private static Parts_Invoice__c queryHeader(Id piId) {

        DescribeSObjectResult desPI = Parts_Invoice__c.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>();
		Set<String> fieldSet = new Set<String>();
		for(String s : desPI.fields.getMap().keySet()) {
			if(!fieldSet.contains(s.remove('dealer__'))) {
				fieldSet.add(s);
			}
		}
		fieldNames.addAll(fieldSet);
        //fieldNames.add('dealer__Service_Advisor__r.Name');

        String query =
          ' SELECT ' +
              String.join( fieldNames, ',' ) +
          ' FROM dealer__Parts_Invoice__c Where Id = \''+ String.escapeSingleQuotes(piId) +'\'' +
          ' AND IsDeleted = false ' +
          ' LIMIT 1';

        return Database.query( query ); 		
	}
    
    private static List<dealer__Cashering__c> queryCashering(Id piId){
        
        return [SELECT ID, Payment_Method__c, Amount__c
                FROM dealer__Cashering__c
                WHERE Parts_Invoice__c =: piId LIMIT 1];
    }

	private static List<dealer__Parts_Invoice_Line__c> queryLines(Id piId) {
		DescribeSObjectResult piLine = Parts_Invoice_Line__c.getSObjectType().getDescribe();
		List<String> fieldNames = new List<String>();
        Set<String> fieldSet = new Set<String>();
		for(String s : piLine.fields.getMap().keySet()) {
			if(!fieldSet.contains(s.remove('dealer__'))) {
				fieldSet.add(s);
			}
		}
		fieldNames.addAll(fieldSet);

		String query = 
			' SELECT ' +
				String.join( fieldNames, ',' ) +
			' FROM dealer__Parts_Invoice_Line__c WHERE dealer__Parts_Invoice__c = \'' + String.escapeSingleQuotes(piId)+ '\'' +
			' AND IsDeleted = false ' + 
			' LIMIT 200 ';
		
		return Database.query( query );
	}

	private static Account queryAccount(Id acctId) {
		// Static field selection
		return [SELECT Id, Name, LastName, FirstName, RecordTypeId, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, 
					BillingCountry, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, 
					Phone, Fax, AccountNumber, IsPersonAccount, PersonContactId, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, 
					PersonOtherStreet, PersonOtherState, PersonOtherCity, PersonOtherPostalCode, PersonOtherCountry, PersonMobilePhone, PersonHomePhone, PersonOtherPhone, PersonEmail, 
					PersonTitle, PersonBirthdate, Fleet_Customer__c 
					FROM Account
					WHERE Id=:acctId];
	}
    
    private static User queryUser(Id userId) {
		return [SELECT Id, Name
					FROM User 
					WHERE Id=:userId];
	}

 
	private static Dealer_Location__c queryLocation(Id locId) {
		return [SELECT Id, Name, Company_Contracting_Name__c, Address__c, City__c, State__c, Postal_Code__c,
				Website__c, Main_Phone__c, BAR_Number__c, EPA_Number__c, Tax_ID__c
				FROM Dealer_Location__c
				WHERE Id=:locId]; 		
	} 

    
    private static List<Parts_Invoice_Line__c> queryParts(Id piId) {
		DescribeSObjectResult desLine = Parts_Invoice_Line__c.getSObjectType().getDescribe();
		List<String> fieldNames = new List<String>();
        Set<String> fieldSet = new Set<String>();
		for(String s : desLine.fields.getMap().keySet()) {
			if(!fieldSet.contains(s.remove('dealer__'))) {
				fieldSet.add(s);
			}
		}
		fieldNames.addAll(fieldSet);

		String query = 
			' SELECT ' +
				String.join( fieldNames, ',' ) +
			' FROM Parts_Invoice_Line__c WHERE dealer__Service_Repair_Order__c = \'' +piId+ '\'' +
			' AND IsDeleted = false ' + 
			' LIMIT 200 ';
		
		return Database.query( query );
	}

    
	private static String logo_url() {
        Document[] doc = [Select Id from Document Where DeveloperName = 'InvoiceLogo' limit 1];
		if(doc.size()!=0) {
        	String imageId = doc[0].Id;
        	imageId = imageId.substring(0,15);
        	return 'servlet/servlet.FileDownload?file='+imageId;		
		}
		return '';
	}
    
    private static String formattedDateTime() { 
    
        datetime dt = datetime.now();
        return dt.format('MM/dd/yyyy HH:mm a');
    }  
    
    private static List<dealer__Parts_Invoice_Line__c[]> prepareInvoiceLinesForPrinting(Id piId){
        
        List<dealer__Parts_Invoice_Line__c[]> pageBrokenInvoiceLinesAux = new List<dealer__Parts_Invoice_Line__c[]>();
        
        dealer__Parts_Invoice_Line__c[] pageOfLines = new dealer__Parts_Invoice_Line__c[]{};
        
        Integer counter = 0;
        boolean firstBreakFound = false;
		List<Parts_Invoice_Line__c> invoiceLineItems = queryLines(piId);      

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
                    pageBrokenInvoiceLinesAux.add(pageOfLines);
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
                    pageBrokenInvoiceLinesAux.add(pageOfLines);
                    pageOfLines = new dealer__Parts_Invoice_Line__c[]{};
                }   
            }
        }
        //if we have finished looping and have some quotes left lets assign them
        if(!pageOfLines.isEmpty()){
            pageBrokenInvoiceLinesAux.add(pageOfLines); 
        }
        
        return pageBrokenInvoiceLinesAux;
    }  
}