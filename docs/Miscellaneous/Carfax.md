# Carfax

`APIVERSION: 51`

`STATUS: ACTIVE`
## Classes
### AuthState
#### Constructors
##### `AuthState(Id userId)`
---
#### Fields

##### `AccessToken` → `String`

`AURAENABLED` 

##### `Error` → `String`

`AURAENABLED` 

##### `RefreshToken` → `String`

`AURAENABLED` 

##### `isActive` → `Boolean`

`AURAENABLED` 

##### `user` → `User`

`AURAENABLED` 

---

### AuthStateResponse
#### Fields

##### `AccessToken` → `String`

`AURAENABLED` 

##### `RefreshToken` → `String`

`AURAENABLED` 

##### `isActive` → `Boolean`

`AURAENABLED` 

---

### Request
#### Constructors
##### `Request(Service_Vehicle__c vehicle, Id userId)`
---
#### Fields

##### `session` → `PlatformSession`


##### `vehicle` → `Service_Vehicle__c`


---

### Response
#### Fields

##### `authURL` → `String`

`AURAENABLED` 

##### `dealerReport` → `Carfax.dealerReport`

`AURAENABLED` 

##### `error` → `error`

`AURAENABLED` 

##### `responseJSON` → `String`

`AURAENABLED` 

---

### accident
#### Fields

##### `hasAccidents` → `Boolean`

`AURAENABLED` 

##### `iconText` → `String`

`AURAENABLED` 

##### `iconUrl` → `String`

`AURAENABLED` 

##### `position` → `Integer`

`AURAENABLED` 

---

### carfaxLink
#### Fields

##### `url` → `string`

`AURAENABLED` 

---

### dealerReport
#### Fields

##### `carfaxLink` → `carfaxLink`

`AURAENABLED` 

##### `fourPillars` → `fourPillars`

`AURAENABLED` 

##### `recall` → `recall`

`AURAENABLED` 

##### `snapshotKey` → `String`

`AURAENABLED` 

---

### error
#### Fields

##### `displayableErrorMessage` → `String`

`AURAENABLED` 

##### `errorCode` → `String`

`AURAENABLED` 

---

### fourPillars
#### Fields

##### `accident` → `accident`

`AURAENABLED` 

##### `carfaxLink` → `carfaxLink`

`AURAENABLED` 

##### `owner` → `owner`

`AURAENABLED` 

##### `serviceRecord` → `serviceRecord`

`AURAENABLED` 

##### `useType` → `useType`

`AURAENABLED` 

---

### owner
#### Fields

##### `iconText` → `String`

`AURAENABLED` 

##### `iconUrl` → `String`

`AURAENABLED` 

##### `isOneOwner` → `Boolean`

`AURAENABLED` 

##### `position` → `Integer`

`AURAENABLED` 

---

### recall
#### Fields

##### `hasOpenRecall` → `Boolean`

`AURAENABLED` 

##### `iconText` → `String`

`AURAENABLED` 

##### `iconUrl` → `String`

`AURAENABLED` 

---

### serviceRecord
#### Fields

##### `iconText` → `String`

`AURAENABLED` 

##### `iconUrl` → `String`

`AURAENABLED` 

##### `position` → `Integer`

`AURAENABLED` 

##### `recordCount` → `Integer`

`AURAENABLED` 

---

### useType
#### Fields

##### `iconText` → `String`

`AURAENABLED` 

##### `iconUrl` → `String`

`AURAENABLED` 

##### `isPersonalUse` → `Boolean`

`AURAENABLED` 

##### `position` → `Integer`

`AURAENABLED` 

---

---
