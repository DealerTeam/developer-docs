---
layout: default
---
# virtual SOQLFactory

SOQLFactory provides an abstratction layer for Database.Query [].
             The Class performs data select services for SOQL style statements.
             To best support Enterprise SOC and Framework concepts SOQLFactory
             is used to interact with obtaining data from the data residency services.


**Notes** This class was originally sourced from https://github.com/4an70m/apex-query-builder          Credit for the QueryBuilder.cls are attributed to github.com/4an70m

## Constructors
### `public SOQLFactory()`

Constructs an empty SOQLFactory instance. Requires a call to addFrom() method for selecting an sobject to build query for.


**See** [SOQLFactory.addFrom](SOQLFactory.addFrom)

### `public SOQLFactory(String fromSobject)`

Constructs a SOQLFactory instance for given SObject name in a string form. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fromSobject`||

### `public SOQLFactory(SObjectType type)`

Constructs a SOQLFactory instance for given SObject name in an SObjectType form. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.getSObjectType()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

### `public SOQLFactory(Type type)`

Constructs a SOQLFactory instance for given SObject name in an System.Type form. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

### `public SOQLFactory(SObject sobj)`

Constructs a SOQLFactory instance for given SObject name in an SObject form. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(new Account()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

---
## Fields

### `private fromSobject` → `String`


### `private fieldTokens` → `Set<String>`


### `private groupByFields` → `Set<String>`


### `private sortingOrder` → `List<Order>`


### `private scope` → `FilterScope`


### `private queryLimit` → `Integer`


### `private queryOffset` → `Integer`


### `private countResult` → `Integer`


### `private updateTracking` → `Boolean`


### `private updateViewstat` → `Boolean`


### `private forView` → `Boolean`


### `private forReference` → `Boolean`


### `private withSecurityEnforced` → `Boolean`


### `private stubbedSOQLFactory` → `StubbedSOQLFactory`


### `private conditionsManager` → `ConditionsManager`


### `private result` → `List<SObject>`


### `private checkCrud` → `Boolean`


### `private checkFls` → `Boolean`


---
## Methods
### `public SOQLFactory addFrom(String fromSobject)`

Sets the FROM statement in the query. Always overrides the constructor-selected FROM value. <br /> The name of the SObject is accepted as a string. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFrom('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fromSobject`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFrom(SObjectType type)`

Sets the FROM statement in the query. Always overrides the constructor-selected FROM value. <br /> The name of the SObject is accepted as an SObjectType. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFrom(Account.getSObjectType()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFrom(Type type)`

Sets the FROM statement in the query. Always overrides the constructor-selected FROM value. <br /> The name of the SObject is accepted as a System.Type. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFrom(Account.class); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFrom(SObject sobj)`

Sets the FROM statement in the query. Always overrides the constructor-selected FROM value. <br /> The name of the SObject is accepted as an SObject. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFrom(new Account()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addSubQuery(SOQLFactory soqlFactory)`

Constructs a sub-query for given query. The sub-query is build based on a nested SOQLFactory instance. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addSubQuery(new SOQLFactory('Contacts')); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`SOQLFactory`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addSubQuery(String subQueryString)`

Constructs a sub-query for given query. The sub-query is a plain string value. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addSubQuery('SELECT Id FROM Contacts'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`subQueryString`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addField(String fieldName)`

