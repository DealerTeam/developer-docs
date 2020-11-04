/**
 * 		W-001569
 **/
global with sharing class ServiceRepairOrderPrint {
 
	global Service_Repair_Order__c ro {get;set;}
    
	global ServiceRepairOrderPrint(ApexPages.standardController sc) {
		ro = (Service_Repair_Order__c)sc.getRecord();	
	}

	global ServiceRepairOrder getServiceRepairOrder() {
		return new ServiceRepairOrder(ro.Id);
	} 
 
	global class ServiceRepairOrder {
		global String logoUrl {get;set;}
		global Dealer_Location__c location {get;set;}
		global Account customer {get;set;}
		global String printDateTime {get;set;}
		global Service_Repair_Order__c header {get;set;}
        global Dealer_Location__c userLoc {get;set;}
        global Service_Vehicle__c vehicle {get; set;}
        global List<Service_Job__c> serviceJobList{get; set;}
        global List<Parts_Invoice_Line__c> servicePartsList{get; set;}
		global Decimal total_sublet_cust {get; set;}
        global Decimal total_payments {get; set;}

		ServiceRepairOrder(Id sroId) {
			header = ServiceRepairOrderPrint.queryHeader(sroId);
			customer = (header.Customer__c!=null) ? ServiceRepairOrderPrint.queryAccount(header.Customer__c) : new Account();
			vehicle = (header.Vehicle__c!=null) ? ServiceRepairOrderPrint.queryVehicle(header.Vehicle__c) : new Service_Vehicle__c();
			userLoc = ServiceRepairOrderPrint.queryLocation(header.Company__c );
			logoUrl = ServiceRepairOrderPrint.logo_url();
			printDateTime = ServiceRepairOrderPrint.formattedDateTime();
			total_sublet_cust = ServiceRepairOrderPrint.totalSublet(sroId);
            total_payments = ServiceRepairOrderPrint.totalPayments(sroId);
                
			// Generate the Lines
			serviceJobList = ServiceRepairOrderPrint.queryLines(sroId);
            
            //Get Parts Lines
            servicePartsList= ServiceRepairOrderPrint.queryParts(sroId);		
		}
	}

	private static Service_Repair_Order__c queryHeader(Id sroId) {

        DescribeSObjectResult desRO = Service_Repair_Order__c.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>();
		Set<String> fieldSet = new Set<String>();
		for(String s : desRO.fields.getMap().keySet()) {
			if(!fieldSet.contains(s.remove('dealer__'))) {
				fieldSet.add(s);
			}
		}
		fieldNames.addAll(fieldSet);
        fieldNames.add('dealer__Service_Advisor__r.Name');

        String query =
          ' SELECT ' +
              String.join( fieldNames, ',' ) +
          ' FROM dealer__Service_Repair_Order__c Where Id = \''+ String.escapeSingleQuotes(sroId) +'\'' +
          ' AND IsDeleted = false ' +
          ' LIMIT 1';

        return Database.query( query ); 		
	}

	private static List<Service_Job__c> queryLines(Id sroId) {
		DescribeSObjectResult desLine = Service_Job__c.getSObjectType().getDescribe();
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
			' FROM dealer__Service_Job__c WHERE dealer__Service_Repair_Order__c = \'' + String.escapeSingleQuotes(sroId)+ '\'' +
			' AND IsDeleted = false ' + 
			' LIMIT 200 ';
		
		return Database.query( query );
	}


   	private static Decimal totalSublet(Id sroId) {
     
       AggregateResult[] sumf = [Select SUM(dealer__Sublet_Total__c) line From dealer__Service_Job__c where dealer__Service_Repair_Order__c=:sroId AND dealer__Labor_Type__c = 'C'];
       Decimal t = (Decimal)sumf[0].get('line');
       if(t==null) { t=0; }
       return t.setScale(2);
    }
    
    private static Decimal totalPayments(Id sroId) {
     
       AggregateResult[] sumf = [Select SUM(Amount__c) line 
                    FROM dealer__Cashering__c
                    where dealer__Service_Repair_Order__c = :sroId 
                    and deposit__c = false
                    and dealer__Amount__c != null];
            Decimal t = (Decimal)sumf[0].get('line');
            if(t==null) { t=0; }
            return t.setScale(2);
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

	private static Service_Vehicle__c queryVehicle(Id vehId) {
		return [SELECT Sales_Inventory__c, Sale_Date__c, Open_Repair_Orders__c, Make__c, Make_Code__c, VIN__c, VIN_Not_Present__c, Veh_Owner__c, Veh_Owner_Contact__c, Vehicle_Description__c, 
					Vehicle_Type__c, Year__c, Stock_Number__c, Status_Code__c, Last_8__c, Last_6__c, Int_Color__c, In_Service_Date__c, Equipment_Number__c, Ext_Color__c, Carline__c, 
					Body_Type__c, Body_Style__c, Last_Odometer__c, Last_Activity__c, Licence_State__c, Last_Service__c, Licence__c, Trim_Level__c, Name, Id 
					FROM Service_Vehicle__c
					WHERE Id=:vehId];
	}		
 
	private static Dealer_Location__c queryLocation(Id locId) {
		return [SELECT Id, Name, Company_Contracting_Name__c, Address__c, City__c, State__c, Postal_Code__c,
				Website__c, Main_Phone__c, BAR_Number__c, EPA_Number__c, Tax_ID__c
				FROM Dealer_Location__c
				WHERE Id=:locId]; 		
	} 
    
    private static List<Parts_Invoice_Line__c> queryParts(Id sroId) {
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
			' FROM Parts_Invoice_Line__c WHERE dealer__Service_Repair_Order__c = \'' +sroId+ '\'' +
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
}