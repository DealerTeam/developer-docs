/**
 * DeskLog Service Layer Encapsulation
 *
 */ 
public class DeskLogService{
	
	/**
	 * search
	 * @param  s SearchContext of variables
	 * @return List<DeskLogEntry>
	 * @notes performs the search and return of desk log entries
	 */
	public static List<DeskLogEntry> search(searchContext s) {

		Boolean isSosl = false;
		Boolean isSoql = false;

		Date fdate;
		Date tdate;

		// Extract Hard Filter Items
		if(!String.isEmpty(s.rawSearch)) {
			isSosl = true;
		}

		if(s.fromDate != null && s.toDate != null) {
			isSoql = true;
			fdate = s.fromDate;
			tdate = s.toDate;
		}

		// -------- SOFT FILTERS --------- //
		String sp1Filter = '';
		List<String> s1;
		if(s.salesperson1 != null && !s.salesperson1.isEmpty()) {	
			s1=s.salesperson1;
			sp1Filter = ' and dealer__Salesperson_1__c IN:s1 ';
		}

		String sp2Filter = '';
		List<String> s2;
		if(s.salesperson2 != null && !s.salesperson2.isEmpty()) {
			s2=s.salesperson2;
			sp2Filter = ' and dealer__Salesperson_2__c IN:s2 ';
		}

		String deskManagerFilter = '';
		List<String> dm;
		if(s.deskmanager != null && !s.deskmanager.isEmpty()) {
			dm=s.deskmanager;
			deskManagerFilter = ' and dealer__Salesperson_2__c IN:dm ';
		}	

		String finaceManagerFilter = '';
		List<String> fm;
		if(s.financeManager != null && !s.financeManager.isEmpty()) {
			fm=s.financeManager;
			finaceManagerFilter = ' and dealer__Salesperson_2__c IN:fm ';
		}

		String locationFilter = '';
		List<String> lf;
		if(s.location != null && !s.location.isEmpty()) {
			lf=s.location;
			locationFilter = ' and dealer__Store_Location__c IN:lf ';
		}			

		String leadTypeFilter = '';
		List<String> lt;
		if(s.leadType != null && !s.leadType.isEmpty()) {
			lt=s.leadType;
			leadTypeFilter = ' and dealer__Lead_Type__c IN:lt ';
		}

		// Craft SOSL

		// Craft SOQL
		String salesupFields = 'Id, Name, CreatedDate, LastModifiedDate, OwnerId, dealer__Salesperson_1__c, dealer__Salesperson_2__c, dealer__F_I_Manager__c, dealer__Desk_Manager__c, dealer__Lead_Date__c, dealer__Lead_Type__c, dealer__Source__c';

		String dealFields = 'Id, Name, dealer__Deal_Date__c, dealer__Status__c, dealer__Vehicle_Price__c, dealer__Vehicle_Gross__c, dealer__Stock_Number__c, dealer__Vehicle__c, dealer__Total_Gross__c, dealer__Vehicle__r.Name';

		String apptFields = 'Id, Name, dealer__Appointment_Type__c, dealer__Appointment_Result__c, dealer__Assigned_To__c, dealer__Confirmed__c, dealer__DateTime__c, dealer__Notes__c, dealer__Vehicle__c, dealer__VIP__c, dealer__Set_By__c ';

		String vehicleFields = 'Id, Name, dealer__MakeModelYearTrim__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Trim_Level__c, dealer__New_Used_Other__c ';

		String appraisalFields = 'Id, Name';

		String upSql = 'SELECT  '+String.escapeSingleQuotes(salesupFields);
												/* Deals */
		upSql += ' ,(SELECT '+String.escapeSingleQuotes(dealFields)+' FROM R00N70000002J0AVEA0__r)';
												/* Appointments */
		upSql += ' ,(SELECT '+String.escapeSingleQuotes(apptFields)+' FROM Sales_Appointments__r) ';
												/* Desired Vehicle */
		upSql += ' ,(SELECT '+String.escapeSingleQuotes(vehicleFields)+ ' FROM Desired_Vehicles__r) ';
												/* Appraisals */
		upSql += ' ,(SELECT '+String.escapeSingleQuotes(appraisalFields)+' FROM Appraisals__r) ';
		
		upSql += ' FROM dealer__Sales_Up__c ';
		
		upSql += ' WHERE ((CreatedDate >=:fdate and CreatedDate <=:tdate)';
		upSql += ' OR (dealer__Lead_Date__c >=:fdate and dealer__Lead_Date__c <=:tdate)) ';
		
		// Soft Fitlers
		upSql += sp1Filter;
		upSql += sp2Filter;
		upSql += deskManagerFilter;
		upSql += finaceManagerFilter;
		upSql += leadTypeFilter;

		upSql += ' LIMIT 100';

		System.debug(upSql);

		List<dealer__Sales_Up__c> ups = Database.query(upSql);											

		// Pre-Flight get relevant ID's for associated query
		Set<Id> knownSalesUserIds = new Set<Id>();
		for(Sales_Up__c sup : ups) {
			
			if(sup.Salesperson_1__c!=null && !knownSalesUserIds.contains(sup.Salesperson_1__c)) {
				knownSalesUserIds.add(sup.Salesperson_1__c);
			}

			if(sup.Salesperson_2__c!=null && !knownSalesUserIds.contains(sup.Salesperson_2__c)) {
				knownSalesUserIds.add(sup.Salesperson_2__c);
			}		

			if(sup.Desk_Manager__c!=null && !knownSalesUserIds.contains(sup.Desk_Manager__c)) {
				knownSalesUserIds.add(sup.Desk_Manager__c);
			}	

			if(sup.F_I_Manager__c!=null && !knownSalesUserIds.contains(sup.F_I_Manager__c)) {
				knownSalesUserIds.add(sup.F_I_Manager__c);
			}
		}
		Map<Id, User> referencedUsers = SalesUpService.getSalesUpUsers(knownSalesUserIds);

		// Iterate Results and apply to the model
		List<DeskLogEntry> entries = new List<DeskLogEntry>();

		for(Sales_Up__c sup : ups) {

			DeskLogEntry entry = new DeskLogEntry();

			entry.salesup 		= 	sup;
			entry.deals 		= 	sup.R00N70000002J0AVEA0__r;
			entry.appointments 	= 	sup.Sales_Appointments__r;
			entry.desiredVehicles=	sup.Desired_Vehicles__r;
			entry.appraisals    = 	sup.Appraisals__r;

			// Get Primary Values, some of these may be re-worked to use more meaningful logic.
			if(!entry.deals.isEmpty()) { entry.primaryDeal = entry.deals[0]; }	
			if(!entry.appointments.isEmpty()) { entry.primaryAppointment = entry.appointments[0]; }
			// if(!entry.desiredVehicles.isEmpty()) { entry.primaryVehicle = entry.desiredVehicles[0]; }

			List<SalesUpService.SalesUpEmployee> employee_list = new List<SalesUpService.SalesUpEmployee>();
			if(sup.Salesperson_1__c != null) {
				employee_list.add(new SalesUpService.SalesUpEmployee(referencedUsers.get(sup.Salesperson_1__c), 'Salesperson 1'));
			}

			if(sup.Salesperson_2__c != null) {
				employee_list.add(new SalesUpService.SalesUpEmployee(referencedUsers.get(sup.Salesperson_2__c), 'Salesperson 2'));
			}	

			if(sup.Desk_Manager__c != null) {
				employee_list.add(new SalesUpService.SalesUpEmployee(referencedUsers.get(sup.Desk_Manager__c), 'Desk Manager'));
			}					

			if(sup.F_I_Manager__c != null) {
				employee_list.add(new SalesUpService.SalesUpEmployee(referencedUsers.get(sup.F_I_Manager__c), 'FI Manager'));
			}	

			entry.employees = employee_list;			

			// Add to collection
			entries.add(entry);
		}

		// Get Deals with Context that do not have an associated SalesUp Record
		String dlSql = 'SELECT '+dealFields+' FROM Deal__c WHERE ((CreatedDate >=:fdate AND CreatedDate <=:tdate ) OR (dealer__Deal_Date__c >=:fdate AND dealer__Deal_Date__c <=:tdate)) AND dealer__Sales_Lead__c = NULL ORDER BY CreatedDate DESC LIMIT 100';
		for(dealer__Deal__c d : Database.query(dlSql)) {
			DeskLogEntry entry = new DeskLogEntry();
			entry.salesup = new dealer__Sales_Up__c();
			entry.primaryDeal = d;
			entries.add(entry);
		}

		System.debug(entries);

		return entries;
	}

