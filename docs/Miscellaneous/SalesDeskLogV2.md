---
layout: default
---
# SalesDeskLogV2
## Constructors
### `public SalesDeskLogV2()`
---
## Fields

### `public trafficType` → `String`


### `public runningUser` → `User`


### `public dealKeys` → `List<Id>`


### `public salesUpKeys` → `List<Id>`


### `public s1List` → `Map<Id,String>`


### `public s2List` → `Map<Id,String>`


### `public manager` → `Map<Id,String>`


### `public finance` → `Map<Id,String>`


### `public companies` → `Map<String,String>`


### `public deskEntries` → `List<deskLogEntry>`


### `public upBoard` → `List<salesRotation>`


### `public CategoriesList` → `list<SelectOption>`


### `public dlType` → `List<String>`


### `public dlStatus` → `List<String>`


### `public systemLogEntry` → `String`


---
## Properties

### `public soldCount` → `Integer`


### `public feGross` → `Integer`


### `public beGross` → `Integer`


### `public totalGross` → `Integer`


### `public soldMTD` → `Integer`


### `public feMTD` → `Integer`


### `public beMTD` → `Integer`


### `public tgMTD` → `Integer`


### `public walkinCount` → `Integer`


### `public phoneCount` → `Integer`


### `public emailCount` → `Integer`


### `public faxCount` → `Integer`


### `public listCount` → `Integer`


### `public referralCount` → `Integer`


### `public otherCount` → `Integer`


### `public walkInUps` → `Boolean`


### `public phoneUps` → `Boolean`


### `public emailUps` → `Boolean`


### `public faxUps` → `Boolean`


### `public otherUps` → `Boolean`


### `public listUps` → `Boolean`


### `public referralUps` → `Boolean`


### `public setToTrue` → `Boolean`


### `public setToFalse` → `Boolean`


### `public ds` → `DateTime`


### `public de` → `DateTime`


### `public rundate` → `Date`


### `public selectedDivision` → `String`


### `public userFilterSOQL` → `String`


### `public userDealFilterSOQL` → `String`


### `public trafficFilterSOQL` → `String`


### `public filterUserID` → `String`


### `public filterUserType` → `String`


### `public filterInStore` → `String`


### `public userLocation` → `Dealer_Location__c`


### `public datePickerSup` → `Event`


### `public dms` → `dealer__DMS_Settings__c`


### `public crm` → `dealer__CRMSettings__c`


### `public config` → `dealer__SalesDeskLogSettings__c`


### `public loggedInSalesAssociates` → `List<User>`


### `public enableCreateDeal` → `boolean`


### `public salespersonResetId` → `String`


---
## Methods
### `public List<selectOption> getCategories()`
### `public void loadDealType()`
### `public void loadDealStatus()`
### `public void loadUserLists()`
### `public string deskLogJSON()`
### `public string getDeskLogJSON()`
### `public void logSettings()`
### `public List<SelectOption> getTrafficTypes()`
### `public String getUserSettingsJSON()`
### `public String getTrafficType()`
### `public void setTrafficType(String trafficType)`
### `public void setCompanyNumber()`
### `public Map<String,String> getCompanies()`
### `public Map<Id,String> getS1List()`
### `public Map<Id,String> getS2List()`
### `public Map<Id,String> getManager()`
### `public Map<Id,String> getFinance()`
### `public PageReference generateDeskLog()`
### `public void updateUserSettings()`
### `public void generateLog()`
### `public List<deskLogEntry> getdeskEntries()`
### `public List<salesRotation> getUpBoard()`
### `public PageReference dropActiveSalesperson()`
### `public void itemKeys()`
### `public Map<Id,dealer__Deal__c> carDeals()`
### `public List<dealer__Sales_Up__c> salesUps()`
### `public void setSearchDates()`
### `public void sumOfSales()`
### `public void userFilter()`
### `public void trafficFilter()`
### `public void rotationLogGenerate()`
### `public static boolean updateUserSettingsRemote(String us)`

`REMOTEACTION`
### `public static boolean updateInStore(String sid)`

`REMOTEACTION`
### `public static boolean updateSalesStep(String idstep)`

`REMOTEACTION`
### `public static boolean setAppointmentStatus(String sidStat)`

`REMOTEACTION`
### `public static boolean setTeamMemberDeal(String rIDtIDtKey)`

`REMOTEACTION`
### `public static boolean setTeamMemberSalesUp(String rIDtIDtKey)`

`REMOTEACTION`
---
## Classes
### deskLogEntry
#### Constructors
##### `public deskLogEntry(dealer__Sales_Up__c up, dealer__Deal__c deals, String css, String t)`
---
#### Properties

##### `public salesUp` → `dealer__Sales_Up__c`


##### `public deal` → `dealer__Deal__c`


##### `public cssClass` → `String`


##### `public entryType` → `String`


---

### salesRotation
#### Constructors
##### `public salesRotation(User u, dealer__Sales_Up__c up)`
---
#### Properties

##### `public salesperson` → `User`


##### `public salesup` → `dealer__Sales_Up__c`


---

---
