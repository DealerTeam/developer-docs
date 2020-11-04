/*
ServiceEstimatePrint - Print Class
*/
global with sharing class ServiceEstimatePrint
{
	global Service_Estimate__c estimateRecord {get;set;}
	global ServiceEstimatePrint(ApexPages.standardController sc) {
		estimateRecord = (Service_Estimate__c)sc.getRecord();	
	}

	global estimate getEstimate() {
		return generateDocument();
	}  

	global estimate generateDocument() {
		return new estimate(estimateRecord.Id);
	}

	global class estimate {
		global String logoUrl {get;set;}
		global Dealer_Location__c location {get;set;}
		global Account customer {get;set;}
		global Service_Vehicle__c vehicle {get;set;}
		global DateTime printDateTime {get;set;}
		global Service_Estimate__c header {get;set;}
		global List<line> lines {get;set;}

		estimate(Id estimateId) {
			header = ServiceEstimatePrint.queryHeader(estimateId);
			customer = (header.Customer__c!=null) ? ServiceEstimatePrint.queryAccount(header.Customer__c) : new Account();
			vehicle = (header.Service_Vehicle__c!=null) ? ServiceEstimatePrint.queryVehicle(header.Service_Vehicle__c) : new Service_Vehicle__c();
			location = ServiceEstimatePrint.queryLocation(header.Store_Location__c);
			logoUrl = ServiceEstimatePrint.logo_url(header.Store_Location__c);
			printDateTime = DateTime.now();

			// Generate the Lines
			List<Service_Estimate_Line__c> lineRecords = ServiceEstimatePrint.queryLines(header.Id);
			Set<Id> lineIds = new Set<Id>();
			for(Service_Estimate_Line__c sel : lineRecords) {
				if(!lineIds.contains(sel.Id)) {
					lineIds.add(sel.Id);
				}
			}
			List<Service_Estimate_SubLine__c> subLines = ServiceEstimatePrint.querySubLines(lineIds);

			// Iterate the lines and create the object list
			List<line> lineList = new List<line>();
			for(Service_Estimate_Line__c sel : lineRecords) {
				lineList.add(new line(sel, subLines));
			}

			lines = lineList;

			System.debug(lines);
		}
	}

	global class line {
		global Service_Estimate_Line__c data {get;set;}
		global List<Service_Estimate_SubLine__c> subdata {get;set;}

		line(Service_Estimate_Line__c sl, List<Service_Estimate_SubLine__c> allSubLines) {
			data = sl;
			subdata = new List<Service_Estimate_SubLine__c>();

			for(Service_Estimate_SubLine__c sul : allSubLines) {

				System.debug(sl.Id);
				System.debug(sul.Service_Estimate_Line__c);

				if(sl.Id == sul.Service_Estimate_Line__c) {
					subdata.add(sul);
				}
			}

			System.debug(subdata);

		}
	}

	private static Service_Estimate__c queryHeader(Id estId) {

        DescribeSObjectResult desRO = Service_Estimate__c.getSObjectType().getDescribe();
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
          ' FROM dealer__Service_Estimate__c Where Id = \''+ String.escapeSingleQuotes(estId) +'\'' +
          ' AND IsDeleted = false ' +
          ' LIMIT 1';

        return Database.query( query ); 		
	}

	private static List<Service_Estimate_Line__c> queryLines(Id estId) {
		DescribeSObjectResult desLine = Service_Estimate_Line__c.getSObjectType().getDescribe();
		List<String> fieldNames = new List<String>();
        Set<String> fieldSet = new Set<String>();
		for(String s : desLine.fields.getMap().keySet()) {
			if(!fieldSet.contains(s.remove('dealer__'))) {
				fieldSet.add(s);
			}
		}
		fieldNames.addAll(fieldSet);
		fieldNames.add('Labor_Operation__r.Name');

		String query = 
			' SELECT ' +
				String.join( fieldNames, ',' ) +
			' FROM Service_Estimate_Line__c WHERE dealer__Service_Estimate__c = \'' +estId+ '\'' +
			' AND IsDeleted = false ' + 
			' LIMIT 200 ';
		
		return Database.query( query );
	}

	private static List<Service_Estimate_SubLine__c> querySubLines(Set<Id> lineIds) {
		return [SELECT Service_Estimate_Line__c, Parts_Master__c, Line_Type__c, Labor_Rate__c, 
						Book_Time__c, Part_Quantity__c, Part_Price__c, Total_Part_Price__c, 
						Part_Description__c, Part_Name__c, Part_Price_List__c, Part_Cost__c, 
						Labor_Total__c, Labor_Type__c, Misc_Charge_Code__c, Misc_Charge_Amount__c, 
						Misc_Charge_Description__c, SystemCreatedMiscCharge__c, SystemGeneratedFor__c, 
						CreatedById, CreatedDate, Name, Id, LastModifiedById, LastModifiedDate 
					FROM Service_Estimate_SubLine__c
					WHERE Service_Estimate_Line__c IN:lineIds];
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
		return [SELECT BAR_Number__c, City__c, Company_Number__c, EPA_Number__c, Email__c, General_Manager__c, Internal_Labor_Rate__c, Main_Phone__c, Open_Hour__c, Service_Director__c, 
					Service_Invoice_Disclaimer__c, Service_RO_Disclaimer__c, State__c, Postal_Code__c,
					Tax_ID__c, Tax_Local_Rate__c, Tax_Parts__c, Tax_Service__c, Website__c, Location_Account__c, BDC_Director__c,
						Company_Contracting_Name__c,
						Location_Account__r.Name,
						BDC_Director__r.Name,
						Service_Director__r.Name,
						General_Manager__r.Name,
					Street__c, Name, Id,
					Service_Estimate_Disclaimer__c 
					FROM Dealer_Location__c
					WHERE Id=:locId]; 		
	} 


	private static String logo_url(Id locationId) {
		if(locationId==null) {
			return '';
		}
		return DealershipLocationAPI.formLogoURL(locationId);
	}

 
}