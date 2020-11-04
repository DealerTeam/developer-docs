/**
 * Identiy API provides access to a number of external consumer databases.  
 * The purposes of these API's are to assist the end user with additional 
 * data related to the Account records he/she is working with.
 *
 * First Available in 1.601
 * https://success.dealerteam.com/Middleware/API_Guide/Caller_Identification
 * 
 */
global class IdentityApi {

	/**
	 * [callerIdentification description]
	 * @param  searchNumber [description]
	 * @return              [description]
	 */
	global static List<caller> callerIdentification(String searchNumber) {
		
		List<IdentityApi.caller> callerObject = new List<IdentityApi.caller>();

		try {
			String callerResults = IdentityAPI.performCallout('caller', searchNumber);
			callerObject = (List<IdentityApi.caller>)JSON.deserialize(callerResults, List<IdentityApi.caller>.class);

		} Catch(JSONException e) {
			System.debug(e.getMessage());
		} Catch(CalloutException e) {
			System.debug(e);
			return callerObject;
		}

		return callerObject;
	}

	/**
	 * [performCallout description]
	 * @return body
	 */
	global static String performCallout(String api, String searchParameter) {
		
		Http htClient = new Http();
		HttpRequest request = new HttpRequest();
		HttpResponse response = new HttpResponse();

		// Craft the URL
		String url = 'https://apsv1.dealerteam.com/api/whitepagespro/'+api+'?term='+EncodingUtil.urlEncode(searchParameter,'UTF-8')+'&orgId='+UserInfo.getOrganizationId();
		request.setEndpoint(url);
		request.setMethod('GET');

		// Perform callout
		response = htClient.send(request);

		System.debug(request);
		System.debug(response);

		return response.getBody();
	}

	//global class calleridentities {
	//	global List<caller> caller {get;set;}
	//}

	global class caller {
		global String line_type {get;set;}
		global boolean is_connected {get;set;}
		global boolean is_valid {get;set;}
		global boolean do_not_call {get;set;}
		global String Salutation {get;set;}
		global String FirstName {get;set;}
		global String MiddleName {get;set;}
		global String LastName {get;set;}
		global String Suffix {get;set;}
		global String PersonMailingStreet {get;set;}
		global String PersonMailingCity {get;set;}
		global String PersonMailingState {get;set;}
		global String PersonMailingPostalCode {get;set;}
		global String PersonMailingCountry {get;set;}
	}
}