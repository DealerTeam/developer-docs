/**
 * SalesUp Service Layer Encapsulation 
 *
 * 
 */
public class SalesUpService {

	/**
	 * getSalesUpUsers
	 * @param  userIds Set<Id>
	 * @return Map<Id, User>
	 * @notes used to aquire a Map of all USERs by ID
	 */
	public static Map<Id, User> getSalesUpUsers(Set<Id> userIds) {
		return new Map<Id, User>([SELECT Id, FirstName, LastName, Username, IsActive FROM User WHERE Id IN:userIds]);
	}

	/**
	 * SalesUpEmployee
	 */
	public class SalesUpEmployee {
		public User user {get;set;}
		public String role {get;set;}

		public SalesUpEmployee(User u, String r) {
			user=u;
			role=r;
		}
	}
}