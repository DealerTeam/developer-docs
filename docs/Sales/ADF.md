---
layout: default
---
# ADF



**Group** Sales

## Methods
### `public static ADFHeader createFromSUP(Sales_Up__c s)`
---
## Classes
### vehicle
#### Constructors
##### `public vehicle()`
---
#### Properties

##### `public interest` → `String`


##### `public status` → `String`


##### `public vehId` → `adfId`


##### `public year` → `String`


##### `public make` → `String`


##### `public model` → `String`


##### `public vin` → `String`


##### `public stock` → `String`


##### `public trim` → `String`


##### `public doors` → `String`


##### `public bodystyle` → `String`


##### `public transmission` → `String`


##### `public odometer` → `String`


##### `public odometerStatus` → `String`


##### `public odometerUnits` → `String`


##### `public condition` → `String`


##### `public colors` → `List&lt;colorCombination&gt;`


##### `public imageUrl` → `String`


##### `public imageW` → `String`


##### `public imageH` → `String`


##### `public imageAltText` → `String`


##### `public vPrice` → `price`


##### `public priceComments` → `String`


##### `public options` → `List&lt;option&gt;`


##### `public financeMethod` → `String`


##### `public financeAmounts` → `List&lt;financeAmount&gt;`


##### `public balances` → `List&lt;balance&gt;`


##### `public comments` → `String`


---

### customer
#### Constructors
##### `public customer()`
---
#### Properties

##### `public con` → `adfContact`


##### `public customerId` → `adfId`


##### `public timeDescription` → `String`


##### `public earliestDate` → `String`


##### `public latestDate` → `String`


##### `public comments` → `String`


##### `public primary` → `String`


---

### vendor
#### Properties

##### `public vendorId` → `adfId`


##### `public name` → `String`


##### `public url` → `String`


##### `public con` → `adfContact`


---

### provider
#### Properties

##### `public providerId` → `adfId`


##### `public providerName` → `adfContact`


##### `public service` → `String`


##### `public url` → `String`


##### `public contact` → `adfContact`


---

### adfContact
#### Constructors
##### `public adfContact()`
---
#### Properties

##### `public primary` → `String`


##### `public firstName` → `String`


##### `public lastName` → `String`


##### `public fullName` → `String`


##### `public type` → `String`


##### `public phones` → `List&lt;phone&gt;`


##### `public address` → `address`


##### `public email` → `email`


---

### address
#### Constructors
##### `public address()`
---
#### Properties

##### `public street1` → `String`


##### `public street2` → `String`


##### `public apt` → `String`


##### `public city` → `String`


##### `public regionCode` → `String`


##### `public postalCode` → `String`


##### `public country` → `String`


---

### email
#### Constructors
##### `public email()`
---
#### Properties

##### `public emailAddress` → `String`


##### `public preferred` → `String`


---

### phone
#### Properties

##### `public type` → `String`


##### `public timeToCall` → `String`


##### `public preferred` → `String`


##### `public phoneNumber` → `String`


---

### adfId
#### Constructors
##### `public adfId()`
---
#### Properties

##### `public sequence` → `Integer`


##### `public source` → `String`


##### `public id` → `String`


---

### colorCombination
#### Properties

##### `public interiorColor` → `String`


##### `public exteriorColor` → `String`


##### `public preference` → `Integer`


---

### price
#### Constructors
##### `public price()`
---
#### Properties

##### `public type` → `String`


##### `public currencyCode` → `String`


##### `public delta` → `String`


##### `public relativeTo` → `String`


##### `public source` → `String`


##### `public value` → `String`


---

### option
#### Properties

##### `public name` → `String`


##### `public manufacturerCode` → `String`


##### `public stockNum` → `String`


##### `public weighting` → `Integer`


##### `public oPrice` → `price`


---

### financeAmount
#### Constructors
##### `public financeAmount()`
---
#### Properties

##### `public type` → `String`


##### `public amountLimit` → `String`


##### `public currencyCode` → `String`


##### `public value` → `String`


---

### balance
#### Properties

##### `public type` → `String`


##### `public currencyCode` → `String`


##### `public value` → `Decimal`


---

### ADFHeader
#### Constructors
##### `public ADFHeader()`
---
#### Properties

##### `public vehicles` → `List&lt;vehicle&gt;`


##### `public customers` → `List&lt;customer&gt;`


##### `public vendor` → `vendor`


##### `public leadProvider` → `provider`


##### `public toEmail` → `String`


##### `public fromEmail` → `String`


---

---
