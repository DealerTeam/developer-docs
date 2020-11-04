/**
 * TechnicianJobTimeAPI - Service layer encapsulation for adding, updating or deleting technician time against a repair order job line
 *
 */
public with sharing class TechnicianJobTimeAPI {

	/**
	 * addTechTime
	 * @param tts List<Technician_Job_Time__c>
	 * @return  void
	 * @notes add tech time to the associated job lines.  
	 */
	public static void addTechTime(List<Technician_Job_Time__c> tts) {

		List<Technician_Job_Time__c> tInsert = new List<Technician_Job_Time__c>();
		for(Technician_Job_Time__c t : tts) {
			// Perform Service layer calculations
			if(t.Labor_Cost__c==null) { t.Labor_Cost__c=0;}
			if(t.Labor_Total__c==null) { t.Labor_Total__c=0; }

			tInsert.add(t);
		}

		try {
			insert tInsert;
			System.debug(tInsert);
		} Catch(DmlException e) {
			throw new TechnicianJobTimeAPIException('addTechTime failed to insert technician job time entries : '+e.getMessage());
		} Catch(Exception e) {
			throw new TechnicianJobTimeAPIException('addTechTime failed to insert technician job time entries : '+e.getMessage());
		}
	}

	public class TechnicianJobTimeAPIException extends Exception {}
}