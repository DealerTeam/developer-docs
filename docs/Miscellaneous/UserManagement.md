---
layout: default
---
# UserManagement
## Methods
### `public static User checkExistingUser(String username)`
### `public static User createUserWithPermSet(User u, String profileName, String permSetName)`

Check for existing username and return or create provided user record and assign permission set if one is provided

#### Parameters

|Param|Description|
|---|---|
|`u`|User to insert|
|`profileName`|Profile name will be queried and assigned to the user|
|`permSetName`|Permission set name will be queried and assigned to the user|

#### Returns

|Type|Description|
|---|---|
|`User`|Inserted user record|


**Note** This methid is not actively in use.  It is here for reference.

### `private static void assignPermSet(String permSetName, Id userId)`

`FUTURE`

Assign perm set in a future context to prevent mixed dml exception

#### Parameters

|Param|Description|
|---|---|
|`permSetName`|permSetName description|
|`userId`|userId description|

---
