# ADF

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static createFromSUP(Sales_Up__c s)`
---
## Classes
### ADFHeader
#### Constructors
##### `ADFHeader()`
---
#### Properties

##### `customers` → `List&lt;customer&gt;`


##### `fromEmail` → `String`


##### `leadProvider` → `provider`


##### `toEmail` → `String`


##### `vehicles` → `List&lt;vehicle&gt;`


##### `vendor` → `vendor`


---

### address
#### Constructors
##### `address()`
---
#### Properties

##### `apt` → `String`


##### `city` → `String`


##### `country` → `String`


##### `postalCode` → `String`


##### `regionCode` → `String`


##### `street1` → `String`


##### `street2` → `String`


---

### adfContact
#### Constructors
##### `adfContact()`
---
#### Properties

##### `address` → `address`


##### `email` → `email`


##### `firstName` → `String`


##### `fullName` → `String`


##### `lastName` → `String`


##### `phones` → `List&lt;phone&gt;`


##### `primary` → `String`


##### `type` → `String`


---

### adfId
#### Constructors
##### `adfId()`
---
#### Properties

##### `id` → `String`


##### `sequence` → `Integer`


##### `source` → `String`


---

### balance
#### Properties

##### `currencyCode` → `String`


##### `type` → `String`


##### `value` → `Decimal`


---

### colorCombination
#### Properties

##### `exteriorColor` → `String`


##### `interiorColor` → `String`


##### `preference` → `Integer`


---

### customer
#### Constructors
##### `customer()`
---
#### Properties

##### `comments` → `String`


##### `con` → `adfContact`


##### `customerId` → `adfId`


##### `earliestDate` → `String`


##### `latestDate` → `String`


##### `primary` → `String`


##### `timeDescription` → `String`


---

### email
#### Constructors
##### `email()`
---
#### Properties

##### `emailAddress` → `String`


##### `preferred` → `String`


---

### financeAmount
#### Constructors
##### `financeAmount()`
---
#### Properties

##### `amountLimit` → `String`


##### `currencyCode` → `String`


##### `type` → `String`


##### `value` → `String`


---

### option
#### Properties

##### `manufacturerCode` → `String`


##### `name` → `String`


##### `oPrice` → `price`


##### `stockNum` → `String`


##### `weighting` → `Integer`


---

### phone
#### Properties

##### `phoneNumber` → `String`


##### `preferred` → `String`


##### `timeToCall` → `String`


##### `type` → `String`


---

### price
#### Constructors
##### `price()`
---
#### Properties

##### `currencyCode` → `String`


##### `delta` → `String`


##### `relativeTo` → `String`


##### `source` → `String`


##### `type` → `String`


##### `value` → `String`


---

### provider
#### Properties

##### `contact` → `adfContact`


##### `providerId` → `adfId`


##### `providerName` → `adfContact`


##### `service` → `String`


##### `url` → `String`


---

### vehicle
#### Constructors
##### `vehicle()`
---
#### Properties

##### `balances` → `List&lt;balance&gt;`


##### `bodystyle` → `String`


##### `colors` → `List&lt;colorCombination&gt;`


##### `comments` → `String`


##### `condition` → `String`


##### `doors` → `String`


##### `financeAmounts` → `List&lt;financeAmount&gt;`


##### `financeMethod` → `String`


##### `imageAltText` → `String`


##### `imageH` → `String`


##### `imageUrl` → `String`


##### `imageW` → `String`


##### `interest` → `String`


##### `make` → `String`


##### `model` → `String`


##### `odometer` → `String`


##### `odometerStatus` → `String`


##### `odometerUnits` → `String`


##### `options` → `List&lt;option&gt;`


##### `priceComments` → `String`


##### `status` → `String`


##### `stock` → `String`


##### `transmission` → `String`


##### `trim` → `String`


##### `vPrice` → `price`


##### `vehId` → `adfId`


##### `vin` → `String`


##### `year` → `String`


---

### vendor
#### Properties

##### `con` → `adfContact`


##### `name` → `String`


##### `url` → `String`


##### `vendorId` → `adfId`


---

---
