---
layout: default
---
# abstract SevenHundredCreditInquiry



**Group** Sales

## Methods
### `private void PopulateMap(object properties, Map<String,Object> dataMap)`
---
## Classes
### InquiryBaseProperties
#### Fields

##### `private PASS` → `String`


##### `private PROCESS` → `String`


---
#### Properties

##### `public ACCOUNT` → `String`


##### `public PASSWD` → `String`


##### `public PRODUCT` → `String`


##### `public BUREAU` → `String`


##### `public MULTIBUR` → `String`


##### `public A_USER_NAME` → `String`


##### `public A_USER_ID` → `String`


##### `public APP_MODIFIED` → `String`


---

### Inquiry

**Inheritance**

[SevenHundredCreditInquiry](./SevenHundredCreditInquiry.md)
 &gt; 
Inquiry


**Implemented types**

[IInquiry](IInquiry)

#### Fields

##### `public Properties` → `InquiryBaseProperties`


##### `public PrimaryApplicant` → `SevenHundredCreditApplicant`


##### `public CoApplicant` → `SevenHundredCreditApplicant`


##### `public Vehicle` → `SevenHundredCreditVehicle`


##### `private Data` → `Map&lt;String,Object&gt;`


---
#### Methods
##### `public void Initialize()`
---

---
## Interfaces
### IInquiry
#### Methods
##### `public void Initialize()`
---

