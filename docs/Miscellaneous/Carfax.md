---
layout: default
---
# Carfax
## Classes
### Response
#### Fields

##### `public responseJSON` → `String`

`AURAENABLED` 

##### `public authURL` → `String`

`AURAENABLED` 

##### `public error` → `error`

`AURAENABLED` 

##### `public dealerReport` → `Carfax`

`AURAENABLED` 

---

### dealerReport
#### Fields

##### `public carfaxLink` → `carfaxLink`

`AURAENABLED` 

##### `public fourPillars` → `fourPillars`

`AURAENABLED` 

##### `public recall` → `recall`

`AURAENABLED` 

##### `public snapshotKey` → `String`

`AURAENABLED` 

---

### recall
#### Fields

##### `public hasOpenRecall` → `Boolean`

`AURAENABLED` 

##### `public iconUrl` → `String`

`AURAENABLED` 

##### `public iconText` → `String`

`AURAENABLED` 

---

### fourPillars
#### Fields

##### `public accident` → `accident`

`AURAENABLED` 

##### `public owner` → `owner`

`AURAENABLED` 

##### `public useType` → `useType`

`AURAENABLED` 

##### `public serviceRecord` → `serviceRecord`

`AURAENABLED` 

##### `public carfaxLink` → `carfaxLink`

`AURAENABLED` 

---

### accident
#### Fields

##### `public iconUrl` → `String`

`AURAENABLED` 

##### `public iconText` → `String`

`AURAENABLED` 

##### `public position` → `Integer`

`AURAENABLED` 

##### `public hasAccidents` → `Boolean`

`AURAENABLED` 

---

### owner
#### Fields

##### `public iconUrl` → `String`

`AURAENABLED` 

##### `public iconText` → `String`

`AURAENABLED` 

##### `public position` → `Integer`

`AURAENABLED` 

##### `public isOneOwner` → `Boolean`

`AURAENABLED` 

---

### useType
#### Fields

##### `public iconUrl` → `String`

`AURAENABLED` 

##### `public iconText` → `String`

`AURAENABLED` 

##### `public position` → `Integer`

`AURAENABLED` 

##### `public isPersonalUse` → `Boolean`

`AURAENABLED` 

---

### serviceRecord
#### Fields

##### `public iconUrl` → `String`

`AURAENABLED` 

##### `public iconText` → `String`

`AURAENABLED` 

##### `public position` → `Integer`

`AURAENABLED` 

##### `public recordCount` → `Integer`

`AURAENABLED` 

---

### carfaxLink
#### Fields

##### `public url` → `string`

`AURAENABLED` 

---

### error
#### Fields

##### `public displayableErrorMessage` → `String`

`AURAENABLED` 

##### `public errorCode` → `String`

`AURAENABLED` 

---

### AuthState
#### Constructors
##### `public AuthState(Id userId)`
---
#### Fields

##### `public isActive` → `Boolean`

`AURAENABLED` 

##### `public AccessToken` → `String`

`AURAENABLED` 

##### `public RefreshToken` → `String`

`AURAENABLED` 

##### `public Error` → `String`

`AURAENABLED` 

##### `public user` → `User`

`AURAENABLED` 

---

### AuthStateResponse
#### Fields

##### `public isActive` → `Boolean`

`AURAENABLED` 

##### `public AccessToken` → `String`

`AURAENABLED` 

##### `public RefreshToken` → `String`

`AURAENABLED` 

---

### Request
#### Constructors
##### `public Request(Service_Vehicle__c vehicle, Id userId)`
---
#### Fields

##### `public vehicle` → `Service_Vehicle__c`


##### `public session` → `PlatformSession`


---

---
