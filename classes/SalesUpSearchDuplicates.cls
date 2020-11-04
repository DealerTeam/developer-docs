public with sharing class SalesUpSearchDuplicates {
	
	public dealer__Sales_Up__c thisUp;
	
	public SalesUpSearchDuplicates() {
		if(ApexPages.currentPage().getParameters().get('id')!=null) {
			thisUp	=	lookUp(ApexPages.currentPage().getParameters().get('id'));
			system.debug(thisUp);
			system.debug(thisUp.dealer__FirstName__c);
		}
	}

	public class searchUps {
		
		public boolean inFirstName {get;set;}
		public boolean inLastName {get;set;}
		public boolean inEmail {get;set;}
		public boolean inPhone {get;set;}
		public boolean inMobile {get;set;}
		public String firstName {get;set;}
		public String lastName {get;set;}
		public String upEmail {get;set;}
		public String upPhone {get;set;}
		public String upMobile {get;set;}
		
		public searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, string firstn, string lastn, string uemail) {
			inFirstName = 	inFirst;
			inLastName  =	inLast;
			inEmail		=	inEmailAddr;
			inPhone		=	inPhoneNum;
			inMobile	=	inMobileNum;
			
			firstName 	=	firstn.trim();
			lastName	=	lastn.trim();
			
			upEmail		=	uEmail.trim();
		}
	}
	
	public searchUps searchOptions {
			get {
				return new searchUps(true, true, true, true, true, '', '', '');
			} 
			set;
	}
	
	public dealer__Sales_Up__c lookUp(String upID) {
		return [Select Id, dealer__LastName__c, dealer__FirstName__c, dealer__Mobile__c, dealer__Email__c, dealer__Phone__c from dealer__Sales_Up__c where Id = :upID];
	}
	
	public PageReference cancel() {
		return null;
	}
	
}