---
layout: default
---
# ADF class
---
## Methods
### `createFromSUP(Sales_Up__c s)` → `ADFHeader`
---
## Inner Classes

### ADF.ADFHeader class
---
#### Constructors
##### `ADFHeader()`
---
#### Properties

##### `customers` → `List<customer>`

##### `fromEmail` → `String`

##### `leadProvider` → `provider`

##### `toEmail` → `String`

##### `vehicles` → `List<vehicle>`

##### `vendor` → `public`

---
### ADF.address class
---
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
### ADF.adfContact class
---
#### Constructors
##### `adfContact()`
---
#### Properties

##### `address` → `public`

##### `email` → `public`

##### `firstName` → `String`

##### `fullName` → `String`

##### `lastName` → `String`

##### `phones` → `List<phone>`

##### `primary` → `String`

##### `type` → `String`

---
### ADF.adfId class
---
#### Properties

##### `id` → `String`

##### `sequence` → `Integer`

##### `source` → `String`

---
### ADF.balance class
---
#### Properties

##### `currencyCode` → `String`

##### `type` → `String`

##### `value` → `Decimal`

---
### ADF.colorCombination class
---
#### Properties

##### `exteriorColor` → `String`

##### `interiorColor` → `String`

##### `preference` → `Integer`

---
### ADF.customer class
---
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
### ADF.email class
---
#### Constructors
##### `email()`
---
#### Properties

##### `emailAddress` → `String`

##### `preferred` → `String`

---
### ADF.financeAmount class
---
#### Constructors
##### `financeAmount()`
---
#### Properties

##### `amountLimit` → `String`

##### `currencyCode` → `String`

##### `type` → `String`

##### `value` → `String`

---
### ADF.option class
---
#### Properties

##### `manufacturerCode` → `String`

##### `name` → `String`

##### `oPrice` → `price`

##### `stockNum` → `String`

##### `weighting` → `Integer`

---
### ADF.phone class
---
#### Properties

##### `phoneNumber` → `String`

##### `preferred` → `String`

##### `timeToCall` → `String`

##### `type` → `String`

---
### ADF.price class
---
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
### ADF.provider class
---
#### Properties

##### `contact` → `adfContact`

##### `providerId` → `adfId`

##### `providerName` → `adfContact`

##### `service` → `String`

##### `url` → `String`

---
### ADF.vehicle class
---
#### Constructors
##### `vehicle()`
---
#### Properties

##### `balances` → `List<balance>`

##### `bodystyle` → `String`

##### `colors` → `List<colorCombination>`

##### `comments` → `String`

##### `condition` → `String`

##### `doors` → `String`

##### `financeAmounts` → `List<financeAmount>`

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

##### `options` → `List<option>`

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
### ADF.vendor class
---
#### Properties

##### `con` → `adfContact`

##### `name` → `String`

##### `url` → `String`

##### `vendorId` → `adfId`

---
