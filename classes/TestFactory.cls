/*
// The TestFactory will pre-fill all the fields we typically need

// You can use the methods like a void to populate SetupData
TestFactory.createSObjectList(new Account(), 200, true);

// Or return the object
Account a = (Account)TestFactory.createSObject(new Account());
insert a;

// You can also set values to be used. Any values set in the constructor will override the defaults
Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id));

// You can also specify a specific set of overrides for different scenarios
Account a = (Account)TestFactory.createSObject(new Account(), 'TestFactoryFieldData.AccountDefaults');

// Finally, get a bunch of records for testing bulk
Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 200);
// You can optionally insert records as created like this:
// Note the final parameter of true.
Account a = (Account) TestFactory.createSObject(new Account(), true);
Contact c = (Contact) TestFactory.createSObject(new Contact(AccountID = a.Id), true);
*/

global class TestFactory{
    
	static string namespaces = 'dealer__|dtmob__|dtffa__|dtsage__';

	global static SObject createSObject(SObject sObj){
		// Check what type of object we are creating and add any defaults that are needed.
		String objectName = String.valueOf(sObj.getSObjectType());
		// Construct the default values class. Salesforce doesn't allow '__' in class names
		String defaultClassName = 'TestFactoryFieldData.' + objectName.replaceAll(namespaces + '|__c|__', '') + 'Defaults';
		// If there is a class that exists for the default values, then use them
		system.debug(defaultClassName);
		
		if (Type.forName(defaultClassName) != null) 
			sObj = createSObject(sObj, defaultClassName);

		return sObj;
	}

	global static SObject createSObject(SObject sObj, Boolean doInsert){
        
		SObject retObject = createSObject(sObj);
		System.debug(retObject);
		if (doInsert) 
			insert retObject;

		return retObject;
	}

	global static SObject createSObject(SObject sObj, String defaultClassName) {
        
		// Create an instance of the defaults class so we can get the Map of field defaults
		Type t = Type.forName(defaultClassName);
		
		if (t == null) 
			Throw new TestFactoryException('Invalid defaults class.');

		TestInterfaces.IFieldDefaults defaults = (TestInterfaces.IFieldDefaults)t.newInstance();
		addFieldDefaults(sObj, defaults.getFieldDefaults());

		return sObj;
	}


	global static SObject createSObject(SObject sObj, String defaultClassName, Boolean doInsert) {
		SObject retObject = createSObject(sObj, defaultClassName);

		if (doInsert) 
			insert retObject;

		return retObject;
	}

	global static SObject[] createSObjectList(Sobject sObj, Integer numberOfObjects) {
		return createSObjectList(sObj, numberOfObjects, (String)null);
	}

	global static SObject[] createSObjectList(SObject sObj, Integer numberOfObjects, Boolean doInsert) {
		SObject[] retList = createSObjectList(sObj, numberOfObjects, (String)null);

		if (doInsert) 
			insert retList;

		return retList;
	}

	global static SObject[] createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName, Boolean doInsert) {
		SObject[] retList = createSObjectList(sObj, numberOfObjects, defaultClassName);

		if (doInsert) 
			insert retList;

		return retList;
	}

	global static SObject[] createSObjectList(Sobject sObj, Integer numberOfObjects, String defaultClassName) {
		SObject[] sObjs = new SObject[] {};
		SObject newObj;

		// Get one copy of the object
		if (defaultClassName == null) 
			newObj = createSObject(sObj);
		else 
			newObj = createSObject(sObj, defaultClassName);

		// Get the name field for the object
		String nameField = TestFactoryFieldData.nameFieldMap.get(String.valueOf(sObj.getSObjectType()));

		if (nameField == null) 
			nameField = 'Name';

		// Clone the object the number of times requested. Increment the name field so each record is unique
		for (Integer i = 0; i < numberOfObjects; i++) 
		{
			SObject clonedSObj = newObj.clone(false, true);
			clonedSObj.put(nameField, (String)clonedSObj.get(nameField) + ' ' + i);
			sObjs.add(clonedSObj);
		}

		return sObjs;
	}

	private static void addFieldDefaults(SObject sObj, Map<String, Object> defaults){
        
		// Loop through the map of fields and if they are null on the object, fill them.
		for (String field : defaults.keySet()){
			if (sObj.get(field) == null) 
				sObj.put(field, defaults.get(field));
		}
	}

	public class TestFactoryException extends Exception {}
}