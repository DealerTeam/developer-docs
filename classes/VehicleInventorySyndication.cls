/**
*
*	VehicleInventorySyndication - prepate uploadable inventory file for distribution
*
*/
public with sharing class VehicleInventorySyndication {

	public static String primaryPublicationEndpoint = 'https://apsv1.dealerteam.com/api/InventorySyndication';

	public VehicleInventorySyndication() {}

	/**
	*
	*	XMLFeed
	*	Prepare written XML file for Syndication
	*
	*
	*/	
	public static String XMLFeed() {

		return '';
	}

	/**
	*
	*	JSONFeed
	*	Prpare written JSON file for Syndication
	*
	*/
	public static String JSONFeed() {
		return '{ "OrgId" : "'+UserInfo.getOrganizationId()+'" , "vehicles" : '+JSON.serializePretty(VehicleInventorySyndication.vehicleList())+' } ';
	}

	/**
	*
	*	PublishFeed
	*	Post the data object to the signified endpoint
	*
	*/
	public static void publishFeed() {
		String feed = VehicleInventorySyndication.JSONFeed();
 			
 		Http h = new Http();
        HttpRequest req = new HttpRequest();
             
        req.setEndpoint(VehicleInventorySyndication.primaryPublicationEndpoint);
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setBody(feed);		

		if(!Test.isRunningTest()) {
            HTTPResponse res = h.send(req);
        }
	}

	/**
	*
	*	vehicleList
	*	Retrieve all INSTOCK vehicles from the Database
	*
	*
	*/
	public static List<dealer__Vehicle_Inventory__c> vehicleList() {

		// Vehicle Inventory
		DescribeSObjectResult describeResult = dealer__Vehicle_Inventory__c.getSObjectType().getDescribe();
		List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );

		// Vehicle Equipment
		DescribeSObjectResult describeVE = dealer__Vehicle_Equipment__c.getSObjectType().getDescribe();
		List<String> veFieldNames = new List<String>( describeVE.fields.getMap().keySet() );

		// Vehicle Media
		DescribeSObjectResult describeVI = dealer__Inventory_Images__c.getSObjectType().getDescribe();
		List<String> viFieldNames = new List<String>( describeVI.fields.getMap().keySet() );		

		String query =
		  ' SELECT ' +
		      String.join( fieldNames, ',' ) +
		      ' , (SELECT  ' +  String.join( veFieldNames, ',' ) + ' FROM Vehicle_Equipment__r ) ' +
		      ' , (SELECT ' + String.join ( viFieldNames, ',' ) + ' FROM Inventory_Images__r ) ' +
		  ' FROM ' +
		      describeResult.getName() +
		  ' Where dealer__In_Stock__c = true ' +
		  ' Order By dealer__Stock_Number__c ASC'
		;

		return Database.query( query );
	}
}