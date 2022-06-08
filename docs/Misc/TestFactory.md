# TestFactory

`APIVERSION: 45`

`STATUS: ACTIVE`

// The TestFactory will pre-fill all the fields we typically need

// You can use the methods like a void to populate SetupData TestFactory.createSObjectList(new Account(), 200, true);

// Or return the object Account a = (Account)TestFactory.createSObject(new Account()); insert a;

// You can also set values to be used. Any values set in the constructor will override the defaults Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id));

// You can also specify a specific set of overrides for different scenarios Account a = (Account)TestFactory.createSObject(new Account(), &apos;TestFactoryFieldData.AccountDefaults&apos;);

// Finally, get a bunch of records for testing bulk Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 200); // You can optionally insert records as created like this: // Note the final parameter of true. Account a = (Account) TestFactory.createSObject(new Account(), true); Contact c = (Contact) TestFactory.createSObject(new Contact(AccountID = a.Id), true);
  @group Test

## Methods
### `static createSObject(SObject sObj)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObject(SObject sObj, Boolean doInsert)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObject(SObject sObj, String defaultClassName)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObject(SObject sObj, String defaultClassName, Boolean doInsert)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObjectList(Sobject sObj, Integer numberOfObjects)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObjectList(SObject sObj, Integer numberOfObjects, Boolean doInsert)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObjectList(SObject sObj, Integer numberOfObjects, String defaultClassName, Boolean doInsert)`
#### Parameters
|Param|Description|
|---|---|

### `static createSObjectList(Sobject sObj, Integer numberOfObjects, String defaultClassName)`
#### Parameters
|Param|Description|
|---|---|

---