---
layout: default
---
# SevenHundredCreditApplicationHandler



**Group** Sales

## Fields

### `private fields` → `List<String>`


### `private soql` → `String`


### `private locationServiceMap` → `Map<Id,DealerLocationServices__c>`


---
## Properties

### `private currentUser` → `User`


---
## Methods
### `public static InquiryResult CreateInquiry(Set<Id> ids, String product, List<string> bureaus)`
### `private static void PopulatePrimaryApplicant(SevenHundredCreditApplicant applicant, Credit_Application__c app)`
### `private static void PopulateCoApplicant(SevenHundredCreditApplicant applicant, Credit_Application__c app)`
### `private static void PopulateProperties(SevenHundredCreditInquiry props, Credit_Application__c app, String product, List<string> bureaus)`
### `private static String FormatDate(Date d)`
---
## Classes
### InquiryResult
#### Fields

##### `public success` → `boolean`

`AURAENABLED` 

##### `public messages` → `List&lt;string&gt;`

`AURAENABLED` 

---

---