Adds a field or number of comma-separated fields into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addField('Id') .addField('Name, ParentId'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addField(SObjectField field)`

Adds a field in a form of SObjectField into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addField(Account.Name); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFields(SObject sobj)`

Adds a field or number of populated fields, extracted from sobject instance into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addField(new Account(Name = 'Test')); //results: SELECT Name FROM Account </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFields(String fieldNames)`

Adds a field or number of comma-separated fields into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFields('Id') .addFields('Name, ParentId'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFields(List<String> fieldNames)`

Adds a list of fields into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFields(new List&lt;String&gt; {'Name'}); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldNames`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFields(Set<String> fieldNames)`

Adds a set of fields into the query selection Set. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFields(new Set&lt;String&gt; {'Name'}); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldNames`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAll()`

Adds all fields of the sobject, specified in FROM statement. The FROM sobject must be specified before calling to this method. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFieldsAll(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAll(String sobjectName)`

Adds all fields of the sobject, specified in param as a string name. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobjectName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAll(Type type)`

Adds all fields of the sobject, specified in param as System.Type. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll(Account.class); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAll(SObjectType type)`

Adds all fields of the sobject, specified in param as an SObjectType. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll(Account.getSObjectType()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAll(SObject sobj)`

Adds all fields of the sobject, specified in param as an SObject. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll(new Account()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllCreatable()`

Adds all creatable fields of the sobject, specified in FROM statement. The FROM sobject must be specified before calling to this method. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllCreatable(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllCreatable(String sobjectName)`

Adds all creatable fields of the sobject, specified in param as a string name. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllCreatable('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobjectName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllCreatable(Type type)`

Adds all creatable fields of the sobject, specified in param as System.Type. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllCreatable(Account.class); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllCreatable(SObjectType type)`

Adds all creatable fields of the sobject, specified in param as an SObjectType. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll(Account.getSObjectType()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllCreatable(SObject sobj)`

Adds all creatable fields of the sobject, specified in param as an SObject. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAll(new Account()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllUpdatable()`

Adds all updatable fields of the sobject, specified in FROM statement. The FROM sobject must be specified before calling to this method. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllUpdatable(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllUpdatable(String sobjectName)`

Adds all updatable fields of the sobject, specified in param as string name. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllUpdatable('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobjectName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllUpdatable(Type type)`

Adds all updatable fields of the sobject, specified in param as System.Type. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllUpdatable(Account.class); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllUpdatable(SObjectType type)`

Adds all updatable fields of the sobject, specified in param as an SObjectType. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllUpdatable(Account.getSObjectType()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`type`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldsAllUpdatable(SObject sobj)`

Adds all updatable fields of the sobject, specified in param as an SObject. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addFieldsAllUpdatable(new Account()); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`sobj`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldSet(String objectName, String fieldSetName)`

Adds all fields from a FieldSet for specific object. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFieldSet('Account', 'My_Field_Set'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`objectName`||
|`fieldSetName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldSet(FieldSet fieldSet)`

Adds all fields from a specific FieldSet. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> FieldSet myFieldSet = //retrieve a field set new SOQLFactory(Account.class) .addFieldSet(myFieldSet); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldSet`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addFieldSet(String fieldSetName)`

Adds all fields from a specific FieldSet by its name. The FROM sobject must be specified before calling to this method. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addFieldSet('My_Field_Set'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldSetName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public ConditionsManager addConditions()`

Returns an instance of ConditionsManage for current SOQLFactory instance. Allows creation of conditions for a query. <p>To finish work with conditions and return to work with SOQLFactory instance it is required to call the endConditions() method of ConditionsManager</p>

#### Returns

|Type|Description|
|---|---|
|`ConditionsManager`|an instance of ConditionsManager.class|


**See** [SOQLFactory.ConditionsManager](SOQLFactory.ConditionsManager)

### `public ConditionsManager addConditionsWithOrder(String conditionOrder)`

Returns an instance of ConditionsManage for current SOQLFactory instance. Allows creation of conditions for a query. <p>As a parameter accepts a string with order of conditions execution and there relations</p> <p>To finish work with conditions and return to work with SOQLFactory instance it is required to call the endConditions() method of ConditionsManager</p> <p>Condition index is 1-based<p> <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory() .addConditionsWithOrder('1 and (2 or 3) and 4') .endConditions(); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`conditionOrder`||

#### Returns

|Type|Description|
|---|---|
|`ConditionsManager`|an instance of ConditionsManager.class|


**See** [SOQLFactory.ConditionsManager](SOQLFactory.ConditionsManager)

### `public SOQLFactory setLimit(Integer queryLimit)`

Sets a limit for current query. Accepts an integer.

#### Parameters

|Param|Description|
|---|---|
|`queryLimit`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setOffset(Integer queryOffset)`

Sets an offset for current query. Accepts an integer.

#### Parameters

|Param|Description|
|---|---|
|`queryOffset`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addOrder(Order order)`

Adds a SORT BY {Order} statement to the query. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addOrder( new SOQLFactory.Order(Account.Id) .setSortingOrderAsc() .setNullsOrderLast() ); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addOrderAsc(String fieldName)`

Adds a SORT BY {field} ASC statement to the query. Field name is specified as a string. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addOrderAsc('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addOrderAsc(SObjectField field)`

Adds a SORT BY {field} ASC statement to the query. Field is specified as an SObjectField. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addOrderAsc(Account.Name); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`field`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addOrderDesc(String fieldName)`

Adds a SORT BY {field} DESC statement to the query. Field name is specified as a string. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addOrderDesc('Account'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addOrderDesc(SObjectField field)`

Adds a SORT BY {field} DESC statement to the query. Field is specified as an SObjectField. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .addOrderDesc(Account.Name); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`field`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addGroupBy(String fields)`

Adds a field or number of comma-separated fields to the group by Set of fields. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .groupBy('Name') .groupBy('Id, ParentId'); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fields`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addGroupBy(SObjectField field)`

Adds a field in an SObjectField form to the group by Set of fields. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .groupBy(Account.Name); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`field`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addGroupBy(List<String> fields)`

Adds a list of field to the group by Set of fields. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .groupBy(new List&lt;String&gt; {'Name'}); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fields`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory addGroupBy(Set<String> fields)`

Adds a set of field to the group by Set of fields. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .groupBy(new Set&lt;String&gt; {'Name'}); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`fields`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setScope(SOQLFactory scope)`

Adds the optional USING SCOPE clause of a SOQL query returns records within a specified scope. For example, you can limit the records to return only objects that the user owns or only records in the user’s territory. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setScope(SOQLFactory.FilterScope.Mine); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`scope`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setForView(Boolean forView)`

Adds FOR VIEW clause in to the query. Allows to update LastViewedDate on retrieved objects. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setForView(true); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`forView`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setForView()`

Adds FOR VIEW clause in to the query. Allows to update LastViewedDate on retrieved objects. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setForView(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setForReference(Boolean forReference)`

Adds FOR REFERENCE clause in to the query. Allows to update LastReferencedDate on retrieved objects. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setForReference(true); </code> </pre>

#### Parameters

|Param|Description|
|---|---|
|`forReference`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setForReference()`

Adds FOR REFERENCE clause in to the query. Allows to update LastReferencedDate on retrieved objects. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setForView(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setUpdateTracking(Boolean updateTracking)`

Sets the UPDATE TRACKING optional clause on a SOQL query. UPDATE TRACKING can be added to a SELECT statement of a SOQL query to report on article searches and views to track the keywords that are used in Salesforce Knowledge article searches <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setUpdateTracking(true); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`||

### `public SOQLFactory setUpdateTracking()`

Sets the UPDATE TRACKING optional clause on a SOQL query. UPDATE TRACKING can be added to a SELECT statement of a SOQL query to report on article searches and views to track the keywords that are used in Salesforce Knowledge article searches <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setUpdateTracking(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`||

### `public SOQLFactory setUpdateViewstat(Boolean updateViewstat)`

Adds the UPDATE VIEWSTAT optional clause to the SOQL query. Allows get a view count for every article that you have access to online. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setUpdateViewstat(true); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`||

### `public SOQLFactory setUpdateViewstat()`

Adds the UPDATE VIEWSTAT optional clause to the SOQL query. Allows get a view count for every article that you have access to online. <br /><br /> <p>&lt;b&gt;Example&lt;/b&gt;</p> <pre> <code> new SOQLFactory(Account.class) .setUpdateViewstat(); </code> </pre>

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`||

### `public SOQLFactory setCheckCRUDAndFLS(Boolean checkCrudAndFls)`

Enables or disables CRUD and FLS check for current query. Default is disabled. <br /> Enabled CRUD check throws an System.NoAccessException if current user doesn't have access to an SObject. <br /> Enabled FLS check removes a field from result.

#### Parameters

|Param|Description|
|---|---|
|`checkCrudAndFls`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setWithSecurityEnforced()`

&lt;h1&gt;THIS IS BETA FUNCTIONALITY&lt;/h1&gt; Enables CRUD and FLS check for current query.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setWithSecurityEnforced(Boolean withSecurityEnforced)`

&lt;h1&gt;THIS IS BETA FUNCTIONALITY&lt;/h1&gt; Enables CRUD and FLS check for current query.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setCheckCRUDAndFLS()`

Enables CRUD and FLS check for current query. <br /> Enabled CRUD check throws an System.NoAccessException if current user doesn't have access to an SObject. <br /> Enabled FLS check removes a field from result.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setCheckCRUD(Boolean checkCrud)`

Enables or disables CRUD check for current query. <br /> Enabled CRUD check throws an System.NoAccessException if current user doesn't have access to an SObject.

#### Parameters

|Param|Description|
|---|---|
|`checkCrud`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setCheckCRUD()`

Enables CRUD check for current query. <br /> Enabled CRUD check throws an System.NoAccessException if current user doesn't have access to an SObject.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setCheckFLS(Boolean checkFls)`

Enables or disables FLS check for current query. Default is disabled. <br /> Enabled FLS check removes a field from result.

#### Parameters

|Param|Description|
|---|---|
|`checkFls`||

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory setCheckFLS()`

Enables FLS check for current query. <br /> Enabled FLS check removes a field from result.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public StubbedSOQLFactory buildStub()`

Returns an instance of StubbedSOQLFactory, which can be used in Unit Tests.

#### Returns

|Type|Description|
|---|---|
|`StubbedSOQLFactory`|a new instance of SOQLFactory.StubbedSOQLFactory.class|

### `public SOQLFactory preview()`

Builds a current state of query and outputs it to the debug console.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory previewCount()`

Builds a current state of query, replacing all the fields with COUNT(Id), exexutes it, and outputs the result to the debug console.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory newQuery()`

Nullifies and re-creates all of the fields in current SOQLFactory instance.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public SOQLFactory resetResult()`

Resets a result for current query. Otherwise, each new call to toList() method returns the same result.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|this - current instance of SOQLFactory.class|

### `public override String toString()`

Builds a query based in current params.

#### Returns

|Type|Description|
|---|---|
|`String`|string representation of query|

### `public String toStringCount()`

Builds a query, replacing all the selected fields with COUNT(Id) and returns as a string.

#### Returns

|Type|Description|
|---|---|
|`String`|string representation of query with COUNT(ID) instead of fields|

### `public Integer toCount()`

Builds a query, replacing all the selected fields with COUNT(Id), executes it and returns a number of records.

#### Returns

|Type|Description|
|---|---|
|`Integer`|number of records|

### `public List<SObject> toList()`

Executes a query or returns already executed result as a list of SObjects

#### Returns

|Type|Description|
|---|---|
|`List<SObject>`|list of SObjects|

### `public Map<Id,SObject> toMap()`

Executes a query or returns already executed result as a map of SObjects by Id

#### Returns

|Type|Description|
|---|---|
|`Map<Id,SObject>`|map of SObjects by Id|

### `public Map<Id,SObject> toMap(Map<Id,SObject> mapToFill)`

Executes a query or returns already executed result and fills the max from params.

#### Parameters

|Param|Description|
|---|---|
|`mapToFill`||

#### Returns

|Type|Description|
|---|---|
|`Map<Id,SObject>`|map of SObjects by Id|

### `public SObject toSObject()`

Returns the first SObject from the query result.

#### Returns

|Type|Description|
|---|---|
|`SObject`|first SObject from query|

### `public Set<Id> toIdSet()`

Executes a query or returns already executed result as a set of Ids.

#### Returns

|Type|Description|
|---|---|
|`Set<Id>`|set of Ids|

### `public Database toQueryLocator()`

Builds a query string and returns a QueryLocator

#### Returns

|Type|Description|
|---|---|
|`Database`|Database.QueryLocator built based on query|

### `public Set<Id> extractIds(String fieldName)`

Executes a query or returns already executed result as a set of Ids extracted from fields of resulted SObjects.

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||

#### Returns

|Type|Description|
|---|---|
|`Set<Id>`|set of Ids from query|

### `public List<Object> extractField(String fieldName)`

Executes a query or returns already executed result as a list of Objects extracted from fields of resulted SObjects.

#### Parameters

|Param|Description|
|---|---|
|`fieldName`|- String name of a field|

#### Returns

|Type|Description|
|---|---|
|`List<Object>`|list of Objects|

### `public List<Object> extractField(SObjectField field)`

Executes a query or returns already executed result as a list of Objects extracted from fields of resulted SObjects.

#### Parameters

|Param|Description|
|---|---|
|`fieldName`|- field in a form of SObjectField|

#### Returns

|Type|Description|
|---|---|
|`List<Object>`|list of Objects|

### `public SOQLFactory cloneSOQLFactory()`

Clones a query builder. Doesn't clone the result list.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|new instance of SOQLFactory, based on current state|

### `public SOQLFactory cloneSOQLFactory(Boolean includeResult)`

Clones a query builder. Can include the list of already queried records.

#### Returns

|Type|Description|
|---|---|
|`SOQLFactory`|new instance of SOQLFactory, based on current state|

---
## Enums
### FilterScope

---
## Classes
### ConditionsManager

Class, which allows building query conditions.


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public ConditionsManager(SOQLFactory soqlFactory)`
---
#### Fields

##### `private BRACKET_L` → `String`


##### `private BRACKET_R` → `String`


##### `public conditions` → `List&lt;Condition&gt;`


##### `private conditionOrder` → `String`


##### `private SOQLFactory` → `SOQLFactory`


##### `private builtCondition` → `String`


---
#### Methods
##### `public ConditionsManager cloneConditionsManager(SOQLFactory soqlFactory)`
##### `public ConditionsManager add(Condition condition)`
##### `public ConditionsManager preview()`
##### `public ConditionsManager setConditionOrder(String conditionOrder)`
##### `public SOQLFactory endConditions()`
##### `public override String toString()`
##### `private Boolean hasConditions()`
##### `private String bracketConditions(String conditions)`
##### `private String bracket(String condition)`
---

### Condition

Abstract class, which represent a condition, which can be added into ConditionsManager.


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public Condition()`
---
#### Fields

##### `public QUOTE` → `String`


##### `public BRACKET_L` → `String`


##### `public BRACKET_R` → `String`


---
#### Methods
##### `public virtual override String toString()`
##### `public virtual Boolean isEmpty()`
---

### SimpleCondition

**Inheritance**

SimpleCondition

#### Constructors
##### `public SimpleCondition()`
##### `public SimpleCondition(String condition)`
---

### FieldCondition

Abstract class, which represent a condition, which can be added into ConditionsManager.
The condition is field-dependent.


**Inheritance**

FieldCondition


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public FieldCondition(String fieldName)`
##### `public FieldCondition(SObjectField fieldName)`
---
#### Methods
##### `public override Boolean isEmpty()`
---

### NullCondition

**Inheritance**

NullCondition

#### Constructors
##### `public NullCondition(String fieldName)`
##### `public NullCondition(SObjectField fieldName)`
---
#### Methods
##### `public Condition isNull()`
##### `public Condition notNull()`
---

### CompareCondition

**Inheritance**

CompareCondition

#### Constructors
##### `public CompareCondition(String fieldName)`
##### `public CompareCondition(SObjectField fieldName)`
---
#### Methods
##### `public Condition eq(String fieldValue)`
##### `public Condition ne(String fieldValue)`
##### `public Condition eq(Boolean fieldValue)`
##### `public Condition ne(Boolean fieldValue)`
##### `public Condition eq(Decimal fieldValue)`
##### `public Condition lt(Decimal fieldValue)`
##### `public Condition gt(Decimal fieldValue)`
##### `public Condition lte(Decimal fieldValue)`
##### `public Condition lte(String fieldValue)`
##### `public Condition gte(Decimal fieldValue)`
##### `public Condition gte(String fieldValue)`
##### `public Condition ne(Decimal fieldValue)`
---

### LikeCondition

**Inheritance**

LikeCondition

#### Constructors
##### `public LikeCondition(String fieldName)`
##### `public LikeCondition(SObjectField fieldName)`
---
#### Methods
##### `public Condition likeAnyBoth(String fieldValue)`
##### `public Condition likeAnyLeft(String fieldValue)`
##### `public Condition likeAnyRight(String fieldValue)`
##### `public Condition notLikeAnyBoth(String fieldValue)`
---

### InCondition

**Inheritance**

InCondition

#### Constructors
##### `public InCondition(String fieldName)`
##### `public InCondition(SObjectField fieldName)`
---
#### Methods
##### `public Condition inCollection(SOQLFactory soqlFactory)`
##### `public Condition inCollection(List&lt;SObject&gt; inList)`
##### `public Condition inCollection(List&lt;SObject&gt; inList, String propertyName)`
##### `public Condition inCollection(Map&lt;Id,SObject&gt; inKeySet)`
##### `public Condition inCollection(Set&lt;String&gt; inSet)`
##### `public Condition inCollection(Set&lt;Id&gt; inSet)`
##### `public Condition inCollection(Set&lt;Decimal&gt; inSet)`
##### `private String buildIn(Set&lt;String&gt; inSet)`
##### `private String buildIn(Set&lt;Id&gt; inSet)`
##### `private String buildInNoQuote(Set&lt;Decimal&gt; inSet)`
##### `public Condition inCollection(List&lt;Id&gt; inList)`
##### `public Condition inCollection(List&lt;String&gt; inList)`
##### `public Condition inCollection(List&lt;Decimal&gt; inList)`
##### `public Condition inCollection(List&lt;PicklistEntry&gt; inList)`
##### `private String buildIn(List&lt;String&gt; inList)`
##### `private String buildIn(List&lt;Id&gt; inList)`
##### `private String buildInNoQuote(List&lt;Decimal&gt; inList)`
##### `public Condition notIn(List&lt;SObject&gt; inList)`
##### `public Condition notIn(List&lt;SObject&gt; inList, String propertyName)`
##### `public Condition notIn(Map&lt;Id,SObject&gt; inSet)`
##### `public Condition notIn(Set&lt;Id&gt; inSet)`
##### `public Condition notIn(Set&lt;String&gt; inSet)`
##### `public Condition notIn(List&lt;String&gt; inList)`
##### `public Condition notIn(SOQLFactory soqlFactory)`
---

### ComplexCondition

**Inheritance**

ComplexCondition

#### Constructors
##### `public ComplexCondition()`
---
#### Fields

##### `private startCondition` → `Condition`


##### `private conditionsOrder` → `List&lt;String&gt;`


##### `private conditions` → `List&lt;Condition&gt;`


---
#### Methods
##### `public ComplexCondition startCondition(Condition condition)`
##### `public ComplexCondition orCondition(Condition condition)`
##### `public ComplexCondition andCondition(Condition condition)`
##### `public ComplexCondition build()`
##### `public override Boolean isEmpty()`
##### `public override String toString()`
##### `public String addOrderIfNotEmpty(String order)`
---

### ObjectTypeDependentCondition

Abstract class, which represent a condition, which can be added into ConditionsManager.
The condition is Object-type dependent.


**Inheritance**

ObjectTypeDependentCondition


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public ObjectTypeDependentCondition()`
---
#### Fields

##### `private objectType` → `String`


---
#### Methods
##### `public void setRelatedObjectType(String objectType)`
---

### RecordTypeCondition

**Inheritance**

RecordTypeCondition

#### Constructors
##### `public RecordTypeCondition(String recordTypeName)`
---
#### Fields

##### `private recordTypeName` → `String`


---
#### Methods
##### `private Id getRecordTypeId()`
##### `public override String toString()`
---

### Order

Virtual class for creating Order in Query.


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public Order(String sortingField)`
##### `public Order(SObjectField sortingField)`
---
#### Fields

##### `private sortingField` → `String`


##### `private sortingOrder` → `String`


##### `private nullsOrder` → `String`


---
#### Methods
##### `public Order setSortingOrder(String sortingOrder)`
##### `public Order setSortingOrderAsc()`
##### `public Order setSortingOrderDesc()`
##### `public Order setNullsOrder(String nullsOrder)`
##### `public Order setNullsOrderFirst()`
##### `public Order setNullsOrderLast()`
##### `public override String toString()`
---

### AscOrder

Class for ordering records Ascending.


**Inheritance**

AscOrder


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public AscOrder(String sortingField)`
---

### DescOrder

Class for ordering records Descending.


**Inheritance**

DescOrder


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public DescOrder(String sortingField)`
---

### SOQLFactoryMockProvider

**Implemented types**

[System.StubProvider](System.StubProvider)

#### Constructors
##### `public SOQLFactoryMockProvider(StubbedSOQLFactory stubbedSOQLFactory)`
---
#### Fields

##### `private stubbedSOQLFactory` → `StubbedSOQLFactory`


---
#### Methods
##### `public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List&lt;Type&gt; listOfParamTypes, List&lt;String&gt; listOfParamNames, List&lt;Object&gt; listOfArgs)`
---

### ConditionsManagerMockProvider

**Implemented types**

[System.StubProvider](System.StubProvider)

#### Constructors
##### `public ConditionsManagerMockProvider(StubbedSOQLFactory stubbedSOQLFactory)`
---
#### Fields

##### `public stubbedSOQLFactory` → `StubbedSOQLFactory`


---
#### Methods
##### `public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List&lt;Type&gt; listOfParamTypes, List&lt;String&gt; listOfParamNames, List&lt;Object&gt; listOfArgs)`
---

### StubbedSOQLFactory

**Inheritance**

[SOQLFactory](./SOQLFactory.md)
 &gt; 
StubbedSOQLFactory

#### Constructors
##### `public StubbedSOQLFactory(SOQLFactory parent)`
---
#### Fields

##### `private parent` → `SOQLFactory`


##### `private queryString` → `String`


##### `private queryCountString` → `String`


##### `private countResult` → `Integer`


##### `private toListResult` → `List&lt;SObject&gt;`


##### `private toMapResult` → `Map&lt;Id,SObject&gt;`


##### `private toMapFillResult` → `Map&lt;Id,SObject&gt;`


##### `private toSobjectResult` → `SObject`


##### `private toSetIdResult` → `Set&lt;Id&gt;`


##### `private extractedIdsResult` → `Set&lt;Id&gt;`


##### `private extractedFieldsResult` → `List&lt;Object&gt;`


##### `private stubbedConditionsManager` → `ConditionsManager`


##### `private stubbedSOQLFactory` → `SOQLFactory`


---
#### Methods
##### `public SOQLFactory applyStub()`
##### `public StubbedSOQLFactory addStubToString(String queryString)`
##### `public StubbedSOQLFactory addStubToStringCount(String queryCountString)`
##### `public StubbedSOQLFactory addStubToCount(Integer countResult)`
##### `public StubbedSOQLFactory addStubToList(List&lt;SObject&gt; toListResult)`
##### `public StubbedSOQLFactory addStubToMap(Map&lt;Id,SObject&gt; toMapResult)`
##### `public StubbedSOQLFactory addStubToSObject(SObject toSobjectResult)`
##### `public StubbedSOQLFactory addStubToIdSet(Set&lt;Id&gt; toSetIdResult)`
##### `public StubbedSOQLFactory addStubExtractIds(Set&lt;Id&gt; extractedIdsResult)`
##### `public StubbedSOQLFactory addStubExtractField(List&lt;Object&gt; extractedFieldsResult)`
##### `private String stubToString()`
##### `private String stubToStringCount()`
##### `private Integer stubToCount()`
##### `private List&lt;SObject&gt; stubToList()`
##### `private Map&lt;Id,SObject&gt; stubToMap()`
##### `private Map&lt;Id,SObject&gt; stubToMap(Map&lt;Id,SObject&gt; mapToFill)`
##### `private SObject stubToSObject()`
##### `private Set&lt;Id&gt; stubToIdSet()`
##### `private Set&lt;Id&gt; stubExtractIds(String fieldName)`
##### `private List&lt;Object&gt; stubExtractField(String fieldName)`
---

### SObjectReadValidator

Class, which performs validation of list of SObjects.
Can check CRUD and FLS.


**Author** github.com/4an70m


**Version** 1.0

#### Constructors
##### `public SObjectReadValidator(List&lt;SObject&gt; sObjectsToValidate)`
---
#### Fields

##### `private sObjectsToValidate` → `List&lt;SObject&gt;`


##### `private sObjectType` → `SObjectType`


##### `private describedSObjectType` → `DescribeSObjectResult`


---
#### Methods
##### `public void validate()`
##### `public void checkObjectAccess()`
##### `public void checkFieldsAccess()`
##### `private void validateSobject(SObject sobj, Map&lt;String,SObjectField&gt; sobjectFields, Map&lt;String,ChildRelationship&gt; childRelationshipsByName)`
##### `private Map&lt;String,ChildRelationship&gt; getChildRelationshipsByName(DescribeSObjectResult describedSObjectType)`
---

### SOQLFactoryException

**Inheritance**

SOQLFactoryException


---