	/**
	 * DeskLogEntry 
	 * @notes wrapper class defining a desk log entry
	 */
	public class DeskLogEntry {
		/* Primary Objects */
		public Sales_Up__c salesup {get;set;}
		public Deal__c primaryDeal {get;set;}
		public Sales_Appointment__c primaryAppointment {get;set;}
		public Vehicle_Inventory__c primaryVehicle {get;set;}
		public Vehicle_Inventory__c primaryTrade {get;set;}

		/* One to Many Object Relationships */
		public List<Deal__c> deals {get;set;}
		public List<Sales_Appointment__c> appointments {get;set;}
		public List<Desired_Vehicle__c> desiredVehicles {get;set;}
		public List<Trade_In__c> trades {get;set;}
		public List<SalesUpService.SalesUpEmployee> employees {get;set;}
		public List<Appraisal__c> appraisals {get;set;}

		/* Measurements */
	}

	/**
	 * searchContext
	 * @notes wrapper for passing the search context to the search method
	 */
	public class searchContext {
		/* Hard Filters */
		public Date fromDate {get;set;}
		public Date toDate {get;set;}
		public String rawSearch {get;set;} /*SOSL*/

		/* Soft Filters */
		public List<String> leadType {get;set;}
		public List<String> dealType {get;set;}
		public List<String> location {get;set;}
		public List<String> salesperson1 {get;set;}
		public List<String> salesperson2 {get;set;}
		public List<String> deskManager {get;set;}
		public List<String> financeManager {get;set;}
	} 
}