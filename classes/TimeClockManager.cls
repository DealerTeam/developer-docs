public with sharing class TimeClockManager {

	public String day {get;set;}
	public String u {get;set;}
	public Time_Clock__c tc {get;set;}
	public Time_Clock_Line__c tcl {get;set;}
	public String tclId {get;set;}

	public List<Time_Clock_Line__c> timeEntries = new List<Time_Clock_Line__c>();

	public TimeClockManager( ) {

		if( day == null ) {
			day = System.today().format();
		}
	}

	public PageReference lookupTime(){
		
		if ( !dealer.Utility.isBlank(u) && !dealer.Utility.isBlank(day)) {

			// Setup date to search by
			Date sDate = Date.parse(day);

			List<Time_Clock__c> clocks = [SELECT ID, Name, (SELECT In__c, Out__c,Type__c, Time_Worked__c, Time_Clock__c, LastModifiedBy.Name, LastModifiedDate FROM Time_Clock_Lines__r WHERE Void__c != true ORDER BY In__c ASC) 
            FROM Time_Clock__c 
            WHERE 
            	User__c =:u 
            	AND DAY_ONLY(convertTimezone(CreatedDate)) =: sDate
            ORDER BY CreatedDate DESC LIMIT 100];

			if(clocks.size()>0){
				tc = clocks[0];
				System.debug(tc);

			}

		} else {
			System.debug('Show Error...');
	        ApexPages.Message noResults = new ApexPages.Message(ApexPages.Severity.INFO, 'User and Date Are Required');
	        ApexPages.addMessage(noResults);	

		}

        return null;
	}

	public PageReference selectLine(){
		System.debug(tclId);
		
		if(tclId != null) {
			tcl = [SELECT Id, Name, In__c, Out__c, Type__c, Time_Clock__c, Time_Worked__c , Note__c, LastModifiedBy.Name, LastModifiedDate  FROM Time_Clock_Line__c WHERE Id = : tclId LIMIT 1];
		}
		System.debug(tcl);
		return null;
	}

	/**
	 * Update the previosuly Selected line. Theis method actually sets the 
	 * @return [description]
	 */
	public PageReference updateLine(){

		// Do we have a line to edit?
		if( tcl != null ){

			System.debug('*** The Line were editing: ');
			System.debug(tcl);

			//A Note Must be added
			if( !dealer.Utility.isBlank(tcl.Note__c) ) {

				// Create Clone
				Time_Clock_Line__c newLine = new Time_Clock_Line__c(
					In__c = tcl.In__c,
					Out__c = tcl.Out__c,
					Type__c = tcl.Type__c,
					Time_Clock__c = tcl.Time_Clock__c
				);

				insert newLine;

				// Edit overridden record
				List<Time_Clock_Line__c> oldLines = [SELECT Id, Name, In__c, Out__c, Type__c, Time_Clock__c, Void__c, Note__c, LastModifiedBy.Name, LastModifiedDate
		            FROM Time_Clock_Line__c 
		            WHERE Id =: tcl.Id LIMIT 1];

				if(oldLines.size()>0){
					Time_Clock_Line__c oldLine = oldLines[0];

					oldLine.Void__c = true;
					oldLine.Note__c = tcl.Note__c + ' - Overridden by:' + newLine.Id;

					update oldLine;

			        ApexPages.Message noteRequired = new ApexPages.Message(ApexPages.Severity.INFO, 'Entry Update Completed.');
			        ApexPages.addMessage(noteRequired);	

				}

			} else {
		        ApexPages.Message noteRequired = new ApexPages.Message(ApexPages.Severity.ERROR, 'You Must Enter a Note to update a Time Entry.');
		        ApexPages.addMessage(noteRequired);	

                return null;			
            }
		}

		tclId = null;
		tcl = null;

		return null;
	}

	public List<Time_Clock_Line__c> gettimeEntries() {
		if( tc != null ) {
			timeEntries = [SELECT Id, In__c, Out__c,Type__c, Void__c, Time_Worked__c, Note__c, Time_Clock__c, LastModifiedBy.Name, LastModifiedDate  
				FROM Time_Clock_Line__c 
				WHERE Time_Clock__c =: tc.Id 
					//AND Void__c != true 
				ORDER BY In__c ASC LIMIT 100];
		}
		return timeEntries;
	}

	public class TCException extends Exception{}

}